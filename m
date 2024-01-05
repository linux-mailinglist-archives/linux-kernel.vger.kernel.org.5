Return-Path: <linux-kernel+bounces-18138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C6E825952
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC2B216EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71A328BC;
	Fri,  5 Jan 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk9QsUAq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15235328DF;
	Fri,  5 Jan 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704476728; x=1736012728;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F2bbme74Om/2O/KP4za9JdH1xDHt7WTCRK7P+JuFC5I=;
  b=Hk9QsUAqHhLnVTQkxWc2NP6TomVL7rLXQjhEAVH1H9kWJ65S1yoTsoIj
   4Y8FQSNE2f/Ux8qE7fpoHXvEgpa8MzaBcqQsQbQR+dQMno4x2YnwgfIlu
   nriL+vJiyrWzPGn5xtTLUXSWHtGx/zMr5IsMGGIbNbRTRF/1QH+cdzSfT
   CO4aKzLB6fuDI8SyExnE8P4rrmApOrK9W/rxI9QuNQLoAAGx8f/dGVouC
   nO5psnawPt1zkRXL7F9cX3BCGEDKKEODgZ6s7/O7s/27J6WXJgP4ucUK4
   cbntMh6BXJYfS6Yzyvzwm9PUPBN8/lipClZKUohGGuOoIuXm2PRrZU5om
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4917335"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="4917335"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 09:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="899706879"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="899706879"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 09:44:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 09:44:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 09:44:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 09:44:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 09:44:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAPvoLcVvwmwWm58jHr5Qe6vj+ejCGcWW7GNsBf/BRxyH4Z7DXmLOIBE8xpdlbzGicKz1okzb5NlNQaN4gnCgw099xYbKx9LoPIl4WNcpEP5XXVpBu7nMZsCZCTEFoOAGex93K4EQEV5ekMxWj/uAUqcv+AXKmREqozr1bfcsB/iOhNgAmeU4SemEUkEbdkBwOPI6pXVWY3hIzFHbDRmqSWWAQYbIhc3hY1i6HbI1em/bfL0yaub69L+S1Yj/7nQzf51bGnsg8YHFOdu43NtvOdkcjycpgr/zsBx3o9IRUY+SDvvSyKQl+b/T8Gjlc34GvALJ4PN9cnkcTO6ylwTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knMCaqoPJOVvetQUAavSWBwsBp9M6kkPH+AZNnAzWRE=;
 b=FdCQ3LRsmn3SHe08fHCy0oz3kUr7FjNfVz00mvAv+v9Zk91KBVthvAm510j+byB72GfP6z8WOe6CAjLswiZjiERtfb2fqLHpq08DGkeo/C/2GIVrD3wPYZgaUwIKPf+qIU1ZH0RHi78Q0cVkjAyUDY74dCFo4GLZQ4SmyZms4X+AMOW2f1/2Eqvc+ak+mfJtdlF3raM6OeKCjyTUgvk5PPjXheqlr0S898Sg55LyVyjP/iAQasGuJswSg8KEMIrhuYcQI/XTduWWhwPHKrQ8Br/HlVxJ4aor49mBHWB8qllc7/mf5TAUMta2j0Cb3Y/Vul52tBPlu5CdkBcHJwbSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7935.namprd11.prod.outlook.com (2603:10b6:208:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 17:44:25 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8de8:c1ad:7062:6afc%4]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 17:44:25 +0000
Date: Fri, 5 Jan 2024 17:44:15 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Jie Wang <jie.wang@intel.com>, <herbert@gondor.apana.org.au>,
	<linux-crypto@vger.kernel.org>, <qat-linux@intel.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] crypto: qat - add support for 420xx devices
