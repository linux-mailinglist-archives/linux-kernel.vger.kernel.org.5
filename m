Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA917BCD27
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjJHIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:05:59 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC2C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh+poKJ/npvP99XN4wMMaQe5fxgM+tTp1UEgUY0Z4/YU/OYlC11vOZvY7cSJnxoS27WKmaUObEKunUQP7FXCbdIBnB3yPCy698fJIqMMjGdP+dMTtzl9QWnUL5nUXq4skDIfkntaNrKZorOvSf0pEVhBj8Wh6J1TX9xjCHb64nVQFOcfFCeMyFNMsQcqbHwWgc3m2Nj9EW0/2d3bflJibN66e3v/H5/8IMwzSognwB1UzuVd4BGaUrlHk5cUBfIlEwO1pdzHEC+y8Y73CTbnGJYniKz2h72Xg1Wbsk4ZCVT/mwLnNCx8stDuIOm26jv4B3vjMZFRBdzPWrYlqQyJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qln6DDhf7ZqVMChbQfOeNOHCSw2KQjJ+xxWsHIaackc=;
 b=AIXz2W3LvJKBoO/YHE/pvUY+a5FUo9jVJQg3b3DonKHk1nH+DLuMarS0ZUPi0vilGFEuUEz8cn/Vz1Z7brSZMraM44WRZT2ZDReJt4laeFc2P3CMx1b6DeJZwnZCNh8pv9y3e5DOAXdeukE9D5KsmPqGYaV3GU+zriJ0jAD3mvihVHLVeOWT7EAs9Nili7mx7NJ9qhqOsJC21+r036YnP7eeJ7+j13QofgI27g8cVnwUjLofh0ljvmKHMnvaVkRZu/g4oj53yCPkL6kqtOIohwOHmPl1k5UNdfXMYTIsYiADqM7ShXqJC/CW4/sUWW5PssQczkPFraAUp4ej7ZV0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qln6DDhf7ZqVMChbQfOeNOHCSw2KQjJ+xxWsHIaackc=;
 b=PIUa/Im/k9oDrw8BlWPAJ5862L9dnrn09UA0Ji2YoCP5cAIpDL1lFVnm92/2YZ5WDOtr99Q5eLdNDeP1ImGjP2I4h9NvujR/97pZ3P4A3m9VEYIByJGGhM8jWhe+hI1+N68SIdUhXiEc0O5PLoB+x0ySypRbMIregTS28E+cLbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 08:05:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 08:05:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] nvmem: imx: correct nregs for i.MX6UL/ULL/SLL
