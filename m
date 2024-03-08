Return-Path: <linux-kernel+bounces-97193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C608F8766BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E502831CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794855234;
	Fri,  8 Mar 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5ZMciuv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B915D0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909612; cv=fail; b=iTSYXn/0OnEd0rey5KJTO9a2uO6EEWHlxpWN6wRtcTDpgRdrJBkJ9fm59noXluZaa7He9kPe4NMmaQ4qhbTJpKS4nKhhr5Pw1NmIvgoDPqqq6zlb/D1wLWdq7wrOcXtY8jol6aYCWyr8WcRmPBvTJZg/NP3e12OmB0FMy3I3f6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909612; c=relaxed/simple;
	bh=JLE1vF7gbiEf/O3hrSMDL6y177fXXEIdLGzuZSB4UOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gk3QeE0jYj67MCRRur9im+oFMtax+HM+cQvvw48vJRX78bXtlwMQY8MhNv8y7p9GLtgW8kfrr0sBU7eO06kZbiGoriIM3eRHUw/2yOLYKStYfro4EiiRWPraxY7M82VtyaPQ5yU2MVF70AN76vUFcybpZzR/NKTZg4xA0aHaWfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5ZMciuv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709909610; x=1741445610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JLE1vF7gbiEf/O3hrSMDL6y177fXXEIdLGzuZSB4UOQ=;
  b=m5ZMciuvjh8IQhNrk3XZLI1kcSn5HOdDah8ckDD6NWYcqRl+zLJF4s/+
   E3QN5KI+Kbc6qMAKZX0ywF9kS8QMLR/X+lne5aZ89RVSRrL/VNUg5CWKa
   hFi5nI1j12IPxqI5jmbc4z2IPU83Evdr7+Gb8aKtjLb0Hx2G4dyS7MQpw
   yUqQ+IJXq42kCCddb4KFDUG+15x1+jvl+i6okJllSyfTE01oMu4rD5MFQ
   szyColEZuk/oq8m1D2lUOZMitOK24xKiVaMmE1VahX0Ml0+19g+j6zDf5
   Eyq3UpAqrgdsZDLEcUY9yNba2CqfIzUjnn23sHMICgtu1gcTDkxbkmmVN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15276250"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15276250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10576570"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 06:53:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 06:53:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 06:53:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 06:53:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqvC4y7MOZle+ZmYOQIQO3e4+hjP/xnQy16od9aAY/7FtRUUCxoJauGREjSS6u2gK41tEGRtbsqX+IsJoo9fmSAXNH0FjZevViyy6c730fE0MwkZdAwbAyRAXCRwiS3oJ5PvAD+L+7cHnAG7h4MocblZNeBLia6srbDrw2n7236wmnHZl1v3zV/NDsjcFxZiy+7KaeHKgJ8M700vASUDXAoBhnJVeDw1Z1RQwO7UGXMTy4gGsfZjJqT6dR6JGXecbJiKKzb4XqUr0Qou2cpTPzgeBK1U41FjmiBuS10DGPCSYqZVm93xQ3Eu/mMEWybd6sZmQP6h8/ao3PCx9izcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrDRo68JpIcCLvrAQL5mP9J/QYieqe+b3jH1q0zUEog=;
 b=dqP7Iqw3IkTXilb+iMER0jrdX/MC9dBNoWPwlntrBYkLqAcjppfVL/H1egRNtWRk3bKwVLb1EI0yQLPUSFLS1Ix6TxzuGfueg8b7R0AxZ43ffSyolrK99ZiCxofMwWSrnVHL9M+NXeH6HcSP9HOgvLkUqNoWhK3Lim2TbtQmH8hYNT6tmxXFKeiVQT62jZzi4pqwXtEDZIPfuYoSOwSqkIJYEoV40fTOz3UEyMospNrKu8RwnaPOEEc2a+b6ZsN+grzn0yPe+NWj6Yqa3dsfD7XuxBvKCBNIdYCTi46/KRLIVhM/B/Gqcve6azkcTE+zH994lP6o710vk3FsetAOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.9; Fri, 8 Mar
 2024 14:53:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 14:53:26 +0000
Date: Fri, 8 Mar 2024 08:53:24 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cavitt, Jonathan"
	<jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <f4fjvfx6a3gk55mdbqrirlyxdzsjxelynhosqonrtmsiiorqe7@m6q2kkuwhgdt>
