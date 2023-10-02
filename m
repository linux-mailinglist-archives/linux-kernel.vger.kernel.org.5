Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF77B57A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbjJBP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbjJBPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:54 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2740D7;
        Mon,  2 Oct 2023 08:55:43 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so16121024f8f.2;
        Mon, 02 Oct 2023 08:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262142; x=1696866942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qeLc5XrOrdKAgQ/hYZGbkV5o1+THk+DVcDdslRirRs=;
        b=sThS+KoMhoVPhLbQBjB+90FGaBixvEviv93n/T/SSzm/bIZhe/T1dXQgXHHJHM4dw8
         J7O6GKLmIKfTtcH6XFNJlBQ2CXcCwNZ9FBhBH7/IBqwNd40HX0/rXmtWhhl3RZMGvFD5
         C8hv9rYdqLPY5LFkqYa5kLcTpLuvgaGthzs6KypjhPm8zr1mQqKuwf094CM4pUUTxKGe
         gwb/YY8PWLIPV8xJy7I8Uv4p7EeCKUdF0y/gHjnqJbwVApgqGu+I1l5rl6nT7JFJOaqp
         OlVbFVpL2HUNoioGJwbPLPruE6Bfz4lxivdnD5bTAVPVGBVnmfnHiqTpLWe3+TsHN2Eq
         Fxzg==
X-Gm-Message-State: AOJu0YwA0fHurVBJvWqywiZ9lYjcGc1RbgmD+AUY555iDZDQH0CJd2/+
        1NMcZVe1JEEHAnxwz/1Smfw=
X-Google-Smtp-Source: AGHT+IElr8isCQxA77cREJ8dEkc1vgGlgie+whLG6+nuVdHqPbgUppOA/S2iuV/DdyjLs1cV1u9bNA==
X-Received: by 2002:adf:fd10:0:b0:317:69d2:35be with SMTP id e16-20020adffd10000000b0031769d235bemr10430834wrr.30.1696262141860;
        Mon, 02 Oct 2023 08:55:41 -0700 (PDT)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id ec20-20020a0564020d5400b005346a263bb1sm9430244edb.63.2023.10.02.08.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:55:41 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 3/3] Documentation: netconsole: add support for cmdline targets
Date:   Mon,  2 Oct 2023 08:53:49 -0700
Message-Id: <20231002155349.2032826-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002155349.2032826-1-leitao@debian.org>
References: <20231002155349.2032826-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patches, there is no more limitation at modifying the
targets created at boot time (or module load time).

Document the way on how to create the configfs directories to be able to
modify these netconsole targets.

The design discussion about this topic could be found at:
https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 7a9de0568e84..b25c89608e50 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -99,9 +99,6 @@ Dynamic reconfiguration:
 Dynamic reconfigurability is a useful addition to netconsole that enables
 remote logging targets to be dynamically added, removed, or have their
 parameters reconfigured at runtime from a configfs-based userspace interface.
-[ Note that the parameters of netconsole targets that were specified/created
-from the boot/module option are not exposed via this interface, and hence
-cannot be modified dynamically. ]
 
 To include this feature, select CONFIG_NETCONSOLE_DYNAMIC when building the
 netconsole module (or kernel, if netconsole is built-in).
@@ -155,6 +152,24 @@ You can also update the local interface dynamically. This is especially
 useful if you want to use interfaces that have newly come up (and may not
 have existed when netconsole was loaded / initialized).
 
+You can control and modify the targets defined at boot time (or module load
+time) by creating special targets names. These special targets are named
+`cmdline` concatenated to an integer, example: `cmdline0`.
+
+Let's suppose you have two netconsole targets defined at boot time::
+
+ netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc;4444@10.0.0.1/eth1,9353@10.0.0.3/12:34:56:78:9a:bc
+
+You can modify these targets in runtime by creating the following targets::
+
+ mkdir cmdline0
+ cat cmdline0/remote_ip
+ 10.0.0.2
+
+ mkdir cmdline1
+ cat cmdline1/remote_ip
+ 10.0.0.3
+
 Extended console:
 =================
 
-- 
2.34.1

