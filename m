Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA53A7EEA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKQBCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:01:59 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855D2C5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:01:56 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc41aed6a5so19603715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700182916; x=1700787716;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n+qzrRAUex+PBmakgBQfGm/QBZamI0Vqb/jP9skxvVE=;
        b=FP8tAwnFGySglYjxkv562PtkFt9R005egDHqSxjcDTfMFxM37U/XnRUdSZftVjv5W9
         kn7FHsrztYtiQ6V/fVJ59IpadzZJtmtoGa27jAEX9SVwstj0q9UPiRyceD91lQQbMcXl
         TRYSKlVoEn96HuA1p1HlNErlPM5/EF5hZd8X+l+8TlMZ+Y/SySuBSwDtz2Grcn3Ks4ZA
         U4A833mHt/IeoIByrMh2jO89UDzchiBj5JHoEcpcogH37nBT4EPOA7gciQHOLKdtILLG
         0oxEfpODI3VD2pH/ZjOX8yIOCz7jyCi3KJpu4oYZitIcI6f/Ntd6lK6QeWlYmv8n8QCk
         jwGg==
X-Gm-Message-State: AOJu0YwGOyc9i5Oe3gBtDgirAXfKFpklhSXACRcq4Qdm3pNaGBPy2Rzd
        R+rdEJjoUsa0K7N0pTIDkUQS0yu7lvjllwyBkXhbcvVjY0U2eXI=
X-Google-Smtp-Source: AGHT+IGqRCoftJmMszs5BLQ2FBv7up12Sn7uAP4FByBRsUqTaUoYf6MDLp27A514wsyiK22Kt9x+Q8VPBvO8YAE5C9HF6EuMjoGZ
MIME-Version: 1.0
X-Received: by 2002:a17:902:8b85:b0:1cd:e5b5:b379 with SMTP id
 ay5-20020a1709028b8500b001cde5b5b379mr2467230plb.12.1700182916061; Thu, 16
 Nov 2023 17:01:56 -0800 (PST)
Date:   Thu, 16 Nov 2023 17:01:55 -0800
In-Reply-To: <000000000000797bd1060a457c08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3e53a060a4eae0a@google.com>
Subject: Re: [syzbot] [PATCH] test uaf in sco_sock_timeout
From:   syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test uaf in sco_sock_timeout
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..515b52e14b5f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -415,6 +415,8 @@ static void sco_sock_cleanup_listen(struct sock *parent)
  */
 static void sco_sock_kill(struct sock *sk)
 {
+	struct sco_conn *conn = container_of(sk, struct sco_conn, sk);
+
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
 
@@ -423,6 +425,9 @@ static void sco_sock_kill(struct sock *sk)
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
+	sco_conn_lock(conn);
+	conn->sk = NULL;
+	sco_conn_unlock(conn);
 	sock_put(sk);
 }
 
