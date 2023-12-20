Return-Path: <linux-kernel+bounces-7504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7881A907
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9651C1C22ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189C4A99B;
	Wed, 20 Dec 2023 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiT3E4g0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0A4A986;
	Wed, 20 Dec 2023 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703110891; x=1734646891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wx1Ax1dQtooR4Td9nSo5xpRL49YUfget19WKcBGAmgs=;
  b=jiT3E4g0m5paazsmSYSZs1c6yuCfNAVuWUHO62d6NrzgCBpyxw1DYPHV
   cOBcwJmpkMrdn29LujqAZzkS93JrGZ/3zSF1RBqWDtk4p3kb9RJ+09gfg
   kmqdSPjEt1P/2qcK9vRZf0kzV8cb0/9/Q3PsgO8hJpawTpPdE4aTjbTqV
   P+fbtv7BHWqkhguFhGqoABhxvoc2Uf9snGF6dZFPgwsZvn9jp2xua9RYG
   suLqCieYbcJNFuL33gsuuWh8W5s314NXyRaQIonxlOiXXl/yhBGy18ZX8
   kMfIKYiFQ9EVmky+VinuTnKNAVb04/2N5+PmNIqWDsDsTAJgf4gYobtYu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="393048042"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="393048042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:21:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="949670228"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="949670228"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 14:21:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 14:21:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 14:21:30 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:21:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTSHIHRA8N+tshUN+ij0PB0U3tB20Th1tt2Ni53E9zlu8FxBg9mwS9xf65v9wo+7rE+VFoml+VCT1ttji5Cp1zJUiZiM81i+RpzYK2zeB87+Yda/yPjWF6x+lurh+SZALG83OT/Cu38YQK0Qc8+26jwFA6ZRszgS+vgRc/8uiP8SYr+18la4uYVCarutvpqzZOuqnVsdwHa0Asn6LW7q0hCfxUoiodA0p9D2JGw8PDaZzAeAm1WWiz0wpukx9b7CVREYk5JgSXLOhR5BZn+nOFYS3fuzQ1iiZZy/MygnFxg49Nf+QlHVT5a40ahCkJT477H2E4zz8uN3VmWtCZBKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXeM/tJtf6FrZBlv1FiTvGeU0HIsU0krfuhPdni24l4=;
 b=mla9Qb6l2hRlWZOSLklXkAMRyZYQ6IYX4SLo3MMYsHXC4QG+tGYhWzU87xv/39G53ysOIW0nrqYl0GaB+NPNQ/uQ2O357J4WzvjArzFGtFlJtuwzBhmOmJ/SF+ac/bQgyCXLl1ONrIJdcqJClto9xLo8GeDifo12z5XBywe5SWlsozk+U5TOZZLkOJ2wAUOGgkn+oY6gU9vRaeANjwq1mu/hKEVfT5e+2qE0snY595J9HUoy8wmKNESBR36/7mbiWsyZkZ7IMOT8xai61MyOJfEhw/FDXE5VuCTFYgCFpjfeNelneKo/93gh+bwHpnLXyi36MkIF6CPUjoRXm6ezMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 22:21:26 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 22:21:26 +0000
