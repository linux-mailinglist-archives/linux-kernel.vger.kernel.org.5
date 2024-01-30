Return-Path: <linux-kernel+bounces-45145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A2C842C27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5A7B24D88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8A79937;
	Tue, 30 Jan 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXeaCS/5"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C369DF3;
	Tue, 30 Jan 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640904; cv=fail; b=om2tPoPJEgbNgpD22AsfBujEBRr5EZmikLHxm9piLY4rgzke/sU8R6pM7uEIStlixWFdfxP6KkRCEQndxlM12Kr8C+SO2FzYes33+RFVxCksz6sQ/w6XhdUQzjNfkMyE/elOxxECp7PxvkfRny1VkjDX7CHBod5c8YW9q3VZkJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640904; c=relaxed/simple;
	bh=6JV4JJlmSxQXjq/ZzM7a1VvfVbpwShgcsUWcsnwRdD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIOVJTNGgMrLihGXgzLj85yZOqb1MBM8LdYipIbXkmxwAGCmncVBFkEd5RMRQndBatscSpe2EmQDs+oD17di93jXKWApx0O5YWUy/ymET6WatZJmiDIS4xszRF8nAsU09YtM+2lj0NGMuz4B7kfeH81qV1YbhjuYxvFJ4xnwFnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXeaCS/5; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706640902; x=1738176902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6JV4JJlmSxQXjq/ZzM7a1VvfVbpwShgcsUWcsnwRdD0=;
  b=gXeaCS/5cJX3+0IFsfU650MN3cxeGG61XaAlGBYnKXjlNpCYD/w3c4um
   qptO0R88wwZ5NRnZ3ddM4CxQ6lS86lxYnqJumi2jYwIYq6pxpvEsV3q4C
   mOB8JMto0e5JZRb1MKUeoyNI80mZWhfwxqUCBncxJZTzBCB+wEvHZ4Vb7
   pVgw1TvTW0JmMBEdlRslI0jI5lgDB/xAR3sEBf9c+hXTn0F1+8xSp49s5
   b6SodQdTXWwBQtLx13ZIPwIN8DXdm8q3vlgju6xOInODYFappTU1OJqkc
   7hQuC2/2UoEq7gtnfX87U46loonYHdTtaPkm8g9SxsWRSA0U2vrfgOwSe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="393822200"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="393822200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119368507"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119368507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 10:55:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 10:54:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 10:54:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 10:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjHJqp8VC+FoKvIS2JGzu76QpdWm1oIg4ATPgSsbLvFT+RuaL+e8cf/4FrSEmF7RbOBwJjU2/alv5nuUUoxBXQoZWD/sSuPiURc3r8PudMOjIpwFVOBeE2g+gX7PWggqSVEanfyvfysoNLS0aUWKni/D3XazcNTx8BjlUT6PIpmd4PZNCqzvq9AfQWvPwvYEVOX7wRF/+RqaE8AQwiQujx28Ogwv2ohqswXMw5AdYcQreccMj3g753TMz02TRrHEY0gmC+XScZjXINMxHAD83lPp5ioVM9ZWK2cjvL3pAYBgq4x5G2dy7H0UmiDHiqpSHwXmdpem+f113zcB+O4fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUpT2dnVG4Q4mB3rIxv7v9i3E3Pgm8r7wODoIvlb8pY=;
 b=S0a5nleYnmkIR2aVHvIYWIf0gqt3ySTKuY7NwJ6yuEJ86GHqzp/fD/f58fDf7uveXQXW2eJCv+NlAizG2Brv+r++PrpnWFolBWXadK/jzn9Ny6Su3940sprJ9GSzTPHOpOssKbwpJ9wJiqVo73e3xmMZZYV8SkpH+MCxifHQX0XOcfQvYWSG6YTUx/F0d0qiyWqSjdPUq17r8CN4MCsVv3pq3gwF8y7mAMoBi8nFo7clQA5puemTvaR6O+kfm50SwcoCrsXvRR2/Vt+buG8AMAsPh3wHQJLe9Z3BclqkMuSk4bEXRZW0cyFZWNjtV9xo0aVa5ANoMnoK+t5HUWxaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:54:54 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::73bc:fbbc:4eb:ef31]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::73bc:fbbc:4eb:ef31%2]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 18:54:54 +0000
