Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D267E6AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjKIMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjKIMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:34:19 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723142590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:34:17 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b9344d72bbso758793a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 04:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533257; x=1700138057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HhaSxWu21hGNz9s5J/8Dd4BOliW177+Rgx2bPMgNKg=;
        b=em6pYQkzIuCbvuHNE9m34IZCAFDonOf7gC7rs7XzCfq8AEXlU+DkbcUm4C+kJHPRtm
         mDIqvEMPFYsTLfLGtmnIIm3Q4GeyCrxKU/xCjtWDXdbWhyj6fMlEMtFhPb+kTasHOx2I
         i2yht9sy3YEqONqtx8Vypzm+8MX2gVEy6GiTJmZrep4HG1L5d7RXmu7ku98knQOgMhCC
         iMDmVNvZUOCwUCogPtm94GiOWiMuPMnW1ax7RmZxvzf5KFM6dPTYguOaQAoujCQHbnpV
         am+XJoCGNU1Gh8AD3gYDhfREIUcW8CMD+XmfeFQadcchONryeF9kty31EttJn/k/SvE8
         D7dg==
X-Gm-Message-State: AOJu0YxvXDZVOiFEo+beQMEMl4qHcGfSZVsqcHRTwwmKflXOW2oW1jqq
        QC08/1ML2h5f78AmIIp4JK80IJDO92Au7lOZ/5ihqcaWqeRINvU=
X-Google-Smtp-Source: AGHT+IHGO79mTJKhnpg6/eJGD87DXVCRNooMHYCRAgAKwv21e447vZpecey618njNqG7jwHlIXEAqx/ymUbpznXOsBqw4XyKMXso
MIME-Version: 1.0
X-Received: by 2002:a63:fc0e:0:b0:5b9:63f2:e4cc with SMTP id
 j14-20020a63fc0e000000b005b963f2e4ccmr343589pgi.2.1699533257000; Thu, 09 Nov
 2023 04:34:17 -0800 (PST)
Date:   Thu, 09 Nov 2023 04:34:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001150ff0609b76c4b@google.com>
Subject: [syzbot] [PATCH] Test for aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for aea6bf908d73
Author: eadavis@qq.com

please test uaf in nfc_alloc_send_skb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..b463452c507e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -30,6 +30,7 @@
 #include <net/nfc/nci.h>
 #include <net/nfc/nci_core.h>
 #include <linux/nfc.h>
+#include "../llcp.h"
 
 struct core_conn_create_data {
 	int length;
@@ -1206,6 +1207,9 @@ EXPORT_SYMBOL(nci_allocate_device);
  */
 void nci_free_device(struct nci_dev *ndev)
 {
+	struct nfc_llcp_sock *nls = container_of(ndev->nfc_dev, 
+			struct nfc_llcp_sock, dev);
+	nls->local = NULL;
 	nfc_free_device(ndev->nfc_dev);
 	nci_hci_deallocate(ndev);
 	kfree(ndev);

