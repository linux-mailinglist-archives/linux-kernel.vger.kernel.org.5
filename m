Return-Path: <linux-kernel+bounces-109084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4879881474
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DB1283E25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6D56B6B;
	Wed, 20 Mar 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLnQYrEo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AA5674D;
	Wed, 20 Mar 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948091; cv=fail; b=SR4LF7t6RGmv2VvDETpUO0NleP65wkqkMn7GcH3XtehutkAuECnO1qTPovt3glKuMXzcFOI+hC5pOq2LogWxKrmJgwlEM4/hxkRhJYhAb4Ohq5g7rz4tdO2IlL59I13Wmpt+td1T5jSOmtNU8D/mCfU2w1J7mg/Yu/SGknCrsBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948091; c=relaxed/simple;
	bh=jeqFqA2tzULbagclxPe9+Zw8c1A0Qz4/XQIN/nYi424=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ueecq2xZXkCp+bXFiNDiPP1/TNbraH8TsJofA89tEucwf3PPsHN3DjL2OBOt7i8NbUcVOc/BYdaleritCdHZxwQ5QinLmlG0z2AkAW7xwBpuufOeVcgU2EDNTHIfhUxCXAaEmBDIanl5SzaB/9kTNVqUYozfhgMT6twvyQmjupY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLnQYrEo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710948090; x=1742484090;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jeqFqA2tzULbagclxPe9+Zw8c1A0Qz4/XQIN/nYi424=;
  b=jLnQYrEo1M1xxGbCCdKfoW52ECQna2tJxDlZuus/BtSwQEi+wi3ujTH/
   W7muf/scWHHoo7mcuzN34n+0Un/IlLGZiSLk3+tSPGHUyZPbCuXCajgud
   5Mv2UES44+Ii81U5zkPCku1ibDi7X06vK/NvdGdoM8XXXGrtldCTDseqX
   64VT8qJ1HKLb04Ezdec9oXQ6dNwwG8cwR0pvtLKWiozEv7KJjL5+sSCL7
   QwkFbUiuTFDEc0//phOTf2N3qLkfOjn2Rj7ft4e9Bfzi6H8nkRdQkN0nx
   OF8kLO4nmJgAdJqJwGPmERUEzQimLQq79wYt+pi2eWROyNf5AGPO5PCZI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5754997"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5754997"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14582546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 08:21:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:21:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:21:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:21:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zncf1kCA4Y/7Iq9BD0HkY9EtsbCUXtEy3Duw6H3zrpaiw8HnmdQxhNup0jRkHYuPRSC58gYShgpPvrzYq1OyTWZ9mjf/S+HgcfVf2PtgJa3IuQr25MRiDsuX+tE+rHmJ2xWgAED09Jl62rrj4peCvlRgPxN8Y2T5HQXesnah+OI+5+ItEJUvT4zY1oPP7/197C0sD3tnYydJHIfHQ9fAJGqWA4AKFAiWUVkcybHu7p9xB6A34XHpOASY/lojqXL8Ry/4jyfGE7FLtr8BzTPF8402a5Lyews+sfJ+BhIe2YBF2jlmCzMGfQA+prDtwwJUs40JpfuQ10eRIRcYOXQrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCgRmfCXYU0s8qtVAUYHngX/CgkiNVVqAG0KxdQlrZ0=;
 b=noHN5ocDrkAzOJvMCTZD73ac8f2SEP17v7EAdWjuQks7iIoVv8TCkVJ4bGiXq4lw9dbY8dIzt18TIZ07hQWEr9OH/sgbCwUbcM5FWlcIaBC3aBTKlbMHCKbfZzm6oUZgJRIlkgqaweBFNH8r+YleeP6DifVc6Bkk2ENSF0bisbT/4mW1NQhPyxbphoXhCMpptkzzODn09iLQUhKCrHQ87vY2uaFTinxO/hygiM6KYmAYiGf4qYtXd8Qr7sQHkwdG08okl/DmcViGPNAO9crtEWrZTpzrmxiIAwrv/UdbmtPrUe/WJspPhM5nlZUEIXdOVFukfKIyA20LD4Cvb1G34Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 15:21:24 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 15:21:24 +0000
