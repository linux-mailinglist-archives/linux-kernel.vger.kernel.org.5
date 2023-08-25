Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98691788694
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241163AbjHYMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjHYMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:05:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5FE1FD7;
        Fri, 25 Aug 2023 05:05:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso102375666b.0;
        Fri, 25 Aug 2023 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692965117; x=1693569917;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCIIdxGXgbtA0ZFgi3G4fDNBziu5Q20KuX0FkDoMPjY=;
        b=KNnUnKxPA9T5qgkv61UlqXSeDdwN+Zz/1xYcGybkBrK3mnz+UHxGx+zP7wfSRH/34m
         VphPCVqfF349uIigmK0Lbjmt24BR0YFIwn26Pu/gLBY01UO7ZFSEOxHBmxtImUlDKJb2
         Uy8t71Ser275sWDVYhZGusaHnEvWNRJ0t3HxY4iBofLnGICkSbKZ6avRz69zmsb1oDei
         IdEwkzB/9RbexMLxJvy0y2gVatj7cJS6UofMsVlEsSA1Bo2xrEd3xoiji+e1chmWgEgC
         mGgDRAxrn3SR9Wb4ka7sC2aIAu4Q5/+C/FQFsj7OVrqNa9K+XOOrAMZHuFolyjaVZfxU
         w1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965117; x=1693569917;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCIIdxGXgbtA0ZFgi3G4fDNBziu5Q20KuX0FkDoMPjY=;
        b=dIUsXpXuuOjlnA1dSYbmI0sEaqiHv6UkTlaqmOTrvAe1IMnCivIOxmcyiH51qHJSy0
         tyCrH5No++uG2hWJs/D0zI28/Tc9S3DpdpjAEENOYxleb03hpOK++p7XVJ+BnhOxXy0E
         GN88F3NEC1bT6yeWla4rxcB/l126A8i5Jg08t/SuWKtiUY18sxEv36wsNNimDmFO3qIg
         DFbvVDVVK8skpCFspSfir/C2dVkySH8sm3OYQVcGYsMS6mrESBR1b6O2qAOFvtIuI6CJ
         +PKFpetW9bnDfihZpExPXH0zw4hS6CTSSdzKnaFoHqncFr9CevvK9lRJNyJ9LvA7fZb1
         FRKQ==
X-Gm-Message-State: AOJu0YydgNqlL9sGjiCuqQlQg0al3hQqNgHm86ESP6vnxhRzm4a/72MV
        MXcaLKjcy1joHE4KHBv+Hc4=
X-Google-Smtp-Source: AGHT+IEvSzy4l1py10ko6cQxsKtwTyta6kmj2sJKAtLcNpi5YkQsEaZ/w8LrbjQXsJUiFyQIxeF5zw==
X-Received: by 2002:a17:906:23e1:b0:99b:f3d1:7735 with SMTP id j1-20020a17090623e100b0099bf3d17735mr12590629ejg.29.1692965116426;
        Fri, 25 Aug 2023 05:05:16 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:98c5:e120:ff1e:7709])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00992bea2e9d2sm899199eja.62.2023.08.25.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:05:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] xfs: fix select in config XFS_ONLINE_SCRUB_STATS
Date:   Fri, 25 Aug 2023 14:05:13 +0200
Message-Id: <20230825120513.29235-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d7a74cad8f45 ("xfs: track usage statistics of online fsck")
introduces config XFS_ONLINE_SCRUB_STATS, which selects the non-existing
config FS_DEBUG. It is probably intended to select the existing config
XFS_DEBUG.

Fix the select in config XFS_ONLINE_SCRUB_STATS.

Fixes: d7a74cad8f45 ("xfs: track usage statistics of online fsck")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Darrick, please pick this quick 'typo' fix.

v2: removed a stupid last-minute insert on my Signed-off-by line.

 fs/xfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index c9d653168ad0..ed0bc8cbc703 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -147,7 +147,7 @@ config XFS_ONLINE_SCRUB_STATS
 	bool "XFS online metadata check usage data collection"
 	default y
 	depends on XFS_ONLINE_SCRUB
-	select FS_DEBUG
+	select XFS_DEBUG
 	help
 	  If you say Y here, the kernel will gather usage data about
 	  the online metadata check subsystem.  This includes the number
-- 
2.17.1

