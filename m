Return-Path: <linux-kernel+bounces-4397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DC817C74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA851F238BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D574080;
	Mon, 18 Dec 2023 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwLcLc0p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE85A2D;
	Mon, 18 Dec 2023 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702933852; x=1734469852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l7X940QIn+6dyHmruTTx7lx7htmF6VVbcII/kH1rAD4=;
  b=cwLcLc0pYYnMRzKtcQReDZbUfIUfb872RRVST1W8k/JtEk9PEtgqfDbq
   skd69a9QB07tqZ9HgQt7eKMwh0lPwNBiwXsueUiHRCJ1lR++SPLiZzqWF
   jYJuZkzW1kzMjmbe+e6ItCfeoP3+FdoHsOVOfmDZK6GA8Ya88G2OYJPMB
   UO3pPFAqVsOgz4fwiIh27amksZFk7iS6R6RiUJ1+VECQiJm9cGWN3Y/0b
   bLPqoWDbjLiARXjcoplWC+Z3KpMEVGVO2k8Ma72q6Lv+pSU5fofavsFqr
   5CWR0sn8Cb/OweJwBz4fL7o/lSCuwWkx7x9uW65uSog3B0OwpfM16o9Hq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375719512"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="375719512"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:10:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751892150"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751892150"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 13:10:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:10:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 13:10:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 13:10:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 13:10:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYZJGMVGFfbYuu9WIEkZeij1fCGpmNoeEjmdWZRewlx2y3a3WszGnS0a54jLWyMeIEMBLblp10cr2aOipQW5qG8E0LH+my6QCQyvw0HsvxuSzocJ6y/RK/46MQcEjOVIC5IaXQ3fX0+9MGKh82FGDXuO8QTmYIGNpyTihrJr92fXUBBsU1ImAIqi/qNtxWvo+lSi/pHgwLfCagclqsGQa2oQQ4PbSSxygKpM0LGA1+xKNwvaiDsx0dUfsMmzap3Wiclr2sk2LusYieOn8zUfgI6NE3uSkccDxBxDyoWF2OAwjs+gHwPeYBOoWTw+8QU27rCfLiN7qFPzkB0NDlt/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSyTrPnL9RrduV4YyifSDEsklGomNSAdvJMSSOfNYUg=;
 b=bWO2921uWo2Hu4WQK0fz5GuNQboQZVALKVChJTB2cgNGnT7p/j2Wz6BJqMQakqSUjZfoSvqxqxvat4kAjI1DBFk3qzBbOGJFxCYvBeY/toBS1a+oE2SmUnNrSmXX/hJP2c6mLgxC5CkjG4Sv2cMlWTW0icTKOsLRG9opdffH8Bp99GfxnFyg1Zay55anvHPvnCszbwZ1uZ/vY893NzHVId2FQgL+F77jJOg5gv40hR6wHhZjtZShJBg59ZZ/fUulHnDeoUTCn4hJeVWEZQLh+n4f3FS0WElXce29v6j88nKyagkhnDXQqg807wf47iSNiApuHHaz0MwP/9x7i7PFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Mon, 18 Dec
 2023 21:10:46 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 21:10:45 +0000