Message-ID: <ZZg/7+7XPXyR06CG@gcabiddu-mobl.ger.corp.intel.com>
References: <20231215100147.1703641-1-jie.wang@intel.com>
 <20231215100147.1703641-6-jie.wang@intel.com>
 <c6662ee1-9c2a-49fb-917f-2a3586f636b4@linux-m68k.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6662ee1-9c2a-49fb-917f-2a3586f636b4@linux-m68k.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB9PR02CA0009.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::14) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|IA0PR11MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dbb901-871f-4671-298a-08dc0e15f515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pz+a5VABn0qBJ8R6cya13TexhAUtt2oj4mAiMgZL3umpdiqzItGIaswslYaI4zNQ+ewePf/oF2laQX5BPPNI5I5ICWOOLuq/7jkNkDHYiBko3ApDgdWl848DQpZco1QlqfS82rR9vBfgtOJwSodl+1KrcrYHZItu4Q1WywamYC7q1UrlnFHw7Hl5hioh9dHFDCTC4VdVERJmppYJcxhBRf5PI/HRexFk43TjbaXCgHQhzlQu/fycaEZ7VKQpiQ/Lfn+yx6ala9Q9PigKZxa2N6O+Gs6VaG/AdYjL5paOfVMCclGpxWVsTGDvgAKSbtJprpq0Kd+6JZ/j64P0wvOHcy7VXJsPEpkr3hhZjNSVtIuaJ+WjUHMdvfLhpNZwnrrYnGZChbWX0wibNLAbOC+4SSf2Us/1mROkC+P3Oc0jNbMZDHCIBVN/jKLxjiAFiTKSoZ2vm3wwRpaYg9R+fais4biUXHwVlV8Zlz4IP113moGENoJHEkWbdr2LstWeD+Yjtmp4rYlLi2rxMBzAGHWjhwuKBHiAZC+IUKEzyakqHY6pJ5TVumoyGNBLu/UHpbRENpmoS9NbxWILh6ufpvCLo8xZmHSh7o8Ip7zE4qj5YwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82960400001)(38100700002)(86362001)(36916002)(26005)(6512007)(316002)(6506007)(66556008)(66946007)(66476007)(6486002)(8936002)(6666004)(4326008)(478600001)(8676002)(6916009)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?g7dLtz5fdyqKEnGVF+fjJfK9ANa1UqovuRvzSrH5nbYKTLWUquz9RHduOu?=
 =?iso-8859-1?Q?oBuzvxPiTsFQlLbYKvV/9NBsBkAtYMB9UdmN5GbS9cKsCwjeuVub0mB4LO?=
 =?iso-8859-1?Q?l3tYdGIq+NVhk3IgmziklFQoSEEXfCagAfWlAzQFmnbaVM8hc9zUmd3Xk6?=
 =?iso-8859-1?Q?Qi2TsMwLoIqKiLUHb4XKhTCJWh0jX9S305vx9rorQc5xhx+ktsi34Kvv6X?=
 =?iso-8859-1?Q?3zZ2Gode0Nr+rzbMMSGPqBU6/36N1V7URpfuP3mD1NXh3izMLvf1cxLIf6?=
 =?iso-8859-1?Q?WIj6HHoxjZyJ+Lbs6QljN3CdcesG9hns53JmwqodhKNB3cgeIm+VbqIq78?=
 =?iso-8859-1?Q?/gfa2TxPtviUzhjwC3rU7AtyJs5mW6z/nRPV0Eox0bw+34hRv6G2LyDRsb?=
 =?iso-8859-1?Q?O/Ksk8vDf+mM3lG3ZuR2IGe/HYaHe8cnQ3OGRsFZcnB2q8LUrcQxkbkRFC?=
 =?iso-8859-1?Q?scthK/KUBeZfz+4F/hntuj+3rfsT9ughvL0xOb47SZBYf1LH0vN0CWnPw4?=
 =?iso-8859-1?Q?2Qe1UdHbYbhDl4jbpkK20DONLr9LWMckbDlllfpXtqDajF4WHfRymJ7BlI?=
 =?iso-8859-1?Q?hGOImyY1ChkiMcB/ehllhKlRb/fuNI7EE5M1pDU/D0u12vpJd/xHDvoO3L?=
 =?iso-8859-1?Q?hUfQVX/sgDjkCTW40d3aUcxsZ/rynViWmrlqmWJhnwg8j7ijC4+npMUxa1?=
 =?iso-8859-1?Q?aWMuMLx4FerL0mu6p2uq4F6c0o32I8KXBjki/yJtjprZJinIBLGALwTngV?=
 =?iso-8859-1?Q?l3ilyD/0tb/relx0lybUiOASdPYV6lk90n3IteS99x8PrL+dhQdfzo0H15?=
 =?iso-8859-1?Q?JCii/WbZxfNri3WToSvFcVYEiMUfVLaezmhPQ/CZPNilWozrFl70cOioxF?=
 =?iso-8859-1?Q?gs6I5ATwZjDBPJIF/FEpEfgnn+3hmRff5BLCKilf6pMpEgSwdUyZfNqkUR?=
 =?iso-8859-1?Q?tr4QWZyUFGn/9Rj1eRfCSh+VY3wdDnagNzbuJOiVWze/j4vLD/iMvclTsw?=
 =?iso-8859-1?Q?bHhskXFfa0NVo7GJ7RbB7vNmGuY185YihaBCzHqUw5XuqYHL85obQxMqXR?=
 =?iso-8859-1?Q?vE56qkI2UbteqRYOY2zzhCIz7eYG+cYaAACWv21/uawfdI87oH3y7hVQkx?=
 =?iso-8859-1?Q?8XOPH5Yf3hou80MBkhYQrnShsMDvnqrZ5d7aR6VfhvCRLl6+bB+YrJXU9Z?=
 =?iso-8859-1?Q?tiNz16zaSbnVsduBiUTV/biBZ+7KurnuhPWVGtS2YbK9wFnj6Lt+9v6rlz?=
 =?iso-8859-1?Q?z2MvSMenYv0oDjSLCb508HKNMXeQ6KUhukrE1A07pVBcM7RTLk1960vHxa?=
 =?iso-8859-1?Q?g8FsE3lAmY4VrrtdRIiw7cTdX94+sXVkqeyvLu5qter6zAFUw/wnfc5CW+?=
 =?iso-8859-1?Q?+AuCPzb93Caiih5nshRe/Pu6zHzCCqpnK4FbAm7mK+XigmXQrcA2mhmhkm?=
 =?iso-8859-1?Q?sMF6+E/vnlaVxIG9Xlvf+fIY48yLJTmgy91gdc+ASgmuZ3Z99w6cSJxVwV?=
 =?iso-8859-1?Q?ZVzPsFWDke6ri7wusBznfzaQLmWY6TYPxCEQnnt/PgjUZUvrKkkc/oxRlz?=
 =?iso-8859-1?Q?aUQmPHxbmzzVHYuU/8wKso/QFJf3nJyUlN+MNm8LAd1IHj6K+bSH9vFy10?=
 =?iso-8859-1?Q?Fhu+mqA3NewKo71DfnLTi9iPYH+qtyTRbX7CUaYbxy0PlPHtTlTiWC4g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dbb901-871f-4671-298a-08dc0e15f515
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 17:44:25.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUlTPkkJvD4gh+rnY+wxH52j31DiklpLDEEDRrmT+wYwW2v4yM6+fcgbSF4FeOFOvBhRR3+Lo9o7ANdYneroKXFH4UddmpnrUZ/h1BD6YBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7935
X-OriginatorOrg: intel.com

