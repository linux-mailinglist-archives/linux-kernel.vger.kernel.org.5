Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB37BA52C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjJEQOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbjJEQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:20 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn0813.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::813])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D7F93D1;
        Thu,  5 Oct 2023 01:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRwqzXXosPAbwsVLgptQh88u+dDR0y316QZlouzlClIpxom3pjv1dNW6OaKe0sQZJoIvk9Z9veZKtKcatlXnakGmdlhsM3uoh10yWMrDmO7w0vKagwylyPZUhNHHHKaFQwtAsFNxKNTx4ezt8s4enzd0eqjt3P1FDXckyuub1YxDMr/4taWExDieLg0UmQIICzZEuc20eSjgQM0fAjKDBKZAX+2gm12gUpA5vTkzhKUv9JYrOsu5vHx7M09Z0PeNDeiL+XWYd8J9HIc1/giBS61Rugaj7iSQjPMdtl1zLF4v11kH9CM8k0Z8w+7HB8JCHLPRvuvRO4cxyOq7efdOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSs6VLssUz41mgB5cZYvsadDrlLXxuEY702N38NLYOg=;
 b=jAk+6Pv0VJpgKAv5rEOFPfhP0iARl3IpSsX/svPDAj417iSsRc9Tc7EFfvVOKODBH27euFJ+U8AsisfDzicm5py0HaSKSf/+lDZY01OIBC13zGa1Fgmi3cK32Cg1JFZ94Wn6sllfiiB58bJLmQWeSo1dE4Tu/fiJk84YXuCPakhF92raV66Fgov085Wx+gpPWjDXNGlqS0vCEIU0jG2BJGRiOItP9+QlK5hgLOuCM6ELEMrAz96dkQQ1EIh5WY2ISecsOHCxq5KASVUKqNRIES6XFc/gU5G1ufO3s0WLpb28Ja0oWYv72sN/ZIsa5Hnq3gtUWIsUOf6IhKXFEoBGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by PAWPR09MB6613.eurprd09.prod.outlook.com (2603:10a6:102:342::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 08:51:55 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::b4c3:964f:93ac:4b0]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::b4c3:964f:93ac:4b0%7]) with mapi id 15.20.6813.027; Thu, 5 Oct 2023
 08:51:55 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     u.kleine-koenig@pengutronix.de
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        paul_geurts@live.nl, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH] serial: imx: fix tx statemachine deadlock
Date:   Thu,  5 Oct 2023 10:51:44 +0200
Message-ID: <AM0PR09MB267515B5C995C5FEA1A8833295CAA@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231004102008.giyogvnsc26ucx4k@pengutronix.de>
References: <20231004102008.giyogvnsc26ucx4k@pengutronix.de>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Pyd27K2z+gzsipdoQo3oHACIXzOPVdu+TLHJiKBDLoDdjwcny6vJU97aT+vr10an]
X-ClientProxiedBy: AS9P194CA0011.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::16) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231005085144.2649-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|PAWPR09MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7896e0-694d-46ce-545f-08dbc580537a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6X5RPZYFlmfmsr69mBIwAwqRKlbcCBsiI2wIRHRiFmYfqwaNmJ5nf/OLVSy+4W9M4NCQtNtMtaOxMqowsCfhaHVGJ7Ojij9oCSWiqq44CyOVU2uXO1IeVq1L9utPjdCOtgftb0TRbFaEYrOa/IkqpFG18nn2ZNN9oTNCU1BmauX6UF5+rVmL7j+KCxPgDheBnkyx0Mc9nR2ZGoeoU79ysEisuOVkXI9/niqmRdET1QG6FaGXUmJQAw18eXBMi3UeILkDJMC5C8U0C0wBW4Rk0DBEFyK1wUpcUKlj5lAubCAxUq/WI/RBtMdBXz0WKbt/SGpgoOTG12UheOJaAmcyVfO2AQBMufmyWTqRezs+3iI4/hTZju999NGMhL73oTSTDOsZjBNFTN9orYiJUoIloc7SWPMKF6gbH7QEpPpBWIloyjkuVUjRz0Uap/I64zI99hMZeCbgJ/k+7E7fYkMS2/ByennmBmycU4fBdTNo0T58KoAPTt4yeR9QLV2pSJyYM233e/mTdVPLS3AKq7Y95VIHkiamspBXJyrVTiVZ/W8lpDmGAgKNWwarzKZWXtzhS0A94nsFwiUWxeX0kWvtP3npRWlmqYJEF1L150UvjOMzzfUscm/x/lE/lP/jjFns
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Z8esGMfrpNvGsmZ6OAp/9mfIfdtPOFKMw0V1J8InOoABBhYyWlfiCIei40P?=
 =?us-ascii?Q?G5kTpMOAoUGa7L9npH395f70hl/za192mg5bkTsGi6kS+njoI5ZKouInuA2x?=
 =?us-ascii?Q?tyWVXI1HbGDm117HlvGN2j5F2Qyf+WAmm/zte5XzyZOU1R09mCj4uFoLTD7h?=
 =?us-ascii?Q?lcBfVtBUV+7fmz4IOZKTgCLNtoFWEvdw0x0lfKP/KLJlMxIweQ3A+6gfw2d3?=
 =?us-ascii?Q?ZxnOlulmErpBoDpq9ODEkmmkfSYu7eGSdQ5/akRnqAzaH1F9xwueRPvs+cZq?=
 =?us-ascii?Q?5N9QAvHj6Layi5JwIwCcZFUbuSs0RswdJnCHsSjqM5Jhk7VVR+bPAFjCsgZz?=
 =?us-ascii?Q?VCCfg1Li3Pbwm84WiPPBMIhsXvHTZgjc6Rg3N5xxJ5nfTMvnDynB4inDDz6o?=
 =?us-ascii?Q?PNebAyBGec9Mq7Zq70raIsnzOsF6O4MvyA7L67UEBrV0OUAanCG1r+3Wj51O?=
 =?us-ascii?Q?oR+GDv/xmAnWSGBzEFUVFXbFeLf/wvIQeJ4CAAn8OpJOUKqZYi6NkcMZy0MZ?=
 =?us-ascii?Q?9dDwdp0IiKQ/yWDFYASV1v4GujJOtyZi56F1KpxBuVE5r27/U0ILEbs9JlSa?=
 =?us-ascii?Q?nE2PCYdiRuC5OQkFrvBpTxs+0mcaGCN99SOI9P/d0QVYaphNbdJH6mWEfmsr?=
 =?us-ascii?Q?Z8Hm7QP782tGHLbB/gK8PQjz5fwBt4+/xl1c1U0Fi3r2FYKVD3VnMSw3uvN6?=
 =?us-ascii?Q?36cjs8YC4BKyhbm0WUCirJzpFDMR4eZiTMxEZTflljANHGVWXfgEhr753P0W?=
 =?us-ascii?Q?4tPb1+c+1RpDaFfpdAl28qXdQq460bLSZA6BGx9RawsGilS1052lsE/9f4C1?=
 =?us-ascii?Q?8S2bJj05IC2PYBt2sI7CHauwy5zTPNEZJRb/STkKjy5RfKybaK8gyFtCqkO+?=
 =?us-ascii?Q?tuLd26nUiW7psJ8W+OO0M57/PeI0pfmtMrElU223F8VdgMGesEJnMOkza89p?=
 =?us-ascii?Q?pw8vUXN7mzaBE57tXBjtvUND5IBr4wvTrDmNCURzAqKoCZma4+QDQ42o6NBb?=
 =?us-ascii?Q?dPYcDcsYX9nj5fm4/NXqgFJB2Z/F5zkeXPwfuYRoo9ar/H8MGwzdWPKYZJwv?=
 =?us-ascii?Q?URoNJOShpJl0gSmaFbNwwBQGN7UqO4tpUdUhq7wpInmMl3+drY2Nh9NbwEee?=
 =?us-ascii?Q?+J8bMm6CqNAHlnanTObRBfoqaVD6tUztif83mwUAKsjvEU9R74F6N/G5bi9w?=
 =?us-ascii?Q?/7qk03OuLwKM1YBffwvmTYR4A2gENq6v+FHa9YXVqd2aVOWWfHV1XB+u/Viw?=
 =?us-ascii?Q?8hiWm4d+MF9qnDl3a+C3S28uRhkHGZv7jbonRHi1bw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7896e0-694d-46ce-545f-08dbc580537a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:51:55.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> Sounds reasonable.
> 
> A Fixes: line would be nice.

Yes, I will add the Fixes line for sure.

> So the new thing is: If the hardware is still busy sending stuff but
> /dev/ttymxcX isn't open any more (i.e. .shutdown was called), the
> transmitter gets disabled. I wonder if in this case disabling the
> transmitter should be delayed until the shifter is empty? Or maybe this
> should be handled in .shutdown, that is only disable TCEN once the
> shifter is empty?

Good point. I am wondering whether this would be necessary. Writing to the
TTY is blocking until the shifter is done, so closing it before the shifter
is done is an error condition anyway, right? So if it already is an error
condition, the data is already unreliable. Making sure the shifter is
empty on shutdown would mean waiting for it, or doing it asynchronously,
which IMO is both not a great idea. Maybe we can just dump the buffer on
shutdown but I don't know whether the IP can do that.

Let me know what you think.

br,
Paul
