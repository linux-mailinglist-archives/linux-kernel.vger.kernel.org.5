Return-Path: <linux-kernel+bounces-74055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56E85CF63
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB90284D61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664B39ACC;
	Wed, 21 Feb 2024 04:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7Q3wJpK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6E28382;
	Wed, 21 Feb 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708491564; cv=fail; b=DVxx70t/z7micHgJ46FeJ9su74wDDSG95/3EgF1BuovwIxGIds9o/Ga40nAGuiIOlTxtnIha+5dqI7oTP95YdGDpAsjfOGMs3KBlYdWjjXsxK76hCQKtGjH9j2COPVKaQ1imY7s7+xmLY/MQlacK2+SWw+Fba+uIbcdR3MQUE/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708491564; c=relaxed/simple;
	bh=CxEH+EzbD83+vPOQ5mrRCgAmCc/o96re9kWsBntRHCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTxn+4RBRE+lNkZ//RADQHR/ol59/eWXiL3xNLoVvzGq647qHJMsfYLXJ3Egb+IEArjZrgJZUenr1kO8p8IYgTDqG54wthb0dNC/++MDsQBBHbvGG4Chv+uUiM1q7UwYL4kDAA9FWso34rMsRoSpCbJ27SvjFMUdB5hcj4JFe60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7Q3wJpK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708491560; x=1740027560;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CxEH+EzbD83+vPOQ5mrRCgAmCc/o96re9kWsBntRHCo=;
  b=m7Q3wJpKj8Xc1weus/bULucBlygJPE3j5IHqehqvH3F2cMSxTrHXHfIR
   yCkFcyjxzJYxNiXeWZ1MAMuKmDKVQZNWGsaLYEqAdCBwhXC/wSKfDQU5M
   W28VuzxJdPch6wVb5JBxpGAug90w4CwYSQLFEwvhZHMfZMBWRcO+rFGbD
   ZTuruSFRvzkkOYUU+hrSlaf3/kUh+q9FdR9wLoX7eXz2jOctSoDXMUjj0
   6tcjrc8Ovq2QU+186a++1ujck2/Ng/Zli/15AGaUgzEqBBXgHP6yV72ow
   svS8FmGAVeOo6Ji+QKvADM9n5luaSBxnVBXZ+Hv0Lwq4hzFUbLwEzo+8G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2496315"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2496315"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 20:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9664150"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 20:59:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 20:59:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 20:59:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 20:59:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvFh+JbHEQwvp67DtUttJHcWE6YzGVvr555erMNure7bXvvA14ehreUGVaTHmfEmPNBZIBM22FquIYUhCE7M2m/zwZAlyP4bHGprhzRou54mSlsTL7sNvrKcXKn1UiR6UT9k5OOv/jAxhQDVGRxQuq7fuV+T3tiElo5b3ix7Sn3xnYqmG+aOnZlwOIvyteLurHoTl0uSf3WkBZ4atFWH6SLE6Fn6pZnCwtAuyDSpPAvhmT3t5cBbuvvYfp9er3rGCYxNIVglx8BxiihgaSP7HrV8Fkof1mDAJLIlnd7lTNewKprl2tIVviGbMaBDRUxWR0ycdAGYTs6mz7Ztvd8gaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USac7kJdwYWa8SHrTheGYA+JkbJ1TxdBvsm7ik/lwx0=;
 b=W/K3+ffqzF2mml1G8NnzSrWyfXtbkaBU0Y0zgKC5Kl9Lf+Zl+ip5ve9Pjys4M/2eoHZ+R5OwuR+FINhgpDNkmqbdJoHbWbVgZMWOnpk3aHPd5pfLNMDKbyzHuU1WekfzBKtgWkVN7QaBqsYC3KpBgvm1BQ1a3WmkS1VZLhwI6UADJoXIeOVsZW0OG5h18dejLmp7X6SRPFGtKZf9DILleDu7Ma+PMCc3j/9F3xvpFU0P3cejBhTJEMYsmpVRAxrP0cRH5Goi/hDnpp58WO+Pl8MrWnfh7IyA/YqPQrkJZKtvNzxTvDpi5iY14NSPmMGPmSoSvnTniza0yFJ+Lj6Taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 04:59:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 04:59:16 +0000
