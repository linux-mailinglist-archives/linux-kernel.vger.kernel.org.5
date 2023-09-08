Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D17987F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjIHNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjIHNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8719BC;
        Fri,  8 Sep 2023 06:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1sx+59DrrqIf9wVvMB5jpsK9cusDORMgyq7uUTEhwEHdQLvC/LYbFToL91WcFugj4nqQwXxhGQiVvEmatHTLcpR9UGcdJsEWzRL0P7LWMb6clOYh+KivnNawfnsxnq+XJwAkwM01ZAGOQI2HRNgEsig2/sWZxR2bouw5DP5WHVn+33xRrVWpRN/8XnLJF7YeLZka1YpVpwT++RpHK/6R5A3xnm2ODgP1xwUYBJwVFh50H9ZsOgPiSP/3DfhKI9I7zzL1WK4szDL1262dYusBrNRYIXLcGbpsBOtACbNMiC0jesM2KD873EGnfDGvFLRQrI4AzzyWtWE5ttLd+D2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjb7B1O9DlPIb0eyKB2G/SgS2Ntu/1itOg2hzWof3RE=;
 b=nMlKtWqRciqpB+jRNWS7rpGXlqwAoPTC10ppV2Zm38122xcIx711Wq1r8X6tgAnGR8lQB4D20MmwWNmJPYyFcKNhQLW+Xir8goITxwGhM13xl4A+Fn4nKxPJ8SUTy8lkqCF8OOJvUNkTS3u5PGDbT7RHFAY2CVVHVJ+Y77JeLtIE7EcgDMu6dY4an9QkBQ3rMfiyMgsMCm0Zejpjb1U6ZLOb3l5EBEvOIKS+m5xWCBPlefs31ujkTZIY3yXqMnrP7Sm4mR+O1ayvwg2WyE1cW8Er9F+M4NSGEPW3I7PTbr1nKAquPSN4lDxYTOw08lq4UK3+OfFsAsN6W4sKdDq3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjb7B1O9DlPIb0eyKB2G/SgS2Ntu/1itOg2hzWof3RE=;
 b=neGwolei2FmbrIAkvNLjjYJu9YpR7pKYlyj8++aM8s7o7dOWyRgwYkcMeBsVkDf8eH4QGTl9dsKuyb5VlLL39ST04M+G45Xf3iyj/7Mi7x/4Y3bbh2JB1JoYs4zz8RrU/xHkI4tmYS2xT4hbJq2kZvTvLQr8X3zVA2SG8koYAoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:04 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:04 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/5] net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
