Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F07DFDA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377573AbjKCBBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346177AbjKCBBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:01:50 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ECE1AE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:01:47 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b3fb625e3bso2142562b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 18:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698973307; x=1699578107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA2fM7/Ped8FPHHfeCfmm5eV2QHQ/1024dXqhvX9LgM=;
        b=Z6KSOXmcQ0ZXcB0Y/CEBKLJch633BMgfzTYU92yVXO3eBI0qUATWnBe1B8x2L/rk6K
         dwq1weAfHtIW+gQSg6ee9Rw0900cvrH7wg3fk8Yd87rhht7GLRh/g5jgzxSMjC75XZSw
         WH23dZFAlkVYdW10RRt6MWtG/j1GIUt1NyFRzv1jmoMJxkwlFdYPFDaRAR4AhywEvv/R
         P397W5XJoHUc9jzJfpCtkygBjvJTwFKVl71+3KH92rmzIQKmypMiPRpm+bboYzzx2X9z
         qPdLZpPMpE+gK73rEkwahFhBml7CyUcC1JkJe5yYEfL8AglqKgAqa159qJBbSOHrN5VJ
         jUGg==
X-Gm-Message-State: AOJu0YyxrBNkPlNr6km6RK/ufOCi196pu6P6ChzE1p1hC6Fcbq2Lg+3w
        bZowCspFXB044TNmfgSo41KvzrukTj0f6Vi/Zd2vDvIOnvN0c9A=
X-Google-Smtp-Source: AGHT+IF0OzhjywtVzkXrm/axW8MQh+Zb2VWW3IpsQ5w8emYONjOQ5pr15uwTqUMhDwjfCb9gncRFC+YTelqqz36bbvXCkT9URh3U
MIME-Version: 1.0
X-Received: by 2002:a05:6808:209d:b0:3a1:f2a4:3d7 with SMTP id
 s29-20020a056808209d00b003a1f2a403d7mr8122412oiw.1.1698973307117; Thu, 02 Nov
 2023 18:01:47 -0700 (PDT)
Date:   Thu, 02 Nov 2023 18:01:47 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007429d00609350c40@google.com>
Subject: Re: [syzbot] test uaf in hci_conn_drop
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 15b33579007c..757ff04bb5d8 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -13,6 +13,8 @@ static const struct class bt_class = {
 static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
+	struct sco_conn *scn = container_of(conn, struct sco_conn, hci_conn);
+	scn->hci_conn = NULL;
 	kfree(conn);
 }
 
