Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD87FC117
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjK1Q4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjK1Q4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:56:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A0D60;
        Tue, 28 Nov 2023 08:56:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpYYtLBdC6VGraBCfct9FUEfmznTwLLKAeofqErBre70e7MUcQSplBUcZluF5sdlpJnIH21p2gaVqg4Owh7vYxrJu7ZVn5+tgmtbdH9W6HeP82P1iq+VqUHoXXq0WATjqG54gnIl68MDUjGqMQnJWDBT2kv/ViDxTbcoqpKtx9RR5BiH7Apq8YmyibZX/vNv4D29UgjHFbhLPi+jt/0nkoIf4OmpwqFXiyV97Mhku6leqDDhqYCTQiJ92mbX27TVy++U3S9CCLaLBwXYvZBmUbUhoQkO6tV0xBequ/ZU7MyHARGp6HdVr80VK3PLy/Od5RIUBL2MFnSXZuX5iOSw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUNiUByFKLNt9aik/qwIaJV5TApKUTVxkc4BrAIPagQ=;
 b=d44kpZryvcvRqo+IKt3+qdCIpYDbJtkTJMbsa3MPvD+59sVBPqvawTfqNuhv94Clwx1TZ2BL+7ohs/vdQWCKYY7/0xJgCK7/zU87RtGYLet3RzX+njmiNf0i87KNNyy0TEAN9yoEAa1qsZUWsXxtY61cTeDNWiIHc7wghn5ZQvDxzRSmHZ8ZyWqYlBevAVj0Nx+qzhvoglELyRHanBHnrJIprUnSCLEM/oBfmBXweoIERYuRctCm5sOXA5J3pYWyH0L1aQrcslicMZvH3kYyMo0lsDOO2MZBVZ7FNg+spJ1K1xYiLVeonOp7t/k8mseJdMg7vM7vD4/a9/96rPybmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUNiUByFKLNt9aik/qwIaJV5TApKUTVxkc4BrAIPagQ=;
 b=ksi337FTnFlLQ5PAnFjixBG1xOMIcwoo5S1DRZTiPWaGIRYmBoI+1+VPW+FicRFsqMpYFfLLE5rLEuTQzE0DF/Y4P+A+98SSXM0hhKuNTW58GIMcvHu15UNL7THHhFYIAsfcSWDVUxBbWYPFSDHzIXfxp6JEOVBFp5+5/QaB6y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 16:56:39 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 16:56:39 +0000
