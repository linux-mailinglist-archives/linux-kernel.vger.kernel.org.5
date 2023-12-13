Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43E810785
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378156AbjLMBTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378134AbjLMBTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:19:10 -0500
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD720F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:19:16 -0800 (PST)
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so377767839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430356; x=1703035156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUXh09h2lQO8hg4DVa7lEdMbGciYtMpynkwHc3N2aNE=;
        b=hPMLVge0zIoWPeC27jQ8Vndf5IWz6zxKGhWfXsWEBV+nbCzmX5GXTxLzsE/PhL5dji
         0U4YCOIU7UM27Mo55ZA/JF/S509y1NzkuXM8pv5w1rVs3wsfXFjjpPTqPwJWkeeJ+KYC
         mb4XbFp5GK93mierPudEMXoGypdP5ga4rbDHo9WAgB+E5EMjgPMW7phMOQvH7IyyLKd1
         TBjFZ+q3uzhxET9Q7cZLr4FutBhbk8Dy4HxRfcc11q/CL+eA+11tyoXK2AVq77p0L4rs
         n3xEtGQ7jKIQq0af3lyh5T0cFIifmdRkq5vGTdZwKBX0UHWZBEcSwKn8pRoi+JIaSZR4
         aYpg==
X-Gm-Message-State: AOJu0YyZiVMhl7tM8UapabBlDVil9GmFhtmkllBZ/NEBPdgxhQxsG5xt
        D+rItlir6Zu8Wocb9slIhek=
X-Google-Smtp-Source: AGHT+IHMr04vj0dJJgQ8mjNjKeiyECW7R4/yw/fE90/5IglQ245owAWpWj07njK4AgX+TiuiyA0jTA==
X-Received: by 2002:a05:6e02:184c:b0:35d:a8c0:8c92 with SMTP id b12-20020a056e02184c00b0035da8c08c92mr11355963ilv.99.1702430355753;
        Tue, 12 Dec 2023 17:19:15 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([111.48.58.12])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001d08bbcf78bsm9266913plh.74.2023.12.12.17.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:19:15 -0800 (PST)
From:   xueqin Luo <luoxueqin@kylinos.cn>
To:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     xiongxin@kylinos.cn, wangqi@kylinos.cn,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH-next] staging: rtl8723bs: replace deprecated strncpy with strscpy_pad
Date:   Wed, 13 Dec 2023 09:18:40 +0800
Message-Id: <20231213011840.10005-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We should NUL-pad as there are full struct copies happening in places:
|	case NL80211_IFTYPE_MONITOR:
|                ret = rtw_cfg80211_add_monitor_if(padapter,
|						(char *)name, &ndev);
|                break;

A suitable replacement is `strscpy_pad` due to the fact that it
guarantees both NUL-termination and NUL-padding on the destination
buffer.

Additionally, replace size macro `IFNAMSIZ` with sizeof():
|	struct net_device {
|		char			name[IFNAMSIZ];
|		...

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ff763c10064..90d521571f0e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2144,8 +2144,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	}
 
 	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
-	strncpy(mon_ndev->name, name, IFNAMSIZ);
-	mon_ndev->name[IFNAMSIZ - 1] = 0;
+	strscpy_pad(mon_ndev->name, name, sizeof(mon_ndev->name));
 	mon_ndev->needs_free_netdev = true;
 	mon_ndev->priv_destructor = rtw_ndev_destructor;
 
-- 
2.34.1