Date:   Sun, 08 Oct 2023 16:10:19 +0800
Message-Id: <20231008-nvmem-imx-v1-0-cabeb18ab676@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxjImUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwML3byy3NRc3czcCl3DxDQzS7OkxJTENFMloPqCotS0zAqwWdGxtbU
 AZdMJa1sAAAA=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bai Ping <ping.bai@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696752640; l=589;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=+e6qva5Z8/fSweDtxOF7JyZOXWKXNWAJsVUb+m6a4LA=;
 b=j9iIUHYvXvkezLToNwG2ZPGQc3OaL01bmlzRwhvpQmXMKNcfG8ujbrINHpsJzS2+uH0LP4sen
 kb8wAetEim5Anlse25cvNM+7H/BLLKMuookNmp7I1PViWk2lSFcAQ3u
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1a7aa4-23db-4325-3b6c-08dbc7d5644e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80NSd/biZkGYX8SwHefbMiqa+1pv4RvnO6XRz8DmdlswSir7SerKqkTuMz3PKMWJK17v2keycF94S0UDrbE2EzgNz4sVcTt/KrcZ7516Y4NjGRMh3/DP3rmLpFOCe8Q0yiEgKrN1MdzOD5TPaaN/tWWMBE0kDp5151JGAPee9pUTf+vOhMHe7cTdZDNZ95cLQoc6MY57k3WiM3W2XpmAbG0UmL62SQXpggbYnaaiYtWpEsVgXwwGpE3CljeoD8Xl4sI0r9EQcbqSgNjDwB8NyGMaX51NkAqNLhsO0nYGUMo0HW2bQZTndxQJ1tEsKdJRs+Y8E5/cDFj6MZIdQH7HsGGHLJoJb0Ic9vODIm3HGpjmmQ82AkeXNncoVF2+URxP+LvnJF6JAksikz7RHTOuZJy0eEejSItCZqPn6cPKgMmc7yBIsyg/CYJDzaEMK+b2jZCRHGOz8b+HZunQqrcHJYrl82e9qNTJ7XU+/86qv3URVY0fY+V5XKk4zdDUhvFEo65CfvWeyxFeBOdgKJ0kbIEnkm9n2WRU+SVICJ0ZLpCob7rDK1cU64g9M0GJH90Ot9zruDKmaDvAg7K9xU4wyficp/sS6pQxv4TyQWuVujL5pEshuVcBKhYjLkgSeBUA0wLM+U2q1OWlUR8PjPv6gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(66476007)(66556008)(66946007)(110136005)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(9686003)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZLeEdXR0FmRkxGSmg4UFVRTHRoUk0zLzljNVl6cUp4TmhmMkJjRi9ZSlJY?=
 =?utf-8?B?anlRNUlYZUpibVlRQ2xta3BnTXFPdHlKbWJqbzFDc0NMMHExaE5adEVxdVRi?=
 =?utf-8?B?QjJ5cVJLdEZjd1l0RUNuQnJGeVAySmg4anZQMUVFRTM5OTdjQ09wOVo3Ynln?=
 =?utf-8?B?UHl2UlNQR2Z1b2lsTVVJdHRJZkZxMXB2OWliT2ZULzQ4MXltUU5YeXpmT2JM?=
 =?utf-8?B?YlJPbFpuWXpLc1hkMnI2NTRVRFpjNityZzVOaW5icDVBVDJnZWVObXVrc2FS?=
 =?utf-8?B?TnRZWEFsWDFTQkhkV2RvdThqb3BmaWNSdUNUci9UdWkxeW4zTlljbTN3RHFV?=
 =?utf-8?B?Q09wNlNKbXJPYTI1UzMrNzZ5OUdab1gwVk9pQVJVZTRBUWo1b2lad204UW5Z?=
 =?utf-8?B?Q2ptYmJJYmEwak4vQWhjZkpSN3VxZDRBakpsTWkwWEc3QjdzdTVlTU1wZ2JP?=
 =?utf-8?B?TngwaEgrcC9ycWdCM0RyY2NZck1Xc0xJbFM1Z050OS9lK1g0ZzZodjBidU9y?=
 =?utf-8?B?aS9CWGhDZmhrVS9sSW5HZVFKdzJacGJ1dWVKd0ZWYVNIaFNDSDRjSmkzQXZk?=
 =?utf-8?B?cWs4YVFmQlJwK2xkSElBRnhqczBYendONFVxaHFHWWJTME0xejhEVXUydmhX?=
 =?utf-8?B?N1loWVA5YnZ2Y2cwSjc0b3ZPWDl4MVUyZFlhbFdKVDdZRTlSY3ZDMXZLSWNq?=
 =?utf-8?B?enlSTEU4RERISWNZT2VqUjdMTVQ1d0ZKcHBqL3F2QkpCQmtVSXBtZkcxdEwr?=
 =?utf-8?B?cFdUK2JGbXpGd2FhWEJVUFZuOW9yRitSRU50czJ3TEU1d0E2My9TRThMWUUx?=
 =?utf-8?B?L2hvcU83aG9RNkwwTkdKNHJ2cDJuUmV1aHJRQ3VyTW5yRmRjdEcxckRaYTRP?=
 =?utf-8?B?YnVZQ0VTWTdONEdoY3dONTcwZHVFSjlhU21vMHVnSnZEOG1ocXpsV3I1Qm9t?=
 =?utf-8?B?dGtIczc0QW1OY29ycFBkck5vRFBjSjJmZy9Fdmh4UmZ5NDVmSWE1YkRCV1ox?=
 =?utf-8?B?dDBPYjRiZHhYM3hQSGtyV3BGQ3crVWR5ZVhlZUJxVG5NTE5DZTQ1VDZqdXc5?=
 =?utf-8?B?RGRZVVpJM1d5em5tRmpkQXJjSjFiSkRCNWU4OWgxSjBvUG9wTHgxbDNoWlpD?=
 =?utf-8?B?VlFxams4ZWpDQmpRSnRNY0JnVUdYbW5kOTJ1MkplOGF3aFNtNUtwTlUySUMz?=
 =?utf-8?B?SHp1dkkxbUpBVkFONlYvbDhVcmRHVld1Z0dyNENFNlA1NlhFSWJldlllSk54?=
 =?utf-8?B?aEh5YTFTTlNZU2dKWUo2WmFiOC9lRU9uUEVwenJmSmxGOW95TWNtMFVua2JV?=
 =?utf-8?B?UTgwS0RRRERkRkpSQlVFVGNtWTJFUmVQa29DWm1PNEdSWUJjclZLRHNZdGNP?=
 =?utf-8?B?Slo0UU9Qcy9QMUdhc2tVbThTWTFiekJtZkRMRjNFV2hQS0JsZVEwZ0x3WERB?=
 =?utf-8?B?Y3g0WktTR0d2UStSQno3am04eWpKeHhTdjFVVlRweGFnWXJUaTB0bkVYQ2VO?=
 =?utf-8?B?S3BpSHM3TXNXTmJ4cDZ6ZnFQUE96aUJmVWFFZzdEWU5yZkJFZ2xtQ1hWSldB?=
 =?utf-8?B?L2llTElMVW93ZW9ObHBDMm5zY2NkeEl4NWRXQXpBeUdCVEpSKzYwV09NcUVM?=
 =?utf-8?B?MUxDWktUaHRWTHpjb0kxbktLYzE4S1Y1RENMS2UwdW1RMHlDMDUxTHpidVZ2?=
 =?utf-8?B?MWJwWlY3eGlEYW9xMnNtM3BuQ0FjaGVuRWlBRFJUUEU4ZjZwYS93eUswNEk2?=
 =?utf-8?B?QytEeWlqNk9lMUt0bk9rWDJnTlFlcFVhRWlQT0JucWhQSDVYZitteVFiQnBq?=
 =?utf-8?B?MnkyZDR0dEZUdXpNRU9USHhRdVBINXo4RWIzaUQ1cnBwN2NabmRFNHM5Rm1k?=
 =?utf-8?B?SURuNlo3UWlmVVIyZ2VES3AzVmRaK2JJQndlaGJRa1o2Ukp2RHppZ2haS3Nh?=
 =?utf-8?B?eVFES2xYYVdXbVRqUjg4MUMyRTRTci9iREdFbWJGRkRCU0h2MUtKZUltVVNq?=
 =?utf-8?B?WitYckNnbFJSVFRCbGxZb3V1bmhPbUw1dHVvVDBBTkFYaWNmTXpjc1lFY1Bn?=
 =?utf-8?B?cXVRZ0ZRaDc1RmtOOGZ6NVUzSzhRTXpXQWx0TmtFY1RXRnRMM1JEY000cVo4?=
 =?utf-8?Q?O0tuVy+/QDwh2wh79NMoYV/WR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1a7aa4-23db-4325-3b6c-08dbc7d5644e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 08:05:53.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLtkRg0Z+rD39vgFfZWGA3+LiUFdWMqoKZ6hTp/mx+XIT+MBQu4IDh16STEkB6IaN/Wz35scGKtNkLB0+AAmKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code does not include the register space hole, after check
the fuse map of the three SoCs, update the nregs to fix the issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL
      nvmem: imx: correct nregs for i.MX6ULL

 drivers/nvmem/imx-ocotp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 0f0fe5040de5e5fd9b040672e37725b046e312f0
change-id: 20231008-nvmem-imx-1af696badaf5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

