Return-Path: <linux-kernel+bounces-66320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC044855A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B07BB242DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC2BA38;
	Thu, 15 Feb 2024 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMcXiGYb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E14A12;
	Thu, 15 Feb 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707977662; cv=fail; b=iblMd6yM/B4g0XEQQeOi5lmEttWPpkULpr2VQDqcAB3q33HXBPwcVJGStAgp0/5wFdGVRhCGvn98ufdPh4uE19uo3aK9EY4Zl0rDOWMTMqD8PXaK7oDxoMTTZJYTqFW1Mt5nEYhClKAI4U+F5GIifqpxv+ypUztEEfJWp0bWS5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707977662; c=relaxed/simple;
	bh=oxAqmmdMI9qGK8PNRXbHbZ+qZeLy6Lp1ij7XKSZ2FZQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DqqAj2PUk3KAGDimogNhCuptzx9QrujjGuhxqO+MkdDzdBUlrFNsR7XRXNBS7WQpKbGFvuetjwWmSx8An8VLdRmiLcyEz74PZqDyIY9XpBoZq0D6PLELOHdzhXRdO1G0RU6wX+XGnbdZFIwvLAgjPnG7+CPT7VSjJ94lbXb0Fck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMcXiGYb; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707977659; x=1739513659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oxAqmmdMI9qGK8PNRXbHbZ+qZeLy6Lp1ij7XKSZ2FZQ=;
  b=ZMcXiGYbE2nMf9rb1fk6O2dP0vzEzWDq1Im6cDAuLYOy4X7FlryYmRGL
   tJa59ViCDgatXm7/4QfpCud70bF5figrWhomhtAKXV1cJO7JNNO+Prien
   u5NaSVOXK46pgnJg4A/q/uOgrRO4GZrxFxCRtdjnYh3Aaggl8WnYbC7Br
   rrZzIhrIbR21ftePGWxz3F89UZ9eZV9krZZeQ2RJ2JDxHQ5lJg5PZ3sTt
   /wjyavXBr1+Yznap1SCMYpNamXxQEXv3kQ52ZPr1sPnR3D4rmg6Uwp8Ih
   u9fzVtQuGfLSV+yXNtL2UImZudYNuS4cGNkh7UlHgshqwRo5TzQPQDnDt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12769179"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="12769179"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 22:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8070389"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 22:14:18 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 22:14:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 22:14:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 22:14:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F01LKzmISJMvO/LOcIlurmgimwiBXRwgI6zjHLlbH63INVyuTAC3kNtiM6M5XzEiXyWekpaPt/15j88rpcpKBVMnQQ5Ms6MdEE//A1DXxXQQa0Tgtdlc6hOxeA528xyjIaDCr+SIsmXcrR2FILqzSSXczXtQ3gb6Afom7zeV6EsBfDZDWn/YEcP6kshPvtk0s1jqrVxQzepk4jRE9R6G9fmylvpB9GaOVOcEpF21o7mHd8ZGvrWwscFrB5KdZkT0tcntfVro9FOrzSLrfgLTFECMZs2vadanCzo/NfRqWbjNuGPhzFyILSJsH1g/NlfghReWCAIb9xWjSM5xs9X4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3TARbxeKdFDoVdiCDWQTTglwt9ZagWDOpnYZg6uho4=;
 b=Y4tGs72jfutFbt745pUggrG2x9ygCXCqnL5VgWlw2nlIzNFobdww+4UrMqH6TwEUWc3wokgIwzyFibE9B/eoB3uS0S7FUUdd3oPKR7pnHBTdsRI5MqskjOYg6UEBxGRrKoqS/e+12fSNIt354CeaJRxAGbyrNq//+FtDCw6ybrskIfAicFLK0OowQZth7BHRVohouFi1w8o6ooX4lC/bH30OqbZCJ1KP8JoEyHblkRSLiuk3VUY+smu7QKTD436M2xu+6bPFRmT+sVvtThGTty1617pG7XgGXMK8S0a1iwpEW/h7R7Cc350/nt6HxivlOR7miWN6+47F1aYRh6tybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Thu, 15 Feb
 2024 06:14:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 06:14:16 +0000
