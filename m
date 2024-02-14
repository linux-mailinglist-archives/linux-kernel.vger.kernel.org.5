Return-Path: <linux-kernel+bounces-65943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D8F85541D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952041C20F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F103112836C;
	Wed, 14 Feb 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmPPeVR2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D71DDC1;
	Wed, 14 Feb 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943037; cv=fail; b=Z/S9D8zbG+DfCImFr8Lk7r/5pU75SklATR9nekQna4gPthD5mlC8eD4A0rw7gVUzVOPtPt6a393QX6/IfrnPBHtrTW3RD42vaiR5idzSWRxwYS9ZYrvuTF7bCDO3/pymFSXb+9AkpftTA1sLV/5Ta8LILTHOoVC1A6uQ4JbYzcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943037; c=relaxed/simple;
	bh=ELy/OaeQAOQ/6P5DXFjulxe3/tkjMcSx4nMhLx7tcuw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ksJHld4IFboe+zI4qH/ltoZDsWHRtZtFiaoupN0e1krsjK4xmltHkhas1RVAmMoekXLQExmgYLlcBpa6HVfj9T2kApVuTg2tWuibHRFfFF2K/Jnq8xLpan0Hdyc4UAnHU91MPOjx/T0JLXShIJ/d072zBAUZFwey7fxe7vBt5kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmPPeVR2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707943035; x=1739479035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELy/OaeQAOQ/6P5DXFjulxe3/tkjMcSx4nMhLx7tcuw=;
  b=OmPPeVR2esJHemOFp7v9MQy5sD/Pg8pgae/zOoxlkew2V1KlUIpWrjah
   hW8ykE4mOHJMCqpMnqD/wWEgq/5pH4ckd1I0ugoVly8ufdQPITPVNBBQc
   Iypo9VGoqLKo25BEuiNLM79nhHO+QCrkJTRcpx+FnMGNboOWqwgitEROE
   lv7BtV5Jkm/GwmWW8tTpZpmjf6D2mrUMCTqCf/vHhJdACp/HmEU8VPZvT
   vSsBy7tzF47QRU1ofrhCKaiGYmi8e59ZeYXSy8mt5WzeR5a19oSFgLbPj
   M3+mzDMcCYnboqLPLqklLVYZ9KqFoRDYn2rkEIopxmsMspwwytQWvKbnx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19425831"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19425831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 12:37:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="40799907"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 12:37:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 12:37:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 12:37:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 12:37:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYlZhsIm0KowAwFa66BmawACILE07rBnVoAZtWeNzCxFDbvr5DgM24Ka8nQMtyvSwsdJMsdDD5odbENlDJqg5GpsSKraLQt+g+Ytj5MDGDP9VdrC4GDcOz5acc4woNEOp8sBzflGILN9Pi3jL9oP/gGFbtr/cpNfugJyuXNzWMVgsRKw7l0/98cUKbugmq+2tCAZ6l/2fZofyaMWdHG7+nVj+bePexpoQ5HtXxH7KZn1BYuKUPwLE4PvI64qk4abHlRm8IMqySfXrqCP5vj0DxtLlADaQr337BQZgrzE2Azybyv8Up2oHo3RbMyBBkSAMXs3CacaIOYqJNUqAzDNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgKFXtyOVLSeqBbQQsDZ+tePgp1L82ZJfHWDP0IgABI=;
 b=mo+ePmHgB5wsCilA/rZHmXV/kMVajhdES8tm2qG/HAwdy5eaNjmkK4fSOgJmzfr90FsZbU4UZjUTu1lo727u3pP/zfE/AFiXCfVf/HmGMHwX2E9ivmfubF1i/FIni5YA8ihcXqBlUK6HtLw5v4CP1U+iETAqZdBhZ1fx4/JP+e4hM5dn5wcOkLaSWRLIGmm0euNoqgm9vpcEcXNSOjie5dXXu1HGBOyZ+7167UYgTlJjW0dkZwMCraxSsgk4ePa4msGgBCX8CUgcmmA6OFSB+7+70T8Xr7az8uwykRgXTh1d7aqWq2g+AObKWLU/tcugfhu1KM88jM4jrWMFqEXy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Wed, 14 Feb
 2024 20:37:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:37:06 +0000
