Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22717B9EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjJEOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjJEOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E15A26A50;
        Thu,  5 Oct 2023 05:37:16 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2cee55056so174066266b.3;
        Thu, 05 Oct 2023 05:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509433; x=1697114233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1QRKkBNjznWASHX/P+4TGpYOnsgJ03ZF7D0qhU3Ymk=;
        b=THZhQKjBURgWFrHOguq0FKgavxdXtW620tLZcSdNpjWRChw9exBJYzQRfok/Ak9Wj9
         kn7JCff//bOBiALqTsFWDEyagWD0s3GJIQvtr7uYbNznitbeTEe1wJStwX96/TTuz6QJ
         r4gbdA3jI91SMZ9z8JHwgFToFQrfq7tAEYFDTrvFIw4bYVf8rlbJ8pjlxeV8wQffnX5X
         3SQG0jMmhHSoyvr9+Cp2it40DJPR/kWXoFEl/uJHCl2Lf1VfECgHIKWYXON+77gbZ03k
         YRSilmTofOfGykgwQVxKZp+3/7y2M51bXVe2k0XhI+B34sKyLFpHCSLpi49jbgRmIlTd
         44oQ==
X-Gm-Message-State: AOJu0Yy6fuD89YdQTndK7yXcQ8ASSqz9V7Bui/U1iBxWsn2ko50DKvdV
        YK1TLTo/zbW/OXvKdfypPZU=
X-Google-Smtp-Source: AGHT+IEFrhWzf73Qi+s9hSUvWpt+21JCI4T91oVdGuvxeB+YC2q1crDLgs/yjf+gkDjXUoiymGjgvQ==
X-Received: by 2002:a17:906:3051:b0:9a5:7759:19c0 with SMTP id d17-20020a170906305100b009a5775919c0mr4687111ejd.64.1696509432977;
        Thu, 05 Oct 2023 05:37:12 -0700 (PDT)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id e25-20020a1709062c1900b009adc77fe164sm1156979ejh.66.2023.10.05.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:37:12 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH net-next v2 3/3] Documentation: netconsole: add support for cmdline targets
Date:   Thu,  5 Oct 2023 05:36:36 -0700
Message-Id: <20231005123637.2685334-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005123637.2685334-1-leitao@debian.org>
References: <20231005123637.2685334-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 Documentation/networking/netconsole.rst | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 7a9de0568e84..390730a74332 100644
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
@@ -155,6 +152,25 @@ You can also update the local interface dynamically. This is especially
 useful if you want to use interfaces that have newly come up (and may not
 have existed when netconsole was loaded / initialized).
 
+Netconsole targets defined at boot time (or module load time) with the
+`netconsole=` param are assigned the name `cmdline<index>`.  For example, the
+first target in the parameter is named `cmdline0`.  You can control and modify
+these targets by creating configfs directories with the matching name.
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

