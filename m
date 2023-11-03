Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6487DFEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjKCFNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKCFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:13:13 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02601A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:13:10 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce26d7fd45so2241873a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698988390; x=1699593190;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zugy3IDDgeRlb0v5bIoZfiAc9gsj8TR/I26tgiorg+4=;
        b=K1wI9jlA4lcBPJZzzBpUiEtcgO2J+vAzN7U4swfv8QDjh6wlx9pblZqjjymvji01U/
         pW3sTJT/HJT3gLfRap35YhB9DpFxrIUQGn2GANlxaI92k52VXC8Z3p7jnuN4Mr1vOe28
         R2EoJppWhGlRH88CUUoz+lMbwDJacUzu9F6cVh2rQG/2hL52cNq33jfzrp4SOHFWV3bY
         pV86bn8lXfytjNGqp95XlENhQvSGuhETiLklM6V29OFiS15siaDKmFv9aIRoVUe1QALK
         b9kRcpzSowrGYqTZ1SVITZPnZmd3ZPqJeziTiWLXyVSmcDFiROBtlk+ONcWa/gqpMEtB
         miKg==
X-Gm-Message-State: AOJu0YxKJG2uvkf57wMFeIRD01agJPQpmY0NNeqxZB2T+PGa6pH0LiWX
        z0GGNblkjpUswLcOTXkVvC0xhI2/E5Dhm7RG7kzB/mtdJaejWKE=
X-Google-Smtp-Source: AGHT+IG4dTVEO6otlqdfeamhlMipdtwVAR2KeQKtgzUTjaVUqRuOq4O85fBhaqU8t+W3i1aAsZmy/0ltFCZ25YERIPDYTteuJ7Ul
MIME-Version: 1.0
X-Received: by 2002:a9d:4717:0:b0:6be:ed66:5ab0 with SMTP id
 a23-20020a9d4717000000b006beed665ab0mr5924885otf.6.1698988390243; Thu, 02 Nov
 2023 22:13:10 -0700 (PDT)
Date:   Thu, 02 Nov 2023 22:13:10 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a64240609388fe1@google.com>
Subject: Re: [syzbot] test uaf in hci_conn_drop
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 15b33579007c..3237ad0d0645 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,6 +6,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static void sco_set_hci_cnn_null(struct hci_conn * conn);
+
 static const struct class bt_class = {
 	.name = "bluetooth",
 };
@@ -13,6 +15,7 @@ static const struct class bt_class = {
 static void bt_link_release(struct device *dev)
 {
 	struct hci_conn *conn = to_hci_conn(dev);
+	sco_set_hci_cnn_null(conn);
 	kfree(conn);
 }
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..858de967ffd3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,12 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void sco_set_hci_cnn_null(struct hci_conn * conn)
+{
+	struct sco_conn * scn = container_of(conn, struct sco_conn, hci_conn);
+	scn->hci_conn = NULL;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