Date: Wed, 20 Mar 2024 16:21:10 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <5vnrboxpkrriiqcbwrxtbextu6pduqjfchlvsdn5nwe7lr7vou@dngffvu7a5fh>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2f1969-98cd-4f0b-8d39-08dc48f167b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy6JKJJgZrSY3HDi4J+iqgVQqctK6+kbNHudd2osvgaI5wznIaPrVQ7WUHb0IZsWi2PR1kNP7sYBk+WqHQfbV15DdJRx0RgE+IRKmuy1Vh5DENob9DzKeDp+FbueZgJkDkHjquzx41FY/1nIy64xfWyfDDys5mj2/Bwy1z/ojZn7hcZUNGP8b6uOtZb6nODBjYYwHayo4c0sPKBOVHYB/8rM9DqhgqGGQIV7iElMOzjD5z9/fWNov3MBS/qWvBG1vzkO9mprP9+Dd+8Gob0tTuOqGQqqEfeIOIIQShZaaTpI9Ke6mTdR9kyJRjX2uJnHCy3gZn/HpRuyvZgwJ3WyptfAXtHUlgsI3E2z012XG8gLrdFTePuZAiwyiOPdg7LE9lHsnfXkYZnSAeNAyVcU3RGA1esPg/c4oDFaJd1t4ZAFYvwKfML/kqABsMAdEBqMOTbu4TBGQAOwAw05bTBsDYiac5u3AOe3OjOoLbmBxkCPbmvvNgyju4QFDA6zdPKkDEwx6EYSRj8x+ZWDCXkH3zM3+59VA70WEfddth5vo3/yd2uCF/sUN7IaPVCwSgi+EbGtmxo6tMVnz9yM1Yc6vvr4hF3PMsYn30dX1e4F+Pa6dpExL36FvXTlhoxjV7/0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AFhLG2GPMuiFMnrIsmfBrB1Gf1XzFkv8DsY44xg5JGUoJqbC+ML4JdQfyN?=
 =?iso-8859-1?Q?G76xQRxK4hLZInEUNoT4zo0SPagp+S3bCAOH8cuzkXeMh4kAks2/Q4nt8O?=
 =?iso-8859-1?Q?vlvmQFmscbInTwsBefQR4GBQJ4Uwp2SPz8zExhevFS2XD04d9LmBHpKyJV?=
 =?iso-8859-1?Q?rh1LwV9xckVduhV45HivYDhyRuXGUGf7ru6qcyIlO54INAj8dn77Ip3t7P?=
 =?iso-8859-1?Q?lQk+UD/TQpLmz5MnLsV3mnSsLzPeff4/ID/Q/MqySrBoxE6FpL8qg+F8HI?=
 =?iso-8859-1?Q?+Uf8S4prRiGoBLFKKbpZjQxff/s7+uCVBvwuoOft9pCd7m9yFfS7hbbPL6?=
 =?iso-8859-1?Q?3qCH+1Lv5gCTNlfLBM25UPODxF1B9m+le0o8SBfQWuJocTrxLcfotTSvX2?=
 =?iso-8859-1?Q?y6ah457RL38fsxjZorKteUQU3ihzwqMNpiK4pqCc6kUpDay0baK8sTnm3w?=
 =?iso-8859-1?Q?AHyzuf4WfqLegLrul/tzWsAKUTCXER5JMpIJ/gknMr7xugtp9KJ2L3N2+A?=
 =?iso-8859-1?Q?y4D5mkO4bV3iCFERSO1itPivMJUXyiQQ0d8JmMeU1Qiyk0k5igC7YF2Qxw?=
 =?iso-8859-1?Q?2ryqByaSEu6GlDiyw1rlgHI/K09rn+6oc0AsqEO+BsnSyqDMEKST1TvMsn?=
 =?iso-8859-1?Q?Ct35HhvJakAyMG+6ZEWPES4uR9abyQV1SOqEoRieOZJ8InR6pT2V4JunZo?=
 =?iso-8859-1?Q?0+/j8cJTGHCCPkCp43x1bCTKvjzgBO2mcNuI1Q5aOpIAcoQii2ryeJjHtp?=
 =?iso-8859-1?Q?e0dRJbLb7Nv19yQsNPAWcCVcCCRPWoAvK/v1jJ/1JTIa+YDd30eBmKNwxp?=
 =?iso-8859-1?Q?QcCGYNb/9OC7CG3Wm+EJdda9ArTFOpfPwh0V8lcCRnt96ETASILO1sC2lP?=
 =?iso-8859-1?Q?OEMDnNO/pzJsEK+QMYBfHyOhvHdddzqf7S72U7KIEbROPboJ4iQrCTKMUl?=
 =?iso-8859-1?Q?UErMgi0zunIZv17oTU1izA8XIvDeA7oQ67/cfEY+LCakLkd1YbMnizOlM7?=
 =?iso-8859-1?Q?stj/yyhkxBBaCO8ist5P0Pn2uDkDeVYorGWN6uGSAtd6aSeev5KBoPJlwR?=
 =?iso-8859-1?Q?hxxmuVgQgZB2KcoZXr8KOpA90PlCDlBK8jQ9yAtLmcL7z6Y1Bmg+aoP1br?=
 =?iso-8859-1?Q?OY7H3ZzVTemz86nAebDwNRVItgbDjXCWJtZEsDfB4uMy/nru7Z96TAM11X?=
 =?iso-8859-1?Q?sSQoC7a76aRTlBIykyGL+kUrJQM48M4ZMLdON3584JDMY1IMJ0niYJocL5?=
 =?iso-8859-1?Q?cPmMoiDEA/+AHTvFqle3H7X7iDWad+tZ54Y73F5D01cxVkkc9qGVPuT1l2?=
 =?iso-8859-1?Q?mHy3hVpU0MXXcCCVV2SphTL5XRh+C5IvvJdNFFDg6/JwioUM/9bg3hFhkF?=
 =?iso-8859-1?Q?NLyka+UB+Wt3c4IYDcVrCdQZm85Ftz/MHS7pSjI/BMoOu/IffAZFqU3A7B?=
 =?iso-8859-1?Q?C3dCx4G+5t0Wf52kklVhpDrC+qMDsgNIvhnk+ZFPRhZad6/SuR4sxqETG3?=
 =?iso-8859-1?Q?Vt3o+6smZKXCOUKwQmn+nViDYs3KtUN8xzhses8JSO/iuwgJ5p+axE0q6K?=
 =?iso-8859-1?Q?GWDOvfRobtz3lc3ergj2RS6wkQRiksnivWBGtBcUDVKvohlJWf91qx0vFX?=
 =?iso-8859-1?Q?x77fr+aGpIQvCBXIMLRMAiDOcaZEseNdEb1aboKAnkpR51+AWyP2/gofSa?=
 =?iso-8859-1?Q?pEZ4JBPNrF+DsCAdbrY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2f1969-98cd-4f0b-8d39-08dc48f167b6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:21:24.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVvYAr8NftYtoO7j63d0hODlPej/uuIzzZNfrIIt1q9M8IoVKnlBWK8QYdzaoMP3xnDyvDRpg0BnBMBsKfn6nUZp0pxOfWHbJxwkZag8k1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com

