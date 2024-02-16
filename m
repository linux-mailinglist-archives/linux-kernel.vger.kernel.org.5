Return-Path: <linux-kernel+bounces-69444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2C85891A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F41AB21644
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07128149012;
	Fri, 16 Feb 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YduaPAUP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDA148FE1;
	Fri, 16 Feb 2024 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123279; cv=fail; b=OvtE4xZlxNXiaiNWCjJ4JKIYN7I0GMLtV3ZXpRD7LGEvGacyYXuS1LMAj7ydOaAqzk32DyqyOo4x16XL0tBssiMNpAQ3Ww33e7ByWJqWFLW0obeUlTVTUHrdQeMZEeQ8yW6EfjO3naMWFr/1BnPfvsbHDkJuUM6o+e2FDemHE0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123279; c=relaxed/simple;
	bh=3AFsvwLjk8+pazQ5ptvj9cF/48DDcSoZbZFjngKRbNM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSDeIZJVnLFTIdEd4jITV8CDyFLfQQpYzZkFBgeaTYtUruiRGb9BAZRA+S6W4Mm9vIZvDHynGwtwsYv0WZcACxj8+lq6kGrzQhMXMRQ4rJxH+n+10EP4dnjhZOpGYmWJMnEb5TLjf/C/WVi+lnVO5rkjyW0KFKkst0dQuMLerAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YduaPAUP; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123279; x=1739659279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3AFsvwLjk8+pazQ5ptvj9cF/48DDcSoZbZFjngKRbNM=;
  b=YduaPAUP1p7Zk1l73s/werN8Cl/eZuXi4XEDMM8VRG9lq/gUZxrc5vfw
   zngiE09mWyPE2PkSJN/HOHXMJTclYpfP0LpmaehK6gd+SvcCKF/1kwMF4
   VlJ3GBveheJLUOej2YMWBUAGY4zW+Tog/vVyyZCXDBZpd8W5TLqbhqby/
   vkvqbYIsmSf9iiHhvLDGqX59x3WIV/x809PHur9sjCewVIIkHYnGhvakS
   G7SfAMA3EUgcpRWDT5vWE+PANl6vQoz1davX/BFW28Hqbx46Orhp08lEq
   XgsEKoiZRY3iqJ1tR7xPvhyenWOsNzt+lEFBRwmiOgngqTZc36eIa4Ckr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2173521"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2173521"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4343980"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:41:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:41:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:41:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:41:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL5rsFzqlbbH3GTDsvAUO6PHJC9IL2vz8iBUoVQFvNftfsKZWT2LHcj4AespHyblhUmdhr3Drq7GLaPNbgsgeDauBrtOWZ9GwcR6xOzhBE93HpfVhJ8ac2uPHAZtN+O/6NTZzrz9ByRiUWVdO4HRWpdCsFd4XCQ5DoR8Bkvlu9jOvU9qs9ds4oSiKWNfPSokC+LgMoPG77sOols05u6P+QXZ83U2CDEaGw7wQtdVb77WG7hiJVsWqPVKD6+7wAaUZ5faERV8iGNhD18xqiHiByLeKupBRv/wkDf1rady+ERxagVtE2gwnXd/6l6P6IlUiclG/L5vHN/Yu1gLNv/rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kYKQRd0BuBrMUnEFdVfEaMwAhvXuG9nRtzl8GAA4sQ=;
 b=SmAhkAcW05+032JTjiAI7lXohsbhsREtM846S5uAS7GdwEvpQVSyOnb2WYaAFhDZwlJXTf7zPbGN6lQhVIa/yqk8rhMHFR5v2WlqZrXweAOjVBvIACrW2/hdGCX/+9NRRMVkMijk9lYjLHO5Z9waVQXBbE99Qow99dAJY1SEMKM+rnYpWTzcf8mbskkeBGeDRxZkNGE+pEGFJTXMngadz36dbJUY2pfbLyZ1xmv6CAZaIAKuWpk6x4VCUedSfdRxs4gOaNk+75SznN1kxopX7AQHAcplgR4AhtNrPRIp762tV+lNasamO3LjM9QMm0vL+/fz+YuTFLg3jKNPMkxZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:41:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:41:12 +0000
