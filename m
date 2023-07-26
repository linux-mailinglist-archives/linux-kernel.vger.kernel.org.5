Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4276387F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjGZOI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjGZOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:40 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96C2D70
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:08 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140707euoutp0180e220e3030e8be267c8bdfe244ba76d~1cArbKVJc3211332113euoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140707euoutp0180e220e3030e8be267c8bdfe244ba76d~1cArbKVJc3211332113euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380427;
        bh=N/tDn9xxgtPj3eeWaK+OzmB4bUzNii0EGpI6o50nYlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNaW5b8TJXaGTl1SEuaXc3ZPzT0d2nuEoslVgvOznQrgb+q/d3VchRseOWur1yssr
         +H7P9gKV9QvqmRVOmPMZc8ggqAvdsuCPJ+7OtRJog09Io0I752iv2UyIRr3Ut0VhSW
         UUxo/Kz5iL/QA6svZHhypp0DmctgIICynw76tBn0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140706eucas1p24789a1a06dfe1ac64f6f1096b26f3d07~1cAq-VuOC0231902319eucas1p2b;
        Wed, 26 Jul 2023 14:07:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.66.37758.A8821C46; Wed, 26
        Jul 2023 15:07:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3~1cAqhUQ8V1609216092eucas1p1z;
        Wed, 26 Jul 2023 14:07:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140706eusmtrp2578967f01f9a76cc3d031fa9ca6dff29~1cAqgYz0r2063520635eusmtrp2I;
        Wed, 26 Jul 2023 14:07:06 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-1f-64c1288a133f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F8.57.14344.98821C46; Wed, 26
        Jul 2023 15:07:05 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140705eusmtip1a687fd37e974447dc1969db1ddf960e4~1cAqM8dOl0182201822eusmtip1c;
        Wed, 26 Jul 2023 14:07:05 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: [PATCH 10/14] netfilter: Update to register_net_sysctl_sz
