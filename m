Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564127C6C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378307AbjJLLOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378224AbjJLLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:14:31 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BCBDD;
        Thu, 12 Oct 2023 04:14:28 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so128871566b.1;
        Thu, 12 Oct 2023 04:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109267; x=1697714067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1QRKkBNjznWASHX/P+4TGpYOnsgJ03ZF7D0qhU3Ymk=;
        b=pP8HlnKKEK/M/MIq+84yYjMlm7nOvq2rhye0tdAqnvsQKsfeu+dbvcVr6XqNFtKUOY
         HXLNBxxLByqLHbUP8QyZoP78htZ1Y8gKJNpfV6tYlmCpv7OXFmXPbEtbdsLVH+G91nHU
         rkibZhqFlh1JsxA59mPGzYx/GDEj/wxwu5Qw5AyWclVDL0i9g4as3gYcsgs3dj4+8SMb
         K2brRJlOfZSv6lKEYOXB4ygtKeRU0FeV+HVnylnF/hGI4JzKTO9gA6F+Tyv2HUOqogvA
         kokIoWg5Mblqt4pr46LQXVsGg5iWMmOVmwJaTsblM/Zt0bwJGyeXTJ1NpljpsWc9X47B
         lo/g==
X-Gm-Message-State: AOJu0YzlUExwGkeUlsdAdJ42ma0R8/ttI2G9fLVsgA9XpBARK6xVga4u
        FoBtstRCBqS+sDDAlcwuHFMeHpU6L5Q=
X-Google-Smtp-Source: AGHT+IE6EJzJraUNfN+/pBxQYEj//JSGY9N0njx3Bqynro9CdqWEMRRS5z9eXQ+Y8KogH5ckF0OvRQ==
X-Received: by 2002:a17:907:2cef:b0:9ae:6355:5ef4 with SMTP id hz15-20020a1709072cef00b009ae63555ef4mr20608927ejc.3.1697109267064;
        Thu, 12 Oct 2023 04:14:27 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id kf24-20020a17090776d800b009b95787eb6dsm10877644ejc.48.2023.10.12.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:14:26 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com, Eric Dumazet <edumazet@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH net-next v4 4/4] Documentation: netconsole: add support for cmdline targets
Date:   Thu, 12 Oct 2023 04:14:01 -0700
Message-Id: <20231012111401.333798-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012111401.333798-1-leitao@debian.org>
References: <20231012111401.333798-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