References: <20240228165709.82089-1-jose.souza@intel.com>
 <20240228165709.82089-2-jose.souza@intel.com>
 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
 <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
 <zfrpz4vuhjwmilbqft5d4qh4s3gs3okzyxbsh4lc5rhzjy5ktx@xuu32mxhun4c>
 <f7c2d3381e50dd9c5e9211461e0abe487f5059df.camel@intel.com>
 <u4tngmdxcciblq327yi75fdfkadv3fomnopnpgbwkk7smh3knp@d2h7373q4msf>
 <04cee1ad22cdb1d6a6a4a7482e4ebf7d28cd63e9.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <04cee1ad22cdb1d6a6a4a7482e4ebf7d28cd63e9.camel@intel.com>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6d0b32-863f-4f02-d6a8-08dc3f7f8270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyJYHF5kWxnq++bBzTzc7BK38QUsr+UiRhJgO2cy6nF2dwwwGzQ8tGUsSZzAl9WVh3ipX2zjYQC27+/wfgSi8lcTeD+QcVQVXgDZ8d8ltklMsXT7OpkLr1aFcHSI6Det1XpU3w8IY5GbajBWAciBUJ+IJDmWI00Oilfr4tXs3azOpUDLJACkyav7hUpoNAmFumjCu9g/a86VA5+MhE5cyP6Zs/zsnsNmfd3k6ypQPd1RgUvJ40DgAFDDhIYjvjUT/9GoFXROizrHcqALs0yfq8QkWiZVXS8k86RHGYQYlhLDqZZTl8KKXLDdJq7Jrqzcchfyg2EubOlRdPm4HnaGu/nTAXCHmqWlNRpykTW6j+Ks5FsS/m/18RxQ1Oa9ExJI1g/xvpU2eqZAiVDsgrqLakPPP7Zqoesfp33Nv9H3ThoS8AzKskS8Dsim+OLg3rQOM3yJINcOQvplB3soUvAMrbi8rEbh0FAEoaauQGmpCdGk8/hPzv6rhrLljfhf+XBWkbSZtcarxrOB6FDzaySjxBvnaWuGYegKN09EAQrIqLuSJ7XdDWLDIcMndIb+dOJ00zxK95HMaf0CJ6t8jYPWE952zvodyxUCY5GpSp/2fII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04z0cPhulp56nFcKzumcpa4EDjoOAJMKjajYLNDl6ykjGohXfB/VvaoOgnEa?=
 =?us-ascii?Q?KZROjwPmLDvGpoO+F3YAHOIWqmaHL5/Wg4H2Pd5nsIsFiAL2cX6Z9esMDt0l?=
 =?us-ascii?Q?3JpHwWqxQmeUFw4ecwuSdohS4AHhxYaK9W92PldB0sex+FrYo0YpMFZr/RPn?=
 =?us-ascii?Q?fqUpa3gUztU0WRzwQZZA5Dq20onjYwFgt86r/Gvf+bpKvINJHJKVUDH8T/qs?=
 =?us-ascii?Q?71i/vU8uwJO4CBXIpXWxTi9F20VSqW86OWdUmSI+iqH6WoxXNht61icTTTaJ?=
 =?us-ascii?Q?aA/SJ2pMyQGa8gqs3LVbS8FRM0l49T03WMCkEftCHSlQ1rGBMxOrUV9fmRgQ?=
 =?us-ascii?Q?POgseOjfMxQVSfqpX52GVSl4bMFOGzUyOGGwjg15cOqgP8gERBi6B6m3cQez?=
 =?us-ascii?Q?PJpMz2ToIWJP6jWmYxWlsZncdnfzZpzgI6PbzPYUZs4tU6EKrpQ8HfNLaQJD?=
 =?us-ascii?Q?aAUlNgrOyhAX/0THJlmrocN8bpmdCt1p2D2z8qoNE77bk6HpLS8PA2Yi3cqm?=
 =?us-ascii?Q?5KDeARIdDFuXkl81cvsEqp53NjaQJxQFGcZMbA9wvK+Cz6bT9JDIqW+fVbT6?=
 =?us-ascii?Q?5rj2ZF30+v2Nv1RzuofWawM0wqox5KJtozIFRB04RzO7AFjPqMCaqLW32Mcs?=
 =?us-ascii?Q?Ww7OL7S9N54bDFahGj6mU/3FWkNQf8VKEXEl8icTE5lya/pHP3oTFT232T29?=
 =?us-ascii?Q?rxMsB/0geUNKf0jJu8yzkr5OKfhkHbRo+NJpxPJGqe7Mmsm9ZZ7ghYXttYvH?=
 =?us-ascii?Q?II8CvIHg/ZvFHfzZth7Js65IX/S9oL/rqFRKjkPSTruB4YWDWXSVqZX+2+GW?=
 =?us-ascii?Q?Td/97DbG2mvlTPT2CVbv3u53CZLhZ2XQhh7EtbKs48c8JqW1VirrYalK2YZk?=
 =?us-ascii?Q?CCm7dFjooIADh2nv6trVJ5Fdr6TtHmspkqsTAWdPs1/v7FhjNExOmwFUn1oE?=
 =?us-ascii?Q?VkOFl19zuvzbZ0J484Xay7nJMf2+2MetOdwJoMavLPL3LjWez5TteeE0ksuO?=
 =?us-ascii?Q?bWc4V9yelAWEihF+8BghPfdX3exaKMRX53DoF3JtXqr08YQtNFH2+0/4++Yh?=
 =?us-ascii?Q?glRmn1uzURRDAXr9di2DSV7Dk6jaBy9+j54wid9UxhcOA190P26Wc2XQ9ju2?=
 =?us-ascii?Q?AoAXXChG4JKpqaXHqHhSdFvktTWh+Xx48YXghnb2Y7vSR0TgaJrnYCns3j1V?=
 =?us-ascii?Q?T5N/Pl/YvsbsLoBqeejDLg1ireTgz+TtMkiyJjrI7O1wcZo0U/AcYU6YmvZn?=
 =?us-ascii?Q?ASFQjPNikvZyhQBpAWNL6du9wtBS/d9NqSTyaDoslC0TuBBpqE/CHZMITO5X?=
 =?us-ascii?Q?cX/M6ZXdK5oLPmUlTQJ3dUIcPc7h526N4eFqgl4tNFFprVSx4ppsN2oRCwYF?=
 =?us-ascii?Q?nWbitZnxlAShaXfghMeQbDuT8smfSC1rGW4UVUTiShL6V5FLCCryYsthM/8o?=
 =?us-ascii?Q?KJ89ofSveXbIJSAIs1Yhdk9vGC7TOiXkKkGkScoVToRNubAFXL2WZg7sBL4g?=
 =?us-ascii?Q?Im0aChgym1tnLURWL8ZVmKtyOtY0FymKhOegTpfOczOXjHVhOSz59/gnByEt?=
 =?us-ascii?Q?egY+ZQ5OnxBVVF0hLnFjfRYGWi5UvwGiMRzRlhM8cbyf9OFlsst4iTzzqBAL?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6d0b32-863f-4f02-d6a8-08dc3f7f8270
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:53:26.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O212Hp7Ug1HhC9VLfmRLmGxkYO4uUUe9J0DUkVrCp/XptweTeX8HhK+N2626QmRFq/9L3Xpz1h3JkMlqiepsuULLkpkko6K1LKwR4EeVFjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

