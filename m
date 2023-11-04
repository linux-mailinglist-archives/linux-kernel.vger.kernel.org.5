Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185B17E0D78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKDDXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKDDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:23:30 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B687D50
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:23:28 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d32824db9eso3046841a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699068207; x=1699673007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m2flpIZjOlZWnRS65RMek7OuTVloj24wmR6QWeXUzA=;
        b=IV8+2uOUfHYvRrsNte2zINX7Qli7AyUXjdxsgavRtcwe+Hsc/NoSSt4DP9QIPNh84j
         uuYXn8J+5jA8Bv2bF76uKHBlE0MYWVwaRomc2Zi22hGI/TDkHeV31crSw3MXyeuwnyWA
         7ecn/bidotUzpqVaYUxadyqgrtzGe6emFSlCjdJsdLiD9FBVy0gzz7NSXnMecthjt4gz
         2ZznZPEgkOZjwB+Rrj1JRlrY83b3xZmH5AT0fHNC5JkGSwQX8BIReejxA4O5EC0amE4U
         ZLf6vgjEd6CorrhmlVQcXVEeiM/0p+rs504YD3/sVYql46WkVglkTp2C82XBm2USH7Tx
         2XlA==
X-Gm-Message-State: AOJu0YyrIiuO01K21I4zxRaxqMthg9CuNSts9hxRTo1tz7a0MIYeHnk6
        EieFKAbBbSznDwogVhcD13cZj/q1gqHgnntgCps5pYdmW0V59Os=
X-Google-Smtp-Source: AGHT+IHmP6V6wWBK5wSy/lO+yGG2gbLSqDYoiztwF7vjA78DHjb5aq7EqKIWFgCL6wyhjnt8jaSzb1hh9z1omqbVBNTa94fv8AHa
MIME-Version: 1.0
X-Received: by 2002:a9d:62d5:0:b0:6ba:8e4a:8e62 with SMTP id
 z21-20020a9d62d5000000b006ba8e4a8e62mr7172155otk.7.1699068207796; Fri, 03 Nov
 2023 20:23:27 -0700 (PDT)
Date:   Fri, 03 Nov 2023 20:23:27 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f99c4606094b240c@google.com>
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
index 15b33579007c..f593a9f39aa9 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -6,6 +6,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+static void sco_set_hci_cnn_null(struct hci_conn *conn);
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
index c736186aba26..0a6404ba8e4b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,14 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static void sco_set_hci_cnn_null(struct hci_conn *conn)
+{
+	struct sco_conn *scn = container_of(conn, struct sco_conn, hcon);
+	sco_conn_lock(scn);
+	scn->hcon = NULL;
+	sco_conn_unlock(scn);
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
