Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F07E0060
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKCHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjKCHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:01:18 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6AEDC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:01:16 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2ef9e4c25so2445179b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698994875; x=1699599675;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Pf6X/QVoDCrIJC1ccvbr45vXSIfEd20y+c6StlXz1w=;
        b=n0lw5XefsWcfCp/6H0rxv5hxwitdJJFDDOInxo8n6m3gm86wuk2gViJOAmUdFrMTCc
         8ih6aexYvo+yndLcvqkdsX/90XmRgDubaoYlBe0RzlCkViBvLnAgoCwSnjSREn1IHe8n
         3H43C/ysmYY2kRuOCd15bcRcH9433858Or7yOj21YYPz/y1ebFiJr7WrjyIXbPPw1tNM
         64oIGKkr8kHDi2vArnjByTDEUT2xA/Ww7yDWy2giURG0E26OM+dmgwTXgEvjkd1SzsaS
         0tGA35gVc5E4tZEklTgTfz5kXrp5rUR1zsIu8PfY9SIyHRdbfTaIpjgxL/GgVMFKNcP5
         oJgQ==
X-Gm-Message-State: AOJu0YwyGVRn0q7hYPDnXOt8zu9XGSNiXW0JBdPhHaj3MM6Q7TYHFDJZ
        WtDLZ3ryaz5cWFCss/bYgDMY13ykzEomlY7MzyyaBwq57Q7tuuY=
X-Google-Smtp-Source: AGHT+IHa1DPZy1PMgyo4iXBSletROadM3KULEP9PbbX157X5RHc312yETKff3zaX6wITG4ZWN433/L9Exh0gGAxQl3VMnG4IA4VB
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a2cf:b0:1e1:2f43:1dc6 with SMTP id
 w15-20020a056870a2cf00b001e12f431dc6mr9970572oak.1.1698994875789; Fri, 03 Nov
 2023 00:01:15 -0700 (PDT)
Date:   Fri, 03 Nov 2023 00:01:15 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bf71206093a1245@google.com>
Subject: Re: [syzbot] test uaf in hci_conn_drop
From:   syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index c736186aba26..739956cfc26b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,12 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void sco_set_hci_cnn_null(struct hci_conn * conn)
+{
+	struct sco_conn * scn = container_of(conn, struct sco_conn, hcon);
+	scn->hci_conn = NULL;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
