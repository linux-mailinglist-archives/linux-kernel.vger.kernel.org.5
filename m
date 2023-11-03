Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814307E0167
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjKCIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346321AbjKCIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:00:25 -0400
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A351B9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:00:20 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-581ff5ab8d3so3197377eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998420; x=1699603220;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6unM5Rn/Esy3F8e84NMMUazz2kionOwhqHex2k2Mn50=;
        b=Umc4uuJ42ohzkFsuge/bP+LjiL7/TQgKPSAhhHdS5yNsE/0bBzWGozkwMy95xjvN4s
         KvHnMxJpDy8m4+Qps3YRH1G8lFGqd7v5k8FB6BUN1cUjpfaZhsX4PeSKhqHIjvVCNmcZ
         Z+qgXv1fxMk6G5p3IWTUo9EChEGaodhhiNknV5wb++aCjg0XdnTTbTVvpIcXZyZxzTvn
         ZjVTeklip3OAlKrkzZh8PV064tTgCbpusTd08er0lG5do6/vTxrRT0pfz22VbTdLbPxZ
         KeyWBkiKYQAUQJlUilNBiHzjMRRMcz81GRqxQdn6+eJd/kFa9cWALUI+lDCLSHW0ARTm
         Ae2w==
X-Gm-Message-State: AOJu0YzmFUnBrIn+ugvRcVF7/NYBIpgfJVqIXONGUwmIAMtK6o5uRpNj
        XahF5qY9N32p+97J9k4uKRnmN2pZ627L1GQOwPsSZQ6wl99pp8Q=
X-Google-Smtp-Source: AGHT+IFFu9kbwDg1GaGEUxom+swhnKaZMXDH4bfNOpqze3Vua6SDebSPqy97tf84XOS5QTli3fQ5np+e5rUs6Pl/XxfheKo94ks1
MIME-Version: 1.0
X-Received: by 2002:a05:6871:647:b0:1e9:e1dd:b953 with SMTP id
 x7-20020a056871064700b001e9e1ddb953mr1159868oan.1.1698998420125; Fri, 03 Nov
 2023 01:00:20 -0700 (PDT)
Date:   Fri, 03 Nov 2023 01:00:20 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e402d06093ae54a@google.com>
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

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 15b33579007c..3c6592da21c4 100644
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
index c736186aba26..6c3b1ee78ba8 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,12 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void sco_set_hci_cnn_null(struct hci_conn * conn)
+{
+	struct sco_conn * scn = container_of(conn, struct sco_conn, hcon);
+	scn->hcon = NULL;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
