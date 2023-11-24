Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF07F75BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjKXNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXNyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:54:37 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E55E172D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:54:43 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab8fso2345900b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834083; x=1701438883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnqaai7rT8P4w6V2VdFT2sphXimv6ezUvhV0ZXgN75I=;
        b=HnhnWPuEXidewlbQXW/ny0CM/eaEh3MiclveFSJbD7oJRNr4HQVKKBcPBYRam4/XVA
         x6iSsCzFAm7M6Ph63COXIE3E7tWpfcNKgaqU7PlpBjZ0DvTq+WMO5HIg/kBk375xgkwo
         HTv5zv37ocD2x0cKAM/xrYM1C58rtu9/4YQCszoMQ2iiRf8F2bSDZkKRNjYEt6k22Nht
         bCT/i5Dmdkcem8n4jAFeEYUsT+Um91helshHy5/os+TVpyjh+arjE6jRmxwMgRIA4UgX
         T0HYLGPQd1Omkrk8r8qurM0Dg3yLTJbcTIflQuJAa0iN/2d1tPnLtxiiqT6t5WF6dep9
         gZZQ==
X-Gm-Message-State: AOJu0YwNo+d4gGQxvhXkgWFMer2uf9/qs1ewpa7kMyGjuIA203wPpnwB
        VKypqdzpdFFIIetPVWA0jAfzccWIsL2RETHSl5rvQtL1kHAurJo=
X-Google-Smtp-Source: AGHT+IESmIArOCg17EGrjWAfojYzlPUS8PQGVxJjuuBGW8Dfvqmv8MAJ3b+ZoCHsMKQtewvrWrZRN00Bx89UJ2CINjkQ8WpytIWx
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2e2a:b0:6be:3025:9148 with SMTP id
 fc42-20020a056a002e2a00b006be30259148mr705380pfb.5.1700834082944; Fri, 24 Nov
 2023 05:54:42 -0800 (PST)
Date:   Fri, 24 Nov 2023 05:54:42 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055fc6e060ae64ba0@google.com>
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
index c736186aba26..1d603d20970f 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -300,7 +300,8 @@ static int sco_connect(struct sock *sk)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	if (err)
+		hci_dev_put(hdev);
 	return err;
 }
 
@@ -438,12 +439,13 @@ static void __sco_sock_close(struct sock *sk)
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

