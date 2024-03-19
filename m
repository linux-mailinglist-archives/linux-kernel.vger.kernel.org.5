Return-Path: <linux-kernel+bounces-107303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC787FAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963041C21B79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7157D080;
	Tue, 19 Mar 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl8IfjVt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF5651C28;
	Tue, 19 Mar 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840816; cv=fail; b=nqezNG6JuWUDNh/eup5LlLtbiUYA48iys5wGa3cxnCktxDA01Vij8xxqjX929vror6KYFMAIUOVd5yvVheTX1cIP1N2qT4CBZLRBR1af8smhD0Vlp06izKy6h7wtgQadgclVVC3rCceQY9lhJhQbN6IyrCHmYUEv0yNFqCeJ+k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840816; c=relaxed/simple;
	bh=CoAMQBBCdX3rEvZdw8DG/7zjxwgxsQa3UyiQIfBhRNo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GFfEfsJtSMpW6a5qjISnVv+KcTRMXWo+/mcj7z/0mgcUvDG2F64nW1QohV9/Dw9aBbYSp8LscHnohcoT4Td98+2Q34vNaHN821q6JW/Y8u8BRjjtUe/kjxmyWF2FhTrdSxTw7MQDAj19qJn8nLky2XlNNqIi4qZYBHGzvRp5RwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl8IfjVt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710840815; x=1742376815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CoAMQBBCdX3rEvZdw8DG/7zjxwgxsQa3UyiQIfBhRNo=;
  b=kl8IfjVtO3n8UyfshEpzATxsutA+83ksuYmTn2bd12+9AH3PwySUZHBm
   XMfeuYExiozeVucrg7YF+o2qWH05QibaaNI3AWUY7GDz+E0KfMvp47BWl
   g97nV9DfGnP+DbmhZRtvFuTmBWW1KSoiDTUORzf8NqHaVUwNXNJaoZVsZ
   34yzNcng/Cy3DJGVkBdrwbf0vWTIScD6BjgP499hacmwgn8ERrXfG+sYT
   6CCezBhzoBF8GW3GwczJ2pCI1bQSukttNo7GCVsgHFEx4AcK3FGrD5T+u
   uHPHiwBUTc5Q7sXgVWqvboXcKYpejpBNAGQ2+sYYQp+5Lk4VAYboBEPhn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5562543"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5562543"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="14137897"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 02:33:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 02:33:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 02:33:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 02:33:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 02:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ0kJVunTP5vgi+vSil9e6QfqtdQRWNKUBaefKWjx2Kse8yAYfTZvt+gVsTRdbC+LfvvGleZBd0G1XfeTCz36nV2OeGhFtF5e/9oD8nor3TSaK0YbAPfVnExG4As7aEc07SM+0Ub/I1edtRsnO4OYxrpqp3JzOroRzHa7MJsI9HrVEV1uXZxfStV9dfGryFbwsvax2/bZ1ew0HaZ02Mect232iVcoPPs39TxJyBCo8C0L39fUW26bIK+5QiqdrV3YykrODtSOVADoCVS48L4I7THj7QiUw8ZiY6c/WkdAYzaONGiSa8m8HJfNWvwLMCo0yIMwhGey3x9/4bb8LuPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/nJvmTWhz2rk+6RhwbaDDSEK56DEpeekfRJ60au6Ro=;
 b=Ts/6mgthTCPEoyPBLp+J5R3X/etT/3RcxxwzR7vQYdQCA8pg2LLlhyWt4MON5lnQOhzSpt/bmoPpTrxwAO1ZGS2jnKn2KjG1lJLLMCoBCavkLd6+dyv4oPiPaG4fi2Bp/n7mKsT2GBi/mfnaoMTJopg48A4ePSeclDvotCq9IHmYmOK+IhwYpDD3O53biG1SUrJ17dwVYRn7q+EyAI9DsshCscLrpH+G1+XJKPjTGP3eF8LPoOX2V9J+44jt7ascipp9/MM0GpHXHu1njGl9/wKX6Oam6lm5n3b43UVNLNpl0wt29H3RA61bJ3uafBhX/ZZcDQFUJ7hQ2n3ow3in/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 09:33:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 09:33:30 +0000
