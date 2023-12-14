Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF0812E31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444058AbjLNLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444042AbjLNLIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:08:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135B1703;
        Thu, 14 Dec 2023 03:08:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVBb+1eecyL0gyXwFwLZDn3glGOCThqw7xhpDqiMQjpb5oy43BBI3c93CSCayoS3/ueaT7jhvXmsGkVF36H1mKAs/jObybLvwDyHO3E8Z6/tRBBRbYsc1cJlWTb40JdpKo5/dBcekvOr/sizLqmga6MF7tkc69DB72iOhsKdpD2nvmyipU+0mjr61pXNvMjL5bYTCey6D3k76lQpW3ugOfWzZZGIOSC6Rd8gnFTF+PbCmGk+ovkfe2JLagGJyKbld5zjIYzZrH9+aIo+6q3gDCuC2eOb8P75TVe+0F5iJpJy2Emy9o/TBn+/4uC4wIsrp63hR48cqtw2gHT0UUyjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVzZ5NnO8JZgdZQ5zwM5utERDlEUuQiKkhwmbeAhIAg=;
 b=na27Y82GQK5aoDdZYOjbcJ4+VpF5gNBHgxzdGYRYgHM4kO9Qt3uGGMA/U5wIBzU9yoXhu4cLAt+6JEekL7eJKGOoKgJx88+G7p1oNI6Yu1FCGDcorjjo+v0hhPm0nkoThHFv7Qkr7WmOrwL/MyNNjaF3sss12w6ZUpDDYTWypWxN1iQWI5+cNXLs4IzLflCivQtdXxD8+b3HkMMW1URbxIj8J21FdaWJ/nvToAAQwFS1+tFcAxAxShqhI9/s09yo8q89s8m4LYRTT9yj4vld+wcuOc0YWKMtXETI/GiQ40a0O0hmkyHibA8htR8kmCjgp8d1sNAOF5DaS2xpR03mjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVzZ5NnO8JZgdZQ5zwM5utERDlEUuQiKkhwmbeAhIAg=;
 b=Un8ZCBmushcHe0yHVl5jDcvXweAkwfjHrTKJ240/wtBWQJNVF6YHKF/1W3X3292/YuOw8id6syfGuGdkLqCxTDd26/aQ5DLDJwOmgsDLkvRkJ2zlbZtT9fBVEmJj24Q/LnQEJal/NkL4fGz2ateCjVY3Q76+Pi457XXZFtPf/E8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 11:08:09 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 11:08:09 +0000
Date:   Thu, 14 Dec 2023 13:08:05 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 07/11] net: ethernet: am65-cpsw: Move
 register definitions to header file
Message-ID: <20231214110805.v4k4zu4y2mc5ifmw@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-8-rogerq@kernel.org>
 <20231213110721.69154-8-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-8-rogerq@kernel.org>
 <20231213110721.69154-8-rogerq@kernel.org>
