Return-Path: <linux-kernel+bounces-49347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68276846909
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD771C2419C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0F1775F;
	Fri,  2 Feb 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL0dhUe9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09E175A9
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857860; cv=fail; b=ae101/k+f3wjUMjzyE2xV4TBd3bqwjTTDfK8ToHL9/ZacG6D9pFa4gBUpkEL26wWWyz1b3gjv8ovyzKA+/aVqfEH7jXD/6kculePbG/B0jc8wSD6MHWvkUNSgjgjcA6NIJbnLSukWa5GyLoWic2n/y7kENjdI8fhvr4+ToLcvA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857860; c=relaxed/simple;
	bh=L44EghzGOVdeDOenr2xiXgkWLRvqcw2BHVsaghM8Oh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AuhCnljp1hrdqn+T/Y1XLF4GI2TuGu5Blxz8MGBlsJ3Tir58PkJoJ0p4mxFwIq7hWIubrNN4qrgoboDhpYvmG1fujV8oWH5xvedQLTbl8M0+X7tECHIaXpzOpRZWlIJMLvtZxgPfljQ55W6u8tFwzOe3DYxEmeAwZsx1bC0x47o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL0dhUe9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706857858; x=1738393858;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L44EghzGOVdeDOenr2xiXgkWLRvqcw2BHVsaghM8Oh8=;
  b=aL0dhUe944zsIrKMwDXr/ExMEOiIGwMytH4NkyzkNAYbJ/ywozrXicK8
   iG3Gl6h20gAeIO/aKrxbiilLS1aknAjYOMdmtc7hm1hh2gmlCwhWZ2IV6
   eIgyen4OVIH48FZqBt9k5/juy3L4NR7CrQfVIcaDixCHKrOONzOEzYd9l
   HgmIA8Zg4C9rYTI7cRAet4MLtB3dxDRrEHa+oq5DoL1NT+SDcAT/Z6aN6
   8lCQeT7ZzRN8P9DsE4d8SuaRYVPB+v+7+HCh3t6/Jk64v9ysJjb8r7GnX
   qoJRzdzmvJ96/FuIX/9AkR592uLonBntAHMEWJ35kzlMpwuWr5U09hOMF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17475417"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="17475417"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 23:10:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="68842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 23:10:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:10:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 23:10:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 23:10:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 23:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmvuOoQIEj3mgBTlelbPpokeEITOdKvcdH+/Q5486IV6zBCt+DxTDcfzh+hcXV5UNV8cIpV40MIzsiuVubaWqa9VoqcuAhYCF9NoNL9fDE/upHyr0nzTPwLsDgDzpiS8jGdV2nD1eE55w5YObDC0vgobGpY+LZIBD6m824HIoAD0HqEdjO/FYPfKawRpR85FwBiHeXQFwKXatTPFFK9kfwur/4poFHtLVudbFUVKGduiCB0rTn6Gr5IrlFUI56nPO9pl9+V4fPrLN6c+5C77QmKN9sAvtfIFWYvGs3uAFBbDC5kl6fzI3LFwbXhY58+NGmlf6aL022Z7sCFkw3XodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHW/ynupBpAXY8iNTIYzE2+EKaZKVRuWe07GMqnl/CI=;
 b=gY/oaLXamDxv6UHG4GErnn9vJ0QjBZ9uEEXKgtI5C4t55K2uPiXffKYKPyEPfNoSbT8zWJofU+jTfw1GLKoCDAZldQBAxHDGXcNcol9tItDXVNBsvmj7S39sup+H2H2lOggKNXIuXdsyaWl0dT7RC2NqqS9H0V/smmDf2AjrvPg7LyqZTVxyxp4g4HuTX3GpX1zLz/wM1W1CrOLJnR7PMEuXOF15P3VQMUoUzUVB4jtzvGTw0j/6EaZKcUg0Armp2gfPnP10Vkq8xSPs+j9+rG94HLyyrfLDvklk456yRquRm19nMM0EKzaggiwvSf4bVEA/LDs53g51WqtCrSfd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5633.namprd11.prod.outlook.com (2603:10b6:303:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 07:10:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 07:10:45 +0000
Date: Thu, 1 Feb 2024 23:10:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Message-ID: <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e75554f-848f-419a-fd5b-08dc23be135b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsomPtEZx5tUYS98o1NVzPl/6IngDwEqfOqnwHzfJW/Mb6HoPMb1V+tv6Ge3DAan9T51gA3CATCJMIrHN7fv+PW+HK7qAJoBE07DM5C272yi4a5XTmmPbtoWcFYpLQKqHq3DXcmeZ3UY+wI4mJF+KcgzEpBr8O/iLtNtiRwJBLwa9wqJy5h1Qo4EOmKNYekr/cBeEd13Y/dWBzcPl4wWRQ2fTVtPNY3f7xBqNHSR2wf1Gaiqjvg4ciuoj3RauYYCVg8pj0YktSPjBVVoYLSjuoZNf8vfMK4UXfLnHI07wYRwIa6vBxGSpG5slPlfq6UqrfT+YAppCVynINX7PWe/zlN4GaHmJkK6/u1xwGDvTOcUJhD41D6JBylmuNZcQU1T2vPIQ9nJQVuV0cQr1IDTgxZiAe2gYpg5KUqYK6Tylu589qCDg2JxQX0sVM+nYiKel8ibItKaTI+nSWazEc367ZDrScgSANKxNvXev9EoeMJcMh8YewI4XyApUSWiMSo/3LQjk/eb7D5Lsu3SnCoZpfkhRoauIIKOE5aKlnIZn6rNd1wWeo/5rdaVWu6Ae+BPS8WtgPNfBExCQlfwMBYqqWCUx+4grpic10x9IsnMURQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6512007)(9686003)(26005)(5660300002)(6506007)(38100700002)(83380400001)(82960400001)(6486002)(966005)(8936002)(86362001)(478600001)(8676002)(66946007)(66476007)(54906003)(4326008)(316002)(66556008)(41300700001)(7416002)(30864003)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gl5NO2w//Ht3p3Ad1HfN0R9YmSqH0UMhRU0LtJCL5BKGHyVexhk2LyHQiuSp?=
 =?us-ascii?Q?I+xN9S62ynii8YMUxfWbgkec+58AUrIKYHEt93kl/QvueWGgstnkQXJ9Ye3T?=
 =?us-ascii?Q?xIPNKcEYY5g3LhmL0BhRvRPmn4P6NNVW3qhVSNiOa6d9jyM00mlUlakm1aLJ?=
 =?us-ascii?Q?xYmi3x5Hm5myoyocgaQGsIbSnuopzk/07bnsCzZ3OhBCXCPqdGfJKEDhU5Qz?=
 =?us-ascii?Q?ZTwiK7rdXdzxhMDd+UjbmxcHUzIQxcLIt0M+xg/x0TdbZXX33Nl5SBZos9Ji?=
 =?us-ascii?Q?GHhv83WB4y1XgLWkJEnk7A1dMI64fKfu+XIfL8hjvSqzWrVaooY0C5ien6El?=
 =?us-ascii?Q?67ROFvkLNJ7fkeNLrOJDAtUrV6OJ7DzMYgYpQwCltN8TUd4h2NK9uYb0+vqO?=
 =?us-ascii?Q?syVU2xVPN+YVZ+dsebmTKlE5riHS0bDslmr3qIsUJyD88iV4UB0rTN2OoPjJ?=
 =?us-ascii?Q?phWlK/rLBGTUKD8s6pdUZgI4vKXTMIoHUgOIFKOtiCiaD+AipQyzPTOHzZT5?=
 =?us-ascii?Q?X/uaOJkupG6szO/79y9O2w7ccfX/5hMkm51L20YVCTKwrAbWUcEnMRWEr8nj?=
 =?us-ascii?Q?s9ymZxEc3CpmXcvrC3S7ouVl1ZU14WosGkvcL6cdXZZESPiY7FuCjzqmso2P?=
 =?us-ascii?Q?dczDYEDBxdqec3yBtasqEZkr+HAQ5g/psEHbGIvCrez5ZlDaorO2wAcYdzRr?=
 =?us-ascii?Q?s2yuq4M8c+OX19szSRe5IqDYJx2D98DeE2zBUJ/EqeYGv+6/KYbbRlk1lep9?=
 =?us-ascii?Q?/djjg7e3Aiq1GegjsRhRf+Up+j3L3gs47l9tgPmztzi9WcIYeWqHcsIIqg44?=
 =?us-ascii?Q?GARij/BcEZ/rTiQAGJ4aBw0ubVX7YVefkVCnnGXrrKRgVWSuhmLRqYpHM6t3?=
 =?us-ascii?Q?ZZvYTdbKynSVDavvG76K9UxiKn4meYs5qwGhG4GZUlG67Q7j0nkIF0R6Zvat?=
 =?us-ascii?Q?7r3qHw63IQHb6g4SZ8Jk3xkF4GI6Z4R/BvuJZmEwWq4Qt3JcXntJwiesu2GS?=
 =?us-ascii?Q?I323mJvXEIo3xK9FSxNsJvOzxCpLGkW9qghuzmOZNWsZpe64nv9D0E76atXo?=
 =?us-ascii?Q?QmUldbdPwi3bsY7v3aJ30zjo9GRwUGfXTR4YBbYmfDdEAf3thK7BVyGwDvPr?=
 =?us-ascii?Q?OpzPDSVcL16G3QnziqKSEN8uvTD5Gc6i+MzGf9g/CzI9PJmPjBeCJ0Oy996i?=
 =?us-ascii?Q?EGkr/8R8n/kXu+E3xUF8rVkJ62tdEJsPh/i9f788jYgQM176uwu60JkjLdTN?=
 =?us-ascii?Q?QYQh4homWzQGGFn3T4dp2F708unjNFV6HHHOz5eVirc/cYc+DnzVSUPvuTE5?=
 =?us-ascii?Q?IOL/iGPwCupC3TxjMnL4q7YxS4AlzvFPeWMvlPps7BT/ZAjve+huqyCNKTOy?=
 =?us-ascii?Q?d40BFl0hCwEb9Nps5AXqpWuGAJ4wI/I3FzdjQ39hSn66wFan6o13lCe2awlx?=
 =?us-ascii?Q?SMHaV29ZDsijKvjuVS8rHyqho7/YxpjDs5o2HA6ko0m/kZonzkSax5sbR++P?=
 =?us-ascii?Q?bPqN+1bzxkv28Rofo+nC+3tDnBL5AGhL8spQYwqLUNPDY4O3Cq1EtjpL28/q?=
 =?us-ascii?Q?TMFtw0KQRQVlpSXsRLe61Cs92ksw4/H7y7v9X+iHLMRJiFsFr7b9GrktKVRD?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e75554f-848f-419a-fd5b-08dc23be135b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:10:45.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOUey+Q0CwO8n7EoMN1lD+rT95rOVlu5ICecWgJUGdr5/dlxyF9as0Jdde4gWlKIpmgkhtUdYHwLhyRdLQUJWtqQivEc2I2ZM27b/RihYcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5633
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> When an SVSM is present, the guest can also request attestation reports
> from the SVSM. These SVSM attestation reports can be used to attest the
> SVSM and any services running within the SVSM.
> 
> Extend the config-fs attestation support to allow for an SVSM attestation
> report. This involves creating four (4) new config-fs attributes:
> 
>   - 'svsm' (input)
>     This attribute is used to determine whether the attestation request
>     should be sent to the SVSM or to the SEV firmware.
> 
>   - 'service_guid' (input)
>     Used for requesting the attestation of a single service within the
>     SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
>     be used to request the attestation report. A non-null GUID implies
>     that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> 
>   - 'service_version' (input)
>     Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
>     represents a specific service manifest version be used for the
>     attestation report.
> 
>   - 'manifestblob' (output)
>     Used to return the service manifest associated with the attestation
>     report.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
>  arch/x86/include/asm/sev.h              |  31 +++++-
>  arch/x86/kernel/sev.c                   |  50 +++++++++
>  drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
>  drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
>  include/linux/tsm.h                     |  11 ++
>  6 files changed, 376 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> index dd24202b5ba5..c5423987d323 100644
> --- a/Documentation/ABI/testing/configfs-tsm
> +++ b/Documentation/ABI/testing/configfs-tsm
> @@ -31,6 +31,21 @@ Description:
>  		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
>  		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
>  
> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) Optional supplemental data that a TSM may emit, visibility
> +		of this attribute depends on TSM, and may be empty if no
> +		manifest data is available.
> +
> +		When @provider is "sev_guest" and the "svsm" attribute is set
> +		this file contains the service manifest used for the SVSM
> +		attestation report from Secure VM Service Module for SEV-SNP
> +		Guests v1.00 Section 7.
> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

