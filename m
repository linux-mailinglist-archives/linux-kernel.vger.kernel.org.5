Return-Path: <linux-kernel+bounces-69639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5E858CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301791F21FBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E214F70;
	Sat, 17 Feb 2024 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4AiIhzj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0E149DE8;
	Sat, 17 Feb 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132649; cv=fail; b=BLmgkbzZZJGSx+YeL8bRJao8xhn2VUqqllCCNv6jXOxD0pVVtnqBqDp0Z4AkynIiQBpam/lEXnvVrq8MJDlhtYbdixXHZyuyKQQbcXJ60/kLcaDQ/fTU/Z9aP4gMxSiGMbjlrNUuBONcilNa+myO4t6ktPZoKyyUiM5820HdLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132649; c=relaxed/simple;
	bh=wCbB+Lq8YutWMjEswRbj4Y6ih0ZBjxgB4xOjO4R0wCk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r1CCEoxZN5J/Wtf3X7JNH/H2okXycxSN6Cl6d7VdPpls32kVdSQCKOKcj4LXICfWDlIpRW6ahBBnEtY1Fa65JUBBS8aJvcTJsgMxz3EVHfeUlwkrAZoWh3gZrRt74SXcREhSUyrP2Zoc8fsM+GZMz7yy5gzAVKWPMwouPxAgPQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4AiIhzj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708132647; x=1739668647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wCbB+Lq8YutWMjEswRbj4Y6ih0ZBjxgB4xOjO4R0wCk=;
  b=U4AiIhzjUBLdcdlI3ORInj1AXLT/qE1hI5wODKcmxIIipLnDd2XxZryu
   yt/NhCb79mvwKxmy+KG9usuLQ2q8R0t/gNvNoyr8IJCjHYGLvWg+NQ0Ps
   KTo4L8yguqdIpnfzUkqpc4wciSxleglAy+JvGkm6XmVJ9tB9laoVo/7CR
   m/jNJ3GcZGtcJwqtchLSfRys6S7u2ag8rITagw5Xi7DwvLs0OwsvjxTfs
   OF/uXdRKWT3H0yyzCLNI1+3ktT9I1yO18uaAfAxvUTRrJ/4mFSFonDDe8
   jhM7VMGE2ziYQIoZDdZ2XGjijYVJg7vcBhLicDemkUEeRVDFWo9ZhUnSS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19802133"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19802133"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4375717"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 17:17:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 17:17:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 17:17:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 17:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUVqUtdFCq2qznUSZoceeUAG8lIAKdCSG3EG7JYOtW3BExLvfcTlQV9RfPNd4DoIMoMQSniVvbiGIcF8P5JdEl4IFIE8oahQ1kPras5N9O8m4psYACAqXJO58ASuMwZUDExG1HMlroY+UBuen6rvNfaJrQEOO4n2lhcdLgx429Rt5+j8e3lrEvNB0ozlslmagqyua3E6groNf+XDvFtexk8pmCC39itcjDQOPztFqYJtGRmiC89I60InxgaheU8pZbVuA7Rs6a50SNuU9v/jgv7cZ2wgk9YuPPrHMHp4+hQFjhiA6MjaWCFqsME+tun47S6YObifUx6uZ7hYNCkIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJkFIxkYDrOSBOwaoO06D+AlC5mFTVFMHYZUN6WfJi4=;
 b=jz2SzGUzQDxkdKCxnD7eUWuRKDbdIQ5Z+LK4vUMjpwm2CaHP53S/u3YkDJf7ofuFBpSYqS8TbZzNlAZBugq/GSwj8+IocpFz3eKh/upj0Pdg58EcPKw/DzjWVbf9rWEXbPWKJh2bYZuYK1S8NeTaFQK0/Bj6dOOlOg9KIrKxlJ/k9cm7K9f7QczLNnXYHph8mi0+xijOoLADlNnOOo3aXQqvdp51FdHUi64blUM1RYzniwzePMfGDMOaxrTrrkqs6AuD77fihkN7SsqzXlsSrXpP2MbH/S28xoBOOa72hfmQuLgjFUVeiyLKwBc0kpbtcXuAOISo97hjpDmlg/3W1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.45; Sat, 17 Feb
 2024 01:17:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Sat, 17 Feb 2024
 01:17:23 +0000
