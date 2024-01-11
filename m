Return-Path: <linux-kernel+bounces-23148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597A82A84B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6661C2339C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4904D28F;
	Thu, 11 Jan 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+BFnxUO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B21103
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958011; x=1736494011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r5Xa3ng36iWB5ujeoBieUtAJmouK1ZUZd+BoeXJWoQo=;
  b=P+BFnxUOPRffnrCov9YdZHr2jSa3U2EYkLSSoiR7TjjGn47W8Y7kTMZu
   DUBlpccQKQB7nS2W6kAT0M1hhNp8rVuOnGlcTpH/8kkiNZipDqgpZPZh5
   zgKt2T5rc3eiSRqv+TSMcUk+51HLJS020UAi7DLdX6JQZBSbs27YvG7Yf
   tJCkH8cygrtpdzrF3bhJsBFHBgI7O3oZOITJHEd6SGiAppNWqJhzshc8R
   RGbOpBqhD0xbHNLDm5X6KH11TFNoEmMPb5yIGlYgB8Bsuljb8sZtxoU2X
   Jcj4V91k+oz5uMFl/cykjKIhqxsbfnNEbEtK+vRALNa8hrH3aFr03FX6v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389202702"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389202702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="816628886"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="816628886"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 23:26:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 23:26:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 23:26:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 23:26:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dphoHAMX5wM4wHVQz46t9ea13VcKPDEzSA0flGo6oiIV4VIDr4kAJSctPIA5D1aUewLxr91rCw2Q5IGBLYnMUmkpEc9FpJPPCRHMrGgYXGnCyW2M1n8rdnoAMkrWiNI6QHTK36+iiMgvfrqamZxaOnIMOfc9lhImvPxCUsvRs9+W9EvaUiIIPOMx8I/cMa+ALVdppC0KIZpNGOjoqm2H/RWHZ/jAbRI7Vwdu4CPLGS+K670Fn7XKwpASAcUPiF1i4WRpiibpNbVaDk1V8D1sSzxJXe3AJfInw7P45eUabsVNl5uwFq92LY0Yl0ogiKnh7FHvCvKafa3KcN3rIgGmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPy68ZaE7nONp9XN1X8gR6EIfMYxad9/bJt24rbeFzI=;
 b=TJ3RCFzRAM17pL9uTKjEicFKbofOtDmXPy00uX/6Z8PcAVjEJB0AgEQIo9FLupEaSjy58X/9eAVvNpyKsXoPc81lGgQO8Fy/ExJAHKIkPVLKB+fqWMfGI6Tb0qE7/RRp0uwlO1t8mND8hkacrDJR+NgGZi1kPqk8OHx4SWX+bIZFllkrgwxc7sLlfbthuvxbTjO1KfsWMQZO0xrx2N2Afsdi6ydW8BKGuFbnl0WhUyJJoVPjlunOp/rvJs6PZS08axPklpQmHWiaiNj+YluGljf+IyqqSyUk/TkUNwJb7uHGs32SDnAp98V9uHNGmk8gmxuN0eaBic+zfCbnDrggPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 07:26:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 07:26:37 +0000
