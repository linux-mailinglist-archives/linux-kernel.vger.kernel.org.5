Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84C7F55C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKWBOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjKWBOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:14:37 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C777110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:14:44 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c1f17f0198so335976a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702084; x=1701306884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXh9W9O+Mjaeo+XurpSXoauMKBLLtCqmM40Dz+c/UW8=;
        b=C73cPZ914Sz1WnqsFyO5y9ACY1GD5YYY5pqcr/yjz1s4L8q2/9w73N9SL6ggrpzr9+
         aICbftcKkXJ0LvxKHW5FpYl+QkCOghXK0WFz0eyGoZ4XnHvLw/WC4Ioqw7daAwM1PL6D
         ej0r1FS8gtKoR1dKU28RDzD7QfiLhSOrdplwW7Azd0WjiLLxVVE+GWK+X2ZZsZ2e/CbA
         Da4W1WQuKFyPKg0MtyR70qee7G5qUKUIqSmlc9nzBtkTfU2uc8kl7pCI0sOxxrkehtFc
         9qi/I+2O02GIHVBFxTeHrUBodbmzVD54lvG4KFmP6T09jzp46iHB71OeBq5cKl49+9uY
         rfIQ==
X-Gm-Message-State: AOJu0YwI2pLUMFDejE7ldQDlv8VSsgNIClHkXoMEUv7MIRZCb6IjcA0Z
        9liNSwB6UHPGJiWkyW4qt3xu+syYnUDrvy2XPREvpm2qVYhAfvk=
X-Google-Smtp-Source: AGHT+IFgu5oKhYKILDf1X+7MEsuI2il6UVdcl4X4MH307qrpcDV5szxG7SScBF9pyFfE0j/28nCS2W1Euh/L+YiG09ruN79UF+2X
MIME-Version: 1.0
X-Received: by 2002:a63:d84c:0:b0:5bd:d60d:f60e with SMTP id
 k12-20020a63d84c000000b005bdd60df60emr744493pgj.8.1700702083979; Wed, 22 Nov
 2023 17:14:43 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:14:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095a19e060ac78ff3@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
From:   syzbot <syzbot+60bfed6b415fbd1fbb87@syzkaller.appspotmail.com>
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

Subject: [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock
Author: eadavis@qq.com

please test uaf in __lock_sock

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c736186aba26..692727831dde 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -443,6 +443,7 @@ static void __sco_sock_close(struct sock *sk)
 			sco_conn_lock(sco_pi(sk)->conn);
 			hci_conn_drop(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
+			sco_pi(sk)->conn->sk = NULL;
 			sco_conn_unlock(sco_pi(sk)->conn);
 		} else
 			sco_chan_del(sk, ECONNRESET);