Date: Wed, 14 Feb 2024 22:14:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65cdabb4be63a_5c7629420@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
 <982e19fcd71c41a162ba664281eb0a68d9dc960c.camel@HansenPartnership.com>
 <ef770532-6db6-4262-8225-2d3ee09b7d23@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef770532-6db6-4262-8225-2d3ee09b7d23@intel.com>
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fe2f29-8940-4ab0-268f-08dc2ded5671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUj0oV0cah8ofj5UYyJaSTAXB9+E7AohBfMDn3OYfJ8f8C3F7IVP36MpDEnaIoMOAedMieN2toqIFYmq0/Gy0WcABM+Wwt/CsIefn0qP2ZfCrhuOgdsR3a2PXmKo/VQCwTsnkyyjbVowAZeWv2MqzUXuuh3u35P/bbAIs3EsZAeqdmKqP+1acbKgLxM7PKXtbaBEKa1e1iUO0/7L2FvHEXLTDn0TLTW3jO1ff1Hhta/I3vE/pOGUrg3JW4nW4MwMqSckLuO4YUQuKNXM7i1o0y8cr0+dge/WnyuML/qA0q9OXSI1IZ/HE+TOXdbYg/2fqBM6JRUww5NDYxzp7WEe8UumM5SrS8QIN1zsUurnHr32QCt9MEyFDtB06PtJzO5vQ3r9WqA0n03n0vDhVPnsL6yuU3YsV3LMyZPSw5jVlR3m53LKb3rf/oPXZbzGFcxW6/y1Pd30XxoIbhk2f9WU3KSdLQ1PvBTJ4Vz9aR22np2x0P8mgmOGxKSLJe8QDzWrKhdgnlw/H/g+dtdhdQH12ZEaQ7IQ3xKQqvC1ykt06v8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(2906002)(38100700002)(5660300002)(4326008)(66556008)(54906003)(26005)(316002)(6666004)(8936002)(110136005)(66476007)(66946007)(8676002)(53546011)(6512007)(6486002)(966005)(478600001)(9686003)(6506007)(41300700001)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JiIIuO8Lq5zZY94ZA0oqQzP8wOkqXtJwG50blcS55ZN81WpQDXg5DV3P9QnE?=
 =?us-ascii?Q?0zEHU8j+jOHCqu5XQyEpym2paxeAEuZYAQSais4a3bdnBOgFpY5aYyZFqMu8?=
 =?us-ascii?Q?9kcBUBZI3ec+/XR8fFzseBA66MWPnpv7hTDBo8X6vHMu1ZnziyLBUrKlstll?=
 =?us-ascii?Q?jS2fceKYVJ30v0RHqbcbnemhqEKGQ/r1FfrRmpRIk3KYrF7hUsphAAEWhC3P?=
 =?us-ascii?Q?eH4suzJDkN1sZYqAU1N5uzrFpWwEJG4svQPjWwF5RXzk2IIfLh1B/YG/e3Ij?=
 =?us-ascii?Q?2QkycfYTNUktthW/LQUYhw4UjwMNpC+m+EHDaiYYFd6XZAeC+hhWV0XwAGPi?=
 =?us-ascii?Q?CdhLLNc7RAYS4/QmSHO6crKTB/zXmtH9jVW+k8rmv8BXu4//JuNK+qAXmgAY?=
 =?us-ascii?Q?XfF7QRWZXxajcrGLy3U3o0R+vqIVaEU90fg91U0TbGnUyzf5zOSXykFU+jyX?=
 =?us-ascii?Q?8GqzThEyIKKVREtS/YkmYe7eH0/q1DyLE9nr62GkKtzrXsFGabXryG/4rQRV?=
 =?us-ascii?Q?8r2YVvAQj3B4/a4OMzhxYZcLtEYrziiFYvlKsbOyI8I/BhKFOP25hooGS9bt?=
 =?us-ascii?Q?sHJA86gwQmYLwvAYSMe9Uu6egNGtKzwGkOK4Fv6MVjFDuPTlvQtVOLrVrjdW?=
 =?us-ascii?Q?UBxbB0+gq0S/IQ5JY0ijHVrIKdg7x+2XvUnpbFAG+zDLSxek1BDc3Dyp54t/?=
 =?us-ascii?Q?UQ9zI4Vr83n6tduMF4Stsn5yVFk0jcbNy9wtC7NCEHkyV8hchOHYZqgOJfW6?=
 =?us-ascii?Q?NQx6X35OcJbQdXqg7IzAQxKBywSEErrzHkpQd86J18JRWl18tCHWrjjXOL5f?=
 =?us-ascii?Q?MAuCwnrz+8dXz5bnXtBNNNwqbom9M1cTA0wHY0Afh0qxuXnUZbFizIqoYeon?=
 =?us-ascii?Q?fMiJHFTpJb1YDZD+z+whKwrIeqbeYln1BUqypJTvnt6PwtF3Nih96t2AbDY5?=
 =?us-ascii?Q?ciKjS/LuumknRhact8Ddqt4f9kN+PT0LTa1PT2Z3AUusFsq5U2juDAze/8bZ?=
 =?us-ascii?Q?/ElZALAx7sIVzOsfpjzj+yOSEMPOuc3BJz6QSKRKlhlxNzazM8oMVCKocC99?=
 =?us-ascii?Q?4Ss9PWA9/CTIzb6IiuFxqDcV0lRaLxXvWVcIKwPoYAwh5KuI4gYI38LdWPlh?=
 =?us-ascii?Q?Qwb7Lx4hb4cwH8WOeBj38Smx4+JZEsnEMhEdimuiB/5tAh/s3C69ceDTY8Px?=
 =?us-ascii?Q?hh1WJP3XftnHkHxXyCDPypLo5GoUSv5iCXKUxprR+68RzU7IBLjvQD91KOFD?=
 =?us-ascii?Q?9hwAcvQBr9WoFokIwZrEhOnO26CYT0LdBhYkKtkc9A64/NbbRXsA0pp+Sfla?=
 =?us-ascii?Q?zPbWrB/ooAZ6vRKcJ9rtaA8gZJ572CVc7RFn05Ij4kEfRMnuOIUOZ0r//5qa?=
 =?us-ascii?Q?7D/e+2fQzeD6MGVz/h5tX7Y7Lss8+3wk+2rYHSZ88vwOlNWn9vBzia+8P12c?=
 =?us-ascii?Q?yqfPt2FMOCaOpFLZzCAFSxiCkyELd18jHbEcYVM0MMriwx9RBcKW7PhrzqYt?=
 =?us-ascii?Q?MoQGFoRaYMiArQ0yAK4164WKIXPzkJ98gaEKn/y8U0b+UBXgS6vCXlA3iIN/?=
 =?us-ascii?Q?v6l3ETfv0B9AnELqwl3JyT0l4jlmTMnc7nGnBKzYGFGWeNhuRKTzoH0WzFdj?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fe2f29-8940-4ab0-268f-08dc2ded5671
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:14:16.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al6GkGd9KS5T0NcAAkNBdrZyCwH2GQxqHXIWqgmflG9wMuTtiU52oYmABRuANjh2pnhFAtJfLPU7iPFQDH+XM4VlHxuij3MePvY5AY5XM7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-OriginatorOrg: intel.com

