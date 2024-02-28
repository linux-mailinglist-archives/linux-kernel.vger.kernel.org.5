Return-Path: <linux-kernel+bounces-85258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B677186B314
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4CC1F28DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE6B15B990;
	Wed, 28 Feb 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKM2Cjgd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AC15A4AC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133918; cv=fail; b=i37vRXsPpiCEaDogQpLkNl4kXAQ3hJRIw3BXRXSav2c0cBlr8JJQqtPaePfu1X5f0qCofF+jpiLGcuR7EaLjUcQTmA4laoPAIEfR9DhpSvCjirsa/YDqStD/GaXD3HkJ8BOecL9Nyd4DCEe8lpj1A5Uyq3FCoBTKmBfnxvQWH7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133918; c=relaxed/simple;
	bh=L4fmsAkjDzKzka1HRDu5shwQd/gwwZY8JrZ9J65pX2Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXFXgs/bGiGI13fOXVHxNAj35qQM1eodQFv0pzrCVA76FXS53+pP+KnCujzAP+4UtuGPpgyHmM6f6dpLdfmKhCWqPRLR9bRsy5sr7Q54QFcbNbaROfhaJT9lci5qe5gj01PcUZNFNCE/Kie9jHwBdwYIRAkqnwO+AMs9ZajCNeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKM2Cjgd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709133917; x=1740669917;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L4fmsAkjDzKzka1HRDu5shwQd/gwwZY8JrZ9J65pX2Q=;
  b=RKM2CjgdVtFQ8bUOJ4oN8oTeXXhiMCUnlbHTAM+REeQPGzktyXOwQECh
   5260PL0gDaa+0zn2oYWl+LD5o4aFQvmYLUF6jj64cH3+u0sQVOANcHP7O
   XtNPYi7+NI0Bs8SEIn8Bl4CPResJcgGLvN4IgDd/3Dd/AiMNhl1H3bW/b
   6wr5iUUpSOvZOagUh9/CaAkLv0yqyF+k20Cg//CGunCahXVoyquAZnTVY
   9P+TUWTYJJq9bLVh4uIBo+rsIdTbOUH4w4op+Me/yOoI+UxWmIfsZVylK
   HBYs6A6WLO3r6QcIChYaRvSZYlZgh/7IVy31B7EyUZHceQ8DjE+M0kqS5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7361672"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7361672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 07:25:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12035829"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 07:25:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 07:25:14 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 07:25:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 07:25:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 07:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLeY5iOjzQfvQTpc7dcXdyjUtWCvPNPkaJbdmHvOngYqSHqtIOruFbjTOTSv/3HXrBW0szZ3IJyRtk7A69LHdhvcwRQ/caSDz/Adu/KYTADPVR5klJZkJe0Dj1L81uzWi2WWM/5jbYJ5c1QweukrT3uX6m5Kme4Lezaw+XieZkrqdpYPZdfisGN3PbwFKIzrnN8vCGic5re+KFzATMgEqnLAV3+hOWQK9/lm7q/Xj7d11KZMs2RAH2AJVbJcuE75PFHyHGRrwwwJaTSVbEExmYqPpbar1R8Bmm1XweTpJwuarAl3cuiChDBuTzudeV3TBefzNuNOwNMUoaqzMk5IsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snPPkQYN4XIb145hHyLDCDoSbwHCOE8igzkju9jjxO8=;
 b=RIZrM5r33Nbrv8/lkAb6aBX1f83vSprJnHpoggbeTOSZsLbBHDwdeiIiNMlACz6PoxRAws21rEQlkkJIlhUhLqPmvVC77yZWFDzzNz8yHUT61RXv1c7eDxOGOPHjQIEPHcK8d3lUckTuGMjZX9tb//5R1RsnO1QJaTKay3oraOYeGKTcSL+cTbZ24MrbHAmrnjkZ56MiGQX45TIPCC3hkvcnwJCsnr3FN4DiXMGA1iAhXTP3dmSNcY5C4NfBi1gAXz5tAKwjCMi/dWK7VLcH9k3mjq1JBguKkXqt89C78/e23cyNDuYk8IVlOSmLrPKRGSxyCpC+pY+pc6mqRT9/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.21; Wed, 28 Feb
 2024 15:25:06 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 15:25:06 +0000
