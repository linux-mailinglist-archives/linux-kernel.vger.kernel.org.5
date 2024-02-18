Return-Path: <linux-kernel+bounces-70616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720EC859A25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FE32814C2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AE76F074;
	Sun, 18 Feb 2024 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6zCHHXw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B41DFFA;
	Sun, 18 Feb 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297256; cv=fail; b=AFSW3hn6k5byL0FGzZwOINfgdKDgUqNyG7MRr8MkmgQiJ+Ad/kVu+fl6CJO1ZtYNtRBemOneiQNba4ig3jBMT3HU3mWIiaIpV4je6yLYn+qq9yIS4UpWV2onSw0JnDcZRD7dkl8YDHBKnwv4vbMOWWL41ga4Z5CSGaxu0hubFfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297256; c=relaxed/simple;
	bh=uc74OaxEim2ftZsHEyHRmy2AJ4/Z8lKPUvPLdWRzNYU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dbGunWxtma2iOroMyfEBbUpiK5WocboSc/NFMwzbbmZB73fg9UgZcKDqexf9ad+z0Jhyh43ETOLElFh0QthTroWpQwLh4m0hgJAWlfbIoKkjSiLK6Zs0AeAXrlYUn9u7fErFnEFSebsscVwCjbyJXpBK92nUoECLqGr0FZb3pYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6zCHHXw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708297254; x=1739833254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uc74OaxEim2ftZsHEyHRmy2AJ4/Z8lKPUvPLdWRzNYU=;
  b=g6zCHHXwNH6u/jqFRQ3x72ElhIvLUM1vRIK4MMHY8qH4EllJYYln5ZDj
   SJYI5QGxXrVhLqW7QYd66vyXG6nvKrsZPK4V9dKAXXWS689s4biKhfOUB
   C3Z0HO/X2NZCyizzPG80OfhhgSaYRWBX7Iy0CGYrzm4HS+FAT52KnwcJQ
   Qq12W2k3oP5ISWtd1yRQ6l/ron+Or5dJN2X3hbvJyPE6g3aHpFp0vbFK1
   3/vdk4FgMDCEYr4LmaWgL6RCLpqeh5UygNZIghY9HB6ErnTnovOH12XZi
   pui4TaIzMSTudHe/5byKJsm+mtyHr2ntm0vfP9hvlv7FwQTHcG9rKIiUC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2799754"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2799754"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 15:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912762979"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="912762979"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 15:00:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 15:00:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 15:00:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 15:00:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVrSZD9EZeW6qJlxXpHySk5xzYrx+ICNiKzXyr1SoI4UUSN0pkvL98IH2eZmb5nywal5V2veQnJh9MzRBaD5ze8r2ufOlMzciQlLx8bAX9bSe55j71lmQUnLXyvsS3En2AZLEuv/5BZUrU3y6SxUe5QSkNvFLxydBhN4KfSnxWnH9D+3iK6HTC2+0jbRD21VASEnXpTJUDn2YZj39NTYEwmZI3Jybc4Jrb272jc8IGOFRVTpmdDbioNTRQ+sOfeBZOQpWjfeowFWsc2q9OE16W99asipm4ZNBBkeYAaX++bEgZVH2RU1f6RL9BevJjb7mkyu7tXlIkba+ZQyhpdWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsBBTlpANme5MbJGXfdA3+8cVJhgmzG2EctxwRHjAUA=;
 b=Y3PcD15vB9Vegib4CPZNg1h1QTeEZTf5YsaB4FXWLlOS4Rm2EsJlGYRG8qG42YlVJTMH9M1RF+h4JQ1efYKsl1C8/uvVl0kfcWvap4dbIRGk/XdWpBCHGAGlS7+V8fUKE8Fs95AlcpQuAqkOVpYPnxQ5ncW35x40K18f9f5cgNZOJXJOZEUXJFJ26I9Y1IdwCkYHpJpb8WprfsI0Ot9EZpV6AkKkNEfSHxYm+73KR2aIxxfOYXGp/NK3f7RK7ci07ypk/0UrdYlFX34NDpAhFP3X80yo1MpEsOZEErTaNhaOyzkWszDHwDWno7sImfBNhEdVv2cX+y8e0HS4kLXwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Sun, 18 Feb
 2024 23:00:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 23:00:48 +0000
