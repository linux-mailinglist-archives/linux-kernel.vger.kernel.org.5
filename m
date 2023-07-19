Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE01A759086
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGSIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGSIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:44:24 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D0FC;
        Wed, 19 Jul 2023 01:44:23 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so6835379f8f.1;
        Wed, 19 Jul 2023 01:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689756261; x=1692348261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT28KMZUfUxLqE36E2WVSHWEOsxWuK8+5KaakQzM+v8=;
        b=YavyBslqvgKfg5jrXB9gxeGsyVgB0y+5VsNNTX6tuEtyQjcs65B8nSLzVMEcagYrGa
         qWl2HN7tsYelNJvf11eBF5ZFv/a6K2Oe343QEZLK9e27sISimxKq/FAL9ZljQiNn3GJh
         b6N9+moZWqXRQcahaNbCO2eby3Jc4yoE/qX+9dVedoqiOU8iD/nHsnu6f8CWVp4F5zp2
         NxPY8nDKVuwVZiVcFUW4lHvi5LvRZaTcGs0SmoWkI4X0ACH5CJXi+R1Dpyhmrcj++hiP
         mW8HN4Gj0LkPngQQMdCucaAMRXZLuCfkuk35mtio7lM1sR0Hs2HVFmXKHXz4g/Ogh5uJ
         PZcQ==
X-Gm-Message-State: ABy/qLaq9cRLwxMkJvIX6RZdK7VRDSDVRV7MC4aGs8d12CaZp237+JHW
        LdSh6arwDGkAyfyTKMW2N8o=
X-Google-Smtp-Source: APBJJlF/ywwhKzxGBt1Io0V8KucgEnzbjqfPGnb6QDESp3ONMvIdSj92bog0DWa1BNuxba/gvMaUjA==
X-Received: by 2002:adf:ee43:0:b0:314:39d0:26f6 with SMTP id w3-20020adfee43000000b0031439d026f6mr14656317wro.18.1689756261248;
        Wed, 19 Jul 2023 01:44:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id k28-20020a5d525c000000b0030ada01ca78sm4688105wrc.10.2023.07.19.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:44:20 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     leit@meta.com, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: Use _K_SS_MAXSIZE instead of absolute value
Date:   Wed, 19 Jul 2023 01:44:12 -0700
Message-Id: <20230719084415.1378696-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at sk_getsockopt function, it is unclear why 128 is a magical
number.

Use the proper macro, so it becomes clear to understand what the value
mean, and get a reference where it is coming from (user-exported API).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9370fd50aa2c..58b6f00197d6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1815,7 +1815,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_PEERNAME:
 	{
-		char address[128];
+		char address[_K_SS_MAXSIZE];
 
 		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
 		if (lv < 0)
-- 
2.34.1

