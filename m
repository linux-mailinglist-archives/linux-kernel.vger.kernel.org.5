Return-Path: <linux-kernel+bounces-106698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80CD87F21A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA22B22172
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E44E58ACA;
	Mon, 18 Mar 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jn2yG7Fl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F259B53;
	Mon, 18 Mar 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797214; cv=fail; b=f5Vik2umPt6HIDllrjvxqGnRabrMafC1YjVPc0JDapgONXc/8wxsYi9iq4mIJ623/u5ncFkev3AAwdTnY8CP5edqbjW6pfyJJVn4Nz8y/UqvWTxptyFosjf+UmUavhgWdKfPs4Gdpmn89TtGLvVDy0e4e3NNUXQ9Xs1MJEfTxSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797214; c=relaxed/simple;
	bh=X161hBKC3w0PuXL+QRzd7ovwo18P+bTmHjiLvcO04Ls=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBbtVCtopKB1aEeVah7sprOBCp/vAiYl0GTUANxn4sSB5GOcwPgcwSkQg1Ye78nFz70QnlkB5cwTk1L61iuUmGg4Y9qLPYUVu/vQyva7k8htV5RvaHgFZuXlekqWc80windDiQ020r6OfU9046UxgLD6lNdsajetmR7ml8ffpPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jn2yG7Fl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710797212; x=1742333212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X161hBKC3w0PuXL+QRzd7ovwo18P+bTmHjiLvcO04Ls=;
  b=Jn2yG7Fl5/e05jmY6HkZqlh1/N0q/xvwYMUnqz56YB5tj93YjAtkE8ae
   xZYQCdkSOeRLwJDLhhCva1p91yPfjhLTjpDbAtk0AYDobI/rkHJyQuPsr
   6KSH/fqmxkwFLiVN2H+oFqXxLhTSGqfs63TfV5mti4/yMHYCh7VLwUdeh
   ikn0DV2Aw3naZjO6j48z1dtygzFFCtasmArI/yD/sc1+5mUdJkyjQRE8F
   DfbOWR+RwOyGi8ZLlRKwrfxsmpxZ0y+iEXO9xEARZSDOOEX2jab+gCP00
   EuqNBG052XHynV9BUmdb+RhjIpzG+ISBZr1xVPSBHtH1/+Y2figJg4oBY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5499484"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5499484"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 14:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13484515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 14:26:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 14:26:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 14:26:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 14:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCAwZ7q62zP2oW/JWcCdGw3KEVC6+8syv6lrUBnd2wbskDDnhULz5uDnXsarhweKjCiwkiQc0f+O5r870VWiGMqxobqKca6+d+zuPQ86RAPf1p8/EoaeP/NSFcg0CBlWU9geSYdxKbQ+Hugh/FmhNyBxvHWnTYraog6EgES9DDwheDSQdGwIHsL661guHXEFtY/4h9onROsqetoz6845V+kKn09D+dU0Bg9c5m6dVyI4+msYKU9b/Y1oCmsYNa3XgnAtbnI6nge+4Ku7qpAjuhW+PUpcDI0lPr8EVraayXNouZRmSjaV0LpP0WmdKlHhtlPc+Ob512B08NBdgt4L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmCWCL/N137d6Auj6+VDdC9TFQJK2LqcyxYttT9kZVE=;
 b=VNXyOeOkS6ydhnRnacjDjd3bxlmV9uqa4+q+k/XZeW6i/H8nDsQQkV0mJxqZRUGulGQXvS/o8ypnN8wPYm5CzMykamFwP4QBy0oyVfzlhRT1H2buOOUDROjfQYZWhoJNVCURo2bGmMveDFFMPb47AcNKmm412idjbx/ngT54FNS9qMf6ALTTXyfS5vZxLLDogGiVHk3QOtc+b3tPHgCF1GN/wzIO4QVYVnBleBkKFIR/UIf2rlCjl7MhEnxc88p0PhWEZ/JnAfGGhneXCb1rKKCq4wrD8OdXYrK2MZ7ZYC8+M61IfU7SutYe1SZKRQpup4KeO0du87Pz6g5kr9VHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 21:26:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 21:26:44 +0000
Date: Mon, 18 Mar 2024 14:26:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Alison Schofield <alison.schofield@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] x86/numa: Fix SRAT lookup for CFMWS ranges with
 numa_fill_memblks()
