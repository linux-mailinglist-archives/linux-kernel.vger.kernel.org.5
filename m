Return-Path: <linux-kernel+bounces-150349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479468A9DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A8D2818DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162616ABD7;
	Thu, 18 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVvQm5yN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE538F94;
	Thu, 18 Apr 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452270; cv=fail; b=If+MSYnjCpeVEZk8FIPv11mLeZOB3XBAvE4UMQxXuSxxTcvwUHBw+/NNZAlEqZy3EDmPAnQInvIJ0OsHecMgyUxGPr6bi9yya01yPx4cyKQvIvDa321LYZJJKYH41QEP2pfvkyrGNUxIfF9Gms3NrC8S1/CvOvNZrrGPFnurD6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452270; c=relaxed/simple;
	bh=tButTGFPB0vnWjXAOdTfOkgogtnJIJJK/5QJ1ITI6YM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8JkoDGdt+gSEWiJ1OTeLnTmbcK2t+e87xoPJuo8fQcTMPO5E9zE+eLVGy7pRCaQw0ivQ9MP78TKfJ4uEig9xGEUx9H26BX1QbmT2E4kxkOF7Jb2z01gfakz6gaTnc6Es7CpBMZFPfp40rqYRcacYhPAbKSlxbvGxnYPDMhvvv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVvQm5yN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713452269; x=1744988269;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tButTGFPB0vnWjXAOdTfOkgogtnJIJJK/5QJ1ITI6YM=;
  b=cVvQm5yNdKu2S6P9AVX4JFPo6JWWZH5CKIA1RmZ+JclWtGp+o8+1iD+S
   mncazlycihUa43J2YMhu4ImIdqhUPikJ93/jhiLb0VP4Sity738crV/m+
   AX9pPkmvAAOwncTwVdp4+fl95sDovnBM0DawvDCTpmBnczRYKwcLlpLuE
   y6YDkfwmW/3FZAfJDAgOQWTi9NxtDRiqwBqICd9+Ec+5YbfK2O9grmL9o
   gfK5Xoq3X44QLnDOBg/OpN9x8GxvdBJVvQ2iVMNC7ueGKcaGewii/dcLs
   s6CPEpWxPd/ukarXOmJahPCczorg9g2M9SzOpP3SofE6xIv9DNxjRT04u
   w==;
X-CSE-ConnectionGUID: lE/EiNrgSm+E0rxdtDcytg==
X-CSE-MsgGUID: tnRUnu2kT6Wt1mEuKBt3ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12792099"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12792099"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:57:49 -0700
X-CSE-ConnectionGUID: F+AWsDu9SHyWCRma4hFJkg==
X-CSE-MsgGUID: Hf7nw/S1QaecEWX7myyjXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27671873"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 07:57:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 07:57:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 07:57:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 07:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx7qXtwt/OjRiN+NtSntLYiqMX2WGM6JEjVkjdMrX2HyJu3NtVZO530zCl8oeK2qj+F15n9fzxSWyzAkHKzR8XN+1xmZ6H8/XCAHcl0WJKWImZbUliYC5vHcdJa3y1urs5yrP+kASYl7gBQOpimpHZLQZIQDKfnS2GiBCLyFup4aUqLSfM5ZzQO3W7W5Nw8ybSBI16F5FotCW2Xq3x3NvZ5kKkV5wTk0mjxKPah9Ogs4nI6MV/nU0JucCqq1KiF8oUwBCMoWbHIUggrsZl7zHZZf/e7i0ETe19bFm4aDFuy/n3j6XvwP/R8coBkvh06sb6dXEgzi6X8PUIblZtFwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3tyaqlI/I+Bgm08thfRpd/WqyyeWnCtduAok5QwMM4=;
 b=Y9fUFWbVFMpMbNypMzx/johFmUlVN3raRWJ2kK7XerdV1OkDJb8hOvYsvu9GfgOY3FuT0cxhepoIV0+dybZOpencV0WgF1jOdq9RM7TczibII+QTZtkz0xTFYj9NPkpuSTUTxT0Z3Ii3YhU8tIyh0lE5xahI1b6KOY+3yuYrtC0dCM2bDLUFaqJ/VM1bZCIb1muNmD/wkSRYyLheRhS34SnrtJOofVYrjrBpeN6NG7ZIszXppmYMbfQMNmX6Frm6ASUcH72RcEzLC7F/oxv1qpBBjxtEM56eszyncMw/ZKnywUleE9mHdU0kTioOj84/19qB6EeYEoW4NAvP/Ufjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6320.namprd11.prod.outlook.com (2603:10b6:930:3c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27; Thu, 18 Apr
 2024 14:57:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Thu, 18 Apr 2024
 14:57:40 +0000
Date: Thu, 18 Apr 2024 07:57:38 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Li, Ming" <ming4.li@intel.com>, Terry Bowman <Terry.Bowman@amd.com>,
	<dan.j.williams@intel.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/6] PCI/AER: Enable RCEC to report internal error
 for CXL root port
