Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05737F878D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKYBbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKYBbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:31:05 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68209170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:31:10 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2855e4715e4so2987433a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700875870; x=1701480670;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKCd3mvp8EhMZXPrdd/+Q/kZz56duRgmNMjj+zisTB0=;
        b=syXg2pB8q32oQt7WJtohjlDnSnT1vklCi5ONEk+rTl6L+012yaYmfm5lgX0f4gIATD
         XVTUITW9hxLPHmVVMUlRKtv7LxJEoAxeXptYeiD2qRZQtaKr9k3yCrv1/gxQqXPTTWXh
         1c45JgRC8JlkEALxFJzef9gErg2HGD1bYd4S5HqErwo41DEYEM/Lze5QNzMl6Q32OZom
         VnkVP2bo9ENE9LrjVGsCZeL2nJipnntfxCCIjwjNxYJsK6pF3nOrjTC4BSrfCllWm62m
         Wo21Fq/K56o5Miu7mWMabWQ4ZN4tc2yBRh5nx7iCQTn/KCvh/I6zYpd/0fW5VrQXJFW1
         w8SQ==
X-Gm-Message-State: AOJu0YyalK/nRfBGJxghy5lMs+42tHUbhrlAUF63j1GCW0FD5PberSGN
        dPYjVTqLX39g5Z4+NXr+nW8JCZJhmTsrUXTEeauxj5Z00UOPbY0=
X-Google-Smtp-Source: AGHT+IEnAyAs55hmV0pxUlpyE5+jvCIyOZsNHH6FR8O0rc+yB/oEpnmXcg+RLykslGIt9doDD/qIZiMcpo2PBmj3oqVLX7Venerr
MIME-Version: 1.0
X-Received: by 2002:a17:90a:7564:b0:280:80ff:1c86 with SMTP id
 q91-20020a17090a756400b0028080ff1c86mr879251pjk.4.1700875870052; Fri, 24 Nov
 2023 17:31:10 -0800 (PST)
Date:   Fri, 24 Nov 2023 17:31:09 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000aa95b060af0069b@google.com>
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
index c736186aba26..0bf3d90c1442 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -285,6 +285,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -297,10 +298,12 @@ static int sco_connect(struct sock *sk)
 	}
 
 	release_sock(sk);
+	printk("hd: %p, hcd: %p\n", &hdev->dev, &hcon->dev);
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	if (err)
+		hci_dev_put(hdev);
 	return err;
 }
 
@@ -438,12 +441,13 @@ static void __sco_sock_close(struct sock *sk)
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

