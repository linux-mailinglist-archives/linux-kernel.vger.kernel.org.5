Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8317DFAA3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377383AbjKBTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjKBTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA6D49
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698951807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m+72lU2is0RjPg3Ej03EzBiDP42Tb65So4vdSCepZ9s=;
        b=Ch61Hwf+63FZ0uv71dadk5okntx1YM1TBwO1p0oOHQB7NsJq+ar+tLHmrpi/volKR6Bxvo
        3ko+gNCZSrdwvyd7wpC3uVpF3hO2V1G+MxjFKvfDBo5a7bWOeaCEYNfB+1EEOVph/28Jmr
        5MwWFrFD8zEPDR/9M0gCq8arLFZPLBI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-9hev12-tPWWLUP4VRjnSZg-1; Thu, 02 Nov 2023 15:03:24 -0400
X-MC-Unique: 9hev12-tPWWLUP4VRjnSZg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083a0fb583so1464155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951802; x=1699556602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+72lU2is0RjPg3Ej03EzBiDP42Tb65So4vdSCepZ9s=;
        b=grMiJ3mPofeUocBirSY8sQFXlU4+1zd9EPIOWpCUWrGYNuq4yie0nYB2yhx/t6Q5vI
         AdekKWiueU9JOwbZoCqXs36mTL17GJ3pnOf0VTIk8NwjCA2fmWje4wkWCgSac4q8XsKJ
         JuyVtinz9kks8KsMS91xUF/1r2mnmBS5aLuXVikH4o6Z5LED+y014jXrchp6Uagcb66I
         Iy5U0FQbZoL60H8PnIOQB9pVch/NdhJwp1DM31YrYwZhAyDnObycVZuPamgZ1+WNB7At
         UNb3Y+zt5pVZpkURwA2iLxsOWtO0Yy1WzCNtbrgCXkWi8FQri1L0Rw+t0y9i6R04qd1p
         wzEg==
X-Gm-Message-State: AOJu0YyUcqDFOi19wTyG4VVFvHaRdXgigQ+SiueL8wYbnRzrtDmrCXns
        ietUtOf96qkxCprGwT3dZ3MT8Vs+nWZEa5t/l4sXCAMUKt2WBFD5ZLRCLvbrLLdJ/dv0BfJzS1O
        zhwB1zqGAHVh/F+W2agCGtMm/9xiSplAS7MQ=
X-Received: by 2002:a5d:5c11:0:b0:32f:8a45:93a7 with SMTP id cc17-20020a5d5c11000000b0032f8a4593a7mr9124225wrb.0.1698951802590;
        Thu, 02 Nov 2023 12:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUPZRT8I8iw/CcEcUptKDDx7966nYE1/uugb6+QE4ZoKiWbmft1KG9gyqtzE1rFEHqmKpeCw==
X-Received: by 2002:a5d:5c11:0:b0:32f:8a45:93a7 with SMTP id cc17-20020a5d5c11000000b0032f8a4593a7mr9124209wrb.0.1698951802240;
        Thu, 02 Nov 2023 12:03:22 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id l22-20020adfa396000000b0032f7d1e2c7csm62660wrb.95.2023.11.02.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:03:21 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] sound/isa/wavefront: copy userspace array safely
Date:   Thu,  2 Nov 2023 20:03:10 +0100
Message-ID: <20231102190309.50891-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wavefront_fx.c utilizes memdup_user() to copy a userspace array. This
does not check for an overflow.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 sound/isa/wavefront/wavefront_fx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_fx.c b/sound/isa/wavefront/wavefront_fx.c
index 3c21324b2a0e..0273b7dfaf12 100644
--- a/sound/isa/wavefront/wavefront_fx.c
+++ b/sound/isa/wavefront/wavefront_fx.c
@@ -191,9 +191,9 @@ snd_wavefront_fx_ioctl (struct snd_hwdep *sdev, struct file *file,
 					    "> 512 bytes to FX\n");
 				return -EIO;
 			}
-			page_data = memdup_user((unsigned char __user *)
-						r.data[3],
-						r.data[2] * sizeof(short));
+			page_data = memdup_array_user((unsigned char __user *)
+						      r.data[3],
+						      r.data[2], sizeof(short));
 			if (IS_ERR(page_data))
 				return PTR_ERR(page_data);
 			pd = page_data;
-- 
2.41.0