Message-ID: <e7727b4e-c173-4edf-8d8e-a9dc00ba7653@intel.com>
Date: Tue, 19 Mar 2024 10:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC kspp-next 0/3] compiler_types: add
 Endianness-dependent __counted_by_{le,be}
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <linux-hardening@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Marco Elver <elver@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
 <202403181038.EC9DF8CE3C@keescook>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202403181038.EC9DF8CE3C@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZJeITvnlVwVQP/gm0NRAuq4rn5Mo9KlXIsQPatAgYBkeSo6f9i9jcwSjwecr9nN9PNtLc3CrGvyq4Wi1QqxHwPR5E50ANgkKIP/GH8RZzA76FwYF/h7xb5sGH2cAkzM+FsAMQ9+a4Yr+DPlUiWfdxqAjg+bd3awFXUCQbyylXuedXANC2WYcu89fr/+JODhp/3gc5JN/xI2+CX0uE5okia61IfBb5dhEeZc0EdxHy2UtnVMv8MgZftYbP/D7Zk8Y9d/hNJZb3dsQlDrDk48FFdHKJx8oFqcRgIcd46f+NJmscNFl86HeGAtv/ICt4gIURlvWNx0pYQQlufyj16UhQDdsewfIOOHaCHgINg3K2aeKQJnbERHWk6PaX4IUsfgS0EQnJ1666Wut6LuFyVYltrWsi/dLkHNyM8X8Pq5eMxIAJx0NqffUo3mwuUwdQ6qtf2X6+Qx4Rgjvx0sM0yis2WKTeRVEN8REVjA03hsbGqK9AjzacP6SdGiFx3XrVUbWxJix4p5a57vbFe56HfDOWNO1cP+5M6Usm54kBbm6Yc0mTbgIlaer68oWMsXpUelQtNFRyuQTwhTrWqIQ0Vegf1rdGwrRCbG32lzpqg8p0OEktBp8Lw6W1zoAxLVXGoKIVT5W33QT+/VaqBxfiFKY5ldoMXRZJA22wCXWXVsOhU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBlK00rRko2UEN4OFphdEN1bjlMS1RlYXVJWHJCZjRPSWxEU3E4SG9PWmhi?=
 =?utf-8?B?Y0dzRTMwVUtMVjBRSzZXUkhOR3pXZEZaMFo2QWxmTk91V2lXcDB1aGZ4cGp2?=
 =?utf-8?B?Z3Q2WWk3UFFjSGpsRVVpVURERWdOMDE3OXcrSFdKSFN0Tk83U2IxMTE3Rms0?=
 =?utf-8?B?eFI4Qk9RakRjdDJGUFdueWM5MjRiUVk5dFFmTFZ6Y29IMG1kQm1wamdHYUo2?=
 =?utf-8?B?dE1uTk4wMUVMQ1krSDFyZ3pUcEwxc1FCRjUraC9SL2xMWlBhNUVCekl4cUNB?=
 =?utf-8?B?SE5jb1NOdEdYZ29JZStvWTJwWVNwV2g5NGtiM1JGeExEZTZOVG5rSi9JRDV6?=
 =?utf-8?B?NlpaaE93QWU5RWlxRi9kWlk5Mi81SlVCYXBnakVqNXJaWnBXNzhsNzIxN1R0?=
 =?utf-8?B?aVBuT2xkeGpoYnZvL2RYNlo0TXpHQW54RkdvSHJvNWpCeEZ4eFdWZVN5RXFV?=
 =?utf-8?B?c1o3TytMSGdIVk9qZjR6cGpodTAzN1JoamczWlFlUWZmRDJ1MXpnZGxia2FJ?=
 =?utf-8?B?OUtqR2x6enc3YWcrRE5lY2RGVjZxb3EwZjkyY2RFcVpIc3ZFc2RIbXE2TFMx?=
 =?utf-8?B?T01ocENCd1A2b2w4WDI1ejN5RkhCbGNkdnFTQkpSVVNmdzhGcldsL0swT2Rn?=
 =?utf-8?B?YSs2eTE0cS80TUxwdlJEV1B4NHZhbGU4UkNvaHRKMkZvSnZqcm83Z092Zit3?=
 =?utf-8?B?OFRvbnBJVS9DOUI2RjREMHRwSFJYSk9qTkF2RjMybVRNRXpURm9leEkzNjRo?=
 =?utf-8?B?dHpZYUhiQUxIQU5NRE96b0YxNXJaN0l0NUt4bW5HdFdra0U4aDIyWTRkQzZI?=
 =?utf-8?B?NGNUL1U0NnVKN0pkQWtYRUdMMWpuU0k0UlpERUFMelFBc3lObTlFakdENVdu?=
 =?utf-8?B?NC8wRC8vUnZhWi9MNHdxSUJsenJUck9vaG9QMEFhemZEck9FSG9hQ1dPVGRh?=
 =?utf-8?B?NVJQclIrZFZ5N21UU0QxQW01RE1SVW15NlhlMUdFa0RVWU9VWW96anEyaGth?=
 =?utf-8?B?aU4wQU5Dc2UrTmtMRW1JV3RCZU95VVFHc3NQaWR3d3V4N1dWVUkrL3UwMFJX?=
 =?utf-8?B?NmIvbmUyYTA0QnlBM3RTeWZKYjFEUUNGWmxRUEtWSnpyejQ3R3c4WEY0eTB4?=
 =?utf-8?B?NXUwalY1TDl4OW9YemNsTHNzNWFPTjQreXFHVjNFYmx5am1GVHI3SmV1M0l6?=
 =?utf-8?B?dFJWczZvNGE0amZ4RzVhZ2hDZFFweHNhOE5lTFZMZ0lXTEZaTGNsR2VqNkZz?=
 =?utf-8?B?ejZZYVo4akMyZnZNM1QyRk4wTFdIa09xd09DY20wcDkweVc1dktETWM0OGtW?=
 =?utf-8?B?dTFzeUszS2V0RytvNXBVa2RRRndMODNDM1RKWW1jVEV4YW1DSWw3cXVIQnVn?=
 =?utf-8?B?YmZiWWVhR2o1YVJUZUM5eDFrMUFicFM2b0c5d0ZmUU11YkJsUWs5ZXFuanVU?=
 =?utf-8?B?Q1k1ZVVPbGUwRWpzUHRmTWt4WFQ0MzVvN1JRZm9tRGNPTDU3dXVWb3FaY21L?=
 =?utf-8?B?eDNwaWlhWjNtQzN3WGt2OHRjT2lXaUZWM1lRV2ZMdCtBSHIwMWgzZDNuMUFo?=
 =?utf-8?B?eWs0ajB5MzRBZEc1VWUxdU8zYlI3TUhnaHR5V01LK2tiVXVUZzZaUVVjWnBB?=
 =?utf-8?B?Tmp2SE0rN2UrNGcxTDBRMnc4bTh5bTVKOURZZ2tuV1RCZlYzZzRuc1czeEh5?=
 =?utf-8?B?UzJlS1I0MGN0NDYxRW10NUU0T3VqRXlVZ0JlblMvVGwzVWQyZDVKZVpmRnZM?=
 =?utf-8?B?b1cwUUQrYXlVTHFJSGtvMEtZcjBBV3pmcVh3OXpZNlFrU01ZQlo4Tk5NMjk3?=
 =?utf-8?B?a05Ydm4vUTMyZU9GdVlHell6VnNZb2I1eGFDT2hldjVrVTVoSlFDQkwxTzNJ?=
 =?utf-8?B?YU1xYktTdHJBbnpSS0ZDQ1FmZEpOZHVlR3dtUDFFVERaRzNENWVnYnE4dGNw?=
 =?utf-8?B?Y1lVQWlPTndYK0hVYUhjUCtJTm9mdDdDK1lWbGhTSDlvTnFKVS8zc25TdzZ4?=
 =?utf-8?B?NjB1UzA3dlpZdG90UjBaQU8zYmZ3OTVES3gvc3hiYkY0TS92VmN4bGxwSTNp?=
 =?utf-8?B?S1VFVEhaZnNEbnNjeVB6VXNHNXdiTTdlWWIyelNoWHo2ZEFiazU2UWtZTzBO?=
 =?utf-8?B?eE1kR0E2bnlsK1JoSGNQeFNLb2UzQmwvUEhSVURSclBxS1orODRRQVdSMEFu?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 223f2ca8-7f03-444e-db17-08dc47f7a304
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 09:33:29.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrsjINAe2FmShIYmXKFJVfUPuLpd4zA2jXVJVbp+5G1uT60hCoCz5xunROYwIUOtaOuVDs7LCPeU+eyBpxS+drVS0Ow8XWveJnJa5u7MFsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com

From: Kees Cook <keescook@chromium.org>
Date: Mon, 18 Mar 2024 10:49:25 -0700

> On Mon, Mar 18, 2024 at 02:03:51PM +0100, Alexander Lobakin wrote:
>>  include/linux/compiler_types.h              | 11 ++++++++++
>>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 24 ++++++++++-----------
>>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> Oh, I see the Subject says "kspp-next" -- normally I'd expect things
> touch net to go through netdev. I'm fine with this going through either
> tree. Perhaps better through netdev since that subsystem has the most
> users and may gain more using the new macros?

Yeah sure. I send it with "kspp-next", so that it would be clear it's a
security feature :>

Thanks for the ack. Re expressions -- Przemek suggested it would be nice
to have something like

	__le32 counter;
	struct a flex[] __counted_by(le32_to_cpu(counter));

but we don't know whether something like this is possible to implement
in the compiler.

> 
> -Kees

Thanks,
Olek

