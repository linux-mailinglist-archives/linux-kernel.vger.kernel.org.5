Return-Path: <linux-kernel+bounces-5950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE5581920E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE821F24FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BF3B191;
	Tue, 19 Dec 2023 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ku5qeKoS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03F39FD3;
	Tue, 19 Dec 2023 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703019925; x=1734555925;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=50ShFUshASqKnK/G/mBSEMA/8Ue40ITNHhb0gtvBkrk=;
  b=Ku5qeKoS65ntCBg1gY+N02IXySC8IjjZVdeLjTq8tOuSQrIJSYLc1vxK
   LlmwQK8Rr2+tJnYYx4X5wu1AImWabiu1TR4h417ESnjfKD94Y1rjG1ObL
   wuE9Fbf9BoxHmC1VMMM4UkGjps3dYnRWFPEfmeGx0FD3BunNHE0qiXWqt
   acsQPht1Hmw1vTxVZ+KQ2lsxSKcaCinpqmRuX1HhDF3zhxrcNayq0L6iF
   kpfZo+lYQ4n69eADCMAobV/0Cd5d2iA4uxapcZtZzjULqUbCgMb8jyiim
   uYh4wkMbmd/hQqE3tnEMCEdRvvQiQv/UAJum+HQBt1uj+nfNEAwM/1oqD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="375211532"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="375211532"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 13:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894433853"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894433853"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 13:05:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 13:05:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 13:05:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 13:05:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 13:05:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czPWH9vs1G2xvIlMvPg7jQCr258GGmmbzevdU63C41nyVQVWk3iyX91xK/nzHu4ymEsxknhQ4NlZ/vIWGYu30zXVfcGwrcOewL9XVzKyYgWz7t3C2Y6pN6b0x7e0j/N0tJdu+grmmRAVK90Zi/b66Z0s/UJs8AMQnCqpBTe5E2+wNI2L7Rn/qwx2Edt975C+mGy6vHwvZ2QhtW94quidzq4MxQJFP0PAK9qS+ljo6ivGC6PsSrxpn7hCQlzEtJ+zb5qzoMIGRQo5wANZt6suxu1iPjBeLoz1q45bgQIIag7y7R0zYXM1EaOO1nQkysN3uvyUh+ONeJM1myewwpopog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmjyZo/ue1IUtgIY0zoBkcZbonlg5apRNk9WaU10Dm8=;
 b=QDxG9Df5Wg1V839Azd5v56cv6iMSSE8t3v/B4Pyj//X0q29BZj3nT0vjIVxetAlClU6NKHB+D4iZqY9flXT0GO+0+x2uffidTMqK2pSeOya7PsjB+gH1Mmrt0DWtwOnJbx17BU+jReETcSz9cwy3eVn+LS46j0uD9peAoQSTNSPHuaNWVyuIaZZ5omymUHKcpoyGFJGD/88jy+hh9oVmy6vTZuk5pbqtCoywQeyudDT7yg34X4fS0BuS4z+zynuwIiiAET0E42fjT8APKKxIxpsb1xE637SBmj31hFNYgdOnFgN4ZbQqA0u7iGv3epZcY71QNPOJDbTG0vd7dO2xjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 21:05:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 21:05:20 +0000
