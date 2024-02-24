Return-Path: <linux-kernel+bounces-79632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E98624EA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B7F1C210B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFA3D541;
	Sat, 24 Feb 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBBbX1x8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90778250EA;
	Sat, 24 Feb 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776816; cv=none; b=k7n6qiomz8wdgmlm+L9ewMgVrY/fKB32XF4xE2nhx+xLXpgXVez7rQwnmk8+TCQpTbJJCUECFB1YLFohAQhVJ5u1j5RP+viMZuYbimjhQZ5kbSeNnEzMKC86FfO1EWKx8tyRZptx3JpXzM41h95h9G1AoTtJURsjQIHjtMZ4CY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776816; c=relaxed/simple;
	bh=XuZaYULxt+QGAQ9Uunj4VVZWgUNRWuw89lnYQs72UaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OocDjRbFzgmS/l11sIvoiXuEHShmIMQ8KHrfWgR7KhZZLOqUiS/wwcgVe1G6ie5YWzrzdy6Y3f5U+KQONPW+A+F+VcRImMV4OTTwsFh/zsSKmvvhCu4VVIct9Io/44/T1NQyuovRS6EPL6Em+eaP3KSqOMlfEZXRP4PUwmpxWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBBbX1x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5F8C433C7;
	Sat, 24 Feb 2024 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776816;
	bh=XuZaYULxt+QGAQ9Uunj4VVZWgUNRWuw89lnYQs72UaE=;
	h=From:To:Cc:Subject:Date:From;
	b=JBBbX1x8mXKUnleDNXQBhFhFYeFJbRFjBjjYJTrUf9jotWBHCZANs+6ulYxs5u60B
	 FuvoWL758zNYDzP/rlga/Z3DlOqtANpMKFbBng9LwIBORz88DS3N5oLTT2DjdaNhHv
	 YhMQLfTibP4NVtubCa2jCcfB5bu6Z1c5QyIl2nFd1/SH3UeDX/KJmxW/bIdLpf/gaE
	 r84yG8YdODU8ZFreixoKcE6nuDE3tUyDUECbPgQZQa0sIkJXIyJ5yzLdU8cld3US9p
	 RmKPse8uLoH6MsC9mKy6/3nmfGS/87zixtpIZYVlWxHHibsIvJtgTkM7pLyClkcyAl
	 P/eBrfdD7z0yw==
From: Arnd Bergmann <arnd@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: xtables: fix IP6_NF_IPTABLES_LEGACY typo
Date: Sat, 24 Feb 2024 13:13:13 +0100
Message-Id: <20240224121330.1924338-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

CONFIG_IP_NF_NAT accidentally selects the wrong NF_IPTABLES_LEGACY
symbol, which ends up causing a link failure in some configurations:

WARNING: unmet direct dependencies detected for IP6_NF_IPTABLES_LEGACY
  Depends on [n]: NET [=y] && INET [=y] && IPV6 [=n] && NETFILTER [=y]
  Selected by [m]:

Select IP_NF_IPTABLES_LEGACY instead of IP6_NF_IPTABLES_LEGACY.

Fixes: a9525c7f6219 ("netfilter: xtables: allow xtables-nft only builds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/netfilter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index 87d890172809..8f6e950163a7 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -217,7 +217,7 @@ config IP_NF_NAT
 	default m if NETFILTER_ADVANCED=n
 	select NF_NAT
 	select NETFILTER_XT_NAT
-	select IP6_NF_IPTABLES_LEGACY
+	select IP_NF_IPTABLES_LEGACY
 	help
 	  This enables the `nat' table in iptables. This allows masquerading,
 	  port forwarding and other forms of full Network Address Port
-- 
2.39.2


