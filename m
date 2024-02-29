Return-Path: <linux-kernel+bounces-88675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F586E51E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CFA287EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712870CD9;
	Fri,  1 Mar 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ng3NFAoW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524470022;
	Fri,  1 Mar 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309845; cv=fail; b=FR8JVq0X9Knn5jxsxNfv63qkXUgPszMOJPlyX1wFIPtUJAOrFEoHr09p+f5UwNaw8961hrn9IncvJnhOcRUGuBdyAyzlwAqaCGdQVsuZbRmK004MXgy+zwYfLIPsXqFYGDjh6f2hW9qZGOM7R4U05dYLfi957rMPUV1uAfGMvFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309845; c=relaxed/simple;
	bh=YIVFbG5pw47tvUfR9mDhxAhDVRejHIMerdrWd2MHXEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/8jtE4RPrcpb3FrDCdD8dSP/QzTaLXscUjeVaPYtI0Q7opooGFa5XCSbNzk+RqVa3qNpi4PnfIcYCJSDZ4os7UAWGfFmGFUlHpcqsPKg8gYtqE/hCQyOb7n9Qia9DD136acLzQ4dLtDvE1waK6iRCe9PEcM7pFXSLDECFtppVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ng3NFAoW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709309843; x=1740845843;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YIVFbG5pw47tvUfR9mDhxAhDVRejHIMerdrWd2MHXEM=;
  b=ng3NFAoWtN1kMuHgxg4tkYpylxxQ16DUIUlofOos4b1U1UsHspTu4tLs
   1t0KsTaM9xPpNNFnXhbyW6ihRDN/a77H9UcE2lt29FH+UeIz/UBTyFwlP
   9ipa13psIo9SyGxTUQXwNar/EGcROn0fvCWwqqa4RpM3eiSASnmNl92xu
   bbgxLS6IQ4UznmOxpho/1/tXcBV6xaOw73rwn6NoEVhdTPIDEgPYMIQdR
   q87VlKqPz5NdVaXMPPIjLgYgbZqA9UnLduwC8oWpZ+Rv9ZV87faYbzMCG
   zS2te5KMlqg8NrWkFSX+6J3ad92vwhrUue84e/a4dyGyGJzqjJLrrKzP6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14494409"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14494409"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="45775106"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 08:17:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 08:17:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 08:17:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:17:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d13fCZ193B6x3Rq//99NX3VXqBC1UdOqjpTVBFCGZs0gNzvckG7GiCSbreRSwbc7N4W9QSwcSXOv4Avj2Qjw0Hirl2xBnzDihC5/GnCRbvoh93nzybcsGCl8NbtPj05lviS4z6ulMytXkwjS2nY40DrBVDlkbASNm4uhYvp11j08IyBUduhjXHuL1ocFM9MeA/3V2s/aqJLib1tO4GIWSKSwaRtachateHJFsG4+hybxwDdqCZxM7R2jHmEDme5ZElVNAw3il27rfpvFO9oaOAHrqeXChmOidPO6TJTgb7iQlovYIpFu+omnUTWNPoRN0p+nODCzNGS4ofmXiwLu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGDW/PK1AFSvAJzrLd41YuetxEd3/80T7qLvKrdQrsQ=;
 b=AJZU4h52jW1XEeHOOtX3XlppafOq/DZUPpDHuX0DM0BcKOAvybzJBTJAxSZeo7+iZUkSUu+WQROV4JeZppV2Y3Mzilcq5aujT5VW9o5nHpbahwAnbrsKL+KKuS2prFmkV2fPlHujNwYf7YfSiYlED/mvq0PIfXzdrkJWd9m5ejo3uToQakC/kIXvIalMWuYl6DfEHerZ1Qv0uFwDGPrEv5ziwpcvaSySH/dnfvYwFK7owoMl8N+rvbZOmIhG5yjoZzsNGFpWhj3HfbNfu97tTOspwJ5eE4hZUxAxd02gIeLIh1Tj6I0x2dmaYjnKHdsiThe0UNuCZFv3lwDkn9d9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Fri, 1 Mar
 2024 16:17:17 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::e8d4:c3a:a247:175e]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::e8d4:c3a:a247:175e%6]) with mapi id 15.20.7362.010; Fri, 1 Mar 2024
 16:17:17 +0000
