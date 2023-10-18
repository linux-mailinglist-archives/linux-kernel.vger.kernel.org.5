Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B707CE1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjJRP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjJRP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:59:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE47116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBIxLMjS6juDiDwqMNG4163QzuLgz6MaJ1X1M9F7UspP76FQejTLYSHn4enVz77pTzE25mB6VoQRYuKB+MfctHv04kmgIlsY60C6MLzgaX7YN05ikQyuVwtpSDHtVT7r8F81mw6ScywcKunnLKZGyqdc4ZSQPtlUYVcTZ+bixuKsKHuOmP/BoY2nX3u9qhzfjC40Yd3oVgFteG7KWEOWh7LNCWJVgdqKV3eWpuuggsSmu2TDQYJVCldu660xuPoljcPP5bKtTETDodoKx/wCrmLJAGtE2EZHb/vbVguhuiTWz2xEZ3B1Nf2l3HX8ZWz0TMChuTia/MeNN8PUkZ6EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn2I1Ac2i9h01JOuAJ9cuH/paKtcsCnttLjp96r4TZM=;
 b=gDoTk3oOzTKF6KM4us3KBmOiHRJCxuJ0t0bGQSn042v9B0zGtC0L+0hcP49b/RFfWNgySZWyxZnb47GZQWT0B32EllFwrbSHeZuZ/aw9oJzrADbPif7Vl6KddtXBizMz3Zst1FqBpXRkSg1nXgOQJeVt8UAbbLNLDHlFnfPFjkTzjwgEtm5fy9GlrMq9SVTtOm7912YHHXUf7zXZXhm37FF+D0rvHFDUegUvP/jnfwq4oZIRzp8HTDx3Os2YSTjB2AhYAJNFc/yOwqMkL3s0AG3Y0JtvC2Vf14Ln1CvNfVWRipGsUW22YuZ/aB+j5xxzvYnwk9mD1BkK5SK2cwQuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn2I1Ac2i9h01JOuAJ9cuH/paKtcsCnttLjp96r4TZM=;
 b=VseUyNErH2+Yj/Oq32yl0Sf5IuBkx4tIwoCb68GdNQdXZ+aprThTeQecPhbC1yvmGlLlifYugcwnatRlOsHoZ6zKad8WJTe+QfDwe9V07mHNzU+goNdCA0smColiwne3EiiPyU3WeHSIZHMNzfEh9YLpYnq0wY2TUIV2QGzZcmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:59:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:59:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Resent 0/6] i3c: master: svc: collection of bugs fixes
