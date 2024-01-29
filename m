Return-Path: <linux-kernel+bounces-43527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818B184152C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FDF1C23488
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557141586DC;
	Mon, 29 Jan 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAxncZle"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16045C8E8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563797; cv=fail; b=NRnuJ+tyEOaiikTlgblbRWjxK89mDMjcMbT5RReuAofe9vF2QK1IcsvmVAXpXVlVvMs/EUAXrcCJnGgTVefdyeYH2QJN1teSUZvqnsD/6vLFVcb0mOEHEtCvo67rvjumVgoY5cALLtyLlML4hynrwZe3elP9woqxSxp0J+Lq/Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563797; c=relaxed/simple;
	bh=yf9mEMOAcHdiva1O7H3g+Qi2sK2UvkB566oW2fA9IKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3+1ZKcjoy2eAWTWxar3GskHJuue9+k7Kv1RbdU/9suFCDnnxSzQSs2zJ/P5kgyvmhaZ6P91N5d6JRxoirVdcMC8ZOBCIt8WWWP/lj3n0mSsW3KljcMY7dPj0+Lyzd4tk8nxLV3R71zPDKI/PS1kyZ6AgNULSgYJ9LQAkahTQMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAxncZle; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706563795; x=1738099795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yf9mEMOAcHdiva1O7H3g+Qi2sK2UvkB566oW2fA9IKE=;
  b=EAxncZleIl9nzpCZX+KMhBlmTUi9StR+9lUaxZnsBfBd1Y4YS6XQPZkD
   P78yWbyv0X4ZAnnteh/LkKKfwbAZkXytTB349MZEkURPqN4kKc/rYfid4
   /E4gkamsQp7ufi2+Qva/8/zkoWzfYHmtWdNAJcY63DB16ptp90HJ9HO3K
   pEko+s28F01IIDCmhuxlH1haBZ9QcDB00SYcAaXHK4I+csQSczOkj/i/g
   ETVyGvR5L+bfSLCQHUZ5yrQJonUWWzG6+3LQ8rPmIreqIjwYRUlJ6zeID
   vinTRWsY7gda+Jt8BeCiSEi5kBBYWFYi6mNhw3C8ZppMeJfoCDvbtqtft
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434267591"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="434267591"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 13:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="36281229"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 13:29:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 13:29:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 13:29:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 13:29:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 13:29:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j27F2PNgmp0k+RLtWQerw8czrpVBHQsDr4GujPcNJJAi5/WQ4QuIovzjHXtEeJv6QDc5prrHljOOiXqD4H2VaHGSsEoTgrv/6kZ6UBhgfWbPihia4Ww2uzFItk1oLp716pCHw0yw3H/SUNIZLxzPVAATJbUZIgalGtiOPfCx7OIPvd2XheHhoEq6xEV/Pp85DKWUd+c9lQb2RwU+WA2W+tzIMpQiRO0ofpszpKzrBz2BxjardEoxG3q5x8BN9mq68vKQ7mg7vLJxTTgM0LEvjmeDHGfHVU5590woFWZWlFhCISnKpDFh3SNZ2hP81Dj0FHj99CyZ2MSf09pJ93q50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74+sGM2jTh7fSlZS/Fq71DxeUSA14Xmg74YR8kljNiY=;
 b=ByeTyyg9kmaA09jsoEzw5p5WuZwNskd6loRDXRLaSufwqnquUIUZyo9ryjYMEW0eM4SQrtVGHJuvCOKolRWezh8M12tvSzJzklvQwSUDQUqsbaVIHbxOkoeaITXhT/8pyU1YLI1xEVoKQu1IslosvFyZlAXjFFPl+5iXVouL6YQwCS08pwtxaO3zsO1mRw0Pe4z24xzWR//BHM3xDG2QacdqLDG9k9Y1kXkuQwEAXbQUMBq7oFYi2OpKovI1UoP/S4QXf27Pa94sS1muPhH9PughqEPksPzYuxf7UI/Q43AzlgnQm6dJlupAMAjBMk5AP/dd2LaCzsREotsv3hzRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 21:29:48 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:29:48 +0000