Message-ID: <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
Date: Tue, 30 Jan 2024 12:54:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Joe Damato <jdamato@fastly.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <linux-api@vger.kernel.org>,
	<brauner@kernel.org>, <davem@davemloft.net>, <alexander.duyck@gmail.com>,
	<kuba@kernel.org>, Wei Wang <weiwan@google.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: 1befb1d6-98b8-4c20-6e24-08dc21c4f244
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfCVPsQD6I0aJkJWx2DxExBKlJD3WkuQtqXtWr8iQV+VQDTFpMjY/fw2+ZBWv3mcxD3oxFzO7MpXVdetUhjCb9pZY9S4Gr5uXezNZ8dGjCrj7I5l8U4rrwaszhbMPUMjxGz9OG1XD4JX0wb+0Sks6LCAOjxM0ndtA/NpjsZUhsQz47adoga5AIGdAUpesZQ9XQL+DzQ2m++gFxYEjn8lN+g5MmqmKd4wjA2LBw2GVUzwOTOFwsHHZoS9yGAkdMYVYMfFRnDK8NFnBTwutZWgnHYK6AbTnzLxzZBJTZYQGVO58AKF5xBfPCOVOFXwiPr9CW6NVDnvvjM3XiiwEdZfKyOXixYupdIvIO9Y+f6F+eLt7DZqapdNglE3xSIlIrOLGVnJ04Dhkn5g6/H4ZpslNWNLqhgfRIxJJ2eSjJUbBRkNTfLmkQHAqAh4v4iToe40s2arxAvsfiDWXayrjDSKN0EFnKhr1sY4CpVRQFPPiQNsDSdWZUevMaJc3EKdlCngogejqDcUzAydANAgHBAt0r/s97YZw/F+HR55GsgwyYRnS+2Padc3JVxsqkKrVnzAF/N4cOP/VJbh7PgTnMiVVusl0zssbOPCN2dmjYASBREgGJx4x9L9CccnyOrZ9toV0tSHY/vuHlGzZCjO05u6T1+8AW+A43e3ja9KjuFD7YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(110136005)(8676002)(4326008)(8936002)(7416002)(2906002)(5660300002)(31696002)(86362001)(54906003)(66476007)(66556008)(66946007)(316002)(36756003)(6486002)(966005)(6666004)(82960400001)(38100700002)(6506007)(6512007)(478600001)(53546011)(83380400001)(26005)(2616005)(107886003)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVvbU91d1FQNVNWcTVuTHpnYlp0RWNTdDFlNW92SlBrMFVRK0FpblYxRTRO?=
 =?utf-8?B?RHN5NGNBbHFpT2tIQ2NBWHFXaENaVDUrQTl1R0JKL2lPTDZsR1BXNmhCT1V2?=
 =?utf-8?B?NTVHTHplclhWMldIVVppcEMwcmxKL1Q5NWJaeHl0YWh4VjFVdFFMeTRLNXNm?=
 =?utf-8?B?VW1LajFvRHA3M1gvLzRyYll5UTVtc3hrL29VaTVHcFczV0kvbG9NTXp3MFVV?=
 =?utf-8?B?N3pXZ093bGprTmRwd0VRM3BDaktQdndGUUpGZTg4VTBpVVAxSlRNT3JZV0Q4?=
 =?utf-8?B?R1ExbTBMMmJxeG13Z2sveTBIZGh5aDlJL25TRy90dHVxUWFldyt3dUZLTWo2?=
 =?utf-8?B?bkNiR1E1dlU3RjhMTlVYdWNTUVdpSmRlYU1SM3pRdjA0SkI4cWtNZDUvOUU2?=
 =?utf-8?B?SVI5dnA0enFhMXlRQXdmRmRuZ05DL0QyY3BOUjNPVk9UckFWZjBMNWRvQ1BW?=
 =?utf-8?B?K1hUYkp4bmhMZ0kvZnV0dzJpK0JzR09IV0tMa2MxTDBUKzY3a2tZVG9Ub1l5?=
 =?utf-8?B?cGpyUGgxNnJkZVdPcmJPdXR4L0hKaGhSV2s1SSs0YVJEYXZOS2h0cFVGNjJC?=
 =?utf-8?B?SVFkYUU2N1lWYVMxNWxXUDhEdHZPNDIwR1BnOGJOa2dvd3lvSTUyUlB6ZGxC?=
 =?utf-8?B?R2RHL1Y3bHo0ekpKYXVUdzJKWVZWVVJtaC93d3FwdGpQcGl5N3Y3QVNtQmN2?=
 =?utf-8?B?NjlXS3hoNmFFRHFLK1JXME0vQmxhdnlNcUd5Z2VRdkt1Ri9NNkpHY1M1ZUYy?=
 =?utf-8?B?QXgyUSttTDFsdWJmazMvakpJcm9oRklLNTdPc1NhSjZZaU5JS1FnQ010b1hs?=
 =?utf-8?B?M29VOW1kZUh1RVFoaW4zcnlWbHozZXJnNjl2amhsdkpDQ3FjRk9nS1FHTGNP?=
 =?utf-8?B?c216ZWg1TXR6Zm9MN2lHaVYxVnB0aE92MUg5enlrek1QcDNIcFJZRUtjV1RV?=
 =?utf-8?B?bDRUK0J5VzlnSXhsalJSREx2eWZwQ0hmM3ZyYWRXZ3ZHTlR3aFkxckp6U01Z?=
 =?utf-8?B?ZHJ4YVpjK1BySTRRb2dlZXJtM1VHenlyWHpLR3pDNXNhUUxYZENwcHkrTTVE?=
 =?utf-8?B?bWV2SFJ3VTJOcUNxVjl5U2s3N2UzMXE5ZVZEWFoxSFlISjc1QktGUWYwaUE5?=
 =?utf-8?B?S2ZZNnZKTXRLbzlxQWMweHRJUDEyelFvNnkrL2NFMEdDK2pIRlJjd3NFUVFF?=
 =?utf-8?B?Z1IvaklCdk5kejhyenVKcGRZek5ZVmg0akJidkhTWk90NGEyMFVtTFVuZWhU?=
 =?utf-8?B?ZjI5S0ZyNEZUMHdHdVZqU2M1ZnRaMFg1U3R5eXFiQk04c0ZGT3cyV3k0YXpM?=
 =?utf-8?B?RzdpdmNQTVdFK09xUGo1NXU1N0dOKzNGMEZZRi9yRDF5dEpaRTRzOHY3MWpz?=
 =?utf-8?B?UWdDRjZrR1d3Y0h5QkR5bCtEblBURTBkNmVLMmYxdWQ5YVZZa20rZGo3a3JW?=
 =?utf-8?B?ZGFPYzR0U3cxMExxa1Bzd2JHQUUwQk9nZ1VMWHJSVU44SVg0M2UyTXRsN3dR?=
 =?utf-8?B?V0h6M3Zza25oT1oza2k5Ni92TG1rNEVpVGE1dklqS3RpQ0FkNllQc3hNK2My?=
 =?utf-8?B?bDJsdWw3UjNPQ0dzWE4ra2tCQTEydk5aOW5Cd0c0bWFmRlpIaWZqNUFIV2Js?=
 =?utf-8?B?aDRPYzEybTlnb0pQWEtqNnFiLzRvbUtPMFd5RzVvUlhhQ3VsY0RIc0pMcXpG?=
 =?utf-8?B?Zzlqdkp4SnZHOFZnb1c5TkFEejYzZVBoK2VJZFVPcXUzUTczMlNBMHdBRnNF?=
 =?utf-8?B?Nk05cndpbFFLY3QzWVowaWJTbVEzQWh3ZlhyTHZMZTRqVXNXR0ZpUG5SejNx?=
 =?utf-8?B?ZTNsMm8xR3p6amR3TzB2bzhid1Y4K0NsTndVRFV0M1VSN29lK2x0TWRhV3kr?=
 =?utf-8?B?YzNIMHp5WjB1aERrMTdjd1krdjRTNlFudlg3OHhycFpTQVdXQWpGa1lXSFY4?=
 =?utf-8?B?Y3krRmVXRlZzbGVVQWp0M1ptd3FObGRXbktWMFhyRlNGQ2xPdEVPTFVzaS83?=
 =?utf-8?B?SWNTNVkrNFBubUMxd3I1QmFJb1dLbFlCR3hrQVNScGdzREhBWFRYSzFKTzVG?=
 =?utf-8?B?akloU0QzakJGbWhXQ1NQWWRXN25LTHhGM0djd2VrQlZLa1Y2alppaDRwanIz?=
 =?utf-8?B?Y3JqbWI3NVdqZ2RtT0N4Z1FQRVYzSzd2MVRzaE1qYTR3Sy9VZTY4ZXVvOTF5?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1befb1d6-98b8-4c20-6e24-08dc21c4f244
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:54:54.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ryzd8+sqxFGHD+rHdKzl0QfM3/0ZW11F5Z4sttFkYMC7zbASXpdJr3XGUwm5pLnHViAmGRBmRupQ1eHk5668BRPPSFG0x2PQLKuIuhbn3mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com



