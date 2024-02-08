Return-Path: <linux-kernel+bounces-58248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234484E376
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE42B2242B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C27A713;
	Thu,  8 Feb 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYWDF5v3"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47067A01
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403835; cv=none; b=bTYJIh9E4NIx3TcuOhtYwk+uZknHZZ7FPR0J0q0WvrRvZGWXVkhIvhsI2mRJY3C53lxLeStCJbTuJF+SEKmZjS9Yqu+03j+1feBkrEvM/nhrpIOEO8Oludj78tsdctjw6uQPrtNP/EDhbhLAx/3II45dtU2qUuB5usrLVavgPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403835; c=relaxed/simple;
	bh=x/YVZfjdNfpe+Sx6imXL9gORrTESWB+MUbneEnPObG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IbEzlLEfy7YK7ZQ6EDSfJi6rfJufccLcngUX8tp1x5sqsFPd407L7uXRHPkX+pEgo+HaTWlgLaRKqaq5vekeEEXTGWcH0tfyNBvAlazWP++xeWMm/T1OuQvpAemejRqYTCCrLhVuu7ByYBym/vwPZuZIUSE/v1MDUXozfA3MIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYWDF5v3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5101cd91017so2224087e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707403832; x=1708008632; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isFytFDXARzCh2Jm6b6WyMr5DRIgqurmR16IdjoLmWw=;
        b=ZYWDF5v3IdJ4ij+F4pMxK0TSEOjpIiARZHLwGjv0UOkGRm2sVFoLtN7OckQhP89Apm
         djuYs8i91Rdx1ZWyfhYYh/jiMiKeam9z7XFW4qS6Z9kqoGa2dw+7yfoI3MudEkhU37iR
         623Jyvb/ftq5TA1vFiIWrccOAycNwhQVH/5dPxNuhINaC5J7YlyoWHriApCicXc+na4I
         GH0WF5UTujG++lDWG6yiyFproZnRIlloT7Lbn2E6QU3qrrRY+qK/d/BJgRw9QhdfMOem
         w386qHcW3mT6LHblB2baJE3tm3orYeNL//TH004tbaa9+xsfQ9IvaUwQo7q5Sb6ASexH
         E33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403832; x=1708008632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isFytFDXARzCh2Jm6b6WyMr5DRIgqurmR16IdjoLmWw=;
        b=A1r7JfjgGGJQ9dg7KjQ2zj+GzTxTMuv7vS7ZrmRW/ZdRV7dX0NfdKoXBHO7eyKAgqj
         GXeaZBn4W9BnewiOyxWZEwzK6DO5BjidBk/kTpfSNqtTGYgYDJ7D39TI/1GUlDdLP3jO
         YrBVS/YBQvlFDif/TF757xJn9BKiSKyV1glhUaW2bV5kdgM/CuJ7ymb/24NC4NmjQRFT
         ejb6WYLEjuWPg9X634b5eVkLVMRtgbCeMbfGM8IUkqYOHGTkBJQi7vlDFtf8ymi7elEC
         1qTHwtlt/A3O/A4FMqIsuw7NQwfHnn+w1s6Xf09tWgU4R2bWxmFMJNn/gvEmC2OCs9BH
         UcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnYyi/ouSA7+p6Kn1sPdObSw3oTps6DOTB3TwmzOdBekKJlE9jOcWkqj43jStBwQyOp6Da+NQ9ebDi0TNY/G1c2GbPA3QBOUDqgaCj
X-Gm-Message-State: AOJu0YwvRivxOX3TI/8IV7eq2ZlW7cPn4cdenzIbjbBq86zXuEHQAQ9J
	LeCNOkXrbxKwTES0icgaEgWjrYaUt1TXthi60wiQdBaQeHAxXhQBzGd4TIFBQu4=
