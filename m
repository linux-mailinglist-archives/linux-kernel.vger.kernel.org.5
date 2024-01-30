Return-Path: <linux-kernel+bounces-45164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B334E842C57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59E01C24750
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC360BA8;
	Tue, 30 Jan 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR+7rnYS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CE383BA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641572; cv=fail; b=HK4NH6boFM/+nx5nu7T2GnzhRe8BpKaNmzvjSlahOiXhHYS+w4EzQwbl6gKCDjKjwiCWGBwCpUDGEYQGJ3lmzdCcAXblpD8NVEQhGl5h2Q27Z6SgmCLwc4nv4HZ90w60+MmUD01Y3XAUlj3pZBtEyruPfvciJOZ17Y6n06U95FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641572; c=relaxed/simple;
	bh=CHvsStIBKyZlFVvb8qlg0GVh+LChHlZLm/04b8sFF9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSHGLi/xwRqmjhV19GOeT01dAmXnKbWQJh0Uf4Ib0wq5VyFoHq9Ar/v+3klDe6KRcLsLr+6jooRkuPueaL60LKaz+K0esIDccvd/h12yj/ie/PUbzoimX9/NTAW1cDNF/rEDwa1YiOoWwmYwjiCSFupfe65RvCvWOHD8Hqp5WuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR+7rnYS; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706641571; x=1738177571;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CHvsStIBKyZlFVvb8qlg0GVh+LChHlZLm/04b8sFF9c=;
  b=PR+7rnYSvz+zLrmrfOvyNscDfbJbmWyYbCJiWZ0KB1okRrd1HHOBp63H
   RUXa8JdLaoFotHx9nWxNVjKN5AhqWmKCqKiGziZ46CALPFAc5YQgw6/a5
   S5XZTTru+TzC6ZlcMPOSHRp31PjbmZyTMCTQNo3Z0Qo3L3bTvdcHABCeS
   mfCRCvu3LHn9pWrQgueNGX+/B9LfuqhWtbsyOeK9AphIJruWtcc8947gi
   2yAGmgANxdRNYczIddXhRmX12xryNxYrjPmXoLOM9VCs1E6qgKz0nmgzD
   R4sBa4EIr5bpPoHqJGtIrPL+PYbEsvtytzMJQYCAkQhgUH/NqRO2l3+9i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16762745"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16762745"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 11:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3856638"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 11:06:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 11:06:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 11:06:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 11:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGhYojyeKuaF1eZ0h8IKn4vm7Ip0Vkh/ZfxdouLfS2rN4lmWPn9Gtt1f80cJHcyIX5Qx9x0CYxH5v+/jlHj0vaMu5WCu7M/2neVtqg1XLRy4Gma4ZYidAWoXJo7RdTHRO0O1kEDw+NSLEOMFMphbKTlURXSL8U5AwnAQ932o+D3nF+PYqq2WuJhu1gTzphI0t5nfDeOa+rHye9tFkRYaWVoz45k4Uake4mrvm6KqmXKrRbZO7HromZuYdIo6OL3mOzwPiVdG2nH9cu8YlGpJoZG9kZrsneS9fbTAAXYnHBaA/1usIv+a9qZLTKJhqPDQ0U/IReAA3TlcSuaL4AaEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpa/JULc74DyEUZxPiQGxPTjcgYiUbRknWQ/M59YY6s=;
 b=UEDdls1ll31Isr09VKKenK+nf2oERm7OfcINpQ/rBvNL+hi01SHOMfwSc7u7b/NUTeY+u/oFUEyMl8TuszSgxNC1U8TaZtUWaozqM5Pkh2Ioly7JtmE1com+9euEEpmKQ0Z+1Rlb4hKpwsfsg8VDt/H8puyv3cOILoVjovfXA7sfqz04+ZDb+CA/3fCdhP8Sa0YAJfbN1qlJ2LjURHhdHRO/95cBKf3r1ZFzTQBQlxwiE5aIoefgC0QhYvNPx0L205O9kPgYzv21wj9rDb/Dn6dBnb3nYM8Vzh7vR47WcYJVLVh4dNUM9gsPyTip1AO/iFdyjc03ncs39+wV+1NaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:06:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:06:03 +0000
