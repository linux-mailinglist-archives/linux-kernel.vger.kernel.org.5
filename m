Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9947F0F44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKTJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjKTJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:20:42 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D79BC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:20:33 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bd0c909c50so4517215a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700472033; x=1701076833;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym2xuxXA8MwY0p+CrJUJLW6Umc2bHUQ3jLUY+ozaSwE=;
        b=PBZWqtIF1rfVItZpbiL0m18IMlWHIMjTUDOO7yuNTYL8LZxrHND14AVhwS5WAZhWYM
         xKymVshY2RgkAO3kODZBs/Ul2bFfmHkWk7uSxZVL4eisUOJgxmgG8x4AnVPYGy8IazUC
         P10VgD9hqtIiV6EkTPGcbS4t/mFRu6snVBgtjNkScSPxoq8LjFcvOpMAJtl7W5iGjmj4
         OcBRA2oJkY54xA8h0q02HRMEFFhSx8zE/fRs+JxIjuu+CisdfP5gPZIBKt1o/bUBJDrE
         PtJ7UAFoPSVjl+BcpyDga4DAduPjpOm99BnVHbFNcukA6DU5QlmpQCmJSUw9oL8TMWcj
         rPdw==
X-Gm-Message-State: AOJu0YxzrQfxipfNuV5eVAyAC7K3lDMoOcQWWEYJViJNua7vrLRee8A+
        B09bLjFwrLqHTXN/FmhtC9Ci8tYlAHr5G1pKjK3xdCy0rZML9Wc=
X-Google-Smtp-Source: AGHT+IFOA3aD2drB7icpl8F3bBwbPgi9+E2OewEQIz0qGE7jDdbMKm4MSuOwzaVt7IY9QEjeOfCjDvfg7hX7lczdNrk+cPzPTleE
MIME-Version: 1.0
X-Received: by 2002:a17:903:2346:b0:1cc:47d4:4936 with SMTP id
 c6-20020a170903234600b001cc47d44936mr1993658plh.1.1700472033290; Mon, 20 Nov
 2023 01:20:33 -0800 (PST)
Date:   Mon, 20 Nov 2023 01:20:33 -0800
In-Reply-To: <00000000000075472b06007df4fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007eb04f060a91ffad@google.com>
Subject: Re: [syzbot] Private message regarding: [syzbot] [nfc?] memory leak
 in skb_copy (2)
From:   syzbot <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Private message regarding: [syzbot] [nfc?] memory leak in skb_copy (2)
Author: phind.uet@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 master
diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b027be0b0b6f..ac8226db54e2 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -20,26 +20,31 @@
                                 NFC_PROTO_ISO14443_MASK | \
                                 NFC_PROTO_ISO14443_B_MASK | \
                                 NFC_PROTO_ISO15693_MASK)
+#define NCIDEV_RUNNING 0

 struct virtual_nci_dev {
        struct nci_dev *ndev;
        struct mutex mtx;
        struct sk_buff *send_buff;
        struct wait_queue_head wq;
+       bool running;
 };

 static int virtual_nci_open(struct nci_dev *ndev)
 {
+       struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
+
+       vdev->running = true;
        return 0;
 }

 static int virtual_nci_close(struct nci_dev *ndev)
 {
        struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
-
        mutex_lock(&vdev->mtx);
        kfree_skb(vdev->send_buff);
        vdev->send_buff = NULL;
+       vdev->running = false;
        mutex_unlock(&vdev->mtx);

        return 0;
@@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct 
sk_buff *skb)
        struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);

        mutex_lock(&vdev->mtx);
-       if (vdev->send_buff) {
+       if (vdev->send_buff || !vdev->running) {
                mutex_unlock(&vdev->mtx);
                kfree_skb(skb);
                return -1;