Message-ID: <da0050e0-f038-4d14-875c-158f4bef4981@intel.com>
Date: Wed, 14 Feb 2024 12:37:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] igb: extend PTP timestamp adjustments to i211
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <kernel@pengutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240213115410.415573-1-o.rempel@pengutronix.de>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240213115410.415573-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: b589239e-3501-4de0-3600-08dc2d9cb579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1Y0di6hPu9+2wLed7EkMaWfnknG/fsER9dYwKqDyf5zrpl42wmzdjrgxXLImfaT7PkHBajO5nLjZI+NdMzyJkI9OS47Gk/Z5X2FhW2N6CpClAq+mu7u3Ih4w3UAynBZiYhSxQhFpvzxlPcGgMTtMygDvWhu/Y4rxTz6ZdiBzHvuJBz6UjxhEbK6WDaZWgLL4xQ0zD5F6UlbG5+v8Cmi5l/rm5/40bGmaEVR1Q2DJRfjxFd2/R/gwdCy8NwowMxA8vTtwTycJxO62Fp1GOiwBpX1qmJ8gkTFxq7ej4SN/I0f7ViAHE0W+FDNOtgke2DD5H4XiNaBN8wP6zC/x3KegDjFaCRbt+jPVGAUm7WVA+9Eg1H2+N8TYPuvVDjPc6IsTcJyO6rUYOysFnDCrnKeflc/oT5WFTgz9V8USZUgJs/c214Zp49uRO6I+W73iF7wJi5297qp6iJD5et0G5OdN4ktKOT2KIkNF3Bihg70rHCl3VEZfukI+dhXjQMzuo6gTMZDsOu1lGJMv2gGWpo/ILMzc6kOMzJTanV2Hx0bMrF8E9t8nOUQ2AZhx8X3fLxx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(6512007)(6506007)(6486002)(86362001)(2906002)(36756003)(7416002)(66946007)(26005)(8676002)(38100700002)(31696002)(66556008)(82960400001)(478600001)(53546011)(110136005)(316002)(66476007)(4326008)(5660300002)(4744005)(8936002)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDE0NTdxM2dFeG96Z05xQi9uOXlMMVlLRDVuUlREb1Vzcm9xNUZVaS9qamUw?=
 =?utf-8?B?ZTZoOGNyZHd6UWtCWlkxaEZmTllkSFo0c2xNK2pQVlZmNVFPbkJYbUF6WWk1?=
 =?utf-8?B?d0p4OFpBb2lTSFc2a2ViVEd3OE1TMWk1bTAwbXVqZGVXRjBPZ3dnMXpoek9Q?=
 =?utf-8?B?QXRDVTdjSWZGREJXeEQxUUlHMlhWa0FDTFdtMk9KZmVLSms1eGRNT3M4SWJo?=
 =?utf-8?B?SENJMHJ4L2M2aE9Jd05IajE3ODNQYXJPK1cvQmNaNmlzNmhXVjkxK2h0R0xl?=
 =?utf-8?B?ZHJnL2NkRHlHT2c2cHhEUUk4RnRTbXlHRXl2aE1DVFBRTWR2WG9WQzNWVmpT?=
 =?utf-8?B?OUNSb2d3bTg0cCtTaGFJSXhHYkdiK0tLVGpKcXpIcW5TRG00M3ArZ0RXbmcr?=
 =?utf-8?B?U3Q2MXcxYnVlL1lKTlpSUm53MlN5T2wydkhEcGxHM3duQ2E0VUkzS2Q4bVFj?=
 =?utf-8?B?MFFXTUZLL1NKb0pqNFhaTjhjOTZXYlhBOXBSUkZvWmVkTmhyaFRxdEtab1VX?=
 =?utf-8?B?Q3ZkMm9lbzB4RWxUM0kzaURZQnB2cGNrcnNvK3BRdDlQTGJXR3AydlRrcmdv?=
 =?utf-8?B?elFhdVV6Rjl2dG1OaFBNYU1LQ2dib3hBbEZoV2RLajhKdzZlY0szL05XS0JF?=
 =?utf-8?B?KytiZTdDYU5LWE5yZUVrVUx5OXl1QVVqSGxrdjRXaG9BY3NGdFVXY3BQc1dR?=
 =?utf-8?B?V2Jkd25mQzcxMVhJbWJscFRoT25vNVRjbkk1V2JFK1JvUkNWdSt4R0RhdkdQ?=
 =?utf-8?B?Q0dxNmpWS2RXUmpkR0Nka1Y0bS9iTitZZmlVZE5FT2pMTTZ4c1g0cnBFZFJF?=
 =?utf-8?B?bXBja1NLV28vT2Y1M2dwMzgvd3p4WVUwOEl1Q1ByM29HUzhqTmtCV1Z5V2sy?=
 =?utf-8?B?UVIwVXBpTlJscWxRMk5yMGhpZ1ZhbXVGczBMT21GcFZ2KzRXR29VZVIrekR5?=
 =?utf-8?B?cW9yMzY3WXBVNm5zQnFET09TMkpvbnBKeXQ5SktwRmhBZnJvYXFiRkluYmNB?=
 =?utf-8?B?RFBtNHVXcEw3b3Z2M2E2QUVESG9pMUkvYWlMaFpnN2tpTHJXSHU0YzBHa2NW?=
 =?utf-8?B?ajNXSHBydmZGbHV6blREVmU4N2tBWTgrYitiaFVjM0xmNCt0djNOb1craThm?=
 =?utf-8?B?SXN4aTlzTmJ6U081b3lMU1doM3h1ZFVsbjZIS1JxTTdTZ1RsWXFuRC9rTTJQ?=
 =?utf-8?B?cnJjUE1LQzVha3lDcUtnSnJLbk1qNG93SzFHZWNLLy9WUndSMlBGS1dhVU1F?=
 =?utf-8?B?UGtzZ3BqSUNzbERnaXRhcGhXZnpIV2RqSXk2Y3ZXS0RiYXFWV0hLT2RrRHRt?=
 =?utf-8?B?SEhQTXc1dzEza1VqbmpmeUdud3pBaVd5czdWWVBmZnNiMEMxOEU1Y1RUTVln?=
 =?utf-8?B?V29ydXErU3FObnE4cmJmTCt4bGo0M043L2hUekl2Q1lWVXk0WmRscnNETHVP?=
 =?utf-8?B?WWZ3TzYrc2VqSklUYy9XZTJuaUQrNFRjVTBuYzQwQkw0WjBoYnhHRm14ZnZU?=
 =?utf-8?B?dXhrakhiS3RjaEdsOFVSZ1dNVUh3TTRDdnNFeDNTeDdqV2NQeUZxaUJyU2hw?=
 =?utf-8?B?MzI0dStEcjRhNXJvUVZiR2FTWUJVNlQrTENrQzhuRWtqdzZWSCtGL3VXVGJw?=
 =?utf-8?B?ODFDRTVoRDl5Q1Y1UFg1OUNhamplSUgzQVMyYUF3K0JmQm41ZFhsZmtUZ0l2?=
 =?utf-8?B?TGpJOVU0R3drSHlvNW9HaUV6czArbk5wMFdKYWE4TS9BTE5WWEJCOC9kcVlE?=
 =?utf-8?B?d01rcnJocUEvUDJqalNhNmJNaW9yK0lqeHdyME1QaFp5Y2lLcGxIbVhzdWlx?=
 =?utf-8?B?ekdYMGdjclA4VDJPZHZGa1ZYS29wVkZrRjQ3LzdsT2gxM2F4Qm8yZkQ2VTIv?=
 =?utf-8?B?UDNIMW42cnY5QzhrWkp3QmFCU3pHeThSMmU3Q0Z1a3IrTUJlSytjOWVZeHoz?=
 =?utf-8?B?SVRFbnJhTXRQQUJnaUQya29nS2QvYmVBQytpMTJqdEUwYUpxU3RydnB2K2pS?=
 =?utf-8?B?Mms1bXpCa0E5YTgwTFZjQmFubFptTDUvcWxLWUIrczBUeEFBZnBEYm41eEpL?=
 =?utf-8?B?bWVQbnViZEp0clBhaGxnNTBGdU5CRVYwYkpFNEIzMWpEMnhNdlRmcW9tc3A0?=
 =?utf-8?B?RURLdDFwOWkxYmRubVdINjBISU81M3pkV1NzR3ZNVDJHTS9LeWRtT1VXMTRN?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b589239e-3501-4de0-3600-08dc2d9cb579
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:37:06.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO3f9dlMhYff1nfYKZIxIUnW10k1X0HDit6EUsXmUMnVdjxiTQNVQnNCc84mH61Fn0H5VaYYacQDN8WKfBdCcMfIb6QJCiD5hlZxl8+/0Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
X-OriginatorOrg: intel.com



On 2/13/2024 3:54 AM, Oleksij Rempel wrote:
> The i211 requires the same PTP timestamp adjustments as the i210,
> according to its datasheet. To ensure consistent timestamping across
> different platforms, this change extends the existing adjustments to
> include the i211.
> 
> The adjustment result are tested and comparable for i210 and i211 based
> systems.
> 
> Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