Hi Geert,

On Tue, Dec 26, 2023 at 12:31:20PM +0100, Geert Uytterhoeven wrote:
> On Fri, 15 Dec 2023, Jie Wang wrote:
> > --- a/drivers/crypto/intel/qat/Kconfig
> > +++ b/drivers/crypto/intel/qat/Kconfig
> > @@ -59,6 +59,17 @@ config CRYPTO_DEV_QAT_4XXX
> > 	  To compile this as a module, choose M here: the module
> > 	  will be called qat_4xxx.
> > 
> > +config CRYPTO_DEV_QAT_420XX
> > +	tristate "Support for Intel(R) QAT_420XX"
> > +	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
> 
> These dependencies suggest that the QAT_420XX device can be present and
> used on any little-endian system that supports PCIe (arm64, MIPS,
> PowerPC, RISC-V, ...).
> 
> However, [1] says QAT is only present on intel Atom® C5000, P5300, and
> P5700 processors, implying the dependency should rather be
> 
>     depends on PCI && (X86_64 || COMPILE_TEST)
> 
> Which one is correct?
Thanks for spotting this.

For this particular device it should be X86_64.

Plug-in cards devices (e.g. DH895xCC), instead, should stay !CPU_BIG_ENDIAN
as they can be used on any little-endian system.

I'm going to send a patch to change this.

-- 
Giovanni

