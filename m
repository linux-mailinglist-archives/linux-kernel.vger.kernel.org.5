Return-Path: <linux-kernel+bounces-45066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BD842B51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F97F1C252AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A5151CE0;
	Tue, 30 Jan 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOfJacRl"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99814E2C5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637514; cv=fail; b=SUWlQxbQT91nTT1d1hpUeeEn1mJ8Qfix/7M2cRUJfisEgFuDnF0Q8N04NgkdAeBCOQhIiZQuycMSqXwGawbUBkLAnfA8xjQP+W1oQY5CTjJeSyjDz6IA2iq/3rwHziztptYWVMCgbmnqf4TFFYcZQ0yx1F4ESOo+BUWFD2gEV14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637514; c=relaxed/simple;
	bh=wndalYPghaS8YcjDTA3TH6hCZJVHxdi/x4CeSt/fLDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjgGCi7duRar7d2+3+09vbDOj4xBSSygumBU1jWMdBUUUWoSfTay1CFRJD+kzjifFqGDKafF660KojsNokd1jokPh4yQJQ9Adm0uzIndpFFID548NE6TrntHZvq8zi7MgjSp0hU4OW9ByKBfw+2wlwe8szw1Bok9ZvJtstVgKTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOfJacRl; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706637513; x=1738173513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wndalYPghaS8YcjDTA3TH6hCZJVHxdi/x4CeSt/fLDE=;
  b=cOfJacRlrde8NG2j7Rk95O/CohOgnjM8f9/oF+qjyzf/ibpwlnxfC1lZ
   jofM1ajsdWysLAj3vquJyhLlSie4yUMOWlaMYErO0ae+tf+v6n+YVMPAJ
   RtCmdctt64ZK+hXTQ3th+F37FFOO4gpsGhG5bP6SNYr8gEWSjnVNy98Td
   KkFm0dEkhi9CzzQikNAlce35E9aPFot6ZrcDQ+EIB4LpWqrOTmw3VZnHJ
   PWFfezRZikXM4YSe3SIzdQNTUBt8HTJ0vZz2eiAP1sorRAV+d5ts8TJWU
   5xvPRtoqCQpnd8G9vasiA5Zs8nbL/s237qp6iuhlfSTX799ZQ+XsU+1yy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400503972"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="400503972"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="36577430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 09:58:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 09:58:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 09:58:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 09:58:30 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 09:58:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAwLu87SA0HVTfYKo4oIczpSH5AhvQevAA5RZVThbrA1SbqoJ5G3gGRBRpjbVy4FtzHaoQUy1C9FhA8AWLBy967z4gUvfl5PjrHqiyQ+gZhzkkzIORP9tJBme8Pqx31BQD46/FwfSj18oC77mU0Snstbxn4mlEN5E9vL8HMjb4hkwvuJJVVcWgPfA3neFLjEULjloFCQYPq89egA2+1z7sEXe9G9UljietiUula9OsH3+dL/Etyhbkvf30p333Q0qUzlMRW5Z1+0elYzTUL+0GHMW1sXjdDWYfggAUJhPW8EpEhVLSN7yQz6mYDmHYiOZkLoZMhUj6KYrez6obytog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJtspFJVw5MPYxejhB9nUpu30yYYNola05kf1vKkKFg=;
 b=G1uNmnBms52i5jy9bpRIrbkvtbJ242e6oIDuuwIeLcIeIqrU4p3fDbRXy128rzjukkWsnmthnEdkzMzMvKBvLFsrU6012UjBXz+yO9yq3qOATB1e4lyfy979OTRcluP0zNciLXkThujh6oTpreWghhtv3ZToK5yR7j28RYNWDUBp2TyU40ebngeYMN0j0i+e6hHkWR/XYDNsdb9q2Ul6m1RMk0R8tkEjNga1qviQIYMHBKY/urK/4v4JkFGAfH3cIXjq/8ZaCvTL00N/Xgdto3KghqWRtNaIAMbTtuOxs/jIxmkmMZj4rs1yC53BJS0SiNzgKwppMlkOva/eeuB6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 17:58:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 17:58:28 +0000
