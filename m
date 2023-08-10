Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064787774E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjHJJtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjHJJtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:49:43 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A8211B;
        Thu, 10 Aug 2023 02:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvbyTy1LszRyuUrLKH5V+gAEfC4HOz9QBwUA6tW9HBpLeKIX3eltbh29pk3bARh9FFTYSxUDMMDBKtnPDo/vX7H28uTqTQApfkWSC85OuJvJlz2Hh2XfZLF7vyJPYVPXPF8h0Bohga2uZzjjjZ2zgfGxb+dRV37DRBAx3djlHGHmqSDBJKu2zJ/4wW6z7XSHZPlHuhAqPHALHBTdMhxLXTPsskBfzGtkabbf7XObZ3uyhelj3++bOnNm2f395D7NaVc187qog/da3qSjx0Xic5YDolqieZWUxnlLJ4huZ3/3jcM2kbMyqtOKaXwT5YLGoPJvDxHRlK4VNFhAj+bdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXNwtCa7wV4WemP3Z11V7hF5X0Xdv87y9udyU2WOwxw=;
 b=javCBRbO0YQYsVGQteNhcdVB8l2Jcd+kdPRQpYB6KLxUjcmFdSvzEBZwRMBXxNf3UzTO0jsih3QcXoUrVnjux6YQeXA75R8VjeFyiXk52yQEO247WYRpcMX9pNH3QO5wl0SBZe/A413EUzGp4NNWq3YPb3il3wrM7UY85EcVYjbF0kMxXcBEds3OSxb0u1ZHVr8k7SbV1AHwhHm/Q8yaEcugfvLuj1sOyxJqbF2lDdJAO/YEdzn2OTwjLon6pZAYb7qncJHeEzhXUv15qtyK5XT5ixAL9w7OBx1gRB/SkDukdBjDIqV3FXGVERyvVU6OcRvgN9ewC3Eaj0oOWLq/7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXNwtCa7wV4WemP3Z11V7hF5X0Xdv87y9udyU2WOwxw=;
 b=lP2XJzjFAS8/tQjNfCAsFH6C8toK3wThXC42iL7YF5rFTIL1dLjtUDs+Szq79+d3UR5qtklZV/sEoj2+8SGxa4UHFqyVCc3oVTmiu2T67eCFRpdMAfEIkgAC4CLxcPaWIucLlER0JY46vmSvWUr+yWL1TPonEedq3bw41xA8LRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 09:49:38 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 09:49:38 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: sfp: handle 100G/25G active optical cables in sfp_parse_support
