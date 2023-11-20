Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1697F0F25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjKTJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjKTJdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:33:50 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56E98
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:33:47 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c1f17f0198so3887728a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700472827; x=1701077627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGapxB8OZnsaby1fpok/LrYkCyEoPx5NPA4MAwCS2Ic=;
        b=p0fzrZp/3ZGL1R2TBwHMJIXiz9m1zMOFqVocq2H2S/8OByxEGMXn0a2sEuipbDMR/3
         Z2YTmIBSzOUUqW2ICsrKi2UNVM7TdPjqjfpqBe72CNo6L/ErK3LEz/pEoEnwWza92HBv
         KatI574NNFjnE7YMvwXV/UjnU9iULDwU2iyRJfOsomfHDKLz6Kfy/MIlBzlqLiVBp9hD
         oyoTMDIrploXaijw0fDc3Flx/ohdsVOWcLerzrhU8Q0TCXeuflf9HfoQEfRZ3Orb3P4a
         iRnI0h4368pMyM8lDicmDtIipiFdwaYviDsiPFsHDFcuK05G90YwT9xrdvk0r6e3b0HN
         2bpw==
X-Gm-Message-State: AOJu0YyLiYJoi+DoWIz7rBMIpUWcD5A1QuVdkAnEPZbhillduzwD0ZKw
        Nbh/mcKoFFaPqXa+mU8z5PR+g/AHF593Lzn0vxwge5x7Dxn7zk8=
X-Google-Smtp-Source: AGHT+IFlAqakaypFfCulYQu+yZHeBFDQj3GxEH71IUylAvB1sN9q6wzlV7+zRZQzlMFEySdxDx/EvGJILWGTZwTNT6IZrteFT4za
MIME-Version: 1.0
X-Received: by 2002:a17:902:c40d:b0:1cc:449a:7f4d with SMTP id
 k13-20020a170902c40d00b001cc449a7f4dmr2354331plk.12.1700472827353; Mon, 20
 Nov 2023 01:33:47 -0800 (PST)
Date:   Mon, 20 Nov 2023 01:33:47 -0800
In-Reply-To: <00000000000075472b06007df4fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d32294060a922e91@google.com>
Subject: Re: [syzbot] Re: [syzbot] [nfc?] memory leak in skb_copy (2)
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

Subject: Re: [syzbot] [nfc?] memory leak in skb_copy (2)
Author: phind.uet@gmail.com


#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

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
+	bool running;
  };

  static int virtual_nci_open(struct nci_dev *ndev)
  {
+	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
+
+	vdev->running = true;
  	return 0;
  }

  static int virtual_nci_close(struct nci_dev *ndev)
  {
  	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
-
  	mutex_lock(&vdev->mtx);
  	kfree_skb(vdev->send_buff);
  	vdev->send_buff = NULL;
+	vdev->running = false;
  	mutex_unlock(&vdev->mtx);

  	return 0;
@@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, 
struct sk_buff *skb)
  	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);

  	mutex_lock(&vdev->mtx);
-	if (vdev->send_buff) {
+	if (vdev->send_buff || !vdev->running) {
  		mutex_unlock(&vdev->mtx);
  		kfree_skb(skb);
  		return -1;