Date: Mon, 29 Jan 2024 16:29:46 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-kernel@vger.kernel.org>, Jose Souza <jose.souza@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Message-ID: <ZbgYyra1Ypa0nf6u@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SA2PR11MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 237104c5-218e-4b2c-ace0-08dc21116b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl9p5LnJlCJaOq+OKGtojhYLssY41rh0g0gqvJE2RqTf35kjuZYKmBS0WZqbcWURnDm+dsMqHSmzvPxBHGHtESMmN+JsZ1KDyp1gSvZ/iCG3cTTdXQQzbphN75uMbgaidFtV+KFH8j/RZ6d3MLG5IbuBOxVhIJNDkfyj3C1QG2HUINxgBeCgBVRLVoHAY7uoZwPsIVIdVClBJnsZcXQY/vu3SCsRoJzqNom49e7RI5k1vBy5kw6QcHyw+7fzGOFYPYQX/dp0AsXk8iDbdHa8GmBPDFtPB4jW5Vqj37nbLu8g9kHiFP7YHiqKXiBZ25D9bcSj4do96nmBYJjxL7tK76ONOW43GR9cCHMqUyoncI5thR/A4TWJsWZ0inVRimb+8UETmN5zCbX/Tbsz/YJEUVn5O8DpaKd8jPGJqVz00S4MapQUjngwA0oUHC976s4gr4JNtLDJ4Y+Ij8EvkVzafmv+5ZMUctEDvdtiNs+Hz6hbDoH7auxjg9WDxFDaFfXUu0ppg9B2hBuji1eMIDrJjCF5tSJF2V+ADokTokNc8IHMGWro565j+KBGCu3b7jBG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(82960400001)(86362001)(36756003)(38100700002)(26005)(2616005)(6512007)(66556008)(6506007)(2906002)(6486002)(6916009)(8676002)(478600001)(316002)(66946007)(54906003)(41300700001)(66476007)(4326008)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BOKIwMZEUPaiYoEQifD3DtPI1n6kgqxpoAwFtxf19yRbLoj965uxGDHSdI+?=
 =?us-ascii?Q?tSAHF8mOdwoYuoYIIEKUwSkH3LHyYX10BHK5d1m0cwPwv41dMmRXTrsQu3GA?=
 =?us-ascii?Q?Q9NQdURiUZcTISjHHabdPU3+K2LI/OK8Yzyte2TJcZqAfMGFExa2AQZ2Egev?=
 =?us-ascii?Q?LQauv3f9FYpVgMfJhRwlgBnNf92ksODfXyCTA6NwaR6C2MDI4nyU/e8LeHc4?=
 =?us-ascii?Q?m5yNixFGZFgwEO3OZ++PQiC9dApPUbt5qzIO8o20Hl7+ThUlIlRTtTx+RQVR?=
 =?us-ascii?Q?uR5EQM1rygdG39II11KxakpM+RN4cx4qmtNbtXlP/jwV5ca3sOmfT16pWm05?=
 =?us-ascii?Q?oss3Ealb2yJ/frY2ADvSYGHSw6tsdBwzqDwKzAK3a4YLKp9jNhT85pNt6uNr?=
 =?us-ascii?Q?TPQWI5zBGE9MPmbBop/g0maHXzjmjOafnPoe+pm50bk8DP24g/ftoRDSVy4n?=
 =?us-ascii?Q?aiYORrKCjy6oFOhmInBpVxJK5v9RcbR7egKvVUG4H2tFJjvQiQRUh5xTKRBe?=
 =?us-ascii?Q?Ng45pvrmC/BD0N7ArYNkWSYwNKnVMuBGrFXIFugJlxd4Q4zP/jZcnvZZKuzi?=
 =?us-ascii?Q?+MAuctnhLNXiWo8AvrNdb0ffUVRlpU7ZdS/cO0dg7csECeO5XMMbpYtYJI3P?=
 =?us-ascii?Q?Eh/bt+/LMBrkmv3LaOHWb3bJJ4Dk0WEbHCEqLbIRyckytQDORLgM5L7lAqPm?=
 =?us-ascii?Q?bGSu5e7OlygRLYXwmwHLg2DWEF5Zk54A+VLWz0oM/sEgcG3ibqQ+2iLh8p8e?=
 =?us-ascii?Q?cOnZUsfCtmybFXchp9sfDm+tkoXpCrKtGwN3ZiN5+q7wsn83GNj5rep7JpNl?=
 =?us-ascii?Q?ErC8vSFPR6JjYmOu6tGW1GTHypMx5p1H6OkPvqNyxGtdTNEPytAndcxS9VCE?=
 =?us-ascii?Q?FwNYhf6P8aIHUPUe4+NNuyeb7WPpv9YLkait/+xAFl8cpOQd9sKobUiScLlt?=
 =?us-ascii?Q?bUE/iwKtwDpoH0cU1yym1WDe8ihjdp26R9numRV7Ogs+7Z+5zU9KUmnpeult?=
 =?us-ascii?Q?JDQABDhUz9RsT1vqp0k3q5+ArbA/MqL46iG79sC5dP78+qND6tTNQkZXOgN8?=
 =?us-ascii?Q?6Ly6UogacRgfs1mPcZht2eMlBicH3v/y1NBIthdIMDKw2CyyfyampOJGSKEr?=
 =?us-ascii?Q?OAfugLQu0zJ2NA46Eof+skinYC5s54tpzrEEcKjU4yD3wvuKrWr3BRdFjoCz?=
 =?us-ascii?Q?mZvi7uCxLYfEKOONEmGMCeimrLpFpQTV7h9HYHiClbqSXG0QBCHRpNSlb3gX?=
 =?us-ascii?Q?Fdya7gA/jeZ52FMKHgymej0uGqZONa1frbqxIEnBl53G+TTQMgGofAp8zg7t?=
 =?us-ascii?Q?F81gBMcu+2/HoumhHLbdzyDKbO93axrmJQ95QfZFj4PEuvzzlurqZUNRLZ7o?=
 =?us-ascii?Q?xvbubrXZH8/j2tQ6jg+DTs6AaaCNGV7Q1UwCNQgV2TILLIecX39B/ic7M+If?=
 =?us-ascii?Q?o3DtHp5BA2gSGcwXLJN5jD4qSPv5rVMQlM07o8rI34zL79O9N0Lk9RRRWTFm?=
 =?us-ascii?Q?T0zjSknBgy8dfSCqV4u9j7RXSZ1CoLHCmBHppMK8DL9tIdCJvafGMlyuwu0G?=
 =?us-ascii?Q?rIuT0sk5XFHPxJWv21U28POZDVNJYxs/qry8tZQK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 237104c5-218e-4b2c-ace0-08dc21116b37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:29:47.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrfY2u2/ukeUTBqt0eyEn3y5GJUTpgeQtpLGJMFYOB2bSq/4//nbfSabznYZglyeZ9F+iszM3f+iSu81iUd80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4953
