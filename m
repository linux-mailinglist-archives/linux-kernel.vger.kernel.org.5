Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5D7C793B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442975AbjJLWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJLWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:07:30 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7920DB8;
        Thu, 12 Oct 2023 15:07:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c620883559so973571a34.0;
        Thu, 12 Oct 2023 15:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148449; x=1697753249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wj8bxxmMdfTdWcmOthiPcD4f/E2nZ5CmP0hi2ncm2JY=;
        b=OUDizIfCWGGTGGK+SkCtg9S4aakkLJKtRkjJy320BMUuBYN42sqpVpwj0BXQrNVRVG
         vt6oxwLwo5PxI9wUKA9+pAcropa0tfv2nK1TR98XqkM/scvnCAkXm4DZX6quKvfQfpAy
         MujN1vH4K8DIEV6m7peF5J7S/bI1wsyDF3JmZdhWbhjCpGycIeb73DAafm/9zh4oA5N+
         tisl5EJYIAdlDiHv470wxUOm3y4Nn8PEg42G4J9op2W+WOExlF9nK/ns0iX3AFLtEWEZ
         t6e3y3QYtjOCTFAkcH/oa1SsImbdwsGtWw9O2UO5jTEVn+8AlyZLWBHiVz8/ha8oHkAU
         dxog==
X-Gm-Message-State: AOJu0YyQwOVjyk10JlCEkBJTHnTev4H6GB5k0SWpCzBpduWdwtMJb3dw
        PRj0LgiaeHkhMr2uiPc2dbsRv9SyZiTm83tx
X-Google-Smtp-Source: AGHT+IF3ETYErezb1wVlMe3A6ctvCLcDHQy9K6fJw58TEfcbRXqIVetzumpEtlejMblEpd2RKXJmDw==
X-Received: by 2002:a05:6830:1087:b0:6c4:a42b:9cd8 with SMTP id y7-20020a056830108700b006c4a42b9cd8mr26584088oto.1.1697148448593;
        Thu, 12 Oct 2023 15:07:28 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056a002f0100b00690c52267easm12225670pfb.40.2023.10.12.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:07:27 -0700 (PDT)
Date:   Thu, 12 Oct 2023 19:07:34 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697148446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wj8bxxmMdfTdWcmOthiPcD4f/E2nZ5CmP0hi2ncm2JY=;
        b=shsa4lg5x46ZuiVFyR2F5z2If28ls8/ezrObv+/KyRopymSkYgc5T2S4DLHX3MHphMVs6Y
        XwoC0v4KX5tFuzgzpTvD2c0m8RQEkfm2068zPF4y+nwkT/7ybxB+1KyV0Pve8TlM0slua6
        VxWBvXSvXn1LwfHriB5sXx6OqTX+HI6EVHCTZ+OKZypr01BJj0LdnCd1NBAogI7ekNia1m
        55o7NaPqoocNk9xxglYBfjmwdhxcTI8feFqegITpnsOqYzdVH5Zr0LwN3e53E1GJ1ESt4C
        BBnBSugmC38WE3fhwzolY9kqDuXnwe9FPM5/5LuwFDmF9KoHG/fYWkkgM4bsbA==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
Cc:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify
Message-ID: <cwc32sg4vzz6akduyvze6tu2dkzpljtvpycuhz43t7lmbzbyvb@jgywtsrcvuzw>
References: <000000000000a02a4205fff8eb92@google.com>
 <gugiuvjgpoogf3k5cm4px4jwevg5torsu3d7afbbhvnrxho4zu@wkcxeb5sr5ez>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="g4hznxqvzwwzlnny"
Content-Disposition: inline
In-Reply-To: <gugiuvjgpoogf3k5cm4px4jwevg5torsu3d7afbbhvnrxho4zu@wkcxeb5sr5ez>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4hznxqvzwwzlnny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git ce9ecca0238b140b88f43859b211c9fdfd8e5b70

--g4hznxqvzwwzlnny
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-media-pvrusb2-fix-use-after-free-on-context-disconne.patch"

From cf7c3b08f80c4cdb7dd08cb977f29d41efebcf79 Mon Sep 17 00:00:00 2001
From: "Ricardo B. Marliere" <ricardo@marliere.net>
Date: Thu, 12 Oct 2023 18:26:47 -0300
Subject: [PATCH] media: pvrusb2: fix use after free on context disconnection

Upon module load, a kthread is created targeting the
pvr2_context_thread_func function, which may call pvr2_context_destroy
and thus call kfree() on the context object. However, that might happen
before the usb hub_event handler is able to notify the driver. This
patch adds a sanity check before the invalid read reported by syzbot,
within the context disconnection call stack.

Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
Reported-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a02a4205fff8eb92@google.com/
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 14170a5d72b3..1764674de98b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -268,7 +268,8 @@ void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
 	mp->disconnect_flag = !0;
-	pvr2_context_notify(mp);
+	if (!pvr2_context_shutok())
+		pvr2_context_notify(mp);
 }
 
 
-- 
2.42.0


--g4hznxqvzwwzlnny--