I wish configfs had better dynamic visibility so that this could be
hidden when not active... oh well.

> +
>  What:		/sys/kernel/config/tsm/report/$name/provider
>  Date:		September, 2023
>  KernelVersion:	v6.7
> @@ -80,3 +95,43 @@ Contact:	linux-coco@lists.linux.dev
>  Description:
>  		(RO) Indicates the minimum permissible value that can be written
>  		to @privlevel.
> +
> +What:		/sys/kernel/config/tsm/report/$name/svsm
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Attribute is visible if a TSM implementation provider
> +		supports the concept of attestation reports for TVMs running
> +		under an SVSM, like SEV-SNP. Specifying any non-zero value

Just use kstrtobool just to have a bit more form to it, and who knows
maybe keeping some non-zero numbers reserved turns out useful someday.

..or see below, maybe this shouldn't be an "svsm" flag.

> +		implies that the attestation report should come from the SVSM.
> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

So this affects the output format of outblob? I think @outblob should
probably document the fact that it depends on @provider, @privlevel, and
now @svsm. Probably all of the format links should live under @outblob
not @provider.

I worry that "svsm" is not going to be the last name for a selected
family of services that might convey something to outblob. I wonder if
this should just be a generic "service" attribute where "svsm" is only
supported value to write today. Another service family could be
introduced later and reuse the service_guid concept, or kernel gets
lucky and a de-facto standard heads off proliferation here.

