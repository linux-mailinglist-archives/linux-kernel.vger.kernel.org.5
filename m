Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8035D7F5D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbjKWLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344907AbjKWLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:12:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075B1AE;
        Thu, 23 Nov 2023 03:13:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso1038744a12.1;
        Thu, 23 Nov 2023 03:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700737981; x=1701342781; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ETRJxI0jYA8eO15FtbRSONvqohxyMW+Q9fmUG4iFDY=;
        b=IEUGmk8vbD/lXdKN7pZDE9//YQNbs5F2SBAt9gb60LD6kAQ6YUwklv9ClN1r8N/Vsl
         qgsEFTPFvtWLWdkt9++MY6dNJczuQwpQKgO+VFNx8t4oMSLz4sL88FlsmERHG4Q2qRWT
         zCLPJ/m2DIpzNdV5PJx9G1MyxAHxNhGJ7fA9YVsGbfrqKZih06UB0C58+Q7rlczhDP1p
         w9eTzMIyi4zSEFGMU87O83mCCFpg4Kh+rvFOKUtoz/l94RjjiMwdmxjeSiXRLMUHMZnT
         iTw3LsSTgb1JgvAPZIEDL7EzHJbwN57+5QEtNlBbIlRS5uZRlRzgZPIb8oiI5tb/3DaA
         9esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700737981; x=1701342781;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ETRJxI0jYA8eO15FtbRSONvqohxyMW+Q9fmUG4iFDY=;
        b=HhYiNfghHpCMeroE6ONkWthZak/BdoQyI9+sJBjbboxd/h5eDfUsaZa/jhhb2qR4pB
         Qe3ElKC581IDa4EMKJ54SwHsrqGzm4yJ9KvCg9sBfJk4bu4dwfM8eyVZleOfIk2RQEtu
         RnL5qgLc5+XoSzWSDSaKks+KJi/fuXR10SLuLroZIYz/mFge6l6gT66cEakAIS9+h/ik
         mhzMksUeB9t1RB/Ri91Ma6olY4hsShsphTxfqopV34XHyvgq8BDYNUs9u0gLsmQIGb6m
         8DfRSY3kCKpfOhxM+pqZuvYSAEzi/JweM/PQP43fkRo+0TOGsPRO0aRylgzcGjO/0xqK
         3/ag==
X-Gm-Message-State: AOJu0Yw/c4iXDk6IlEdBLiotLKBOCpUjIkMMZMh2mkAwZBEf53DUnbPO
        qVKy2h68m0KABla/tkvDnNU=
X-Google-Smtp-Source: AGHT+IGDcx2v11UllY0MPwVs59OUelQ1fQzHkONutC5jBwKmQP7TQh2iBL8GZFvs8pVUkQNqXV7mWg==
X-Received: by 2002:a17:906:340e:b0:9e5:fdd7:f521 with SMTP id c14-20020a170906340e00b009e5fdd7f521mr3755277ejb.41.1700737981121;
        Thu, 23 Nov 2023 03:13:01 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d183:a5d9:39a9:cd13])
        by smtp.gmail.com with ESMTPSA id kz15-20020a17090777cf00b009fd50aa6984sm646420ejc.83.2023.11.23.03.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:13:00 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] net: make config lines follow common pattern
Date:   Thu, 23 Nov 2023 12:12:56 +0100
Message-Id: <20231123111256.10757-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig parser is quite relaxed when parsing config definition lines.
However, there are just a few config definition lines that do not follow
the common regular expression 'config [0-9A-Z]', i.e., there are only a few
cases where config is not followed by exactly one whitespace.

To simplify life for kernel developers that use basic regular expressions
to find and extract kernel configs, make all config lines follow this
common pattern.

No functional change, just helpful stylistic clean-up.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/net/ethernet/cavium/Kconfig |  4 +--
 net/caif/Kconfig                    |  2 +-
 net/netfilter/ipvs/Kconfig          | 54 ++++++++++++++---------------
 net/unix/Kconfig                    |  2 +-
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index ca742cc146d7..fe4203b1bc5f 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -32,7 +32,7 @@ config THUNDER_NIC_VF
 	help
 	  This driver supports Thunder's NIC virtual function
 