On 1/24/2024 2:20 AM, Eric Dumazet wrote:
> On Wed, Jan 24, 2024 at 3:54 AM Joe Damato <jdamato@fastly.com> wrote:
>>
>> Greetings:
>>
>> TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
>> epoll with socket fds.") by allowing user applications to enable
>> epoll-based busy polling and set a busy poll packet budget on a per epoll
>> context basis.
>>
>> To allow for this, two ioctls have been added for epoll contexts for
>> getting and setting a new struct, struct epoll_params.
>>
>> This makes epoll-based busy polling much more usable for user
>> applications than the current system-wide sysctl and hardcoded budget.

Agree. looking forward to see this patch series accepted soon.

>>
>> Longer explanation:
>>
>> Presently epoll has support for a very useful form of busy poll based on
>> the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
>>
>> This form of busy poll allows epoll_wait to drive NAPI packet processing
>> which allows for a few interesting user application designs which can
>> reduce latency and also potentially improve L2/L3 cache hit rates by
>> deferring NAPI until userland has finished its work.
>>
>> The documentation available on this is, IMHO, a bit confusing so please
>> allow me to explain how one might use this:
>>
>> 1. Ensure each application thread has its own epoll instance mapping
>> 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
>> direct connections with specific dest ports to these queues.
>>
>> 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
>> polling will occur. This can help avoid the userland app from being
>> pre-empted by a hard IRQ while userland is running. Note this means that
>> userland must take care to call epoll_wait and not take too long in
>> userland since it now drives NAPI via epoll_wait.
>>
>> 3. Ensure that all incoming connections added to an epoll instance
>> have the same NAPI ID. This can be done with a BPF filter when
>> SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
>> accept thread is used which dispatches incoming connections to threads.
>>
>> 4. Lastly, busy poll must be enabled via a sysctl
>> (/proc/sys/net/core/busy_poll).
>>
>> The unfortunate part about step 4 above is that this enables busy poll
>> system-wide which affects all user applications on the system,
>> including epoll-based network applications which were not intended to
>> be used this way or applications where increased CPU usage for lower
>> latency network processing is unnecessary or not desirable.
>>
>> If the user wants to run one low latency epoll-based server application
>> with epoll-based busy poll, but would like to run the rest of the
>> applications on the system (which may also use epoll) without busy poll,
>> this system-wide sysctl presents a significant problem.
>>
>> This change preserves the system-wide sysctl, but adds a mechanism (via
>> ioctl) to enable or disable busy poll for epoll contexts as needed by
>> individual applications, making epoll-based busy poll more usable.
>>
> 
> I think this description missed the napi_defer_hard_irqs and
> gro_flush_timeout settings ?
> 
> I would think that if an application really wants to make sure its
> thread is the only one
> eventually calling napi->poll(), we must make sure NIC interrupts stay masked.
> 
> Current implementations of busy poll always release NAPI_STATE_SCHED bit when
> returning to user space.
> 
> It seems you want to make sure the application and only the
> application calls the napi->poll()
> at chosen times.
> 
> Some kind of contract is needed, and the presence of the hrtimer
> (currently only driven from dev->@gro_flush_timeout)
> would allow to do that correctly.
> 
> Whenever we 'trust' user space to perform the napi->poll shortly, we
> also want to arm the hrtimer to eventually detect
> the application took too long, to restart the other mechanisms (NIC irq based)
> 
> Note that we added the kthread based napi polling, and we are working
> to add a busy polling feature to these kthreads.
> allowing to completely mask NIC interrupts and further reduce latencies.


