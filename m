Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE67E0DD1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 05:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjKDErj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDErh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 00:47:37 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E2D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 21:47:34 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d31f885789so3161501a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 21:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699073254; x=1699678054;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C30cWoaVR5A5nrRI+hOREgRJ2LAt1Xl17w7gbHiM6/8=;
        b=gJ2U3lVykDoyieh9knGGzKblIkJzJUimqIrGTgcQdmo6h21W+DEKcKmisTXNIhdCz5
         /ohzub2asa6BeFp1Q7oeWodKvrSUDI1WQPtjAW577wHIpwpU8qZu4d846vMy8L68bwyO
         i/5x6H8BAuFi/tsuMXRMO/sxsk+yYHFBQod3LlAq0+l28XlLZQtyUqFs7E2YhqCY3EvI
         NoUHwnOTMv6uaLj54zuyW0Kls/wVWexZxa/kfbtfAfGL07h8sKeIuEizAEoJNDiqcLv1
         bXgbIDX3gXSGs1XyuaDcLoOGLxqHXBTPyYdviMtu1Kc2sjgkk+IRXMBs6Otd4+EDjhp8
         b9YA==
X-Gm-Message-State: AOJu0YzpZFV7ebTWyU7/36lCmobF1P5RHNzM2JyfiU6KX0EmJ2puxTvY
        nBx76wiPy0Y3mrzbRiFQfdSt3VJ1HTKK1L8Nskuox7+mcDHG5bs=
X-Google-Smtp-Source: AGHT+IFB6vTzYIGdbZSbeiYDeE85BHzA6QrnUVRgcaEi6cDSu0hz7y5ReFju1ZtFC80rzr35DLxNvz98S+dXM9AqZ67sIrKDmhuo
MIME-Version: 1.0
X-Received: by 2002:a9d:7746:0:b0:6bc:ac3d:2b77 with SMTP id
 t6-20020a9d7746000000b006bcac3d2b77mr1549194otl.2.1699073253985; Fri, 03 Nov
 2023 21:47:33 -0700 (PDT)
Date:   Fri, 03 Nov 2023 21:47:33 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0526e06094c5121@google.com>
Subject: Re: [syzbot] test uaf in hci_conn_drop
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
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

Subject: test uaf in hci_conn_drop
Author: lizhi.xu@windriver.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..bb02f1ca8cd0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1719,6 +1719,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 		hci_sco_setup(acl, 0x00);
 	}
+	hci_conn_get(sco);
 
 	return sco;
 }
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..5cba9cfff8ec 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -442,6 +442,7 @@ static void __sco_sock_close(struct sock *sk)
 			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
 			sco_conn_lock(sco_pi(sk)->conn);
 			hci_conn_drop(sco_pi(sk)->conn->hcon);
+			hci_conn_put(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 			sco_conn_unlock(sco_pi(sk)->conn);
 		} else