-config	THUNDER_NIC_BGX
+config THUNDER_NIC_BGX
 	tristate "Thunder MAC interface driver (BGX)"
 	depends on 64BIT && PCI
 	select PHYLIB
@@ -42,7 +42,7 @@ config	THUNDER_NIC_BGX
 	  This driver supports programming and controlling of MAC
 	  interface from NIC physical function driver.
 
-config	THUNDER_NIC_RGX
+config THUNDER_NIC_RGX
 	tristate "Thunder MAC interface driver (RGX)"
 	depends on 64BIT && PCI
 	select PHYLIB
diff --git a/net/caif/Kconfig b/net/caif/Kconfig
index 87205251cc25..1eb271125eb0 100644
--- a/net/caif/Kconfig
+++ b/net/caif/Kconfig
@@ -22,7 +22,7 @@ menuconfig CAIF
 	See Documentation/networking/caif for a further explanation on how to
 	use and configure CAIF.
 
-config  CAIF_DEBUG
+config CAIF_DEBUG
 	bool "Enable Debug"
 	depends on CAIF
 	default n
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 2a3017b9c001..db6df2ca129d 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -26,7 +26,7 @@ menuconfig IP_VS
 
 if IP_VS
 
-config	IP_VS_IPV6
+config IP_VS_IPV6
 	bool "IPv6 support for IPVS"
 	depends on IPV6 = y || IP_VS = IPV6
 	select NF_DEFRAG_IPV6
@@ -35,14 +35,14 @@ config	IP_VS_IPV6
 
 	  Say Y if unsure.
 
-config	IP_VS_DEBUG
+config IP_VS_DEBUG
 	bool "IP virtual server debugging"
 	help
 	  Say Y here if you want to get additional messages useful in
 	  debugging the IP virtual server code. You can change the debug
 	  level in /proc/sys/net/ipv4/vs/debug_level
 
-config	IP_VS_TAB_BITS
+config IP_VS_TAB_BITS
 	int "IPVS connection table size (the Nth power of 2)"
 	range 8 20 if !64BIT
 	range 8 27 if 64BIT
@@ -76,34 +76,34 @@ config	IP_VS_TAB_BITS
 
 comment "IPVS transport protocol load balancing support"
 
-config	IP_VS_PROTO_TCP
+config IP_VS_PROTO_TCP
 	bool "TCP load balancing support"
 	help
 	  This option enables support for load balancing TCP transport
 	  protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_UDP
+config IP_VS_PROTO_UDP
 	bool "UDP load balancing support"
 	help
 	  This option enables support for load balancing UDP transport
 	  protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_AH_ESP
+config IP_VS_PROTO_AH_ESP
 	def_bool IP_VS_PROTO_ESP || IP_VS_PROTO_AH
 
-config	IP_VS_PROTO_ESP
+config IP_VS_PROTO_ESP
 	bool "ESP load balancing support"
 	help
 	  This option enables support for load balancing ESP (Encapsulation
 	  Security Payload) transport protocol. Say Y if unsure.
 
-config	IP_VS_PROTO_AH
+config IP_VS_PROTO_AH
 	bool "AH load balancing support"
 	help
 	  This option enables support for load balancing AH (Authentication
 	  Header) transport protocol. Say Y if unsure.
 
-config  IP_VS_PROTO_SCTP
+config IP_VS_PROTO_SCTP
 	bool "SCTP load balancing support"
 	select LIBCRC32C
 	help
@@ -112,7 +112,7 @@ config  IP_VS_PROTO_SCTP
 
 comment "IPVS scheduler"
 
-config	IP_VS_RR
+config IP_VS_RR
 	tristate "round-robin scheduling"
 	help
 	  The robin-robin scheduling algorithm simply directs network
@@ -121,7 +121,7 @@ config	IP_VS_RR
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
  
-config	IP_VS_WRR
+config IP_VS_WRR
 	tristate "weighted round-robin scheduling"
 	help
 	  The weighted robin-robin scheduling algorithm directs network