Message-ID: <fa937d9e-456e-4458-a5ea-8f912e64eb47@intel.com>
Date: Tue, 19 Dec 2023 13:05:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-af: Fix marking couple of structure as
 __packed
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, Suman Ghosh <sumang@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "sgoutham@marvell.com"
	<sgoutham@marvell.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>,
	"jerinj@marvell.com" <jerinj@marvell.com>, "gakula@marvell.com"
	<gakula@marvell.com>, "hkelam@marvell.com" <hkelam@marvell.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20231218082758.247831-1-sumang@marvell.com>
 <c48b24d9-f05f-4c66-a0ca-5cd6f59bea0c@intel.com>
 <35751ffb2c4d436baaa93230c1430a03@AcuMS.aculab.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <35751ffb2c4d436baaa93230c1430a03@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: b170f1d5-8a01-4e48-7d91-08dc00d635db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfagE/HyDKvVaN1bxZgEas7u8ixPA6bTYr6IzicH1uG29zb6jcfq+lYcybSZgrt72H9ankK3l2AO8m/y5o7rC9Um48juMTo9VkFK0/aZui0r33g/WRS9K6xnQ4k0ewiuQM50PsyQteeJ+NQLnlNHD3/KW7Pu8PPs0FITDYdtViHnOqAFxLCIaToAAK3CCoNSov4QZ93au+v9rRvtX9EE+zpUlATp5NVtgSOr79d95p0rmJtmEphpMB35xZqjcgq+DUOZY0TShj4dY+AnwVlUu0NficqQz6JLozfYBmyPze5pATsBcpKFxHuRu2I2iUkCEdX8tm72bLIYyXtfpz14jCzOCX6qo8/IuZeo1q93ytA4lUpUpffPlCA2Zj2GfQb0FlPQVTyzQr6cHE4u/mtg9hUqFi6+YE/IyLRAc9ntHtKoaSzxGHm5o5qW30YXbgi4/3i6Wbs6y1alQ2lgLdf++yJfp9jowz1bU3vUIgYrNe/WYZal/GLA+4EKR0pIyMj/77aeQhrCN+LtPIDDRhqDHSvb4rw4u1tVYkd8Da5sqkfXdeRFE8f9Kj/OMyEheO288g36wap6SNJmWymtn515d78UnyT/SQIrVeWuzUAYu4v3j2NIbLrm6sWtPWdFN1MpcdSdzVzmRxp3xMnxInAtD1sncI1OUVm0Sp+/Db35m1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(7416002)(5660300002)(66899024)(31696002)(41300700001)(921008)(36756003)(86362001)(82960400001)(26005)(53546011)(6486002)(110136005)(2616005)(83380400001)(66946007)(66556008)(478600001)(316002)(66476007)(6506007)(38100700002)(8936002)(6512007)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBqRi8vNkkreUJUenlRUWk1SEtLdFlGdDE2YndWRUhKRm1vWFJxQVROSVBl?=
 =?utf-8?B?R0xURW93cnBSaUM2bENHOUtOeGZPcnZrYVBkSERxK1duOWVSZ3VwcG5UckFK?=
 =?utf-8?B?aTJnN2l3T1Fnb3E4VFZYUUJoN0FoNkZBNG9Wc2I0MzBWSkQ4TTM1VUg5Y3VF?=
 =?utf-8?B?dStHNUJ2UlUzY1l3SmpuVkYzZkFMQStsLzdMYnpEWHcweVJRc21JSndabWI0?=
 =?utf-8?B?dXFjQnhQS255TkowRVNhSXRCVjNIMm9zUVowN09BZTNmT0p6c1l5NlJKS3cr?=
 =?utf-8?B?V3JHVFJDK2UrSnRhZWJXQmQxU0hhVDBKRDZhbCtkY1JYZVRCalp4TkZTckRh?=
 =?utf-8?B?dDRZL1dkdUdpSmhIMFVOblJTeHJWVm1PV09LWk0vYWNXWTlyU3RuSDUrUVdx?=
 =?utf-8?B?WWhjRzJuNi9KK2p3RmtJeUtNRk9nLytWeEFEaUFSU0hNME82U3NVbVhjN1Na?=
 =?utf-8?B?enh5TzdyNXVMc2kvcDE4TFlzKzBzUjRlT1k4VGRmUmJuWnFxbTl2QjR4REUv?=
 =?utf-8?B?QURxRDJNckp1OEV1U2dkZ1NOTG1IVXVRbkUzL1VUSFMrZVhaVWF3TXF2aTk4?=
 =?utf-8?B?VjZEbmNlNkNudXJDZzdoNlYzMy92a2JkVFM0Z0dxcG9XN2NLTWRPNjR5a1Bt?=
 =?utf-8?B?OWhKTDBnN3FFS05OOUpBMWFUR3NwemVEU3QvenlBQ3paSXlnTW1RWjB3RlA0?=
 =?utf-8?B?bXNPanB5WFNnVGZGaUtUY1N5MmpGVzR6dzRkcVZGSzBsdUt6ZG9PUHJSWEtw?=
 =?utf-8?B?My9GUTRTUWppRFkxS3UrWm5vTW5kVnova09kOGpTS05MdnIzejYxOHBpUDZP?=
 =?utf-8?B?M2t6Y1VYeWRiNXEzMFNqZmZoYUNISmhKWEQ5UUpqQzJ2UjZrYXRYMzB0ZlMy?=
 =?utf-8?B?dHF2NWw5a251bURZZXArT0x5T05aeXFwWUxXY2VKa0ZoTTVDYjBQZnF1N3M4?=
 =?utf-8?B?ZkYyVElNVmFiMDBHMCttVTVIdG5PbmhmYmFZSjZRSXltR0NDTDJQUFI4VUJr?=
 =?utf-8?B?dndWUjYvUWhiZ0hZS0IvWU92ZmFJR0QxclBLS2phM0VyenlMcmdNcXRYOXNa?=
 =?utf-8?B?U0tWOWp4cUIydHlnVDJwSGtYMkUraTljQi8wanU0bG1JWERIRDZrbmdVVnhJ?=
 =?utf-8?B?TzFFWlVhU1pEbkJ2dXppR1FHb3NuOU1nT3MxQ1IyUmI4QTZGZDZSUGxtTGR6?=
 =?utf-8?B?T3IrYWRsNG41VFFPNjFRTy9MMjBDa2luRFZRbUlNNzkvUGNJc3F4TjA1QlE0?=
 =?utf-8?B?bGhLV3NoZXRKRmhPUlBERUV4bHU4VkZlMkVWRmZMVGNDeFFOQ2VFbkw4UXhl?=
 =?utf-8?B?Y3Zlb2UyNWZIVjR5ZlYwZFJjSy9TTWNyejA3TmNJbmVCQm5TWnBBMjlJRkxT?=
 =?utf-8?B?S292MGFiVHl3NWZ5R0FmcEJZZXVaNVQ3NTlQc05jV2dQd1dvL1gvQnVoQ2ww?=
 =?utf-8?B?MVF5TURBdk0xK0lqM1VSRWxaZnhaNzA1TzRuOHIxWmY1TnpKSHE4RU9rdXpa?=
 =?utf-8?B?RTN1V3NLUzRhOVhYUVF3dHdUYXY2VkgrLzJNbzdBSnVRdXBuWGlLYVdjZldH?=
 =?utf-8?B?VFk5L2VJM1g3dURLWkZ5cG5MMmhCZnNVc0VMSnJTMW9PYk9KTU5peVRPRDkr?=
 =?utf-8?B?dG9RYU01ZnJDL2x5WUlsazNYYXZNSjcwamdqTHhIRkxPL3o4ak9qTFJWdjlB?=
 =?utf-8?B?WHdqc1lHRmpSUHB0dFJJRVhzZ0s5c256ZjNJZGtBY3drMnFJYzhtVXh0cUhP?=
 =?utf-8?B?QXVJbHQ2VkJiZnNTcW54cm11N3RuTWpjbDl3clpnWFpKdHlqRUpndnZUeEh2?=
 =?utf-8?B?L1JldTZMVGw0OE93bTQrRzlldlN6UndMUVA2NmJwZDVVamV1NGJkaVlKYVh6?=
 =?utf-8?B?Y2pCK2VTWlIwbGd4aEZ0endMcis4NTVpRkJOa1EzMEN4S3JPZkI3MjNJTlAw?=
 =?utf-8?B?dm5zcWUvQnJxK1IxUG9IOXRzQ1pRR2RVWC9DVGIrcGZKK2txQ0tobzVCUFIv?=
 =?utf-8?B?RzRucDN4ZDdZb0JycWxUdXZUdlc5NzJCWkZ4a3lzTzQvR09ZY1FCeGE4WUU5?=
 =?utf-8?B?eExwWlFTOHMvTmQ2NUp1Q0Fxa01tNElYYndDRXAxT0p2MUV5T3dHZkJITDR3?=
 =?utf-8?B?MDBPOEJjZVFldXlFN21PQTJWWjhHdG51NEVoenFPTWtLN3ZtcHR2cnpHMG5F?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b170f1d5-8a01-4e48-7d91-08dc00d635db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 21:05:20.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcPfh2ugCim7l4nrnxxUeeARPIAL5smAnleibYVnH9LUt2939ds8OfwVSQUoGDXDWmxqnUabssmWwNH7HEyliVPn1HlW2p55PYOXjV8NXjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com