Message-ID: <65f8b191c0422_aa222941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318210904.2188120-2-rrichter@amd.com>
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7152:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwfeyZmhgt2hOPAaeYOAOX/UyAhJtBX5GIPYe/PH+Ve+EWNP11Qc2pPK1N5Bpfee5btxRQxfO8P0l61CA4aQfw5pG3mkU1APsIGPrbpqju+dzTntASoGovrn+0ymscbBUxhx477hAXiHs4tFQ5FD1B0ChATJ3XRBkvA/7FGRQ8uKvRRaeuIB+ROGZeYFZ3DSvLNcPGfdWFUnZGdSWS1cIfWWwrwOfx4D208V8kkhFkjU+nl85L47NAsTh8ieHdZUE3TCifiRG2CZdZ/PVXnt5GTKjR4g8v8oc7pr1WagNKR4YEGl55nVvnUq7QJbdM4gRPkl3iCM+fG/vp54bJ31pjUey6Jz34RIL5+fsS2p38Xncmy9rZMxydZjwPm7aK+4TvO/iPLBokR27CzsNQQYooo0Mvhcvy6gxRkmRxPoI04qEvj1mkk9rysysWZ0aacJjrB2IV/otpyBPaE2ckxSF4bT1m3kKO13bRuziSS7L06c/ZaHS+YfM+qXgYWArMrXfyUzl56UWcUcW4Xj5weCcArz+oqzU2xh1WlYCnOXVXiE2LjSosA9LsWid/1pJaVs6TiHxIWvZDEFzW5Mm6uIXyyALECLiTl8TGzfGYyTcExY4yAbWCb32U06Zv44JKYPYkC5K9rI/3aCBflDzHJKYEYzp1wkSaIR72OdtENmXTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjbnuLsYH2i1QKk1ahJmF+qntBbljbzKEtyVw0QOTeOvhkyLVFNO7JuW4QHT?=
 =?us-ascii?Q?rAoATsHhrrDvmLPjSXVkE66irHFLKe6tPeB9Mk8J0OjOJxd5ViKcGkHCzgrI?=
 =?us-ascii?Q?nh/fEOyOI6C1Oe4llJgkcQL9lPaH+grH3S5iWKtw21yWusk2l7XhHB7s+mgX?=
 =?us-ascii?Q?IGypCYlVO8uzBxASV6+x3l0E23xosiroyB2UwfDM9/F/lNyP4NMmxTH5nJ6X?=
 =?us-ascii?Q?xy+XPIzEHu9iEisJiWkB6YDkdAZA3uPxMOchJ29GPR/wLFbMfYh8IXjg+pbr?=
 =?us-ascii?Q?Q3PNjfAwSt00L5O2ifudStA5HZiYy5N820S0lAIMBpHxf6SQkTedU1pkwvuE?=
 =?us-ascii?Q?0e2UE5ZkpQJ5aNcONBZIDNAGhfNNVHmWMi4kmK59xx6HBYQVArhPwwnZCRNG?=
 =?us-ascii?Q?nA9dM19z2W6ZaKVs21CUJSFgFzB6sVySBBKZztSAky+T06Qgosvi3XVBTvmk?=
 =?us-ascii?Q?k3KlosIYH8QeDySKchHyDJRSgHHsbEoarbgt3bskBuM29mv8a0oNkSNO5BTZ?=
 =?us-ascii?Q?1ogORuiooBQ/8oxCgx80xg+EA517m316ePd4rNADRuCegXwCDSo3DDWURyGO?=
 =?us-ascii?Q?cS322TFjSxCJ8mMX6yNdbh6MLeaiAzSRhPRaO8XKE48OAdn8x0otUhqRBh3c?=
 =?us-ascii?Q?mQjHvVZh+LBZqLJoOtojqueWkF3qrLoZ0q6cWrDazfRSvKuzV6rA09CjaTWl?=
 =?us-ascii?Q?NGwDFRwEy7g8Hecd9Hb3BzR/BBLTODllfAg6p/dY/TPJoR2mGffR7btD80PW?=
 =?us-ascii?Q?GL1q8F/Z5FO+beQf3ELDK4fH23VUBkEP5qLY2KqsUWuZx66kimiQsAux2hw1?=
 =?us-ascii?Q?apjCpBYlklFSg/sEUJcMuv096dry1drMk9Pk8E0HrcRojAICybfHd3nRq+P+?=
 =?us-ascii?Q?m7P8Apl99E3Orql5/yRUNwjQgT4ogiqJRPC72QW1xNLNNlnh/kmIDr6zGEyE?=
 =?us-ascii?Q?9oczrhZguKI9E5s+aEQz/LDie39zpbx1AyNGMYzsRj4SST0MGYzea5Ult7CE?=
 =?us-ascii?Q?ikrcaClh2+Alsv5gL7u54mYNSnH44cpwTzN3Gq1UtzxQk4HXCCIBkfZOiD4I?=
 =?us-ascii?Q?O5MbN73p0hnWtyZQEIbJ9h68k0UTqN0Tgno+9iINQemMKDwMyKxV/p0dcw2Q?=
 =?us-ascii?Q?V/2lkO3AeYdT6EjKSpTAYRS3YJNNT3XhHSJPkwvrD0cVHC/gKS2Rpe9n1fuj?=
 =?us-ascii?Q?QYH2rlfDQNHEeTPw7H/+Qv6493qwJ5rI4FXbdASqlLbre2Gf2YsnlUnB+iZW?=
 =?us-ascii?Q?Jeglhegh7dF/4LSI3yj5uNF/8nk/wZv3SCLjGSOf5oSzJAmFywwVda+uVzwS?=
 =?us-ascii?Q?O4LfrZOv+fsVqyN8usX13gugZ0cRxIhR5RK5baPZVI7uyntp1+47LTne3h3R?=
 =?us-ascii?Q?AY+iQfhlwzhrRc7F+ZZFzNjKx7Q6aFDvKB6BxHCgMQIVGHsuSk/MsBdc5W0h?=
 =?us-ascii?Q?kVdq7KlF9iLluk1/EpZqNzTmZ4CFtxnYEJmQwhEAv9JurrAlzN/RaYBQx3ef?=
 =?us-ascii?Q?bEm2Mvwag76OhoaitgYTldhm2RuGHATFtCRE7eNEHGc6J7rJFUPwvaW2k37i?=
 =?us-ascii?Q?1+RRHM82OpwjrbagzZTGxs5zQ3ypkKAsDLEo7q5zBeXzRPjNgJGyRKRieBvX?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a762dd-a67e-471a-89eb-08dc47921c22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:26:44.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8H8m4WwePvii6ho9o+BwNJJ9LLFTHoPBN9eZrUMmqnAvsKps6NUUTx7Uxwd7zcLralXplmv+a/2/L2M/GPcHTvCCF8L9Z8kV1YDicGWGKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

