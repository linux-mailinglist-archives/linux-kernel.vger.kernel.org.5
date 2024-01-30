Return-Path: <linux-kernel+bounces-45105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2C842BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF911F2BDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CCF1586C3;
	Tue, 30 Jan 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m06OKtXP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CC157E6A;
	Tue, 30 Jan 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639158; cv=fail; b=DtMO98xTwyHkdSQXZdqiLLw+yC2mXITdBeHttNekyTqxd7KHaoYrSDprxN1Koz+MxV3zmYXHztscVuLX5CAIiSsV3rE2ds2fcWvC05I3AsyiGm+N/J7pH8l/aOiMm7dfBajcHbzSioo26OZU2ETFZQhR1qHQVfOjP8g7+kJlcj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639158; c=relaxed/simple;
	bh=6V7e0X2W6z/PIJZin5zDmNFmnVj3nt7aJPFyeiBRHGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2yNIafcdNI6AJ4yOSepBtjoj/tesR8G7yKJ4aluvzvjkFuhpckP4dDC37dBI19gef+koG+aE59ZJcrIt6aeoceLoDjSZ06KmELFZmaiBWqFTw1OxhoJdCKx3AwHbeH5U/OVCBvQk8y376S8BVDFPKZ73BNCNslmujIZ1UKrTQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m06OKtXP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706639156; x=1738175156;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6V7e0X2W6z/PIJZin5zDmNFmnVj3nt7aJPFyeiBRHGA=;
  b=m06OKtXPOnGrxJ6ncFDbrPqP+QTME07exZy3PlkjHTgpxoMpPsHaTUau
   Iq80SdOLJvg/YMC9Z5lbcHlRjOjf7VpAlIYyeIqTlzWLpT8PKoiaG8UtU
   zXY6a7I+cnsvdWHBCvK3tCBasQ2WDElgsEj9inxI3QPHcHzSgHJVRaltj
   7QLflsM3jYcpfIEYyxSTTYMs8ekY9vwv3Mym3AFxF/rtGwo5F232XLhZJ
   smf7kMb8NAk3pMFzGz1HK+tfKXGKODYdjY15stZSKm+MJVVu0YxcnnYHh
   DeKlor+EpWA31beEJaup0Spynp5HcBGu0RdZlVbTI/NBzzXp6IJoYKcM0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16749898"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16749898"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:25:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961365255"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="961365255"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 10:25:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 10:25:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 10:25:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 10:25:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 10:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhBD5Gw2sWPV4NPuWq0GqyVlE16abYQP0nlsTshprOLFngf+hAi8kfFaVgYFlsKcBxrYI7IsdEtyta0spIT/A13dwdYlkln4fLP+QimYzCos1H4V5tBy7lKofVwQZDqW38TC3J/PyCJ/jVfoLFxEyIOOYlA+lU34azjry1Q/KzKngN2iCHsZoD/cTLub5e7ysWpJepdw8X7MB4W+/+ejPth8jRT7qszi+a7MIytISKe58Y3M1BV6Nwelka7Ntg2xJsdoc1M7tCcdSyixRartp/fahcF6fF9CiU3EDcYNRENDRaq1pZpE+yNm3s+6/wgcxgHMZ+kSI8Wscyl2GgSeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9Wsvp/pFgUBU9FuC9uXnEBWtEcoI17xLh4Q4XhmSY8=;
 b=cS95g/wk+Ewy4Uhon1EAWDww2VoQt3+HT7+wuSBtAxL/s+sVnglc2g1/9FN7A2dCzObgp97oBAt8/l6oOA3bOEd19guw8OQreETW+ta5KV0URJJhpHQbwe1Zg+eEdOLcrp1uBPgcAQLeTO1wccy3p6schBRvIWIunaO5k3L7tBvneHf+CKXiIYXAFUMFPxLrGhJj9besJ2vxTMcBGvhsB6rjkAwQKWuvuq/HYq4ITegSjnXAND1LuttiSiF7QObACcyho69kaJzouwccPOWf/xVGxd4a1xCWcuPSgMa2/7UvzSjg2EWMJEZHygp87lkieA4ZSITHK/o/smlMcZoc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:25:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:25:50 +0000
Date: Tue, 30 Jan 2024 10:25:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "yaelt@google.com" <yaelt@google.com>,
	"serge@hallyn.com" <serge@hallyn.com>, "nichen@iscas.ac.cn"
	<nichen@iscas.ac.cn>, "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"jmorris@namei.org" <jmorris@namei.org>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
