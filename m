Return-Path: <linux-kernel+bounces-78547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836678614D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8272863F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0382866;
	Fri, 23 Feb 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWctQYAu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21566FB9;
	Fri, 23 Feb 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700014; cv=none; b=E/P47v0BGlr3jISCSOFmmsLrXvfKfWpsCifNxR3Obvi7I/c3zBayRBUuS2Qtn9uWStKJQ2F/vOMFPkCzmyy4W+j6Xhgy0/tbiXzthPyOZ5nNYtFKx8Pe7RhJDXrJ7JsLWh80OtN9N+H9Exw+FqX8L0hXfD1sRrLv86QMaMEyHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700014; c=relaxed/simple;
	bh=jNZB8Ha/81ZEkS+EVythIX6YkFlIT32/7Z17lY22gls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u50zcvlQElsminScWPXSUcbWLkHrXMiFbjAbyJLqAPDDQRPBspdqdColx5IvnW6MZFqICkVzDe5m5GXnR9g8Yv8pdACGw0ETHZIbQRUjgSW7g3iBGbWoeNly3tEPvc8Lj04ANXW4skV2u6IdyDDoZp7W9II7CaZOhjQSEF4bzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWctQYAu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41291355cb4so6286945e9.1;
        Fri, 23 Feb 2024 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700011; x=1709304811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/a+7Lbr7oxAEnMW9lRS2BPIWRChV9WXDE8CQg9Hrfk=;
        b=hWctQYAuJqeTzcWCXlafVUlifzCelNeQDT/fWFMIRKPNsWThg8Jzu51zTgtFzw0qLd
         J2FjPDmF8RmS5U4ZG7xrP5FghlYome8YvZSaVUpa4wwVPdRqbbcCT1y+0EHz/kuPqCdW
         iv57iN0aRZJC/YcZvyWCOfX0efKFn++PCzJFz8kJI+YYF+AnFbsQA+xMnuY06Vs6YrSz
         UFPVgGdq3Wmecj5AnRV0T0hG3u8ZEm2rlZMnDMKS7KdujROOhwqCjrirfgkguEtiNXC9
         VBE14vNgiEmP/Kyms15GzJhf4uaPfSAkTg48CpKwq+7C5M9HbLOrcRT94vTmy/Hj9WS3
         7nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700011; x=1709304811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/a+7Lbr7oxAEnMW9lRS2BPIWRChV9WXDE8CQg9Hrfk=;
        b=IR2QcmzciwASeBPsVMM1aEaCho8rtDZdJ18cgQU9g6ndm+Xf/bnSpw+fF02E2s3UjI
         82TmAEp4RkhcC19CEixv9H7W//Jla6plfBFDuDKO0u6L6eZ824MDIMIcpn3VWGiyNsxt
         TC6PTavH07/riCV+ws0IOfo4U75PZdRV6HNuWk8hhwVw2Kk3iCt+YnWnEnGicMOaXFNr
         Dg0Lrp8MDqJAKRalk1CTm8xcJTSqUy25sHYyTE1SYDv5cC5+sLOaVp7HgnvQ9gTNodEF
         thwRmcbY48C20GyqaWPp8Qr72Uw4ZVVPsfpMPmGn4xv4YNslmqld28wuYEVKVXsBDTK0
         svHw==
X-Forwarded-Encrypted: i=1; AJvYcCVMdT9pmLuLgEf0vt1lIDLL4Yptm50vSkfrZ08CkaDkYtKtAGLPGs0tzNe3BbVx4ds1KyRqVxyXzKv7wbkauqNN9fTDgOiF+97nHHzL
X-Gm-Message-State: AOJu0YwPzX2IFRinhkw+aGPdd2tsr00V7TbCcxthdk9wTZPwCdIeNea7
	dZ2XHszpljT+M7+QlQgg2vWcB20ZHoZypBfeK67RnIOfydC3DKRc
X-Google-Smtp-Source: AGHT+IF35jagaTTZ5yDNpFhVTYaG+pRkNtNOoRROuGdHT169YIqL9YMhI6h0l9YJGvPC1RWOYJUXyw==
X-Received: by 2002:a05:600c:1389:b0:412:952d:3c6a with SMTP id u9-20020a05600c138900b00412952d3c6amr44821wmf.13.1708700009287;
        Fri, 23 Feb 2024 06:53:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040fdf5e6d40sm2686953wmo.20.2024.02.23.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 06:53:28 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Roy Pledge <Roy.Pledge@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] soc: fsl: dpio: remove redundant assignment to pointer p
Date: Fri, 23 Feb 2024 14:53:27 +0000
Message-Id: <20240223145327.3909835-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are two places where pointer p is being assigned a value that
is never read, the pointer is re-assingned later. The assignments
are redundant and can be removed.

Cleans up two clang scan build warnings:
drivers/soc/fsl/dpio/qbman-portal.c:662:3: warning: Value stored to 'p'
is never read [deadcode.DeadStores]
drivers/soc/fsl/dpio/qbman-portal.c:820:3: warning: Value stored to 'p'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/soc/fsl/dpio/qbman-portal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index 0a3fb6c115f4..03cc374f11d7 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -659,7 +659,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
 
 	if (!s->eqcr.available) {
 		eqcr_ci = s->eqcr.ci;
-		p = s->addr_cena + QBMAN_CENA_SWP_EQCR_CI;
 		s->eqcr.ci = qbman_read_register(s, QBMAN_CINH_SWP_EQCR_CI);
 		s->eqcr.ci &= full_mask;
 
@@ -817,7 +816,6 @@ int qbman_swp_enqueue_multiple_desc_direct(struct qbman_swp *s,
 	full_mask = s->eqcr.pi_ci_mask;
 	if (!s->eqcr.available) {
 		eqcr_ci = s->eqcr.ci;
-		p = s->addr_cena + QBMAN_CENA_SWP_EQCR_CI;
 		s->eqcr.ci = qbman_read_register(s, QBMAN_CINH_SWP_EQCR_CI);
 		s->eqcr.available = qm_cyc_diff(s->eqcr.pi_ring_size,
 					eqcr_ci, s->eqcr.ci);
-- 
2.39.2