On Tue, Mar 05, 2024 at 03:38:58PM +0000, Jose Souza wrote:
>On Tue, 2024-03-05 at 09:22 -0600, Lucas De Marchi wrote:
>> On Tue, Mar 05, 2024 at 02:21:45PM +0000, Jose Souza wrote:
>> > On Mon, 2024-03-04 at 17:55 -0600, Lucas De Marchi wrote:
>> > > On Mon, Mar 04, 2024 at 02:29:03PM +0000, Jose Souza wrote:
>> > > > On Fri, 2024-03-01 at 09:38 +0100, Johannes Berg wrote:
>> > > > > > On Wed, 2024-02-28 at 17:56 +0000, Souza, Jose wrote:
>> > > > > > > >
>> > > > > > > > In my opinion, the timeout should depend on the type of device driver.
>> > > > > > > >
>> > > > > > > > In the case of server-class Ethernet cards, where corporate users automate most tasks, five minutes might even be considered excessive.
>> > > > > > > >
>> > > > > > > > For our case, GPUs, users might experience minor glitches and only search for what happened after finishing their current task (writing an email,
>> > > > > > > > ending a gaming match, watching a YouTube video, etc.).
>> > > > > > > > If they land on https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html or the future Xe version of that page, following the
>> > > > > > > > instructions alone may take inexperienced Linux users more than five minutes.
>> > > > > >
>> > > > > > That's all not wrong, but I don't see why you wouldn't automate this
>> > > > > > even on end user machines? I feel you're boxing the problem in by
>> > > > > > wanting to solve it entirely in the kernel?
>> > > >
>> > > > The other part of the stack that we provide are the libraries implementing Vulkan and OpenGL APIs, I don't think we could ship scripts that needs
>> > > > elevated privileges to read and store coredump.
>> > >
>> > > it's still a very valid point though. Why are we doing this only on
>> > > kernel side or mesa side rather than doing it in the proper place?  As
>> > > Johannes said, this could very well be automated via udev rules.
>> > > Distros automate getting the coredump already with systemd-coredump and
>> > > the like.  Why wouldn't we do it similarly for GPU?  Handling this at
>> > > the proper place you leave the policy there for "how long to retain the
>> > > log", "maximum size", "rotation", etc.... outside of the kernel.
>> >
>> > Where and how would this udev rules be distributed?
>>
>> it depends on where you implement such a logic to collect gpu coredump.
>> It might be a new project, it might be a daemon from mesa itself, it
>> might be extending systemd-coredump.  Your decision on where to
>> implement it will influence what's the reach it will have.
>
>Don't make sense to be in Mesa, compute and media stacks also needs it.

