Return-Path: <linux-kernel+bounces-113085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05951888158
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36EA285C25
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F2150980;
	Sun, 24 Mar 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncNvJONy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B914E2CB;
	Sun, 24 Mar 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319893; cv=none; b=iVC3nD5ZPxjIxRBxZcZ0mShpSH1fka0Iohji+/ZZatUz3sLvYi2Ft4W7x/QCg3q/CsUOEHc7oKl+wKB5kJaF2Iy5K19fNWPqobYdWGE50olhRbX6G0lvbTsXnsR9QwdHTNL6JHIuOTWdQge7jpLUJq6UjZsvvWYDhzW7eam6ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319893; c=relaxed/simple;
	bh=XTfxCywVWqK8pg6d8yIzBn4qNjzARm/lWyecsJM7WN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRroTQC1kZd1ZsQCBusinUgqyl8a9qDwukUA+43e9VIo+qUXtapZe6TSmKHs0E/5Hz7T496EZ51BWTvdJLpAW+Xlx/+KK4WhCQ3csga9Bq8YNbnh64TdGffPa8fjLEzvZVD6uvtgU3MtKNvzz6pwwBHl5kf4J5tQVPYHifGeHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncNvJONy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A945DC433F1;
	Sun, 24 Mar 2024 22:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319893;
	bh=XTfxCywVWqK8pg6d8yIzBn4qNjzARm/lWyecsJM7WN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncNvJONyaP6kt2ROV4iOu1+JJLgeB0n0EnZB3etS8QTS5bE9AmSuNtsY9fDriIvht
	 61JSNojzt81Zd+dB/mJGJ2H9eQFknRoZDZuhBhGu3uswNGyBWVYUdPmMaK7TU7MdMW
	 TCVzVMo9AlbJKZsegHpf1IVTSFfPUZdXwE7HikSh1c/GHYwtlAbo4ptGYo00ugJdRT
	 Sj23j6Ajx/S765tGNNH/JHckZK3Pweb0lgcTX9Lp7qNld/iALARc62yuyP8dMuiEst
	 ncx4jfQqlM2SD38Qk6Pd9qw97BLbj+atO9uGm4ijEuR9tIDOo4Vm/+zPD9EZePgzuy
	 B+4LuuFO4cNLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 198/715] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Sun, 24 Mar 2024 18:26:17 -0400
Message-ID: <20240324223455.1342824-199-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 4ca88eaebf06a..cbef0dea1d5d7 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
-- 
2.43.0


