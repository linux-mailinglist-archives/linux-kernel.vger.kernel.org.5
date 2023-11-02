Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9397DFADE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbjKBTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjKBTY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9B6188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698953056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p5/AYOFpMtipyX3yVNE3RQ2sBJUpaSLLWRc4pCufaM4=;
        b=PISWMasEA+/cGOyaiqmN54OtG0KDP5HxLmcr3QdWeEckS0gUKM6bu/fTslszFg9TNgklmV
        3FNjoWAMGh5RI/SRDpZKuvCAAlNxHcuOETmMHpVGE2D/GQ1GLBkEEDK6sIUXcLAqkHfYvO
        MWnwQE8/k82Z2OpTuQiuR96pKDTgw1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-mKhNalJfNKCnAuaNQZnUsw-1; Thu, 02 Nov 2023 15:24:14 -0400
X-MC-Unique: mKhNalJfNKCnAuaNQZnUsw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083a0fb583so1480405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698953053; x=1699557853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5/AYOFpMtipyX3yVNE3RQ2sBJUpaSLLWRc4pCufaM4=;
        b=regKi6MBnI+24VjVhOlgulMyIvpbQgmi0eVjne3CH2Nz2+OUQ99DA8n5BdtkbPSvlA
         5s+r+w87Y9m+hI1yJEbDpUQPVXifjLOjM6I7pC2khoAqPi9TjpM3jpAvDiBM0surOyHQ
         DQJZVPQSRuh2qCKcpjQCwbU3FY7Me+rHy9/65hcao52mbFMrMXR7r4kf9U44EgTJ360G
         kZwf4ZTtmwUcucY0Fs74tSfi7ul8bXkPHtft88SE7A1FTh1eA6nXBD3OV7eNgc8NG8MQ
         AXzQVVbecx5eVeDDYZgvZuaHCN0/UuvnkOLf/yuvcTZ0F2n7hu5pkWynGeC4ISX44BV2
         2PFw==
X-Gm-Message-State: AOJu0Ywsou+0RQ4Y0djsAi+C/0nNCPfV1JkORU+7ZwcgtaXkJvw7jeKy
        Tv5VShyfFiAsUPAu3j3aly2RCywlpD5RWpQAm/YSnn0iwc2RBWBTvz9/xomxrSiYWw43mflWKza
        KP/r8Z7IxrDadzxG5N6jtyz6f
X-Received: by 2002:a05:600c:350c:b0:405:39bb:38a8 with SMTP id h12-20020a05600c350c00b0040539bb38a8mr15776530wmq.2.1698953053683;
        Thu, 02 Nov 2023 12:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEUyUDco60L/5B6mfJp7cXtWCHrP4XE4BNQJlgxAUqDulZh/VHu2Gj0WecmI7xbtoZDCWUmA==
X-Received: by 2002:a05:600c:350c:b0:405:39bb:38a8 with SMTP id h12-20020a05600c350c00b0040539bb38a8mr15776516wmq.2.1698953053326;
        Thu, 02 Nov 2023 12:24:13 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id gw21-20020a05600c851500b004064741f855sm66371wmb.47.2023.11.02.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:24:12 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/video/fbdev: use new array-copying-wrapper
Date:   Thu,  2 Nov 2023 20:24:03 +0100
Message-ID: <20231102192402.53721-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

viafbdev.c utilizes memdup_user() to copy an array from userspace.

There is a new wrapper, specifically designed for copying arrays. Use
this one instead.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 58868f8880d6..a52b1ba43a48 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -574,7 +574,7 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 		break;
 
 	case VIAFB_SET_GAMMA_LUT:
-		viafb_gamma_table = memdup_user(argp, 256 * sizeof(u32));
+		viafb_gamma_table = memdup_array_user(argp, 256, sizeof(u32));
 		if (IS_ERR(viafb_gamma_table))
 			return PTR_ERR(viafb_gamma_table);
 		viafb_set_gamma_table(viafb_bpp, viafb_gamma_table);
-- 
2.41.0