Good to know that you are looking into enabling busy polling for napi 
kthreads.
We have something similar in our ice OOT driver that is implemented and 
we call it 'independent pollers' as in this mode, busy polling will not 
be app dependent or triggered by an application.
Here is a link to the slides we presented at netdev 0x16 driver workshop.
https://netdevconf.info/0x16/slides/48/netdev0x16_driver_workshop_ADQ.pdf

We haven't yet submitted the patches upstream as there is no kernel 
interface to configure napi specific timeouts.
With the recent per-queue and per-napi netlink APIs that are accepted 
upstream
https://lore.kernel.org/netdev/170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com/

we are thinking of making timeout as a per-napi parameter and can be 
used as an interface to enable napi kthread based busy polling.

I think even the per-device napi_defer_hard_irqs and gro_flush_timeout 
should become per-napi parameters.

> 
> Thank you
> 
>> Thanks,
>> Joe
>>
>> [1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/
>>
>> Joe Damato (3):
>>    eventpoll: support busy poll per epoll instance
>>    eventpoll: Add per-epoll busy poll packet budget
>>    eventpoll: Add epoll ioctl for epoll_params
>>
>>   .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>>   fs/eventpoll.c                                | 99 ++++++++++++++++++-
>>   include/uapi/linux/eventpoll.h                | 12 +++
>>   3 files changed, 107 insertions(+), 5 deletions(-)
>>
>> --
>> 2.25.1
>>

