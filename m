Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDD7F5700
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbjKWDS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKWDS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:18:58 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76B1B3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:19:04 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf6177552cso5785625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700709544; x=1701314344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4SgUdCsrue3easXW3h1+6ZVf0VEc0EEtfc1xmfLb7x8=;
        b=IFFkBs63rFxlYmJLuB/bdI0PvlkfgTc1LWCEapuefyLTZ6sIP3tJehKf5ESOmxafHY
         vsD2vUO0l0drYzNzau53RckdSlXNzMFDd7d5KWmionJ4ZwX0hD+VI4DYNwq1t7LhU/bR
         iI7BoQrpOPg2pNCZhmTrn1Hvfo8iNIUmhZy5vPzDielaUTfQ7c72mgmyZbDvezWNDkcS
         biYQv7zJicgWbTkioVXBsErfedu8IyeHNnN9jV8CdHpie1RGDY0AXQOMRf2vuFqlUV6F
         pjUGy9GMn1BecWHgjHLOM7p+P267uWKFDoe3CP7J5VO9rwfyK+Hpe2LpJtQ2VEbhgy5R
         tn5w==
X-Gm-Message-State: AOJu0Yw7blanfXmUwGS6sSfTbSvY1GkvroH57Lf5vla31fM3Y3FQLXjC
        QOM5fhlmcOWmvWaJVdHn6kL6gPbNdOHCYbWyqe+Kbgosq/x/n3k=
X-Google-Smtp-Source: AGHT+IGW7+ObphmRTLiBHXZe98zBVohq6iLAogKAmmMe1Rx3YIMLmQUiLsjces8a3RytPbxlAAVW92k4YKy+wTxvML5P3IkXciUh
MIME-Version: 1.0
X-Received: by 2002:a17:902:bb8f:b0:1cf:669f:3a86 with SMTP id
 m15-20020a170902bb8f00b001cf669f3a86mr934760pls.13.1700709544589; Wed, 22 Nov
 2023 19:19:04 -0800 (PST)
Date:   Wed, 22 Nov 2023 19:19:04 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004581cd060ac94c84@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
index c736186aba26..3d76352d3e79 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -270,6 +270,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
@@ -300,7 +301,6 @@ static int sco_connect(struct sock *sk)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 	return err;
 }
 
@@ -438,12 +438,13 @@ static void __sco_sock_close(struct sock *sk)
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

