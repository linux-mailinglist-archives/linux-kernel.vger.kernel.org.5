Return-Path: <linux-kernel+bounces-116273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E2889DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9EB829DAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082763C957A;
	Mon, 25 Mar 2024 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCnewe/v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCF18183F;
	Sun, 24 Mar 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324099; cv=none; b=jYxF8Regc5cz6VNYQTyjriTrs4NSUj8D4Vr7EXQb//YQdTDJVhETAuR1Wb0ChSnKTJbqwzrEcOIZR0uA3Om5l9SbRD/K8hKhStXeC4enfNSdryVBVZMUu+hQz/3DBwsUzf9JmCmqJetXzsPuARb7pUEEW2HqHEcVhKAV7bazto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324099; c=relaxed/simple;
	bh=erTOiUpc+GJ+cEYmFzYUyNrdLp5zH1m8Gi2IAi7tp90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H61HEEfpQ90JkwothMrPCRTJkYzMnbwc/rv7Sm8wlGP2+TCZpBvgzlcNo6v1xqi8WQk0S4W4WoSBHM6lRZvsjfhU9wNtWLj3Mrsq+yC8w4YJgomEQBjDqzXxASUM/s4D1hs4VHRFI5VhmMiF75oNf0HlNyPxNL8cJ8oIQ0sfQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCnewe/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D209C433F1;
	Sun, 24 Mar 2024 23:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324098;
	bh=erTOiUpc+GJ+cEYmFzYUyNrdLp5zH1m8Gi2IAi7tp90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCnewe/vvtQ1xHI3enAkZ6QoC79y0NxA7eBrKfS9uMx25CoDacINufExtDoEI8v5T
	 SN5t5+aOkyZtnI1yK+xrsGQhHzKn9AjrqkCFT+6ViOZyqjbcX12GxQACmMlRnznih5
	 uttJse1l/Kiqzgq8svut3y/3gWMMX9Z6QSn4Kp/upDYjwrfI3+Pac5sdd2Zg8avFJU
	 9dplubA1Fq/eqC5qo5f8g93MDSRcz5xB40i5VuIrkX7SqeangDadtvfAgDBW7Z3mcu
	 u118SRY4ne6yg7lfl1mFVsIH01fgG1Bns/m2C+Rev9QY7axWDTnhKGoky/dE5HvpOg
	 rjzFMnMm0xaLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/183] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 19:45:10 -0400
Message-ID: <20240324234638.1355609-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index a9891c9fe94d5..9c03f67398cb2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1110,8 +1110,8 @@ static int
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


