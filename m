Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117F7F881A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjKYDU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:20:25 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB441988
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:20:32 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cf7ff75820so29668345ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700882431; x=1701487231;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPtFm4aNlsL28hzwfoClasUPy/BDeRiM4ySI31Qf8/8=;
        b=xMjh/9bwZIy0NJC66eQBIwiFx/kLXc6yHhx6v4+zFGV976pkkdie8c5EPGQ62e/5XD
         /vmziSO3INNzC5r5XDtgR3Z3fqT4wtP08I7Z4730bPgg3FyUfdDAXzkD94ynm1muXF5R
         Y2Mb+alHsSwNgkApxWad/TvXiiKLbg9saG0FLSD4DQHjJd3QauUN6e8P+bO/Jpn0EHWy
         rn5CiJK9nj/0S1D4Xi0JAWiKVFqSZ9a6KNLdNTGDO2yeZplv5wYIoEB1PqzqO3+Fwo24
         cLmPjSipA8xFXQ9pg866aqwaBp6Bx+6+uNUWMZc7/9GQEvIQxxUA9Nlf2GFEmhNeyytD
         K83g==
X-Gm-Message-State: AOJu0Yzj9YL7kvtJej/eQCWvzMkTSXEBYDTm34dthDWiXqmqgGqx6YB2
        lKf4zb89p+EXD76YSk2AseDMSpzAgdSGm5WiLDCa9PDgGEHOVWE=
X-Google-Smtp-Source: AGHT+IGKLBiCaWcXVPqDkosGQzUGFyUMfcXIFA/iyX2bhRLe/4x3C44MpeFjZLXGYhdciWCVPFqc0eeBXd6IH3RJGzAFVDRpLWmM
MIME-Version: 1.0
X-Received: by 2002:a17:903:41cf:b0:1cf:a2e7:f84e with SMTP id
 u15-20020a17090341cf00b001cfa2e7f84emr900903ple.3.1700882431654; Fri, 24 Nov
 2023 19:20:31 -0800 (PST)
Date:   Fri, 24 Nov 2023 19:20:31 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024c34e060af18d39@google.com>
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
index c736186aba26..236da4241620 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -285,6 +285,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -297,10 +298,13 @@ static int sco_connect(struct sock *sk)
 	}
 
 	release_sock(sk);
+	printk("hd: %s, hcd: %s, hko: %p, hcko: %p\n", hdev->dev.kobj.name, 
+			hcon->dev.kobj.name, &hdev->dev.kobj, &hcon->dev.kobj);
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
+	if (err)
+		hci_dev_put(hdev);
 	return err;
 }
 
@@ -438,12 +442,13 @@ static void __sco_sock_close(struct sock *sk)
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

