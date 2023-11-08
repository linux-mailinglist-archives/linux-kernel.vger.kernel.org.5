Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F887E5D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjKHS0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:26:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663DB1FF5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:26:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so4826734f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699467999; x=1700072799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1kERn6BqrTYSq/wcLvk2u9/EuVMFvU8+Uv0uPnlNwM=;
        b=JzvHVeCU/0vLUfD36ItqZFEDy5oh1COhRxdaB04wXclirhgrRJnsuAICd7c9pOpt68
         7VfCnabICLDm74jZ2DlsVfTKjGiMiW5G8emONcYcdJUJrjr27AGVYs3cmQseJY6GSAKG
         kY3h66Xpeaq7PjR/+cdoiDchr1cYBAFk1ElEniDxHoeobQzOTPvq2PFVL5kZ7cXROeyF
         0a4wdsXa2slL2028IZ2BDdrtsRbYNnBp/8rJ5rgVcL9hubAdRCgkWbtF9v1ITgEkHDpT
         V+IxUKvg2wbEoB/4vLIA+aeob88sduaYmemMhdZYiQIkLZwKD1Qcp3uZHYNy9rXViG+1
         6uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467999; x=1700072799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1kERn6BqrTYSq/wcLvk2u9/EuVMFvU8+Uv0uPnlNwM=;
        b=T3qNbC8FSEcgqQrD+2nJQKgFpotwzVfkhJoC86klWnB23ggffrWxCYr7UmG6cztKFk
         sfmY8X0MuLLwAqxF1SoGw2NNmCUi2F6dju5AmicPbYlRPmX8SaeMxmLvC5Y9cnHq0My0
         oGmL6GVgrUbcGe8MRH4M48ij3ZiaKf4A+J4C0v55Ceqe46BjdBH5BD3pWgFNQ7Cb9PQH
         u5Hr5dxBiLUlFL1JxFI+gOIotKUVF7NtS52IFNE2nzDxcApsd9XgHxB0y/Cq1nAjsdQW
         tMUoC1kijptdd7IvXJ1paGD/DLIojTmJGx+OrMpUdP/NuhfhxfIeP9qQZ1q2ToOPiFOt
         qp0Q==
X-Gm-Message-State: AOJu0YzVHp5+uecxMO8UvvDGGvEGCuMgsItL19KfLr/dAUPaktijPS+B
        +bVDyTQnBnZdn451VWCVs9z3Zzn+VkE=
X-Google-Smtp-Source: AGHT+IHgXWrzbdDq4xZ1jianfBnc7JjgrzvZzvkwkFcw3xZB1748V+kWLOAfOqeV34xJCJ56Am7bTg==
X-Received: by 2002:a5d:6d8a:0:b0:32f:9511:9795 with SMTP id l10-20020a5d6d8a000000b0032f95119795mr2190812wrs.11.1699467998439;
        Wed, 08 Nov 2023 10:26:38 -0800 (PST)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id v5-20020adfa1c5000000b0032d81837433sm5542596wrv.30.2023.11.08.10.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:26:37 -0800 (PST)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     chrome-platform@lists.linux.dev,
        Patrick Georgi <pgeorgi@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Samuel Holland <samuel@sholland.org>, coreboot@coreboot.org,
        Brian Norris <briannorris@chromium.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] firmware: coreboot: framebuffer: Avoid invalid zero physical address
Date:   Wed,  8 Nov 2023 21:25:13 +0300
Message-ID: <20231108182625.46563-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM64 systems coreboot defers framebuffer allocation to its payload,
to be done by a libpayload function call. In this case, coreboot tables
still include a framebuffer entry with display format details, but the
physical address field is set to zero (as in [1], for example).

Unfortunately, this field is not automatically updated when the
framebuffer is initialized through libpayload, citing that doing so
would invalidate checksums over the entire coreboot table [2].

This can be observed on ARM64 Chromebooks with stock firmware. On a
Google Kevin (RK3399), trying to use coreboot framebuffer driver as
built-in to the kernel results in a benign error. But on Google Hana
(MT8173) and Google Cozmo (MT8183) it causes a hang.

When the framebuffer physical address field in the coreboot table is
zero, we have no idea where coreboot initialized a framebuffer, or even
if it did. Instead of trying to set up a framebuffer located at zero,
return ENODEV to indicate that there isn't one.

[1] https://review.coreboot.org/c/coreboot/+/17109
[2] https://review.coreboot.org/c/coreboot/+/8797

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
(I was previously told on #coreboot IRC that I could add coreboot
mailing list to CC for kernel patches related to coreboot.)

 drivers/firmware/google/framebuffer-coreboot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index c323a818805c..5c84bbebfef8 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -36,6 +36,9 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		.format = NULL,
 	};
 
+	if (!fb->physical_address)
+		return -ENODEV;
+
 	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
 		if (fb->bits_per_pixel     == formats[i].bits_per_pixel &&
 		    fb->red_mask_pos       == formats[i].red.offset &&

base-commit: 2220f68f4504aa1ccce0fac721ccdb301e9da32f
-- 
2.42.0

