Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB047FC176
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbjK1Pis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbjK1Piq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:38:46 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C85D4F;
        Tue, 28 Nov 2023 07:38:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl8/vNfpL4dYPKHwKIj781t5HILG/xvlr6oMtQXZyQ4Cym0QIL5mEQaaYPSGgytNLve9ywq/6oyImgZzHik8bajDzC6VXgqieEYShz2HwtG2YU/WqCAZ/isfPbouyX2YFQGJ7nY2YzGgH0fj76ND+KfPyFKjxu6aIdF9Y6946zcygt2VwKHaVfEgHlqjbv9vH/XTiCygIYHxgv4MHsiZ5xKWnbfgW/67mKDRvsv9QH6wLjOGMchdTuNPX9pf3AfHmlJ5XDcRmtkZy6CR+wJx0vBgNqR8xoyzu6EEmH6uc28PdHsQd1APovES3dDpOVNe1Xob476GtC7hdq1TY9ATIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q2bp1bWzTA61yw25uDwQdVfdpbhiYwtIGrj1r32keU=;
 b=WfNAyE1pPN2K3NIY1piUHGb15dcVjIUiSmVTZe1PPsdalRoa5jek2F6CzEhToYgIkR3xQPbWgukwgLvBWcZH8xW6rj9UmtNqbU0NIcyMrZVDHVf/Gu10Rb+uj6ShiEX97PbC5Tr/mi0oZnN6ch9KVVpIckZ51NfTmc7O3RHcqgRfWP8VdvtIsPSbc46V7Y9/aWK0dsLKHWs+uAku63YGckTSchcEK+XsWn1uIp/aFIr7Diq46F0BvfQ9lmsr4MO78PX96m7+7D9aZYxCRUZs5o9Sw8T7XFgAZB1I+uor2ZEL+n9JUSWYlkrumRSZwZP2EGotWok8xTMKYFFBnog/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4q2bp1bWzTA61yw25uDwQdVfdpbhiYwtIGrj1r32keU=;
 b=EOZ07Z6+MmJPzBzFn97FYPHx9dFIzEXOansnxGs2v6zs1r0JxMcgZuN4W74miJ18nMslg9W966Kc5KjVNSwhiqdEmdwHJj9tmJRQPKCWWmKF7cKQInXo5B/rX2Z1fHbpe66/QpLQSI+nzVdkt1DuHbzbwzsxuPE654PslCrlmKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 15:38:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:38:48 +0000