Message-ID: <65b93f2b3099b_5cc6f29453@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
 <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
 <49c48e3e96bf0f5ebef14e7328cc8a6ca6380e08.camel@linux.ibm.com>
 <50c2fa781e3266ee8151afdef5a8659d63ca952e.camel@intel.com>
 <CYS7QMYS8XAJ.2QPI3MS5KXK8E@suppilovahvero>
 <CYS7WMFLXNE1.35OBTKTONKNX3@suppilovahvero>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CYS7WMFLXNE1.35OBTKTONKNX3@suppilovahvero>
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b9356e-84ff-4458-8207-08dc21c0e2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfDYu1/AJbCJMsl5DfYqS7eszo6Z7OCqNg23N3u7cHuASIiMUVkicaReHVeYMhMaeeYqlT52NYUTgQXXervsqaMGGAG9jlVWMPMME1ZNKMtc/S3bMj5Sf0I7xk/rs1hs9xvBuQUg9uVXeHb+6Fsa5fbbTOf0BOKoEXrpAAaCcNuiB6ZILgH3xeiNCzBq3XUb/e9etLSsTcXtuZYzN13HszNHT2y4yx6NkAN/eFDw9B7hEBOC3/U3oVF76R/Gkf5kvPZjMv6aLN1iLn5H+l5T1eamMPqC6ZpMgX3JcRjMBZG2ka1vrtRmInEF68qWE/Vqtv3fmpr6Kbh4z/UKuLZAhCcOQ/zvlw+TT/XBw+CumBZqIEpDORWzqkTywBWznj9xLBHxhPGtli1c1iTW6A9Yjd1k7cxijwklil23oDYY1FsYxs2WWCm5hlmjNZ1dYEy9W+cU79svt5r65j1RRx04lRZfjhcKlS1PlM7yCL5syIpBJiLU8G9b/DHh5SfhQRKYWf3ElJLjdBCpaeHv0WmIuVYLxqor+nNz2BWDlPVJmkWNQ1JhRnbo4Q6+uNCC/837lHJibbY9GcxfIEk2crGMWcMokPLinCB8tbszyeFwj4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(86362001)(83380400001)(41300700001)(478600001)(38100700002)(4326008)(26005)(8676002)(66946007)(316002)(110136005)(66556008)(66476007)(54906003)(6486002)(2906002)(7416002)(6512007)(6506007)(5660300002)(9686003)(8936002)(6666004)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hHbtDqyNU8xqpZ788Pkr6bCbjYOCznWzL3qtZnstqLqiCTIwgmmB8a6HQ0?=
 =?iso-8859-1?Q?t4HKx1NV+D6uJRPzsYdSNeBSi+KWaMk1AGTOAMFOk3zJjH/MNiqsK0gApi?=
 =?iso-8859-1?Q?gu18dCEJKsroZ56LFGTqu1kU1fZDe1N3qjGAbAgxOZzotUiNWeeidpuH9G?=
 =?iso-8859-1?Q?AEM+C0Q8ujKAdS5C0coJP76ztBDZuuwzdFRaQVxTwtPCb6hc26LqZbMfVs?=
 =?iso-8859-1?Q?HXJFWqUB/ySjsumqWpsyHf59lTsVzVq7Uvt4/aT2nc2x9K7kAKO/LsG0QV?=
 =?iso-8859-1?Q?67OG2ZHyiD92lva6U9httvXLDDD1kUefwEWa6RmrAaUoLDho1x94nA9GB1?=
 =?iso-8859-1?Q?VplZJa/FdFZjzzLUtM7aonOt5aYheaOzEkb9MMv5OvFcivli1QCSem+bwD?=
 =?iso-8859-1?Q?kdzvElCZM66znjv73mC9tLw7Ng7z7r+e60zw97xfuVLwzP9VsV2O8SkPCE?=
 =?iso-8859-1?Q?/dXinbEdolWfEv8vDLNqfDgrmhul8oUMp42cRyLV00zocf27ehlWSFy0/F?=
 =?iso-8859-1?Q?77Xp+56PP5+7+O7yARrqDd5iuM63Bes1qIdxMuUkLjkJR3ARj86NtZ4Gju?=
 =?iso-8859-1?Q?XNwraGShkdrHA0/VUN+jUkpdW97yt39TqKEgzT78ushOhuxGMryxjL6+2b?=
 =?iso-8859-1?Q?UNkZtr82eK4MGQDj4Mi0CRpe0PXgdTzoYhALl6A90gBbeMH7Gn9R1FHTbH?=
 =?iso-8859-1?Q?vfFrPe8L/81MM8bVHtfaoMyLJlvZQ+9jPxenFsLCj5C/hnP0kDXElqeTKe?=
 =?iso-8859-1?Q?OwdvD4YaofxjzLYgyg3C3RmsSeSaW0OfJ27mVrg006D80zkHndes3B/bdn?=
 =?iso-8859-1?Q?3crRBPHUeV4mFZf1Mi3N4Bg+3bu0GXPUPiJdmpglKWYVoawptw/+1+gcAr?=
 =?iso-8859-1?Q?hD0G9bV8S1BmBtQwYG7Di0aDU6C/tYcjKiUbxdOIqX3cgf++7c/It/Je6q?=
 =?iso-8859-1?Q?qMLOTRapYODPr4a5g3VfbKwjyD4LIYTd8HrlFKfJSGP7xJeIpW+qA7/NF1?=
 =?iso-8859-1?Q?W/GUqS8XWZe73hKh8svIdmfzZVkMWacQy1vq6mC7unYcj2RzsaGrPe1o9s?=
 =?iso-8859-1?Q?IKYhAD3nhmeQ7CripLKSchK9GLWk24F2CShp4WtHeqXD3Ke32S2WhmUeKs?=
 =?iso-8859-1?Q?HSatbpxVr3enpD3iwmQBibboWhCckhXnILw/Fcm+lY37Oe3XYPvVWLpQjo?=
 =?iso-8859-1?Q?qca/j+p+aCbTFQ8kFbxCxTK5kfvey4xDjUUsmdNfclz6wdwJhErlod11GE?=
 =?iso-8859-1?Q?F6dxINiOUyGFcz0dyo7Jd1L76Ms+cBgUuFdHFc5LOF/uxMZvAp/2p1/1mZ?=
 =?iso-8859-1?Q?YuAFMz3D3wLKvOAt9yiIjyKJb7bE1jIkUqq8vWM/VyJDLA0kwP3mHW8L33?=
 =?iso-8859-1?Q?XzZv0ZBdaMJ0UTAhlbBXlTnwPw/lGueUNTILU5aAV9vnLe4MX8Qh6fXDe2?=
 =?iso-8859-1?Q?tsent52fsk4359phyDSFCPE/WNi4JLO132lkgGVw3w5M4HdJO1M23TlJ7t?=
 =?iso-8859-1?Q?dl2eAYmvn4zsnW3UfQWPjqDCj7CYez4fNws/ID7afYzTOf+UE6SuviYPZy?=
 =?iso-8859-1?Q?NP8ACdFUQElGmkiP8NQngc7oFmntO8xV02aplm1h6lNC+3R5Ji0wWoXXlY?=
 =?iso-8859-1?Q?boVVVvXJTj3NnJ2Jbg0xeKjSnPamdqQZ0Jip12B8jC8kop4DC8vOBhfw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9356e-84ff-4458-8207-08dc21c0e2df
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:25:50.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PESGPKBoKoIdg5ARgaRJwbt4rcJl8gjJ3S77m6VE96lVB016WPDE8rEaTgjwkdzMe/jPReCX2+9szi7vYLVgA4hI7pekL6JwOgYtxKP9H2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8127
X-OriginatorOrg: intel.com

