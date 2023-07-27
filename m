Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5A76528C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjG0Lfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjG0Lfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:35:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F3B212B;
        Thu, 27 Jul 2023 04:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mainZNKYF4eb1OSs6Wt378lwYY9I1fysWoXEr9Mhfk5+2sephyPff41Np4bgMtzDJfq+Tk0K6874aDn+aH4F/C1iLqI1wqv7VVVCAKJSfMtza2JjFP3+FXMDX/DCXSka/t1KJbS/+MmwH/AzKomQbxV+6kBJwUVP039KVk41wEZ2vs/TM2dWhCIaJfRrpRfiJ3OtQPJzxnx/ec6VGJv1cIi3dq+zaLQp83KosXrIELCz7oOCZP+8UXUxtjbqiAeCbAPGBxCckvY3WrT4aON5j852mvgFiE95w2Q7t+wAtNMnnUHpT29rHsgqowpc7LKfJ0erw3q4N4gnUBXBLNM5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVUe0gBFQgahTc7+C/TpalUIn8sR8HX7eXFaN64RLSI=;
 b=OKCEZ5hvpSLbulcvrm5qOWEPVG5Zaqudd8MHr6S8um3MCfTaAXd9Ap2QeqsxMaSAhjLZVKw9vvCxuvhUooeR+ry5F9ArKePOu1w+ov2swPEu+r28pKae3a0oD8bvldkRjsxWha7XScC+ICnyRHFM2IFlBFQfbWkz6VExO9CSfGlhln6mFLWf8IKL9h8MecddxU/OpuN3GzeHZ8I70wrQxJz1RU88NOo4p30mIHzDxCo15E+T6jHS4LR1XfR+aY6CHsc2Kv5OkYMvfF58VgLUys5CqnhRi1zAcna2iqS0UKDjo0GJT/MLbdA6D0HYN1kamY3BakWJMtXWZ/0JXrAkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVUe0gBFQgahTc7+C/TpalUIn8sR8HX7eXFaN64RLSI=;
 b=mqM87BF1Wp5cqEVdbX+JpMK4/Q88t6uFPAqkwiKu1rt1raE3hcZeOipP7kZX5PD9f6hpaZdBC3zvt+E8aoUC61T3oxmgFJlKwDchfx5Iev2jUnmMmPy/0cQQF6crzYtkrQz1DjbAScG2hmMslexDE2AQe3odt+lNXpchPZ1fo9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3761.namprd13.prod.outlook.com (2603:10b6:a03:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:35:37 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:35:37 +0000
Date:   Thu, 27 Jul 2023 13:35:30 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: datalink: Remove unused declarations
Message-ID: <ZMJWgjSSyAlwAfh7@corigine.com>
References: <20230726144054.28780-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726144054.28780-1-yuehaibing@huawei.com>
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b3ce4-d4b4-4a67-3df8-08db8e9598fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJ5RzSRBhqZJj9YutS+K7gLvIINbUe1DymjLyVN1PyV0C1M1kSwMGk/Jo6iIz1DqMEhNZsg4ITc5xQYnShSRIdgOeOVZB/1OfrFO2hn4+ks/LolyNTNJS8xP/h0ngVtTqTZmHX0jA8bRHhrHaZHxmUTPleEazk4UN7S0iUYluPTZEYPif7AquGR0CdMMwqE87wIq5GE/5iEBHltbCWb9hFxnwh30NlZFy/WDqOF9D2H9sI/yr69a4ZopK9eoiuQi39aprP0h14wTsIh253xZ3GhJZueUfBBUqm7aUBuIs+a1hijVSbJzwsEChfD1BWupIJKKVoDwB+lDubECSy+XNtZ99mX6vdFX0wAAJSVpAk/vcpAE8JRh857+Il/2zVu+FlgQd1VxLWahM2GNomQPJDXbztRdI6bkdMMGB7hnLoFZB5ayuxzUK1IE2RlGWvzvCufM9wcPAaGeh0OoBJzlcGCt4c+M2z3vujJtPTJNm3p5/Fbh+78pnLohMpHYRLIq6hw3HcGAQkVxBHw5nr3eEVgoPlZ+DMweBGJYsq2MDE3QdcW+aVUpdHLSdmq4IXT+YhiiN7qTi3kMqzxmneDtJ/9T0MVD3aO64uS8xWUysWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39830400003)(136003)(396003)(451199021)(6486002)(478600001)(66946007)(2616005)(38100700002)(6512007)(8936002)(5660300002)(41300700001)(4326008)(66476007)(66556008)(316002)(8676002)(6916009)(186003)(6666004)(6506007)(86362001)(44832011)(2906002)(558084003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tq7t2CT5UqC7QDHZA0xQNN+kzlFFZg4yNfXt0U1SCgUoAbnLwyjOfKEIsZXb?=
 =?us-ascii?Q?m275/s8ZAXf8Wbkf0eIrkSrC11C/YkuVoiZ19ub0aJ6aKRpZQdngjayT7lvK?=
 =?us-ascii?Q?4nhet7+4Zwb6tGqfWHI2l+GtyulYlQTZvsesxsiWoemyTyJ9N+jTfqt+QY/V?=
 =?us-ascii?Q?Aw449i7CW2i5g3m7rfh30UmbfpGKba7kc6ENHPEaSa9+x6iYkSo6WJVuSKdc?=
 =?us-ascii?Q?DaVvWpAsmMN0aoKt/ta7xztOQxEE23kNBY6YxaqLo4EsqW5f0GwgQU++iYTj?=
 =?us-ascii?Q?7EYLQfOvIxOSYO+KQhbB3iOfLna6Mq1eeXm6Ile189ofZUDyRSAHWIlP9zgw?=
 =?us-ascii?Q?wyvqE+K9lbyadeJSjdC2Wl8jMx5uFXeK2egR9JA7NBdyKdbLFwTyhSQ5kAcO?=
 =?us-ascii?Q?aqFqjJMuxPx1jvEl5K2K9n5PiG+cQXk8fdE7Ef6klggQoxZqsJaAnOWfpsI2?=
 =?us-ascii?Q?/OjvSBY+SrfIX90sl2WwW8D0a5n4vRjsxcLFOBwAPb5dILBXOt1X8tjn02H+?=
 =?us-ascii?Q?s01AzFp5Wgq7sjMPhUUJCpmY4CHqUAWmVMBC+3shmufBEV4aLgc8mMmHAutQ?=
 =?us-ascii?Q?ybrjA/GF236nEm2OXF+GXBUQHvjNYHlrA71lWxqkMv5IDVunStDBmRPa9Z4d?=
 =?us-ascii?Q?eeMDhnCn/lj3Yt0O/AuLKzTTiBG/+kjQ54UmGM+xRNZQlDI01s47vZEZcS1A?=
 =?us-ascii?Q?6JW18mAy/bWw8syHHSid710cj66Y4LXJgt4dGdFTUWlCWB1ky1XhkUaI2xMS?=
 =?us-ascii?Q?4DUdWYugTKNxcddawhIHktN7qCnU3ACn4zLTnNR4b4FNuNB8ihTe8vJiFEkv?=
 =?us-ascii?Q?Q5gomo8j77J4uvo4eRBPozwOe0cFD9UB1zfVTBrvCITKtzej4LTIHH7pCW9T?=
 =?us-ascii?Q?1LzDYV41ro3704PfpXH1G3gl/661T8dtj0u8QVIGMmWm4V1qNDcL7Js71GMh?=
 =?us-ascii?Q?PdhPaMKdhIdRcPCstpN+gfODFW75QDiTHOB2D2zJcX3+YcdWDlPVPKVHyOdt?=
 =?us-ascii?Q?CkK2e51by8tisQ4PZTdeMPwL6TfmLKq8MdjvZxEfTShAWC5c/R9VENcbVI/A?=
 =?us-ascii?Q?EUhcw370RBSMCiXIGaZrAnTpTKyAzMESlHKOzptSIUkrKV5NBIfW8TtUgLAk?=
 =?us-ascii?Q?s0qiPjwemJf59b7kL0DGG1ZJWPE36VStHK3r2TdlAj9CJyKjzN6dDVLLc77e?=
 =?us-ascii?Q?GuudhFoGXMlOYsKCOnoPTDkNNX3I55ow2aOuCl4QrX1A8ix1gvakPEdEwbr5?=
 =?us-ascii?Q?YVQwPYRAaboRPuph7mZuzoAhsjC31b2nQLoW1WG9oq96jLLPM34GhQ1p1MyV?=
 =?us-ascii?Q?qe4MkowJmFV8Y8naSXKf5RN9ItESAOwbmu+uhzHxyPPMzO5bALyTnBBQT5+4?=
 =?us-ascii?Q?3meWS/GrK/TsSK3aRcfPnXTo0Q+JmL0RnTNxIy4VAdP4a2oqlHIUeXt7UgJF?=
 =?us-ascii?Q?jGmlrXVRO/IvDLl77TjnshJGZQePUBjx21NxQNnKs8NPOeOcht/fSUtrPZFJ?=
 =?us-ascii?Q?VRq/mWCYAgT84Qu5hLxDHN+KCdLjeksumSgEIH3OKh6mdjtiHnNGnr+ouRa5?=
 =?us-ascii?Q?RJDZ5oPwqhvp76anOCR20gVt4SMgx5ZII0ViMrpF/BkUJeCNGSNX7mVcTh0L?=
 =?us-ascii?Q?e+a9bQHxPIOL6H0+7bZq0S6MBURXBZ0MPZiSvTr9OElzT+D16QvwE7/me70P?=
 =?us-ascii?Q?NvDKsA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b3ce4-d4b4-4a67-3df8-08db8e9598fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:35:37.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re7RBOoQO+3/mXhlyXWNgV2HE9ZBAz3+L+3Sm4UDkgBRB5/TCtLuH02Fjelk2SwInKvUsKgLxzOC4rHboF9k/T/zUoiGeyx998lzoLRZ7pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3761
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:40:54PM +0800, YueHaibing wrote:
> These declarations is not used after ipx protocol removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

