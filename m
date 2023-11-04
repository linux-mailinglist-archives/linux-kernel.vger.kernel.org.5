Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2FE7E0DFC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378485AbjKDFkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjKDFkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:40:17 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E491BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:40:14 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f057511202so3021507fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 22:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699076413; x=1699681213;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4kNOcyHdV955YB9rpzxaShUU/1YajJBJ7oMLhtpVRI=;
        b=RES68EXyTC8EsJoSuuSzdPyD66ajwXkdoc7jW6m/EZnSM7QqRBJgxK//81rwhfVL0L
         lJkUMlkfMDDPeewHBx8H4ySXMhuuq99EJejdC88ty+NQdZh20b5i5FMsYGt6IBUFCxw7
         GuI0xD5UllEOjBp17F1QberdnOtvN0vwy9WbS5TWwVWD7Dt1gnXfD4QeWWOvKwXRlDek
         MrTBY2E8/9PHIScjS/bCJ9Et2sT8EG+zC0wWMgJI7aD1psfGaudNuYrvPhbLrr4t8UPS
         YTEfszpVQuB+v8nVQYUf93Cwe3tMoD2PNVqMu426bGKTJpzrEG6XgbUBdUXnsbUpszrM
         h/Ug==
X-Gm-Message-State: AOJu0Yw2mzCIVYYqk9Au3NGFrjKxzGebYFJafSshuwB0vluuOrvNevlE
        uVC/AEGYkPFTo+92oOZ/5moPUyNXCPc527qho8RrfUm05b9RdU4=
X-Google-Smtp-Source: AGHT+IHm28217lx1XJZ71KN/MdD3I6CVpY+1vRR4/L/1HmOTccAWP2TQ/8xYrbOCjgydCujhYuVnXNfg749SNSLRiunNia6hlz7E
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a4:b0:1e9:a128:7f1b with SMTP id
 m36-20020a05687005a400b001e9a1287f1bmr11300350oap.6.1699076413645; Fri, 03
 Nov 2023 22:40:13 -0700 (PDT)
Date:   Fri, 03 Nov 2023 22:40:13 -0700
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014e8ca06094d0ee2@google.com>
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
index 9d5057cef30a..efcf8a560d6f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1702,6 +1702,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		hci_conn_drop(sco);
 		return ERR_PTR(-ENOLINK);
 	}
+	hci_conn_get(sco);
 
 	sco->setting = setting;
 	sco->codec = *codec;
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
