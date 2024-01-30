Return-Path: <linux-kernel+bounces-44816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D08427CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9601F289D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B263C81ABC;
	Tue, 30 Jan 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxiQ+avi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209007F7CF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627784; cv=fail; b=umxLJNY9/0BsepOO7lU06ePkzhv0cXLhiNQ4wm3Pl3fq+imYi+b8ZmzxEkthdhnMen8j8iO977OcxKJODeMznUuYvutN0Nrno2P893P32QHtz4onuA6SChvAvjX3ijaRLbw9JHoix/sMj5pgoQNNMSrFE2e/vVt8ZX1O3TfW61c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627784; c=relaxed/simple;
	bh=lVSmjqFZA2chPkX/UShddg5HcAcc8xRPFa/J0Ij2PJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAWRv5qWgOr3PqC4SZHVy0ZaRcbvn+SUhY9m7pFyi5mJkBygw2P0G1y4jfQdK+D2MRE5NRQcG5JWBlJVKRAg+uHxLHd2aMBq0KFBrjjXf2elcM+vRwN9Iy42WK7myNyE71GAv+xO3B+S820Ds+l4IG0lGLiTpkqO+XMlsAPZXYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxiQ+avi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706627783; x=1738163783;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lVSmjqFZA2chPkX/UShddg5HcAcc8xRPFa/J0Ij2PJU=;
  b=QxiQ+avi8le1hqeb/RKSnk32NhHA2mncuV1C+RQS9HK6zkVdA3vFMqAE
   IaSYLVqobO5m4IYU1ADzy2TPJitYpJBzUem0PhvzzGTUTkL8wbn4X4MF4
   HGni11IKTwjs3soUIWw2ohs3aEJUprUZOh0RpCy8XlsH1blGTV3RWrUqm
   E0b5egzyB4Hb78+HpOv23NlWI2V0KocfgTFJnm34k955ZDDw+bwjY8NLb
   CWI6taEzFRxeGsqHfZjkTIFNasfJ080uoeAaC9f+Ur+GyOm9wIITnZ37e
   SbavKvPlhpbIAEfhV65OSwXp+TUgyetqLRke1LHd6G0wjMoJpbKSHCIHz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10697790"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10697790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961312477"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961312477"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:16:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:16:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:16:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:16:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQNVkQhabEhdZ0oKQG4Qv1Ucte+O/hRZ2PIBAg8pVpWP13NLgl0e1ZW6hZ2n7ZpHa+4xTL67QjyS8s+M0nMVD5LDRUZSijVITil2TpSL7+vokqChz0asW+CZy0PqaHUglyFb5W7JDUprU7Qx6A1SItHCEWuGuFUjLMnoU0Zb0yaM8O6QK0+vrGhI+P3/GH1cGrc9V7fUH2WKA0AKxJkbM4rIuPpcjHq2dsmDUfeX79UqJ/+nTeX7xAfZlwEhoGj2+CqhyjVHKsZAVPY1QGRVdI2lMR2S9+qL7wRJWslIjbuJj6fDadKYYuCCLypiGdowPeZ4SvH83inanwC166JWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOjoXERtfwDa+CYB/9FZEdHdRmm4dO6CYosJzhdS9e0=;
 b=lL4JDnh5G0jitRz2VLVni2+Ai0esgy5Z7P00G1zvWmvJuiupcmR3levaUlBYUvUfx+myM8dLMkayBFA/MT2ZepJbizBx9HloY844M4zT60H9BJGm34AGiaaqZM3BZxJgjXoLa+LES513sF9Stb4xJMP4ACPgJSrNeWMQhbr3PC0Eegj1TUpNQe0uo7FmhYQTJTtVaYhZwJKSQVQpkC9/h8TT6rmYwbYmHFA4GYx3+4cN1Sx0yjTGJJhFXci6GeGChWY3CnqpoNDmrtiZXLdC001j8rwwa4KEbn1QItt9l00UXBBEU9eMfNNUcvvSWiCvu1MV6veJNaXlvNCzGJxKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:16:17 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:16:17 +0000
