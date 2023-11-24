Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCD17F72B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjKXL3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:29:17 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDEA10D7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:29:24 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cbb6ff734dso1871982b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825364; x=1701430164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbVjBFBegUBKRhGHJFhM5Hhz1L9HgxzrvisoXWZeyIk=;
        b=XauFtm50pRW7cNCtNjON/JknOUEOGkxjq4DbH20W3tiVbfobmEeDvfI6N/LdGH5iUG
         suFoYHBH1JTDtFjfPGYlt7SlCI6JTd53HcSeFW7IGfIyvtI/zr1lk5pXa14a3jXS9Lpu
         yv+Q8yDvK12BWM5ojGR/QfUuzhQPIBhZk08bqsWBKQUpOunTuXOHYqI+AEJGj5F5WRy+
         M2wDCBF1oYViiu53TCnyTWZptBGmw5vatYwHpc0FAj70qMkHyrMOk3DkyX5ojMjRgNg6
         0eElsxRU3VERYr6tHW8F8eiGEuPOabh+QtMyLpy+328fHwVR8DXu4NilihAf1NmAHPMN
         4sBQ==
X-Gm-Message-State: AOJu0YzQEgVvqauHLKADkUoWqEn+w8pCbC3Zt/soYU+PL3rZeg1mS18H
        KnROHYjDI3M43PO1Sz2bKDCF3OTYHVyjDIM/iOiT5vpBWpeUsms=
X-Google-Smtp-Source: AGHT+IGqYc+hpiEe5YkRmvSiFuoYQtFnxxanB+jobK+pboAqnj1ZQpzxmFYRf554n39JuLgMomqFNhs41KmqLxjCpk5fIMkPTH4i
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d8f:b0:6c3:9efc:6840 with SMTP id
 fb15-20020a056a002d8f00b006c39efc6840mr702921pfb.0.1700825363819; Fri, 24 Nov
 2023 03:29:23 -0800 (PST)
Date:   Fri, 24 Nov 2023 03:29:23 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2b6b9060ae4439a@google.com>
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
index c736186aba26..062ab9926146 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -270,6 +270,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
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