Date: Sun, 18 Feb 2024 15:00:46 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the cxl-fixes tree with Linus' tree
Message-ID: <65d28c1efccb_5c7629431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240219090743.1019a5f8@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219090743.1019a5f8@canb.auug.org.au>
X-ClientProxiedBy: MW4PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:303:b6::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: c485eee5-3871-4068-8935-08dc30d5722f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FeDjOiEKTjwdK1rvSXOisUJjthKAM3DMaIFkwdKjAEdNo7KVaf8wsu+zDddQLLzd/4plgWWnlpELk3ubqHPkLAPaegQv5HQzUNcCPG09p5Ei8JBx15pjckHAGSsjNE499fE7Iei1E/aVrCwVcXsQvd7iYVQjFsCVqtYckUABjNP/fnucnABVn+6M7k0zEpGN1psU/0/La9QIjCftrN3sdjqctcxr0OhaLu3mo/x07qxO0x/wRRuajDTgUSIAImcXyWQY3wsqBufewX7lBenaoNbOIu8DeECnvHEwfADrbWFK77K1vGpTZENgcTxc4UHCF1hzff1CoyCYwGBFDOth7nG1umARYLDTPIqiA8OIc4Dhfp2LtCFhLCuEOv5nGbXeVaAd56x1kv4I3Ca2HUWUjWA7S4Ci5Heyn6kPjWFa4iKNAFFnCit2ACA2+GqvP1TY8rlnbhhJkhSlklcMunliuD6/JtazjQkoSPl6IogomsaEDwvBXYc/zKE8eNyQJ0uIIgp488BUCiK8LebD3YeDkZLZ19RSchEJGZ8O/ML32tPdgSfyHTRLG220zycOY9ee
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(86362001)(38100700002)(6486002)(6512007)(9686003)(6506007)(478600001)(316002)(41300700001)(54906003)(110136005)(83380400001)(26005)(4326008)(66476007)(8936002)(8676002)(4744005)(66556008)(66946007)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RG4n4mi9sTk6DzmR4LXRLbQVdT+Iy4Lsr58W188HYYyUZJWJ3OC0i6/Qn4b0?=
 =?us-ascii?Q?dqvhSg+SbBw8c3NTLWqvYpsCEoCqr3yOjDtQ/Go/vyKxrfKiU/7tQK5ZIMSq?=
 =?us-ascii?Q?/BY9SLe630OZkjsBj7U1FZzGX1OMvvJZ1M6LFhpjIcRmEv3NTMT2R2uHgYWa?=
 =?us-ascii?Q?jcvxsUjssGpwvjg482MruBMCrG/DDiit5xn4f7AT2X10M+yCMKjW8Qv1XK/7?=
 =?us-ascii?Q?L7CD0LqejNoNuamEael6HGg32j0V07MiPsKF622PAETMlBxsWwHW5BKASqlp?=
 =?us-ascii?Q?b+pjtBfTXn2hY7uYwW0ljnxpruWyzgh26B0F/gQ9tufTivw+CHsyMyb7Rqfg?=
 =?us-ascii?Q?pQFeGtsoiWuUMAjmF1GStP1gEF3PMO1+hbiNgKa7FrBMF8oYX0fFWamDpGoi?=
 =?us-ascii?Q?JYKYVPf2cjLoS+/BypfsiOFn/odn1KJMt1lA+5+Wz+LpEXMLQlAH0W7Jqx9K?=
 =?us-ascii?Q?ntPJQnvQoMDJVIT1qo5BHT6ZshealD8R0yDA1LKKWZVkNQUBhNT6EhaQjXlq?=
 =?us-ascii?Q?2TA4W8J2tz/ldy1ayvuc2/1LODgHVoevmlVFklx/88qhVPhvj6Bq+pdmVnpz?=
 =?us-ascii?Q?d78EG81jzvfFfiMtiRvfqrLDBRcrgvfh9OsNlw7eCN/Jvzumo3GZksXAFXdm?=
 =?us-ascii?Q?uAoRis7py7V+DTex23akO3JtOkfjFJBrRGKytAiiH4FGBjyYvMdC5VRGV1+m?=
 =?us-ascii?Q?uI2KuAL2JrduM9vBblUP2+lES3iQC3MDygPU4t+sI75M6ZhTlK1zsOGLW4nN?=
 =?us-ascii?Q?xyyAT/rjzD+kYdgSfaGrOtHHy+6qxiL1M+B/mVUlAqQEZkKSYwA8Xx4TgBXM?=
 =?us-ascii?Q?THJyoAKPf7btd90g1PIHnnG4FlJWwPbAdx9zfH5iUdwbSvCStXJ8lx8fT2/a?=
 =?us-ascii?Q?CfHuLKX7sm4Rfvs3R+pCBbHjVsq+Nxyhi3yhncXGMC30AGWwtfIJxY9U5IkQ?=
 =?us-ascii?Q?VgkPW2gZXc4fd+RDgVYsjrYlWeQSu1S3vd8Row0fVBW/WWBJny2i7qP/HtD4?=
 =?us-ascii?Q?ql+TyZKntSuoVQvgoCcrMmlfxrRY+6kTl0E47Bg1kdyuYfiam3OGwncJBo6g?=
 =?us-ascii?Q?L4AKdjUJe89LWryVewk3LS9fvjNNNUCZGbClJSZ/25oJnrgzOLrskMERpd3o?=
 =?us-ascii?Q?6JcoWxRT88Bb/NQPOFWO5wVd5mNrAk79AAxaxCJSHyoIe6VUp+VK5eXbIgap?=
 =?us-ascii?Q?U3nydiHowh8UTW8H/2v8REg+ep8OizNDZNIBGpzUYqQwOBYywezrXYvcJ1d2?=
 =?us-ascii?Q?BJIA8F0dJwJAGjKCCXV/eJkv5g+iOa44UEBJbD5yTiW631dpM/MSP1boprbt?=
 =?us-ascii?Q?S6BC8XggIDVJUDxM5kXYqPNHyAIJF/WbNsX1rX7i31+YXypbRrZown15n0PW?=
 =?us-ascii?Q?Vc7YrhcqTGWMKgxrtjITSIzOTwxwNG6rKP9QimgxC8+5z/q669GinQYpQ4/H?=
 =?us-ascii?Q?xSqo6etN5zB68dEgpHGYQ2DUXrNTRVgjGqhnzt8nKBYisiUvSIjEe7WxMrpz?=
 =?us-ascii?Q?Ygol39Ag57O1J0o1iRSrQZ8uwRyPLY+R49PC7k88Rv9zEo1l8+t1+3ABQmNj?=
 =?us-ascii?Q?VDM05tm3FT1hXvLHV3rFVbhHDbAMbdasAiYNfvX88UoopoqTpy+vbRQ0pjgS?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c485eee5-3871-4068-8935-08dc30d5722f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 23:00:48.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Pza6CrifJBLnXN6jTBs/w0HGZ/+95Y2WiBlbj8zf+idfoAzZQnkx0VpO/Fn7143UiTQlyzLxFsEXkHgHEtQIOhC+riQwkLuTP78CcbfPP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the cxl-fixes tree got a conflict in:
> 
>   drivers/acpi/apei/ghes.c
> 
> between commit:
> 
>   54ce1927eb78 ("cxl/cper: Fix errant CPER prints for CXL events")
> 
> from Linus' tree and commit:
> 
>   6cb604ed24a1 ("acpi/ghes: Remove CXL CPER notifications")
> 
> from the cxl-fixes tree.
> 
> I fixed it up (I reverted the former commit before merging this tree) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Sorry about that Stephen, I had not realized that fix already went up
through Ard. I have rebased the removal patch on v6.8-rc4.

