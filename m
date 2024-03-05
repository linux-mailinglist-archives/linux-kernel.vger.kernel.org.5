Return-Path: <linux-kernel+bounces-92213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5DB871CDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CA3285EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063995676A;
	Tue,  5 Mar 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR1S5fEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A15A4C9;
	Tue,  5 Mar 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636683; cv=none; b=CL/ID/ap38oE0fY06cyKsVjGHw9FbCDzKb9KoK6tldMNfsRF+HsLE1X6TaGBEHXnGq3lBap/sIAiBQ1SLYOQ75KO4jYf+JsiQcqLRhv9Ppd9HsqPy8m465WWdpK3bW6gAyH9FSk8mHxfID6XOXYgCw722ZGIoXjvkOZfIKrfV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636683; c=relaxed/simple;
	bh=P/wdeWQa0W3b+O5lwhLDozduBxcngBMm9JDLN+WGduM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QP10qN028kFF0BMPObdi1TH2frWpi+vTZL9DaRG9pBayLRk07d2+YlwGDSgP23CBEUD2ZsWNoNH7EIQaPafH5gfH3dCPQVT+Zw5ASxJtbI3ATcFKOT9xiqxInjlaKR1lNRobptHSa5keWW4lxzgFft0KJ7Bak8KEGPdkWBj4524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR1S5fEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1472C43390;
	Tue,  5 Mar 2024 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636682;
	bh=P/wdeWQa0W3b+O5lwhLDozduBxcngBMm9JDLN+WGduM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BR1S5fEoZsz1bBQVWzTSK40M6v9eBP8CCcp3i9PiFSCaj2eRenKYjm6jKD79jD8/B
	 8ogvVNpRfOjRThuQaBEs5Fx8c+VIaHtAkQ6hKRgSZLq/1U7nf7m68V6mFbtvSKE4ZD
	 o78J9v/9cfaKrtXeJKgErl9KcsvKkPBh1smOqvzlJqnBE5J39+tm8k/ktdHdLdCv+7
	 MunHPZg9PEf2TQW7NDLaXXKx3F+nFboglM/UXI4KuUMtZ8PV8XfRDN+GF9A6u9xmri
	 Uq93U5huzkcXq0ArzotDiZE50xMEJ0xWAU9MjNkmnKPA15uN4+EWC3NeySXclgR8QT
	 7U/cZhUlhOEyA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 12:04:30 +0100
Subject: [PATCH net-next 1/4] mptcp: drop duplicate header inclusions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-1-c436ba5e569b@kernel.org>
References: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HA1tmoL01hr3DXbYFWkVkYbZaNlDbfZMyOwEbhewj4w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vxDNFiGxhHposnm2lR7WNXn7U29kq+wYr8W4
 jfOtiwnAbGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb8QwAKCRD2t4JPQmmg
 cxxsEADgdU6yF3Gm4w0rwIhzT8Hl02+fcezmjXOsGdfghYbErWVGDH51LAMrxTd2a7mdVs985lb
 P6YC6pgmb23vA6XsyYk91C+W8mQlEyXx2EyROQbhHZ9deNf39p4+gJ9jq9hLPGYlFx2BK4Y397q
 O0b+DZHvJ2Iao74Y/ujEyEpkfaSK3vs+6rloQ6cHd9EBiGRGPvc85loW7uXxVIn2BlEKNUdc57D
 55NpfHHV+dRzoQGdWwLPBl0AzTSX2KNHNj23mplqd9aogFxiT6HOYbtS4rt5ECIe8zDXl+Jj1Cx
 +CwxPDNN3GdUU3+Lq4NsBQmSfD8NMeivRjOVZbav0VSyyOL+E1ErVDEvNc+g2ES/AaFJ+RjIykw
 aMqcEWv34dj9AuZJmpvNmd2BvO+ohBpH1jr0UDbcXHybSg03B5mTblqcuzPr/YlUEUpYHICt+AF
 mhHTMcjB3ngXhDpc5ZQF2BWMkJBUNFn7w6LjA7wN48jhr28ie3GFr13gRMDT6697LBL8zLW5QRV
 HEjKErT59vvWrt4fceTneKZJd2CNlCF727x5Ru7Oimmg+QKv8kMXpbkRTHDG+zDrL2qFLcP3RzV
 hRl68CSlVVFKyPPZmQ2OI7hGb+/FuFGPBos/+xquM4Xna3SoBMnqxCApULAuYkYi5F1+t6eirjg
 +49jMaa0kXTVaNQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The headers net/tcp.h, net/genetlink.h and uapi/linux/mptcp.h are included
in protocol.h already, no need to include them again directly. This patch
removes these duplicate header inclusions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/diag.c       | 1 -
 net/mptcp/mptcp_diag.c | 1 -
 net/mptcp/pm.c         | 1 -
 net/mptcp/pm_netlink.c | 3 ---
 net/mptcp/protocol.c   | 1 -
 net/mptcp/subflow.c    | 2 --
 6 files changed, 9 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 7017dd60659d..3ae46b545d2c 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -10,7 +10,6 @@
 #include <linux/net.h>
 #include <linux/inet_diag.h>
 #include <net/netlink.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
 static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index bd8ff5950c8d..0566dd793810 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -10,7 +10,6 @@
 #include <linux/net.h>
 #include <linux/inet_diag.h>
 #include <net/netlink.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b4bdd92a5648..28e5d514bf20 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -6,7 +6,6 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/kernel.h>
-#include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 16f8bd47f4b8..a900df9f173d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -8,12 +8,9 @@
 
 #include <linux/inet.h>
 #include <linux/kernel.h>
-#include <net/tcp.h>
 #include <net/inet_common.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
-#include <net/genetlink.h>
-#include <uapi/linux/mptcp.h>
 
 #include "protocol.h"
 #include "mib.h"
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99367c40de0d..3a1967bc7bad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -15,7 +15,6 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
 #include <net/tcp_states.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/transp_v6.h>
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6403c56f2902..1626dd20c68f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -15,13 +15,11 @@
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
-#include <net/tcp.h>
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 #include <net/ip6_route.h>
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
-#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 #include "mib.h"
 

-- 
2.43.0