Date: Wed, 10 Jan 2024 23:26:32 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>
Subject: [GIT PULL] NVDIMM/NFIT changes for 6.8
Message-ID: <659f98289aefc_aeafc29498@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f54237b7-7939-4307-f564-08dc1276a538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vm5PN7Bl+XhblHoKznVm5xu0mTjIJGw1wLOcROV2VYFF8Z/Btmb4jQBnvpZ1wbuiycnxLXQWgFESD/MkfLrR2HsXRB2MB3cIL+3BBRxV547/rKjS1gqopkdRpRXg2HxJqsNSrkoAGDYw/PeOBljIBRce8uL0y+Nv942QnmvZCfkTTp+zfe0zmgTaSRMjdOwuSgpHBcvp2P94dLWcp1EmBNS9fXemaQv3rotCi9wATR2ue/dN0/2j7KruU4skoLBqtGIvg6s1z6s7qPANlW9DPiTiD+MvuZuXFypjjQnVmwVq5NHxWv+OUIhrRzESUUhDjkiMI+qfiD0DM7z7Lrigubw4jjC5DNk7HzZEMpmcV4VAPpeU+oN8apDozNGvAoap7VK423NHfD8wzzDrBHNKfZRuUYSiUq/OQ6/bGCbc1o/k0JeN6Xto04oeu6ON/wHaYa/DXpVVN7n6bziXXvhRASBwdcjAl0pRdpkpSnhS1AjMwYnC6aw+pJ9yaYGXQGAwd1Mh78jpdollZqz2wyzU/81bTiett2Tg3oC81FMkSd+c166vpC6rTaZaJhy5ilDU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(4001150100001)(2906002)(44832011)(26005)(9686003)(6512007)(86362001)(82960400001)(38100700002)(6486002)(6506007)(478600001)(83380400001)(6666004)(6916009)(316002)(8676002)(4326008)(8936002)(41300700001)(54906003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfTfisGXPv+6QuUeDoBSZd1vwMWE+fyJGZDQIisz0jK+B0b5bc5W+5m5j4n1?=
 =?us-ascii?Q?BwxuomQ/gZgnpk9/Cj/muDZ1g4KVBLWMqLQXF01aY+0VGO5U6YEbMqZDbvQH?=
 =?us-ascii?Q?fUOWZD33RbZ3ze1+bbSeEVhQt4gIfgOfz0d/H8JyXu5ZBzKw7/uY4VoAXODH?=
 =?us-ascii?Q?Hs51MSGTvAm346t3tMPt3cRyXGROoZ2S09H3zMupI+CuPdSBlhsR0cMtBP64?=
 =?us-ascii?Q?+74yDb4IN+eNyXu57ncRvgYfojd3s3/3lFhNDFcxu3UHOgski/umDJkuvSju?=
 =?us-ascii?Q?Q9oVP3IRJaU0TF9kEWa01T5kZ/DWqdSjtUYXCncUC0vOQmZby72ZDxQLkhE6?=
 =?us-ascii?Q?IVsK/pO65o6/+uO9piE6vdz2NmjdIUJwacQCS+ApQx+Xh7CpTbk2dDm3+QBz?=
 =?us-ascii?Q?blGO/64KNyzmx2v24Xmy/dopxyw61ciCxMTfVN/J6txxlixVEQdDNXT+kutf?=
 =?us-ascii?Q?2/IlMFKaKAptA/2ioN9nJf2xr2XPq7xIoSiLAif9ckqP6AcX4hDJKEImCT0d?=
 =?us-ascii?Q?5NZoNJ/RfDZhUTcXKSYURkrJPp5GFvT+xzGB/eZyGf4UQ0Pxo+dJ6huJUAZY?=
 =?us-ascii?Q?nSBpVkKQOMuSgDFbirrkHWrGBo71jmfMPdb4GYgh+NJLvSCrtGxvmQIc3jb0?=
 =?us-ascii?Q?DWWeKqt0IcDw4ZM9+BDc4DupgF+DIUXs0plZPGATJsWzpoTf3aAYf6zD21Oe?=
 =?us-ascii?Q?70sc7OR3JrbCsctBifWVp/Acaf7dn4sr4oOmuRAoU/JJ5InqstoMIg5SpesN?=
 =?us-ascii?Q?QLOvIm0+1G94jYkFb4B+vH/RvJiEVZXZAIi+2mC1Pxtm9ltQm3r5vU28jbA3?=
 =?us-ascii?Q?EZMx6VVDg27CREi4xm6zIC9+BcPUx6zyWBYgcWx3S5wQ5La2MphxeEwl92yq?=
 =?us-ascii?Q?2BVhudOJaUSvJHQ5FOnBVNU/NyqA5bbXtsSCr6n4lOokPmcVd4ymBfKps9nw?=
 =?us-ascii?Q?gKvx7HeSlXRAjptvw+HCLsZPdEcykTsdxKSCktDv526mURdNlYaG4tFeXo3H?=
 =?us-ascii?Q?NYmf97Kod5J7CRIpKo4SA5/hnSDbFDW207DGDdbbeXXEylBEZU9uZtGmPAUS?=
 =?us-ascii?Q?xdn2fKz9PkTrTKay5E7oewqGa3YNwuGqDD1TeJVMlFY7p6fsVeiCgad0YQoV?=
 =?us-ascii?Q?25xQO493eOIJJvP3OtXb472+SqQ9rHBD0PYLa9lfo3/D1lSg1jWCio1VZjw1?=
 =?us-ascii?Q?I3QGt9EH1mPHUlC4vF63O9Nxw3roAZ3mO0eW4z/4JhaWxP/S98LQN+xxGg7B?=
 =?us-ascii?Q?1fVzByosnzvK06Xx+DCMTHLjywvBvJ019LuekHzyeyzE6oWOIV9MGh4Y8v/0?=
 =?us-ascii?Q?1SZEOK67F6Mtu6Q15lFIKT0XouaCkR5XZVYKzUNwpblexVCMCmsShXAr/M09?=
 =?us-ascii?Q?Omn2r/ARTkhkuICWfm8u7BQ7TCYaonMRsbSeV0ve/LgPvNYg+5II3CVzScH8?=
 =?us-ascii?Q?ZTNLNsONZcxyFLzaiFo2OS7+nKd1b8g6fBzzZwu/3pfEsALhWpdKRCM3ycym?=
 =?us-ascii?Q?VkhwrGucgUyzyk+sjW2lf0yc6tKrzaJ9zyb7TYnUjWSSQqwCjRGl6V4650Rf?=
 =?us-ascii?Q?Kz/sDyzQqekzk07OH+4CtU2nNPRaxxopwRBcp0FG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f54237b7-7939-4307-f564-08dc1276a538
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:26:36.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2g7jkVgPh9l4mr2xQdogvVpSUWVWavI4aCpw7GEjMb6HWr8H+idi+yGH2Y0RPIML3IBTbFDPnVLhkmjuathww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.8

.. to get updates to the nvdimm tree.  They are a mix of bug fixes and updates
to interfaces used by nvdimm.

Updates to interfaces include:
	Use the new scope based management
	Remove deprecated ida interfaces
	Update to sysfs_emit()

Fixup kdoc comments

They have all been in -next more than 6 days with no reported issues.

---

The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.8

for you to fetch changes up to a085a5eb6594a3ebe5c275e9c2c2d341f686c23c:

  acpi/nfit: Use sysfs_emit() for all attributes (2024-01-03 12:21:37 -0800)

----------------------------------------------------------------
libnvdimm updates for v6.8

- updates to deprecated and changed interfaces
  	- use new cleanup.h features
	- use new ida interface
- kdoc fixes

----------------------------------------------------------------
Christophe JAILLET (1):
      nvdimm: Remove usage of the deprecated ida_simple_xx() API

Dan Williams (1):
      acpi/nfit: Use sysfs_emit() for all attributes

Dinghao Liu (1):
      nvdimm-btt: simplify code with the scope based resource management

Michal Wilczynski (1):
      ACPI: NFIT: Use cleanup.h helpers instead of devm_*()

Randy Dunlap (3):
      nvdimm/btt: fix btt_blk_cleanup() kernel-doc
      nvdimm/dimm_devs: fix kernel-doc for function params
      nvdimm/namespace: fix kernel-doc for function params

 drivers/acpi/nfit/core.c        | 65 +++++++++++++++++++----------------------
 drivers/nvdimm/btt.c            | 15 ++++------
 drivers/nvdimm/btt_devs.c       |  6 ++--
 drivers/nvdimm/bus.c            |  4 +--
 drivers/nvdimm/dax_devs.c       |  4 +--
 drivers/nvdimm/dimm_devs.c      | 17 ++++++++---
 drivers/nvdimm/namespace_devs.c | 19 ++++++++----
 drivers/nvdimm/pfn_devs.c       |  4 +--
 8 files changed, 71 insertions(+), 63 deletions(-)