X-ClientProxiedBy: VI1PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:803:64::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f50916-ffa1-4cd0-769b-08dbfc94f473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLVf9DKuxTCJ5bpCZE6ny93POK4ZTSRHPWfvxqurrZ22Pp3xHmNWzZwDqYxkpe2ds0V/sDVnWyNEtyWKkB1yBHaTqkDi8lHu2XS3vUo/iuXMwa5tSGeyjzIKS6ah2rTYT6JUud44ZH3m0lGsTEQOrtW6b7hsxgd8vPF6vlnLWm/rTXgnlCvD5wfToTHYQXMT6IEcdvEVm0KOMbkHBK9QL96frYSP+pphvk1UthFZItYEImVoN+6ULBmW2QPEwv7meDSEMfXIFuWvDKaynE8JDG28qFH5a+N2bhs2B0g5r/01TmtiVcA6ymc2pxH+Lz2bSWi8UmswuvfNmS0FdWlGH+GrZW+pKnc7jfp0mlD6dUyGzqrd1+CHKHPlvVKtpOp3rmbDhqy5Mev6B7lACeVk8lfyp3cm0eY9so2VqtnkGkaXcjex4RF4Il9BKSgcUT4Uj3ctOT0hdyjTQ2tIr+6TkjOaaZWadCwAvQ4oieZecJNlOe+Bwpga3s4yPnHGIG9J3prg6/HHpi1BA+8UtLS9XQmlv/n37fbQjnNXfxARcOv8U+6r3Ffk3zyysiukjtBz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66476007)(66946007)(66556008)(38100700002)(558084003)(86362001)(26005)(6512007)(1076003)(9686003)(6506007)(2906002)(7416002)(6486002)(6916009)(316002)(478600001)(6666004)(33716001)(41300700001)(4326008)(8936002)(5660300002)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdaFkaIYn76xzKKBKxEtWv2zigRt14kffqX4ypPV3udAry3wD2dHLPZRGK3B?=
 =?us-ascii?Q?140DSrQ0BHX7aHjvV+ms78Wz/au3lZZvSoWAE/9XLZ4j3Woo2WXP5uffx6YB?=
 =?us-ascii?Q?MRyFo3qG3yKeTmc3Hk+wQVkx3yENqNFTXAnshTBXXe4krDlEWKdih3JlX2Qw?=
 =?us-ascii?Q?9HATKGoARF1GXjzV+fMTmMLNkHWRr2q74umXsQfouIEOvUM550R+ltAzxQ+X?=
 =?us-ascii?Q?xLMKLBDcWGSTMkExVXExxgTt7ge1ZlQV82h19/1jus5I6D4N2zIW2I3xh0/x?=
 =?us-ascii?Q?ZpKZVjvNp91F9icLOUHWhOcAzYdXuryonyiNyiy/qMm5E3XWrl6O/Vw+PCfY?=
 =?us-ascii?Q?TDseO2ExGo75DQI66F5t4w9SNP+r267hmG0a+Rl7CxAEiFN5Fi59mv6FhaMN?=
 =?us-ascii?Q?GOaTFKsN31C7fBS2pGErt3NCs5mL50tdfdWPrtJs7LqTg7QXCUTLfritLnm1?=
 =?us-ascii?Q?LX8g9P2fiTitGbvKnOMHH2Cy+pJAqXSdltuAYDDdjjlYcxUozGg0lmtBS68u?=
 =?us-ascii?Q?qzpqcU2HXEpuwRXUyXyp/qT2+3eSTMm2iLYH9bkh3wNrKIdq9MIilcyz3bMO?=
 =?us-ascii?Q?PXfJosd9JH6IzGZdTG89yB1Us4zoikXF3EytRcVkySzaEC0iiHWLBUweDJif?=
 =?us-ascii?Q?AnVTl0SaMB+2+IlAPGO22CPRy3hLG/qezP0hT1Jed1WxyLG5H4Un41tjBMDQ?=
 =?us-ascii?Q?ApRwqTy3flMmIjhOBYi+fTGk73ilDkA8MHiDd1etgQbifu2nimNw5VFzXsmN?=
 =?us-ascii?Q?cR5yJZ5gloCpevj9IDgVitKWyVE4X6jv1RfWHe9IuuBe8i85/9eXUVEQLDXk?=
 =?us-ascii?Q?mUWimwEnFCNuquBlwNYLSYQEc2hwkdZLsGNNSl9XDuP5NnVebBgB+JWds0qb?=
 =?us-ascii?Q?eSrYwlDeb83oUsvigIx6RID3b6sOtMtcVLSmnfI+FIlMZGlWTUhthe54pDiM?=
 =?us-ascii?Q?GzeZkfw3epk5YZA6iBxxdGpC66F62k0eot+E59/hvwDiMgoFwVy/E6iW7A0E?=
 =?us-ascii?Q?DwLWwLcz1icqWCt1HDtenY8PxIqwtNRIFcHt8M/SQ1DP+SLYXEgOJqmJUSgN?=
 =?us-ascii?Q?/Nk9JnYZrAoe3HohaIlaaaHbGZ1m/SQwHu5IIVbwg3MZJfaJhsQ7gPwMoNXJ?=
 =?us-ascii?Q?teZzpN6vZySQp2AfENPZ0+WB5QEdPvSsoev1A97MgqvAYzM4/nvq+rHM661B?=
 =?us-ascii?Q?pe/alX6eFTcVu9aBP+kEVjifpNTD0eZkfD+g9pTnmI1Y5Sfati3jgbiN+a8w?=
 =?us-ascii?Q?RF4G77uX3leko5kt+sfOZ3QGzZgBisDvZS/WyoWj5yo/PkmWNcobOUAlKnlZ?=
 =?us-ascii?Q?eC8HGRmYY4wqzPCb9GO6SUM0w5KGnK2wMaidv7gG5+bukLz8EEjI6MMGI5z/?=
 =?us-ascii?Q?Fg80h5f56EG3HGQwRxu7RtxcUqsJvjRxa8bIQxz0nc3lKb5ICaI0k1qv5p/3?=
 =?us-ascii?Q?SnWj50qcBsbdcI/zC5fdlMU52BYUHMR2oSqBmuFXuPSRec/fbTkv2mfG+Uij?=
 =?us-ascii?Q?M3ksk9n9zTbhIrSL84/vfpk2S8kVQL79HF1bDCRYG0TgAwDoWl9y/sDBgTnn?=
 =?us-ascii?Q?g9szgC0YzDVKxNVEDqOL8a0DWx3y38J3NXfmhRbnwueCsdIxkAuA0/JFJf9K?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f50916-ffa1-4cd0-769b-08dbfc94f473
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 11:08:09.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrEKMRlAOKtSUYhdrmY06I+MnugpOoOFr1+DF0iS5+xAYNUl+yU4/5AIdOYpPcp7H/VWJ85T7Uko7Kd+J2IrGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:17PM +0200, Roger Quadros wrote:
> Move register definitions to header file. No functional change.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