> +
> +What:		/sys/kernel/config/tsm/report/$name/service_guid
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Attribute is visible if a TSM implementation provider
> +		supports the concept of attestation reports for TVMs running
> +		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
> +		(00000000-0000-0000-0000-000000) requests all active services
> +		within the SVSM be part of the attestation report. Specifying
> +		a non-null GUID requests an attestation report of just the
> +		specified service using the manifest form specified by the
> +		service_version attribute.
> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

Given the small number of service GUIDs so far perhaps save someone the
URL fetch and list it here?

> +
> +What:		/sys/kernel/config/tsm/report/$name/service_version
> +Date:		January, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Attribute is visible if a TSM implementation provider
> +		supports the concept of attestation reports for TVMs running
> +		under an SVSM, like SEV-SNP. Indicates the service manifest
> +		version requested for the attestation report.
> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

Perhaps document that version 1 is assumed and is always compatible?

What prompts new versions and how does that discovered by guest software?

> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index b126e50a1358..4cafa92d1d3e 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
>  	struct svsm_pvalidate_entry entry[];
>  };
>  
> +/*
> + * The SVSM Attestation related structures
> + */
> +struct svsm_location_entry {
> +	u64 pa;
> +	u32 len;
> +	u8 rsvd[4];
> +};
> +
> +struct svsm_attestation_call {
> +	struct svsm_location_entry report_buffer;
> +	struct svsm_location_entry nonce;
> +	struct svsm_location_entry manifest_buffer;
> +	struct svsm_location_entry certificates_buffer;
> +
> +	/* For attesting a single service */
> +	u8 service_guid[16];
> +	u32 service_version;
> +	u8 rsvd[4];
> +};
> +
>  /*
>   * SVSM protocol structure
>   */
> @@ -217,6 +238,10 @@ struct svsm_call {
>  #define SVSM_CORE_CREATE_VCPU		2
>  #define SVSM_CORE_DELETE_VCPU		3
>  
> +#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
> +#define SVSM_ATTEST_SERVICES		0
> +#define SVSM_ATTEST_SINGLE_SERVICE	1
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  extern void __sev_es_ist_enter(struct pt_regs *regs);
>  extern void __sev_es_ist_exit(void);
> @@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
>  bool snp_init(struct boot_params *bp);
>  void __init __noreturn snp_abort(void);
>  int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>  u64 snp_get_unsupported_features(u64 status);
>  u64 sev_get_status(void);
> @@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>  {
>  	return -ENOTTY;
>  }
> -
> +static inline int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
> +{
> +	return -ENOTTY;
> +}
>  static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>  static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>  static inline u64 sev_get_status(void) { return 0; }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 849df3aae4e1..83bc5efa8fcf 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
>  }
>  __setup("sev=", init_sev_config);
>  
> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
> +{
> +	/* If (new) lengths have been returned, propograte them up */
> +	if (call->rcx_out != call->rcx)
> +		input->manifest_buffer.len = call->rcx_out;
> +
> +	if (call->rdx_out != call->rdx)
> +		input->certificates_buffer.len = call->rdx_out;
> +
> +	if (call->r8_out != call->r8)
> +		input->report_buffer.len = call->r8_out;
> +}
> +
> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
> +{
> +	struct svsm_attestation_call *attest_call;
> +	struct svsm_call call = {};
> +	unsigned long flags;
> +	u64 attest_call_pa;
> +	int ret;
> +
> +	if (!vmpl)
> +		return -EINVAL;
> +
> +	local_irq_save(flags);
> +
> +	call.caa = __svsm_get_caa();
> +
> +	attest_call = (struct svsm_attestation_call *)call.caa->svsm_buffer;
> +	attest_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
> +
> +	memcpy(attest_call, input, sizeof(*attest_call));

*attest_call = *input? Just to save that little bit of reviewer
brainpower wondering if these things are the same type and size?

> +
> +	/*
> +	 * Set input registers for the request and set RDX and R8 to known
> +	 * values in order to detect length values being returned in them.
> +	 */
> +	call.rax = call_id;
> +	call.rcx = attest_call_pa;
> +	call.rdx = -1;
> +	call.r8 = -1;
> +	ret = svsm_protocol(&call);
> +	update_attestation_input(&call, input);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
> +
>  int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>  {
>  	struct ghcb_state state;
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 1ff897913bf4..3693373c4227 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
>  	u32 length;
>  };
>  
> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
> +{
> +	unsigned int report_len, manifest_len, certificates_len;
> +	void *report_blob, *manifest_blob, *certificates_blob;
> +	struct svsm_attestation_call attest_call = {};
> +	struct tsm_desc *desc = &report->desc;
> +	unsigned int size;
> +	bool try_again;
> +	void *buffer;
> +	u64 call_id;
> +	int ret;
> +
> +	/*
> +	 * Allocate pages for the request:
> +	 * - Report blob (4K)
> +	 * - Manifest blob (4K)
> +	 * - Certificate blob (16K)
> +	 *
> +	 * Above addresses must be 4K aligned
> +	 */
> +	report_len = SZ_4K;
> +	manifest_len = SZ_4K;
> +	certificates_len = SEV_FW_BLOB_MAX_SIZE;
> +
> +retry:
> +	size = report_len + manifest_len + certificates_len;
> +	buffer = alloc_pages_exact(size, __GFP_ZERO);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	report_blob = buffer;
> +	attest_call.report_buffer.pa = __pa(report_blob);
> +	attest_call.report_buffer.len = report_len;
> +
> +	manifest_blob = report_blob + report_len;
> +	attest_call.manifest_buffer.pa = __pa(manifest_blob);
> +	attest_call.manifest_buffer.len = manifest_len;
> +
> +	certificates_blob = manifest_blob + manifest_len;
> +	attest_call.certificates_buffer.pa = __pa(certificates_blob);
> +	attest_call.certificates_buffer.len = certificates_len;
> +
> +	attest_call.nonce.pa = __pa(desc->inblob);
> +	attest_call.nonce.len = desc->inblob_len;
> +
> +	if (guid_is_null(&desc->service_guid)) {
> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
> +	} else {
> +		export_guid(attest_call.service_guid, &desc->service_guid);
> +		attest_call.service_version = desc->service_version;
> +
> +		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
> +	}
> +
> +	ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
> +	switch (ret) {
> +	case SVSM_SUCCESS:
> +		break;
> +	case SVSM_ERR_INVALID_PARAMETER:
> +		try_again = false;
> +
> +		if (attest_call.report_buffer.len > report_len) {
> +			report_len = PAGE_ALIGN(attest_call.report_buffer.len);
> +			try_again = true;
> +		}
> +
> +		if (attest_call.manifest_buffer.len > manifest_len) {
> +			manifest_len = PAGE_ALIGN(attest_call.manifest_buffer.len);
> +			try_again = true;
> +		}
> +
> +		if (attest_call.certificates_buffer.len > certificates_len) {
> +			certificates_len = PAGE_ALIGN(attest_call.certificates_buffer.len);
> +			try_again = true;
> +		}
> +
> +		/* If one of the buffers wasn't large enough, retry the request */
> +		if (try_again) {
> +			free_pages_exact(buffer, size);
> +			goto retry;

Is this expected to ever go past 1 retry? Fail after that? It would seem
suspicious if the untrusted host kept asking the guest to allocate more
and more memory. Is there a reasonable max that can be applied to those
buffers?

> +		}
> +
> +		ret = -EINVAL;
> +		goto error;
> +	case SVSM_ERR_BUSY:
> +		ret = -EAGAIN;
> +		goto error;
> +	default:
> +		pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	ret = -ENOMEM;
> +
> +	report_len = attest_call.report_buffer.len;
> +	void *rbuf __free(kvfree) = kvzalloc(report_len, GFP_KERNEL);
> +	if (!rbuf)
> +		goto error;
> +
> +	memcpy(rbuf, report_blob, report_len);
> +	report->outblob = no_free_ptr(rbuf);
> +	report->outblob_len = report_len;
> +
> +	manifest_len = attest_call.manifest_buffer.len;
> +	void *mbuf __free(kvfree) = kvzalloc(manifest_len, GFP_KERNEL);
> +	if (!mbuf)
> +		goto error;
> +
> +	memcpy(mbuf, manifest_blob, manifest_len);
> +	report->manifestblob = no_free_ptr(mbuf);
> +	report->manifestblob_len = manifest_len;
> +
> +	certificates_len = attest_call.certificates_buffer.len;
> +	if (!certificates_len)
> +		goto success;
> +
> +	void *cbuf __free(kvfree) = kvzalloc(certificates_len, GFP_KERNEL);
> +	if (!cbuf)
> +		goto error;
> +
> +	memcpy(cbuf, certificates_blob, certificates_len);
> +	report->auxblob = no_free_ptr(cbuf);
> +	report->auxblob_len = certificates_len;
> +
> +success:
> +	ret = 0;
> +
> +error:
> +	free_pages_exact(buffer, size);

I was going to comment that mixing goto and cleanup.h helpers can be a
recipe for confusion, but this looks clean to me.

> +
> +	return ret;
> +}
> +
>  static int sev_report_new(struct tsm_report *report, void *data)
>  {
>  	struct snp_msg_cert_entry *cert_table;
> @@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
>  	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
>  		return -EINVAL;
>  
> +	if (desc->svsm)
> +		return sev_svsm_report_new(report, data);
> +
>  	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index d1c2db83a8ca..33fa26406bc6 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
>   * The attestation report format is TSM provider specific, when / if a standard
>   * materializes that can be published instead of the vendor layout. Until then
>   * the 'provider' attribute indicates the format of 'outblob', and optionally
> - * 'auxblob'.
> + * 'auxblob' and 'manifestblob'.
>   */
>  
>  struct tsm_report_state {
> @@ -48,6 +48,7 @@ struct tsm_report_state {
>  enum tsm_data_select {
>  	TSM_REPORT,
>  	TSM_CERTS,
> +	TSM_MANIFEST,
>  };
>  
>  static struct tsm_report *to_tsm_report(struct config_item *cfg)
> @@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
>  }
>  CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
>  
> +static ssize_t tsm_report_svsm_store(struct config_item *cfg,
> +				     const char *buf, size_t len)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	rc = try_advance_write_generation(report);
> +	if (rc)
> +		return rc;
> +	report->desc.svsm = !!val;
> +
> +	return len;
> +}
> +CONFIGFS_ATTR_WO(tsm_report_, svsm);

Modulo whether this should become "service" per above the rest of the
configfs interface changes look good to me.

