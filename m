Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A485E793E89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbjIFOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIFOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:16:38 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3AE77;
        Wed,  6 Sep 2023 07:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2WpI29mUTY9F8175s/Tp0POh2Z6hG6nHPahkBtTVNDnbcfN6Z183mEj6tf5cib6sEVTNtZnzqjJ/jqHZ+B5wv3Eyojrk1VF4Jv0vwClRHQeL7e9u9sL3E+HBKZt85hS9dzhVynDGYE5PaV+ACp99+EyGabx+zIYu/Wez399YTQ3wsmQU6n2D1P9UlVbql0TWUWY6YJrlCLy3JvQN2pIIiSUUXsGCItWzJ6HrJQqOR8me+5tA7XODuXUK18hxV4uZlJYveZGm+b9+RvY2cv5kkFgMKz3pL8u+cHQNDN9dHxTVPiIiwH42F8ayWDeM+k7NbFg1YuVg96Xknlgv2AOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND99i3z84ZiOeDEnaM57wSjeLHmjY5I44oirMiMw8SE=;
 b=Yi95FL7ssBNoAlkHeCHYwMcG++LDRj/8Djw9j3nZXZYvN0k0oKXtUcbIpS8elfDMd7huSedPg8Q1ob0LzO/8U0IsRTbQhaXdd68kfVgQq5YyeKYYN4n3VD9AAOUO8E0rigWkgQPCr7MfFs8HPzxNwKj9vBVGE1GArlHI2zeFHCwkGVaqhl6xJ1Wt5sNZscvkYfWstH/S7F8/m4kpdslGV1Q0dhuyIBYwEIQES/9O/N5GoSmLmSRhftC5cfMJqtf85MHvwHpQU99BnA0R2eX+V00fRg8k7ofuZ0u/zYLubp7V8HL/dwPK9vmsIJU3VTPicqWiPLh6TPsom67ZMghTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND99i3z84ZiOeDEnaM57wSjeLHmjY5I44oirMiMw8SE=;
 b=P2SYdfhZ2LhnFfkcHgo48xuzTI9Gvi3amtx1lQhUSMICCfV50GgzuR0eKtbjbRthzdqhFKCERYY1Jp976ITGsNecpPt8RNy5/2mfMk2yF1Z1F9rnz3ox0VHWcwGHkcXKrLy80+rhB6WWpAMDkjxAqn2mUEiFeE4F2McPSSHajTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8375.eurprd04.prod.outlook.com (2603:10a6:102:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:16:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:16:30 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net] net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()
