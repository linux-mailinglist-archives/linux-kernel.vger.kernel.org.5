Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303367D6978
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJYKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjJYKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:48:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A1F131;
        Wed, 25 Oct 2023 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698230932; x=1729766932;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KVbHUtuwoLgRV/FtC7nEWWJ1DnhqLfHtAlGqkZwcjWE=;
  b=OfDFG5ewqBzHqS2gH1RWr/ABzAxF026GQnqkSvSoudK3YCLsLIO5ZVij
   0emxIiL0sSxry0HKVRclYD9Cs+8jF2CiymvYJT18ktDNj4GEqInNdp3+U
   CPVg9fCEqp1mVKuGBGsnPKPjaNpS2goISzCsp2IRVNe4Ba9VKxSJMAInz
   9DUOTOfwR6KUmC/79q82pIU7+0JaNaLv67BSNnCGX9AAVPJWpVNam+/ci
   spRbD4h+0Bv0jvJAJTyp0+l289edeYDN59i5y0lfYxdgZcM1wfHVojOFk
   YWaSwXHzUSe4afWX+zcJKCnqS3eAsT0N6LWoOJjlERui2iVEsk1E4mdqQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="372337929"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="372337929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 03:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="829172474"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="829172474"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 03:48:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 03:48:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 03:48:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 03:48:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 03:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMKnsxf4DsoypJS97trRDRWnlhjl103eNhpKrlUaBhYgTVengQP30FaQrZVpiu7ZS3Zbgwd9dlS+4Imgj6ZkeOC8aEXzRXKygYK3V1FetrJTGNTbeWXTWj+jgMkioi0iuu+JawC3oEAW0xmBuKfPAnW+e2OBOrZ1SAG0zTnwmI79nhgYoqElbL/B37Y2AMY+u2Q1QHPLHIQ/1h5/1IHL2+o2flIF1/ojvp89cTId8fBhJIN4u808QZKqlsmdIBIFE6XRoCayf8s+gfsyTJSCp8dTwWgJERJK+87nLKYH42U8IQQjVNIqr/GWinpzFtELJdHqtBDwOVfFU9iTpS4iwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tBpu05RD2p0cqO27VYyZ/RQdiVpgdrQHjoQfIHgxAI=;
 b=Ee9HkSnMNHnz5x5ovgQ0Xh4gbKeh0KnNfAox4pKis3P8Um8e2S4VTuPZp0xEu3gRQYJoB5klPMsbwmLGOqOAKzJuth6T2wfPLpc9J9e/+NDssup5LBfnZbFznAjiYA/TCsH3wKh/BnvnXZrUFho39LiEEFsQqqLMUMGRjcCAwxYB25NTGFCVXsVMq/zum3AdFnGRIr3n0zKLwkB35YUVFr+BaNNlrSszULiaJ3KJxn6bskguv/d4noE4y/WywuW/b6qolw4NVPHMFc3Z9pbr/Fho1gRa24TXnhDjJU9u9z48MA5lt5PcPvfAnmdB3UKGy0VBrVDHmFIrKmJocHQvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CH0PR11MB5489.namprd11.prod.outlook.com (2603:10b6:610:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 10:48:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 10:48:42 +0000
Message-ID: <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
Date:   Wed, 25 Oct 2023 12:48:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231025103315.1149589-2-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CH0PR11MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d87a285-b088-48f1-fd2f-08dbd547f48d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a2qa9bzWPBOcX+G0UuaWeR8Xcjbp5nAibRFqFCmXXClQ5YaAkMYXE5rqFcPfp2JJfmuGcpPXvHFFlPb6KF5dJ1BtDiFjtxP+sIj6RNp+ZLUZrsEPXS/P3eWeZu007W/iqYxtIfbRnJyVJ4IYGcOs6GQCcpkurnXpwBadUJPrhljEuxy1KsIrEjVkEX2XW/pIlIQSH3NzlZXEvBjN83apGkjvObcj6E+IjVtz/Q9HF81CI23Yp0X4bJi/JMwzMHsV0cn+XVNX8wszB1LLy8YgTUb1HM/8z8nQLmp00M0H1PnQ4DbOP+16DcDq9E4urW4x7R0bvtMWvsJ6pOyajiSnwZMo/M06XSHhUZv4syx5JFqEp7DWitduOuultU8ivdSmYtq4pxR30oHXiyY6XjAotCCBz6VuTvmJh/atqUcDHl8VYI0+ssoP8aO//KWFManc9E2fOBn/fu/eRaajiGChpfE6vTVasSmXEdqm37zelyF6KQ3obgbExnfK7m2cdzQAUD1tz3vo9co8ox+SDJz4zu0KxQZ2pSGyNtGgTMbBtwh5pBsjyhB2AhSKw5dX2kCKKrngBsJVCWIKw+bqdBR7EykLhtggYlBJQfEeS5u5ZRAZWPyFGKKY4iVM3PQynGArr4ixgalxRJ/GroOloI7ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66476007)(2906002)(44832011)(86362001)(38100700002)(41300700001)(82960400001)(66556008)(54906003)(316002)(6506007)(6666004)(107886003)(478600001)(66946007)(53546011)(6512007)(6486002)(83380400001)(31696002)(5660300002)(36756003)(2616005)(4326008)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJZSS9FTTVXb2MxclY1SlVuajdoUGFORnNFWDgrU0VwdjBZcjZ3UlFSbW81?=
 =?utf-8?B?U2pyMHhBRzdMWjN2VkhVQWxiQm40Z3phT2tUNHhWSWtQQnhKOHZkR3VYK3lI?=
 =?utf-8?B?UitzdDJPa0lIWnZidDV5YzF0MWwvMW5oc3NqK1RqNkRIb0UrbnBYbWNMWWVH?=
 =?utf-8?B?SjhrVXdkaVFmOFZoM0JsOGZjZC9zdDdqdDc3cFQzOGdWRU9wVFlEVWFlcFN6?=
 =?utf-8?B?ejh4eElHN1VQVW1DQmtic1pXYWM0ejJUMFZaZlEzWWI4REoxSFcyTzN0ZkU4?=
 =?utf-8?B?R1pFWVVQWjFtTHBmMS9sdzR0Qm1nc21MRnFlRVZUY09OMlJGL3ZFbXNhbkhm?=
 =?utf-8?B?aVlyVHZZTENjc3FwY2NYeGFnOXpnKzB6Mi9VcTdtaUcwVC9oblJpczZtdzJu?=
 =?utf-8?B?Z1RGNzR0T05tZDJONkFqZUU3T3c4NmFxLytJMEp1U0p1R1FmdTVaSzQ4YUw1?=
 =?utf-8?B?VmhwazFxK0RvQnBuWFZEelZOZHJwU1E4SnlYSUl2d1ZRRHJKVVFCdlZjbEhY?=
 =?utf-8?B?bkFnRExLY3ZuOHZUVG1mLzlZcGh4ZERvR3M3eW93bEROeVBWVVg4NC9UWlNU?=
 =?utf-8?B?WnB6K3RkWFVSOGMyd1FYNVdxbS9DNys2U1BlMjFmZmZaRUc0UEtBYTBKZkVP?=
 =?utf-8?B?VWlMMHphOUwvRlo2MDF2aGRPZmNiTTBUMlB1S01maXByL1dVRUhKTTRLKzY3?=
 =?utf-8?B?WnFNRGtxYjJLQWw2T0ZWVUJ4d0RVcVJtR3VKWWRHQkcvd0dFKzl0dHFvR3dV?=
 =?utf-8?B?TlZFWi9ibEF6UkF3aGpHYU1oS0dteEt6Y1VWREIvS09QK09VemMvMVpXSmhI?=
 =?utf-8?B?VWZoVER1bTduVERLN2t1STRuMm1IM2Z4SDZvMmtQQTBJVEthUXdDWDZzdkh6?=
 =?utf-8?B?YkZIVVRmb0taSzJkUVlWTnVzWVg3NnBwbDFyb2FJMHVCQWdiM1IyWWtXTTgx?=
 =?utf-8?B?cERpTXoxNkhkUDRpeTdEV2I5Y0tNbTlCZXhWWGpIK3I4OWxrY201VzR0MHpX?=
 =?utf-8?B?d0ppVy9pcDJ1WkZYWEQ3bU5OajBzYW82amRudnNvQ2M4SVUxSXEwSkI4NjBS?=
 =?utf-8?B?ckJBQUdsYjRHV3FWT21RTzFIUXRXZENqcHhKbkdzSjJtSmU5dkJaNUtJUlJU?=
 =?utf-8?B?NlJXSWNYVkl2QjZSY0VEV2NKQnd6cGNTeDhDOVlRalgwNHlMQ0JyMExLZlZh?=
 =?utf-8?B?TG5nYnZhQ0VjcEhMNTI1MUxlOFBsMjdSVVlScm9LdVgxZ2gyNVNSZUlVSDlq?=
 =?utf-8?B?ZHpqbTRLeHcxM0lNc3VmTi9kbC9wVHZYV3JQV0srSlRyUGVDQS9ldFhxN0Qw?=
 =?utf-8?B?SzdUODJMak1CcFl6aU8yMDhyMzdndHo2Zjk4Zkl1d25HaEpaK0Z0cVQzZTlZ?=
 =?utf-8?B?bFVaYjJ0aHJDWTg2Z3FaZEpWWllTMXpqY3VBRjBUYU13aytGcTdBZ2lucG1r?=
 =?utf-8?B?RWw3dHIwVCswMVZzeXNKTmx2eHg5OGhpcnBuTmI3TjhTWEVlVGFoa1BVbzVy?=
 =?utf-8?B?d0NvbEk3clluVit1VkU2VFBTYXU4M3JaeVFqQVZXbGhSOWYrTjBzY0ZzNE1v?=
 =?utf-8?B?R2ZicXpXQTZqTGFiVDk4Ky9KMWVoUXdKZnh5V2dwUjIyUlJtY3daOEk3cUNJ?=
 =?utf-8?B?N1YwNGZSaU1uWEYxWHNwNXZyZ2VoSTFLeVNwdTc1MnBEQlhodUQweWY1LzJm?=
 =?utf-8?B?ckZBTVNodm1Nc3hWK2UzbFJ1SmdUa0VaY3YzQzR2VG9Pekg1Y3RubVRYOEtP?=
 =?utf-8?B?QnBERlhBT05vL3Zwa3N1RDFvSWR6eXB3MVRLWnhLWUFKZi9XMWxtNjR4Mmdv?=
 =?utf-8?B?VHB6OUllWk9qZ1pVNzU0ajQrbDZ3NmNENmxRNnAzd2ZnbVpTQm8yOUovcS9K?=
 =?utf-8?B?Y0F4SWoybnpjeWtUY0ZGK2tSWVdoTEFYUDBMSlJnNC9CT3JzclZoMlhHZG56?=
 =?utf-8?B?WkNleTMrV2VTck1oNXZoZGdiWDgzQ1hJWHhCbUZZOGJkT3UxVTZRVFkyUG5r?=
 =?utf-8?B?SmRMWlJyTzhLakVjQTdYS2VGcDJMWFF5a0RndlJKM2lHWHpTTGhTNXJZb3hL?=
 =?utf-8?B?TXRJa1hpdnJoWE9oVGRQTkx2RHlpRjM0U05nd29SL01TaVV6N2dSRUZ3WEdJ?=
 =?utf-8?B?U3ZSU3pRTjJ6TFBEUFRUYjAxaVQvZFJKQkhmRnZmTGZMbzE4WUFudDYrWDFW?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d87a285-b088-48f1-fd2f-08dbd547f48d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:48:42.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ugP7pqoj9o2EZLF2Arxnv824oFOZUfFgFP3IjA2unWFprROTu/S44MgoB6tEv9zDrVqq/dH5mWRVHgSuq5nNSUfvVGAlL2GIrUQbkPwPGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5489
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.10.2023 12:33, Ivan Vecera wrote:
> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
> i40e_adminq_init_regs() and remove enums for these VF MAC types.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>  2 files changed, 10 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> index 29fc46abf690..896c43905309 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>  {
>  	/* set head and tail registers in our local struct */
> -	if (i40e_is_vf(hw)) {
> -		hw->aq.asq.tail = I40E_VF_ATQT1;
> -		hw->aq.asq.head = I40E_VF_ATQH1;
> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
> -		hw->aq.arq.tail = I40E_VF_ARQT1;
> -		hw->aq.arq.head = I40E_VF_ARQH1;
> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;

What about removing those I40E_VF_* defines?
This is their only usage here, right?

> -	} else {
> -		hw->aq.asq.tail = I40E_PF_ATQT;
> -		hw->aq.asq.head = I40E_PF_ATQH;
> -		hw->aq.asq.len  = I40E_PF_ATQLEN;
> -		hw->aq.asq.bal  = I40E_PF_ATQBAL;
> -		hw->aq.asq.bah  = I40E_PF_ATQBAH;
> -		hw->aq.arq.tail = I40E_PF_ARQT;
> -		hw->aq.arq.head = I40E_PF_ARQH;
> -		hw->aq.arq.len  = I40E_PF_ARQLEN;
> -		hw->aq.arq.bal  = I40E_PF_ARQBAL;
> -		hw->aq.arq.bah  = I40E_PF_ARQBAH;
> -	}
> +	hw->aq.asq.tail = I40E_PF_ATQT;
> +	hw->aq.asq.head = I40E_PF_ATQH;
> +	hw->aq.asq.len  = I40E_PF_ATQLEN;
> +	hw->aq.asq.bal  = I40E_PF_ATQBAL;
> +	hw->aq.asq.bah  = I40E_PF_ATQBAH;
> +	hw->aq.arq.tail = I40E_PF_ARQT;
> +	hw->aq.arq.head = I40E_PF_ARQH;
> +	hw->aq.arq.len  = I40E_PF_ARQLEN;
> +	hw->aq.arq.bal  = I40E_PF_ARQBAL;
> +	hw->aq.arq.bah  = I40E_PF_ARQBAH;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 9fda0cb6bdbe..7eaf8b013125 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
>  enum i40e_mac_type {
>  	I40E_MAC_UNKNOWN = 0,
>  	I40E_MAC_XL710,
> -	I40E_MAC_VF,
>  	I40E_MAC_X722,
> -	I40E_MAC_X722_VF,
>  	I40E_MAC_GENERIC,
>  };
>  
> @@ -588,12 +586,6 @@ struct i40e_hw {
>  	char err_str[16];
>  };
>  
> -static inline bool i40e_is_vf(struct i40e_hw *hw)
> -{
> -	return (hw->mac.type == I40E_MAC_VF ||
> -		hw->mac.type == I40E_MAC_X722_VF);
> -}
> -
>  /**
>   * i40e_is_aq_api_ver_ge
>   * @hw: pointer to i40e_hw structure
