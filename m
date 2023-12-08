Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7080ABEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574620AbjLHSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574618AbjLHSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:19:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC8F1724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:19:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf5398755so595268e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059587; x=1702664387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOrnZdekpeAnHe7xn8UUPJWAs5TkKWMYRyhQfSDptvQ=;
        b=jllc1r8XWTJ5RmjYTsBJ935/2Cp1pYqmxoXq3NO25q24k9NvuAlR/ZFYpBu8jf3gOc
         6OJVNHrWJY4ai+IM3GJjJlW6nombFSCQ4GSWpauNm5MPN6IB+pCId0RRtj68vtB0goCl
         Peezhoa81BDOI2WcFY7kjo+Mu8nBcoZw0inowHVZVUCmubByhB0iYf8TsaaELgf/a7BI
         L7jduwOVsSonLHpnQniuoCUC+2tm7afTF+FyhcKKDdykgtrxnXj/ghrLtCAzM9w0SB+r
         +F0knZHNRnbfQCX92ecE78/uCen438R4VCq5nT6Pw9SzdVi+FdTRuMFd/l8y4pgagnjS
         Wv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059587; x=1702664387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOrnZdekpeAnHe7xn8UUPJWAs5TkKWMYRyhQfSDptvQ=;
        b=afZElu73EAUtdiSseVzO2TGQLkq//0gm2xR9odVz+423rmt/Zi/TaH0u9JUOXdljZP
         MVsavk3UTiW/j8s6d0//0yFOgoJ5J74WEOsiw9IZqvLAhxcLnpmlJyGE3mzrgIULU1N4
         VGHbBZIV4Qiuc3UQMPyFAgUgWR6T3tiIQHSvWuHy4mv5ZpIrB2TPJeFJN1XbN7k1M+8p
         TMmatU8ayTdrGx8beXP4/k7n6DNtvUH+zAID2mKQwr8O1tNxUIfaAvFAVxEeWPto//Hc
         YR9tFtKbuQw2l9714O9HXEJlK0acBBF3wrD3GfsbIc9FUTC/XGaDlmsxJ18LqXaSYeI5
         SJOA==
X-Gm-Message-State: AOJu0Yy1bCHVxcOBqW/+0GjRCO19CuBbUF28FXuTJwCm3yq2sgJepVeM
        /Dd14Oz9p1YXCmDas4mU2GquR6CURwA=
X-Google-Smtp-Source: AGHT+IEEMuA8qPG84k8dFSXpZgNwYxw8lx2Nozdz1oeVgXDapu7AXQsf4jIMKJRYMkMTlkdoqyeqig==
X-Received: by 2002:a2e:bc02:0:b0:2ca:143:a52f with SMTP id b2-20020a2ebc02000000b002ca0143a52fmr458391ljf.2.1702059587157;
        Fri, 08 Dec 2023 10:19:47 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a1cc1be1158sm1277639ejc.165.2023.12.08.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:19:46 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:19:45 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: rtl8192e: Remove variable channel_map
Message-ID: <19ca762b4b9d5a3e857b31c22f0688324ca3bd9d.1701989555.git.philipp.g.hortmann@gmail.com>
References: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable channel_map as it is initialized but not used. Remove
channel_array as well as it is without channel_map unused.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 10 ----------
 drivers/staging/rtl8192e/dot11d.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index d51d4afff61e..c44ff26e8d61 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -12,18 +12,8 @@ struct channel_list {
 	u8      len;
 };
 
-static struct channel_list channel_array = {{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}, 13};
-
 void dot11d_channel_map(struct rtllib_device *ieee)
 {
-	int i;
-
-	memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
-	       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
-	for (i = 0; i < channel_array.len; i++)
-		GET_DOT11D_INFO(ieee)->channel_map[channel_array.channel[i]] = 1;
 
-	for (i = 12; i <= 13; i++)
-		GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
 }
 EXPORT_SYMBOL(dot11d_channel_map);
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 5c02e51c39cd..d047283f2ceb 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -19,7 +19,6 @@
  */
 
 struct rt_dot11d_info {
-	u8  channel_map[MAX_CHANNEL_NUMBER + 1];
 };
 
 #define GET_DOT11D_INFO(__ieee_dev)			\
-- 
2.43.0