Date:   Wed,  6 Sep 2023 17:16:09 +0300
Message-Id: <20230906141609.247579-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0077.eurprd05.prod.outlook.com
 (2603:10a6:208:136::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 4450e2d1-c1ac-4915-1ace-08dbaee3dda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6g9+VIsk5nmawL5lsN0EeqgphlpVhW/jldGxlJP13A7GboKCBQyKaWnichwjhjFoHpC/nFeWjokbsHRfhlEWaYCJOgVGcb48eDG+2wvHISjZnDEmuJG8ctMUM6XNcAMUrtSFc/5+uAwqF2nxux5o/bmneBjnJJ/IPB4cLdhibyqt96sftLlWvlOBXUGsFqi3683jaj1K9VbsA2O0KhGzcuYP4ZaKbS0a16pufsKJVhux564VdGLTVaBmaUJ7WD+Fw/mQqWw459lNVeqbqT30ek3t4/eFYC8Lv8vOvAxN+LID2nwEo5Cvj28w8QwW+VGA4pYMZE8h01lSalEWU3KXlGxsltd0A8c18F4EMRVjobEq2pOdS2K17NOBblK9d18pBvopgT+NbaJSwqlQCxa57puD7vXX73U9udLAReakUCOOFzQE939APZkGEfR16iMIjwPBj1KiPv+rCtG3fMNZP6828jG2fLcnL8zYDl1m1pxgvtO04+HQMpoTHGxnVD4XHJ574eQcfRCUFfLE8zGVg8dRmbUDVMksRBm8Covc0v0BTP9gadn1yhLE4GN3X8Pv03HwozuEGnBPxWbjPnbZSpB1ndVxPhYuB3MBWx9gQtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(186009)(451199024)(1800799009)(41300700001)(38100700002)(86362001)(6666004)(2616005)(38350700002)(83380400001)(966005)(478600001)(1076003)(26005)(6512007)(6486002)(52116002)(6506007)(36756003)(66946007)(66476007)(6636002)(2906002)(37006003)(66556008)(54906003)(316002)(5660300002)(8936002)(6862004)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFWcQkW3aXegdu6ExEhrIPwHrHnw050VryURKh+f4/JkG9As+WWsX2HwuR4b?=
 =?us-ascii?Q?OhkkeD9Zk9bziFAtNGpNtMHOHaJQ3jmiaZFFOCPkp23wdcI7C0V9VvmrAU20?=
 =?us-ascii?Q?mSqt91SLe8ZZro/98+e4eaPn0ghajrAF34+oGYJ2U16GOgZY2PPWow84/GWb?=
 =?us-ascii?Q?jnegEWPgqUSRS7Gae0ON7N1TfVGSV4aczCMbSFMGGJyj20RD3xtG9m7IBS/t?=
 =?us-ascii?Q?vyVrdSyumievh3yDVVBm3QN2xoVps1suZecTn+J4EHRWCKZtUWUqj4nay7t/?=
 =?us-ascii?Q?2ZRpsxHM1q36SbMeovCWkIEsb4pZAkQPnh6mooHhzene0ZkrtHriltmJdZQP?=
 =?us-ascii?Q?vKnpiHCYr69gQDW5bMxKoVNwxdhD5aD2EZ/LnDLMJwSV7YeQZVniJwnT/qH5?=
 =?us-ascii?Q?axArjYwD+DpaR2YDLsl7M65pHHiIGlWyrYxIvnesZ0745mBARCwaJpBY/rdL?=
 =?us-ascii?Q?IwMWseksSC+vCSqYtb8ylEIwHChwseAS7qBL2VeIpQe2YLfgXMc4NAXWL9tS?=
 =?us-ascii?Q?G9NVlR/u+iqbnx9UuPJJK2cPUS2tNM0M2xaCSz0NFirX8vXIgqXNv1QOCMS8?=
 =?us-ascii?Q?ABM+L+BEkMcRapowBBVkV5w2qRn52K7VUnBWgnXC3XwtNTxmRPCAkyeVMhMr?=
 =?us-ascii?Q?IvMaGJcOfgoIobgHPzuNfjsxGt258TuQzo44/fGf5CMMvASCMNpYvFfYhA1e?=
 =?us-ascii?Q?+zJ5luZx7EVqBueOpMZSfT7a9f7lwf4OYUYsHhSpx4nEOrBRq7czddB0c4Wl?=
 =?us-ascii?Q?DQ3oAoa23g+VZ71jmyXIG8Q5U+EyLZZPZ9ebP/43cbmy5PzuDSBbRZ/4WYWd?=
 =?us-ascii?Q?PbtnAEvHhQAH0wtUVaw2jPHfKgGbfuPIKXrnCADvgqma/fx4tpolXXwGqI6e?=
 =?us-ascii?Q?KQD3R6r58lpwTWoq9AjHITRlr11Rbl3qosMcm02EoRDEjrsTtbV9KZjKuiq/?=
 =?us-ascii?Q?zxoJlOGGedfaRfdRIYQYBMBL+wJhk8zvXKz1NHBHpjuGscVYWx1AZPXpAjt7?=
 =?us-ascii?Q?wc7ozlj854C9bqiC7QQJC28rVNidqmMYiwMEXRVDJBJkExVy3e8a/tMAdjB6?=
 =?us-ascii?Q?/jJcyxEiVpD0lQkxK/lCx9PNi1BaZ4cqZZUFAU6w58eeKzRWeQwMuhQUffsq?=
 =?us-ascii?Q?ZIr6d8uckLOCw8ttmHc9GXDipkOdk3hDYL4OFx7nU+EQDREDKPK9fNbbyVG4?=
 =?us-ascii?Q?7jjcvNEXKEooE9nLHfnHcF4EOt/VM2vy1RZ1IncWYiZfDdi0IUK0OYE3xOiB?=
 =?us-ascii?Q?3EuN0VqiKx1xrULdb1CZoPT/IX0ObkY3lBhz/iiGrU3j2hjysEGsEdfG31tC?=
 =?us-ascii?Q?ftEnp9gN1B5o4L5zVZHEsqQPMtGXVMofGzb6k8wisinM+JNQyMusPuQpzBg+?=
 =?us-ascii?Q?IJPR4T/03PcARbz9hc2Rnm1TU8UHXeuVE+/KAJjl//G8MT8+VUnjl8pWQwsq?=
 =?us-ascii?Q?PFu0g6/W//nVr+/xxHLazfsysmqTQQ6zP+28yV7FBAHZuPVJIhw0O/HB3AS2?=
 =?us-ascii?Q?tAZqJO3GLWcEak1Wh9evYDCWmIssyUkicM5zjdOfaKG7uOUHlHnrc3h3pwP0?=
 =?us-ascii?Q?zNSqfdZgDM7Bg2kQCh/vAhU+tD4YK/v/N7W3uQ9ACH77E4j7ugvCGO0urnAB?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4450e2d1-c1ac-4915-1ace-08dbaee3dda8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:16:30.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXrh8bd66LgxThVtbS50QrcQl+gIPoHKlDccFJH54iXnwiKO7p2EtLmiBXp7kmfaGJNwY8rGAa7LqdrLgxj+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enetc_psi_create() returns an ERR_PTR() or a valid station interface
pointer, but checking for the non-NULL quality of the return code blurs
that difference away. So if enetc_psi_create() fails, we call
enetc_psi_destroy() when we shouldn't. This will likely result in
crashes, since enetc_psi_create() cleans up everything after itself when
it returns an ERR_PTR().

Fixes: f0168042a212 ("net: enetc: reimplement RFS/RSS memory clearing as PCI quirk")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain/
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index e0a4cb7e3f50..c153dc083aff 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1402,7 +1402,7 @@ static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
 		return;
 
 	si = enetc_psi_create(pdev);
-	if (si)
+	if (!IS_ERR(si))
 		enetc_psi_destroy(pdev);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, ENETC_DEV_ID_PF,
-- 
2.34.1

