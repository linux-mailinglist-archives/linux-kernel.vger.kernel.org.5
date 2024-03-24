Return-Path: <linux-kernel+bounces-113704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE2E888621
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F7E1C256FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3E1E61FD;
	Sun, 24 Mar 2024 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZuCcwUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32311DB405;
	Sun, 24 Mar 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320691; cv=none; b=RrpmZWc6YtoxWXcdvTqZljVV12njTEOqun+UwCO9TUrDVNrEfn6HExb/WZ6ZvST59Y6pr0/ykpR1OzvtvA1O4uVpjS+b8RM5OgzGASHlLRZqnM/1AHZ+53LVEwA8JlhghbNWQfzg8gsiAte/LTFbp/qApfvOEpel6BC2qrhf2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320691; c=relaxed/simple;
	bh=Zx9oHE9XflvjybKHTXCi5dRQLTOXPeicehCdr9wDNqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEn281eFERMoqqi+9z51WzYmnGL45DodcNXtKCbGJqyeIAWgwSTQtFLEIAnu20ZHxSNMQudwLcpC/TGZVObZFugw569FGE4Ed04tvcH7oN6rLyQE3IZWf4eYhKaBqt112jj/VmvX/yE6UzOSbyN0p87I3UoGWSs06qc7d9W+BNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZuCcwUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B209C43394;
	Sun, 24 Mar 2024 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320689;
	bh=Zx9oHE9XflvjybKHTXCi5dRQLTOXPeicehCdr9wDNqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZuCcwUm4oVE57e1eBtFxcMuMTW7/hcK9RmPOZLtJ4h8ySCHlsCNIrSDOnYL2YhMl
	 +T+Vvfq910/hgR1lHew2HPKm2wUDT7JemaM8nHDsWjVpcVzb/8fIcPanuORwmPcCtJ
	 QyNHwuEM9DL4MOUcuChOMFRz9sQdINL/dHkilrus/PR7z4nzKdC5kU81qQMTZqfiva
	 EeHs33YxVMGE1WDPpWdiwoyai2R5iXTi/xBIxaGZ+QCF0nuaFZ67Qt7Srt4hTMwNf4
	 FM7UHDnhgmyLLEeX/onMKPS2pCDba0jBfq2uQKKfBLX7b6EYzvuCX6VlhHr457xrko
	 IEoXeAXK3lOLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 252/713] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Sun, 24 Mar 2024 18:39:38 -0400
Message-ID: <20240324224720.1345309-253-sashal@kernel.org>
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

From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>

[ Upstream commit ceeaddc19a90039861564d8e1078b778a8f95101 ]

Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
introduced a new 4.1 if statement in llcc_update_act_ctrl() without
considering that ret might be overwritten. So, add return value check
after Broadcast_OR register read in llcc_update_act_ctrl().

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/r/20240212183515.433873-1-quic_uchalich@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/llcc-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 57d47dcf11b92..1b7e921d45a11 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -766,6 +766,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
-- 
2.43.0


