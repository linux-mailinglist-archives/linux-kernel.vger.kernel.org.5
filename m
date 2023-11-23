Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5EB7F5644
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbjKWCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKWCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:06:17 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F2AA3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:06:23 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1ccdf149e60so4020265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700705183; x=1701309983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4amVbv3Q09Okt69QNEidmRw6msqxlnAWNcQv8Svc/2E=;
        b=kjzbEGgrezsQeVOgfV+1ZiEfBs6Mw7cKXg4+MWKIlFMpAk98vWMpGQ0nR3cK2Kl422
         zn1XOZna95PeJwXbOFaNeTEETSqZhkmdIFdSoxF1O0OwLo6UolU2rZOa4GkBT5IuT0EQ
         +JM09V0cgM+nqSw83XN14XXHJ4MbPNZ0ZHoZRZ4d2MxqkyXzm420USH11widrImXquFl
         c4hT/C4zQftNR4NlA3fRoqKXMZ+IfZOj2o7YWsI/qN7y63ZDmaKRXrrioWW+YIOxkYCJ
         ddHq6VpEY5l1QurSri2OKPmZWOkjrFYhfquBS6GgOw0d7DQ4Vp2Czroths5SQpzz5bc4
         Po+A==
X-Gm-Message-State: AOJu0YyyBzpQE02N23vjrjxj7Gn22KGOIr3tRWWW07LneH54cFNCwddU
        kWc53aobBAsTaWeUkcPKLDqgLi738tbkhOVezSC7BDZTKDptllY=
X-Google-Smtp-Source: AGHT+IFBeQUymVU8ZfXPZ8tI0pBKrUTOZ+HTapAbaNgBGY2fKEiRYynqmX351tQ8H5SYT1J+bGrsgyWdOuxuvvX5HXVz5n5k/1Rp
MIME-Version: 1.0
X-Received: by 2002:a17:902:ced1:b0:1cf:6910:3b8c with SMTP id
 d17-20020a170902ced100b001cf69103b8cmr1014626plg.8.1700705183518; Wed, 22 Nov
 2023 18:06:23 -0800 (PST)
Date:   Wed, 22 Nov 2023 18:06:23 -0800
In-Reply-To: <0000000000007b84a2060ac7d84b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054dd20060ac84858@google.com>
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
index c736186aba26..82e50c215386 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -270,6 +270,7 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	hci_conn_get(hcon);
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
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

