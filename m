Return-Path: <linux-kernel+bounces-114545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3D88904D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3A8291738
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E9184126;
	Sun, 24 Mar 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7shPU8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA522C648;
	Sun, 24 Mar 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322177; cv=none; b=NgOODzsuD7wFpHkxRjYEMl0QicW8MI0jDBP0mDC5rE1B/LwLh1nspmOZ5BzvMwy6x0Xd2fRCw+lHlm+D4J5LbwgILYcBAlKkAa54//WB3YugXyZszhP7h0FQo7yD/LV09pe0qrKMkZ6reFqdCWMiZVTLDGEmkHuwL3j1UKub84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322177; c=relaxed/simple;
	bh=K6TNKTonEOFkC3asOO/O52ESH/pj8vkuf7job0eqG5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P000Rmp6kt3RKDrfgETW4Q+pxsTvoGRxNfCdzwACncB79UcJOq7/bV8whB4vwFLgeSnA3lNH4LCIF1pKidbkvhCS0lnkyaXczWks+8W/GYPvyf+xV2KihhkPwJCosMdY7MS4yK8FC0/VzwJ0Y/AcM3S2rpnLW2dI9NTRbLC9T8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7shPU8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C87C43390;
	Sun, 24 Mar 2024 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322176;
	bh=K6TNKTonEOFkC3asOO/O52ESH/pj8vkuf7job0eqG5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7shPU8jdp6nGuZkNuYOwxXPBNEmPlgePf7Uf+zbRefoyQTx+DMaJFAj2M8WXBZm8
	 RnVxnU0NvOf9jlqbDWvHYMuMEi+0/A+BogvpB6upAr/qFOvn6w78gYQ49Xfvd52muv
	 AbBfHvQCP8nHd68z/k/YtI2fJ0IpNIH+7hGKLGZJv28driQfPKnoUODeVAZbJ9nIYZ
	 QqDIj03jlSVNVamWtWhdD2VemMUbb/EmLAF4WdqrX/WDJTjYfrQ4IShVJMEG8iNnwe
	 iSfl/9tWLdzVmyddT2BSkR+kURxrLWPQ6b9AvtBRft+A6jj9Bdfd4RuAf1T8OcQn9O
	 o6PWC/Gh/lMYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 255/451] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 19:08:51 -0400
Message-ID: <20240324231207.1351418-256-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit aff10a165201f6f60cff225083ce301ad3f5d8f1 ]

perf_data__switch() may not assign a legal value to 'new_filename'.
In this case, 'new_filename' uses the on-stack value, which may cause a
incorrect free and unexpected result.

Fixes: 03724b2e9c45 ("perf record: Allow to limit number of reported perf.data files")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240119040304.3708522-2-yangjihong1@huawei.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7314183cdcb6c..b9b0fda8374e2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1785,8 +1785,8 @@ static int
 record__switch_output(struct record *rec, bool at_exit)
 {
 	struct perf_data *data = &rec->data;
+	char *new_filename = NULL;
 	int fd, err;
-	char *new_filename;
 
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
-- 
2.43.0


