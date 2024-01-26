Return-Path: <linux-kernel+bounces-39767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F983D5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9ECA2854E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE17C0AA;
	Fri, 26 Jan 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClG0zG9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4D1CFAE;
	Fri, 26 Jan 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257945; cv=none; b=shghj+TrjiJmFq15ruMASMJw+j9VgDj5rwH1Kc4JzCzI/N/DUFEFwkb3Gew96lWfGarPgczr8nmVLUlexqlZl6pW8TaQ2hBCG/8hY6XE5LavT23QKsznVEoWn944BBwmbJ0QEl/9ylTejmEz9LgbVkHkHolWAnkxYaDcIw7sICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257945; c=relaxed/simple;
	bh=wstLSSz3qMGDQxUYzW+IHsUCg9UT58andHSX7WC1dOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ISCCXF60ksxA7reHb2yalTH89RJ25gzCBObO0UJUbg0D9ioMvvWM26/PldkL0uknvQDqx5nQtn5eBAbPBjBog9mhYr368vRLBOI4AUCKrnfSgm+EXSIOZ7BsaW18Dd9XcpHxAZ1+tNVC59ptt2LNhGLEL2imiESkVJKUrZuLeq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClG0zG9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2BC433F1;
	Fri, 26 Jan 2024 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706257945;
	bh=wstLSSz3qMGDQxUYzW+IHsUCg9UT58andHSX7WC1dOA=;
	h=Date:From:To:Cc:Subject:From;
	b=ClG0zG9k5IMq0O5zUgX7DQVolc1NIz4ZcQ4BZwOfNsuOjQ0TRHPthT4u5pvvVM/LL
	 35kt2P0Zwt/YyQT8ILDOA3jHWeL2/oenVPShooFxHoOG5XP0OESHRGRnQgoWS/VEyh
	 YsBTnamXcWdV53UvCANE0ryGhcj+2lI1wWLgKTxn5JHby7pudKrN4c+l1evWyVjaSL
	 2QTDpzVmdFORUulHfrTCWwYLQ5ovXxqfskd8BXf/ORMi6j049L0+uCewvKH33oxYHB
	 jyUfTxDhEbBz/tBXhKCgm4Uduuxl/VhoIgWITu6ZfR8KsWsJW+C6TN4sKRGDCzBPcF
	 JmOmUr2w+UPrQ==
Date: Fri, 26 Jan 2024 09:32:20 +0100
From: Helge Deller <deller@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH v2] [net] ipv6: Ensure natural alignment of const ipv6
 loopback and router addresses
Message-ID: <ZbNuFM1bFqoH-UoY@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On a parisc64 kernel I sometimes notice this kernel warning:
Kernel unaligned access to 0x40ff8814 at ndisc_send_skb+0xc0/0x4d8

The address 0x40ff8814 points to the in6addr_linklocal_allrouters
variable and the warning simply means that some ipv6 function tries to
read a 64-bit word directly from the not-64-bit aligned
in6addr_linklocal_allrouters variable.

Unaligned accesses are non-critical as the architecture or exception
handlers usually will fix it up at runtime. Nevertheless it may trigger
a performance penality for some architectures. For details read the
"unaligned-memory-access" kernel documentation.

The patch below ensures that the ipv6 loopback and router addresses will
always be naturally aligned. This prevents the unaligned accesses for
all architectures.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 034dfc5df99eb ("ipv6: export in6addr_loopback to modules")
Acked-by: Paolo Abeni <pabeni@redhat.com>

--
v2:
- Added A-b from Paolo
- Rephrased parts of commit message
- resent with [net] tag

---
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