Jarkko Sakkinen wrote:
> On Tue Jan 30, 2024 at 7:22 PM EET, Jarkko Sakkinen wrote:
> > On Wed Jan 24, 2024 at 11:10 PM EET, Verma, Vishal L wrote:
> > > On Wed, 2024-01-24 at 15:40 -0500, Mimi Zohar wrote:
> > > > On Wed, 2024-01-24 at 20:10 +0000, Verma, Vishal L wrote:
> > > > > > 
> > > > > Ah, thanks for confirming! Would you like me to send a revert patch or
> > > > > will you do it?
> > > > 
> > > > Revert "KEYS: encrypted: Add check for strsep"
> > > >     
> > > > This reverts commit b4af096b5df5dd131ab796c79cedc7069d8f4882.
> > > >     
> > > > New encrypted keys are created either from kernel-generated random
> > > > numbers or user-provided decrypted data.  Revert the change requiring
> > > > user-provided decrypted data.
> > > > 
> > > > 
> > > > Can I add your Reported-by?
> > >
> > > Yes that works, Thank you.
> >
> > This went totally wrong IMHO.
> >
> > Priority should be to locate and fix the bug not revert useful stuff
> > when a bug is found that has limited scope.
> 
> By guidelines here the commit is also a bug fix and reverting
> such commit means seeding a bug to the mainline. Also the klog
> message alone is a bug fix here. So also by book it really has
> to come back as it was already commit because we cannot
> knowingly mount bugs to the mainline, right?

No, the commit broke userspace. The rule is do not cause regressions
even if userspace is abusing the ABI in an undesirable way. Even the
new pr_info() is a log spamming behavior change, a pr_debug() might be
suitable, but otherwise a logic change here needs a clear description
about what is broken about the old userspace behavior and why the kernel
can not possibly safely handle it.