Date: Fri, 16 Feb 2024 17:17:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Steven Rostedt <rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65d0092079c20_6c7452946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
 <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
 <65cd4e1f69205_d5b4829463@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65cd4e1f69205_d5b4829463@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 24080ccf-f3bd-4790-5e87-08dc2f5631cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eA7hPJZrk5G7JOWYrRcZE3rmjxZMSxknEsnmlcxM1Tdo8JpN+pLCSCO5MLHzFQ9cM8vaeGsPr2lkR6d1OePSsWUlo/SSxKyo/BtKHnR4PGWmVhh6kAd6z4V+cEk6mlehIcaWSMsoUTF2jY/xsGMo7hZbIDOSCL7DL1+vIKTiJCuRoZ9Tc1sioHskRVZfZu8KIPNI+KosAz611YHJGivFocynTwZdFcuXwPWil1hTWG2L3W08KmlR2Tt5YhHUsEQ2cBKrHfhN+kRs+2ZGxGs8iEXCBn6+Go4ffuVzaWXJs2jSDVPmWO/tcwIWxY6u6PwrrL9XF/z/Ngga8mLeqXTI3lxgsjhHtbCgQIHJAsRcUFtPUaDOTMel2qaTjvTDGUwioNtWzbdTfU+pFUu+rnM4BkeSsPjEjcVku7PIVYWev+M8d/YPzxoeT+bJaKTuPLsJ1FYIbAXi5dKwGrAS16YWPkzw/IurgUMaCpT+h2zwAyEfxadwX6Ff/VswoCpxw6aFsTbf6ceYXo8EUHibfvFSqQYjsACqbVEkYXK+GMipKl9Wv5RNwtVLUjHt8RzTRmiN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(8676002)(66476007)(66946007)(66556008)(7416002)(2906002)(5660300002)(83380400001)(38100700002)(82960400001)(8936002)(4326008)(54906003)(41300700001)(26005)(6506007)(316002)(478600001)(6512007)(110136005)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v+sZR7ABC7UJUjpzZf6Fcnz87g10KtpaIGqOhwDELRsSx27rTYYGwrZoJfVv?=
 =?us-ascii?Q?K0VAYsQJ/gMZT9A7BsX/+Zo0EmZx5Ik4HWsV1oy+aZj+yeGmDHAyMPLK1Dwp?=
 =?us-ascii?Q?CukrVaDuheNksbIthxowB6la0i/IJBp1yR5/QMREvvlobNYS4bxggvshvFqY?=
 =?us-ascii?Q?iZ5hbuyZF9pptlaGTMK0kAN/33HDnEUkoiugnXLZ4W9vIPelUcVpv33GZADI?=
 =?us-ascii?Q?aP+GxosoHa3vO4TfwDTGaZJMYw6igUW/VXHT18Btd1s22+QkvKAxDKzpx1wT?=
 =?us-ascii?Q?C4PzmSWRnszuQP8JCABe5JL0/1MFOknFQn/fjWp5IC2DnDTfE0wKo50RuCKy?=
 =?us-ascii?Q?VnuZ8HMl/FryCbuVI21ndWgwfgWlyoAyJUfA3RcVPygz8VxLP5QPiPIGcV3p?=
 =?us-ascii?Q?yawDErN45iVTxqqSkxjdFmzMG7R5o/GhAxVy7bp++F5StjJz9iCLBGHH30l+?=
 =?us-ascii?Q?ya23cfnAFHlrSA6ZJ2DNvkDngdGvZn5UEZ/T5Kv250nm03eJJC0wpwfm3zLZ?=
 =?us-ascii?Q?jSgw7IZS9ocVtkG8LQGpfZoyQ3SVlStXgIkwiGFgJctjfBMvi64AZddmXF1S?=
 =?us-ascii?Q?OMsQrIKnQQvhv9GE6Zo4suKCyllKs3usFXeoCiCEoVmAouzkM6s7tBtebWlm?=
 =?us-ascii?Q?KJExdIO3vFGD64UtKbi5G+7usyAW6Wo2hhmYX2yh9gMDUwIpmkUnz0UDJIBa?=
 =?us-ascii?Q?PjzUOMbFJ93ox0g1zl4ZJt8/lHYSkYF0wnJ/8aSVdDifEWGrePcGMQZhF0nU?=
 =?us-ascii?Q?cmeHqzJZfrdlAoDaug1wNtDgvA00zNEezJ4GLrd65dR9CI1e99ge+u5BeALf?=
 =?us-ascii?Q?RI2QlBvpFsHPsk01WW2Jgiz9ydDASSV9p3Jhov2axe9DpVaZvD1ggbntB/ZV?=
 =?us-ascii?Q?kdIHZEnu7neaL98lIuZugNBizHN75g8bPCM8kGf5bdNtWVsyNi3kYGEF0Tvq?=
 =?us-ascii?Q?bPXJwJJCDqZNHJQCSvVHnZxbk3wZbVuCU02zBW3owH219JHcUr8pEbhO8dnm?=
 =?us-ascii?Q?Nz8mqty2PaINPEW6xnPqt1ms2fvnyRvtUj2IpiNgHyk34qTWfdUthzRbLmqo?=
 =?us-ascii?Q?eUOI9h9cLnyJYH7qp8HLmsWkOh3ls0/925EHptlnOSdYCrUbVI3pDCMxAxUh?=
 =?us-ascii?Q?7rwqYhwt4lKtiG4tDBoycEfM6j64nUv20GDGFSfxqEEVdbRpb67pMqyFSOgs?=
 =?us-ascii?Q?FMLDo2FKMTXxPYN2Z5FrCYt22qL0iLJkpbIvnw9QvZUy1J1eST7Q8dEyorgg?=
 =?us-ascii?Q?LvVjJkctV+d1tYy7VwJ+dOClHZScXkqLHuRwVGRa4R+dfD93pjqUsL+tE6Wr?=
 =?us-ascii?Q?8rw4pjKmO1u05DbKx0WQ2mv68TIzlvE/nlWqXeU58jmkSDov2ibSGESDGiog?=
 =?us-ascii?Q?AHGBGwudgfMP1g75L42+CbjlE10uhpa8r72cjukbG2zljlty0x6zCAHZWIjs?=
 =?us-ascii?Q?ox1JnUyn/EpFsoABc40naGTQcqeDcMMa/Ddch/CtzzVjQmITU/M34i2UDVDB?=
 =?us-ascii?Q?UIVdv2+IsdQmz0XFFeYfhPNBe2bsOM+hKQnPTarZcJUH9EMqsGRrbLzenR5u?=
 =?us-ascii?Q?fr1yyYbKp7u1YRrtXe32TvoaVtpUXi7YDgtHze7zU/6zQO+kxKOgPHC1j+3a?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24080ccf-f3bd-4790-5e87-08dc2f5631cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 01:17:23.0170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hilr+RgviJTU5hn0IAOFHIawqZt+FWDQ8ub1NbHnXd5PQloo/aiuTlBgbYAxR2EfW89/IX6eazewTn5EorkSsANw4xvC7DBJLFso/3mYlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Ira Weiny wrote:
