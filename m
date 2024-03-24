Return-Path: <linux-kernel+bounces-115459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFD889BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F51C33DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305C21C185;
	Mon, 25 Mar 2024 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWaIO8JO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C211DB06C;
	Sun, 24 Mar 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320847; cv=none; b=Mv9lXporJVSVbqlSR/1yD+NmLUnwACDDINfefCriOLk3vx8AyNKqWwvuLXOD2amASWVNa2MovCrBrBZoyziVowKJEH19y73gDv00prPJXMWtMYqIfum65/H3B3cxBiHX0hKoLC9Dv3FbYZpwhLY8uRGeILEb8RRiyV1/eYnkiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320847; c=relaxed/simple;
	bh=100Q3DQFY0vQZd0kuvkMZF3fR4O/64ANoavsC0h6OFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnr1lOT8PwJmsg9NvleGYcFgV4z5wU8kLCeMl7O91YZbCfHPw8+ZW03OQwaLbdC3ZDaqxPTqT7CFICGqiz2K1okMuFdsLHZVieF03Fuaez1T3FXNWst3jw6dSOzjF/bOaYMWiAlON1vJbnjUw2fBf5b2XHAwwmafOAgkFw1q0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWaIO8JO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1E4C433F1;
	Sun, 24 Mar 2024 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320845;
	bh=100Q3DQFY0vQZd0kuvkMZF3fR4O/64ANoavsC0h6OFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWaIO8JObm2jzaWhwPy2Wrr3gtiBuklEekncNvqOq+wLEUTpEjJzN5MSVpPIRrT6I
	 ClH8T6xzSlpJx/aqJlqyi1a95BlccdlphlE0zF26JRUfy1hXtPuG3wTv4XYfEsuusM
	 Uva9hv3XP7BWWCmafkyDw5F10I8kvhy7F1rboDKMqG4zr6Xr/GOGMWMS29Z1jbggCx
	 QnsJFQMqdn9CNMOLqPJPv7hkfzZ5GOHXgIi9Q6WqXC3mxOI5OmAnq294yU0QizQQRB
	 X0I+ZxVJUHV1KPmCzUyEzy2UhvEeHXoso/XRvpUE+ylGaimIYzXBZgO0dXDstB+EAV
	 XxKuq5UwmSvmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 411/713] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 18:42:17 -0400
Message-ID: <20240324224720.1345309-412-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index dcf288a4fb9a9..fa13479ed73d6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1818,8 +1818,8 @@ static int
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


