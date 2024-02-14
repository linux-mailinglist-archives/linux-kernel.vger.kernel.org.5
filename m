Return-Path: <linux-kernel+bounces-66009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F785552F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F261F23CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125D13F01E;
	Wed, 14 Feb 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyJ2+inc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD818E0C;
	Wed, 14 Feb 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947785; cv=fail; b=YjFLLMCqVUaMgtO/8zze+m4C0REpTQ64EVcdIigoFt4J50gd+/zcYGU/EM3MkwUzWTrbpZSwXkLDBwOo3Z+tAKOdWjur4CpEMTdaGUHp3XI5bSRZ4+mTF9pJ58no8Dv2zZ5I7IKwgv4wtww+E/BgAeWsvfoPncyFgwiNVuiGxN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947785; c=relaxed/simple;
	bh=mMLq7hDFqMT2/lNSaDM4e5sZkz+K55imHQdXchedF6I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbEpQI1GhsKDFLBnaBQrHC9zrrcBEMsoxF8nTCEzIRkisOvW/m5J2uuCwnmxs3rAdX183UGhpdaF6xQpija/z8U90AEEaq+2DXchvvme7JPrLmkhTunhywSam7kzUvJDw8cXzj6rFvv6YQpEkYHRbNXjKsELzDFmd6FEwCViWQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyJ2+inc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947784; x=1739483784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mMLq7hDFqMT2/lNSaDM4e5sZkz+K55imHQdXchedF6I=;
  b=dyJ2+inclNkJfWVm/YpQ9bBG4E4RZeJW2hBeHjgmHmY9XheXfwuUgqQ1
   4vzz/X7ypuDMSF6bE0jaMqpV5b3zJcKuQMup11rV9VmovBm0FK6/oGQw2
   cZZ4Da6buCD6fqBnS5AwX/D+Y7ITCpXWf9e0Sr+KLmZTXjpY3Cq50goqt
   Do1TJ9cQD3Pl5tMY2reEK2f8xmhFeSPVUMjKv7juuP8xX9+Fa4xh5n6Ga
   LchHsuEKglyjX++/AT9ynOrOd2c3iLWXwXKD8f8BW0Ol8j9hp1e97w2Hz
   Y37bYqd3jPVkY8r94zsYL/I2JhkxDg0khZEHDxEBR0UaHAWWtqsk5jn45
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5793641"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="5793641"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3310937"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:56:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:56:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:56:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:56:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIIvNjP6T6hF5DNXas0/aqHflNTDP0bAzAJISh9yOh5lnve7dkeNfRuGY1DBs52EsXK44SfPwZdqMYzc9+7LQhtjcYLqRgEl3yXOeyysnFtFNvKwZ0PfXmoutwp6V6tvWHd5qGOmtGosP+Elft7mxEDli4ZXZVuqUwZeHBmglHgsWL2lZjrT8T/ei7F1+iN4Um1mlx6hFRJc+NYHpxN3eahemStOzCM9ooWUvNf3EBrGDatYgyaqf53BObhhEuk/uUS2kgWUeSBZo6JqtjlIup0xz8qeMRiQZcOFudKuLjCblYy3Yp9qo5HNMMaGEt3Th8zRhtD881PnHB3A0fIFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBDP4vhv/6fYRI9jit4HQSSsdvtxdqVA0CLYevq6BnI=;
 b=XGSP3QuPgmbg5IPSlMBKW5A9MWz9Aje1VIU9HRWziyoMYITaS20ZN968phI/owWkAjz7hpv/v1y2XgHVudpDvT1VNZk9Is+1Aif0RX6ttVbA2Atwn2ue7Cji8fX3CYYNbZC/KfGvu2hqoFVQ+obRihxtetrmKsy72HavwHn90Cxa7InqbT8qpKg9LUPs7Vk35/9S+6b3ID/SbVCwTBLWNVhoA1rOnTISqXWOEpDssezYNcwBtrKkyVuK4F+F3kd+OFJLGdYuzIDdFrpkwzcoWhnRwMu4p6phmWs15ZpFgAZ63pCzmNSWquab4er+m2WQ28Rw0XN5pZlpQvidvJ2HDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 21:56:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 21:56:19 +0000
Message-ID: <998248d1-aa5f-45e0-813e-d0565fc952d3@intel.com>
Date: Wed, 14 Feb 2024 13:56:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dl2k: Fix potential NULL pointer dereference in
 receive_packet()
Content-Language: en-US
To: Rand Deeb <rand.sec96@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <deeb.rand@confident.ru>, <lvc-project@linuxtesting.org>,
	<voskresenski.stanislav@confident.ru>
