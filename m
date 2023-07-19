Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F7759FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGSUbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGSUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::70f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211E2700;
        Wed, 19 Jul 2023 13:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx7vydefjrBvTAJCQ2Lux+Vt+nGbIfMHFm3Hx6jy8wBPQ1/tWL17VkGAeW2hMU/DLJmJnNygCTihhdH4pAcOMU3XBcu0UJrNlHPoo0T73RHRX9Ybip6Ex62zxY4Rbz0T5L4X/npKRTh5alJC2ZU3xBJjKIFXAF4xzYBpVAlBi7regwN4KviZsa6vdRZihXjIsH+aL3WVdjuBF8WxTWX5uWSvI0iwePNs2wGxhPTUuwqXCKsQiqX7mPrqbGaZJSmj0BwNuYnB+ChiDuJbxOpVPeFnc/UFUADQFZFpROnKAmeYl6n3WPO1j4MMAs8mcdall+L3FVBQhiySpVLDUNJJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r64cTRbXWrKuv/7glCpOeJToLOqq/+33OMOfBT0l6M=;
 b=mGe/hB997Xzd4OOqNsRxKM2Iu9ngCgs9W0QdYoUsyvYHcUu3fLdNRAIWczfUZFLpsrT+3MPJj2vRQeaI4MkPY5CGBzCeoJt1/iYrVCGxDR45VqE2XKqJ46L7acgS0xJzbzahPKhhAj8Oxe02lPeUOoMQvy5L5nkfLLdSE+j4YLNRvJyQU23r1qG61u/5dVckpUrwU/wVv3KwlP+4gxrWKxMV4UjDNI3s/Uml/+rXcSHrxB8cotP/frOsjLKcC2HGvcrYXQvC2BddpsLgUADxgjJ231hfrewQt7UKdx4yxJy+5TxKT9jIw15O8w0m5FQlbl63VWT7Qn95lYOXyK5M7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r64cTRbXWrKuv/7glCpOeJToLOqq/+33OMOfBT0l6M=;
 b=CPRrDxgmw905tHjrenBOpMhiuGlzyruu2KCA96TvFMRyEoeEIntJ5R57fiFxxbAnMG0CSL+8rduUCD3bOGq7iTwKfy6Su/b/6+8dFB6DHyI45s6Oun1iJEDfqUSfLtZtirZtGsnKZvXRb/Dc1xGzSX9I7Q+msnzD9R6IrPtMJF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3698.namprd13.prod.outlook.com (2603:10b6:a03:226::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 20:29:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 20:29:38 +0000
Date:   Wed, 19 Jul 2023 21:29:30 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net-next PATCH V3] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <ZLhHqn2mNP6L4qNJ@corigine.com>
References: <20230718044049.2546328-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718044049.2546328-1-sumang@marvell.com>
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3698:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e2a212-042e-42ac-99e5-08db8896dfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtDUlCxq2pHfaba8zAgHsa43WY5Ub9rInl/phgS6FS+PsO6w595+d2vvAqW9KEdm1qMT+UPxdXO09m7pLNejbDvMypGuUMgC28xpxqWIsIJqk0Dub1Q4W2zOoeGa4YIWxyOCnIIhWlERTqJmtt1MCvGYb/Ey7jm73mg6tfQA7XGQEnpvl28crpszKSIKil0NNrACjqTfqlSmtyIikYx5ZXTDuNO4buvuhesaVzzZujnQFTgw6AYO8HXp3JPlUKbkZnJQXiicAOB0rVi9nywZN/QJJI3ILmrzt3pzv8fn1fKuIoNjj2blpyNaN30Nh+Bf5IRHQRTD3KIKQOqtvwma17K4mqyLiWyCHxXdZwVjnKXz6+SEtxWZztCCDdEbCKTnRK6Rde+x0uPmX5NQLb+Ks3nHldoxHBNM21ybBOLzGufxlh6p11005RbRVRJWWvkg89Gbf26phDSPDcB0vIRPSboZdEEwxlfbNTAs2nuqUbWH9XHgiMTHajOc8PKQpwLq+gP3u5oQtSMNcZYADsgv/o7JtfhEcV9YqZzDjJjFkB25ln9i6BymDbEDlsGx/iP0iB2anzRXG5FgErfTw1MTolC1yGvFBubb/pjyKLVAIjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39830400003)(451199021)(8676002)(7416002)(4326008)(44832011)(41300700001)(5660300002)(38100700002)(8936002)(316002)(6916009)(83380400001)(2616005)(66476007)(66556008)(66946007)(2906002)(36756003)(86362001)(4744005)(478600001)(6666004)(6512007)(6486002)(186003)(26005)(55236004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyQh0KReBH0ci5vURzghhlwx/hzhrPwx+dy79bHfHPaADnS8yDe5j3gYeA9u?=
 =?us-ascii?Q?LJZwmyU+ROsaT1Ug0ufxH8PNmgF6T6swbJIJaoBLrsFbq9yrhjUraWxUouyP?=
 =?us-ascii?Q?JSSEA+s1qRPtwUsmxN053DPS8XoQj2eKUEiuU/WUz5julAzh64QUgwB9na7h?=
 =?us-ascii?Q?HGcEVy5J8krdbw+gNykM1f8qXNlMEBOwE3BbJVc/QmeFfZjakVhXFXrcXfmK?=
 =?us-ascii?Q?VliREJvdkIFS3bA1ppVKSBTrLNIfqcu93W27mau0Eclfdv2XpMs5TXpNRvZ8?=
 =?us-ascii?Q?MND0885IW/HBAN/RJJTWgi7wKaIGxnI8hTZAqBvpbWdOSv1+0XLfyMZI1e3a?=
 =?us-ascii?Q?+VDev6a8mgZanEIfFb75V87e6QuHUpaG9iy932uz9Z7DkvNl99TCHQf7bfUX?=
 =?us-ascii?Q?yco0swAJm1ICotu/0sV+U2ou/PF6UA6UJBwNeEiBakjw17yKgdmz7yTt2jKc?=
 =?us-ascii?Q?MPx6vi303SgrsdLdy/kf1VQiYwXmHI0QTxyS44tgWysJl9UYclS9TAyAGGrq?=
 =?us-ascii?Q?eN0L3LijWezlYeFx0USk3xpjkfh0cd23sGdMYMieHQGby1ifibDb3BRAsIcm?=
 =?us-ascii?Q?b1AKGqaKKRZv5B1KbZT3EsEiuyr1uwo/yRLC58vqfaXWAbHxZvcFdznELglf?=
 =?us-ascii?Q?+q+OfGLSALdlBJPxPaan3CPKENveWWJb/HJpvLYSgNQYfJEl3mI/hRzn9W0j?=
 =?us-ascii?Q?gWELL/L1adk9NdurdaoqcakQuG8wnlOkVaZRXC5Qc0aosivukODAt6KgQk66?=
 =?us-ascii?Q?gVCxlkZB4ib/AZRJTFTtBKDVNCbTBT6wtwQpOM/9ZkIzoFmM1T6bMW1Fz8UA?=
 =?us-ascii?Q?YoxqjmUxIYGVtO+mDzNlDF7qAoVTMQDF17z0O2dqDWTuxxLPaJoBwPUqBoTc?=
 =?us-ascii?Q?f83xvXCkIfRstwOwEcrH1hV4L84eYBU3WBp9aGiGe6czULXaDlsPE3APrlFM?=
 =?us-ascii?Q?PXt9BXLV4bz2JZXygrmU9zPru4MH70srgmfrcpQN0kIBvbwJhgXXbIAzhOg6?=
 =?us-ascii?Q?b5hkYqbv/rfMx5GjqEaFchxQjuaF48f/u54rAojrs0TuVdCmYpxVTS0GvT4t?=
 =?us-ascii?Q?JPcFUwqg1CqtzvTIT3HYYe8iKR/DZij3ohsIAhqo5nH7nCn/Uc4OEkqb1jxG?=
 =?us-ascii?Q?je2Ut9gT3SAGK2/aYH4HVHmT2FazS/gDQRyFFlQ03ZEfwRUFjhUhsicUF6JS?=
 =?us-ascii?Q?N2Ap+fH0SvocNJpnFuYBzHokpjRPSBEq4NyEjUg1CieuFIkmnKjo+PJLnZyQ?=
 =?us-ascii?Q?I4UfPYClCF3uiCJagAM7yfxuFdKBpAOsxo8S3YZpj3q2q1ixnoQAo4abNTBt?=
 =?us-ascii?Q?tSSnpzDYu+lCaqrUkUwzVsKCuvaZiaLCc2KOAL37/NVVo/5dBnOVb4APTzCH?=
 =?us-ascii?Q?6bEbv8xYe585ONcBG9NU8+ly91JEZtTpdQdJqFgCnHq/COJSv41Ci5uw0BgY?=
 =?us-ascii?Q?1iNeqTZWHnRnjlltvIke9GTi3m9oN87WLiJq/GdbOwD4hpLHoNfFFcW7nbgq?=
 =?us-ascii?Q?MraH5p3UtMnN0IR0Ghoj2HlDMn32d9KY1xWlVLac1E2vX93Dyu1iSdStDdIf?=
 =?us-ascii?Q?NPqE0gVcupw6TAgCn3USF4PQ+QS3XBdGUOkLrvcwoZaQ8J46JTzAD1crHGPD?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e2a212-042e-42ac-99e5-08db8896dfdf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 20:29:38.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iEiGVR0hfw274C8pb1Hd6qSsQsPBYqMVjxElCrodf3JQg3fwD7T5JqEM9Z8zUKIb/OvF8mMsHKcOnOTVhCfY69+WoXya/5uDOX7JOnnb2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3698
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:10:49AM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

...

> @@ -729,22 +816,106 @@ static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
>  		mutex_unlock(&nic->mbox.lock);
>  		return -EFAULT;
>  	}
> +
> +	if (cntr_val) {
> +		rsp = (struct npc_delete_flow_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +								      0, &req->hdr);
> +		*cntr_val = rsp->cntr_val;

Hi Suman,

otx2_mbox_get_rsp may return an ERR_PTR.
Is it ok not to check that before dereferencing rsp?

> +	}
> +
>  	mutex_unlock(&nic->mbox.lock);
> +	return 0;
> +}

...
