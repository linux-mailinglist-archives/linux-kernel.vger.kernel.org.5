Return-Path: <linux-kernel+bounces-9149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A181C19D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF16B24DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E4A79475;
	Thu, 21 Dec 2023 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=faucet.nz header.i=@faucet.nz header.b="m5FWgqV9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4032E78E90;
	Thu, 21 Dec 2023 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=faucet.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.faucet.nz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faucet.nz;
 h=Content-Transfer-Encoding: MIME-Version: Message-Id: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-4ed8c67516; t=1703199957;
 bh=l60SR+53LmctJjdJT6+f0RpMxenYz9binUoltgUVMmE=;
 b=m5FWgqV9zNfPV+auhA9mYWbBFfs0BokrE6vja+oSSKrmOZZwdE73azw1L4uhNf7VE6rLuGDdl
 PV2UhMDM1hIcpABWJPrKyOfJJ0Q1rh/nX5M2KTU2rLsn/8/q8j4tTsJUtCAQZfdIB+zRfLFzvXN
 DAnLpwunFyVGkJIs5XGdj6A=
From: Brad Cowie <brad@faucet.nz>
To: netdev@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netfilter-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pshelar@ovn.org, dev@openvswitch.org, Brad
 Cowie <brad@faucet.nz>
Subject: [PATCH net] netfilter: nf_nat: fix action not being set for all ct states
Date: Fri, 22 Dec 2023 11:43:11 +1300
Message-Id: <20231221224311.130319-1-brad@faucet.nz>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; brad@faucet.nz, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6584c00e068c01ef26868e78

This fixes openvswitch's handling of nat packets in the related state.

In nf_ct_nat_execute(), which is called from nf_ct_nat(), ICMP/ICMPv6
packets in the IP_CT_RELATED or IP_CT_RELATED_REPLY state, which have
not been dropped, will follow the goto, however the placement of the
goto label means that updating the action bit field will be bypassed.

This causes ovs_nat_update_key() to not be called from ovs_ct_nat()
which means the openvswitch match key for the ICMP/ICMPv6 packet is not
updated and the pre-nat value will be retained for the key, which will
result in the wrong openflow rule being matched for that packet.

Move the goto label above where the action bit field is being set so
that it is updated in all cases where the packet is accepted.

Fixes: ebddb1404900 ("net: move the nat function to nf_nat_ovs for ovs and tc")
Signed-off-by: Brad Cowie <brad@faucet.nz>
---
 net/netfilter/nf_nat_ovs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_ovs.c b/net/netfilter/nf_nat_ovs.c
index 551abd2da614..0f9a559f6207 100644
--- a/net/netfilter/nf_nat_ovs.c
+++ b/net/netfilter/nf_nat_ovs.c
@@ -75,9 +75,10 @@ static int nf_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
 	}
 
 	err = nf_nat_packet(ct, ctinfo, hooknum, skb);
+out:
 	if (err == NF_ACCEPT)
 		*action |= BIT(maniptype);
-out:
+
 	return err;
 }
 
-- 
2.34.1


