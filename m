Return-Path: <linux-kernel+bounces-67302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F44856973
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7444228F4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CD13475D;
	Thu, 15 Feb 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9xkvkoE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4713248D;
	Thu, 15 Feb 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014160; cv=fail; b=TWzwCJX6sdHKNGKslJZqPhGoDJdcQA1M/kx2+TOsOqXb4ebctAUlX6eo+R/F/A9H10Qk6KvNtNyZenE4G7mSWx/Q7euz8OragtjaoD2vLRRoSVwVjUYQ4eXcP6/Rtpv8JXkP3yIu0V06HxDQpEoCwGQ6w/Pw7OTYzGBJVxRVRhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014160; c=relaxed/simple;
	bh=q2CIOf1GztNLWfsKwqMOSncSskTbnAgV4jkW3zoW83o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQ4wmCcWPh7ZgkDjAwpJXDv9BQ1Mofou3Zc4vV+u4JXrYu4V0MOB5qYOCgvDtX5LuJWtt2el/iBUMYVt+ild0dFkdNjpl/mISQrOf5O7SA3qQicg+mn8xCHGPzCEbadHQ88rYnegHufWGYZfdwm1lKRfxjn32DYlj/YJQoVDO5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9xkvkoE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708014159; x=1739550159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q2CIOf1GztNLWfsKwqMOSncSskTbnAgV4jkW3zoW83o=;
  b=j9xkvkoE1jbeW2WJJ4mDmvpy2C5A8nKnHwsFgVm7yBj2jcWPiE386IGs
   p6CXZFyD8nrtcOSS+tqXiuefZ3cH3NGaKoG6dqstKiOnKUEQGpyoeFQd4
   8ZLI3+RRrs456RN3yd+RS6dJOIdDVR7tQa2eKfk0E9ojzFZ4idsPFQgBn
   jDlHUjJ7qO2srE2OTa/rWpVAO4JC9gQ8M/H2KYZfAk+Mfj4nez2Kv2RWA
   LW/zEzH0Z2hzjSMQwDmpjgcwtNg2O4goZQRp+8CKMePuUl8yEwpGge3ys
   T78Xiod6pw7xeiXlDrF4Y3y+LItyZOaAF+JcMYvQXXtDW6K50J0oC32KA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2238589"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2238589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="41064437"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 08:22:36 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 08:22:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 08:22:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 08:22:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 08:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8itc5RlBZnr2pphyzSot+xXUXq3geqwGqqou4+36O530b2BvnyUJgAdY4LNcuDtz5wvDlwgLCNwo1ws1PD29Gps85A3Wih/euqO7aN+dhEW64PCFZpJteULZtOh4qam3v4gtEi6vZseqFEOPLiL/1/k9dbo/lgCWhEpAhGWiDuLApmcUF/SnspT3jwVyU7TRLwUk6q+9ihkWs733hbY79RvLKcFbgfRfUbgRf4IrDKdWkw0NSweHIUyGj6o8cqUvCQM7UaoXpl5Ytt4ujPFHw1z+yKH60T7KSjGgFm6W4yYgC/cM+L/wQy0LBmur38HhSa6Ivnq2B1wthe8pSkNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaEmdsULx3dq76m8EVpwHagNpl3Fq6DzCap5jgabFsQ=;
 b=TwmFCPO7ulslygZyBhUUmXxGn594uw22ETS7MGKuTF3UnATvsCm0lWlQbWnZbzYWabinxhfzUSr3DItO9rC5zs1K2pEk5ewS8GwLhr+x1p1uP+wz8RGL3zEoUsRf0g4dTUPmuyl/smbPbD19HxYGGZ1wMJ7epkAEKaOhjthsUCXAuHbk9rvANRE3wd5ZYWnqb5Xo1RcvAjUrboTABE6Kh4/5yGp3wSX6KuGLdiWYzxs+66W5ejx42VPDzdTDDxWxaUEroemF1VBKOv7eSkwr/cwxREEpvTekfj8fYF5mLvYvv0u4Xz4dyCm1L32IZn0EQr2BZ7dF/w0E9bdxtx0TnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.31; Thu, 15 Feb 2024 16:22:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 16:22:29 +0000
Date: Thu, 15 Feb 2024 17:22:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suresh Kumar
	<suresh2514@gmail.com>
Subject: Re: [PATCH iwl v2] i40e: print correct hw max rss count in kernel
 ring buffer
