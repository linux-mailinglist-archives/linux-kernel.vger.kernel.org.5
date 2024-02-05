Return-Path: <linux-kernel+bounces-52985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A8849F2E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966572897F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720D45035;
	Mon,  5 Feb 2024 15:58:57 +0000 (UTC)
Received: from davidv.dev (mail.davidv.dev [78.46.233.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BC3D99E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.233.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148736; cv=none; b=Cvc5m0uANs6wr2pMs5uso+NwYYtSwWUg5vWfJcGTQoxdj9bQbTfm/rGckOTc8b2rRbRUw/WYi+k4OShKE+OK3xwyTgcFSYDBu5/HYFcUGdf11NRXU29Gj22djnWpjjdRbBWu4gQ9ZizJlIq17Iw50jQ2t69WNVRHTpO4pLVECg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148736; c=relaxed/simple;
	bh=Pppg7VSwpwIuek6Wg6dxlq5yApM3fhfhfp70mFwuCPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APJ4dkZ2TcCaH862YxHTZO+7zErY+vcM5xb5ET/mZRonODMkRejSezRe/11o/he5EPeldv//9YZY/mH/MK0md4RCIGgCExV5ekD8A7CXElad49DS8I8v+DD0lYdPsVBy11Ua87LfAX2o15PLDlDo7AXR00I/07gVdpIUvE1xEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev; spf=pass smtp.mailfrom=davidv.dev; arc=none smtp.client-ip=78.46.233.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidv.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidv.dev
Received: from framework.labs
	by mail.davidv.dev (chasquid) with ESMTPSA
	tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(over submission+TLS, TLS-1.2, envelope from "david@davidv.dev")
	; Mon, 05 Feb 2024 16:58:51 +0100
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: Change default delay on IP autoconfig to 0ms
Date: Mon,  5 Feb 2024 16:55:43 +0100
Message-Id: <20240205155717.484198-1-david@davidv.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <580001e3-17ef-4f24-8fd8-bc14110e874e@lunn.ch>
References: <580001e3-17ef-4f24-8fd8-bc14110e874e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As suggested, I'm updating the default to 0ms. 

This patch depends on 1f0aa0c947eeb4edb60add141a5bc2309f2dc8dd ("
net: make driver settling time configurable").

Signed-off-by: David Ventura <david@davidv.dev>
---
 Documentation/admin-guide/nfs/nfsroot.rst | 2 +-
 net/ipv4/ipconfig.c                       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index f26f7a342af6..fce610a4ec54 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -225,7 +225,7 @@ ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>:<dns
 
 ip.dev_wait_ms=<value>
   Set the number of milliseconds to delay after opening the network device
-  which will be autoconfigured. Defaults to 10 milliseconds.
+  which will be autoconfigured. Defaults to 0 milliseconds.
 
 nfsrootdebug
   This parameter enables debugging messages to appear in the kernel
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index cbf35163b973..8b7d08649b09 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -99,7 +99,7 @@
 
 /* Wait for carrier timeout default in seconds */
 static unsigned int carrier_timeout = 120;
-static unsigned int dev_wait_ms = 10;
+static unsigned int dev_wait_ms = 0;
 
 /*
  * Public IP configuration
-- 
2.39.2


