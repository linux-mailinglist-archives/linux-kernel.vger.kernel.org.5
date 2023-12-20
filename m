Return-Path: <linux-kernel+bounces-7615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031EB81AAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2856E1C240A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDB4E634;
	Wed, 20 Dec 2023 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDQNZO1n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1224E623;
	Wed, 20 Dec 2023 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113286; x=1734649286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sPG9Xxmq3FxkOk8vsOKyOxkUjIQHPDhhAs/KrqnO0u0=;
  b=HDQNZO1nK6e2OnynrF0CzXoYKnNSppWsDAinFegXUIb37AoioXSlHFkg
   XhaoioipT0M7AffYdVCoWgEkXtzGuelhylgf6EdyXTvpYVxgxVTGuMVK3
   WY2lvHmvF8f43fmwPM+wx9+oQ8ILsK8o14mUXL+HuyYXtaLonD/shIuIe
   xIWwe4jwluGcwkOLeaS77CfrxAUIfP+hzwgv3PhE7fJfNooDTL6GeD5yC
   BgwdpJjC8ayIgbMpR4tCIzvYHSWbIWviTTOzqAENBZuApPThDoo7T6l3X
   s5amP32e43iXMx1iAodHwXQmc8VuswNC64r89RO37uOeexeUC9rJTEnYH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="380875628"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="380875628"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107877709"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="1107877709"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:01:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:01:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:01:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:01:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:01:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1/W1mp4dX0T0XMfGbzEkUYnG9mW5rY5gmjiAQltG4jyqOwScA0rmn3gQmverkaCOCvbyE5ZflRNmtzLfu6JhsbX+fNwr5sPB0BB3Kbq1q8O/YwHAO6ey/l8wKRAAVDbY7n5866WThxRgj3nxsi7zR9VulFEC1OfxMtX4YYzh0xj8ggNSYoGHvKPdKOVyq14XaVNCHc9ZOdK8nplxFu4dHfcIev8jU38jd3xOw93cxaMeY9l4Re4m1U/GaI6jMW6URbzN5XnvfHQOJL91GOwshHYwYzvrxiyaIlSnRedRvP6PbX7vt0umyaQ9sxpZUk4hfmX1yHck2jANA087Jvq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnSdjSHlyNQ0jrwmY/DDHyM/TFPAxQab/qqioG4LdWs=;
 b=VMNUJCrXpGu0TZs43T+AXKzO7CPOu3QM4thLGl8+zuV8qOkDfjqW2YIKxRIpCiynVexj6ma3RFSxypP4dNFPVQ4VoSHOs1HQMJdeiZ7jMD5xrDAhUMcwcoWowkT2ZVBUVageveeFHldUOWNWlFne/u8sFjUIu7AF2pV+fmp33E9Ha7+U70R08xWe6hNaRIfKeXGv0WMDfOgrMZtDWYoAFRjdPR7lFwChPaR98/9QS4sa04mEktDTfn9m0XRMEt1cscN53MirdVey/tgYgodq3MAJ8uPBNXDzMALGKbvZMjG8mB8xhFCxLXF5kmSj5mZ+wZSjCkfl+z2mI/tfgDqZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 23:01:18 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:01:18 +0000