Message-ID: <5b971ec5-a455-4796-a3b0-76db8cfad815@intel.com>
Date: Wed, 20 Dec 2023 14:21:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/12 net-next] qca_spi: Improve SPI IRQ handling
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-3-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-3-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::28) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e71a38-796f-45d4-25af-08dc01aa0194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZM2++3/v709afwZJQBNXVdenF8PJ+DKbgNeTdyIKGWiCQokat6znWCX4+o29+JZWYOJ8+58eLdRJzr73CxmOEK9KZLDz6tRqFmue/H+zy8WMdpEIjcP+oiHZW7Xu4+n6J1w0er2u+JktOMAqhHo1F05rELzbxPDdY7NQ54e9Goamwu/8iQ6iUDKUWclv/0yiVaE96M2SWNgERxzmETnuDNeDJxMfgd+e2fmReF6vOF3jR1Dw80OlFszI4uaKKgT1K6ng2c6A9+WskLeXyzs9ZU6joXBNu4+xaYRQhpgsFlqvB3kOxWxso9wHuh8kKzcpiMNxwNJsnfN4WYpbPD0wMD+CElIG4Vcyi7BuVldx54WpRz7FIQ/gCOPNb33c4VsosHWGOpfgcsIxtG1EwnPhpSJwuXR1LBTYuFEHturgc4G2zDf9jSdjRPphu+qKzkUNXQwW3yqERi1VgB0hsSLOgm0pEGdmP8jqtCVUNiKkVhZ/+YUSd20JYY2PHans8KO+GfZoGCB/y+/WQF9kilCGZoAUV3eANgg549t8dp4OtfJTDGMwmUmOL0tARSAxmDl7NjhTgZLP9zj8Geq8ibRDG006hqWBFMfFxfOEIpsJUFmQW3mfcKMsiU962CUp/3LpuTIzXPW5Gvl4GO68LVPudw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(26005)(2616005)(6506007)(8936002)(53546011)(5660300002)(83380400001)(6512007)(41300700001)(478600001)(4744005)(2906002)(66946007)(316002)(66476007)(8676002)(4326008)(6486002)(66556008)(110136005)(82960400001)(36756003)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJpakkxR216Y0pVVnBPTnZ2TXZtTmUzcmZTS24xcDg1RmFlalhJbmFBMWRH?=
 =?utf-8?B?T2NtOGdKd0tCbXE0b2x3WnBoUXFHMVB5VEFxR2ZJcGY2YUhaM2xZNThkd29U?=
 =?utf-8?B?dnR3eC8ybU9DekdVSzA5YmpxeFZwM2RUZlQ1WmJLaDZuUkRPWEEvSElnY1VC?=
 =?utf-8?B?cjREbWhuZmxwcVZveWxSL1NYaTJPUDBjVHg2Zkg5c1VORE8vckRmMExQSXhs?=
 =?utf-8?B?QS9SSWRwZEd3TFlUbDVzWklKNTg5OW1RaHcycEJnTFQxQzR1Z3VXZ05oa003?=
 =?utf-8?B?YVVZYk1TdEo3REtWMHNUNjFKam1PSzBEK0JPUlNXNitkbTEzSGVpU1lWb09X?=
 =?utf-8?B?YWJ5SWs3alBWVzZ6Y0lCbnB3YWZidjRMd05qKzlCN05VU1ZIY0d0Wk5qZkw0?=
 =?utf-8?B?WEt5MmRQbVFyNVRVVkN1QWlBbkJKTndPeWIwMVFQU2toL1hwZ1BPVWg2WGZ0?=
 =?utf-8?B?b29kZWxNa2FjcUVhWWZ1UmJGZ0JIRnVtRURoODcxU0ZwcU8vV0VvWXQxai9V?=
 =?utf-8?B?aUVNT2lINjV2RnI5WTBDZzlrb2gvOHMzTktQeUVhVDJqM0dlOTNwbVhlMmpS?=
 =?utf-8?B?TnZ1SlFWRFcrUDhUR3lyd3ZLRXFGNkg1K2NNZWdEbVBSU2VLaW04VDRxcDFD?=
 =?utf-8?B?TEdZc1I2SDJLVVdkTXJkM3Z6cFk5d3FGS011NTVteVZqaExhSUJYdzJPSC83?=
 =?utf-8?B?OXdOaFJ4MHkrUXR2Z282Sml6RlRFRmRmQ25hYmx4ZmhSL0xUVWwzbkNnOHBQ?=
 =?utf-8?B?ai9QTFpucnd4cXhGQ24wZnV3d2pRc0RwRHR0Q1h5QXZEVFhlUWtaYTAybkwy?=
 =?utf-8?B?YTIzRUZ3Mks4NFo1Y0tvRm1xQjI4dlVFUzZqRENDek1ReU4zTldULzBwOFpK?=
 =?utf-8?B?ci8vMzZnUzRNUmozYWpHQVV4SENwaWl3b3ZaOGgvSEJnWHAyZFpYelBPZ3J0?=
 =?utf-8?B?cTZKbjVKUWZucXU0eWJKaUhyYjBwcVB0cVVYVkF2U1NDQmpVL1hCLzRSMnlj?=
 =?utf-8?B?RWNRZ040eWFGV1ZUcWtZLzA1TTI4Rzl0SFZRTTFhMXRpVGwzRDlYbTdmYlR0?=
 =?utf-8?B?ZEZwYmsyaEFNVTU1a0xrOGl1YktNOWZRa3EwOXZnMXBycm81T0pKUmVYbDBB?=
 =?utf-8?B?TXYvMWsydlloSkdqTjlpYmh0aGg5ZmZycEIwVmM3V0d0eTZvVWdHejIxcWNP?=
 =?utf-8?B?cnh6WFZaK2d6a1VxMmNzSkIrZDJURG1yenM2b3hvNDA5K3Y0dzN4VW1ueVdR?=
 =?utf-8?B?WUhBVmdMZnZpWUozcHVPMEw1QWQ5c0U5alFVZHV0Rm1wTHdkWWhQZ3doRS9D?=
 =?utf-8?B?SGk1T20waDVrQ0ExTGJ6a0o2K2drdURtaW43Z2ZqVTRqQ1VvNVdjck5JQVY3?=
 =?utf-8?B?YkdobWp1bm03d0ZrVmd1ZjYzQkgrNWt2U3JGOEV1VHA1YjN5UEozbjZiQkQx?=
 =?utf-8?B?L0orcmh2NUNDeEU3NFNKeXVMek5pTlFyVjBnVGZaNGZDSVVlOHZ3cCtXZ0Rp?=
 =?utf-8?B?WGJXZTU5YWEzbkg2aTNraFNPTXltcFkveUNkaTA2QkxHUStyMzY0Y2pHYXdP?=
 =?utf-8?B?bCtON2s0V1NYS1lhOWNhUHBzd2dzUXU3YVFZM0IxNTl6TVhSR2VWM0MyMWhJ?=
 =?utf-8?B?ZEtiQ0g5aUJ0ZS94dWVOdFJ4M0xzRzN5emx1aGxUTC9sTVVzeXppUGdjY3lQ?=
 =?utf-8?B?UlliNTdZT1RKV3NtRGRrQmJtSzhYU2VZL0greFdVU1F2cHVwcm5BL0NxMVhX?=
 =?utf-8?B?WTgreklTVHZvWTNRbjlTaVE5TUZPNThqTy8waVFOdzZMWTlkNEo4UGZYN0I1?=
 =?utf-8?B?M0pKWnduVU1XTDVNMzNkeE4vQnZ4MURqVWlMQjFaMVlqaXFrdWRJcEo1Z3ps?=
 =?utf-8?B?TXhEbDkxZ045c1pTQXpiSWMyLzBZTEtvQ200MFlqMEdlK2ZFdElqczh3eEoy?=
 =?utf-8?B?amdTeG5zbEx2ZHVFbE5vOE1kSVBMUzZQZmxvYXNOd3prOThKVnI3SzFCN2pS?=
 =?utf-8?B?dGFPSkN3cDkxQ2poNUp3emxxbkwxYlMwRVhQbWg4dHNENm5aeG96NlhmUXNI?=
 =?utf-8?B?dUhva2VHRTd4WjZENzd2NDJCNDJpUjhmak1xTzFxRUlnYThjcXpSOXdCV09J?=
 =?utf-8?B?MkxUaVZUeklMNCtEYy8wL21HZzFiSVhYMXZuTVB3cVFZT2syampzWlRKdm5T?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e71a38-796f-45d4-25af-08dc01aa0194
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 22:21:26.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7To5lryESppy3h60mKXmJ2GmSVTMjp1kdNQyOMsxN8UatI6pvmQenAwBaBCfYMi0EO8432/pgGwQqVMAfF0sdR1bU7RJy4s76AT/PT+324=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> The functions qcaspi_netdev_open/close are responsible of request &
> free of the SPI interrupt, which wasn't the best choice because
> allocation problems are discovered not during probe. So let us split
> IRQ allocation & enabling, so we can take advantage of a device
> managed IRQ.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Nice cleanup.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