Message-ID: <Zc46QEBEpCOL75qN@boxer>
References: <20240120072806.8554-1-suresh2514@gmail.com>
 <e524c57e-fe43-4582-bb05-c50f3e529848@intel.com>
 <SJ0PR11MB5866EAA3CBAF4E28842305D5E57D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5866EAA3CBAF4E28842305D5E57D2@SJ0PR11MB5866.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: b06ceab6-95af-47bb-4267-08dc2e424e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFGaTclkSSUb8XyrEgg2kN/hmTAFsEzSKS+a8L5YJBt/hXLw+mGxyASvybIjM7sQSHsT6ge+RdfDn8lR6vuGY+7z/DaPLq/kMpvTeG4PBxrRAvJJ8dY4OJkSZqEVqM7n9NM7aNWT/E2q4RvIy5d/Q3+Dn2Ydfgzm5OqjhrBJ97AFxJ1FCo5/wJGfsGSon0ma9kvr0dW+4xLkUOjL0bs9HBqzFVlB6loy/wBf76/Jmz9Gn+LoUROnuXMCHY0K7BAoeMhzbevVIW72pYegJfETT6T/vclo/sgaE9GSyunGpBZ7dgurND7th/vrMXAAuixNgy5FAK70YUSM2JDv0U6C1yUezlsE0ZyiPyQH8WjKjjpSfTbwv/eUWq9ZqgFTHzUX3xzCegOBopHQC74kdrcOBSJVrCVgQA4FiDPCntiCNKmf3cNtIOOQ2mT4LVaPnQ4yDnOj8MtIk0LdJnzGvzrHtZgGlt9PUGSAjyHtUEWlAJCF5rTcSx4jC341MI3yql+RMJXzNIIop5Tquof7+it7cJNPWx9Cwcu09gv50MldOXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(33716001)(82960400001)(5660300002)(44832011)(2906002)(38100700002)(4326008)(6862004)(26005)(6636002)(66476007)(8676002)(66946007)(66556008)(54906003)(6666004)(316002)(8936002)(966005)(9686003)(6506007)(6486002)(478600001)(53546011)(6512007)(86362001)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PzVF3Kqjih6LfI2bhugCvZsQVwyYF2NNFzIvTnVFkWCI70rCcF+7q26WJpbo?=
 =?us-ascii?Q?KoiXc6QiNV+N7ibsoC4yI6GDP3Q74JKc7HezjFs6YfQuOK/6Sb51IS8Ra2Re?=
 =?us-ascii?Q?bBmV0YK2FVVTp6kzLhgKyMvOzWamfudsj4sd+YxuFP9D/5tQ0llouBbYDuVC?=
 =?us-ascii?Q?C5Ct9QoYhwzwr2FOF8cgqrBKQqRygAioL0cE4XxsR01ebJVAJ9UbmrOLsgjl?=
 =?us-ascii?Q?VRgiv1IilfhzIVgmbzZQHcm3kixGgbEohuMDBiBP1vG+8pOhmkRvABdf51I8?=
 =?us-ascii?Q?NmNhFrC6qT8ReWplM5hWJpmYqb0bs3k3H3lW4t5dMHjxRGO9oP6D32F++h0B?=
 =?us-ascii?Q?str/hU3Vvja0kxlwG8bIgQmtz+ES0gQdZXVRLkdnj82c/HnvVZnKsKnHiKG2?=
 =?us-ascii?Q?5IIB2khA54PCVv+/Roxm5IIdUaEd1ISQpnfG3U5h/gHxV5QNvMxxAXOQPQMF?=
 =?us-ascii?Q?YRHyvzTSWzOKagWrLYdOBQA1Ib0apljRVdv0VMq0BYnE2Duaz2IB2hX0ShKt?=
 =?us-ascii?Q?uQTHrL0UChmNcZxL67PNnUuJy4n8gvp+nqbEdd4xyoeWC64auWwtUFqShkWI?=
 =?us-ascii?Q?114r6NNwPJPzwpyuPOKbG5/IYBdUjqYsCU00JgsGxtW5Ah35J/Qug6SRul+o?=
 =?us-ascii?Q?pgXqaJ1inOZm5ojuYr93z6Wyqaq38/tfZY8WOBXP0baZuLtL/qetyPdEhXtO?=
 =?us-ascii?Q?zheJVw2FH7bXAmE46yuqO4WFzCKxt37O+44OdBhp8VuDTrM5zqy0X8rCL7OL?=
 =?us-ascii?Q?p0XPvXzMO9iDoFgiwC96RK6uvKsK+nKN6ll9DHb0nS+5uKcS91bi5tP3yGbW?=
 =?us-ascii?Q?275U0CtQzpCg0kHjXtq2z9RJUx/owhukR6eFNcHx6Z6MPEb/fqsiqZdUfwQ1?=
 =?us-ascii?Q?HFxjC+kzB2kVTx7H+E/iadyY4AoqNL9hGYRPbwhO8V/7rgSXAlJ03iEDa+pY?=
 =?us-ascii?Q?1Z8gpLL6x1P8Nj2qKI6nhcZWEuEBNbGbfOISQr6CIarSI0fhWBOJyfHfFVRN?=
 =?us-ascii?Q?81YX0yleqdiEEdfGuta2D3hqwayPH7iGK2PocquTxy8vjY0V1ta1T0Xi/71n?=
 =?us-ascii?Q?E5kIKYKEIWQeCZZ2DVoPhgDPTZDYqucwy6+TVEJ/a3jBtda05vWk4Qey7sJR?=
 =?us-ascii?Q?ZgpnPdZmd1uFN+UFIeKsRXMQQ9mly9hIWaoF8YatbXBIWMv2w43L2P6Ua7kb?=
 =?us-ascii?Q?dwuQf/V5KuIEhJKyDG0decRR90ETcXpM4ermh3rTfzAwW4iqGaiP7bm294Bj?=
 =?us-ascii?Q?I6xbstEZZWjpLysy72IE5Ivgw0p7lFCJqbQdWMHfsjmJ9xxB+FgyEMl/dzaD?=
 =?us-ascii?Q?vmRSJVqAObs52IpIJf0j2t8P6HTbGJwYbPwJfY/dBI5HUmLaF8U3ZhSCq/Ti?=
 =?us-ascii?Q?sPMR1qc/ZhcDlkRNY+qVBbmQ46ESYlD4UFa4pAXl9OkZiBwWalmh6VgkmueW?=
 =?us-ascii?Q?JJzU+wzHfwNBG+AeiIVsX6GP/acgEhZdxlYFv16zglFmM05jMpBc9NlvRw0m?=
 =?us-ascii?Q?kQqb+y2GVFVu2zG8QQn+LhFZC8yrRf6o1+QBTxKOG0lfKQrQWgOyG4jRfXYh?=
 =?us-ascii?Q?iLy+HfBUgByWuOp+551NwTOXnPzvh3SbGNhUk0WBeNpLN8XDTq25MLWZIeWi?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ceab6-95af-47bb-4267-08dc2e424e39
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:22:29.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMSC8aMgoOXjF6wRZyxXuC1xJJmN2Sg4gWDsVOA/i6RQAIWHJ71lQjQSRgZaY+qnpt3BQaZaqH0TKHUgqKCiHtB8E8xQJscY1FZ90mOVv4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