Message-ID: <530f5c55-969e-4113-87ba-02a6f8ad31c1@intel.com>
Date: Wed, 20 Dec 2023 15:01:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/12 net-next] qca_spi: Log expected signature in
 error case
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-10-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-10-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 586358b3-daf7-4b58-e0db-08dc01af9374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJuNLAyFbNfUCXqBnPXpwlITtLyS1NSgfrmhlHbwh3VVFNBAZ7p4xsT+6vES/tLFBFia1DED6T32saXkuBhTNka0ZiEftR2krsfA/LHwVhBwx5iCcBDympVn9U788/RMbeUNuZXD1zOd1gfOC1vkGTtLkktSMfug4kJIYzRQY5Xj8ij2dO1KGZpJZDuuobA/f+rQmsrJcAqw5FEDT6k+dA3f2oO1nBsXRT+G4fX8ZmmoqMXK+zFOl72b7RK66D1YRvGxkpmyvsp0DsH2JPa3CSVHASLtFGncuPYCvWeezx1gakVW/kIvcRk2Vi/Fpp2w0QjE4TulVxk/kAmc94Fk4HM/1gGqmZGyAMXhjt0M1U1hUrLVotgzqgS34qvYEoTOjKI2fTwbo9lgYUOROMgb7rBKyelEoV2tUIeudIv5XuSnTvxyu1AkySGdTllPVtEo8ETXgykHMa9X51fFp2UCZ0myHPPeRGIMkroNAVsXooTIzG2me40VnEodWOSjcWFZfCbqJ3TS4ZyZ/pLe0z+ZxD8wzZ7kkutRjj1e0OjSqtKHLgOnyRiewe5Bdv7NJYpEAXyiYioc2nw3l8bj6zczvA2hiG4hHxA7dNXfdIO6BKU2Wc9efg9z4M9r3nBRWbpP+RrJuGMMFAl6QgyFxP5qVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(316002)(83380400001)(110136005)(6486002)(66476007)(66556008)(66946007)(2906002)(8936002)(38100700002)(8676002)(5660300002)(4326008)(6512007)(53546011)(478600001)(86362001)(31686004)(31696002)(6506007)(2616005)(41300700001)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktKTVZxeFIxWEhEOVRkT3EwK0dwRzhrK0ppWXh2dDJSRTdhZGZyUXp4TTcy?=
 =?utf-8?B?Uy9iL25vWGl3bDVYVW1WZDlOWW5Nb0JFeDdBTnhMSlErcWk0TWxUZk5OOXVx?=
 =?utf-8?B?cTNKelloQVNndkZaZXdhdlgyNnBGOTlWRXhrQWxjT0NYT2xnd2V4bUUyc21l?=
 =?utf-8?B?d3lxSkJiMEp1VDN0V0x2R1RqY1pPSk11ekFUNzJyZHVjaHREN0NUcXRhVStY?=
 =?utf-8?B?QWdpaE1MdUJGeEhjMWhObEFNUnRnZHVKdEFiUlFSVTZVMVNYQVJOTE9UQ0Qw?=
 =?utf-8?B?ZTB5TzROWGpNNytkelFhczFuV1ZxVjZxSndXQTlZV3l4TDB4V1c5b3lrOVVl?=
 =?utf-8?B?Vk54VXFaV0lQQlF2Z0VEQXI4TFJGWkxtMDZaL1V5S3o3dmpsQlFleC9GUGhl?=
 =?utf-8?B?QXV4eWhzQ240N0U1SGdIcWhKOG5DUkdmQmF0R3BpZks1NVZqQ21tamRWUnBy?=
 =?utf-8?B?VlIwRXQ4dDRFeElCaVpJSXUvbGNJNkVYSlVTOE5KWXFQbklZNG5kQ1lkcTFK?=
 =?utf-8?B?OTlTb0pZM0IzUlI0eDlrejUyQzhCRzZPSVVtbGh0WDNhTkpHbzdFZXByQzBs?=
 =?utf-8?B?MDl6ck9sZi9NWE5mUVdxMXkzTFhxalR0M3FiOVZac29sZFVNcVR1ckVEcWdX?=
 =?utf-8?B?NTlKZzBiMVVwL3pkaXp5aSttWW9tYmU2QzNyaVVjVDhyWU42M29kc2dKK09t?=
 =?utf-8?B?SCsyVjhyR0t4aE1oakk5WGYyY2ZuZEQ4cU9LRDJrUDZNd2VQRDZHQ0E1Zm9w?=
 =?utf-8?B?QWZMNmJRdCtKWkt3K00xTERXZjZQSFRyTWxtTEhlNlNpSnRYSUJOdVBJWXdu?=
 =?utf-8?B?a25lMExxclNNU2VlVDJ5S2JrSml2bTFWdGFmc3h0MnBSNGY3ckVsWnpxTlRG?=
 =?utf-8?B?WlVsbk9ld2xvbTM2VTYwY3ZvYnNpSWJ0NENuUWNlNkh1R0krTG5tamlKQlcv?=
 =?utf-8?B?NUxTME1WaG9vTmtoOUJGVzhQNXZ2Q0VRdVdWUEtTRjVzbmpwN09ZcHp6aDBP?=
 =?utf-8?B?Ulhxdi9GcnhIT0c1N01xc2VFNHNCL21lMVFSSEdZbXRuZSt1MUVLYm9DNVZn?=
 =?utf-8?B?SWsvRDlOSVFMcVFuU2VRQWlHSFlUMVhMQnVtU05OOTVscmpCeklUUXhPU1F6?=
 =?utf-8?B?dFpiUmVlWHBLMU51bVRYcE9xb3VDcjNycjJZMlhaL0hrZkpkdHBjV1lKRGRE?=
 =?utf-8?B?RDkzTlByRUlGakM4WWw2TUE0MEhZRFJVSWkvMlVvcFJzOHlVOUJQYlQyTmVE?=
 =?utf-8?B?R1ZFV1NTY2tYVE9XZGtlRWpRR2p2Rld6VExaTDdlbVZaaUZwNVFFNHBGZXBa?=
 =?utf-8?B?S3NCYk42a3h2emRaNVlLcGZLSVY3UUhSUGxSU2k3UThMdW82MkJIMFlyZm9l?=
 =?utf-8?B?dC9ZeWMxdEpMTldLdG1sYmRFQi96cnV6emUxcy9Ma29rSExPTmUxUGxuTmho?=
 =?utf-8?B?SERyZm9mLzFiWE01cS9jTjQrZ20wcTdhb29KU25KVkIxbG9oVGpDVXQydllJ?=
 =?utf-8?B?RGFtOFQxemNpZ2V5aytlVVZrM0U4djJiSERlME1MdmFGT1lUazREeVV2azBB?=
 =?utf-8?B?blpYeDg1WTBKVWsyWVlHRkQzTUhWcmJwaDNzV3l3cWR2ei94Rk1CSXFYMTBl?=
 =?utf-8?B?OVdkellLaHZzV3ZjOFhRdjVhUmVGTm4za0x2YVNJb2ZuaEMyT3NDeVpZMHJu?=
 =?utf-8?B?VDBqOFJ6TnlWbWp3WElWSGEyc3YrT2RCR0V6RGphR2RsWlVKK1hJSllLVm03?=
 =?utf-8?B?RVBUNmVFZjhHUGRLMzN4M3JpSi9yTHIza3U1TGZDUGhncXVTTzhSQTZybjRG?=
 =?utf-8?B?SG94TDM2RWFBZjZXRUZOY3BZc1dsbmNzanpsTXljWmQvekVFeDZRa2lZTlFp?=
 =?utf-8?B?cjJGeDhmWFd5WDFjejBsSXB1anRMVFRKL0VxNkYvcFBkTmg1eFV2UzJ3YzJj?=
 =?utf-8?B?TDNoenZZNFpVbkdPZTdtMDR2YmpDZVNucnAwZzZKOFpUa3AwU1VubFhTamRv?=
 =?utf-8?B?RlcveEVTVW1WQnkvcnZ1cUVYcDJVbVY4WDh3OU9oUEtZQnczblFGeXZvSTJu?=
 =?utf-8?B?K0Ezb1JIeWxidU11aW9jWGl6MlZ3RmRrbnVSSnhJbENIUlRwbUJKZVVZanQ3?=
 =?utf-8?B?aWFaR1k5b0pJMnByVTFwcmttUEpuVDQzUy9NQjdPZWo5ejc4ck9KQ0JMNWsz?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 586358b3-daf7-4b58-e0db-08dc01af9374
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:01:18.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnlXOjsM6qmlpu7ooniTMFLzEqA/rCIWw4oJnq2y3DgpBpSHfBX/UsXcTxkl+pFxNyC7lCRTjclbN129sQg6Rtr9zCrXN05EN21LQvZP4jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> Most of the users doesn't know the expected signature of the QCA700x.
> So provide it within the error message. Btw use lowercase for hex as
> in the rest of the driver.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
> index 6d2859aad921..c5d240fe4146 100644
> --- a/drivers/net/ethernet/qualcomm/qca_spi.c
> +++ b/drivers/net/ethernet/qualcomm/qca_spi.c
> @@ -1005,8 +1005,8 @@ qca_spi_probe(struct spi_device *spi)
>  		qcaspi_read_register(qca, SPI_REG_SIGNATURE, &signature);
> 
>  		if (signature != QCASPI_GOOD_SIGNATURE) {
> -			dev_err(&spi->dev, "Invalid signature (0x%04X)\n",
> -				signature);
> +			dev_err(&spi->dev, "Invalid signature (expected 0x%04x, read 0x%04x)\n",
> +				QCASPI_GOOD_SIGNATURE, signature);

Makes sense. Helpful to see whats expected vs whats there.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