Date: Wed, 28 Feb 2024 23:24:52 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Xuewen Yan <xuewen.yan94@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>, Tim Chen
	<tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang
	<wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <Zd9QRBaWVgmZ5Df8@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0192.apcprd04.prod.outlook.com
 (2603:1096:4:14::30) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cfdc4f-59b7-429c-2828-08dc38717168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5U9tJXGLn19Jgopo9TGhzcLcS26qmDh/+I/i9K6Vwxl7ukdz5li1h/78RutpxYKMg414EskfHl/3Y0J/5kElFVS4ZJ/KJSTSUse8H4iyrjNEcz/z3eC0n+D+Xd7ST53Pmc3wNs5kwZAvtT4ZyQHJqkRmGfNDsqivXvuCCci1cF6VoaN42hVxei5T1t002/jbVx9ZRdDSvpZOnaXbPGLx8HSKkV5/xhaeBK12mzLGPaE2eeNhusE2BTsVYHtvV3bY/OetLOjgYX2qUsB9wXJrQqi6i9z13WNdIjcP5RwdW8ZIA/KoikZaHZow2oVKJ9e192rzlyr79jnl4Kk5PFVNfBm0wznMl+AwOiOn60ED+l6GhO37Q4X5sg3NuVCpBMUdpjyK+eusKT8DE8gkVVAwjqy+Bqui38PU4BVP+pbKAMKJSPks0wzpXzXT05PI88yIjvQxGzncPZUyhngV6KAu6Czjgkp7Ud0lLaYY0wkxxSDzEyCw/Y5DqoBORRBv0z4AQbV22hKIF5dxm566MruXlAaqz3LeqxBVcaW+Y2TymBGZXGLnf9VAXd94sMX83rhqzzkNnGiEkuLZUDt9+PpSm2X/kfddda6n7nl7fmQN0bY2g/ABsLHE+XWeginzNsuOdG8S/vDf3Ne53uFZ586qaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bythVnFiQXkyaXBnQnc5UFByTElSWGU2d1M1cEZCNWFkWHdyOWdaZ1Y3V2Zy?=
 =?utf-8?B?bGhGZVVpMkdHRVE0RU5sanowZ0I5Ri9NMnNwZWpINWp5bytheWdYYW5VdkIy?=
 =?utf-8?B?MG9lS3NEcjdiTG11L0hFOHRsOHFGdDRFTFVpNVV3NHN5LzFvcjBsV3pkVDJV?=
 =?utf-8?B?UmlGQzhpN055NFA3bE1udkN3eUp4VFdUdHRHaUlHUFFibnJLd3FQNjBIWlpE?=
 =?utf-8?B?VnNLcVcyeEJhUG9kd3dkbVRDd2lFMVJmUzR2VzFvMHdLL0ZPZFkyUlVudlpH?=
 =?utf-8?B?RHorR0lYeU03dEdNcld2UXY5UGhPNFkyMlJUMmtYSWx4Wk9tMHcveEs1Tmh0?=
 =?utf-8?B?UVZldS9kd0lPRmVGOUNHUjBtZnpNc2JEWEl5R0oyaXpQc0kyaU1CaWZ0a1pB?=
 =?utf-8?B?cHlYT2lRMU5LaVMvT0ZyanRBMXVtR1EyQzNUUGgyWG1UOGJqUUdVL05oS3VY?=
 =?utf-8?B?RGViRDlDZGxQMWxUM1BuM3o3ZVd6WktjK0FVSDZWN3JMc21rTGlDdXJHKzBS?=
 =?utf-8?B?aW9VU2VqWWpKeEFIUHJoS1RNM1hWWWNKZmRGWG03NGpUMWIzMFZETHpKMTNj?=
 =?utf-8?B?VUZ3aGNVUDFFYTJ4dHgxcGFzSEdwUXZCS3BTS2hqU0ExK1BJVHlnZkZPcWo2?=
 =?utf-8?B?MXpvZjZWKzlOdGx0bDdzUlhsc1BoQ3MxVXFNU0pnQXpMejdibkphaEpRei9x?=
 =?utf-8?B?WUZzc2tpUDY4SmJNQ0R2OFBHNEd0UmZmUVFrcCsyQUxJaUczUk1UWWJxN05C?=
 =?utf-8?B?WUQybFYyaGVVSkpZUzlOV2luU1Z3eXl0K0RLbUphMWJjM2dMQVFoSHloa3B1?=
 =?utf-8?B?Rko3QlNicXZiNjRwb2s0bDBCRVVlRG1DT21ROEw1RlRTWHE2VkhJZm5NWFgy?=
 =?utf-8?B?OTZZVzJRV083SjU1VnpKTWh4UUpyYm9FMWtYanlXamhyUkM3eEo4R3l1UnVM?=
 =?utf-8?B?a2NqOFY5d0h4QjBDTTl5aFlhekk5N0gzMVh2WlV5Z3VxWjNzSkNHQUllU2Nq?=
 =?utf-8?B?elNVZTJSVmFmcVp2WXMxMkZOSnhwOE1pcTRMdjVyQ2VWRFBFQms5dzJNSGRw?=
 =?utf-8?B?Y09IVGYyaDJGTy94L1FxdTNqZUlBMVF3L2NwdEt6QWZHNVg5YWVndkFpRnp5?=
 =?utf-8?B?Rk82T3JNOHZlL0FKazBsTkhJa3BGZTViUnZXU25vMTRDUUpYZmRrL2dUSVF5?=
 =?utf-8?B?ZXZsNDdvRlJLYlJlNGVqVEh4SmNBM3BQV2ZReHM1TFZYSmVGWkpsd3Q1RWJv?=
 =?utf-8?B?RW5ESWRhL2lFNEdUR3FOMXlJd1orY3U5VnRTTUs4Y1hpalhmVXQ2MDRPU2xC?=
 =?utf-8?B?VWt2VkplS0NpQ0hDdTF6WVdvb0FaKzQvYkRPcGp2QjNuSG1rWTNpMVNNVGh0?=
 =?utf-8?B?d3Vrb2YzT0tGYldCNmsreE9Vc012dDNUaTB2ZnQyRklId2U1a3lDeG1DWW4r?=
 =?utf-8?B?d1JIZkhFeVdONWR1dWxDMVUrbGpmbHlVcWxRNjcxREtycS9lS3pqRDcvYU1W?=
 =?utf-8?B?b04rWHNJcEU1akxEdm1ZVVFxMVNBZmNRVXRRUUduRTF1UzZDMW9xSmtPWjkw?=
 =?utf-8?B?NVg4ZnFZZzgvbjh1M0hYRDFZekxobHhUUS81YllQVWYzSmVNTVg2N3hSZDhs?=
 =?utf-8?B?S1VTQmpBdjZaUFJsUkNBNXFjekFKZ1FmSlJLNmpINEpydkJ1c0d4cHdjRmVa?=
 =?utf-8?B?bXZzY3FwV3QxeGwxYlNXUVMvVHBrdXZ1d1p1dEtmbkV2Y1pzK05SQWlaRnBT?=
 =?utf-8?B?b0RjZjJWcDByUk1HdjZDRHAxYTlsUU84V3pZNUQzSVBnUHBSVW5uUDU0dFd4?=
 =?utf-8?B?UlI4aTczaTdIMENCcUVNYlo3YjRjUkdrQmNzQXZhTFhaalhPalFpQlY2dE9h?=
 =?utf-8?B?dGNBU2NNRGNmcDhpbUdGVG9OS0xTRGRhS0RNRUI3cEJnZFE3MThNQ0UwbTBU?=
 =?utf-8?B?Zjk5K045T2FDZkhON0h4cjVTS2wyZTN4cUNXZ0VDTGl4VjBjdmt6UE5raEZW?=
 =?utf-8?B?dnpURlE1ME9RZVA2ZHVGelFzL3pkNHN1bmw5cWdyYURDOVRBNDg0ME95OGdk?=
 =?utf-8?B?MEpZK01BeVF3eUNJYThybGUvNGRhRXJ0QlY4ZnJwM3FUOHh6TUFHdG1zeWw4?=
 =?utf-8?Q?AS83EIED3ghXbLruxJAVOv+Ym?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cfdc4f-59b7-429c-2828-08dc38717168
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:25:06.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yORmSgglqWsDEGh9F2eP4KWJtx1varOuIaPoXTnaE6aG7irZGYqK5pN/BdgM0eJHc0TQlAs7BOFGMDc4uUcwhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com