@@ -134,7 +134,7 @@ config	IP_VS_WRR
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_LC
+config IP_VS_LC
 	tristate "least-connection scheduling"
 	help
 	  The least-connection scheduling algorithm directs network
@@ -144,7 +144,7 @@ config	IP_VS_LC
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_WLC
+config IP_VS_WLC
 	tristate "weighted least-connection scheduling"
 	help
 	  The weighted least-connection scheduling algorithm directs network
@@ -154,8 +154,8 @@ config	IP_VS_WLC
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_FO
-		tristate "weighted failover scheduling"
+config IP_VS_FO
+	tristate "weighted failover scheduling"
 	help
 	  The weighted failover scheduling algorithm directs network
 	  connections to the server with the highest weight that is
@@ -164,7 +164,7 @@ config  IP_VS_FO
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_OVF
+config IP_VS_OVF
 	tristate "weighted overflow scheduling"
 	help
 	  The weighted overflow scheduling algorithm directs network
@@ -175,7 +175,7 @@ config  IP_VS_OVF
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_LBLC
+config IP_VS_LBLC
 	tristate "locality-based least-connection scheduling"
 	help
 	  The locality-based least-connection scheduling algorithm is for
@@ -189,7 +189,7 @@ config	IP_VS_LBLC
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config  IP_VS_LBLCR
+config IP_VS_LBLCR
 	tristate "locality-based least-connection with replication scheduling"
 	help
 	  The locality-based least-connection with replication scheduling
@@ -207,7 +207,7 @@ config  IP_VS_LBLCR
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_DH
+config IP_VS_DH
 	tristate "destination hashing scheduling"
 	help
 	  The destination hashing scheduling algorithm assigns network
@@ -217,7 +217,7 @@ config	IP_VS_DH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_SH
+config IP_VS_SH
 	tristate "source hashing scheduling"
 	help
 	  The source hashing scheduling algorithm assigns network
@@ -227,7 +227,7 @@ config	IP_VS_SH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_MH
+config IP_VS_MH
 	tristate "maglev hashing scheduling"
 	help
 	  The maglev consistent hashing scheduling algorithm provides the
@@ -246,7 +246,7 @@ config	IP_VS_MH
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_SED
+config IP_VS_SED
 	tristate "shortest expected delay scheduling"
 	help
 	  The shortest expected delay scheduling algorithm assigns network
@@ -259,7 +259,7 @@ config	IP_VS_SED
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_NQ
+config IP_VS_NQ
 	tristate "never queue scheduling"
 	help
 	  The never queue scheduling algorithm adopts a two-speed model.
@@ -272,7 +272,7 @@ config	IP_VS_NQ
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_TWOS
+config IP_VS_TWOS
 	tristate "weighted random twos choice least-connection scheduling"
 	help
 	  The weighted random twos choice least-connection scheduling
@@ -318,7 +318,7 @@ config IP_VS_MH_TAB_INDEX
 
 comment 'IPVS application helper'
 
-config	IP_VS_FTP
+config IP_VS_FTP
 	tristate "FTP protocol helper"
 	depends on IP_VS_PROTO_TCP && NF_CONNTRACK && NF_NAT && \
 		NF_CONNTRACK_FTP
@@ -334,7 +334,7 @@ config	IP_VS_FTP
 	  If you want to compile it in kernel, say Y. To compile it as a
 	  module, choose M here. If unsure, say N.
 
-config	IP_VS_NFCT
+config IP_VS_NFCT
 	bool "Netfilter connection tracking"
 	depends on NF_CONNTRACK
 	help
@@ -342,7 +342,7 @@ config	IP_VS_NFCT
 	  connection state to be exported to the Netfilter framework
 	  for filtering purposes.
 
-config	IP_VS_PE_SIP
+config IP_VS_PE_SIP
 	tristate "SIP persistence engine"
 	depends on IP_VS_PROTO_UDP
 	depends on NF_CONNTRACK_SIP
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 28b232f281ab..5f2502977042 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -21,7 +21,7 @@ config UNIX_SCM
 	depends on UNIX
 	default y
 
-config	AF_UNIX_OOB
+config AF_UNIX_OOB
 	bool
 	depends on UNIX
 	default y
-- 
2.17.1