Message-ID: <e77b032a-42cf-43df-809a-24b36dbcb95d@intel.com>
Date: Fri, 16 Feb 2024 14:41:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bcmgenet: Pass "main" clock down to the
 MDIO driver
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>, <netdev@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, "Justin
 Chen" <justin.chen@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
 <20240216184237.259954-3-florian.fainelli@broadcom.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216184237.259954-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f02319-db4d-4f16-31e1-08dc2f4060c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZpF8vwDKqJA3Phz84Uk/2Kl9fX6X4mGOEBaKJLWtqeU97QReCDFMSaKlnbsKmPlBsTvuGuYpfJUVQElUxZoRaMwuG38pSmBw2QglKpagSFBSm1eoS8uA7fKPNBFncwo5AmBY0jxkdYi4xnS3BHbI+DaraGKNay0yCJfMRBlXpQswae3647TmMpBuGJ1yZKCrLFD03x8uUZ2/1X6RfW1g1Ck5ocBkZd3xPSjy1D39V/RENd9+jo+ejFdTs06qvrwdRt5fJhRUg+eQqwDf3ZsBUOyExk+EshglKEMc7TfY/dm+c2k5ynYhD9oLQ5rBW+6GlMcZ2Dvjp/yqyTvjTqhWJsCwKR3WRe4cdhbDWu2X5C+0AvldhGdBDiD20TZe8Mq4JOl9QLp03rPeRSJYGAFM4YuApMOI3CZe74nO3WymxOhtmYtui980/GV66Ue8D9TfdCj9bc/kjy3VNB6zHmN6dFS5vOju6fe/PPkpOlYHLqaVfPHVIqQ29rbjtdD3TGFCZ9fy7t5AUpL3PQWkJSIiHSwv6a1qf6/XnpHs7/lZEIvQMt6oIv3k/Ch3hoF9vtz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(54906003)(478600001)(6486002)(36756003)(38100700002)(86362001)(31696002)(83380400001)(82960400001)(6506007)(2616005)(26005)(316002)(53546011)(6512007)(7416002)(66946007)(5660300002)(66476007)(41300700001)(66556008)(31686004)(4326008)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdpeVUyUXFIby85MmhpZllURVAva0U0MEwyOG51d3hKai9KTTNLTXZnQ1NV?=
 =?utf-8?B?WFpOclA2dVk2aUNxdG5PcVcxNkZSNnhsbjllWmlNS1VRbTQ2QmJ1NlVjSCtR?=
 =?utf-8?B?djM4bG11WEFZSTlsWUpjRU9EY0NHOFBwU1laK1hNczF4S3BSUFNTV01MQmhv?=
 =?utf-8?B?d1hFK2NDQ21oNlNWc0FNM285RGxLMHVmL3lCcWJnOW92UmpEVUlMT3hybUti?=
 =?utf-8?B?ZHBHRmRsVEgzZloyYWhIdTZ0aXBvZVAweThDTy8zMEM1MFZZRGx3cXhFL1F3?=
 =?utf-8?B?eE1sSzFMSmZkMEI4ODVIV0pYQ0tHdkhGYngzeEtxMzBSTDJBRy96V1FrSmds?=
 =?utf-8?B?a2FCYmxxUWV4UGE3NzN6bEl5MVpLcWtTKzk5S0dKdWVQN1N1MnFTU0JOMVJi?=
 =?utf-8?B?S3RPZWxOR0NseEpaUUE5WnFQZEJYOXVCaW1wWkFKelp0Nm02VVJOeERKR0s5?=
 =?utf-8?B?d0JuOFZpYzl1ajcrbW9ubzlLUjJxYnlXdzB3dmhMSzNVd05nYWVpV0xsVEw5?=
 =?utf-8?B?OVJiQUJFWit0MVcvRjNldW94OXpBRk1Bak9iRkpCVEdrZERRc1FBTnphQVkr?=
 =?utf-8?B?U21TSnc5d2lraVc0NnV1aDVsbjBwNmpKRHZKUUJkYkk4dWtoaFhjN28xNFJR?=
 =?utf-8?B?cFhmamovOVNOQnJXUi9selhxc2pjRHJhV09peXp6Y2hkQ2hWbFlKa0NZR3p5?=
 =?utf-8?B?dWVsQ05CQndEYldBclBubFdXVWhHM0hZWGRPRVY0MWV3Sm1pSW9SSTJoUWZZ?=
 =?utf-8?B?aWVoR292cUhnN2FJVlFwNHJEUGRZc1QvODZEa0tBVE5RMyt4NmNoR2dYZ0pR?=
 =?utf-8?B?WXM4U0tNWG8xVVR4dnhsZWNiOU9HRXlQb2FISE4xRzdBeEdnVWZva0M0b3Vv?=
 =?utf-8?B?MFF1RExZMWYrdVY1MUF3WXFvUTZsUzVTU001MXlNMDAwZnFHS0ZvZ1RUdjUv?=
 =?utf-8?B?NDJpZUxBMHlUTnh5TGdoTWpidXBwcnc1MS9VQW8xbkNMRCs3RDlGZEVOVWxr?=
 =?utf-8?B?VnZhTmptWkxRYlRCai9GQ0FuN3hvaFFoUk5VNFd4ajJ0RnhtdUNtczBKVFJB?=
 =?utf-8?B?SzY3VzBPVkFlRGZYZE1xVWc1MEtvNDQ3NC9YNnRKV3JnMUF4aWhTN2dBU3l2?=
 =?utf-8?B?MFcrVWg0ajJvMTZ0Rk9SYlJwNHVRbXlBdGxOTXhRbXpvdExLSWpRS0s0YnND?=
 =?utf-8?B?MmoxRjFyYjVraWI0YytxOUs2eFdZVDFFVkRUdzNaejRRMWlBTnA5aVBUMkM3?=
 =?utf-8?B?aGFsN21yVno5d2lyeENOQ1RWQUZVLy8yRGlKTVd0WFMrd0ZyOFpTYTFMcmlO?=
 =?utf-8?B?azI3ZEhjMi9hUEJQTFhaU0NMRDBDNmthV3Y1VHhvaGJhNmVUNllvbkY5TW84?=
 =?utf-8?B?S3FxRmZxbXQyaTV1UTU1SlVLM1hBRm1PYjd5TGlYUXZXVUFSc2htSGNxRENR?=
 =?utf-8?B?T2I4NkM4UlU2WHlyd0pUWDB4d3habzh6ZWtZTGdRVDA3VCtIYzBtQUIyaHhC?=
 =?utf-8?B?SmdlL09pSkRsS3VqU1VFWG9uVmRvMS9oV3U4WVJCYXc5SVlMNW14cTdlcmhP?=
 =?utf-8?B?dytxT0Zma2N2a0c0R0d1QWJpWjVBQWJZQkxFTmxFcDRKSmpXWTExQ1JwSFBL?=
 =?utf-8?B?L0F3NXF3dGhQbkU4OGhZTEZFbXowZGlXVFQyU1hUTEpSb2g3U1U0WDVGUGV3?=
 =?utf-8?B?SzdFSUpVc3dpSGY3OUpwU2lDbVVnT0RIdDRRTUZiaDdLWXYyK0FpazBBSnZR?=
 =?utf-8?B?ck1SYS9nSmVRQkcrQitlQ1Y0MHhiUjB3VmxpUVRkWGdxdm8yTlc0WE1xN2Ur?=
 =?utf-8?B?ZmFoTURDQkExMmhBenAzSzhoM2Fvcy9qeUNLU0dHZHNHejU1Y3FWN3VjUnhx?=
 =?utf-8?B?YzBNeE83WDhJcDBZdlA0MUltSFZ6M1BENUhaZThDWkxHTU9OK0VJM1p1QmZw?=
 =?utf-8?B?bDRHb1FqbXhqeXlKeUE0WW5nWDE5em1vOTFqUmlBWmRQdEFVanZaUTFZeXNq?=
 =?utf-8?B?MERQTTh4OUVRZk9FRjdObHpURHlOZTNzZDYzTkRnNHVCVUFMN21LVm43dXdM?=
 =?utf-8?B?QVc3NUpGRmxnSEg0MFlUUEI5d1I3SlZ0ck9md1VXUWtWK2xlRmROV0dITmU0?=
 =?utf-8?B?bUVFVUhxenRpN0QxOXpDR0NkNWVVSHZSUGtWSkx6QXBRVm1pR2ZTOVdOVThO?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f02319-db4d-4f16-31e1-08dc2f4060c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:41:12.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbuDhNZDItFn2/Q5hcHiUqACFSeLU4xW/1pI1zAWdUR08GCZXQJRwt/Eys6vDmSPEon/vn2Jhgb9NQlDqLuHnFvLdsZTjDRLHt0rNQHh6Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com



On 2/16/2024 10:42 AM, Florian Fainelli wrote:
> GENET has historically had to create a MDIO platform device for its
> controller and pass some auxiliary data to it, like a MDIO completion
> callback. Now we also pass the "main" clock to allow for the MDIO bus
> controller to manage that clock adequately around I/O accesses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index cbbe004621bc..7a21950da77c 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -476,6 +476,10 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
>  	ppd.wait_func = bcmgenet_mii_wait;
>  	ppd.wait_func_data = priv;
>  	ppd.bus_name = "bcmgenet MII bus";
> +	/* Pass a reference to our "main" clock which is used for MDIO
> +	 * transfers
> +	 */
> +	ppd.clk = priv->clk;
>  
>  	/* Unimac MDIO bus controller starts at UniMAC offset + MDIO_CMD
>  	 * and is 2 * 32-bits word long, 8 bytes total.

Is this missing a modification of the header file to add the clk field
to struct unimac_mdio_pdata? I don't see that field in the
include/linux/platform_data/mdio-bcm-unimac.h header currently...

Oh. you included that in the first patch of the series. I see.

It feels like the series would be more natural of this was 1/3 instead
of 2/3, since the current 1/3 patch depends on this clk value being set, no?

The result of the series makes sense tho:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