Hi Xuewen,

On 2024-02-28 at 17:04:49 +0800, Xuewen Yan wrote:
> Hi Yu
> 
> On Mon, Feb 26, 2024 at 4:26 PM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > There is occasional report from lkp that the kernel hits the NULL pointer
> > exception:
> >
> > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > [  512.082337][ T8305] *pde = 00000000
> > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
> > [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> >
> > This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
> > After
> > commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > the NULL candidate would trigger the NULL pointer exception. While before
> > this commit, there would be warning.
> >
> > This NULL entity issue was always there before above commit. With debug
> > patch to print the cfs_rq and all the entities in the tree, we have the
> > information when the issue was reproduced:
> >
> > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
> > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> >                         min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > [  514.536772][ T8390] Traverse rb-tree from left to right
> > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > [  514.538539][ T8390] Traverse rb-tree from topdown
> > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > [  514.540340][ T8390] Found best:0x0
> > [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074
> >
> > We can see that non of the entities in the tree are eligible, neither is
> > the current entity on this cfs_rq. As a result, curr is set to NULL:
> > if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> >         curr = NULL;
> >
> > and the best is set to NULL, which caused the problem:
> > if (!best || (curr && entity_before(curr, best)))
> >         best = curr;
> >
> > The cause is that, the curr is eligible, but vruntime_eligible()
> > returns false. And the false negative is due to the following
> > code in vruntime_eligible():
> >
> > return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> >
> > According to the log, vruntime is 18435852013561943404, the
> > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > thus:
> > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> >     delta * 2677 = 7733399554989275921
> > that is to say, the multiply result overflow the s64, which turns the
> > negative value into a positive value, thus eligible check fails.
> >
> > So where is this insane huge vruntime 18435852013561943404 coming from?
> > My guess is that, it is because the initial value of cfs_rq->min_vruntime
> > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> > seldom scheduled in, its vruntime might not move forward too much and
> > remain its original value by previous place_entity().
> 
> Could you please test the follow patch:
> 
> https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
> 
> Because the se->vruntime would be changed in place_entity() and
> reweight_eevdf(),
> however, now the vlag may exceed eevdf's limit in some scenarios, it may cause
> the vrunitme's error.
> 

Thanks for providing this fix. I took a quick look at your patch, and it looks
reasonable to me. I'm not quite sure if the vlag issue is the root cause of
this NULL candidate problem, say, if the abnormal vlag happens, it should satisfy:
curr->vlag == curr->deadline ?

According to the data,
curr->deadline = 
cfs_rq->min_vruntime = 763383370431
cfs_rq->avg_vruntime = 386638640128
entity_key = -10892823530978643
avg = -6851585614346926319
load = 2677
so avg_vruntime() = 18444185410266494357
curr->vlag = 8333396704550953
which does not equal to curr->deadline = 18435852013562231446

Anyway, if we want to root cause why vruntime is behind cfs_rq->min_vruntime so
much, we can add more debug code to further investigation. And we will also leverage
lkp to test your vlag fix patch set.

> >
> > The proper fix should deal with the overflow of entity_key() * load, but
> > I don't have much clue on that, so propose this conservative method to
> > restore the previous behavior before the mentioned commit.
> >
> > Fixes: 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/fair.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 533547e3c90a..fb9202f464e2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -880,7 +880,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> >         struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> >         struct sched_entity *se = __pick_first_entity(cfs_rq);
> >         struct sched_entity *curr = cfs_rq->curr;
> > -       struct sched_entity *best = NULL;
> > +       struct sched_entity *best = NULL, *leftmost;
> >
> >         /*
> >          * We can safely skip eligibility check if there is only one entity
> > @@ -905,6 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> >                 goto found;
> >         }
> >
> > +       leftmost = se;
> > +
> 
> Maybe judging which of the deadlines of curr and se is smaller is better?
>

Yes it is donable. When the NULL pointer exception happens, the deadline of
current is very large(nearly u64 overflow), we might always choose se
if we compare them.

thanks,
Chenyu