Date: Tue, 30 Jan 2024 10:16:13 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-kernel@vger.kernel.org>, Jose Souza <jose.souza@intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Message-ID: <ZbkSvcEtRgTXuzgJ@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
 <ZbgYyra1Ypa0nf6u@intel.com>
 <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH0PR11MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f0c879-b51f-4ba7-a654-08dc21a667d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iMcIXpOcStDICHZ4BmbOxCOGl9LijuWptLY9sJp/B7N6HisblRXgnvwH8PrTziP0F0LVMDXZBpHVVZY+N/ZWyi7gNBQJwQd2hSguXVG29J2YmLUM+LlKxSfu01HE9tkBePRCcdIg+N36RFFS+KoRFukyuZDyQQG40iI3B4prrPFVku8yojG09T9uyFylNe3mG23T+KcA2Vv40CPWHgdj726/j5t9N4oVwUTPz6CptokimvuzNcs1Ij39VLp3NAGs1IpucNBL8874EeQwzo1PfqY2q4Nh1ftjcS6P6bCCE8yE+VbMlvI4ScpAa5OGEfgJ9WQBvrdiobHqydKgoydPAuWdA3eH2JduXAlg+yUxcc4ZbbsYNmctZYo+5dYzF00v6vKIjTB5FkGM9QjrRWAdJ5VOMu5LSx3SOGa3Kgm0fM/33TUuM5E0zBjm48XX6q43tI0QCa2iE4Il0jHlK3XaLrJRrYg38Ahvz30RfGsDbpduqvyl2I6F6Si2jtHGfs0pcmdASifhARkERXBbSg2E4LO5imnocOHsPlE/Y9M15A7fjczMHMq5wtW8nRzq59O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(66899024)(2906002)(41300700001)(2616005)(6506007)(83380400001)(26005)(54906003)(6916009)(66476007)(316002)(66946007)(66556008)(6486002)(478600001)(6512007)(6666004)(38100700002)(82960400001)(86362001)(44832011)(8936002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lAwcM2sTbm8S/6cvv7XLAVNve7gZZ0app0S0e/kzBrQTmEpq9TEe99RvuLnJ?=
 =?us-ascii?Q?cgaAKwij9TitY5tbAXJfFPOyHuploOEDmpLMnwuMTWA1fCg4nwm3jKpTaJ4m?=
 =?us-ascii?Q?kA/IsKYnAqENdoE2aoPN3K7VDMPBpZH/4iGfnw7FHzIzPWD1lUsgsmfwLGOV?=
 =?us-ascii?Q?ejUIPloMFoOlOpRMcZBGqxFdZOmoRE+vJGJeJYF1MjNw6XKkxI9i5JgpN5tv?=
 =?us-ascii?Q?R238SZuXUATu3ZnaItetbqON+wZDt8VJW3fCcO+Wjmrhp4HJEsPLGiW8ABir?=
 =?us-ascii?Q?KTEuqrVO3gXvRep1Ml/Vfe/JYY+ZXFLBCp9CSnJ4vkHSiY+P+n22j11wSODE?=
 =?us-ascii?Q?31MEk3MDIQPAjHTCsNe0+XrTV6wgi5sej5sLMmYf9blbd9oQXvznCyy4p5Xn?=
 =?us-ascii?Q?5J0jqDPMD3kng4o0DHqV6xQkuLz8YsinQ+kdX6DGHLyzdRPo1HSHpMXqezLC?=
 =?us-ascii?Q?zv5oHncH608K6reeKrLRoNan+GENklGaT1P3jK5VrPYDbmk35e+PuYkAkiZp?=
 =?us-ascii?Q?3uHrVJLyKi1/N9lbBlRsQYqbiKangSWYFqQcCL90xtQAxYbj2aqU0Al7HSIo?=
 =?us-ascii?Q?WRarNcPsSnxvpJUJjzpqesEtRx7oecG4WnRHbSYBtGc4E6+T0iMs1jTCgVyD?=
 =?us-ascii?Q?Vn5lQOBcuZLWLlWjiOnZYDB4f1ChH9YRX8J6JOqr3Kn3DTvG4YnDZAAdcWm0?=
 =?us-ascii?Q?nMQW8FTEI9VZK2QZCpIINAEVeEc2ed4lyyiUSK9Mni3Cd1yUPrCFEz/ldLow?=
 =?us-ascii?Q?wWq9VW13p/Yvr63ZPJ2UwSFYbiCNgTMYvJg9o1IdGlPfGMiixZCWYeNF9KJV?=
 =?us-ascii?Q?RAISVlT+CwNYEiqlr41DsvUAB+7BXW3ifIh6CN4G6Eni3xYPKJlXp0WZ+9NR?=
 =?us-ascii?Q?3y2L44bXcjJPZgMB1+D5xDCQFHEfjZ87u6v/dnXfTvl8fwgrRGrgGye9axTE?=
 =?us-ascii?Q?eZC8PeqMl53h0dgPvlNJWKhoy65baSBOQkOR61OVt+dNeQf4oAruO4DqdKml?=
 =?us-ascii?Q?q4THcjpEQyrbvXhyYYvtdTl+4ueKMZaX41m/iMAehrQH3jTNHNW1esAQCFdq?=
 =?us-ascii?Q?dAGfF1llMSd1dgyibihNp3a7fHvg5GmW80yEKY6OgnJAu+i7dy6zEv6jbOe+?=
 =?us-ascii?Q?oiDZ1nCqa+gseGsFXsCebjelepVvCkC4OT2TjO50/xPiAXOhg5+c/OZSyn8D?=
 =?us-ascii?Q?CMuFzzC90UTADKDCCPCIbgToBo9/q/Sj+krzmDYEzC/lNdATWgnvzYw888aA?=
 =?us-ascii?Q?QNAnBvN1k7/UBf4lt+thgOmqx91TS1Ac0xIdMUEgmPt+2F/rjJUocfiLIpCY?=
 =?us-ascii?Q?fngi9LQ0CNhlTYRK9OautSW6ezO3aEDlam0gDajZmstE5ur6JIoXZDrhkB3e?=
 =?us-ascii?Q?RvVCbOpFSdOuvoQfprw8MbhoPb2BkpcSXbR69TGjX5id/KvJ+Y2NMntm75Jk?=
 =?us-ascii?Q?sXe+ywII2Oz/xXhqvmgFtB7Jrjs9+Lh5oJcuYoOcr1MI37eQJkQsi3Uut/Ii?=
 =?us-ascii?Q?gfekWYIoWkEnKtu/jzAtAtPlMf0ymEWLDpoumQ0e6bR0HlwaJCTeZCmBM2iz?=
 =?us-ascii?Q?wbrV30hUXJwc+J1IGlIrfPnoJLqZpjG9hP6J4o13?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f0c879-b51f-4ba7-a654-08dc21a667d1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:16:17.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpesBPD+WdtxClbRLUcxtPUG9nNSKRkUEmq0DXy/tOVTFPtRc5t7T9akjAMg2Rert/KZ2cNCtZASum3K0wMWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

> > If the failing_device is gone, the 'data cookie' it used to register with
> > dev_coredumpm(... void *data,...), is also likely gone on a clean removal.
> 
> That's on the user. You'll always be able to shoot yourself in the foot.
> 
> > And to be honest, we shouldn't even count that the registered *read()
> > function pointer is valid anymore.
> 
> That's not true: the module cannot be removed, there's a reference to it
> if you're using dev_coredumpm() correctly (which is to say: pass
> THIS_MODULE to the struct module *owner argument).
> 
> > Well, we could indeed. And that would unblock our CI, but I'm afraid
> > it wouldn't protect the final user from bad memory access on a direct
> > $ cat /sys/class/devcoredump/devcd<n>/data
> > 
> > Shouldn't we consider this critical itself to justify this entirely
> > removal?
> 
> No? IMHO that's totally on the user. If you absolutely cannot make a
> standalone dump 'data' pointer (why not?! you can always stick the
> actual data into a vmalloc chunk and use dev_coredumpv()?)

hmm... fair enough. We would be okay here indeed since devcoredump always
free the data.

> then maybe we
> can offer ways of removing it when you need to?

well, to be honest my first local version was like that, offering
a dev_coredump_removal() that driver could request the removal
before going away.

> But I'd rather not, it
> feels weird to have a need for it.

We could change or CI and instruct our devs to always write
something to 'data' to ensure that devcoredump is deleted
before we can reload our module. Maybe that's the right
approach indeed, although I would really prefer to have
a direct way.


> 
> johannes

