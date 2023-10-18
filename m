Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960397CE21A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjJRQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:03:50 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB92116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8awn0luH1M7tvGisGW/m2rG8RcRun0jRN2CH1Gph+wJYry6TTJAqRPQ1s19lKN1uMvthAB+Q+3pzfSFeqbTGoqF9W7Bmp/mZhiXP0cTWvYQA8wao4f5sN5/pZijBlTBjMSsScEXoUS+4AhNCcVsg96rJYSqoPcE+ZZVRVRkIrkf9XN+vIJmVF1w3refqUXX79ZPQcEERXRPkvIEUlQG/pHOChG4ODTalQgBrsnam5mUygHvVlexFoSSq602W2Xa07Ds3lPf0MWjk22uCHuHiN/sbnBWBZXAfJ92kw1D6nf/rJ+kkW8PAzCWDi/fNWydx25ppGhJf4/KvwUyb5DnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihlGonB5cGkh32UbRpHQv0CNhJeHt2royBLHo6hnvbo=;
 b=NMY2/2BA0MO0nUtr3b9bRv3q/4mwXf+VLJ/QBdANuX4NrZYkF/fIY2hM6NdMbwKJUP9VzKmk48rIIsvr8Tum3G0xxitBFIeuvxh+/im08hWgNO3n8qwurtAl6OGSbK9d11uSSrp7Vnv5dx62uDkrmvUB0BAVl5Nhj6T/gx0d7Gn+eOkCeByRsZxPZzZD8C5vkuomGbKv4KedJyQU8rhjc12WkPdA7MHwXRqXZsvb2uwoA2o2ic7Dtd8VqfyncMMEf0JwBrSOZb2B976UJYfEuzkPVJdDpSITwTslNWEk6GxrcJg5v1gIwOjw4xTQS2H6s3Lz22O0+cq/z7pJPfQ9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihlGonB5cGkh32UbRpHQv0CNhJeHt2royBLHo6hnvbo=;
 b=DF8axtf112bBoNJql9mizRAytLLCUMH6MRe0/y7/cerjSLom7N9CA+GSnASDpSmmhEVXJg4zHS48KLmYRXChCGMj2zadTdmSkHkb4CDd1HBBYzxRHshgXthg5awIq+EPab+YLmAJnlVP6QE49B2i8T3gIvXfaqHaapGFMY14ytg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM7PR04MB6966.eurprd04.prod.outlook.com (2603:10a6:20b:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 16:03:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 16:03:40 +0000
Date:   Wed, 18 Oct 2023 12:03:33 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] i3c: master: svc: collection of bugs fixes
Message-ID: <ZTAB1f+r4j8vjxQc@lizhi-Precision-Tower-5810>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM7PR04MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8dc3cc-ab69-4b5a-1c67-08dbcff3cb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg21CZ6n7M88Fwem8lQxrPOonv5u1BksLUxli76KKiuMA8EbRl4r+iuU9wQ5+bflXKrazU6jgEK8LFhlF/Y1dHKQEGGQvNiDwFcQ3mlp4n8ALsYTFTqhLdIsGoC8ZA3/fIU6R5H6uwEi6Zi5mvhffKzR3SZ2IV8hGPOvK0rdepQG76aBGsXa/RnLVGJdEKqufn+wCYQuZTokj+gq3c3HYx5mR4qs33IX+/Q8PKRkHHuvNImqMjjorZc2uo0Wtro/2Og6vhfubmLSRwVIqQpjx6Y56Ey4Hb0Fcm+ogOoXVpgwwte+MbzNCCJ7W1f8BCeLWezku6E+7VWjOnR9ZQI5IuF29uSCG7JQfwOEDhrDaquQSV2F2UDtrIUHd8tqdJPaFRqftYjoz3H8pizSlE/mCelHrw0xWMHxQHp9Zz3mHyUrRhsyIhqZo4J95d410u7MD1fmokUlg0FVZRUz9SGx1jgepQeGMXIxri9S3njSPlwSF4VJKoTO4bxzSAVNRlPPvWtnEYEMbGPVb3A4HvRk8XIFxKROt0b3C7Fde9krjYXIVHF/6NwSMSA2VDO1orUR7TGT9RNOE4cKk60zoWZuwjNtyjBscpiaiyEaXc5w9jQsi44rnqTaxzASMX+C3u7EzsMPsOUgrxPCXsHtDowW2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(4744005)(478600001)(6486002)(6666004)(38100700002)(8936002)(5660300002)(8676002)(66556008)(4326008)(66946007)(33716001)(316002)(66476007)(6916009)(86362001)(41300700001)(9686003)(6512007)(52116002)(6506007)(26005)(38350700005)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HwahMalWPj7iyKBDpEKohonBRNeW7Cy21ShMGWIOffVKyKoe+/rgomzvd7b4?=
 =?us-ascii?Q?Z5rIl6fS8MMWuoagat37VMuLKhoW1DEBH6gFoQk0PFcphTC6UkQpzYM0cOYc?=
 =?us-ascii?Q?MZ2MmSBCKDAdyP+AbNQ5nfSHnRSnqZU2vQWOfcbZBzW4gx9LfsOV8gnnzLQ9?=
 =?us-ascii?Q?MmyzLQwvog+4Ig+mNa8viqpdR98JVm5vI8JVBeC0sqTXSmL3U1AruvKzfaEN?=
 =?us-ascii?Q?QNuiEC3g/j3UrdoeDFvIohHFISFsT61Es7LRdVF3qGzMxZJvJqBi3j0pPeaX?=
 =?us-ascii?Q?9jjh4sD+2U5Wod73kNvtp4C02ZbTBOlXDM+TL9bHhbAMEjq9s/ykoSfPeQ//?=
 =?us-ascii?Q?99Dqqu0tQHQfco2OfeaStqrV6wCqkPZsLh/IDMmoCFWDP5/zZqPn3KwKuTI6?=
 =?us-ascii?Q?GZBdoR3KK5gb094hWl2/YL5cTRTKZ6BTSi/ILuKzISRtPVdkiuyOYCDXp+my?=
 =?us-ascii?Q?MlbPbedpWn0CplT2iIp+Bq9yU7lC5H1LCGDpsQ13B9dPTW3wmaT2TeILIMzB?=
 =?us-ascii?Q?mWjkeiCexFxNim6RjFAZpKtuQ6PRTA8fe1PEV5yhanpuec9nHQW1BHIhlKVF?=
 =?us-ascii?Q?dRxfAdzW7/f3FyfStcQaCMV+LlV7pnCPmhZKF4u+n53vhGHGiVPkUDkGcE/Q?=
 =?us-ascii?Q?21jBOB8g/ICLVya4GR1vzauhlAveSrgyd48IXxPupCpaxoG5WfXVZn6lcUHo?=
 =?us-ascii?Q?+7qeJnKn/M1ORuHRJdDGgsBEMCS4h/WRoYMSDsZ3h1CUKBtKHCgd+afFTOPq?=
 =?us-ascii?Q?uge+nJnxpm1uhnS9hYxFhvijtgCrU3TldWfspvRelYJZSscUzZHD+6lomvOG?=
 =?us-ascii?Q?Jc2ShqesHl9u0dSCWvhEeduwcfcpQA2AovQab2D0vw1VYUOOsT9OyoxWxZzy?=
 =?us-ascii?Q?EXXUHnerpuNZLzO8pkQeUMvBkwWDt2cKG2wJRuI3fypxxS/2Yc1Ca/R8yrXC?=
 =?us-ascii?Q?vVmFBxJ6vGk4wBVj3Y+8wqe1GwCcigYqbFWmTjo0mXiaOnR/Bm0X0rT2b0Lh?=
 =?us-ascii?Q?fIGY08bQMTQQiYgHHws9QuIZXxk5pR410xwoZ2QeiwdrVtuoTY4LkamB4eY9?=
 =?us-ascii?Q?M341+RprkCJNUGa62GsPqwIeR0DDsFunkV2T+aUsMOBrIb66od+Zt1MGND1h?=
 =?us-ascii?Q?GEBoaKpWasTU3WauGjh25/xII9yBO9WVRMBGsUS0wPocaQJXybhzcHctG1u6?=
 =?us-ascii?Q?CETFxCS6brQIFpp26DKKQKN8lks/PIUqyuxIlyYJJZd2Q61hin4eP/JvJe86?=
 =?us-ascii?Q?KWUdRFrLVBJqtZ0oS+ebjmA1fJzy6Q1/a+k/4jnvFa7qBE3iv/F0Rr2bqKjN?=
 =?us-ascii?Q?n0oOalmA7ULqAy/m29bhV+E4ZfajlFEIhyozmYuUsQdz+4Bqv/DFAThMSupN?=
 =?us-ascii?Q?X4c6HWRddHC/edtWnO5+Iphx7pe1AmOVo87TpPuh8XUrXgeBE41k0f7PMWA/?=
 =?us-ascii?Q?8fi4UKRv6XB9QVQ3T+umS/zl6i4rBFghxXhjGUTzW38qdPTRW39Nvtc3p25R?=
 =?us-ascii?Q?kEmefM6vFeEjddgEDFp/EufqehiMygpn8SFY/z5N+w0gKl50MNLTCDq/EE6b?=
 =?us-ascii?Q?gbofa+zOBhEOW7A8/Hh2FXpqjpx5T6trTkcR6vIj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8dc3cc-ab69-4b5a-1c67-08dbcff3cb93
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 16:03:40.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK4t61H2dU5AbCWYPIep67UJIAE4TrqK/qDJ8pS3uiSmLXsEB50TcpPnrxZLI7w64Sg43NiswdnLyr7VeIxnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:48:03AM -0400, Frank Li wrote:
> Each patch is indepedents. See commit message for detail.

Sorry, mistake sent patch "master reduce clock"
Please discard this patches.

Please check "v2-Resent"!

> 
> Change from v1 to v2.
> See each patch notes
> 
> Frank Li (6):
>   master reduce clock
>   i3c: master: svc: fix race condition in ibi work thread
>   i3c: master: svc: fix wrong data return when IBI happen during start
>     frame
>   i3c: master: svc: fix ibi may not return mandatory data byte
>   i3c: master: svc: fix check wrong status register in irq handler
>   i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
> 
>  drivers/i3c/master/svc-i3c-master.c | 49 +++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1
> 