Date: Tue, 30 Jan 2024 11:06:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b948987e865_5cc6f294df@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b9434712b57_2d455e294a8@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b9434712b57_2d455e294a8@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e90ebf-fac2-4923-9c49-08dc21c68121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sbk2h44h3gmabV/YIVCvPpLaU/CmgRTJfo6gEaGQqsOKR7T+8RrmLt/Fi0PjsBSEyO8uxAxPbMWBTWmFPayVonCgx/DSCsJfP8Yax4zo9FOksO3bP+XHjTzZ0mBLorutoazjyCYlpR+kVmRayPhnwuJzQu+Tlc0XU8bVvbjetFtik98I0xA3QsfQvO5J4pEQrgG1V+enprbmgVKZ0RQHXJ+tLwyTS3ylPdOsX+irz1nYNM9m5so+hNZiEru1EH1m568HTB++4OiQCxKFhjHMyQ61L81qTk+jbzVCz05jpz0ohH0pHnqVl/EpMAm3jxyUBmD/Mpzsw6fAYej8SaVtfqHPjSaVL/VzdX6r7dWPj3nTrRQZU0mLYSV8+OBpLkD2qiH752h0RW7I2KWqG2JEe09UBt8Cry3rt/GQvyFi8n9tykqa0iu8fTBmFa9KJoDeS/nCk2Y68kHNaz16auC1WE8M7Bh1/iyFqrqQU2wiYifgPJwakBXal+xJqFFpQ6TXcAPs9twAXHdYBtDwti+krPEC140x7WYSoCJnLMz0nmq6Kd8+qwDzsP22PBKYzoP8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8676002)(316002)(8936002)(4326008)(2906002)(5660300002)(86362001)(110136005)(66946007)(54906003)(66556008)(66476007)(478600001)(6486002)(38100700002)(82960400001)(6506007)(9686003)(6512007)(83380400001)(26005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vvr7mqvDeBXibp50vIjraiOgLniXP77bkxR0pFPVfyEsPZ7C59q802ygDPST?=
 =?us-ascii?Q?0w3l3PPTxwwGJKRtP7fidHi3NiXTj2wkYujGN9AuD0UWgzHABVFKjjxpCQdG?=
 =?us-ascii?Q?Oq05kOYgvkJCnq7RBnOFmOAxJo1xvMnE7tvnwIcAckVNGW7uko/fTU3l1wZI?=
 =?us-ascii?Q?SJZyfOlEvTVZW1BUg3Iw4Cn/OfeKZ5RlSOXjCYsCfdsNdh8a5I8+r3Qc612T?=
 =?us-ascii?Q?dAwAtrQ36ElXlSAPL/5fQP1BFFacRKu+9K06kYXd0CmgB/0nXZ2c2CB12S+W?=
 =?us-ascii?Q?hjKhZqIwyDWhIvGvUHjirqX/5HDvA/buH0jJZPSfbDvzdvOtsVMwR5Eb6Om0?=
 =?us-ascii?Q?vtWjuwagsDMiTdkjf/4xiizz+J9ZZSAmG1AbIAfS4caIy+zdwSG/Jx2J9kUA?=
 =?us-ascii?Q?I4SQ+FARRuuS2so+qb7RmnWqB9UErKkK3T02tsbF1bSPS7wTX3ZN8o4bKs9D?=
 =?us-ascii?Q?uTFXdFfM8JLJFtzJiJCaGXACCZl7A1ix6cDSOLo7SLUzXQQgd4IJ61TUpOTU?=
 =?us-ascii?Q?kdMhdzKnfsKZwd8PmEURQswVHuV2OklD9m2wkTxm6KZ6xFyQmGTPcS60LV5R?=
 =?us-ascii?Q?kgVa5q80+QTFzYfNuvLtq/7kl0vp3xLUONlLzYC35vbz63XDA1rrc9V0BYBy?=
 =?us-ascii?Q?zWmwFNT4MCp+3RToYmGnJQOvdM9Rh4S0zd9MvcbUeqJevyNUM9zkr5+GG7+L?=
 =?us-ascii?Q?BI2N93sCHyXmfq5kjyfi/Z0zb1WuixPvbAgi6PAsyDS9XcoantID3m6eexss?=
 =?us-ascii?Q?vmlzImBbRDYBE/Sww1YsqbhqN8oYXZ5zom+DES3YAMddSFlL0/u889oxR6rL?=
 =?us-ascii?Q?jNW03pAfcDAK0Nk3px6ho04GsCrL7Ok72qk7Nhvt8qTmxkL3ss6CtOmH0P88?=
 =?us-ascii?Q?HN4gqZERhhmvGYBX/7oBtLvGLlIDkyoyFpgkM63iKjDgTbV6UVzDwU+woQOZ?=
 =?us-ascii?Q?2JeMN3d7dT8o42nRZPVXwaPnmjohfFO6T5VX+ZzjfgI2fsd/a4cHQh12huaF?=
 =?us-ascii?Q?iMHhfx0bRI/YJIsGkFzPswo32Pa275fTnIA8ZvLPwXICBuAyZGU5xlS2OjkX?=
 =?us-ascii?Q?cJ/Mq2ertRBGK1o8hfwNDds9WsE3phg7MVYz4apULA5NcJ8D7hYok367uiyw?=
 =?us-ascii?Q?PUB7rhe8L4JbEtlr63BnkIDp4+MoqcHrZCrA+YBY7TxsDToC5HicGafF8Fkw?=
 =?us-ascii?Q?1qL6v5tjRZd4YMLL02E5y2F2go/Qetr46f7c8EZElSaSai/LTUyUyQ//MSwE?=
 =?us-ascii?Q?x7lkK0NmjOGq5ws5uTclhU8DNGw4HW3V61uexIwcBqYTRmyPKFYVha+VmZvF?=
 =?us-ascii?Q?yK0P2qVMi5foj8lPojQFyYHjSYA5d8L68wzTWyKXMXE8Tyi6oQUDY4+dr6ux?=
 =?us-ascii?Q?2RXC7GRjTD37b/64VW5Sr/WdVUBIzM5Ib82e1f+s+f6wQ7d8fHGSCuZb7d4w?=
 =?us-ascii?Q?j/9lmB5XItwjoL+vZaQs0vFIqLKCRcVYDfBWSKU+inDjMBPJwVfV7tCImjuh?=
 =?us-ascii?Q?t5EkFmAQXP9l80DArTwGI7h+JylFku/i8dQTJo+p0vu1uJBq3EbAQ/qIlDjK?=
 =?us-ascii?Q?0hUy1R2G/yLclHoggqmLEL+SO5mvqCb2a2ny06msRQtKIeQFoLQpYA3ppWDA?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e90ebf-fac2-4923-9c49-08dc21c68121
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:06:03.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3Od4WxKLSxpE5VnVeBoS++CTm0/JuhBamtg00dtAqkPdsE17GLhOlEkS+SI9BS5jBwIR3/6pjujHefea0gblLljpcZyf93bq12M4WyIBmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Fabio M. De Francesco wrote:
> > > Add cond_guard() to conditional guards.
> > > 
> > > cond_guard() is used for the _interruptible(), _killable(), and _try
> > > versions of locks. It expects a block where the failure can be handled
> > > (e.g., calling printk() and returning -EINTR in case of failure).
> > > 
> > > As the other guards, it avoids to open code the release of the lock
> > > after a goto to an 'out' label.
> > > 
> > > This remains an RFC because Dan suggested a slightly different syntax:
> > > 
> > > 	if (cond_guard(...))
> > > 		return -EINTR;
> > > 
> > > But the scoped_cond_guard() macro omits the if statement:
> > > 
> > >     	scoped_cond_guard (...) {
> > >     	}
> > > 
> > > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > > to handle the failure case:
> > > 
> > > 	cond_guard(...)
> > > 		return -EINTR;
> > 
> > That's too subtle for me, because of the mistakes that can be made with
> > brackets how about a syntax like:
> > 
> >  	cond_guard(..., return -EINTR, ...)
> > 
> > ...to make it clear what happens if the lock acquisition fails without
> > having to remember there is a hidden incomplete "if ()" statement in
> > that macro? More below...
> 
> I sympathize with the hidden "if" being confusing but there is already
> precedent in the current *_guard macros.  So I'd like to know if Peter has
> an opinion.

What are you asking specifically? The current scoped_cond_guard()
already properly encapsulates the "if ()" and takes an "_fail" so why
wouldn't cond_guard() also safely encpsulate an "if ()" and take an
"_fail" statement argument?

