Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85675DEC1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGVV6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGVV6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:58:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D082690
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so162238639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690063091; x=1690667891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPT/AaCv1OdblmY1sVuziMvUrHf6Fzs9xst1BQLTFpI=;
        b=gLDIOy0ohXK9vHvraqSrnUynmZTIZUhN13Q1jXSlL9o9+gqiPYDRq8Th/tnKe+eKSr
         y26Y+SLlCCOi3yT6/hzl7oVlUn3VlKC1I3LURBAXMh3alueBoROpiQydgomkdefEbaAg
         BqiF72KG8tCfKTQHV1GJu1DR5cQPrbD39eWEp6RhNC94WNp494vyNmucf2hvDpDHyuGK
         fdHq9foANdxDy3nFRxj9J6d8xXvfbZDd3Hqv45xD7KMjgQQjdgsO9g22b57RCXq9TsOW
         i1bAjp0mmhd/sFBbjpB3sgSxEAKy7zlgZ+MAwBY4hxYuGttf4twoX+moE0E+Pcdzg8Q3
         OW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690063091; x=1690667891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPT/AaCv1OdblmY1sVuziMvUrHf6Fzs9xst1BQLTFpI=;
        b=d1BmQ8xS4MixE/sS3p0qY+L2g0iZPsfKDoqi8ET+pKuUDPjZaWLMdsfXfdgBXvF68W
         Ear61WURxg53AxsFJKPAlb3st2zMnTptRba20tMrA/HDhPGks1C3uxKe9K2DC2qhAvUZ
         GZEyq49x0VC7U/PD9iRZfsfa/Zc0rhYWpncFwSqp+KPaIRM09qH/r4IgqWj41eH1wAhv
         vs834zqByWPJGxrSyQTDqJOBDn2Nf7MEzvvwxBgp1A6DDvlWaUBdmnQhi+DdVP/GXtP9
         KjnpqpQ3qiAGVeoss095FGIGYIMDzDOXTTYxQpivcSJQ5PggrIewqjaGnifYQK+EUfdT
         gTHQ==
X-Gm-Message-State: ABy/qLZMV6k4WgE4TI/0h+8UfOS4CmasMhbK70wWlsfvWJwP3cfVIG0f
        M19N8Un8IllZWf/cA9nZsxI=
X-Google-Smtp-Source: APBJJlFt3oHdVC28SHz3N2Mh7uQSWrDQ0BdAogp9lEEEWYgXszD5grDUOkI8fc6+R95dvQYp36wHFg==
X-Received: by 2002:a5d:9c95:0:b0:78b:b892:e334 with SMTP id p21-20020a5d9c95000000b0078bb892e334mr150927iop.11.1690063091537;
        Sat, 22 Jul 2023 14:58:11 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id z25-20020a02ceb9000000b0042b3e86dfd8sm1932511jaq.141.2023.07.22.14.58.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:58:11 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     franziska.naepelt@googlemail.com
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/9] staging: rtl8723bs: ioctl_linux: Fix block comment alignment
Date:   Sat, 22 Jul 2023 23:58:08 +0200
Message-Id: <20230722215808.4246-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
References: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch issue:
- WARNING: Block comments should align the * on each line

Signed-off-by: Franziska Naepelt <franziska.naepelt@googlemail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 20c296d88c8d..088d29b9ea03 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1204,9 +1204,9 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
 	/*
-	* this function is expect to call in master mode, which allows no power saving
-	* so, we just check hw_init_completed
-	*/
+	 * this function is expect to call in master mode, which allows no power saving
+	 * so, we just check hw_init_completed
+	 */
 
 	if (!padapter->hw_init_completed)
 		return -EPERM;
-- 
2.39.2 (Apple Git-143)

