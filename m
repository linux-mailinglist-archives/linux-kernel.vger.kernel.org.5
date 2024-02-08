Return-Path: <linux-kernel+bounces-57779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCF584DD5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21111C24E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AA6EB4C;
	Thu,  8 Feb 2024 09:54:11 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4E6BFD7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386051; cv=none; b=i768Mq3mZhJXO14F2kgNT8ElG6zRO8+moJ+X9p9kiaAZL0swQE9QSF0Kz369y+I+5IGTuHCn7a9qFIt63o3QDiV+84h8HF9p8GDm5zYMPZxhWFh09RhmQ4jdCcReAk7uUG3eIFOBKI7VcZYrpySIv0xAll+/6fBa4CLfiGfCO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386051; c=relaxed/simple;
	bh=zquoTPDiDMopq79YAJN8pFBJInmPfdGsBn+pPQU1BdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7LdLmtyj97PvMJGMQHqnnYM1w1wClRH0H3t0V/TcpRmPSPir6ZNzql6LPZAaxmdIriTjFRdmr+Y7wg+VcrTxCsjbJeshgioN9Y8ANeg1CpRfGy8kFi9wpDYbF5SN8zc9yN6n2hkdtiICCzpoo1KzfKKwUxQV5PtsJnLiHMO1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from framework.labs
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Thu, 08 Feb 2024 10:54:06 +0100
From: David Ventura <david@davidv.dev>
To: david@davidv.dev
Cc: Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: [PATCH v2 1/2] net: make driver settling time configurable
Date: Thu,  8 Feb 2024 10:52:29 +0100
Message-Id: <20240208095358.251381-1-david@davidv.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208093722.246930-1-david@davidv.dev>
References: <20240208093722.246930-1-david@davidv.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During IP auto configuration, some drivers apparently need to wait a
certain length of time to settle; as this is not true for all drivers,
make this length of time configurable.

Signed-off-by: David Ventura <david@davidv.dev>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++++
 Documentation/admin-guide/nfs/nfsroot.rst     |  3 +++
 net/ipv4/ipconfig.c                           | 23 ++++++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b47940577c10..b07a035642fa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2291,6 +2291,10 @@
 
 	ip=		[IP_PNP]
 			See Documentation/admin-guide/nfs/nfsroot.rst.
+	ip.dev_wait_ms=
+			[IP_PNP]
+			See Documentation/admin-guide/nfs/nfsroot.rst.
+
 
 	ipcmni_extend	[KNL,EARLY] Extend the maximum number of unique System V
 			IPC identifiers from 32,768 to 16,777,216.
diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 135218f33394..f26f7a342af6 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -223,6 +223,9 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns
   /proc/net/ipconfig/ntp_servers to an NTP client before mounting the real
   root filesystem if it is on NFS).
 
+ip.dev_wait_ms=<value>
+  Set the number of milliseconds to delay after opening the network device
+  which will be autoconfigured. Defaults to 10 milliseconds.
 
 nfsrootdebug
   This parameter enables debugging messages to appear in the kernel
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..cbf35163b973 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -82,8 +82,6 @@
 #define IPCONFIG_DYNAMIC
 #endif
 
-/* Define the friendly delay before and after opening net devices */
-#define CONF_POST_OPEN		10	/* After opening: 10 msecs */
 
 /* Define the timeout for waiting for a DHCP/BOOTP/RARP reply */
 #define CONF_OPEN_RETRIES 	2	/* (Re)open devices twice */
@@ -101,6 +99,7 @@
 
 /* Wait for carrier timeout default in seconds */
 static unsigned int carrier_timeout = 120;
+static unsigned int dev_wait_ms = 10;
 
 /*
  * Public IP configuration
@@ -1516,7 +1515,8 @@ static int __init ip_auto_config(void)
 		return err;
 
 	/* Give drivers a chance to settle */
-	msleep(CONF_POST_OPEN);
+	if(dev_wait_ms > 0)
+		msleep(dev_wait_ms);
 
 	/*
 	 * If the config information is insufficient (e.g., our IP address or
@@ -1849,3 +1849,20 @@ static int __init set_carrier_timeout(char *str)
 	return 1;
 }
 __setup("carrier_timeout=", set_carrier_timeout);
+
+
+static int __init set_dev_wait_ms(char *str)
+{
+	ssize_t ret;
+
+	if (!str)
+		return 0;
+
+	ret = kstrtouint(str, 0, &dev_wait_ms);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+
+__setup("ip.dev_wait_ms=", set_dev_wait_ms);
-- 
2.39.2