Message-ID: <662134e290d89_5eec229450@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-4-ming4.li@intel.com>
 <7172ec2f-7cba-460b-a6c6-9fff45ba938b@amd.com>
 <b4a721c2-567d-4ab3-8a85-963e3f323e61@intel.com>
 <91ddd182-cc71-480f-a1b2-e7c31b29a549@amd.com>
 <f0b85a37-ead0-4954-b7e0-dd09cbd9ab09@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0b85a37-ead0-4954-b7e0-dd09cbd9ab09@intel.com>
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: c605e8d0-09b4-4e5e-cc40-08dc5fb7e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uifdoYdqaXzX1IUEnGSTD5t6/hNQbV5/lGUfff/xNxU3Eolh0W9dgnHxJiJobGA67EoDdHNwAQ6KZX/KjcsbKmIGkCks+kv4PsMJQhQ9ihfcDJ1o2EtnDX+msDVe9o1Sm88Pg5FTBbElS0KJsaWSayWD2bcuRZEzRqfIV8n7NOxpsg5K2VZhWlrOYLGwpp1X4uTeTJD7gW4qKCH7wL/G58srxXxSJ/6+VV7r5dHCjS3sKhA81W012dgI98VZyJPce1j6BXJLcjzVHBcmmv1VBSzCsHmlejeV3SvrGlbhqy1YqJcs1lNecMquuBB6TRM9yyBAAdMg8tseAclUfUB8ZRunACQArAjirPgQagO8o90x2gXc9CYOKH386Gd1x+6Dkpa2HsGVnyGU55vNe1MHGWCvfq3drbz6pwUp5+5USjou1DjV0f3sudQkIm4/6bZnzuUDIcCLYi0nsBV2hA2zqWduV6FdS6IMfSb1hFWFjWmaMRqgVi4y0CZJJd2P+R8VeXgUsJOGLGkc6hschG68c1/ND1yhWChtoaFMbBpfRjwGz1dVAgWy4WIapBPlmoCXHhkovo6Y32QtqnZd1e0nXreXUlDk1EkbUax85OwVW73HAS0i0gNEYXCX4jJUVN9fx2UGBsuQyXok7Jdk5SpYzfeGY1cJ/mWsx//xAkxQx1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrzSAvNjFKXVeab+Q2CNrsHswihODtb68LGzDx+zx9Owf+qKd9TO1GNleZDx?=
 =?us-ascii?Q?cMrZBNlIrPxlyUEwwcVqZX9KDz1BDxHEiG047MDhQlOvK7DaBKhn9TGiDHIt?=
 =?us-ascii?Q?tu/1jwgzxQ5n/IokkHLmHxqBeZaZAa49kvEyi0HU6Le0+jRZrT+0Uxja1m5s?=
 =?us-ascii?Q?VKZ3n/gvGfZumKXrINy/+1TXczynCWKpIoMPzdGrwfpYgu9Y+o7J3vKBhm3i?=
 =?us-ascii?Q?1OAtK59PF7hDHXHK+mUaAMz2+S5bSEl1hsOLAzvGrstvY3UUxj1NLBlwLClB?=
 =?us-ascii?Q?kj5G5nqpcZUvUsaEmaJNjHh+JwZRnO1NibdJspHjtb5lUvp7l+yq6y/zZvfj?=
 =?us-ascii?Q?wwEkt0rLr2UwBgQWKeOuVRd7RQYd5YBSxPMuPrtraIvLLwAJw7WKKG/YICz3?=
 =?us-ascii?Q?b0v8fNpHhR7vtLZ2YsUcGpGG/WZOK2Rf/F+jwF624VQwqykh3LnJMAssTWLJ?=
 =?us-ascii?Q?7g1kVA4iAjqiadyW/QoYciAiPdr/PbiRpweRfJKmwyiR6SCgAennWZV+bOBs?=
 =?us-ascii?Q?TIsjP4Ds3H0rJ3EjLkTKzHw6Yc1MeqFOUr6DHnfVHsS7qGkgj6NxolY5vsBS?=
 =?us-ascii?Q?nxRFI6w5/JoXrCiXSjzy67KzdF50FTM3xZKGKZW0oOC7IlwWr8oxOO8vwZrP?=
 =?us-ascii?Q?5sMSgpoYYnUbaTzD81ebwrG7GdmJnVXoF6msKosjzObfyX+czyerl880/2am?=
 =?us-ascii?Q?KBhxYGGnd5uUZkEsoG8LGSWS/8tNvJAq7FoBZREhXumzT3Rh+Blcm+SMDj1J?=
 =?us-ascii?Q?5lz8HcXr8QNQrGe/O/wI31LS1bzHRKd7952Xfzowr97u1pGLTglrbdvG3Kvm?=
 =?us-ascii?Q?YEiremX4j2xcIMyQq7SeuzzCv+dcP03a3eGPnwGZa0nBp2xELUEa/ySy5ul3?=
 =?us-ascii?Q?ZoivOnHwftnvQGIcyjtf9gGucLD+AVfwc8h8Ga9+L/EP1nIO0vTPzCXl52Gr?=
 =?us-ascii?Q?u1H8qqyouBSI8EZaS7OqpHOvkuWptU98Ny++pSDoTWaI9BLMislfWtjpnDSM?=
 =?us-ascii?Q?dWSS4Vrasl1bN2agJzsRh7EBv4NfHFzxnVY0jmmIqHE3NbLYOEJxWgL+ZlVe?=
 =?us-ascii?Q?JcBS0TnfQPBd2uwIPsNjM9a/1BAdtYHEzrH7k+aqI7zaBnB2L+GNHeKoUDce?=
 =?us-ascii?Q?SbneOsnm6PWzHJZuI0eqiCO343zLFvaEMVJWL24ft5mX+PjUKRDKIMJwnXNP?=
 =?us-ascii?Q?u2WbsecfHmJeCwA0dGgq21sBpcSlByAXfwy2tNWAJN5nm0gJJQp7F0oHYl8Y?=
 =?us-ascii?Q?EYFv47zQmQ6NNCGHBP50cFfVRpYbbc+Fij+rT22TlwVYvYraKTP8pzhGtN6N?=
 =?us-ascii?Q?Hss1c4o9GFMm2dDiAwUZrO7zRzyRWrd7apeBlMyz1irrGInAcxcGj0TS5djt?=
 =?us-ascii?Q?O45HXgVQYjXfl4JuKl9jENUKyAUGKe1XJNAXeIiNrHNs3VcwTSESK0AFkt/1?=
 =?us-ascii?Q?FkAsklwcjedwog5qeNZcr1RpnJr0t3f4R8o21+HK1VQAzE6LHgLA/DdKAQQJ?=
 =?us-ascii?Q?n+SnDWKK8zZdPurpEJRt3ue+h3rGyW7jVkliQD3RvsSkk3Ptc6dJbrHU3h6C?=
 =?us-ascii?Q?L630g6/0JWY9MhEGuYpyiBLIeztAlBE/pw3iyYq17M9JaEx5vBSqSbdx/e7E?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c605e8d0-09b4-4e5e-cc40-08dc5fb7e4cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 14:57:40.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHSZLZjVaOojWUtRbA+Low+c7PA7dzgFYQDAB1/QJhgj6Gy1gg394Ton5xY9TgGlIHbMwG53XpFX/08XdC48cyYjTwIxEvgNgLqj8is3awM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6320
X-OriginatorOrg: intel.com

Li, Ming wrote:
> On 4/16/2024 10:46 PM, Terry Bowman wrote:
> > The driver support is much simpler if RCEC does not handle VH protocol errors. Is there 
> > a reason to forward root port VH mode protocol errors to an RCEC rather than consume 
> > in the root port's AER driver and forward to CXL error handler? 
> > 
> I agree that is simpler if only root port handle VH protocol errors,
> but I think that software has no chance to choose if VH protocol
> errors reported to RCEC or root port, it depends on platform
> implementation. So I think we should support both cases.

The question is whether the CXL spec RDPAS behavior causes any problems
for platforms that follow PCIe rather than CXL reporting flows for
root-port errors. I.e. does it cause problems if Linux starts scanning
root ports on RCEC notifications?

I do think the lookup needs to change to be based on CXL host-bridge
detection and not CXL-type-3 endpoint detection, but otherwise it looks
like CXL spec wants to invalidate PCIe spec expectations.