Xing, Cedric wrote:
> On 2/13/2024 8:05 AM, James Bottomley wrote:
[..]
> > The TCG crypto agile log format is
> > 
> >   index (32 bit),
> >   event tag (32 bit),
> >   digests array,
> >   sized event entry (up to 4GB)
> > 
> > So an IMA log entry can definitely be transformed into this format
> > (providing someone agrees to the tag or set of tags).  The slight
> > problem would be that none of the current IMA tools would understand
> > it, but that could be solved over time (the kernel could use the TCG
> > format internally but transform to the IMA format for the current
> > securityfs IMA log).
> > 
> Hi James,
> 
[..]
> Another problem of CEL is that NOT every byte of an event is 
> hashed/extended. CEL spec has defined for each "content_type" the subset 
> of bytes to hash, so a verifier must understand ALL content types to be 
> able to verify the integrity of a log. In other words, the integrity of 
> a "systemd" log can never be verified by a CEL conformant verifier.

Wait, James said, "crypto agile log format", not CEL. Crypto agile log
format looks more generic, no "recnum" for example.

[..]
> >> IMHO, we don't have to follow TCG2 format..
[..]
> > https://xkcd.com/927/
> > 
> That is funny :-D
> 
> I can't agree more, so "no log" I think is always an option.

So to me, "no log" means that instead of going from 14 standards going
to 15, the kernel is saying "whee, infinite userspace log formats!", an
abdication of its role to support a stable application ABI.

The job here to define a kernel de-facto standard for the tags that this
configs implementation of a cryto agile log emits, right? As James says:

"(providing someone agrees to the tag or set of tags)"

