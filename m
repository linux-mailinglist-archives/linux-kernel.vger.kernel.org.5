Return-Path: <linux-kernel+bounces-130589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06B897A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EE91F22545
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337E156893;
	Wed,  3 Apr 2024 20:37:35 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF0156880;
	Wed,  3 Apr 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176654; cv=none; b=Zw9XrSk5iITGZo6kQHInI8m0tXc9bk3xPvmpnU0jYwF3QS/HdBk1wJ3wJG52lNWWeb1jgmz+j61eCnt6+/DOKiiDJhu4rq4NltJQR2n4uzpbIfzQ82ONILOeE2pOq+x0JF/+jinjk/G08S23DvW53rJMv5fBctAZ8Mkor1AzVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176654; c=relaxed/simple;
	bh=X6bTWWIJgpGy4SkYcFLNiquERMtuJ6e3t7TzjT5IO4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDcGFo+DA96RtnKk+kqBR30Azz8St2rXgQZz8U+cmiQr130J5pWC5tyoGpXSzvc/Qple/gdS/eQgt5YgTczpXZSGDa3AWed2EQyLcv72n6rYmc7FY25EHDzsvBSIuJX0B/rqdY4xm5fxuWdXi+ni3BIQH+Nk8FNv/6L8oLSGIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB52160003;
	Wed,  3 Apr 2024 20:37:22 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yi-Hung Wei <yihung.wei@gmail.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net] net: openvswitch: fix unwanted error log on timeout policy probing
Date: Wed,  3 Apr 2024 22:38:01 +0200
Message-ID: <20240403203803.2137962-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org

On startup, ovs-vswitchd probes different datapath features including
support for timeout policies.  While probing, it tries to execute
certain operations with OVS_PACKET_ATTR_PROBE or OVS_FLOW_ATTR_PROBE
attributes set.  These attributes tell the openvswitch module to not
log any errors when they occur as it is expected that some of the
probes will fail.

For some reason, setting the timeout policy ignores the PROBE attribute
and logs a failure anyway.  This is causing the following kernel log
on each re-start of ovs-vswitchd:

  kernel: Failed to associated timeout policy `ovs_test_tp'

Fix that by using the same logging macro that all other messages are
using.  The message will still be printed at info level when needed
and will be rate limited, but with a net rate limiter instead of
generic printk one.

The nf_ct_set_timeout() itself will still print some info messages,
but at least this change makes logging in openvswitch module more
consistent.

Fixes: 06bd2bdf19d2 ("openvswitch: Add timeout support to ct action")
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/conntrack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 3019a4406ca4..74b63cdb5992 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1380,8 +1380,9 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 	if (ct_info.timeout[0]) {
 		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
 				      ct_info.timeout))
-			pr_info_ratelimited("Failed to associated timeout "
-					    "policy `%s'\n", ct_info.timeout);
+			OVS_NLERR(log,
+				  "Failed to associated timeout policy '%s'",
+				  ct_info.timeout);
 		else
 			ct_info.nf_ct_timeout = rcu_dereference(
 				nf_ct_timeout_find(ct_info.ct)->timeout);
-- 
2.44.0