> > Jonathan Cameron wrote:
> > > On Wed, 14 Feb 2024 10:23:10 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Wed, 14 Feb 2024 12:11:53 +0000
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > 
> > > > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > > > assume this will be resolved as well?  
> > > > 
> > > > That pretty much sums up what I was about to say ;-)
> > > > 
> > > > tp_printk is more of a hack and not to be used sparingly. With the right
> > > > trace events it can hang the machine.
> > > > 
> > > > So, you can use your internal patch locally, but I would recommend waiting
> > > > for the new printk changes to land.
> > 
> > Steven, Do you think that will land in 6.9?
> > 
> > > >
> > > > I'm really hoping that will be soon!
> > > > 
> > > > -- Steve
> > > 
> > > Thanks Steve,
> > > 
> > > Ira's fix is needed for other valid locking reasons - this was 'just another'
> > > lock debugging report that came up whilst testing it.
> > > 
> > > For this patch (not a potential additional one that we aren't going to do ;)
> > > 
> > > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Jonathan,
> > 
> > Again thanks for the testing!  However, Dan and I just discussed this and
> > he has an uneasy feeling about going forward with this for 6.8 final.
> > 
> > If we revert the following patch I can squash this fix and wait for the
> > tp_printk() fix to land in 6.9 and resubmit.
> > 
> > Dan here is the patch which backs out the actual bug:
> > 
> > 	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 
> 
> Unfortunately this is not the only patch.
> 
> We need to revert this too:
> 
> Fixes: dc97f6344f20 ("cxl/pci: Register for and process CPER events") 
> 
> And then revert ...
> 	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 
> 
> ... but there is a conflict.
> 
> Dan, below is the correct revert patch.  Let me know if you need more.
> 
> Ira
> 
> commit 807fbe9cac9b190dab83e3ff377a30d18859c8ab
> Author: Ira Weiny <ira.weiny@intel.com>
> Date:   Wed Feb 14 15:25:24 2024 -0800
> 
>     Revert "acpi/ghes: Process CXL Component Events"
>     
>     This reverts commit 671a794c33c6e048ca5cedd5ad6af44d52d5d7e5.

Even reverts need changelogs, I can add one. I got conflicts trying to
apply this to current fixes branch. I think I am going to just
surgically backout the drivers/acpi/apei/ghes.c changes.

