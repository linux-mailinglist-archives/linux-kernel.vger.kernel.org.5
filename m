Return-Path: <linux-kernel+bounces-7489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5781A8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47D9282A77
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F8B4A986;
	Wed, 20 Dec 2023 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2sqRB83"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6A482DB;
	Wed, 20 Dec 2023 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703110348; x=1734646348;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9e+6wkkKW5Lx5bh9HH1JkxwQB65mB5SrlMZPDu0FCcE=;
  b=E2sqRB83mefylDjiU70bdUuNa3JhxvQgxxn0KCgvD7twEaXSPLXQnxqv
   CNJ/G4pqj0e6IOKxoQdvp0YBNGH0uwZZ70gF1RyDltvYabNdIm77OtFm4
   JNesqb7yTpC4VxRmoqFgtGcCNdKd2Ur8MjK40tRMTtOdP3nA8MdES5qCg
   tZm1woYZhiVoMSbCzZsjRgfME5h452sKedmWdx8KL3uJix8oRB7awJYYS
   cWoH/1u7H9vHNOoDHavP9EcPAPdwlX3lC5R1T0q9Ous963mD++E1KXw4m
   qAZPT5E98aYUM04V0XQUGzrhsn2OMiYv77t3zZTJ8QyLDAHupJwlcOFdI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462328277"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="462328277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18106311"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:12:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:12:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:12:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:12:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyr3Bpg6n0WdtzdTo2PiXFyVttxPUYEgPzLr49HXVUv2YV/r1mNJKZ663twMgR2H3nqBjCzLcsXO9cI4xP0kBo2tK4T3m20c6LxL+LSLvWXc4rKme6efP8bumnojtQd8wUjwU7EPwQm4HcmeIzOwqsoj36iHdD/H6+vhVWlruMaZjVjFrXLNv2LtfhMBL+K1u/kDBzJXwJ+1859lq9GljO4Xc4cIGzh07svl11QuYZ0d8oVu7F10c+jxfjQRgdACuLlBPoR+AsMFTeVNHqTLaAiArJ0XRpug8pGrG0DdPscbQOl/SaI3nYgf2BTQgdCQQ4Zw4riGXhK9bvqANU7vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99btik5qUSJsSb5rfF+9fY+oc80mITcB++Dj+l8v0dg=;
 b=TdZGYf8yCq0RbXp2NOfKqetQFk4miyqCsmJPKcOa5xLoYDTt8NZNVlYHt1iBpTG6+6vHzcjmemwtUCx5Nxga4Rg0sgbdMKg3BeNirIdT0sL6YeT5YKBcZqxjkbme9BVEcBDvYKEtmx9Itqz/IMNs/x8m916mQ9GR36q4YvFl/gVI1I71A20JhLUi6Z6vqMvNW0z0Ez8FNWe4JlVfMRkNJgaEGnYX1+NjpsXogyJ9K8kq9ho3FofiJ2qgRvaVVWG18h6imHck+8W1/PcXqyWX4dK82KAsCZGCAnNiURVlQGpkdNY23czBkgOJxyE3vSdr3NXXp3OsYqX1kCjA/NXyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 22:12:13 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:12:13 +0000
Message-ID: <7249a8c0-b97f-4634-a08b-06be503f8c71@intel.com>
Date: Wed, 20 Dec 2023 14:12:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Emil Renner Berthing" <kernel@esmil.dk>, Samin Guo
	<samin.guo@starfivetech.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, "Giuseppe Cavallaro"
	<peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>