Date:   Wed, 26 Jul 2023 16:06:30 +0200
Message-Id: <20230726140635.2059334-11-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2c/avg4vPZt/jpX3RnR1MPO753JpVk+kt3sutXh5dmO
        PQLJGG0galaMCSEKTMWbjBm7ip8D1k0GjCOwdQ0RNqphTPKoEPwFSgEDlHRtPHj53/vz+bze
        3/fnc/fl4aJSUsJLTc9ktOnKNCkpIJo99/teKVz7g2r9OddqdKn+dy566PoSR5a+YwRqbMvD
        0KhnmIuai2wAGZxBgCo7/wJopGSYg0JWDSorNGCo94Qa/dxczEH+NguJDBWTOAoYRwHyWJ9F
        xsbLBJrpGQfINH4FR5enQxiasqxF83MW8nUxfc/XDejynF8Iuqn2KkZbHVn0hZoYenBsC+2o
        O07SZwLVgL47fwmjiwz3SHqi4wpJFzfVAfpUXjug3bNWDm25P0PQU45Vu6k9gtdUTFrqQUa7
        Lv4jQYp/cIiT0bLp0OScHeSAQlkh4PMgtREWzOvJiBZRNQB6b+4uBIKwngaw0lwK2GIKwJ7v
        6sFjh29Wj7ODagB/7GxZpG4D2Dll4kQokoqFfePXFqhllB+HFy39RKTAqa8xeMvzEzdCRVPb
        oP+P4YV3CepF+Nu/Z/GIFlLx0KM3cdm81TB/wLTA8MP92oZZDssshd1lI0RE42HG4CxfSIPU
        Az5sH20gWPN2+OArB8bqaHinq2nx0RUw5KrAWMOZ8N6P/uayhQ3AKn1w0bEZHusfCQ944YiX
        oL1tHdveCktODYJIG1JRMHB3KbtEFDzdbMLZthAW5ItY+gVYXFm6uI4EDvhdJKtp2Dps5hjB
        GvMT55ifOMf8f64V4HVAzGTp1MmMLi6dyZbplGpdVnqyLEmjdoDwx+151BVsBTV3/pG5AcYD
        bgB5uHSZcMOHHSqRUKU8fITRavZps9IYnRss5xFSsfDlLd1JIipZmckcYJgMRvt4ivH4khws
        ZZ+K6h+Quw5+k7vjjY4y2+Y/HQmaZN9Y/7W488FqtFM9etJpObxy17e9Uq8gOuG8euhGaDx/
        riCx3TWdINsT85yzyJht4x9aSd9wBrzC7igbuUReYe/1vc3IzXmGvs9alyuMZuGF8cQxccGn
        G+We/ZVxieaPiaGJt7wx1ttJuqr37R79yTJuXK120wfCV8XlMwnBdzTPrLhYYUfvxZ5QbPN2
        Ibdi18OzvnflqXPnFIHkzxVHV6m+z13yibyrJDpz4pb3+v72kVIt/sX2Nwefyt0q2TtyYIdp
        b7bj6dDs85IjqbL8yXp9w9WM+I7eo8fXNHZW/Sq+rol11Ky35t083SIldCnKDTG4Vqf8D82I
        EJEnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd1OjYMpBvO+WVicWHOb3eLvznZm
        iznnW1gs1u1qZbJ4euwRu8W23tWMFs1bvzJaLN3/kNHiSf8jVov/C/ItZnY1M1mc6c61uLCt
        j9Xi8q45bBbN8z8xW9yY8JTR4tgCMYsJ606xWHw7/YbRYvqbq8wWp778Z7L4PEfD4vePOWwO
        4h7vzp1k9JjdcJHFY8vKm0weCzaVemxeoeVx67Wtx6ZVnWwek28sZ/R4+/sEk0dv8zs2j/f7
        rrJ59G1ZxegxsXUPo8eh7wtYPeb8/Mbi8XmTXIBAlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5Vv3WAu2m1d8+rGesYGxS6+LkZNDQsBE4tz3
        RuYuRi4OIYGljBJnb69k7WLkAEpISXxfxglRIyzx51oXG0TNc0aJvytOsIAk2AR0JM6/uQPW
        LCJwn1mi59caJhCHWWANk8TJBe/YQaqEBZwkLt9/xAhiswioSlz7M5UZxOYVsJM41jidHWKF
        vETb9elgNZxA8ZVrv7OC2EICthI9U5+yQ9QLSpyc+QRsMzNQffPW2cwTGAVmIUnNQpJawMi0
        ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAtbDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCaxiz
        L0WINyWxsiq1KD++qDQntfgQoynQ3ROZpUST84GJKa8k3tDMwNTQxMzSwNTSzFhJnNezoCNR
        SCA9sSQ1OzW1ILUIpo+Jg1Oqgcl24xGljT4l5bY2mct0O2oEBNdn7La6k/cwsJMtn7OuhF2p
        vtpDN5spkzFxwqfrN+b9+Dgj4D7v4n9ZwiXRoROF3u2/x5LIbRKWJpp9dofS89Qcke/HA9m2
        M9w47iCq4mWm4bMhovx6aFzWiQPcheIm5dybr7ifqzWapOIccHxD3OX1UVwP3dPmvpY/pHne
        JfznZc2S7VOKrY7H1Uc9NHkVP3vLy/o11xiD7q39+5WhNatIOjunatNU7gU/Wu7o/H/E+1Cv
        odjZ4MPvEy7JAa++xXck6az7yzr148+IaetvM60983DqMWaGl7tXpapkq9iq6oocU2yILV+1
        LF82rYEv4fcFxvfBomfzrxX8VGIpzkg01GIuKk4EAGwH1juUAwAA
X-CMS-MailID: 20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140706eucas1p1b11e5f0bd17f0de19af9608cbd8d17f3@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the effort to remove the sentinel (last empty) element
from the ctl_table arrays. We update to the new function and pass it the
array size. Care is taken to mirror the NULL assignments with a size of
zero (for the unprivileged users)

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/bridge/br_netfilter_hooks.c         |  3 ++-
 net/ipv6/netfilter/nf_conntrack_reasm.c |  3 ++-
 net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++++++--
 net/netfilter/ipvs/ip_vs_lblc.c         | 10 +++++++---
 net/netfilter/ipvs/ip_vs_lblcr.c        | 10 +++++++---
 net/netfilter/nf_conntrack_standalone.c |  4 +++-
 net/netfilter/nf_log.c                  |  7 ++++---
 7 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 1a801fab9543..15186247b59a 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1135,7 +1135,8 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 
 	br_netfilter_sysctl_default(brnet);
 
