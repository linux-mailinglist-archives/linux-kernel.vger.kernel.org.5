Return-Path: <linux-kernel+bounces-34178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F106837530
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70DD1F27DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F72481C2;
	Mon, 22 Jan 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6FPeoic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480A481A8;
	Mon, 22 Jan 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958841; cv=none; b=MZkMjfq0yd/ga8Ztvl62laukDgLlEbF1f3uDHId0lehy/C7lr3FBJQZdmaji2BjVLcEP5fF4HjavebMCypzV6kW5LK3Ol3U9YgyUQoI4AfMbJWwbagHyxcqtJ0WfjGoijd2icGmb0URfDeG9gjPzBodCg84oIuCqOJ4zuoPzysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958841; c=relaxed/simple;
	bh=B4jg+wknI7bWQTo4YGuAgpR6c3hqlIFCNIfSJVyzWpI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hi5y9yOB7YoZUygU7Q1l3ey/5rxG4Tm4NVmsFGFL+dsnJepIhW9w0MZUNH5xunoUuolw3AYzwn3A/hY9XirgiWVArQk6NefCbU0WfnfkgQRNZsVxbyDfJfByeGXgFtmVzSRcyqNOz+3iW2edI+jVjz/LWRis7syhBIKxE5lics0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6FPeoic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0185C433F1;
	Mon, 22 Jan 2024 21:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705958840;
	bh=B4jg+wknI7bWQTo4YGuAgpR6c3hqlIFCNIfSJVyzWpI=;
	h=Date:From:To:Subject:From;
	b=B6FPeoic5mAklseNc8DVinZekJCs3gm2yeVq1FZiWEKQ8OhD4vCTm7Z26KO1F6vSP
	 UCp0UeCrMc7gtYKPXcgFB36tWYBTWLfECX5vNKW3/no/3J1peECVFU6t4c93a9WSQr
	 y4BtWUo83y6Ync0kgxA9L3e+ryczFPMIHZ0ACw1yg02oB3pAjXUib6a13Kgmi2xfns
	 JsFFnzZmB500h5sX1+0GnLXmIWFKjAHK5iA6+4SJ7IqsPQgObcr0dsq2JeyR2TwPOj
	 OfIkrsMAlrI/H7jA6aj7QuOtro/2If44RZ+u9NTtbxBtoRZMYKiNvIourW9jLFsmUA
	 FTJ9QMJkq/0Sg==
Date: Mon, 22 Jan 2024 22:27:15 +0100
From: Helge Deller <deller@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH] ipv6: Ensure natural alignment of const ipv6 loopback and
 router addresses
Message-ID: <Za7dsxCjItn-dlfy@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On a parisc64 kernel I notice sometimes this kernel warning:
Kernel unaligned access to 0x40ff8814 at ndisc_send_skb+0xc0/0x4d8

The address 0x40ff8814 points to the in6addr_linklocal_allrouters
variable and the warning simply means that some ipv6 function tries to
read a 64-bit word directly from the not-64-bit aligned
in6addr_linklocal_allrouters variable.

The patch below ensures that those ipv6 loopback and router addresses
always will be naturally aligned and as such prevents unaligned accesses
for all architectures.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index 507a8353a6bd..813e009b4d0e 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -220,19 +220,26 @@ const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
 EXPORT_SYMBOL_GPL(ipv6_stub);
 
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
-const struct in6_addr in6addr_loopback = IN6ADDR_LOOPBACK_INIT;
+const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LOOPBACK_INIT;
 EXPORT_SYMBOL(in6addr_loopback);
-const struct in6_addr in6addr_any = IN6ADDR_ANY_INIT;
+const struct in6_addr in6addr_any __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_ANY_INIT;
 EXPORT_SYMBOL(in6addr_any);
-const struct in6_addr in6addr_linklocal_allnodes = IN6ADDR_LINKLOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_linklocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allnodes);
-const struct in6_addr in6addr_linklocal_allrouters = IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_linklocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_LINKLOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_linklocal_allrouters);
-const struct in6_addr in6addr_interfacelocal_allnodes = IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
+const struct in6_addr in6addr_interfacelocal_allnodes __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLNODES_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allnodes);
-const struct in6_addr in6addr_interfacelocal_allrouters = IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_interfacelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_INTERFACELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_interfacelocal_allrouters);
-const struct in6_addr in6addr_sitelocal_allrouters = IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
+const struct in6_addr in6addr_sitelocal_allrouters __aligned(BITS_PER_LONG/8)
+	= IN6ADDR_SITELOCAL_ALLROUTERS_INIT;
 EXPORT_SYMBOL(in6addr_sitelocal_allrouters);
 
 static void snmp6_free_dev(struct inet6_dev *idev)