X-OriginatorOrg: intel.com

On Mon, Jan 29, 2024 at 06:48:12PM +0100, Johannes Berg wrote:
> On Fri, 2024-01-26 at 10:11 -0500, Rodrigo Vivi wrote:
> > Make dev_coredumpm a real device managed helper, that not only
> > frees the device after a scheduled delay (DEVCD_TIMEOUT), but
> > also when the failing/crashed device is gone.
> > 
> > The module remove for the drivers using devcoredump are currently
> > broken if attempted between the crash and the DEVCD_TIMEOUT, since
> > the symbolic sysfs link won't be deleted.
> 
> Hmm, is it a problem to remove a whole dev when it still has some link
> here? 

Well, the big problem is that with link there, the base sysfs dir
is not deleted/removed. So, the next reload fails to recreate beucase
file exists.

> Maybe we could just make the link be managed/auto-removed?

this would help this angle indeed.

> 
> Probably regardless of that you should change the comment in
> devcd_dev_release() since it's no longer a concern?

indeed, I don't believe that that is a concern because this
is exactly the only place deleting the link and it can't race
with itself.

> 
> > On top of that, for PCI devices, the unbind of the device will
> > call the pci .remove void function, that cannot fail. At that
> > time, our device is pretty much gone, but the read and free
> > functions are alive trough the devcoredump device and they
>                       ^ through, I guess
> 
> > can get some NULL dereferences or use after free.
> 
> Not sure I understand this part, how's this related to PCI's .remove?

Well, this is my secondary concern that the idea of the link_auto_removal
doesn't cover.

If the failing_device is gone, the 'data cookie' it used to register with
dev_coredumpm(... void *data,...), is also likely gone on a clean removal.

And to be honest, we shouldn't even count that the registered *read()
function pointer is valid anymore.

I'm sorry for not being clear on this point. The other one was the
immediate one blocking our CI so I ended up writing up the commit
message with that in mind and without thinking about alternatives
like only removing the link.

> 
> > So, if the failing-device is gone let's also request for the
> > devcoredump-device removal using the same mod_delayed_work
> > as when writing anything through data. The flush cannot be
> > used since it is synchronous and the devcd would be surely
> > gone right before the mutex_unlock on the next line.
> 
> Can we just decouple it instead and remove the symlink? Which is kind of
> what the comment in devcd_dev_release() says but at the time I wasn't
> aware of all the devm mechanics etc.

Well, we could indeed. And that would unblock our CI, but I'm afraid
it wouldn't protect the final user from bad memory access on a direct
$ cat /sys/class/devcoredump/devcd<n>/data

Shouldn't we consider this critical itself to justify this entirely
removal?

> 
> I'm thinking this might be annoying in certain recovery cases, e.g.
> iwlwifi uses this but may sometimes unbind/rebind itself to recover from
> certain errors, and that'd make the FW dumps disappear.

I see... but it looks like dev_coredumpsg have a different handle of
the data cookie and read functions with the read direct from the
sgtable and might not face this bad memory access, since it allocates
the sg_dump_data which is only deleted/freed by the devcoredump removal...

But I'm concerned with the direct usage of the drivers using
dev_coredumpm() directly.

Should I then move dev_coredumpm to  _dev_coredumpm()
and then create a new dev_coredumpm that calls for
_dev_coredump and this devm_add_action(dev, devcd_remove, devcd)

?

And also an improved commit message to show the bad memory access issue?

Thank you so much for the feedback,
Rodrigo.

> 
> johannes