Date:   Tue, 28 Nov 2023 10:38:41 -0500
From:   Frank Li <Frank.li@nxp.com>
To:     wangxiaolei <xiaolei.wang@windriver.com>
Cc:     vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dmaengine: fsl-edma: dmatest timeout
Message-ID: <ZWYJgc/S8xMofmWw@lizhi-Precision-Tower-5810>
References: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f2e017-8811-45c1-fc2e-08dbf0281d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da13179FvadVn8x4hJJswWkjIXl+zACPeGXWQXdS47cqYmju2afl6JPrBWnaC97jbMBGV2UzKduzJUCq6aJ314w5JBqtsofptRGYzkrtIBZ7tATed50hYpOwjkWvsWQuPv/uJWogMNbLJ7gB/+5z2U61H8cwok/ryE/2x/qyXasWkNsjVrvpzS29LK9JTFwQecq7ZOSyOJXT+LGUqtRDdvd3kr0cYH2tIeHSPNB2/wUszWvt3ddbp41E+LLwZ2aCsV8OlZAmOBjypOoBFItrOouWfKTi9IsVi/Dsi5tN3r0c5eQ5Z59EMay5KE8GzhTlEyatfVAYA+n8L0fgedYTK5PdGjb7tNmRmkpGk0XtOPyIUDgDJ0NSeB/9QId1dG1+wXWtMOh0TXB97x3vdnIAAS9GxvgWN1qrBnJTju1u+x53SWXvnrw3QlheHZA8VQLV57e2PgkMLRlWksq393FagnKDQk8FS4lT3FA67iXAh+dxaamSJAGkGrqd+VWHAoPR+MyNZqQdRnZOZozLE8wOdLMyzr6kTLT3AHEm8bftFrTpGh16wYMvBtaYiS5CEPL46RJWN+Fz7a0xfo0ilJUYlvplGHN6VPO596QAOHiAizrXBIgCoTDf4Z6+TWR2J7rt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(33716001)(38350700005)(86362001)(9686003)(6512007)(52116002)(6486002)(6666004)(6506007)(478600001)(4326008)(8676002)(5660300002)(8936002)(41300700001)(66946007)(66476007)(6916009)(66556008)(316002)(2906002)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shKsO83j1gaJNl8joLzgDYu0GjrQKTKApXNlJ5svOwQTyAAOoEPqYKI87Tlp?=
 =?us-ascii?Q?/BOcaQBj1cytdHfTY3sr8IU+o6TcsWjMFrfYH/HHnrlGDSBIgtCtmEpxidb4?=
 =?us-ascii?Q?T3qkOlR9kdxeSxRmS9cFm1gbvTTEfcKg+YkZyX3G3SmHJBVZJu86BxdZ+9tz?=
 =?us-ascii?Q?jAlIgq/buhvNGXrtCZKWI0fSU0PPWMDaITj2BRN1qhZHXHkbgCzwDSFAf7Ue?=
 =?us-ascii?Q?nhipdT2cACuZEWgJxUEZePZ9r8D6TDSMkQn2zazBA03mU7taRpR/Binzqwtx?=
 =?us-ascii?Q?I8uSQwIHDJlADiK9CdmHUuCGfdrnaJg0kYHUpDozOkyAwTTPQ0jlwUwL6qaq?=
 =?us-ascii?Q?nnTBNP0CGbcpiYYuCuJVjD3sDLmuNUmoHl18+rtNpcCM+94S53WUACTAoOMc?=
 =?us-ascii?Q?0EHyvNJLGqhIlKtSWeDsuwwfpQSRPO20zs4+CoR0QKUhXwZtg2jHbFH3s7fo?=
 =?us-ascii?Q?b3ymoabUX8l370MxwH+L0NFLaj39xxndvnbWzKg0LV++Mfm+E4PPaVUCkOwx?=
 =?us-ascii?Q?QL4nlATaW709B+ELaUkOR7fq0OLT5HCL6uoumoAerLqONBjTMmIv0fGqkQIH?=
 =?us-ascii?Q?llfqDmIS7tkCz+zaIQy1Xo6xjBdG3nD4zKME1Wg6H81yAku8WNVVy4kmndbk?=
 =?us-ascii?Q?jgp3/+UhXeFjC7bz+fZgTf7f4mw5OZL5dZ1jt33Li+ghMM2UCJF0mCOtuzZX?=
 =?us-ascii?Q?aaJlEWll5RlOV/CItKFb0a4IcIxnoeKJwQGq0ELwABpmn+OZ0ZA04g8qo4PK?=
 =?us-ascii?Q?uDFIjHLBWFoMptZ2DLpjjob3ljnon2dTZS/5qUN2QYoS4CpvLf34Torn9J8B?=
 =?us-ascii?Q?5yzY+9U1uuJ8p1T+eMeCwBHFoaGwb8w2IDpJwcBu5L7DYg8fok6KketsxdiU?=
 =?us-ascii?Q?NdNANYiTjrT/Qf5CcJMYj6R8tYGr4Cm8ucnnAfA0IO42BBzQPRC5DFLCH5Dl?=
 =?us-ascii?Q?MWDgyeZLGgpO/k9HRb9fDIIK1AIxAkn7mpMN6WdCzr9qqwvqSk6x0gLWVzTy?=
 =?us-ascii?Q?2tuqMqoePY3OL1uiSAv3EUAKXDjYhi/W5ZVq7PwceS7COSe+hBObZu0cuTFG?=
 =?us-ascii?Q?NU141L2SKMaVMz/fUDAHb5EdzI76EJkl547Zb9xTtUjKs7rGXlIz77z/NJFq?=
 =?us-ascii?Q?ERblvjrsG5ssBsAap/0UwrTjHIe7eNkVASc/JYu9c9ahEgtUD0EPLn8Kqgfx?=
 =?us-ascii?Q?5siwraRIPVhiYbeDzDvVpk9OqnNjnfeWSqlRr0Kj17PwDiSM+hXg8KW55nYH?=
 =?us-ascii?Q?lOJikS60J4MeWLcKJs+MYWAuVEAoUxL+dk14Jd2SjQIncS3ncKDC7PGjYVH9?=
 =?us-ascii?Q?dPnbPzttocM8Gx2VvNjWZCGMw+j1XlMS75h6yRtyJL0oM80j3PdaSyLeCsI2?=
 =?us-ascii?Q?S5gPCjR40neFIi0oRLwH25dVFKpHLVNZxBTXBtM12IMmxUGPve7peCdSBEBj?=
 =?us-ascii?Q?qtD3HZYWQTQTLiUy3JOApAWeUANhg4E/no9U6wmFS4WUtgVF1ruKnF5y8tle?=
 =?us-ascii?Q?+RqTkEsPVSN1JtV4nNBBIVjEvDChd9sHudrNU/xXJv0Q4A8WyW0wouhHxJkD?=
 =?us-ascii?Q?NUAF1F+tFTbyc1+lzbNYmGPGHPPXM4uaWOxr1cVn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f2e017-8811-45c1-fc2e-08dbf0281d62
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:38:48.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpDyJP3/yOrc9C9pLnow8LkaMBin7ud5Z6WqD4j7FpNDIMp51JOWCVpAlshp2OEIUDzts30uAsqEMLLWdHJ/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:43:59PM +0800, wangxiaolei wrote:
> Hi
> 
> When I executed the following command to do dmatest on the imx8qm platform,
> 
> I found that the timeout occurred on the current mainline kernel:
> 
> 
> modprobe dmatest run=1 iterations=42
> 

dmatest use mem to mem transfer. It seldom used at actual system. Let me
check it. 

Frank

> 
> I found that the completion interrupt was not received in
> fsl_edma3_tx_handler().
> 
> I didn't find any special configuration from the manual. Can anyone give
> some suggestions?
> 
> 
> thanks
> 
> xiaolei
> 