Message-ID: <068ace8d-9e37-4262-ae08-7751793be32f@amd.com>
Date:   Tue, 28 Nov 2023 10:56:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] crypto: ccp - fix memleak in ccp_init_dm_workarea
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231127034710.23413-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::12) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: efde23e1-b8d5-4858-5049-08dbf032fd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJ1m+DXpaYGp3hM0fzAbWcMRUeWakcdP5TqYg1N6qWmKETEu062WuPxL8Lc6dBkX6/0A/kVBTXJKWT2h+WKNMxz1iPOMt7OeUwms1KZqY8xrKNNGdKh8PYsEJzeh7/Z/y4amxr7WLJ5Wa5CoMOc4aH+IOMQ4fwn2BE3rPbqA9ECldpIoXZS9txS8XUhSyDifHLTssBfH6RB1wIO8u9Mr3FEykij5yxQ2ncablCTwCBDxBgZ/8PbiFFaqNVhjW6yjDgEcwK/mrrpi2C9V0binVA7kS2G+YDNSdJrLvVaHARo2YmFd12lJb8sZ7XnKr9QTY2x7BGpCJKs8Te7bGoB3Hr8sm8ITyBTG7oKm5osSu4RcQw7l4Is3otQ069r51KaOEqhkrsROnohcoOXDl/e96ni05DEOH7kCs20bsOLAZcmHHx4eEDDrYxF0+k7UCVqgfyZ+kkLYhC3AKW227ttuLUbMKkGgSODy7dD1u07nOm7hWZYD9rP8SmTIGraoL1xxXZmeZxAMAkTvuNOOiRpnlzr94LWC0vJA1m0kyMSlix9MV1pJHXWZTJFksdcfylTnP3Ya3r1v3c0zmPqMpL9s25yHg7EKgZxBQxePM47ea3tz+JaV1HVkgb3ysttOK9MdUslL0g0lYe7FhRxkp9dDYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31696002)(86362001)(2906002)(5660300002)(6512007)(31686004)(6506007)(8676002)(4326008)(41300700001)(8936002)(83380400001)(316002)(54906003)(38100700002)(36756003)(2616005)(478600001)(53546011)(6486002)(66476007)(66946007)(6916009)(26005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em83MXk1Ykg4TzFyL0dRTHlIdUVRWE1BTmQ1VVlLblNaeXVsQk5PaHUrdjJn?=
 =?utf-8?B?SFU0SmRMb3QvdERvRk9pbnR6UVNSR2lDYnRGTXc1Sld3eXlteUFKNFNJRVNn?=
 =?utf-8?B?NUJjOC8rMEEwOVdhY3B6ZGM5Yk9NZkduZ1FkSXBLRUdsSDB3Mm1BZDN3Yk9T?=
 =?utf-8?B?YmIzZVd5aXBqSGpGeHZSdnZ3dy9zUWF0M3k0Z2VxK0lTbUphbFFQUXlhQ1pr?=
 =?utf-8?B?ZjJOamc5VW9BVFVBQ3ZJODRYMkRuMFFQSk5ubnlneHRtRkhVaXl2eUtkNEFX?=
 =?utf-8?B?VVZKcDNvWU9wWU1Qc2ZXSVZ2aVhiUE8wcFNIMS8wNExJN2lXcWk3ZXhrbjJz?=
 =?utf-8?B?REhjSS9ZTlBGSXBNYm1zZkdML1hoU0I4blh6czRqTEVXY250M3cydWtlQk14?=
 =?utf-8?B?VTJrcVBGODl1UzUyeHNVOWJzV1gwMXJaaTJZeENjaXh4clU4QkZ5ZTBMS0dv?=
 =?utf-8?B?eW1YdUhmRzBCbjN2Wm1wbUN6VUxyR1pqVEtDOUVaYXQ3ckpMS2lMQXB5M3lm?=
 =?utf-8?B?b1J2clRYeVZabXRMSktOaTBwa2I4RFRaOVhpRTY0c1IyZVRXdlNQbTdWUU43?=
 =?utf-8?B?NjVHajlRNG1CWDZ0QmZGOElyNmI0WmF0NDNhcWQvSXFKVXcyczNXWFZxQmRs?=
 =?utf-8?B?RUdVM2M3SlNZOWROSW1kY3hsZGJITzRVWktTQ214ZGNWOUoxVU1BRHczb2NR?=
 =?utf-8?B?MTFZd3ZKYWxmaFp1emltNUNYbU9UWCt6KzBvMEhacU43bjNib1NEYy9sYmRw?=
 =?utf-8?B?bk1YWXd0aFp5Z09JdnRIVTRGZ2pzTTcva1BzRUJEU3IvRTVDL2JEMWJsT1Ja?=
 =?utf-8?B?VHEyVmFmT3FUbk5oODBwK21BVjdSQzBhYm5jd1drWXJiU3h4THNWV3ZBcWxk?=
 =?utf-8?B?b0VuZ04reDNTM2p4b2N5RWVBcFM1YjVQNWFrVk4vdDloblIzUnYzb2IyYzk5?=
 =?utf-8?B?Z2FBYjVSZkFrOXVJaHVTQ3RHeEI0cGUwL2pJVWNMNXNXbEppQ05vVmxSMVhl?=
 =?utf-8?B?V05OTk5KU3hmRTZJbkU1T2xiazRiR3BkbXIyaHVzcnBML3NVamwzTFZYbldo?=
 =?utf-8?B?ZDIrMi9zc0hsZWlnTlM5Zk4vTU1HWnJZY2ZWS2hRdmdEV0pReUYraCtvWTM4?=
 =?utf-8?B?ZEtHSEY1ekFkWW1CUHF5OGRZZzBTdFI4NU1aNTNrYjZZTTh3NE1mQ2VpaW1B?=
 =?utf-8?B?cXdjMzRnalRkNWZNemRTVFVWVXVEaUhuTVlIVWsxcWUxNXVpR1VLMUhIdzNS?=
 =?utf-8?B?YlpwQzhVdTRnRjU2Q1lZaGkzS2lZU2w5bjNleWVXQldRRG8zYVlkWER2MmY1?=
 =?utf-8?B?OWIvcFpiL1JoMU1qMWhRNUtrdjRIU3NjZ0grUFJPNVpxMnh4eUVOMXh4M052?=
 =?utf-8?B?Q1lsS2luRTNReFllVVcvZFVFYit6NTgwc2xVUERrN2Q5Ym80YWV0d2ovdWNG?=
 =?utf-8?B?VkpYTms0VzBwWGxXdDE5cmRsaU94WGFmVjZrZ001b2tzdlZtSCtHdXV3L3ZM?=
 =?utf-8?B?dHFzTUZ6N0lVME9iNCtaVnNsNExVOHRvQ3ByZWFmZGVCV2tkOVhuZ2hIN2NB?=
 =?utf-8?B?SmlaeTlqcEE4Ni9GNlZpc215UmVwdTFkaWJ3dUIwS1dFUkU4eWYrdXRYdWs0?=
 =?utf-8?B?dmZveEY2TktxVm5vbTZ0cjd3VzMydEpucCt3TUpoeWpvY2RnS0ZyK0NGL1NY?=
 =?utf-8?B?Z2Z3V3lXaE1HQmtkZnVLRndoNWdUMU9PL0ZWNzVpaTJ6RG9VaGJRZVg2T2dG?=
 =?utf-8?B?d0ZmVWhUbmZySzhWZXFkMGRyNnV6VGNWMUw4VUN1S1BVOTlYWTJIL3Y0NUk5?=
 =?utf-8?B?SjcxMDBQMWRaUGplSnpMNFlFdjQreFlRbTlGWDJxOFBGZEVtcEo2WjhvaVE3?=
 =?utf-8?B?aks1eGlyenU5YzJKVU9IN0wxQmtHdjcrdFhwUXVMbHp4Qm9ieHVKNzlOZHhN?=
 =?utf-8?B?MzRlK2dHcTJBaWFadlpJVzhxRUd6ZWFQZjlONkxsQUNMM29tNlFPKzh3dnl5?=
 =?utf-8?B?cEx0YmIzQzlld1ZZTWMxdzgzVk9KS1R2M1VPNEFJMncwalVoeW1MbkdXY0Ja?=
 =?utf-8?B?YXZXbVVha3JFeVJCWmx2TnBEbW5iTVcvTHlPNGtRZEg0WFVkQUowMTFDZ0xZ?=
 =?utf-8?Q?fC9vG4bBD9Qi64xLtfBXoAn+T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efde23e1-b8d5-4858-5049-08dbf032fd9a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:56:39.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUMna7DgmmHgyyNCVOIynCodLbJ4nHfro+D8WQjE0kSZ2lve10DmYMI+F9P1aNlQ4V/XInrya675P9yzK7Ic9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/23 21:47, Dinghao Liu wrote:
> When dma_map_single() fails, wa->address is supposed to be freed
> by the callers of ccp_init_dm_workarea() through ccp_dm_free().
> However, many of the call spots don't expect to have to call
> ccp_dm_free() on failure of ccp_init_dm_workarea(), which may
> lead to a memleak. Let's free wa->address in ccp_init_dm_workarea()
> when dma_map_single() fails.
> 
> Fixes: 63b945091a07 ("crypto: ccp - CCP device driver and interface support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> 
> Changelog:
> 
> v2: -Improve the commit message.
>      -Set wa->address to NULL after kfree() to prevent double-free.
> ---
>   drivers/crypto/ccp/ccp-ops.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
> index aa4e1a500691..cb8e99936abb 100644
> --- a/drivers/crypto/ccp/ccp-ops.c
> +++ b/drivers/crypto/ccp/ccp-ops.c
> @@ -179,8 +179,11 @@ static int ccp_init_dm_workarea(struct ccp_dm_workarea *wa,
>   
>   		wa->dma.address = dma_map_single(wa->dev, wa->address, len,
>   						 dir);
> -		if (dma_mapping_error(wa->dev, wa->dma.address))
> +		if (dma_mapping_error(wa->dev, wa->dma.address)) {
> +			kfree(wa->address);
> +			wa->address = NULL;
>   			return -ENOMEM;
> +		}
>   
>   		wa->dma.length = len;
>   	}
