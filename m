Return-Path: <linux-kernel+bounces-79598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABC86249C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37261F22F14
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689463C087;
	Sat, 24 Feb 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRs1z+or"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824829431
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774987; cv=none; b=aJ19f/3v1FMxdsxeu4oWH+xwHf90Fj6uqzuFwLU/WXbCr5qjET6kAPkTdmHzyxj+mgFmuetbeN3oEAgtKatcvFaOrZEicQ7CTxZmqtonpd+sy2num1uQmuzDcDlG6Gg1IDZNvjnR9eMZt6qM6Hlx+MpWLumSlabE282DwwayLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774987; c=relaxed/simple;
	bh=NFQlnvucAzkke+g0av8LzJ99HYuGDB8fN/rNXLvRupI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2BFxRGAuHRx5UnoCMmfLy7rHQKR5RV+7qM9Ws29DRXtcxRNPMOqUJbThcZbBLfW5yaR/ojrqGhrF52Cqc2/ppLm3e1aX6XM0xulJcaZW59SRG9+0cVyQFfYvHOPzuD0rNM2lsmm22rnIzmFvQmr0FrnEzj4veEg8eE8mzm1JGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRs1z+or; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso20613481fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774984; x=1709379784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRXNlWlEkUXxYgpQny+lK/Acr8Ynqo1isiIpftw7+Mw=;
        b=SRs1z+orH1kJmEz3suS6xzEQfVfo+ZXiEhQNjkYxjE3N3QxpdQa3GHoCY9FH3iQH+H
         OIlkTKTWBqM5ZohLuXJesVRIWBd4RafV0tCKqyuldRmlY3+yvzjdOwakQcmw/IDIsEgc
         4ddpv2prMmbCJegAA7pDda50+DoOgT2y6RqVnosMa8ez/GvyYIS93lXzNxAoO0IysNAt
         5ek/XCeGsGDrYiPNOb/xxiq3AgSHfRpOY3aeHdIw9bU8p+QW5YTMaZ9yEal1A9iEpY/L
         bOUxD3FltQPPdtGN/o0XucX7Ue4pnx9CDJ4VzzkjFwmGk2U01I6rWUSHxapmGvGZVeuO
         3/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774984; x=1709379784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRXNlWlEkUXxYgpQny+lK/Acr8Ynqo1isiIpftw7+Mw=;
        b=kS8zr2O22elJRYnuQ/JM2l+uyjbA7eENdoPCBg2R6ydHl9IICEmV/t44Bn3wh34o0V
         XvIcQtZslr1JMg+ejaQKad5kPW9WhPKGKkr0a9C9fVEF2TH4axfFeqbLppKUja3DMAx8
         GVga2sfi5o/qVa6F928pMV88WP9WXqyhOxCJ1pnvY/KY5k2vfkioOKLYUct7ueNOO/gO
         obg9A+scYgEeL5AfW2qmkBitIrG0Q/IBI1FjPKRu+DqygHwoVQ/qg1K17XsTqesqHb0o
         mPiXncaaEbXPtzCmErp8+/3M8WeAwHV4MRwOKYiBjBtg7iZ7D4uKrohXLeKLTBlLbe5H
         tpSQ==
X-Gm-Message-State: AOJu0YxSxnbA/V1ADs+z4V1s7NfQn3MCdxl0Cfe993XRk9ykZV0Pknpn
	Melb97lYzoG/WP8zGFi26yZJ1UjJcdwv0uHJuPce75Uef8DZ41pKxrHSODsHioQ=
X-Google-Smtp-Source: AGHT+IHYSijVV7fsHI1C4KlxWF5pLVo5PnX6H5bx2Qz0MXRCtydRPmdJsqWp3TXr7DjclKtU77ebFw==
X-Received: by 2002:a05:6512:2820:b0:512:ed2a:7938 with SMTP id cf32-20020a056512282000b00512ed2a7938mr1460342lfb.14.1708774983778;
        Sat, 24 Feb 2024 03:43:03 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id r27-20020a170906351b00b00a41a314f052sm508149eja.192.2024.02.24.03.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:43:03 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] misc: fastrpc: Pass proper arguments to scm call
Date: Sat, 24 Feb 2024 11:42:47 +0000
Message-Id: <20240224114247.85953-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114247.85953-1-srinivas.kandagatla@linaro.org>
References: <20240224114247.85953-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2764; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=WU4YZ7m9sxgUITCURG7mdFpIsa2Mc/vrm9UjEmZsl0A=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dY3vxz9eY9VHspknfoGLRDn2U95UssYiI+9t BofQkb3tM+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWNwAKCRB6of1ZxzRV N2yUB/9YStJ1HS7ejogBDPD2nGNDiVdOrgXmPpqgVLzUsqOUtWORfiXHwI5+Y7f5lw6BneGkczz nZUZQWTuAVIOeOZOrOpVNor3IjrBpJFFPqKf3EdOuQwkn7Z9qaMaiUTaP7mawRJzqMdmphJJZfe fhIqRrb/B/8rplBwjpG4OTrBODN9RvpKVNfBGU+5h+EFY6QbHthPQFtISEzvIZH7VZRETo2x3TN mmFuCCkA5h+kfXda68F0NnGOSOTxetlcm17uirUV6VfZaHC47ILyTexein11Gln5i/l+ljAg2Lp BGMYvvsSp1GGaldSv4YPSyL86xpmE803SvAt+AEejJszZe2L
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

For CMA memory allocation, ownership is assigned to DSP to make it
accessible by the PD running on the DSP. With current implementation
HLOS VM is stored in the channel structure during rpmsg_probe and
this VM is passed to qcom_scm call as the source VM.

The qcom_scm call will overwrite the passed source VM with the next
VM which would cause a problem in case the scm call is again needed.
Adding a local copy of source VM whereever scm call is made to avoid
this problem.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c6c62a7f7f5..c13efa7727e0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -263,7 +263,6 @@ struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
 	int vmcount;
-	u64 perms;
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
@@ -1279,9 +1278,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 							(u64)fl->cctx->remote_heap->size,
-							&fl->cctx->perms,
+							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
@@ -1915,8 +1916,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
-			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
+			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
@@ -2290,7 +2293,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	if (vmcount) {
 		data->vmcount = vmcount;
-		data->perms = BIT(QCOM_SCM_VMID_HLOS);
 		for (i = 0; i < data->vmcount; i++) {
 			data->vmperms[i].vmid = vmids[i];
 			data->vmperms[i].perm = QCOM_SCM_PERM_RWX;
-- 
2.25.1