Date: Thu, 29 Feb 2024 20:33:04 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mateusz Pacuszka
	<mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
	<jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Pawel
 Chmielewski" <pawel.chmielewski@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
 <20240228084745.2c0fef0e@kernel.org>
 <ZeBMRXUjVSwUHxU-@nanopsycho>
 <20240229072813.5d7614c3@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240229072813.5d7614c3@kernel.org>
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL1PR11MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: c81c8ebc-c3ef-4205-bc85-08dc3a0b1058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26OIYKzmocP1LMhO7Ae+kUDWH6boyNDdBNiMu+ngItMi26rIJDCnT7lvVlcsf87NOvZEGYhaDwQC25aI/Og3UFG/Td5wlNL9mu0YnftfAztDfQdWy4zC4qwfgTc20nJuaQ87b+h5Weu8AsZ/7AApvlVG++wZbtS3xHw2RKq2RccWKNxrhtwXeM32IPdQ6nCTzgBjpEx2B4zxIbcTuSS9dC1NzC3umzQNUn7GfO/rDpZIU/H+ihUtvXuCTcrFl1TVsGpIVNM/XPSeWk+zv0iK86pUJoO3b7hIKa6IwXsVpjJ4+EBLpr6PUW+SMCAzDdEec3TODsWGj1F6+lCL7FymeTA+i2eEfSnbqgcKqUtg118xm9tqdE5m3pVaku8jBfEqym3yUHA3UIU/BiTuWRr2L9OCqb7pJSG7OmO+4QpI1PxdePdeFV6js3CJFVT/XL1SM/34V7MTJftxCs6DuGSk9UtXySAcu9vuQp8zmYIT83Sw3fa/4nG1mKvbOpEU6+O6dOYzr1uGngNHAn70dxUGgYAw0T+sK76eRI8ARMS3i1cMm+4cDYy8NkekAGFDx0GbBO8e/OS9E9moc6Dbl2Kk7CqMtOXWqW+MufbJTCioL45U2snNqolJ9uIn98RepN/E5fIaeYMNTp8UWl82votLcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xGeJ5r1XtYQU7QYhgdSNL7z1ZwrElx/jd+0KhS2w8uql8YELYQ8NQ5b1Ghu?=
 =?us-ascii?Q?O3gHC69t3YTKSPL/GTpCQmg3AsanzeIIZ42QJWyuhoCr8s68ePbf+owTGudE?=
 =?us-ascii?Q?ajU6al0W54sVkOOMRb/X7KtBMFHa/ZxMImxg55HLTBQz1DBQUn1OB8jeCuyB?=
 =?us-ascii?Q?wSS9vX5WMeNKHB2YjYk8HxIsCz/v+dA9GLRs8sfSp8QyZfHq01cZhIAv/39M?=
 =?us-ascii?Q?dzPNVCiM8dOLQnlQXQ4jvdI2YPuGi+4cQsmjzZ0GvekmZ/3sC2iLyDQMKwyb?=
 =?us-ascii?Q?F//Y5hSMrUh04wSGoTWDZ/DCq2+ZFiGS6KL8xtIbY+QTQsm+Z3ulH7QlwqWf?=
 =?us-ascii?Q?hRsQ9FFLR8DJ9vxHlD7ILLMDJgbOTueSsdE00rl7JDZjA0Z44Eq1OHRItCVi?=
 =?us-ascii?Q?fyAYhPm17jxBgthS8e96USPhMMpqDk4y8iJ99QEr6KuEU3dgolE/niR2zVin?=
 =?us-ascii?Q?39mC5i8IXlzZ2bzWsUcsuP0leAzRb8zJrOrfNI56eeGedq1x+ecAjcOFGLT6?=
 =?us-ascii?Q?F5bGtNKrlQDVShkMWLQXY/98TrVF+gLZQm04k10ZXI5ZQpSI5S6g7FQBJbTR?=
 =?us-ascii?Q?HuY+wzV09LBMNEZ4RGK87j30OC+Iw5HUNOcZgdDFBzA//U4gkVsnyueRkoLq?=
 =?us-ascii?Q?jpIqw3thfQovISOEva5wgVXiHYpVKCMw65IQ7Cmzfn0xoz+LRmm4Q0umLuWK?=
 =?us-ascii?Q?3PZxGh6fYDiM8/8bVqSQuZl6fjgA/VFsM8zMz2pTjTd56CF9oVDBvsjLKc1F?=
 =?us-ascii?Q?qkNyGw2ELmSN1SbCB3xDIyUlCks30SB4d9ko4qLJUNnvG2rNiDWXX60RTZeS?=
 =?us-ascii?Q?vPmDQvFPdNYoUin9U3gLZsjdgp59zP4uI32uRCBCaMRT2Y57kqtJopOx7LaO?=
 =?us-ascii?Q?SZBZV9Uaqvkqfz3+uTLq4DgxqA3HlS16Vl5wQ5155jZYouGRebndfOL19iIW?=
 =?us-ascii?Q?os2Gp/o9+slSF3yRD+bq51TSi6CMkaAdYY1TaI6ZFU3D+mBdJn7nXCRaWSpN?=
 =?us-ascii?Q?x8elwAPTsqUzq+H5ibv0XQIb06GB308hZ28LZcboVDr8D3R/72QDiDLInnUz?=
 =?us-ascii?Q?yQCm9DHycO19M9fAqbUEqAfj2KNpGFaQIvJIlNLJnDKUd0g6pDcAmXAds/EK?=
 =?us-ascii?Q?VMwHJbGM7ga7dLkweZ92ETvSWVUbZ//Fo7k+HzdnSGuD/1sjB0smuyn6TyOW?=
 =?us-ascii?Q?mHR23vOahA+EQYC6Fqwcpt/wMOu7R4Agye2Sa0EcbEpBdm7gkISd2AvAachJ?=
 =?us-ascii?Q?ELd2aeMcEJYS4I9r/h1WYkYiAv4hlY+oMr9DTh4j6YLscilae+OxyRY367h3?=
 =?us-ascii?Q?y8iaFcWwbitsDCSDEKuIf5N0WsdkIy2yTDlPIvRZwjcjUXtrbrQYZ8wJH/8a?=
 =?us-ascii?Q?0vAyGOXtKiC3hgVw2STDfj4BcDxK0Z8MtdrfiFNtRb9yWyTbupyKOzMtoJFY?=
 =?us-ascii?Q?4wo/thtn/uIBrjO/LZ83Fquhk/zp9CTifg7Mz0X2TD2evFKTaC9/Zf7BfZbb?=
 =?us-ascii?Q?cL0urNuZHnlxyZmR1kzJDGBmJ4AlnRLK5VvYiuqRGRXswitJSU/1ZX/UdUZJ?=
 =?us-ascii?Q?YOi5kSgLXPKwitR6IJltuiwA6Et+o5jFjWfRJABxQkzRUGqlWUD3fGpbV6Lo?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c81c8ebc-c3ef-4205-bc85-08dc3a0b1058
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:17:17.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GU6bDOz71QMG3I7wpaVAlO/77sSkafbYy1YMLt7TIzGBMQer1zfwW1hNEa7IJ7caow9fFvBaP4J6WrkxLZy6YzGSsHowRJly0zAn3C5M/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com

On Thu, Feb 29, 2024 at 07:28:13AM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 10:20:05 +0100 Jiri Pirko wrote:
> > But isn't it a matter of eswitch configuration? I mean, the user should
> > be free to configure filtering/forwarding of any packet, including LLDP
> > ones.
> 
> This is an LLDP agent which runs as part of the NIC FW, AFAIU, not about
> forwarding or filtering.
> 
> They already have the priv flag, so best to reuse that. If not possible
> we can explore options, but as Larysa mentioned herself in the cover
> letter sysfs is probably low on the preference list :(
>

FW agent is disabled NIC-wide, so only PF should be able to set such flag.

The lazy part of me likes the private flag direction, because just replacing 
sysfs entries with corresponding private flags would make patch look better
while not changing the implementation much.

I guess, treating it like a normal eswitch configuration would be ideal, but 
it would not be purely generic, as there is an added level of complexity because 
of FW Agent interactions.