References: <20231220002824.2462655-1-cristian.ciocaltea@collabora.com>
 <20231220002824.2462655-2-cristian.ciocaltea@collabora.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231220002824.2462655-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 609097b9-0e28-42c9-9268-08dc01a8b7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVZ/gC/koujLqPa2YGqmVbkA9VQ0ol1rPbaSGAO24fFAbexW9RdzYpHTerf0pNGlYjjxLlUTrx0YDWKQxnLK86A0oQGwNnXgO31bOBgZ6LCYbvh4mhTWOEV5bp2m8JcIgg0jegfS2OhHVvmg6U4IEEjDoZ4Nz0ONq0sWP3QwA4G6v3Nnfqg/3c7KIheXYQm32t+eMnfMMfqV0LxDMGWoguZ3ds/KTKyS63QYja/fXWGPkHxrWFYyB/r8yTwMh2t3vUcT5OCzutFIEVfvII5G6reh59y5h6iQn0d4Pmi1JRSimB39Hqij4amr3fHsEVHDz+SEQXF1kSRe1DfOntzulws6VKO6cW7vOqDwcAOIKcpD7yBoM8fBytuizAOjPsLtppQvjFWo7MwyZWozJOEr87rFu+IqtL8WFTaDg5lo1Rh882PM8dO64nkc+AsUdFNSoHN5HEt7ePXHxxCDxieSdJGkGLdKqfhBovIOxo2MmpMlaWFfztDb7q08/ETV0ehuyJN99tzhZOFlhdR8T/LY/60XHBo8QqFvn6/8Cmo+D1hlWb5UmvP48WoFjd7YkOcSNxgXNRsE+9jMxm4WFVnpOnXRLlWf243SOGQykQnQNXr2jBT/YPksoyVBpBZF9bClv+maBGOttJw48d5aRwB+F17ev2YSkIXZhJZV4xnXF1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(478600001)(6486002)(38100700002)(31686004)(82960400001)(41300700001)(2616005)(6512007)(6506007)(53546011)(86362001)(8676002)(31696002)(7416002)(4326008)(5660300002)(2906002)(8936002)(36756003)(921008)(316002)(66946007)(66556008)(66476007)(110136005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUgzckRxVytYOEh3MU95SzdYTCtUOWZYU0xqUml5NjlLeXI3UW1mYXpJQjFt?=
 =?utf-8?B?LzVxT2NyTVFkbXRxVmxFNlRPclgvL2RSNDBkVTE0NHN4eU1aWTN6ZTBYSFdZ?=
 =?utf-8?B?VUFvZEdpdXkvVVozZU45MmR2OHU2d1ZkZXpTVE5OYnhrVDdHSGN1SU85UEs0?=
 =?utf-8?B?TzlMMFo0cE9NTW05THVXNnZ0WTlCUTc4TDJqRUFBREVxSks2NzM2WmhkaTBX?=
 =?utf-8?B?bUUrUkN6K1pRSWhLc2s0ME9TSXZZZFhiNXZLZW1IaG5RTkdHYXFYWjZQSlFv?=
 =?utf-8?B?V21vT2lJaXZtakhCNUwzZnNXdmttWnpZYmF5M2hmS1BhUkZPWHNFZVdkeG1z?=
 =?utf-8?B?OE02UEl4L3N4WjN2NWR0RlQxWVpoNlJIU3ZLUUN0RFM4MS9SSUlPREU5bk44?=
 =?utf-8?B?RE9QaXJGZmRsYldQMGd3TDJXZUJIWkNGcmpveUNEMis5ZTRaMlFlN1FVQ1hV?=
 =?utf-8?B?MnBFRHdFS095Z0xkNjBGY1A2UXU1bkJhNng1MDF2aVRvSDhJZ0FMVU5tdlhF?=
 =?utf-8?B?TTBBbUlxY0ErSmZwZDRYZjlPSS9tVnAvaVc1TWdKdGRTbVNzaWNRWlFPUHBh?=
 =?utf-8?B?SnRJTUxKYXRwTnN0dGNmY1oxUEdjVERWem10cTNpZVQ3ZUU5d3JkYU5jY1Jh?=
 =?utf-8?B?MEdwdk9OVnhHaUUvd09aZ1c2ejhDWGFKODc1dUtXVCtQZFRZOEVzcmNIa3ps?=
 =?utf-8?B?eHhiZ1krR2ZkcFZYYW5yUTluemU2bUZleDQ2R0kzWjBxdktLT3FiRlQ3eHhJ?=
 =?utf-8?B?K3pwK2RhYnpPbVBpd2U0TlR1ZTV6M2tSWFpmM0poazNTTTQxMXRVVWNENENT?=
 =?utf-8?B?Z2h1SEdtcjQ4SU81Ry93MGtST2hFSitiZkZYK0NqTVc0ZXJkK3hFbUxyOGw3?=
 =?utf-8?B?TVpRZE1CV2h0SytpVzZLNm1XMit6dHdzb1VZQytRb2xyT01ONTVKdHBCNVI2?=
 =?utf-8?B?TDdmRUVybWhZQi9EY0s0WVY1VVhwL2dHcnJha2JnTFhkNFVLeVczK2QvZk03?=
 =?utf-8?B?RDhEUkJWRmtTL3gvTk1aa1VGQndnRXU0bEgxaTZyb2MwZDlScTRMZFRreEJE?=
 =?utf-8?B?MmhGbUZFMEZUdXYxSVp3Z2dNVkJ2Zml5eEVTbWQ5WFNWZUZINmRFd2RVZkFa?=
 =?utf-8?B?ZFAzQVdqQnM2SitldnNzbnE1UlcyRXFOVTBzem53R2l5RWdWMDY3YWNRdW13?=
 =?utf-8?B?SVVrdGliRHF4RTRzS3JGMmptOVk5TVNXdHJOYnR2VitpekRMNi9qYVRENWZv?=
 =?utf-8?B?SXpQRFV1S2VXMlkvQm5yN2s0Z1dSMVh1SmxYVTJIVmpKcW1FK1I0Z0tXNXR2?=
 =?utf-8?B?eGdaY3llbTFkQ1lyc3hNVTllZUdBRTVlR2J1TGtPMXdjQjVUbEVOUW15ZkY2?=
 =?utf-8?B?NUVOY3VLNG4wcTdTeGJlRGo3WHA1QXhRRFFzdVY2aFZOaFgydWNJM2xpdEpo?=
 =?utf-8?B?aFdHU2lheG1yQjhocVNDUDMwS0JwUXJVQWRjT1czVDlGVy9kd1krUUk0WUhU?=
 =?utf-8?B?RklWY0pjd2ZUbVU3WjYyd243OEtkQ0xyUU9aYU1KeUVINmhkT1M4WEdxeHpo?=
 =?utf-8?B?WTVmRkd2djA2Y3l3UHJRY1pFQlc4NkJzWVFFRDEyVGQ2dkZ6WFdUcFJKVHFx?=
 =?utf-8?B?eGI4ZTNGc1lmTkcyTzJkY2xIalUxaU5pZHF4ZVVFUnJlblZFUE13cjQ2eHhk?=
 =?utf-8?B?Yk1LY2dlWFhZK0pkT2tUem9TNkpRQkUyTUxQejdPNi9jM3F5ckF6b2FDc1pF?=
 =?utf-8?B?M2orNDc1MGJhWk5FdCtiM2UwV1Vhei9BN1FsQStjTkR5dTFTMDFFRzN3dE1o?=
 =?utf-8?B?Y0xxamJRbWR5VTN6Yk5JTFNRME9PWVYvT3dtTnl4SkdNNVF2TW5DYTlUTTJG?=
 =?utf-8?B?K3I3dzVwLzR1K3YrRkFXSWNqTnVxcTBOVzBjeDY4Q0ptMUkrenc4TDNQZC9K?=
 =?utf-8?B?ZWRtZUZCelJQNC9xbENCTGpXNDd1aVhGcHlmWFhwZTE0d1F1QWdhWllya2Yy?=
 =?utf-8?B?d2xYNFpGdDB2SHVCdmtGMVFobFk4cFBQMHhzQnp5RjhxNTZVY1Fvb0dsOXNq?=
 =?utf-8?B?aWc1eEVzYjYzWmVJWHNVR3RhMlY3R0tsSWZkWERKMC8xRGRUWWtEeEFUK2dh?=
 =?utf-8?B?Y1FoRDY3d2RRQWNjeVdhWjYveWV3VE1CQ1lsVWY0c0l0SldyS2IzUTZxYUt3?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 609097b9-0e28-42c9-9268-08dc01a8b7d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:12:13.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc4JWT7ESdcDtKxLoD14huUyY8KDEbyYFAsvLYuvEqzl0zrLwT3Fqct5b/fGjpwNxIMwuqBPFSZC9ObDqVDBhVec0pKDa0KzdOR7SVznnYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com



On 12/19/2023 4:28 PM, Cristian Ciocaltea wrote:
> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
> similar to the newer JH7110, but it requires only two interrupts and a
> single reset line, which is 'ahb' instead of the commonly used
> 'stmmaceth'.
> 
> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
> conjunction with 'stmmaceth', extend the logic to also permit exclusive
> usage of the 'ahb' reset name.  This ensures the following use cases are
> supported:
> 
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
>   other:  reset-names = "stmmaceth";
> 
> Also note the need to use a different dwmac fallback, as v5.20 applies
> to JH7110 only, while JH7100 relies on v3.7x.
> 
> Additionally, drop the reset description items from top-level binding as
> they are already provided by the included snps,dwmac schema.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