X-Google-Smtp-Source: AGHT+IE5P6J4KgAgsuL0CsQE8iHKVUyxpqlXKbhBUrR1OdOwxJGpw7JPp6luC1UX32OF+2q+jVtXsA==
X-Received: by 2002:ac2:5e9d:0:b0:511:60eb:cb1e with SMTP id b29-20020ac25e9d000000b0051160ebcb1emr5468828lfq.67.1707403831789;
        Thu, 08 Feb 2024 06:50:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU889DrDkoP2EL0AQ5Awe3MnvmaThnO6wNUDDSKLLdLcLXSO01+Opd6tk6yqykwTUZs9JGEyU9uLk6UkHKOH3b6QJMwN+eQWdxsfBkRUnh1E7ecjhQ6zhekL6kCkzBwfbDz+aOhfJ2wUw5BYx5M1SZzZWorGD6WDIf+g8KNLbxTGwiu8zO73rN4Y9/KEZlmoOKxEDXttleer9tkLti7m/sGiFhoaqEor+PbZHE7HuW3X/IPGh8obaRVHPDc3ihESzcXKOzc5xyPPMW/M6qQ4BsrzRQrxaXuKUoRGg13o4RdX+kTIb7U2DkxEyV8QD4aj27rFA1dE+1uSGppFVUy
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l4-20020ac25544000000b005114808a6a3sm18706lfk.168.2024.02.08.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:50:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 08 Feb 2024 16:50:27 +0200
Subject: [PATCH v2] drm/msm/dpu: make "vblank timeout" more useful
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fd-dpu-debug-timeout-v2-1-9f907f1bdd87@linaro.org>
X-B4-Tracking: v=1; b=H4sIADLqxGUC/4WNQQ6CMBBFr0Jm7Zi2NgVccQ/DAugAkyglLW00h
 LtbuYDL95L//g6BPFOAe7GDp8SB3ZJBXQoY5m6ZCNlmBiWUFlIYHC3aNaKlPk648Ytc3JBqWY6
 iHyphbpCnq6eR32f20WaeOWzOf86XJH/2TzBJlGhsXRpVVdpo2Tx56by7Oj9BexzHFzdfS0C5A
 AAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=x/YVZfjdNfpe+Sx6imXL9gORrTESWB+MUbneEnPObG4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxOo3cq2IouUVB8De6f00vICVYzCDbalGwerEn
 5b+e6Wey8WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcTqNwAKCRCLPIo+Aiko
 1SpYB/9ulG3MmOsHSUbXR9H9Tq2M8lBcWigpdCj0CDDaOuXMQFDJk/Jjvu2xo9k6lT86PcKhf5x
 QEE4Z8EAZai7fDQ0ugBk83nfi5loCR30Val4odndfGz3nF6dQFK1RoYcIIhMXHHR7yo6g/8NA1q
 +R8lwDkp5TAT7KWWPk3siq/WbCgeOuYbUn+YdLgf6O5zFbBzvVFwYU+AdpZtu3YfqOl5da0g1wu
 VTO8PJx280w5XFuTwyuZ74g3JKENeY7y7h3p7bIlldy69AhFLbJZnn61Ll/TMf1ar2ZqWVcDRqU
 /CO85qi5PON2G/OoE5B5VxPqFK3vu5VgH20Ybw3esisaS8dy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We have several reports of vblank timeout messages. However after some
debugging it was found that there might be different causes to that.
To allow us to identify the DPU block that gets stuck, include the
actual CTL_FLUSH value into the timeout message and trigger the devcore
snapshot capture.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Added a call to msm_disp_snapshot_state() to trigger devcore dump
  (Abhinav)
- Link to v1: https://lore.kernel.org/r/20240106-fd-dpu-debug-timeout-v1-1-6d9762884641@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index d0f56c5c4cce..a8d6165b3c0a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -489,7 +489,8 @@ static int dpu_encoder_phys_vid_wait_for_commit_done(
 		(hw_ctl->ops.get_flush_register(hw_ctl) == 0),
 		msecs_to_jiffies(50));
 	if (ret <= 0) {
-		DPU_ERROR("vblank timeout\n");
+		DPU_ERROR("vblank timeout: %x\n", hw_ctl->ops.get_flush_register(hw_ctl));
+		msm_disp_snapshot_state(phys_enc->parent->dev);
 		return -ETIMEDOUT;
 	}
 

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20240106-fd-dpu-debug-timeout-e917f0bc8063

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