Robert Richter wrote:
> With kconfig option NUMA_KEEP_MEMINFO disabled the SRAT lookup done
> with numa_fill_memblks() fails returning NUMA_NO_MEMBLK (-1). An
> existing SRAT memory range cannot be found for a CFMWS address range.
> This causes the addition of a duplicate numa_memblk with a different
> node id and a subsequent page fault and kernel crash during boot.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too.
> 
> Fix this by enabling NUMA_KEEP_MEMINFO for x86 with ACPI and NUMA
> enabled.
> 
> [1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..2f4ac6ac6768 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -3,6 +3,7 @@ config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
>  	depends on (X86 || ARM64 || LOONGARCH)
> +	select NUMA_KEEP_MEMINFO if X86
>  	default y if ARM64

A fix is needed, yes, but this is the wrong one. NUMA_KEEP_MEMINFO is
only about marking numa_meminfo data as not "__init". Since
numa_fill_memblks() *is* an __init function, it should have no
dependency on NUMA_KEEP_MEMINFO.

The fix here involves moving the definition of numa_fill_memblks() out
of the "#ifdef CONFIG_NUMA_KEEP_MEMINFO" in
arch/x86/include/asm/sparsemem.h so that it does not fallback to the
default definition in include/linux/numa.h.

It should also be the case that cxl_acpi needs this:

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..1bf25185c35b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -6,6 +6,7 @@ menuconfig CXL_BUS
        select FW_UPLOAD
        select PCI_DOE
        select FIRMWARE_TABLE
+       select NUMA_KEEP_MEMINFO if NUMA
        help
          CXL is a bus that is electrically compatible with PCI Express, but
          layers three protocols on that signalling (CXL.io, CXL.cache, and

