Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9647D8161
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJZK4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjJZK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B9184;
        Thu, 26 Oct 2023 03:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698317798; x=1729853798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MjVl8+nTpg9ytOvSF1MlBx9K7rWnUCoYqYzk60K8oig=;
  b=bCv6RgM617o7gYvl+Wo27T1LsP8x09PQmDECM4sGLDXHceKasRlP7SMw
   ez/myXazCEVLPzMLCX7u/p/BE6y1pnKUkCOb5SItFgFGJwFzNgJwI3ZZR
   SynuvnbgyiXQR9dMpqnWuK1s+zO41mYRx81aCSzW15dOPntLOkx58hLv/
   /fKgDo9t93/zfYGBIjB/QGC1T5LCXsOjNf9+bhXrikn+bUkQ7TrrFJ/2v
   ScyIp6vWoefydJDzIHgbQ3TVUKeHRqNFAgDfIhf1OZFU/pii9JKx3OFDO
   W7LQkgP4bwbvRK/xMHXPElI1OLzOYbdZrlFrvSMvFPvilAS2nAtO7ilPX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384719871"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384719871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 03:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090580673"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090580673"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 03:56:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:56:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:56:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 03:56:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 03:56:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjTrzoQW2ybB655UGySSBHqy7WQ0LqzGTJGRGWeuFLBhEefbQoDL8+kU7do5efcosoI5FtKvfIu7j6RWW1PIqrBwmftMYCQiVDq+pIcAQfzb7QWWp6XvyC/jKj/EWQ2Hea+BtmYOjL4MnPvYtm6DczNKfjxxpkWUgOpkh1gcyNAhqbZQa34pZTARAmLPH6pqhti5j7Jzk/tqJ3RVJYIjKs57HlIarGmT3alFGV+yMWHAU9cy8H8hrT5suv+qPzQfbjaAgdRmf33UQO68ZRkhiWY8XVEwl9t2l1PrrpsxhVwuSGCEzVweGI08+dA2TwGENgmJ/zcOQ/vn0/I1r/33Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwDE9yw85PynIbtYTAr+OeGFJhn5iJwq2mk0YZ/dwXA=;
 b=AJw50uW53DPNUgHDDv0VtjIED4tADCYboMzukLnfKi/XifDAsY8ueXAvc2rUNSDTAJf/uos3jZ7z7aTEwyVmngwLovwAspNQxaJNiFQdgeGCwIBa++krZX/vlvXmHueTrofXAIcFUxzgndbaWE+8L99xnUeRWYF+Z257pXOPZ08K87yfq5IfFTH2zDRXWSrz79pEPWwnjqL4H8Kg2e2/ElgLIfcfsIsLSBp7JZStSOSFsK4mT4sM30SCVUCBEMiXom9opX46d/CjIocSyL+lnjZcYnz6oFdyzwsCxvwtVuJldxobkfZXzOMlej2HmyvctYBWxX4u3r/r1gIwgjHwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:56:33 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:56:33 +0000