Date: Tue, 20 Feb 2024 20:59:12 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65d5832090c5b_1ada2029473@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR01CA0003.prod.exchangelabs.com (2603:10b6:a02:80::16)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f88575a-cb34-4124-5edf-08dc3299db00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wu6nlN8wg0aiNIyMYByjvWg/MCheVNVujdeGYCA63E00nyIn33j2Fs2RL5Toc56N7BIDMZ7czebp/Jd0REve3KDF35PsCqX/qVR2h4pfl9KAuSs+zBTHEozXPtePlb60Yt1fSY0rqg96V6ULbApuyJAphimuynS1ZZ0ol7GNliQwQrE+qO7VjwtTg+BesZ+Jns5XRAVT0X4tj7xYyQgyUqPQu4HyuLV4bKefKZlsH+k0B9dYIuB3BPIM2wDbFerh7c+HTMlCAEpEt0FJOD8W4xofsSf1JTMsZGMJhS6OiwwUDbd/beC4oVVD5wPs6EjOflMLEwwt5WO00Jm3Wkkley/bFomk3FlR0VLkjhnaZjpafp6u056cWVAVY09IB2qYBp3yXTSwGmwmdckg9Lq5NXaV2GFKEDH6XirGT/GZRAZdd/GQceSqkgGMfWcwzHqoB0hjuXoWuT7EAnAuDN85egNz2RMgk6vzbFo617wN3wSxp6tAkm6rKQcLSh8JidXjvvYP1o1u8Bfe/1I3SBnq4bRqPooOxm/hy5kud3KxV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gF1wqVGwJkHO8gDVZUUkASkHy5lrgLbF73G24QzZrgI2nO/xOljaHLWKh+qu?=
 =?us-ascii?Q?O+vuQ4HM1INyV7f2e5FVZ/On+M8/wMrHfMxWMo/ymKU7958XfXbLGv9mN4AE?=
 =?us-ascii?Q?KpP+FsOimFOlYCCPEHBgGGOazGCrGrn8r8xZTZpxAAuqcEzFb+yVw6U06AJe?=
 =?us-ascii?Q?CZ+CnA5aEYVbMJA1ubfchj/zgtzdAYL3+pgG/k03nd1J9by9iEe/FjsUg80n?=
 =?us-ascii?Q?3DJe+HLuXV4k/UbWuvc7YgH91v1iFwcAcEbhRsRUO1DsNa0veEtqOII7qgTj?=
 =?us-ascii?Q?T34n8/W984nn88/f9VRzbGXao6p8t9c54e0vrO4mPRQBLbDjuxmpACBgilHw?=
 =?us-ascii?Q?Eu6HqvkGDFnvDctXQzxuP5bm+S60+a7ussM/AO3eQ24MAStyDBm5Bw2B2T+5?=
 =?us-ascii?Q?469GhiFOFbKX9T73dnM2nNlK3nzqOIyeTOhwi/47FgOnmmVXO3RhxcVAfzU/?=
 =?us-ascii?Q?AHSW5GfpNHCc3oGXNJem4rMHbu4BQpO0bBpojsAFMY52/Kf2+IheSE7dwkNa?=
 =?us-ascii?Q?wNCUDY8Ds+5nokOLI4po+qPPiliWG1WTfUQdkKuuhFX2qbvSvpPcl37suxQj?=
 =?us-ascii?Q?UV7w+88jSR+Pb75L+/YSZs1CFu/daAa22VEP5T5xdx19nNFRybYvO+wuiVEO?=
 =?us-ascii?Q?obX88jkbOasvWiotpdeGe9ZrroSRhCUfKnL+kwmKzYVatil1Hd3yd4J+Rm58?=
 =?us-ascii?Q?m1fcG5laApfqY+ToKXD5ZvB70g2vdkKIrXIvPCsxgeXgIACUF1sfZxPfYVOy?=
 =?us-ascii?Q?ti0yx4foCA3wCmill/cfppeE75QDARt+K2oa+RAVB9Q8UM/V+G4BTSMLjqQp?=
 =?us-ascii?Q?RfQezHqZt1V1bUDDREL2xbF7zU9TN30ozNh5IlFMeekpYTr5ypsTCcdbAjBZ?=
 =?us-ascii?Q?ZkU6XzBJ9DP2XrCLryVxKTyUwk11zlQSfjE9Qfzfu3idJADg4A+QewRIp7p2?=
 =?us-ascii?Q?5oluCtCRgo8dGWuvjr7cXTDv+U2fJqL7GG6m87RCwyqwf1mPfLgWuRc3ern8?=
 =?us-ascii?Q?KSPTGjVDB5xi2hidZ01HhRc70O20DGS0XC5od7zyt85Qu01zS6lfSZkwq1gh?=
 =?us-ascii?Q?BB+HbGRT/0t69qHFwdmvQ09iEcHzXxiWZJmVdsJSPnYbkrSPsK1gAPzsREfS?=
 =?us-ascii?Q?HsFFQ6c1uVXzqvajJtkUXkyU2YJ14R7/hnm318yRURVPZEBZjNcHWog/5OAm?=
 =?us-ascii?Q?tzDSIlo9uf4Uxys3fcmqGamDPyv4Z1bwAhJXHNDlnIX7HMrwkGu0mN21thJJ?=
 =?us-ascii?Q?4o76oDFZPLn/U3AKxs6+/g6RUAIr/w0MYyDVQPA6AUhlfS3wpluKymeyvSfj?=
 =?us-ascii?Q?TIdgjoMzFIBd7TfwesWYpe+LfYMn8l94HEauDOyay7irKJUHdh+UEcu9DMyL?=
 =?us-ascii?Q?h0LddTW2CsGKihy+iKwrpC04LFFMC9JNeaaSkM1iSUaSQSweCvK3sTU4IjlA?=
 =?us-ascii?Q?hT+8DpzsW3094sHTy/AC9toSJ4ggkUXKy7SMmBS2VYOXdYkj22wunss4/7Y9?=
 =?us-ascii?Q?qgrD5zl1D1wbtIvNzfTQEXuMzjgOOqn+/5VE68+vUiK6laysneCT9ejMPqAk?=
 =?us-ascii?Q?5drvWRuqakIQxQjvEhfJgWYn57Qt4+WaLbj/e8e8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f88575a-cb34-4124-5edf-08dc3299db00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 04:59:16.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhwV5QPN09+wk1d2ofBNG7gP36cnnOtFSvMLPWk2rGCUY1Wg/McrrXaKBMbxl3ICIwXO8bLqlr0CzBU1Au6AMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> >  
> > -	guard(rwsem_read)(&cxl_cper_rw_sem);
> > -	if (cper_callback)
> > -		cper_callback(event_type, rec);
> 
> Given a work function can be set atomically there is no need to create /
> manage a registration lock. Set a 'struct work' instance to a CXL
> provided routine on cxl_pci module load and restore it to a nop function
> + cancel_work_sync() on cxl_pci module exit.

Ok I'll look into this.

> 
> > +	wi = kmalloc(sizeof(*wi), GFP_ATOMIC);
> 
> The system is already under distress trying to report an error it should
> not dip into emergency memory reserves to report errors. Use a kfifo()
> similar to how memory_failure_queue() avoids memory allocation in the
> error reporting path.

I have a question on ghes_proc() [ghes_do_proc()].  Can they be called by
2 threads at the same time?  It seems like there could be multiple
platform devices which end up queueing into the single kfifo.  So either
there needs to be a kfifo per device or synchronization with multiple
writers.

Ira