Date:   Thu, 10 Aug 2023 11:48:17 +0200
Message-Id: <20230810094817.29262-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d93a0af-83d2-4676-5358-08db99871c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJKiZWxAROZfqnncZ7S9KeeHyihqnsHmwE5q0DD/2A878YlezunfoQnLyPMfViAdb1fjqJUeSlWXC6onTLV87Tg0f6w7ML02gzrlRvsP6//zvCTBI59wUlLx0qhOikk4E4iV8cz7DHfa+v22Wzrn6GAoEN30BQRfBsHmf5traO4s7/C+Pg4qMij9/IpuTv8ZECMu54AEerelu31YyASa1brjaR0kmJHAVeEcBejZL8B28I82aAI5oshzc0Cej0y8jm4vorv8JymGe8yPx8VNKRk2TSgLn8XOabJwtwA58u0roQByaNNmr9rhKm/t2GGeYYWOMn3XEVWIXFdmMUPmIcB400R46vU6M6gb7tBosaqUPHTpWRQInDVg8HKKjzUUL84837jX2yKbOEoJoAZpJ5zhJNHKT6sN24qO1RWUtLnISWUbZA49vsc1wKH4Jm5MHObLa8lyhI4JT4RfE2Z/O+XIvBGcV1flzA5cDbXxKPiCO7i+GZIkrPieD0saxu4uv1twHKAWp24PyrqPUPY8nMGe5iqcrfEZm3ODQwAK9mDfm7+wts8fG/Kj+R6Znd89xD61W2cGcyuIOWbkkRDcnFEffa/zYP3lJhNKesKP7mlWD/yXgUHF/JKJeBih9i7/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39830400003)(376002)(1800799006)(186006)(451199021)(66946007)(66556008)(36756003)(41300700001)(66476007)(2616005)(5660300002)(54906003)(6486002)(52116002)(478600001)(6666004)(8676002)(6512007)(8936002)(316002)(2906002)(86362001)(26005)(38100700002)(38350700002)(4326008)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vdfse0efv/mhVvC8oJBzjDhXR+rsFPrnGwymQbIrP7gNPIWZMLpa3dYEvu6a?=
 =?us-ascii?Q?2hXyeoNyrxIZYC8LUrWBtu9x8LboBdCrzdWyn4yurcpmhACQzi47X/PYxGlv?=
 =?us-ascii?Q?Atw84m1d6OY6HyqZYZMu3XuSb9O/hagcwZzkaELN77wW6LiZNp7rG/3DRrn7?=
 =?us-ascii?Q?3SHa7xFZnnx1mRxDQs7Ply64/BJUNM76Bh2dRlNCkLxtZeyu+RV1uc6AUxM6?=
 =?us-ascii?Q?2YF9nfJ2J0EymFjxcT5yyjr4faLyhxVozEtQghlpxEFy1LuW8n206K2gofYB?=
 =?us-ascii?Q?THc3SOBOZbs8Cq4aW5cimJ6/O5imSElr2BVuPCxrIKSA53bg38rQLY2HsKXA?=
 =?us-ascii?Q?p4wnwR3SvXFvSvBBCiT/HykCAy1ru7SV+2Oqo2cce/02srmUahOKEJkHyyMl?=
 =?us-ascii?Q?W0OYFEh0uh54fUoEXYUsytsqqfzVotlFcggVepO6cDsZCNsvjiaQjF/1J8Vn?=
 =?us-ascii?Q?KpUv95Ks5UnpBo4AdmM5x6NgDaD4jU3Kr84+Lw+dSA2+3D2wtaKY12eraMge?=
 =?us-ascii?Q?U7EW+890Vlhq2YzmUHrEso2jAJ6MsaYcl9O3nxjDVVEIevSX6ubxEzREnCX4?=
 =?us-ascii?Q?YBhoM2hC0QQpWvGyHRMDPGn8cvn4cP3rujoCTIOxiSbHJMq9czmlciamS4Fx?=
 =?us-ascii?Q?fugcER6wwEu3NWGQY/5XeIC6eyBCIabGaxX2Bxw2Ch6IJyI52/39ARxJPaxs?=
 =?us-ascii?Q?C0jqtdewHua159df7OAMgceb/N2nCpVX3nNfpauNwdZpprHHDkzH4zZvCup8?=
 =?us-ascii?Q?ZKMtxlfN1O9I5NXwSYpMjVQBumZ3sp6uaDnLbt5VngDnP/CQpET9SmEC9TVk?=
 =?us-ascii?Q?E3gQp7WMlBqpiJUTtHXfyox7aA062NMxZ3rL0uv1IKrjWY7ThM1+MKOkD0Fn?=
 =?us-ascii?Q?DBqfmTHL8bqcIh+tdcX1yFi8M5P8OA+rrsOTUPgkdazSTfLxOQOVVGlcKrQW?=
 =?us-ascii?Q?rGo0jehLsz71jRQLuKxa8/kru6ti+aSEG3gHrgSdEu6EB+8MkUNanVJ2nKAb?=
 =?us-ascii?Q?9dfDM9S8SS8qM7pozUJRU/gYmMvYjMfD7tQ3IzDhJETiGgIRSWF2azTTQC6A?=
 =?us-ascii?Q?6lVXxFXloN0GcwaNm28LT2p2fwyFzAhXolhs4VnGdX6YOKG7hOL7Ac3VsGfd?=
 =?us-ascii?Q?NXsIxbQqgQ9mDT2mAx4orKfoT/OX+Wjxdx72SuqPOyptOJY/C3Wp7Y8qKNRz?=
 =?us-ascii?Q?NkbkEyF5eNZvQXs3FpxxawtPcJP6V0VtowPJhHxnrxjs5CehSGABHRu5/vCr?=
 =?us-ascii?Q?H9UPred5yyL8Yk7rwnsRtHuUDjbW/zlaWi7olaqOx394GT1ir5D1CQEvsaSt?=
 =?us-ascii?Q?EwrO5bq5cFNTX+2Bz75cs/8VHWBSxPVtJ6AgGVhTy8nv4GAgJKMTFjCiR4AF?=
 =?us-ascii?Q?VWxStrTayfXGmGjQcl9LmQiyeCcy9YdQRp27zp9p2n+dwSOLByd1RkclGTV9?=
 =?us-ascii?Q?+ZlIdGWpE/uTNus2j0aqqoM/XMLLmrgFDZ/chcJ3SHgeSCR5mX4MtAw+l6vR?=
 =?us-ascii?Q?qg5rs+AyRARrKHfQye7TYqPBP5YcQORAgh7WGg6egU6GsUACehyQYb5X74hG?=
 =?us-ascii?Q?WHCH0wpRFfMFW+YqpVMfoAUFvUPplBu3XPLe7zrS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d93a0af-83d2-4676-5358-08db99871c65
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 09:49:38.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdnkJsOI+Q12Evi3/z18w86kKWjIieJzCeGaoOLSwFCOiEgJWHeykj2pl7G94E11NwcZj7mtFHmcBDR0Azxe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
for active optical cables supporting 25G and 100G speeds.

Since the specification makes no statement about transmitter range, and
as the specific sfp module that had been tested features only 2m fiber -
short-range (SR) modes are selected.

sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
with compatible properties: 100000baseSR4; 25000baseSR; protocol 25gbase-r.
Add SFF8024_ECC_100G_25GAUI_C2M_AOC to the same case.

Tested with fs.com S28-AO02 AOC SFP28 module.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/sfp-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index e8dd47bffe43..db26e1d8a10d 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -258,6 +258,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	switch (id->base.extended_cc) {
 	case SFF8024_ECC_UNSPEC:
 		break;
+	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
 	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
 		phylink_set(modes, 100000baseSR4_Full);
 		phylink_set(modes, 25000baseSR_Full);
-- 
2.35.3