so what? A project can't have something that is useful to other
projects? Anyway, having it in mesa is just one of the possibilities I
mentinoned.

>
>>
>> > There is portable way to do that for distros that don't ship with systemd?
>>
>> If you do it in one place, people who care can probably replicate to
>> other environments.
>
>But then the 5 min timeout is still problematic.
>
>In my opinion we can have this automation, make it store codedump in disk, do the dump rotation... but also have a 1 hour timeout.
>The automation can write "0" to devcoredump/data and free the dump from memory for the distros that supports this automation.

IMO it should not be treated as advanced automation, but rather the
normal way to collect dev coredump. It's much more useful to the end user
than documenting "oh, if you see a glitch on the screen, hurry up you
have X min to look at file /path/to/log to get it from the kernel. And
btw the glitch couldn be something else that does not generate a
coredump, so if you don't have it, it's normal)".

It's not up to me to decide though. If maintainers think it's ok due to
be a small change with no dire consequences, then fine.

Lucas De Marchi

>
>>
>> Lucas De Marchi
>>
>> >
>> > >
>> > > For the purposes of reporting a bug, wouldn't it be better to instruct
>> > > users to get the log that was saved to disk so they don't risk losing
>> > > it? I view the timeout more as a "protection" from the kernel side to
>> > > not waste memory if the complete stack is not in place. It shoudln't
>> > > be viewed as a timeout for how long the *user* will take to get the log
>> > > and create bug reports.
>> > >
>> > > Lucas De Marchi
>> > >
>> > > >
>> > > > > >
>> > > > > > > > I have set the timeout to one hour in the Xe driver, but this could increase if we start receiving user complaints.
>> > > > > >
>> > > > > > At an hour now, people will probably start arguing that "indefinitely"
>> > > > > > is about right? But at that point you're probably back to persisting
>> > > > > > them on disk anyway? Or maybe glitches happen during logout/shutdown ...
>> > > >
>> > > > i915 driver don't use coredump and it persist the error dump in memory until user frees it or reboot it and we got no complains.
>> > > >
>> > > > > >
>> > > > > > Anyway, I don't want to block this because I just don't care enough
>> > > > > > about how you do things, but I think the kernel is the wrong place to
>> > > > > > solve this problem... The intent here was to give some userspace time to
>> > > > > > grab it (and yes for that 5 minutes is already way too long), not the
>> > > > > > users. That's also part of the reason we only hold on to a single
>> > > > > > instance, since I didn't want it to keep consuming more and more memory
>> > > > > > for it if happens repeatedly.
>> > > > > >
>> > > >
>> > > > okay so will move forward with other version applying your suggestion to make dev_coredumpm() static inline and move to the header.
>> > > >
>> > > > thank you for the feedback
>> > > >
>> > > > > > johannes
>> > > >
>> >
>