Message-ID: <c15dd551-3253-4491-8dc1-fdea8e741677@intel.com>
Date: Mon, 18 Dec 2023 13:10:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] octeontx2-af: insert space after include
Content-Language: en-US
To: Wang Jinchao <wangjinchao@xfusion.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>
References: <202312181459+0800-wangjinchao@xfusion.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <202312181459+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dec3f4-6212-42ed-92b5-08dc000dcd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIw2eaMDc9VVjNJmxsCt05dpOmYJ4HVIp1EQbS8EUVGe2IPDn9/YwOL8mKGAtbQNih6e8B87Ifx36tMWGwNGsKn/aiCI7ZQSVZjn2DeSMuGA0+uTrGFKRGazQetWhn3OxyCHMsG9i89uE8Pa15kcNqDajspniE8yvvmpm/UJ5M8oLlOeCSiZDkXXxvUM9B1qyO3IYxie+zlvyOMpora1L5uqO4vcbVwBup+OdUuMHgqxI1arQlIEVvg/KJLx/Bqs1K+WFWTJkzBsQz6/adDIMNT8TToWsaVSzW0Q0bTIHYTNTl4F/MWDZFi3wJRc+8i+z/GlFZBWfb7xAT988Q0qe3RhVvNzJ0XGWHQwAIp6f25KWypygxZJNgAVQHBdtd+lVbBPmBEdHRFmej4G5PtRXOXZDv9DNA1th6ycXPWajxIbkge6avxjsfGdKDlYDLyJLdFJPEB5muoxdgKP48BJYSAgif9ox7g6W14Rs//t983kODe52ttrGm9q/I9i3LZsjI8tkrPwuez09TMVgno5CgbYLrOWPJwq/3mLS6YIPkcGzg9Q8rg4kfZh4m9Sede0VM9I+xiaki5XdQXwSzLqtsz59uCZgQAG33pUNbpvBOWkOVrJ+pt1CLQr/n8pgTDSVSiUOiGtcgyXp39IFwksvN/Lu9h5+OrbOOMaWPiGnqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66946007)(83380400001)(110136005)(316002)(478600001)(66476007)(38100700002)(2616005)(966005)(6486002)(26005)(4326008)(8936002)(8676002)(6506007)(53546011)(31686004)(6512007)(7416002)(5660300002)(2906002)(86362001)(82960400001)(36756003)(921008)(41300700001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdyK29ON3ZLOGNaWDR4R1o3NURQWW41M0RETjNWNGljWUFQTVdHcklPQ2xu?=
 =?utf-8?B?Q2k4bEpLRGpIcWJwdWhXYzFYTUxTZ3dadmtoOEpSM1pQQkFTcXZZSkdDcm8z?=
 =?utf-8?B?b2tTRis5UUdoS2tENisxL3FSTEVORG9hR3Vpb1Nzbkd0NW5Hamxqdkh3NWRO?=
 =?utf-8?B?aXcycTZZZHFtUVRLZ2N6TXBGMEJqOGJRMmsxcndCY2QrY2tyRjRYdTh5R0ZS?=
 =?utf-8?B?OHVObXNocC9EOG84MDFFaysxU2ZkRUI0aUEzOHpjTDlmWWdGaFQ1ZjFrUGJN?=
 =?utf-8?B?ZFJsci9ldExaYS9PSXZZQXlFSmE1dElGYVhsQlI5Z0theE40REZKdlJIN2tL?=
 =?utf-8?B?US9sQWQ2RGZaOFVKZmFIeXVIREJld0haTzJmRjJvZTVvL3BRY2NWanZOQ05W?=
 =?utf-8?B?ODdCRDdGMUhWbzRLbVp6VTNsRW56VWU4eWhXdXorb3BBVzRraU9zTFpCTHJp?=
 =?utf-8?B?ZnJYMWFEQkNPWHNyY2FLV2k0ZXR4R1RnWEJXMjVkUjR2Z0RuNW9aQ0NyaGZK?=
 =?utf-8?B?bVgrd1BOWEF1NUN0dGY4d2UxWk9RL3BzQU16aThGZ2hURGNSRTlOUHN6Yjdp?=
 =?utf-8?B?cHppd1RudUlUMnppYlhDa1ozV05KMS95NUl5RlNwOW51di9hbE9hYmUwNmts?=
 =?utf-8?B?akN4RFhTNHUzVXZQM1RJdVZnZVduOTRmTGFGRjRYVE56d3dFVWxXUVhUR2VN?=
 =?utf-8?B?d1cwS04vb3VDV0ZjbVhtb2pOcHF4bllIT0JXSm9RSUNPSDRzN1pzRy8wUTF0?=
 =?utf-8?B?TkZ3MTluYlhPdUR4c0hGeFlnc1VWYWw0cDh1d0NSVjVWYWdaaUpkWlJtS0pB?=
 =?utf-8?B?dk5UV1dPb1RJQ2NVdmJBWTA4a2pvaW1la3hQTGw1YkNmMm5yNUhJdWJIdjFJ?=
 =?utf-8?B?cnNleTBzd3lGN09LZ2s2VXhaVUFnSGZrczZ4MG4yNWx1TXpSeGd6NkxqZUI1?=
 =?utf-8?B?UkJwM2NiT1hhdXAzVFRRd24zVG9tckFZWlRGeXppanpiRlYxazNYU3R6ZTAz?=
 =?utf-8?B?SENJSzlaTU5VUnpFY1ZHdnNSVm1SQjVuaFN2RjRXaHZKRlhvOFUzK2E3QmhM?=
 =?utf-8?B?NUNpTTZVZFducGtwVnpWVW9yTG1MTmtEUThwcE5qK0x0NEgwWUN2TjlmU2FB?=
 =?utf-8?B?ZjhqcE1uTUtOQlNENnpSUTd4UXEvV3kvTVBPVFQ1NVZwbkhXSU10SHBPSGwv?=
 =?utf-8?B?Y0RIMkZlNnl3STlVR3p0bjdMTnBLb2pHNklSK1R1enUzNHliZThYODQ0OFdo?=
 =?utf-8?B?WEkxMk05ZCtOd1oyRDlVSWlTTjd5L29sWGVrdjV0QzlSa1FPaGtnWnNMUjlj?=
 =?utf-8?B?T1lKT2F0cDFTUTNQTkZQVDZTSGNLdmFyQnFZeFoyemZnQm5YUEt4NnhVR1Zl?=
 =?utf-8?B?TVpVTFN2bGFQRGpXemI4YlBmZnY0Q0ZFTU1KMjRSK2dxM2pZVFYzRWRSYm5S?=
 =?utf-8?B?SStVVWVmNWFyVFpIV2N1K1BPck1YNm1HS2ZVV0RzNk50TlpHR0FoMjhWdlEy?=
 =?utf-8?B?cGtOV3dDUUtqZi9OdThobGFZWEhpd0Eyb3czOUxCMDlFK2xPZThYdDZkb1Qx?=
 =?utf-8?B?bkpzNVJZcFNTK1RJanp4ZGhGR1lETTBkaHpkRjhDZGFVQTFPRnpUK2c2aEpM?=
 =?utf-8?B?eVdXZlhsSjlpWHRDQ1NsNlJrd1NZZzYrMlFwWXQrR0Uwdzg2c0lMeVdKRUpD?=
 =?utf-8?B?VngvdEVmNkVkR0JsZnA2NEF0bkRsS3pZZnVtYVJNNUttNERLMzltYko5bTc5?=
 =?utf-8?B?Um9XbEtaNk9qekdtbTR4M2ZndWk5TWtTcVlOREhpcTIvMjd4UDZaYjRJbXpx?=
 =?utf-8?B?UHZpTElqRWxkRnZXTVM3bUNiVTVaWkt6Y0pIcjYxSUpybDVwLzBoK2x5amFh?=
 =?utf-8?B?MSsrdlRQV3NrME1iWHFqc2F3WXd6RUt0ZTNDblpQY3JabFlGQ1FFcWJiK2lW?=
 =?utf-8?B?bFZTRDhGei9RRXJDMlMyUFp2K0c4TitWWlJHb2Q2NVl5VzhnNjc0cGdnd2xa?=
 =?utf-8?B?MVVFN0pzdm1rSWtCODU0V3poUDQ4a25YcFhQN0tYNmJjb0IyNnJHNDg0R1k4?=
 =?utf-8?B?elNBeHhrVkJCeUlsZHNKNzlrTFB5bCtDanRyOXJsRVFNdE1PWXNORGxSU2tV?=
 =?utf-8?B?REdXU0RPemlWbXhOeFJVWW5qaVB6LzZCZFJmcFRka1BwS1d1Mlc5cmhEZXdh?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dec3f4-6212-42ed-92b5-08dc000dcd43
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 21:10:45.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo8oyjHYjvW9xW6ADhgBl/z0eYHfYxDBAHfenZJXKkOHJUtoYDKW9FUEyMI6ntMf0w2uzZXPReprln2q7/H2QinZErNK7YckG1V4HmuSfPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com



On 12/17/2023 11:04 PM, Wang Jinchao wrote:
> Maintain Consistent Formatting: Insert Space after #include
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
> V2:
>     In accordance with Jakub's advice, modify the patch title.
> 
> V1: https://lore.kernel.org/all/20231215181043.4ed733cf@kernel.org/
> 
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 62780d8b4f9a..97a8039750c5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -5,7 +5,7 @@
>   *
>   */
>  
> -#include<linux/bitfield.h>
> +#include <linux/bitfield.h>
>  
>  #include "rvu.h"
>  #include "rvu_reg.h"