Date:   Wed, 18 Oct 2023 11:59:20 -0400
Message-Id: <20231018155926.3305476-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd8d4e6-9209-46d5-943f-08dbcff33d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTb2s6pT9D4aIasjS4YQSaU1vMBGHur3pt+OHpWVW3fGcgljTaAUlVs0XwlKPFxvFakr2HdtNEK2eBD3jVrv3VChLjIxm0ErUE0lxbIoODXxM4ltE1nPHR47/Mj63KmCbaQ8+TbJCX1Po3sYy0HUtZomF+VAUD2+RinRVfyK+w7ikuXnou+duza6+Y0aW7J3Jwjlv24rzRKmtzqU0teQmf3oCWuA8ozwSp0m7+JC4mONH1J4xUeHkFW2eJhUA/+TzwUSCikaZMKhl4cZJZA9vjFbWVjTW0Qj0ntlA30YEu+cC+w7rVNAub36FVJn7HYQBHv30HSmhuyH7ERKP8aER9cCHxX8JfP8H2ugdRl+jINqFw58CvYTZyXqaC+blFpuIYXIJrNjSmWRFII2bzvw71KQdeFS7TviYFwJy31eWR03M6N6qnZZ1aMgaNomRlnT/4Hi0uOPrJs+VYVBcwlCY8LnjMDay4MAEUjSQ3QVOZgY7HTgbZwvr8vYDoe4CtccSej9hI8fMdEJlvFDI5hTCYTUheohzTwYxE7R6Bhig5dayTUyVmfS1goR1eM5vz8DCEk460cCWKDorvDqn28xAzrcRenxR/JzwgAZX2WbfzTVJ/xqiS9hfg7C4sWxeERE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66556008)(66476007)(66946007)(6916009)(316002)(6486002)(478600001)(6666004)(2906002)(38350700005)(36756003)(86362001)(5660300002)(4744005)(8676002)(8936002)(4326008)(41300700001)(26005)(1076003)(2616005)(83380400001)(38100700002)(6512007)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1p3a0EzNzVuYTUvV0ppTW90dnl0T1RTelNqWGRmZUJrNUFZSDloM3JZYk50?=
 =?utf-8?B?eGlpT21QdnllOWllRDdrT2hNUlIrUDlvdnlCaSt2SzUwZzZhc3JGc3M3WUpv?=
 =?utf-8?B?ZWFGWUZZazRpQTloQUdjczhnSDg5a2cwZXhHUjFjT2laNW1rMWdvUTlaVGho?=
 =?utf-8?B?ZXQrZW05N3FxU2dQSjJkdmh2ZDFVSkYxSDJWWUpVSExaZXRkWTIzcWZ3aU5h?=
 =?utf-8?B?QmZISHI0NVA2M1lEOUhzaXN4VzdlYWVpUUFLZUtnaWEvZ1Y0NDdaVUJNNk1o?=
 =?utf-8?B?S00zNmxPSUxWQWd3WUlwQ2l1d0dkZFEwd2FuS1AwWWh6cXhWaHdUSjVYaEJP?=
 =?utf-8?B?VjJoTWl2dnFFT0I2M2pQQ2ZHYWlhbUI3TkdqaEUybFJGb1lFM0dIZ1Q1QTNP?=
 =?utf-8?B?b2dDemNvVTR0YmdhN0VhUFlpZ2N0SHFwUW1IUVBWOHFONUV4d0VNZVp4VWFk?=
 =?utf-8?B?bWJmK0dERjRUdEpTYTN3Z3ZNN2ZuRzBHcHJZUWNnQWtjSXQxdVlWUHZEZDU0?=
 =?utf-8?B?VXVyMldoK2hwaXlwRzJqWEpQRHhyRC9uL2kxamJRdzUzdkpKRlUvMkNLTWZY?=
 =?utf-8?B?RjduT05GRGJPeW9sQlVBa0t6S2FXTkZsMXVySWp4Ni81bGJqbE04d1d5dkhj?=
 =?utf-8?B?aUg0NGRxREN6d0hMdyt5NTAyYnduRFIxa3UreHlmWW1uL3FoVzcySURiRmtp?=
 =?utf-8?B?QTVJbE9KSG5KKzFsbG43MFdXSmoxTC9ELytFeHMwYWErVllsUk1pYUdFWFV0?=
 =?utf-8?B?aGNobmZCc3NvanJUYmlHeVo2d2dpZzhwYjBaTldRV2NmQlVqOHkwRzNLb0pv?=
 =?utf-8?B?bDBUTlBQbXJLNS9DcUJuRGE1REhrczBWZVhSWmk2em1RWm54Y3JxWTAwTkZY?=
 =?utf-8?B?akUxNDVBeTNGMEJuUjdqU0hnby83b0U0ZEJZTUFOckV2V2xqMDJTYUxiVEox?=
 =?utf-8?B?WTRXc3Zaam5hSDZuWmJVVGZQV1ZhejA2azR1aG52dzE3eVdpMUh1NmljdGNi?=
 =?utf-8?B?ZzUrdWw0cEJCMDcvTEszZzBBR0pQaGZoWEsrSmIvNnY3YTVUT2RzWDV2SHJ3?=
 =?utf-8?B?VXJhN2R6aXJlc3hrYkZmMEl4NUZ0azR1eHRGZjZFMmhPZk9Mcm1oM1VzdXRZ?=
 =?utf-8?B?QVEzQ2dzcDg2cm5uQTMzdGJCTzh5ZjRaTE1aZTg0MUVuMTFqcnlNc3lhUzhX?=
 =?utf-8?B?RkM3QVNibVFsZVovalREakhwdllET3cxdkM2TFZRN2pmbUpzeEZBbjlidXlB?=
 =?utf-8?B?YkxwOVlpVTNRYUlWazlON3pQTGF5U0wxeC9zTWlmRDA1WHhtSDd6RE1YN0dr?=
 =?utf-8?B?RjhCN0VIMGVTTWVDc0dMVGxxeVg4eEFEcmNuTmdQR3B6N1RvT1dSZGVId2li?=
 =?utf-8?B?MGZqTkkyTjNVZHA5MUsvSm1uWENhSEtLUmsrYmh5Y0dTZUR2SnRJMHh1UGNC?=
 =?utf-8?B?UUIybzFiSEpiRGZpeGlqazRDbXg0RXZpZEk3UDY5UDlwT0hxbkRBVlZFVEJz?=
 =?utf-8?B?Vi9ZSmM5c0lNQ1NYY1l3UTJ4YTdoMVJRRE4xeWd0SHF1U0Z0Qi9OZ2JyTmtz?=
 =?utf-8?B?dEFwSTZrOUMxRWVUdi8zUndHYjZnVVdvS2dkZ3Z4VXBVRW9aTnRRczdIODU0?=
 =?utf-8?B?YVdoRUNGSjBZWFBuZlk5MFNoU05tQllpRU44WmsrT09QZVNVODV0TW1CVzR0?=
 =?utf-8?B?bS85ZUpVbUFSajFKUUpzWEFETWNDaWxWSnZxVmR3L0RQZkpjUythcHBNNmFj?=
 =?utf-8?B?UG1qMXBsMDV2UEJyZWFSNkVFU050Zm80Z3BVUGNPeXl4YkR0cHUvdy8wK0Nw?=
 =?utf-8?B?dDExYTZYOEI0UVpDK3dLVmJ3TVIyOXhnbkpyQUkzWEhkeWVGL2R6bmdDbk5C?=
 =?utf-8?B?K0JXc1Bjb3BYdUpsZThkbHV0NUVteTAyUmpzVjM1cnhOWXNIamdoVk5leEwz?=
 =?utf-8?B?ZEtNT0doQ0VWbS8rZjhNbVVHK1RQdnI0YnhuR3RDQ1dpb1hkVno1YVRzV084?=
 =?utf-8?B?Zlczc0tVdzJOems2eW9vVjEwR1BNZ0xLNWEyMHFPeVBaYmVWYVZkekhoMkJu?=
 =?utf-8?B?RUZpbnA4a0FiMzhralpBK2VNMVJXUUI0cHF0T1hHN1hMNC8yNFhXV0swT2Jz?=
 =?utf-8?Q?MiQEaX3LqhsNC5Kasadhm/Y8O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd8d4e6-9209-46d5-943f-08dbcff33d93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:59:42.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTsQj+D4nuPhRAMrXIu+jJgK3wbH1WEBHVfFY9H7MuqD16zc0Wd8YfCHkScagp5Z67X+1r2qI1+73bA8E5pzgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each patch is indepedents. See commit message for detail.

Change from v1 to v2.
See each patch notes

Frank Li (6):
  i3c: master: svc: fix race condition in ibi work thread
  i3c: master: svc: fix wrong data return when IBI happen during start
    frame
  i3c: master: svc: fix ibi may not return mandatory data byte
  i3c: master: svc: fix check wrong status register in irq handler
  i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
  i3c: master: svc: fix random hot join failure since timeout error

 drivers/i3c/master/svc-i3c-master.c | 51 ++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

-- 
2.34.1