-	brnet->ctl_hdr = register_net_sysctl(net, "net/bridge", table);
+	brnet->ctl_hdr = register_net_sysctl_sz(net, "net/bridge", table,
+						ARRAY_SIZE(brnf_table));
 	if (!brnet->ctl_hdr) {
 		if (!net_eq(net, &init_net))
 			kfree(table);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index d13240f13607..b2dd48911c8d 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -87,7 +87,8 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 	table[2].data	= &nf_frag->fqdir->high_thresh;
 	table[2].extra1	= &nf_frag->fqdir->low_thresh;
 
-	hdr = register_net_sysctl(net, "net/netfilter", table);
+	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
+				     ARRAY_SIZE(nf_ct_frag6_sysctl_table));
 	if (hdr == NULL)
 		goto err_reg;
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..8d69e4c2d822 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4266,6 +4266,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	struct net *net = ipvs->net;
 	struct ctl_table *tbl;
 	int idx, ret;
+	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4282,8 +4283,10 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			tbl[0].procname = NULL;
+			ctl_table_size = 0;
+		}
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
@@ -4353,7 +4356,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 #endif
 
 	ret = -ENOMEM;
-	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
+	ipvs->sysctl_hdr = register_net_sysctl_sz(net, "net/ipv4/vs", tbl,
+						  ctl_table_size);
 	if (!ipvs->sysctl_hdr)
 		goto err;
 	ipvs->sysctl_tbl = tbl;
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 1b87214d385e..cf78ba4ce5ff 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -550,6 +550,7 @@ static struct ip_vs_scheduler ip_vs_lblc_scheduler = {
 static int __net_init __ip_vs_lblc_init(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
+	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
@@ -562,16 +563,19 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			ipvs->lblc_ctl_table[0].procname = NULL;
+			vars_table_size = 0;
+		}
 
 	} else
 		ipvs->lblc_ctl_table = vs_vars_table;
 	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblc_ctl_table[0].data = &ipvs->sysctl_lblc_expiration;
 
-	ipvs->lblc_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblc_ctl_table);
+	ipvs->lblc_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
+						       ipvs->lblc_ctl_table,
+						       vars_table_size);
 	if (!ipvs->lblc_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblc_ctl_table);
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index ad8f5fea6d3a..9eddf118b40e 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -736,6 +736,7 @@ static struct ip_vs_scheduler ip_vs_lblcr_scheduler =
 static int __net_init __ip_vs_lblcr_init(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
+	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
@@ -748,15 +749,18 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			ipvs->lblcr_ctl_table[0].procname = NULL;
+			vars_table_size = 0;
+		}
 	} else
 		ipvs->lblcr_ctl_table = vs_vars_table;
 	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblcr_ctl_table[0].data = &ipvs->sysctl_lblcr_expiration;
 
-	ipvs->lblcr_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblcr_ctl_table);
+	ipvs->lblcr_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
+							ipvs->lblcr_ctl_table,
+							vars_table_size);
 	if (!ipvs->lblcr_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblcr_ctl_table);
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 169e16fc2bce..0ee98ce5b816 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1106,7 +1106,9 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 		table[NF_SYSCTL_CT_BUCKETS].mode = 0444;
 	}
 
-	cnet->sysctl_header = register_net_sysctl(net, "net/netfilter", table);
+	cnet->sysctl_header = register_net_sysctl_sz(net, "net/netfilter",
+						     table,
+						     ARRAY_SIZE(nf_ct_sysctl_table));
 	if (!cnet->sysctl_header)
 		goto out_unregister_netfilter;
 
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 8a29290149bd..8cc52d2bd31b 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -487,9 +487,10 @@ static int netfilter_log_sysctl_init(struct net *net)
 	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++)
 		table[i].extra2 = net;
 
-	net->nf.nf_log_dir_header = register_net_sysctl(net,
-						"net/netfilter/nf_log",
-						table);
+	net->nf.nf_log_dir_header = register_net_sysctl_sz(net,
+							   "net/netfilter/nf_log",
+							   table,
+							   ARRAY_SIZE(nf_log_sysctl_table));
 	if (!net->nf.nf_log_dir_header)
 		goto err_reg;
 
-- 
2.30.2

