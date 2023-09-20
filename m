Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660C7A7075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjITC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjITC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:29:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAD412F;
        Tue, 19 Sep 2023 19:28:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c328b53aeaso57153625ad.2;
        Tue, 19 Sep 2023 19:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695176937; x=1695781737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=hDVkcNQNzGBWx5z3Tq0YTSl+CZigWuaX6OIEoJsC+93Z4T/x3qlhIWF+4YDbVHwlDC
         0wGiGmULatAVYE2zddGD1rz1gIUZwuNn1ELZYu6UksHSJ4IOne82Fz8YLAAH6I0PH14I
         uv6aUnEwd7ZFYpl6Lols1l90kLIXLs764RFrbLwlKBuTIrWQhrnADfLQFkimBtpS/xtf
         rwxDZ7M6DLcQZPlAhyPFOrm46Kxb7EVFzoZU7TA71lSrc1oEdla9xBZ50gWlIje5EGuI
         wE8TX9pr7AOBGAliOchwLNjs1eUP/HI6MJ124t5QrL3t+JYtdbqyJGAcm7wM/FqHMS7F
         FUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176937; x=1695781737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=OFDL2WX4RwNCh6Ze0y5ptU+j9y3876ed8TLlWRRwlF+liQACgzZvYxEqndiq9/QrKp
         a0CUrHIk1k2WTpd/rRFCzSzSHMW8rRns6hMSBH29/DMxm0em4H4kuuYNQxBx3DP6iQkw
         RM7MjTDT7kpvELfV70cHA0BhSeamzSbAczjlGsZs5xkhli73mRckE/lNrCIscevxuSQa
         7Zo9x3rABr9jakwts16ul6VctEhCEV+1fo+HXxn9YRflTHs80eoBbzQYf1VRdHYOdufF
         DGcZ6RId+IxKJHNV1L9Ln3LfZvEu+qM0gzj9i9WHzHSXRhWwwDs9ERHWQRiFoMalnWDd
         /iKw==
X-Gm-Message-State: AOJu0YzI7QPn2RfsFDRI6Mcf4PEel5L+uPyyHTb5Vn1h0GlHFypQ1Qqn
        pxYCv9rU+D1JOXNWRvNfIlk=
X-Google-Smtp-Source: AGHT+IEZlDmWh7PrhaDhdl49q2CMxvu8uzds0DqTSVDtgAY96SSaYFWPfAb2DTn+AFysKoEXOjzLgw==
X-Received: by 2002:a17:903:191:b0:1bf:826:9e30 with SMTP id z17-20020a170903019100b001bf08269e30mr1357501plg.16.1695176936887;
        Tue, 19 Sep 2023 19:28:56 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a170903110900b001bc930d4517sm10610009plh.42.2023.09.19.19.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:28:56 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v15 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Wed, 20 Sep 2023 10:28:10 +0800
Message-Id: <20230920022812.601800-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920022812.601800-1-milkfafa@gmail.com>
References: <20230920022812.601800-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control base for Nuvoton NPCM driver controls, and reserve 16
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..68db66d4aae8 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -203,6 +203,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

