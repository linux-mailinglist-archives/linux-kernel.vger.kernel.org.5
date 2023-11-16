Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A07EE66E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjKPSIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKPSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3D519B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700158079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W54lS/jbyFmKQJpxN3dQRiCf/ft7R1Q+OyFPgBZkh2k=;
        b=eqhIonDBpjIEJ90ik6n6HuCFFP4r/1TIzsOcrIBXYU+DBoECfeHQvs4aKBkP1atpX17y6h
        67oMU+8dfWzgVAIZJwSvQwPk0Fo66RgSTI1AmRCbcsuwc2bjXIxy2Ww9yPhASHLuUOxnxo
        n4DcT7Seg5W/6Hu8DXi4wiDU1yRDL0M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-31z9j3-ePwWdQuw9uwWvfA-1; Thu, 16 Nov 2023 13:07:57 -0500
X-MC-Unique: 31z9j3-ePwWdQuw9uwWvfA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32db43129c6so544068f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158076; x=1700762876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W54lS/jbyFmKQJpxN3dQRiCf/ft7R1Q+OyFPgBZkh2k=;
        b=WiquvTOARCvosNP4DimOwKaOHc4kzc8uN+GJ37VZ/p0GtthOUjcxDvUMxquABLtSzh
         K5SFu3mU7+Mmk/TPKai3P43dqi59ABnHzp/RwfTOsFaZoUUcm2eqq4pZ8uAK9/+1K6xv
         WP0E4Dqur721SSZ/sBPX+Tmil/VClDJmvW3BaK6vnpgCM+1FIZK+ilnmsK99Ic3bywvs
         Shzj3c0vnsgQaRAviH6KyX9DkQhQZCDvIyv+QcJAKOEjFr9l/2KFk+Li6E85BiOjcP2B
         hNEsK1/n0ck86RuWB+nG/QTztin8gsIlpJpOw8DAFHTIfcC/38RkNLNCiFkfF7cBKTyw
         XvSA==
X-Gm-Message-State: AOJu0YxRiJ7FBh9CHww1ls5CFGA+oTxSYF8DhtZfZEA8CKAgxQGfyoSF
        WhmWbEEPPFhdhj6waK9hkFbvmuAGyhsaAtGc2HJemZf01+GcL9cdRj7zpOFayK9/1s6T2lcrKqK
        DUosLG/9V7DT7i8asjUW9Zjh73fJClso8SUaT7Zn1DWzEWaPhTedHb40egLc6v3o/k0hD1obwQq
        boOF8L0/I=
X-Received: by 2002:a5d:4441:0:b0:32d:a688:8813 with SMTP id x1-20020a5d4441000000b0032da6888813mr11709933wrr.32.1700158076015;
        Thu, 16 Nov 2023 10:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr2Uo2/zKtm0kyeqWnh34kZmrEKiHbZLy5vndsH3tPLeRv2OqMJqf+niFFID1bDqbG3zONhA==
X-Received: by 2002:a5d:4441:0:b0:32d:a688:8813 with SMTP id x1-20020a5d4441000000b0032da6888813mr11709913wrr.32.1700158075741;
        Thu, 16 Nov 2023 10:07:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b0032db8cccd3asm32812wrs.114.2023.11.16.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:07:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sahaj Sarup <sahaj.sarup@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 2/3] fbdev: ssd1307fb: Change "solomon,page-offset" property default value
Date:   Thu, 16 Nov 2023 19:07:38 +0100
Message-ID: <20231116180743.2763021-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116180743.2763021-1-javierm@redhat.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to specify the page start address offset of the display RAM.

The value is used as offset when setting the page start address with the
SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
1 if the property is not present in the Device Tree.

But the datasheet mentions that the value on reset for the page start is a
0, so it makes more sense to also have 0 as the default value for the page
offset if the property is not present.

In fact, using a default value of 1 leads to the display not working when
the fbdev is attached to the framebuffer console.

Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 5ae48e36fccb..34f014bf4994 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -637,7 +637,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		par->height = 16;
 
 	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
-		par->page_offset = 1;
+		par->page_offset = 0;
 
 	if (device_property_read_u32(dev, "solomon,col-offset", &par->col_offset))
 		par->col_offset = 0;
-- 
2.41.0