Date: Tue, 30 Jan 2024 09:58:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22169722.EfDdHjke4D@fdefranc-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <22169722.EfDdHjke4D@fdefranc-mobl3>
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 4542f544-87fa-45f4-997a-08dc21bd0fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLjPj37jbzJ6epHiqZHm7nD9Gjc6eWo9Pg1zirFjyhlC7qPiCNRtejnHB4d0utoNiLf/UcKPeIajQyuyQ4glHx0cpgBsUFOUgWjE05iJGV3xRehTWoLwsTSsMhDNAuWitNI8iPJcwnltpbTUkE9+IhZe/SJwmuqv5QnI4PbBgRqLxjdXBos2N00tBF9hPBQJnjvqEL60U8mZWAbKKoR6JSyhd+Hn2xgtD27rtL4oimaplTXSyxoLWyAJ9O6xDjjFNqnt/3FNZXnNYpyyAoClQYT0RiQ52ZpBz8JfXss5uBgpuTsqjDT1WQmopQZlN+i9lsQOLsvgBRH1t6kRYmsLSHnCZXVz9/s2VIVdAqXA9ABe8kzTiLLQfaK+6uGZzOPUby341XIcx6Nc7tStethAta7vHubPE1d+Rsx6kyDAZVZxvTFJnyvStOS+gcCUAUeoGyvE7OjzuDkUCy5waO21qfQuU0gBOkDdoq6bbXqIKk9jpZrunIhnMFGTpFUUveIxAh8IWRL9aLBtk19nwDZJmgw1Ook+wWxl0MgsnS7DSmIdJRr6vIQjeowAWHJ+C5rp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(9686003)(6512007)(38100700002)(26005)(8676002)(8936002)(4326008)(478600001)(6666004)(54906003)(6506007)(2906002)(5660300002)(6486002)(66476007)(66556008)(66946007)(110136005)(316002)(82960400001)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxHO3BeBslceLsvPOzqlflXuINXv6iFcIuFm2au2k4GSzqZFqGvfXzNGbI3w?=
 =?us-ascii?Q?uGlAfvDSdbNnF6V2j/6/MDTeOJKDeweyOmAL+KK9aYzMT+9Zi5NJAs5BHjeI?=
 =?us-ascii?Q?tUzizL/IbRQoDj8CE4lc4cHfpmd1mSSPAXM2GJjRjMxo4fdafMWXPyy0LoP3?=
 =?us-ascii?Q?Ig4QgLx+6v8Ma2slL4ORFdBtWbFnWE9PArBE4Z/Z8GQ6zj9lJ0QmwKH/47nu?=
 =?us-ascii?Q?ErB+hZVqfdFGny/Ei7dZkwe/WwMWWgtn6Ez+QKuNH67WDt4868ljF9BydSEk?=
 =?us-ascii?Q?4/FVoOL4q+bqD7Qy/SPZbFil/loMGlcrOrOErcS5mZ6nC1dE2M7aOvzGYPPm?=
 =?us-ascii?Q?MkaXsLMSckeIxry6ce9p3UOER3P7gPrAGPeZuNixy0c75X0gewH2tFUzaGH+?=
 =?us-ascii?Q?92k5YaAM8/jg5mLxsx5XghuApuXc9SL/ZQhgsd10uUxLwXalf6H2nHtbq3V2?=
 =?us-ascii?Q?WuWTg4fqloFO8yZ44Osao6wJ8s1MGFGhF4NVeU2Sv+7bW3fxXlQy/B5p3GG5?=
 =?us-ascii?Q?DHBK6gZCnWsTPKSKsBJEOzGkQ2dw9eW9jrnLuuXsDpfKgFq8jPNC5ue7OhDu?=
 =?us-ascii?Q?K0+8gyJ/5Pbdhze++h4dUt3hImZ3azNVLbtmXwNIg2/9rvWBMb2gk/KhluKn?=
 =?us-ascii?Q?z7AJS/z9bgJ6Kv3PcqiLjSS4enWMpJMZgmp4IK23Gg1L2ajHaH89sVVlbE4d?=
 =?us-ascii?Q?b0laT1q5t5cKp13prV9VMBFYmyk7D/fltCSqvflkvqLQmbWYkH+isvPuu4IR?=
 =?us-ascii?Q?DP9CyJIONq/UmOo9WCbD0kqSKXVdnr1mULXDAUsJ1M5EDMroD2AEtPb/EtcF?=
 =?us-ascii?Q?MBE1RiDtFj8EgfDmPUOFwvJZySbHT2gHRtrveNnLEyK5MUI92yWhpZBXlZZV?=
 =?us-ascii?Q?spmF2DlC8evSC7jqNtrk2fnFalApW8ypCCwigED5D8p2AoPP6sAGWpNntyDO?=
 =?us-ascii?Q?axQUam1EfOqvPiEvWsn8nP3IlUYZU+fMTPBd1+FrzbRcaEAkW8M789n4xesw?=
 =?us-ascii?Q?WC+/w9IDR9HrW5m3H/8PQgWA3Umbujb24hrbtGkW8Y5S+aFM5SZzBzp8P/Eg?=
 =?us-ascii?Q?8GYuu3r/AjDpKrulXrl4I8lb7RlqLxqfenIEpeSW44Fy8atF+MWLAvHHffNZ?=
 =?us-ascii?Q?OIb0SPWyzY8iO1kNoEjQsJqycqq1Bk8vcBR35zhbqKPVZiZwc/KSO/yGNadQ?=
 =?us-ascii?Q?DNqz1oWczkjRC02X1AIY8Bm5HC5UfVYeXOxkxlIvobUSrv4iE64EQfPrcDVA?=
 =?us-ascii?Q?ngM8IblSuYWgZGV4kSMRh3dq0b7otnxuQOwcjvem8QVMwZdAtYt7dnJRyiuf?=
 =?us-ascii?Q?hG13V60WdoAOqal9yTrteo9RQr++3YYU+IZB59ywoQ9D8TOnXiIQKzWFLgnO?=
 =?us-ascii?Q?KlYSrnPzlue+fVKIlslZd+DuJ+EO8BQfj5cn0kJu8KhCmjbMdaeD5jTgzYyq?=
 =?us-ascii?Q?1MPYP3TdIJzyHAcN/r5JH3YMI8g38mi+zc7k8OYUfYSrgCoenu46ZBxm9Wkv?=
 =?us-ascii?Q?2xi76kM4poOF2dc5bdkcXAnab/r5i6eqen6eC4Zn38pdcIMgptAbc1L8p2Bg?=
 =?us-ascii?Q?/toE8b1v8+dUNCWOn5epJHHnGUQWwKAjf3jtwImNUuXoK114Gj0sbna2O32V?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4542f544-87fa-45f4-997a-08dc21bd0fe2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 17:58:28.0737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHd5ikCsiGiOrQ/R+FoooN2v8ohxDbFWBZozWY9L5k81NmgT67Q1/LSSL1H1gtrClGUPolYbgUWytkhFHS+UgFZLk5B+VJLVLCOlSA8st28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Tuesday, 30 January 2024 18:02:09 CET Dan Williams wrote:
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
> > > 	if (cond_guard(...))
> > > 	
> > > 		return -EINTR;
> > > 
> > > But the scoped_cond_guard() macro omits the if statement:
> > >     	scoped_cond_guard (...) {
> > >     	}
> > > 
> > > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > > 
> > > to handle the failure case:
> > > 	cond_guard(...)
> > > 	
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
> As you propose I can't see how to handle multi-line error path like in:
> 
> 	cond_guard(...) {
> 		dev_dbg(...);
> 		return -EINTR;
> 	} 

The _fail argument is a statement, to make it a compound statement maybe just
add braces, something like:

    cond_guard(..., { dev_dbg(...); return -EINTR; }, ...)

..another possibility is something like 

    int rc = 0;

    cond_guard(..., rc = -EINTR, ...)
    if (rc) {
        ...
        return rc;
    }

..so, I don't think we need separate macros for the multi-statement
case.

