Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319A67A5BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjISICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:02:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D053114;
        Tue, 19 Sep 2023 01:02:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2767378ae15so1117206a91.1;
        Tue, 19 Sep 2023 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695110534; x=1695715334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnkum48/IhCb89iyYA5Sse0XApschq1dMT88JK5SabI=;
        b=SzpP7mc5pf8q325SdcUyv7eLy7SJELLrEF3wxwgF3W6NHDifguSdik5NZkKIiV+UrD
         P8SMcwcpFay1kONGFDgF91iwptNYL9HY1vmXeBwlpUZi6Xd2WAS03EPHzoUNhYHAqTkZ
         poDjuduGsQfoRXuEL3L6m9J6sbCjb5R7SPZzuU6l5miqkLNNFLNNe0D4Jiz4bzDbZkSH
         cEK6Clnte1kFvz8bZd6AEdArfm9yehOK3cVajx3tK22dhRYM6iyAsWktDXTIyjpCKtGi
         ZRbnZAXhUCbkvZRLOXA0HGqTWVX/WF0L6+NbLFqi8p3F3395rsrPUMGNtNIrZMCydgSy
         NQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695110534; x=1695715334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnkum48/IhCb89iyYA5Sse0XApschq1dMT88JK5SabI=;
        b=TWjSOOss7t4TNPJ9bEMHNso9dFCSRt5O05GqdwX07DSxUQ+Y5Vd127ucK9NIo4azTk
         tC7I10Vtb8EPOgHIFfYEoYqXVcpqmEcou9ICa0LhwJJOzBfRRGmPt66MChwuv/qv+Wyi
         bk/WjeM4q9AjPEP2D6itZ54TSQ/uYFC4BgxBVb6CJzzddtGfXRDBMDwvQ+mbpfMO0OWc
         qth2kxwAGUqXcY5DlJlofTSxPXvQ8NbsS8tPcHVNqqQzfON8tqvRZR2bZGe5SS1RyOnT
         knKhvMhhwLfxcU+0+YR3GN7kLluMXTb5iDb9LEQL0IEzbTPBnL4187jogeoTNV1vVeJH
         +GJw==
X-Gm-Message-State: AOJu0YxhvRJDkmv1dZSuLBvbHKbTUV/ZBASG+TbRzf3VvBWYFoqkTeiI
        xLYRxDjfcoi+71csI6Z2F1A=
X-Google-Smtp-Source: AGHT+IG33mFQGDzHGsPywCxRJVtcP8QtComo7I15mvnW/mCsvoKU6HLsQtjza7LFyyBu4bVAIngpZA==
X-Received: by 2002:a17:90a:6482:b0:26b:4ce1:9705 with SMTP id h2-20020a17090a648200b0026b4ce19705mr9160012pjj.38.1695110534024;
        Tue, 19 Sep 2023 01:02:14 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
        by smtp.gmail.com with ESMTPSA id mu13-20020a17090b388d00b0026596b8f33asm9899649pjb.40.2023.09.19.01.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:02:13 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     eadavis@sina.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] tty: fix memory leak in gsm_activate_mux
Date:   Tue, 19 Sep 2023 16:02:08 +0800
Message-ID: <20230919080207.3654671-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023091954-algebra-hastiness-3bb8@gregkh>
References: <2023091954-algebra-hastiness-3bb8@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the call to gsm_register_devices() fails, we need to reclaim the memory
requested in gsm_dlci_alloc().

Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
Reported-and-tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Signed-off-by: Edward AD <twuufnxlz@gmail.com>
---
 drivers/tty/n_gsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b3550ff9c494..df9bb87652b0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3136,8 +3136,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 		gsm->receive = gsm1_receive;
 
 	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
-	if (ret)
+	if (ret) {
+		gsm_dlci_free(&dlci->port);
 		return ret;
+	}
 
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
-- 
2.25.1