Message-ID: <0d1cb5d7-53e8-45bd-ad45-48fae64b8d9c@intel.com>
Date:   Thu, 26 Oct 2023 12:56:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH net] octeontx2-pf: Fix holes in error code
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20231026030154.1317011-1-rkannoth@marvell.com>
 <5819e6c8-d887-40ca-9791-07c733126e64@intel.com>
 <MWHPR1801MB1918043F69F45C9D69656449D3DDA@MWHPR1801MB1918.namprd18.prod.outlook.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <MWHPR1801MB1918043F69F45C9D69656449D3DDA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e24f480-026a-424c-a01c-08dbd6123749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu+8fauJwKxE3OfLWnJdGdg6Pnpoy0z423SB905DYLwz0fyfFzqTa0OG5fRtf2MRpJrrq77OWbNxLmAMl/8x4zow7JNVS9sN0XHeWhwqdM1BlVaWMUzAt46GrbD1YTJFPkHPKOZ2s+Fi3evurvSeBnQYYJh3j3BQCD5x1UQIP4Ccg59/T8p3a5DPHepO9jsqOJAH4Nu06sXJYTwh6sz0FsrCP0s34UDZuvVVeq5whkmdNK85k3QIatvTq+WvrgfhaZILUjfzyM1O4kq20THdUDjEKFq7MJJjmQUoAAVDHNZqypMfVNrPA0QZlWFFZ0NYggFnVlTYor/CaRJmzZRhKfcfmufSGizVaiDwdybfxUd49k7u3J0+ej5olxETCyDkURRAlpcsb2LpSqWwvH3a/wkqjeJdyFXj9bBorPobTt0HVsa0slf4lcPOnkA4vepUnK3FyF3/SwcX09w5NlCbRucyNxFhwHF4XF/P1XTO5iIyETrktIzlHVdHFqBHbFWLClosGOGs8sejSD1tKZSvnFXpKPC4oSpwFJ4IrttCS6NLGJnpIBoeISzjHOCvanmQhevnUDMqzzSqqZdBza/I5EDpr4UlxJG+gheRGHZUwcMmLlmysORywnwbWFGQmMhqBhQ3GYowWSqlNlxlPgtGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(2906002)(31696002)(44832011)(38100700002)(41300700001)(54906003)(82960400001)(478600001)(66556008)(66946007)(316002)(66476007)(110136005)(2616005)(6506007)(53546011)(6512007)(83380400001)(6486002)(4326008)(7416002)(36756003)(5660300002)(6666004)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5pRUY0S1JUSWl3ODNISmY2NkpxakhLd1RqSHV2UVBuT0FqakFsWUFTZERZ?=
 =?utf-8?B?cjlIdnIzQVIyVzc4MUVrRGdHVCtjZUhjS1FYUEVKTW5iMmhGaWtUQWkrOVdv?=
 =?utf-8?B?UmJEYWVZakF6dDNoaytKRUlwSEE5Q2doMDRXQ2dGRzdjb1FGdTdwS0ZFczlm?=
 =?utf-8?B?N0ovem9nY0hhb0xXMWNOL1dlQzZKNkh4QkorNFhvdm5GUGhPVjVzSDhKOUFL?=
 =?utf-8?B?cVowdDRIZDZscXJUVWJjMmV3ZDI1ekFJVjk1YUpVc1ROeDREcEMyQVBFSk9W?=
 =?utf-8?B?dW5hQlhERndsMEpVcmN6WWZFeHpFTHpQR1lweDNzdTJSaEpBSHpCQUVzSkxB?=
 =?utf-8?B?NS9hczZscFdpeTFVUmF1SHFlbU5obzlYT2RtMGhpa242UlBjZkwwN3BnUWsz?=
 =?utf-8?B?dytyaUtnZGpFcmRXWTJyMm9sWjJNcVRsSjJ4YmJYcG9tbUdhWU1KNEJMSGpU?=
 =?utf-8?B?MSswMlRPaFZ3U0tPSnBlM0toYlBCeVl3NmhCdENYeVVEZkt0ek4rRnlqQVZk?=
 =?utf-8?B?ZnNJQllVKytxUWVBd2FESUFwQ1F5Rm1mNEpYTGZreHJvUEs5ZVY3RVNxQ0VL?=
 =?utf-8?B?UVIwNm1KaXB5cGNWaEtObkx2djlIbjg4dmtSeGN4djlzaFFiVVhGcTJBNm5u?=
 =?utf-8?B?RUxJS3JQVDZSOWNiTEM1S2txMkR5YUZPYjZyM3dBc0JHcEdKWlJWczlaSEly?=
 =?utf-8?B?ZlZyb2pidjdnYTJxQThNOU04TkJ5SGdpSUNlM1NIUHdtK201dklRZENaUDFL?=
 =?utf-8?B?UC9HUldjYi9OUlVXckl6UTNMWlBJbm4rRFdqU3ZKUERiT0ZxTWd0SEZtNlJq?=
 =?utf-8?B?b2oveUhZbzVVcjlJQ0NzT2oyc2JpTTNUQ3ZHQzZ2SS8vcG1ma251dzd0UEhB?=
 =?utf-8?B?QUNUMWxGWklnVkFmdWVMdUo5eGE2cnZHbE1teWxXNEFiWkcyT1E2Sjh6bVJi?=
 =?utf-8?B?UEl5UTNYTlFVNENQME5qVjR6VWlKcnpVQVlHRDA1Ky9wb3NqV0kxSHB3RzVV?=
 =?utf-8?B?cGNzVFJaZ1lmTUJKeExXK1JMWEdvdGs1WkdUUkZ2dGxTd0NOWlQvbzBVMzYy?=
 =?utf-8?B?Ym1WazZ3TnJXczhSMmxPS0NwNDV6VzAweis0OU9sSXFmMzJBWmJEcmFScFUz?=
 =?utf-8?B?QS8rZnI4WEhiYmtUazhFYzNPYnFoTUFXMmUxK3NwbXVUUzQ0WXlTVlR0emgy?=
 =?utf-8?B?MGE4RjI0eEc4cTc5eEROellncndCT29hc1BoSHY5Ym9oV1FVRHU1SHRWTVIv?=
 =?utf-8?B?SitaZHlBMmpQOTFISnFTOXB2TzdrZkpaWTR3TThVbVRsa21PZFZUWmQ1bGZJ?=
 =?utf-8?B?VmVUWU1aSjVKbjZJMVErT3I1Q0hJZS9mbzdrU0Q0UERocXFaTDB3RTRwUjNa?=
 =?utf-8?B?czNGUnY4L2hYdnIrU1pSaHdHdE02bmh5YSsrUTI0RzBoQmFYNXNsaFU0aEV1?=
 =?utf-8?B?NW5YL3RZWVN5K2FFTFRQUDhYbnJrdmVCbk9QU1k2QTM0UkZVME5kYXBvY2hx?=
 =?utf-8?B?QnNFQXl1ODRoTDNUTnRXamlrTDNDVExlM2JpS0F5aEIwSFRsSTB3YTZ4Qi9w?=
 =?utf-8?B?UWJGcnpUcWdsb0NCdzhmMWxwNGtaUUJkUDRzbTd0QTYxN3FDWFlXc1pUN2R6?=
 =?utf-8?B?R0xWSERKRkRYOHhveE5CWDlOc2ZJc3B6RVd3cEdaS253aE93UnIrSnp5NEFn?=
 =?utf-8?B?aDcrM0VUS3RDcTlPck95cUQ2WElLdUZZSTdQN3U5ay9xS01LcEkxZldxdHM5?=
 =?utf-8?B?L3ZzNzVweU5GRmJocnUzbWp0K3ZHYmEyeUpjcG1YQlJvWG05dzgwYzJySnow?=
 =?utf-8?B?ZDlVTWlaQjBLTmRBRjg1dWtUbnUydldmdXIvNnFvSzBHZHdsNExTVllFYTNv?=
 =?utf-8?B?azRZbko5ckZBSHFDNytPSHIraVoyQzRKSFZza3BsVlU3c3FzUG8yZ2UxQnZK?=
 =?utf-8?B?M3lmQjlhNE1kbWZWSkltUnUwMFREc1pMQkxzanJPV1pUd1k3MVU0bEhGNEhO?=
 =?utf-8?B?TDVRcUYrV0tXRk5vZW94ckVvU2xkcytWMGJlOWRHVjZDRkRidGFsNllSNXp1?=
 =?utf-8?B?dk0xSVd2cDArSmNuZTFtMUhZMHJsR0JXeTZyR21wVUE4YlQvRndYa2RrS1M1?=
 =?utf-8?B?eW9GVzdvTGExRVU5SnlPMnkrWnE3amErVUlpeWNCWEp5TkwwMmZqK1FhdTFS?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e24f480-026a-424c-a01c-08dbd6123749
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:56:32.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RaNfOrrGWJKEYV/HjVnd3dKRrLPqJsX0kNmVBW+p0v2d5EPNi38+tkFmqDcbeBBK7XLfyBi8hLKs7kncGwTg60DIzZRzsvJf9lMwC8fuiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_75_100,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.2023 12:37, Ratheesh Kannoth wrote:
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>> Sent: Thursday, October 26, 2023 3:44 PM
>> Subject: [EXT] Re: [PATCH net] octeontx2-pf: Fix holes in error code
>>
>>>  static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
>>> -	"NIX_SND_STATUS_GOOD",
>>> -	"NIX_SND_STATUS_SQ_CTX_FAULT",
>>> -	"NIX_SND_STATUS_SQ_CTX_POISON",
>>> -	"NIX_SND_STATUS_SQB_FAULT",
>>> -	"NIX_SND_STATUS_SQB_POISON",
>>> -	"NIX_SND_STATUS_HDR_ERR",
>>> -	"NIX_SND_STATUS_EXT_ERR",
>>> -	"NIX_SND_STATUS_JUMP_FAULT",
>>> -	"NIX_SND_STATUS_JUMP_POISON",
>>> -	"NIX_SND_STATUS_CRC_ERR",
>>> -	"NIX_SND_STATUS_IMM_ERR",
>>> -	"NIX_SND_STATUS_SG_ERR",
>>> -	"NIX_SND_STATUS_MEM_ERR",
>>> -	"NIX_SND_STATUS_INVALID_SUBDC",
>>> -	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
>>> -	"NIX_SND_STATUS_DATA_FAULT",
>>> -	"NIX_SND_STATUS_DATA_POISON",
>>> -	"NIX_SND_STATUS_NPC_DROP_ACTION",
>>> -	"NIX_SND_STATUS_LOCK_VIOL",
>>> -	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
>>> -	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
>>> -	"NIX_SND_STATUS_NPC_MCAST_ABORT",
>>> -	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
>>> -	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
>>> -	"NIX_SND_STATUS_SEND_STATS_ERR",
>>> +	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
>>> +	[NIX_SND_STATUS_SQ_CTX_FAULT] =
>> "NIX_SND_STATUS_SQ_CTX_FAULT",
>>> +	[NIX_SND_STATUS_SQ_CTX_POISON] =
>> "NIX_SND_STATUS_SQ_CTX_POISON",
>>> +	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
>>> +	[NIX_SND_STATUS_SQB_POISON] =
>> "NIX_SND_STATUS_SQB_POISON",
>>> +	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
>>> +	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
>>> +	[NIX_SND_STATUS_JUMP_FAULT] =
>> "NIX_SND_STATUS_JUMP_FAULT",
>>> +	[NIX_SND_STATUS_JUMP_POISON] =
>> "NIX_SND_STATUS_JUMP_POISON",
>>> +	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
>>> +	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
>>> +	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
>>> +	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
>>> +	[NIX_SND_STATUS_INVALID_SUBDC] =
>> "NIX_SND_STATUS_INVALID_SUBDC",
>>> +	[NIX_SND_STATUS_SUBDC_ORDER_ERR] =
>> "NIX_SND_STATUS_SUBDC_ORDER_ERR",
>>> +	[NIX_SND_STATUS_DATA_FAULT] =
>> "NIX_SND_STATUS_DATA_FAULT",
>>> +	[NIX_SND_STATUS_DATA_POISON] =
>> "NIX_SND_STATUS_DATA_POISON",
>>> +	[NIX_SND_STATUS_NPC_DROP_ACTION] =
>> "NIX_SND_STATUS_NPC_DROP_ACTION",
>>> +	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
>>> +	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] =
>> "NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
>>> +	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] =
>> "NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
>>> +	[NIX_SND_STATUS_NPC_MCAST_ABORT] =
>> "NIX_SND_STATUS_NPC_MCAST_ABORT",
>>> +	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] =
>> "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
>>> +	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] =
>> "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
>>> +	[NIX_SND_STATUS_SEND_MEM_FAULT] =
>> "NIX_SND_STATUS_SEND_MEM_FAULT",
>>> +	[NIX_SND_STATUS_SEND_STATS_ERR] =
>> "NIX_SND_STATUS_SEND_STATS_ERR",
>>>  };
>>>
>>> @@ -318,23 +318,23 @@ enum nix_snd_status_e {
>>>  	NIX_SND_STATUS_EXT_ERR = 0x6,
>>>  	NIX_SND_STATUS_JUMP_FAULT = 0x7,
>>>  	NIX_SND_STATUS_JUMP_POISON = 0x8,
>>> -	NIX_SND_STATUS_CRC_ERR = 0x9,
>>> -	NIX_SND_STATUS_IMM_ERR = 0x10,
>>> -	NIX_SND_STATUS_SG_ERR = 0x11,
>>> -	NIX_SND_STATUS_MEM_ERR = 0x12,
>>> -	NIX_SND_STATUS_INVALID_SUBDC = 0x13,
>>> -	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x14,
>>> -	NIX_SND_STATUS_DATA_FAULT = 0x15,
>>> -	NIX_SND_STATUS_DATA_POISON = 0x16,
>>> -	NIX_SND_STATUS_NPC_DROP_ACTION = 0x17,
>>> -	NIX_SND_STATUS_LOCK_VIOL = 0x18,
>>> -	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x19,
>>> -	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x20,
>>> -	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x21,
>>> -	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x22,
>>> -	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x23,
>>> -	NIX_SND_STATUS_SEND_MEM_FAULT = 0x24,
>>> -	NIX_SND_STATUS_SEND_STATS_ERR = 0x25,
>>> +	NIX_SND_STATUS_CRC_ERR = 0x10,> +
>> 	NIX_SND_STATUS_IMM_ERR = 0x11,
>>> +	NIX_SND_STATUS_SG_ERR = 0x12,
>>> +	NIX_SND_STATUS_MEM_ERR = 0x13,
>>> +	NIX_SND_STATUS_INVALID_SUBDC = 0x14,
>>> +	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x15,
>>> +	NIX_SND_STATUS_DATA_FAULT = 0x16,
>>> +	NIX_SND_STATUS_DATA_POISON = 0x17,
>>
>> There is a gap here, is it intended?
> [Ratheesh Kannoth] Yes.
> 
>> And in general, why error codes were changed?
> [Ratheesh Kannoth] it was a bug. 
>  
>> Starting from NIX_SND_STATUS_CRC_ERR which was 0x09 and now it's 0x10.
> [Ratheesh Kannoth] Yes. It should be 0x10 .  The real issue is - >enum was not in sequence.  (Eg ,,after 0x9 it should be 0xa).  But 
> "static char *nix_snd_status_e_str" was assigned sequential strings.  

Ok, got it now.
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
I'd add to the commit msg that some error values were wrong and it it was fixed, but it's a nit.

> 
>>
>>> +	NIX_SND_STATUS_NPC_DROP_ACTION = 0x20,
>>> +	NIX_SND_STATUS_LOCK_VIOL = 0x21,
>>> +	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x22,
>>> +	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x23,
>>> +	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x24,
>>> +	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x25,
>>> +	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x26,
>>> +	NIX_SND_STATUS_SEND_MEM_FAULT = 0x27,
>>> +	NIX_SND_STATUS_SEND_STATS_ERR = 0x28,
>>>  	NIX_SND_STATUS_MAX,
>>>  };
>>>