On 12/19/2023 7:26 AM, David Laight wrote:
> From: Jacob Keller
>> Sent: 18 December 2023 20:44
>>
>> On 12/18/2023 12:27 AM, Suman Ghosh wrote:
>>> Couple of structures was not marked as __packed which may have some
>>> performance implication. This patch fixes the same and mark them as
>>> __packed.
>>
>> Not sure I follow why lack of __packed would have performance
>> implications? I get that __packed is important to ensure layout is
>> correct or to ensure the whole structure has the right size rather than
>> unexpected gaps. I'd guess maybe because the structures size would
>> include padding without __packed, leading to a lot of gaps when
>> combining several structures together...
>>
>> I did test on my system with pahole, and even without __packed, I don't
>> get any gaps in the npc_lt_def_cfg structure:
>>
>>
>>> struct npc_lt_def_cfg {
>>>         struct npc_lt_def          rx_ol2;               /*     0     3 */
>>>         struct npc_lt_def          rx_oip4;              /*     3     3 */
>>>         struct npc_lt_def          rx_iip4;              /*     6     3 */
>>>         struct npc_lt_def          rx_oip6;              /*     9     3 */
>>>         struct npc_lt_def          rx_iip6;              /*    12     3 */
>>>         struct npc_lt_def          rx_otcp;              /*    15     3 */
>>>         struct npc_lt_def          rx_itcp;              /*    18     3 */
>>>         struct npc_lt_def          rx_oudp;              /*    21     3 */
>>>         struct npc_lt_def          rx_iudp;              /*    24     3 */
>>>         struct npc_lt_def          rx_osctp;             /*    27     3 */
>>>         struct npc_lt_def          rx_isctp;             /*    30     3 */
>>>         struct npc_lt_def_ipsec    rx_ipsec[2];          /*    33    10 */
>>>         struct npc_lt_def          pck_ol2;              /*    43     3 */
>>>         struct npc_lt_def          pck_oip4;             /*    46     3 */
>>>         struct npc_lt_def          pck_oip6;             /*    49     3 */
>>>         struct npc_lt_def          pck_iip4;             /*    52     3 */
>>>         struct npc_lt_def_apad     rx_apad0;             /*    55     4 */
>>>         struct npc_lt_def_apad     rx_apad1;             /*    59     4 */
>>>         struct npc_lt_def_color    ovlan;                /*    63     5 */
>>>         /* --- cacheline 1 boundary (64 bytes) was 4 bytes ago --- */
>>>         struct npc_lt_def_color    ivlan;                /*    68     5 */
>>>         struct npc_lt_def_color    rx_gen0_color;        /*    73     5 */
>>>         struct npc_lt_def_color    rx_gen1_color;        /*    78     5 */
>>>         struct npc_lt_def_et       rx_et[2];             /*    83    10 */
>>>
>>>         /* size: 93, cachelines: 2, members: 23 */
>>>         /* last cacheline: 29 bytes */
>>> };
>>
>>
>> However that may not be true across all compilers etc. Also all the
>> other structures are __packed. Makes sense.
> 
> Or not - maybe all the __packed should be removed instead!
> 
> Unless these structures (or any others) appear in 'messages' which
> get transferred between systems they really shouldn't be __packed.
> And a 93 byte 'message' with all those fields seems rather odd.
> 
> The above breakdown seems to imply everything is 'unsigned char'
> so the __packed makes no difference.
> 
> Using __packed requires the compiler generate byte loads/store
> with shifts (etc) on many architectures and should really be avoided
> unless it is absolutely needed for binary compatibility.
> 
> Even then if the problem is a 64bit field that only needs to be
> 32bit aligned (as is common for some compat32 code) then the 64bit
> fields should be marked as being 32bit aligned.
> 
> 	David
> 
Right. Typically packed is only required when dealing with something
where the exact binary layout matters (i.e. copying to/from hardware or
across systems in such a way that the layout might change with different
compilers/arch).

If that isn't how this structure is used, then ya, removing __packed
seems reasonable. And at least for one system I see no difference in the
actual generated layout, making __packed redundant.

However, its not clear to me at a glance how this structure is used and
whether it really is copied between places where binary compatibility is
a requirement.

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