References: <20240213200900.41722-1-rand.sec96@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240213200900.41722-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df65ee2-97b4-4466-ca3b-08dc2da7c66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AatDEVGXNymOIHRbNMmo5XLjOHaPay1tHdkD/Gtt2Pk7jjUQ0yfo9V7C7xP2b6KVEl2aiyId8nM96OKbhkiZZXBydq8AJtqtKzx2y9NmYaC14BOCMPZNDvZiK3d2r2fE5fZzqZwuIgS1Ut9nig78TIPpUurSbp1b2mMAWvrat5fKakB001KFtYS+aUKud9lcUdhC8rflT+AazR7swCwB42cN/TRKFpnboyP7sU5FGS2vPziH+t+5gRsl6XCexld/FjpI4GgL/wzjboPNnUWLKlC/Rfucn3DNHCuWq2H2Wxb8AplUBtHI3rxt4/ve0x+mtXNBy5rb94yP15VCIoJMGux7PiUl4COsiYmLyXmTS9Dh/YSIbb9p5AJukJhpNcIJwm2mbHgLlFvCTBVu8gr3kj9OwDhfIz4Oq+BLplr1v0HDUDT+VljNPL5hG3PMGz5rr+3FtAzSKmhXf1n7PPztHy8oOCBEFrH03ytWWRgEO7cL4gg+0zKXjhEGWRjLUZ7qwT7APaYEsShv8VMMVFvWUwyB50Y7cBmRMDrFvPIQKOU4UHheFNaMo2dNIYSTH9/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(230273577357003)(451199024)(64100799003)(1800799012)(186009)(4744005)(31686004)(2906002)(478600001)(53546011)(6486002)(4326008)(6506007)(6512007)(66556008)(8676002)(5660300002)(8936002)(26005)(66946007)(66476007)(36756003)(2616005)(41300700001)(82960400001)(83380400001)(110136005)(38100700002)(31696002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVFuRG1MWEN0enZSeUN2eTFNNVBNclhxbjN3Y1R5eWkvNGRrQXBzb3JhR04z?=
 =?utf-8?B?ekROUEtTRFdqZU0vSXZPOWVKOHJ2VnRiRTRaajh1bndFWWhYcTN5cm5la0lm?=
 =?utf-8?B?M05MQzdFcE9BdktoQkRKRXJyYWdlZy8yZUw5VFQ1Zmw5UURkYTRpaGNVSXRQ?=
 =?utf-8?B?NXEyQ2RGaFBkcjJFMDN4MEMwWHJTQnJXRW4yRWlscU52Y2VTWmc2R09jMlZ4?=
 =?utf-8?B?ZzdHSC8xVTJJT09QMnFuemYzbUEzYUVzYUQ3UmpEeWJPTEJOQW1teWhKazdP?=
 =?utf-8?B?MjZFeVVIWXNIbzE1TUtOQ0syQTUxUmVWbXNYTHJ0RndlQ0dDTHpQOXFuOTVQ?=
 =?utf-8?B?MDdOVHBqdE9hM09mLzZ3YzI4WFVoWU14VE9SMnVUMklzeXo5dG9YMDdqdTJS?=
 =?utf-8?B?ZjNPekl5QUptZGhYU0RSeXRBdSsrZGhTNm1BQ29YVHkvOFZBMllBY0pIbTZS?=
 =?utf-8?B?ZmF5RnVQdkFlTGNuS01nYmxQVzZ1enMyeFkrWE91SzhOTWYzdHYyUWNtUUdS?=
 =?utf-8?B?bHduWGhTdTBNM1lTbjBudjRsUTZlRTZiVVR1cW9aNzRZdEk1MlZXN2Jybnhh?=
 =?utf-8?B?em54d1RwWFppc2RNOC9Gdm10eWFrWkRLRG9sdlc0aUZpa0VIL21EZGVFVXIv?=
 =?utf-8?B?UWNPeUxqRXhRYWZSdXg1RVlCRnpYNEhIaHlRZFI1NVBicjVCTEhVaUpsLzhM?=
 =?utf-8?B?SjdTRDZjWUxXR24zT1ZYbytzVFNBekErTkVLUHJzOHJMY2xnQ0hEMWUvOFRV?=
 =?utf-8?B?b0xpcThyTHNzYWs2Umliczg3TENhUFdoUzBhWWtLWC9xSHRvRU5JTEJOM3k2?=
 =?utf-8?B?N01NcFVWN0QzTFppYnZmUUxqSExTdjFLTGNRN2VLZldsejU2MEhqQS9oL3ZF?=
 =?utf-8?B?d1BxUmhhSUNmRHF4ZnJVVElUT2oraWxBTXROVzZaT2xmM2loNDZ3MVk2cUNT?=
 =?utf-8?B?TlBHRDE1SjQ2N3JvMzNSNS9ONm5qMmlFTEF6Q1Z3czFsam5HeUdEVE5KYzRG?=
 =?utf-8?B?T0R0T1FmZnh2N0dqQkhpc0RyWXZPQlVuMzVaK2hBWU5lNHlYSyt0N0t5cUZx?=
 =?utf-8?B?ZlZOZWorL3A5OHhjVDFZMlMzT2dGVUlseWhsaW82NnhyRVl6S3hWcXRHUG12?=
 =?utf-8?B?eGZCdTBFQUxpK3JFZXFWL0xINFRRMkw2WlJVWmhNNUZ3dXhOWmdaWElDN1ph?=
 =?utf-8?B?M0xGNUY3UHYxQTFqSFVKV3A0VnExRXVwc3p5RUY5dy9qaktRZkk3QzFaQ1lr?=
 =?utf-8?B?NGtHcW05YUh4bjYxWkczQmtXQUJKL2xvcWVaVXV3RnZTUWM4TnNiVDVGRlZj?=
 =?utf-8?B?cllNU05kS0NXUUwvMlFkVjBtclliOUo4UkdjNzBFdlpqaEMrZUYyelFaak1l?=
 =?utf-8?B?WjRQcFViNEozd05TbnZJbEphNkZXcC92MWlwcjVaV2UrbjJoTHNiczFScXJy?=
 =?utf-8?B?Tll3UDJtbDhSeDZjN3lPQXJkTkRsZVJtdzA5WHdwTW1rTC9IdUsrSlo3YWtM?=
 =?utf-8?B?c1hSV09XeHpVa1BHejFEZi9TRm9Yay9SYmhZSThPTUtUSkU1elUzcmZmbWtT?=
 =?utf-8?B?RGt6NFhUa3NkRzllc3pZLzFGOEh5dWRGUWl0Sjh0N2ZSd0k4RjA5NDdSOHEz?=
 =?utf-8?B?Uks1ak5jVXhlUlI4L0F0UGI3YWxveUhURUJZV0lTWGFMOWhpbDdMSTN2WGFj?=
 =?utf-8?B?Q2RpMHVZQmR6TlhDbWc3TW5HOWl4a0xpcS9KSzc3L2tENEs2ZzBMN0w5N2M1?=
 =?utf-8?B?bkRFWDhXc25rMEhrRjc1Q2xIeGNWL0ZXVlJLVEE2MnBRc2hKQTZSK1JKSVBv?=
 =?utf-8?B?UVMvWitvL1JTUEoramw5QnROYUFaTmVkYTlza3NaYncveTR6MWRVSjI5RFVl?=
 =?utf-8?B?K1hCVzBPeVY5amRRK0JaakR6MDE0ZCtVbVFYMXNYWER0c09TSFh5N2Q4NVMw?=
 =?utf-8?B?NGkvaW8vMmtHNEtINU5ZamhicDh3KzZWNUU1eDBJL3BzNTUzamg2ci9TbTZR?=
 =?utf-8?B?SVRueUVSNlhXWDdmNUUyL3dmRjVlOFJ1NThyeXRKUHBwcm01Z0o2aWFiS0JM?=
 =?utf-8?B?NVJRTy9nZDJ5cUQvRHhuL21odVY2RGdoeGVBRlNRZE5ZNVloTmZucVJkdnhx?=
 =?utf-8?B?WG0zV3Q2WlY5RURiaUF4K0N3NU5ValV1TnF2eGsrazJ1UERnSk03OHV3NERw?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df65ee2-97b4-4466-ca3b-08dc2da7c66e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:56:19.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UJJ9YDktGW10kth/83pgp2QoLfj9kFn9D9HLaMCLebWu8yClV8oKI9jeNx40zLOb/m/QIqsrnZ+w6j0T24Mp58WFi37kV2IreSh/QAaYj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com



On 2/13/2024 12:09 PM, Rand Deeb wrote:
The subject doesn't indicate which tree for netdev it would target, but
this seems like an obvious bug fix for net.

> @@ -972,6 +972,14 @@ receive_packet (struct net_device *dev)
>  							   np->rx_buf_sz,
>  							   DMA_FROM_DEVICE);
>  			}
> +			if (skb == NULL) {
> +				np->rx_ring[entry].fraginfo = 0;
> +				printk (KERN_INFO
> +				       "%s: receive_packet: "
> +				       "Unable to re-allocate Rx skbuff.#%d\n",
> +				       dev->name, entry);

You could use netdev_warn here instead of printk, which would include
the device information. I checked a couple other drivers and none of
them appear to log any message when this fails. A handful increment a
driver count of how many allocation failures occurred. I'm not sure how
helpful this print would be in practice.

With or without changes to the printed warning message:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

