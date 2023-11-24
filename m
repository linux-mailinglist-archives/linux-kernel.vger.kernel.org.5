Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251777F72EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjKXLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjKXLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:41:40 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94806A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:41:47 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28571255ec4so1798618a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700826107; x=1701430907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVfx+d8yR39xWdamd6Q4w2OlfL23Zow+F5xI2TOjvwM=;
        b=l247jvNpxrRAOdjHeR52HS6AupqSqKowwvvPJ5o8cPvWsm2KxGZleX6/+aIHfd0JxX
         IybL+udO1/CjBP2l/ZmCGnBsWUqJOtp3c5izTh3oHEd3sNQh1w/ZuzsC+cCNv2B9eDtB
         Tvk2aAPkA5FfVl9jaqlCTgOibCoxoB3ylaaYNRnlzWKjbi6Kyj/q9cdwk5lLdVh4QSCX
         MAFZ6VxHoYeUZEjViu/Ebwlnxenoon5lg5X2OBKdg5w5vbYLLivchG+NZfjoGF9HDWqu
         j/+zhRLAl4rWK1IeGc88EvwWVeq5HlhGz7ZkDK1xrvCqt0LA3yPhZuYCIT24sfeedyop
         P6Kg==
X-Gm-Message-State: AOJu0Yz+kWz4XYAXeIU2TyE0MfjB/7dc3/+c0WdHfFuFAWA1uZXvxeBZ
        dQeMh0Yb9Tn77LdXfKd7zFGKEUt1ohw9YC1/Dv0tZmTZTMwShg0=
X-Google-Smtp-Source: AGHT+IFiWUsUtnEGVxIN/wWoVtbi7EkLd+YJhpIpjIpWChCeuJeAL7BwaBwbb867A5v5sXKK/2zICUHJGbj+Ek+RiuWfo9IS9CYT
MIME-Version: 1.0
X-Received: by 2002:a17:90b:4388:b0:27d:15e2:b248 with SMTP id
 in8-20020a17090b438800b0027d15e2b248mr520652pjb.8.1700826107133; Fri, 24 Nov
 2023 03:41:47 -0800 (PST)
Date:   Fri, 24 Nov 2023 03:41:46 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c719060ae46fa8@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
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

Subject: [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
Author: eadavis@qq.com

please test uaf in __lock_sock

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..d7054e3d7146 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -285,6 +285,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -300,7 +301,8 @@ static int sco_connect(struct sock *sk)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	if (err)
+		hci_dev_put(hdev);
 	return err;
 }
 
@@ -438,12 +440,13 @@ static void __sco_sock_close(struct sock *sk)
 	case BT_CONNECTED:
 	case BT_CONFIG:
 		if (sco_pi(sk)->conn->hcon) {
+			struct hci_conn *hcon = sco_pi(sk)->conn->hcon;
 			sk->sk_state = BT_DISCONN;
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
 			sco_conn_lock(sco_pi(sk)->conn);
-			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 			sco_conn_unlock(sco_pi(sk)->conn);
+			hci_conn_put(hcon);
 		} else
 			sco_chan_del(sk, ECONNRESET);
 		break;

