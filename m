Return-Path: <linux-kernel+bounces-30656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728268322A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF04FB23601
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B3A23;
	Fri, 19 Jan 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhsFMZgi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B7EC2;
	Fri, 19 Jan 2024 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705624364; cv=fail; b=UJH9I2cssIxZXoYhPW1HyzZTVF9Mqr8UD8dCJdWcLCN1ux/w64hHNOyJjH2opOp5oQS7sS/7nJ2RtglUQajb6fbw6grStplWMp4IoOhIUWYRLddGYYTbk/pzlMo0C8TzBn4W1uo5rcIl4wKM/JTI8rQOcFU1TggA51QUGeLClDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705624364; c=relaxed/simple;
	bh=SS/2chP+o+qwKMfvFEPJIFB2bOB99QHCb0MFzORxwCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m2ZtRwGfnwIZAxhTld0BZG6IhZBx6IbtMJGk02t4js/aCT0pNSTidVE8uBtrDO0zsP49kvBYemfBiQJq+d4SVPonc+o9jT2K+A8sZNVSFDfaJoY9W8tSxm5ho3LvbwpYBjTdIyrmG5Xpuhzuo7HlLOd70Us46pz2Rumn2kPm9b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhsFMZgi; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705624362; x=1737160362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SS/2chP+o+qwKMfvFEPJIFB2bOB99QHCb0MFzORxwCU=;
  b=MhsFMZgilpb1fmOGbWbKEeZqQVStOunE+rn8ybJGIxjO4pnagXf2Wx8B
   OCkH1lZcKnSwv9xrSjWuCALlANFr0+H74OmlqhmyqazcD/oO1fwEnLo1k
   I3DJr5cY7Ajjv1p33D1Y2lmPKVMI/hxynxIcVKsNYmWa4jg+XMfq1YgP5
   bcVUiVZwBwjkoqQxnDMxR820DKJYJzOokun8Iethxv3oBwACCXJ4auerx
   kUbTqD55dMYgXwowKa9oLJ3Omm/t4IJ3f6/sNy5NC1RTd82tQ/Hd40iEJ
   qBurrnSN/k4FTS6Ynd3C2Zo6MQh87sTJ933LxuJaPkM0oMJIoHS5md01M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="19203586"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="19203586"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 16:32:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="33240388"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 16:32:41 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 16:32:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 16:32:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 16:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm7nNJjEsXp2s6tpAaPXwl6GFZe3nO7VlbIa9zdRV1KHDYkX374vSwpvzC0dtAn9NNJWbSTuFqWv92q1+SK1/CzfJitemx1ptETPfqTvueKAizW4mIm/Fk6RymXoxvBX1LHvDIjsbZmr/I0h98t6PUgOdIGxAzITU1h4f0w9yD+ktCd6Tw2vpJ9YC82GcO4OIz4kkrEgmO3Kx3Fb2qB6F1E/Of6yAtGYHVHdaDgWkZhQ61zQKaSybHPG8OyQ8aTsCb3C569plSXgUVibdfLXV3URLkC59uq0NEqFc/3yyuDaGgutg1jaVen7W8nOrDQYRNpGzOWtTJhHBOY0GvDpDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO6SBOp9fXKmiMo0BOhgtCDC50scXSDNVa+QB4GvA3A=;
 b=MwKGo5ldx3aKNivzXV2aQ9XgUG0hs/rFiEUXOH59P5NjGYhSWsX+VTIOmbu/9nyDQQW5ea4qkkIOSz8LsH51AxSFPQb0XlRJ3ICXKWQ4vcuAoNid5kXDHHQZPhl9g50dmsCrWI/EsQ8nwOFdrftqTuXA2jCQTOv1O/XF0cNkRedz07OZTz9qFnE8MTnGyY33s0Bhg1IFKepeiL2HhRI8qVgcF3U3zq9pxcz/GGaHXBWDP02d8/goPkS9w8xJI9T1YqXzCfO6JsTUyzcKj8UU8kf8iMyz+WzQHqQ6jqGAyJ0W2815WqLtclMqd2VHKTBANitr9IZhdL59KZ1gs5s9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4825.namprd11.prod.outlook.com (2603:10b6:806:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 00:32:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 19 Jan 2024
 00:32:37 +0000
Date: Thu, 18 Jan 2024 16:32:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Len Brown
	<lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <65a9c321785ea_37ad294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240108114833.241710-1-rrichter@amd.com>
 <20240108114833.241710-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108114833.241710-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 535490f1-8d37-400d-8278-08dc18862301
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+M0HTWAy+HoeCm/g4BikVaAkwuO7m8W0r6Ppry1Yw99sown8VEkEeX0DHcWOQsdUst4mBhUPPtZ12n9ptpjSFSfeJ3+1qO8CnN9TfOXUeC4pmZ3PINQuN0FJ3G3a4mZtXFravQkFPS5OGFx0IJozVeBcdnzpxgbMnZgjVQfOq7M08wTlwHi1bnTd2mMyd2NW7tfX0r2+hAxKk75aKV9l1ns+3CDtDGJeKiAkRkwYVPk2JVawmnuyC0OdhaY/g9CeXXIN8CdspqrOa5VqZQWEILP4NmPinrX3gISaTugaoNnwYXF4AXPqPhvqZSpgJF+alokOuuq+a3Yjz18lZ1UZQBxMvaM9STAVLHj/AgvVC8PLir8upur0HbNiQglC8kdlfjSspPiMhhFbh08SEoV+O6d9LRM4S24CA50ysLiVXbTF3sQHk2KvmXdvImJeuAiSdRR3AyuHBemOagXBYoWlkHBZvfL5RhYMjCbYew9zrbBbiVMw7C7iEs9vCgFKX3rTNg+6UVowkXQSkIKfcKXtF0FfIxY66RahPpvtVWLeKCldFVCzIGFJqCr6y33xJTbnXOnqqxTa8/cG88+v0hZAH1hcxunSuUBQqpiiHwDpjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(9686003)(6666004)(6512007)(6506007)(83380400001)(86362001)(316002)(4326008)(8676002)(8936002)(6486002)(66946007)(54906003)(478600001)(110136005)(82960400001)(66476007)(66556008)(38100700002)(41300700001)(921011)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4BtNH9FgLomgvAJLvC+m/VpX7FYB+3TUbG9hKZFnrTWSGzU3TM/QStNTswLx?=
 =?us-ascii?Q?neB3SHakMRBCRq1/SDT1sj2da945haDgpSXW/5BOmvYVAYoxbCF0LD9NnQF0?=
 =?us-ascii?Q?vhZOU5x6pa+CgILpsZKLywwFKIuFC08ImtUqfoTKb1S761t4fpEUefM2S/la?=
 =?us-ascii?Q?qdyEoVmkT9bpCPmagvnN81TXJABG+3UGo2Xbuvmud7qIqkVbIPKlwZTabx5d?=
 =?us-ascii?Q?cTR4rHNQ58pmYKKkOU66i99x9MCey9adBEbFq6NSiMlamMF0rz+WdmOnR0Wr?=
 =?us-ascii?Q?SxnDFNkvm0E0/tTtwbk7W1F6wJPoagkrXi5gpTspkf/immQew1Fl1dVO3M1a?=
 =?us-ascii?Q?mOSgI1JoJcImCT/OnN5SAjocMbj0rultHD5BSFcLueYPn3Q7yMLh/VIodGY5?=
 =?us-ascii?Q?ZV08+U753dEgdrH8L08K7CgzA16ldjrX0IOJji+NfQIFLaChtee10u8DdWur?=
 =?us-ascii?Q?xNnMAqttWaf0f0fZ2y5IieZc11c1jvePvv1bdIs1CLIsj/ygXAwCtnRzen8Q?=
 =?us-ascii?Q?Eoz8PCHlkNzhxgAALjaxcif4CnpnhpBza/dxe26dloURcepr/ETV2MdKglc4?=
 =?us-ascii?Q?0hF8eBCc2bOK/rRxeuWvWcC+FnbyJAIKWEqB06QfTXhTS76P3SyyndagfBau?=
 =?us-ascii?Q?Ja2oc1se5eKBiNaYhpScYqKNa1gaN6M4MinsGWDikJ6rzdntOFJkiD+IbG8t?=
 =?us-ascii?Q?dq07xsBQMyLfuXc83HW7c9gFOwxbkbBjS9225V7yGwkDjjvvnd6ArrMz6IHT?=
 =?us-ascii?Q?9pdcaJTWLIFgRLb4VPGfqCwXSZsxB4YNfyPVCC3FcChNifQFebo7UNzFU5AG?=
 =?us-ascii?Q?qitVdYrMrzsfVUEB1M8hFiBcuU5QB504g3OpybUIWPG7NLvMfYy0BusAJ07U?=
 =?us-ascii?Q?vBrGYGoUP7IWJo1YrqJD4JFUoxtp1umhrwCDGFFTOgmIpk7F8rpXMUQNwfv3?=
 =?us-ascii?Q?z7kIMZ8YzszOPgwT2qINJI9ygP/yHM/uVu/JrTlbdPAIkYP0fWXsWgkohXJg?=
 =?us-ascii?Q?FYyCINL2TKuI8dbHxU2p4EO3YGCA3iTp4eohVoxEqbk/76Zdx1yGOnh9PHdh?=
 =?us-ascii?Q?eojy8ELCF2jrx06dbNYcUVdKTXDBng3xDdJ6/L8LHpRxFJDwDBnYRMQVZ0Nx?=
 =?us-ascii?Q?xVOC6bZlLzxjD3ezp0yxaS861EjJHaGmyyyT0OL465xm3Z5YYRQNwO9RWj8K?=
 =?us-ascii?Q?35e7Aq+LV7ibDpbBtHSFpKJp3vqAR6ZtPZh9Ek9GFYmTsHvyqGGTEZlA8Fvx?=
 =?us-ascii?Q?K8oIK893BFmgmn2ZIKbhHw7YhDb6J0aWMDARbu8wU0pkMXhGsBGErw8q50k7?=
 =?us-ascii?Q?hWj+lzZxhydL9jqXkkLFkPzQNEWByBGqP1R/kIPdmO52E29jC+XcusUF6Hq+?=
 =?us-ascii?Q?ljpzS899YR+3kuOL0g370p340sE86BZ2vY+vu1Br35WbwJClobFmQ70fRPcG?=
 =?us-ascii?Q?mqprV9111SVA+Rx/n0lG4zdUA+fAiqP/mQXl91LBquI5i44SMQQwceyOtYUd?=
 =?us-ascii?Q?o9p4i5SeAZG68MNEl2/yeHKFKajIWKnoHiox3b6+lJWoRA67MwqIDRaSIiVb?=
 =?us-ascii?Q?f7rCWJky6zkFS2HnWC11GfXPMxwRhDRe/Brsx1KrR4tiQlj6r0f9paTWkF/P?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 535490f1-8d37-400d-8278-08dc18862301
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 00:32:37.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihovBYo71nvvcZMAdbYarqcF7giB26TJnPLYYu4Yq6s+uHDJtC/xNhU6wZ8XmJ8zpu+Pvqt1tzqfch1zRZY/W8iBMg+zVKE2vLm9BXyTXFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The last entry in the CDAT table may not mark the end of the CDAT
> table buffer specified by the length field in the CDAT header. It can
> be shorter with trailing unused (zero'ed) data. The actual table
> length is determined when reading all CDAT entries of the table with
> DOE.
> 
> If the table is greater than expected (containing zero'ed trailing
> data), the CDAT parser fails with:
> 
>  [   48.691717] Malformed DSMAS table length: (24:0)
>  [   48.702084] [CDAT:0x00] Invalid zero length
>  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> 
> In addition, the table buffer size can be different from the size
> specified in the length field. This may cause out-of-bound access then
> parsing the CDAT table.
> 
> Fix that by providing an optonal buffer length argument to
> acpi_parse_entries_array() that can be used by cdat_table_parse() to
> propagate the buffer size down to its users.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Robert Richter <rrichter@amd.com>
[..]
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index 1e5e0b2f7012..ddb67853b7ac 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
[..]
> @@ -164,8 +166,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	int i;
>  
>  	type = acpi_get_subtable_type(id);
> -	table_end = (unsigned long)table_header +
> -		    acpi_table_get_length(type, table_header);
> +	table_len = acpi_table_get_length(type, table_header);
> +	if (max_length && max_length < table_len)
> +		table_len = max_length;

The other patches in this series look good, my only quibble here is
that this is an open-coded min_not_zero(). If nothing else pops up in
testing that triggers a v3 I will just fix that up locally.

Thanks, Robert!