Date:   Fri,  8 Sep 2023 16:33:48 +0300
Message-Id: <20230908133352.2007218-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
References: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7d018d-bab2-4d38-186d-08dbb07044df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dvDPh3O0bMd2iy7K4nJ8yA2Bg8E6z+w/szUNSXNyAXFywz6hNMe1FYgeLkXecEFYcSyYXbkTv1oujUgJ1Ja4LhuwzkOzgoCprQCKfxPGGKs1lccPatYVm6/mCXHWmP85MaXBxh7OFrF8azWS4ueiOYOZQRy32L6htI6oq/lOEIKiG8Ko+MlJeWugr2gmrgYb+iwwIDedz6hhyIIDMUyajYXclJn5tQcu5We4y/i67YQXXmv8ZTK8nifA0lq0oiJgwqlvsXozOK93eo9J1luSfqmSra9SPXAoABOCrNy15i71RqbOe18TY5xQEiUP6f3wFCxaj1Wf+JAtFx+7Gvj1Fkgt7RsfBugCWU7Pf+4qaH/lFudYxVV6FJkmpAOxsDitPrTxvsPFQfgqD/vhKjwsdEugl/29/XSZjBsouwn/5CnMyahFzBphi1XBexrBmsA/7ElHxmZHDlWWJQzNBrPyoUoZscOdyGXET1bHAevo5kSO+wTW8FJe87VYnJK+zvkYRAGPbC+BQRmjy+uhMwKpn3IxBJ6CDP/vUjClIUGhRTn5iux4MfQxOhGyFuou0OLvLcr851+QRn3Z1nOyFmpbsudTJa/MRiAosBA2d3Q+TjZqc2D1PUku2g1OdgcTBUF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWv2FmCVoSVhez8nJVBRdWsgZ1B5jXKiGoM7XL1/43CQoNiF0m9RqN8N/nug?=
 =?us-ascii?Q?U1yd8D54XE62yZombZoSuVMqy9mW81Q+dmKhpphdiBK1EsMxl11kA6VIAVTQ?=
 =?us-ascii?Q?AWbzqTUExj2E481KHIT3DCzfJBdJVFRn0/OOyLp1QucSpwCu7kpRguifXVQH?=
 =?us-ascii?Q?m24i1kY4YURZRagtS7XfKq1Hs4pwKpNnTuPPe3dl5PyXkfyk0p7RKz3i4Oue?=
 =?us-ascii?Q?ptUXQKuBsvqis6ue+Ls2f6SSUiUtGDWeQ2D/Po47NRgMsckkPdyv8xU2b9i6?=
 =?us-ascii?Q?9+YKTvfOwnriZEiP+daACQQOKz2eAqj3c5x2gb26a1lnMAZcsdK0oDBQMODa?=
 =?us-ascii?Q?CWzTW+yvDTk6AzXGYhMTENWEBMAOejgqIgHt4NxHNKhXM79AqF/U3nYKSOv3?=
 =?us-ascii?Q?wWyn4jyG3n/Z+6TuiXnUZwexeQ841aSgGu8yBlixI1NkdPx0e9Gs8L/2fCuN?=
 =?us-ascii?Q?6Fv5Ftze9Q44FSjkihgpJa+eX7mQD+weY6y4S9ZPUrQR6HxOn6Ep5kt1ER2X?=
 =?us-ascii?Q?lqBZslEdU35KRQuvG5Xm53wwTxRFCO4PlN8eCNtI3h0UYI+ACX6iBw+YdMi+?=
 =?us-ascii?Q?veAig5arnYlCq4jlVjflAbf3b5eT8QhVqLYG3kr9M0FryI3m3fBmpdOgCHty?=
 =?us-ascii?Q?tFlcs2qQeiwYG5Y+BWXqdoSXceQXD8TSMWYDKnG7wlJG8ZYH83LhoUVleSKs?=
 =?us-ascii?Q?LbJ9h0h4ywWju9/OFJjBT9isxa08sCiZ2p0dEdzTTjO2KkuSRTziA0fV4x4Z?=
 =?us-ascii?Q?6AzQsAn7pmUOGf9/UDHnOsK594SNqPpgJrSq8FnB7XK8OrvKMXRWwGA6PgPZ?=
 =?us-ascii?Q?65CyPik5TbAmQIPwm5geNxfj2/17cFA/okdvt+fj72600UY7Yq55/flk7NBD?=
 =?us-ascii?Q?TUN/YeGqfxseJokdUu+l6Tse2TB4obsqJWgkN1pIkcRYSQr75yxEaoePY4cr?=
 =?us-ascii?Q?BzNW8Sd1KK5sB/b1DMo1O+qQL9J9Q9lzSzMKS2U1f2tL1luR/85v6EpRSZ8g?=
 =?us-ascii?Q?VbHQv/n2J0LaqmZx9vR4+0TAcAnJgaoJBvKDK1jeAA5H1OCOQQ+Wojw8NhM+?=
 =?us-ascii?Q?HXDHjNdP7Mnf83Zu37uKFTaKvbqzRyBsfgZh4YFZ/qoIl3npsYaHTjomsuz0?=
 =?us-ascii?Q?kzwORhJq2hPucenNa+oDG+DStM9i8YyHVJF3tLiMR/8lZcYhDJ/ijYIq3taR?=
 =?us-ascii?Q?HuQUD5NxJRFtFuPrPWn6UmDeOxzsiEDVRofReJ1fNxa8e1Ev/Cxln0svQXEV?=
 =?us-ascii?Q?C7VDh7JuR4UcPe+JYhcsH1T4G0ePQ8aN+UhU3Xa97hIckVmrQjcs3ZNxZ/Px?=
 =?us-ascii?Q?u6cNyfdRQubDnooA2Qg2zk7FOdXTzEwV58fcq/PKuslYCUO3eWSaVQbIWu7h?=
 =?us-ascii?Q?cA6kmgDhskxeEWZz+xJMu1oDgfIu+e5HNHCZCxtYh2x8gFy6FkFSuYhN1z3C?=
 =?us-ascii?Q?rYWXBGJ0VDpLi4ZJq5LCIu3hu9jOfSai0LnOWQM5c79pQ3pArwMPe3nxvYQo?=
 =?us-ascii?Q?NTe78ozkhPOuvmu+p0FmVPYJ70a5Wga/m+NNid0WORoAv7Qeum7R25NUF/CW?=
 =?us-ascii?Q?xKfJAtKpM6zGDucrVD9hC/ymLh90AWoUfmSsik2qDwQqMFILM9FQhAqVEbXK?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d018d-bab2-4d38-186d-08dbb07044df
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:04.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3Yr5m+oxh8Ext7jAwy3Wgcv25tXlG84wuheWI72g7z3QFW/zrXeXVbGcTnedPWOgChpmp4GjligOoYzyUDrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4d9423549501 ("net: dsa: sja1105: offload bridge port flags to
device") has partially hidden some multicast entries from showing up in
the "bridge fdb show" output, but it wasn't enough. Addresses which are
added through "bridge mdb add" still show up. Hide them all.

Fixes: 291d1e72b756 ("net: dsa: sja1105: Add support for FDB and MDB management")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index a23d980d28f5..11c917d5ce43 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1868,13 +1868,14 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 		if (!(l2_lookup.destports & BIT(port)))
 			continue;
 
-		/* We need to hide the FDB entry for unknown multicast */
-		if (l2_lookup.macaddr == SJA1105_UNKNOWN_MULTICAST &&
-		    l2_lookup.mask_macaddr == SJA1105_UNKNOWN_MULTICAST)
-			continue;
-
 		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
 
+		/* Hardware FDB is shared for fdb and mdb, "bridge fdb show"
+		 * only wants to see unicast
+		 */
+		if (is_multicast_ether_addr(macaddr))
+			continue;
+
 		/* We need to hide the dsa_8021q VLANs from the user. */
 		if (vid_is_dsa_8021q(l2_lookup.vlanid))
 			l2_lookup.vlanid = 0;
-- 
2.34.1