On Tue, Jan 30, 2024 at 08:33:43AM +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Sent: Tuesday, January 30, 2024 9:26 AM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Subject: Fwd: [PATCH iwl v2] i40e: print correct hw max rss count

Subject should be iwl-net and you should have Fixes: tag.
I also would like you to go through
https://docs.kernel.org/process/submitting-patches.html

or any other document that would prepare you for your first submission.

> > in kernel ring buffer
> > 
> > FWD to Alex
> > 
> > 
> > -------- Forwarded Message --------
> > Subject: [PATCH iwl v2] i40e: print correct hw max rss count in
> > kernel ring buffer
> > Date: Sat, 20 Jan 2024 12:58:06 +0530
> > From: Suresh Kumar <suresh2514@gmail.com>
> > To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
> > davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
> > pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
> > netdev@vger.kernel.org, linux-kernel@vger.kernel.org
> > CC: Suresh Kumar <suresh2514@gmail.com>
> > 
> > pf->rss_size_max is hardcoded and always prints max rss count as
> > 64.
> > 
> > Eg:
> >    kernel: i40e 0000:af:00.1: User requested queue count/HW max RSS
> > count:  104/64
> > 
> > whereas  ethtool reports the correct value from "vsi-
> > >num_queue_pairs"
> > 
> > Channel parameters for eno33:
> > Pre-set maximums:
> > RX:     n/a
> > TX:     n/a
> > Other:      1
> > Combined:   104
> > Current hardware settings:
> > RX:     n/a
> > TX:     n/a
> > Other:      1
> > Combined:   104  <-------
> > 
> > and is misleading.
> > 
> > Change it to vsi->num_queue_pairs
> 
> Please reject this patch, it breaks driver logging.
> The massage clearly states that it dumps max rss queues number that f/w supports.

..which would imply that you would be able to work with anything more
than 64 queues. From a quick glance rss_size_max comes from early i40e
days and if that would be the limit indeed then driver allowing 104 queues
would be a disaster, no?

> 
> Thank you
>  
> > Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index d5519af34657..f5c1ec190f7e 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -12524,7 +12524,7 @@ int i40e_reconfig_rss_queues(struct i40e_pf
> > *pf, int queue_count)
> >   		i40e_pf_config_rss(pf);
> >   	}
> >   	dev_info(&pf->pdev->dev, "User requested queue count/HW max
> > RSS
> > count:  %d/%d\n",
> > -		 vsi->req_queue_pairs, pf->rss_size_max);
> > +		 vsi->req_queue_pairs, vsi->num_queue_pairs);

IMHO this should be vsi->alloc_queue_pairs instead.

> >   	return pf->alloc_rss_size;
> >   }
> >   -- 2.43.0
> > 
> 

