Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698A67BF260
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442131AbjJJFpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbjJJFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:45:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2132.outbound.protection.outlook.com [40.107.95.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B43AF;
        Mon,  9 Oct 2023 22:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzwobzK2aq0TAC+Gzo6xtkicrlfIf24CqSXIbT4/iyO6ivX55/bDmHCv7ZPMYKUD0OBDMbMaDXlTzRwuqmfndHGaVIp9MolgrRKnnOSIUGWMK9JeMEr17bnFx7Of5OVNHbhR6sWXaNRd6Qbqohh6HfeOR1f7uq76DLl1wX+ov5HqlIH8/XDAh5Fjp8QWlVr8y1JSPSHv01k8WWhUdQMubK0ShzyqGUwjjWqWiXUqAY4tNApPxsMaz/OOjvpikHJHQoG8DvGwG+2T7dr00LKXL2Q2nlrOcPvsJevnkrpY9ccA+rGvlEvPNC+DgkmLI2jtZuGjNm2YkkOKheyl7f5xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv9TC2jI0G5Wh//0oSav4shiU/2wOyLqijCjCuIdYXo=;
 b=GFR5SuXp0MWiJDmZ8nD8cH6YtjNZgNRh/oYW3TmXkVxvAEhpmVCnSEB57eM19BZabfMrg8s1H1yhv/l+nrzxnOdNYWXtYEIRKiCMe6xfA+WqKfqWmGJfSJ6hHvvW9m1zRdxARFFG3qWDaBFF0TokJT0IC7LSJYBO0q+ch8Ih2F/rkqizhihZSK3VzrqP/aIRBVz8LZ+kmw3hnrxqUwMP9FLpQAwmf4BC8C8OHdIsG2O8/RM+GioowzMhiR0B/wUwdxeR2bVagNYAwRU0HXsQnbmXAykJUP7lDqYGXbcvXMp9VjVQcKZT4XeGjYFB7NSCRB3HRa1E5LR5uTzhqlWsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv9TC2jI0G5Wh//0oSav4shiU/2wOyLqijCjCuIdYXo=;
 b=Ynxj7/ZEl23eNi4CcjIfeyiZ8ORe474VXZCj6lylb+mTpj56d2MiyOeRxRrtBNAcyVaat/zjRRvqZHr6Qf949qaULLv+6HZzLcL63F7cu4mWOo5JmGkCGVtvPVKqSn2n+/63rYuZmrxebhjnZ4dZQlGKDT1ZDK8jSGOtnxDBqUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ2PR01MB8434.prod.exchangelabs.com (2603:10b6:a03:557::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Tue, 10 Oct 2023 05:45:33 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:45:33 +0000
Date:   Mon, 9 Oct 2023 22:45:18 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-perf tree
In-Reply-To: <20231010095601.1443903c@canb.auug.org.au>
Message-ID: <98ffbcf6-a646-ac2-5785-f78644f7cbe@os.amperecomputing.com>
References: <20231010095601.1443903c@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:610:b2::18) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ2PR01MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7180b9-8a24-4481-a63d-08dbc9541e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kaLZ/giUNEjBhG9fLHLAloRc++6J5UC3iLSJrmI5Q/F0imldQ9tLWbuloJpUuoTXZDrmOQmaTfm/uVh+H1dF0dd7tRaKRBo7vVuo1BTYQ5+ZpCnba4Usif0W80Ev5ebGZ4rhXUmXGd5lOH8EnU0WqCiTAP6OsCYWDdRvvm5dR7Fa7w5oAx13S7Akih4wljWsow4nHdBvvRA8GCmU0x70gQ+HmeS4fn4/jtJbNi3fGOm7mXhV1FCOagCsKMkUMDZ2x+s0XfK2ACcqQoLFzV5e/Fof3B+LkxeQcVukS911xaYZSuQXU77XM+nbFbmRXtAfn5UomX4ot9mlridvC5FaP2n3eZrErZsqOApEs341VhpTWH/pIQfUyu3GgBepMvhLWzPXqya9JdaBKY8bTb28qJW/6InENxoAZ5XHTVj6B2wJW+rfxXthsxfEqVraV5vDvmRcFF/XuzWFvAxuABQq2CRrCNRRi8sLq+4KtTurXSvK4Pb32ziTO4PzUeCb5bg8YwbKgQLbCIa1MILgj+zrxmNVAvsjiw8Qcb8E7SqS3X9d8UvSPTbeBgkkOhFDnOUwzAD3DgwXp5hC+xV2mY4832MvmCEt4IcMJ5VfRRL49ME28zS7klxVUnuWXCumN0EP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(52116002)(26005)(2616005)(38350700002)(86362001)(38100700002)(6506007)(4326008)(478600001)(2906002)(8936002)(83380400001)(8676002)(6666004)(6512007)(41300700001)(6486002)(5660300002)(316002)(66556008)(54906003)(110136005)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eo8hHkdtCNFm29D3WU1yM21G72ygotZRKfmdTClqBOJj5WNL1CFNS4BtCQQ9?=
 =?us-ascii?Q?GZKGY9jkTncbnDWnsUz/Watn7uG8oHPSyR0D292hRMNMQVpyhgRrH+PEvmvc?=
 =?us-ascii?Q?CXqhefyv+x0+TxhbfG3YUbQ37fbvtqmEcWVeiDPYRrpqL1yFnvGa94TiqhlG?=
 =?us-ascii?Q?hf03CP84uaMrhFexqN3H/7s6F84qrbs5IGOdV5aSfH+Tdg7sp1SMK7Ve/Bw7?=
 =?us-ascii?Q?JPu8ow4o+PpnGuQTyD1VqyhsnHLUAIPo5Q6SF7Ktliae5gpSJVqQs9J6eF3c?=
 =?us-ascii?Q?sKvVK4o7UMGzpqyRDPd6fz0ZlGeoy4E7axYFr+fz4JOByTBQx8S/bVdATOIx?=
 =?us-ascii?Q?Tr8m7vbKyJc79YUE4OvsYcN1I+hQ5H7ZwBp2CmDi2R0cc/UbbHvlUwt1VKzK?=
 =?us-ascii?Q?uxKtPzrtKAGsoj8n+NuMOQFKFywNOWFl74LJVNofRwG/FvcrR+FyuMq7EOrB?=
 =?us-ascii?Q?63vJIUAjqX/pUctjL+RiyFWobYwZ8emrq/zt+amiQijjNRZlhK/lltLilsUd?=
 =?us-ascii?Q?n/f4Ps5MoKtgwNqBgA+wfgSrvGjS5JvPSO0Rvjsqz0Vf4sGUKgmWHxUYU/JE?=
 =?us-ascii?Q?pjd6qRdyfXgWEa33Fv+CI1Ca+GKYNLV3g24w1+TOCblr5v/0f+nk/0BaCmFB?=
 =?us-ascii?Q?rN6HQxzwBFkXGjDg9pSEcTC2u8WzL4sEy4N45XcJYTAsdrOr+08ji8JuxgyD?=
 =?us-ascii?Q?J8JE4TTgZmPg+ivUcDDAGj/rkYSg5avvKiyATn1OXZxW7erCbRxz2DbRPFqd?=
 =?us-ascii?Q?eKh0eyO8+/VP4a6HKDi4ogELNp4ewo8El/d0Nc/vZrtvbZ1Rp8gRgGtLObAV?=
 =?us-ascii?Q?9aWl/6q1iNb+F7cohhDY2+a4VoHjJ4dJSjeaMH4EPLI++69RerSKnOj0SKce?=
 =?us-ascii?Q?m5nv2n+OtrJamTncbgkzS3SVQ3a5GT+Bq27tfbJsX6t/Vwl9kN3Twj1QjPya?=
 =?us-ascii?Q?K4VQezEc2f6WpBSC5T7YHse3vIdIHDpwGKk/ztE+apswn2bvm5sEg9oCm9+i?=
 =?us-ascii?Q?UJ7lAthu/mX+ZWQ/bj9AazmU7u2CWdNlt/zV/doWpuAudMeaOBnMg+YJrUqE?=
 =?us-ascii?Q?WYRoZKHeYwbrnaBE6FDrHiuj9/oub+ZMPddZL3kTtmXs4RJ7U+R/FfPCRZkc?=
 =?us-ascii?Q?0LUo0jREpfwKg9r9XMelnUTdxpR8IPOwDi+2pK2iTZbMimglRoijhop3QaK9?=
 =?us-ascii?Q?BzBuF9QNGQFfTYoI61iLPod18fXsLj7tR2cQUNBgD+A+D6UjniJQNgw4eYrC?=
 =?us-ascii?Q?5aFBFVX6lwB0V061VwBcLtFWngTdkZMPRLiycbtvAJPintirhDZtW1jTpadi?=
 =?us-ascii?Q?emOT1egK5rE9h+c6CFK288EpNX7bN+GNqptHir3DL1lBXfsaeOAifFQR22h9?=
 =?us-ascii?Q?BXBMJu2gyI4x+aPai6ZvtsSzXhQ0ss79hO0LD2aGA5Y4EMtA5OenrRLr2oas?=
 =?us-ascii?Q?Je2bQaum5wULqN46GsL+2Z80C1gSFOL1QILHHNaSce4IpJexKkAkta49l8Ur?=
 =?us-ascii?Q?tiMycPwfDo/dtj3aT0Wy2cZwIylHqSOJk8uoMvteuf1K2gm8OT3VtN496EGf?=
 =?us-ascii?Q?Df7WOzJYUQFSbfm6rN4u4qr18xVqFneHR93bUMVsjw0M6wa8TLzySFPuYJ9n?=
 =?us-ascii?Q?wEn1U+HZu1gam1/GYBwo8l8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7180b9-8a24-4481-a63d-08dbc9541e3d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:45:32.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHk8xiWXG7C+poaGIgVJHeScCXAxsSY/KZJ7ABp6y0ciXEn/D3D3YaAKR8gZCJOAJCl6DWY6Rn4pNVh8hfmslrAqBTCKuwz1CZda2pGK+GhEgyT4Y4XGDDPesg/VFpq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8434
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

On Mon, 9 Oct 2023, Stephen Rothwell wrote:
> Hi all,
>
> After merging the arm-perf tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/perf/arm_cspmu/ampere_cspmu.c: In function 'ampere_cspmu_set_ev_filter':
> drivers/perf/arm_cspmu/ampere_cspmu.c:164:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>  164 |         writel(threshold, cspmu->base0 + PMAUXR0);
>      |         ^~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>  290a9c0e55f8 ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")
>
> I have used the arm-perf tree from next-20231009 for today.

Thanks for catching the bug! It doesn't seem to happen on arm64 build but 
I can reproduce it on x86_64 build indeed.


Will, it seems that "#include <linux/io.h>" is missing from 
ampere_cspmu.c. After that also x86_64 build goes through. How would you 
like to get the bug fixed? Shall I submit a new version of the patch, and 
you would replace the old patch with the new one or is it better to
create a completely new patch that only adds the missing include line?

Cheers, Ilkka