Hi Reinette,

On 2024-03-19 at 10:51:14 -0700, Reinette Chatre wrote:
>What remains is the user interface that continues to gather opinions [3]. These new
>discussions were prompted by user space needing a way to determine if resctrl supports
>SNC. This started by using the "size" file but thinking about it more user space could
>also look at whether the number of L3 control domains are different from the number
>of L3 monitoring domains? I am adding Maciej for his opinion (please also include him
>in future versions of this series). 

By this do you mean comparing the contents of main "schemata" file with the
number of mon_L3_* files?

>Apart from the user space requirement to know if SNC is supported by resctrl there
>is also the interface with which user space obtains the monitoring data.
>James highlighted [1] that the interface used in this series uses existing files to
>represent different content, and can thus be considered as "broken". It is not obvious
>to me how to "fix" this. Should we continue to explore interfaces like [2] that
>attempts to add SNC support into resctrl or should the message continue to be
>that SNC "plays havoc with the RDT monitoring features" and users wanting to use
>SNC and RDT at the same time are expected to adapt to the peculiar interface ...
>or is the preference that after this series "SNC and RDT are compatible" and
>thus presented with an intuitive interface?

I kind of liked this idea [1]. Hiding SNC related information behind some not
obvious text parsing and size comparisons might eliminate any ease of use for
userspace applications. But I agree with you [2] that it's hard to predict the
future for this interface and any potential problems with setting up this
file structure.

[1] https://lore.kernel.org/all/SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/all/7f15a700-f23a-48f9-b335-13ea1735ad84@intel.com/

-- 
Kind regards
Maciej Wieczór-Retman

