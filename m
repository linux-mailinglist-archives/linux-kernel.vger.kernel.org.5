Return-Path: <linux-kernel+bounces-115691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC89889719
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA21C30015
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287FF35ADDB;
	Mon, 25 Mar 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqgbUfly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4251EC4B1;
	Sun, 24 Mar 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321635; cv=none; b=CCFGIBjGNDcfH5XDoNcn/0O1v90XuU79owbw3pue12Jqy93YTc5nDXsOvRvgYiYClg5osMhoEACh1clbiknjKKQGnGDYausRGEz8QblTE/TmFVVYk61h0/yTOpMrpb6nINeRqAyG3YeDUDRwwyU+DBAxOmGKbS29QTqG0xXRbbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321635; c=relaxed/simple;
	bh=5hAiO/oE23Dfr/v/1rIlZy338PxP8Tq6DlQNvV4pUs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2TA+SKF/lX6R56DcvpQwkLBVamRq7In3/LNrLbCR8//X8LowYZG+t4217scdgNgUmiTgbAoMRybjpXaIaSoQ7fuwnLF9MeTErnUMU498QkRKIUvrINylP1EkZAUXAaLaZFvM1rRIp6sjxFckxD+3pIP/vWLq+kC4+vnTG6wrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqgbUfly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061A8C43399;
	Sun, 24 Mar 2024 23:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321634;
	bh=5hAiO/oE23Dfr/v/1rIlZy338PxP8Tq6DlQNvV4pUs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqgbUflyE7e55moqs7N23qXDb+3LDeDVJHiFq6W9VeaHc47BBepqnB5z+cJMfWei3
	 EeOgsO1ZjcwTcd7DudRi67BEJmaSv32R+N+MAjdcU/pbY5LJnVf9/kaaGkUGALpsf8
	 mOg6h2Cc19+NYynFtBmHG+0n67552jZ/P49ItTcy7AEuPaItCUUOZ2ZIEuMttVxz2S
	 CHSkqtPJuoDymo/neNQph4dTKEtVMhnHtnKYyAv6r8gt4/Yhk87tR9PTUuYiyAeF+N
	 sE9yLlYx+pqFyqab9tytW0JpY5DhPkJRM7ZCMIX52MeO2zsTTCN/WHTjV3eVCV5J6N
	 dEaPFi7SOXpuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yang Jihong <yangjihong1@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 365/638] perf record: Fix possible incorrect free in record__switch_output()
Date: Sun, 24 Mar 2024 18:56:42 -0400
Message-ID: <20240324230116.1348576-366-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 34bb31f08bb52..cd1725643ef77 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1786,8 +1786,8 @@ static int
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


