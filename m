Return-Path: <linux-kernel+bounces-45129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86AC842C01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F4C1C24147
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2578B63;
	Tue, 30 Jan 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CunAUGoG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3769D3E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640211; cv=fail; b=sjqhfnKY8pXsuv0q8+zRZOpq7sYslApeFy4pfDqp8VhMlWKpva0ZBV/FoPDCw95Y4cOpuWctbPLPTCwWsTHjJ/tNRbD2/BhWc83p/U3HysHv7Nvns/+vE+L38R5A2S+zeoDzXsOx7M4KyZhSau4Ny5a3Xd+pc44+cH1H7dsgkBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640211; c=relaxed/simple;
	bh=QnyzIpbig9vBi+g5RUn66cwdmOGyB9fedyUqMnACGUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxCzi6uSvfklu7XZcb+ncFd2f1vMw9H1Eot0qhdtFeFNEqnoSbZIGG2f4qhn5/IF+dA38KJVOV4aG/7C+uMtbsR5YR8hOdGonTlvIAT0NT/Uj5hDZLVZ2wUNwtwtNgbeFqkuYstKnxjxxhjBEbO9jD30rTHSMOmOsG14T16GgUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CunAUGoG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706640208; x=1738176208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QnyzIpbig9vBi+g5RUn66cwdmOGyB9fedyUqMnACGUU=;
  b=CunAUGoGbNytYEEpxrIb1BKSzQfs3Pg+HVk0gneqAMUIOXd60mj4yaki
   ABtz2ypuIqOWu9Q31hOyj21XVQEC/FlrbEGKCTFuhhM1gHOO7KVylz3hf
   6hnAh3WleExYzzRPx52i7kv+rrXW00i6uXVX4YgWMKY4CTKwEm5trVsSD
   RPC5ruBr/2wHTWLXu3dt9x0fk+Oy16nJg9UtlQHWFT9E+XyFiFwInMCWQ
   oQ6KK8aHkDEj4azOWSLviTQGaSiy1Bwyd5YCYYlb+zByAXP6PYdAOjttz
   12a77YuX6jelJv9o/SkApe9/KtMMMFmpIxd0/4IYIZP2YsXHz4e8/wq2q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10119537"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10119537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 10:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907582075"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="907582075"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 10:43:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 10:43:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 10:43:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 10:43:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 10:43:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzUtoswLtcFVJR43LX6yUYAyBWRO10BjIsj60dJ/Qbf3v7yp6GqkzQnUXTY6Nf+JmshfEAkZs6yOnmkLFmW8wGSqCdFDBtpi+ydnvbYWf4yFnyO0VGHR8gA/Mbjf/uvkKipGhr23mh0XN0EAsHJO3AL1NRot3PJDK8ldlwS2RekJSZK4h5GcT9CBa2cxIe4DJNombWlxDkATvDWaDOH8QGNreC9tLPWXCRAkzcmQqOExVQzmNHVOePK83rdWsnCoN2x1U2E4ng1G0nKBGDiHuN9r14QMVeDyM3ViZ7/JgDZ3FbgkrPKRnHFAM5PA3swnROI594OYWECO5z0jjezRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YJn6kOwngnfVXoJcGU/qpgx5jTxotcv6IurriDitMg=;
 b=Y30rXhJes96nKdfslV7jSjDno5jWI2gZ1vtJGZ/uoBrO86wtkTO4Lg54sTopgb9QmQqqaWLQCq4HHeIdjTkgr102SXbrh2oQWSUYWikIgixlSSL6Dq/LAwR2vhu0Yzp8y1D4QJYFsCQbIYQ95MHWb6SCQ3dG8DzJ5BA8wCXQioJBJUfBwApl9sdApnTMnUkaUxcw9glkxLjslu/tJJ7J0lxtjbQwprN1a/ndZ+X++eQkmDPKwCimR1BxgSVo9T1fjqVTUFXNtkJZxgBuiz9QwFlEysJtaigumFunR7Aey9xtfK/XIftYCaaJ04a/9Ef1f7fOQwnFaYu8tqgjemPCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 18:43:23 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7228.035; Tue, 30 Jan 2024
 18:43:23 +0000
Date: Tue, 30 Jan 2024 10:43:19 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b9434712b57_2d455e294a8@iweiny-mobl.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: a05fe1dd-c767-4f67-3801-08dc21c35698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaDf9RUH6/KCj5DliZd0rQMfHgYazu+nnAdQgcm16CSsnt/z+Yo6/+LKU0qlWJ5ZBUOH7mz9Zj41tkBPrvRdjvQM7td4o80MNGL3h858k1VIQtYmDbHIPid/jIySaLw+jrUGcnhnUv+VaMzl1mLzyND84mLGvPB7u9nGythu9PET/dWhGDuzUQV3V0KqTj0nqiX3X4XvC9b+kyj6aVcRVbhAiH9J7ss2C75PkbKxW0w5dY08qP0FsjrJdIYsMB7r1qlazwWwfZq67hjojb27lgj17Yus485plcGjnVKGrwrZI5U8S8v+CJHJQcDds/Gm8FJ4/evha9FGLe0AJoNPaBx7eIo5O4lE1PDs2EKu39SDBHCaDb2zxnLpiXESTrofZ3rTVqKJAk3lxTv8lUe5F6r5cqWYiv2PjC5yAhjVMSynioK+L6q6HLaiwKQ5OEdjlU+b+vOk0ZsdLOTY4H2ylZUukc4XTF310yAPvpRWHkOS/bMq5lgrxoKxriITP/E7w8Zncl5jCWwLOT0nYSW9M+FIjPQ1/VWh2hMQ6gDfmHF8IxOG6KsRk3eOXOJSCE3h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(26005)(316002)(9686003)(66476007)(6512007)(54906003)(6666004)(110136005)(6506007)(6486002)(83380400001)(478600001)(38100700002)(82960400001)(66556008)(8936002)(86362001)(2906002)(4326008)(44832011)(66946007)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhIk6nczcGmjoVHZw+52KplTez0l4srCZ/KcfK3kfCV6nnyKt7qFg+XEdR+o?=
 =?us-ascii?Q?G3fqraHFrdBcjLRT9H1uHMpP1VRwdJpE1MbIFgMkOYB+0PJsGgslNVXzq8Sr?=
 =?us-ascii?Q?cKUm9C7nabomp/dH+8/i2eu5rp7usJervKWp5ya4Lv2gd02WcpgIkTVjEC5B?=
 =?us-ascii?Q?uRd1ELnSMRW7GM20Qe0LwggRzY+kGKla/ZQcPKfXVY5mPJ8bwxh7z0yW8stT?=
 =?us-ascii?Q?NDKG2EK2vVdCMwRwkiPCLJLiR5GZfzz/UJ/VvnOfDOO+qYCUnzQoeehtdrVu?=
 =?us-ascii?Q?7D6XcGxNGM1IzfObE1MoNg+tLPjtvgG/HnRuwZn7uiuUVLmSGXiPEUgsnStG?=
 =?us-ascii?Q?5RPaubRVMpYzaW3RiFrsmMjlpTYLVNsynGF2Bc9yz9SXKNT6HbgG95ftTAp7?=
 =?us-ascii?Q?vd1+0FGrBHaUzeoieBazNohgO0C7iPJcLgWMWlNgQgU1UX83yeUDqLK2bZQK?=
 =?us-ascii?Q?Pz5xiF5tOG1A/C/a9Yjy6eLpMoh9lWkHeXsyXucXGXWVT2gNXdWX4G7iQEF9?=
 =?us-ascii?Q?wxxAyfErtLWDTkEwc6AqHBHRVO4b6i5WJEV9H9+nHl0LPGkyOfdxvDNCRtDz?=
 =?us-ascii?Q?spYFoZ2SyLkVsPEcy/2uKbpyzOzXAPCPAgb2aWvJQNZNiGvesXF00ILMeeA7?=
 =?us-ascii?Q?liu+5fT0u/UE99dgZVwox3oodFkrCOM8s4xFU5v5edhUvAmsX2u/ftO0+D/c?=
 =?us-ascii?Q?mzCUfa7uwBmuJvYgNaTYFa0IcyhvuBkCfhbBB03w14WY+qCKKanBHQ4Zqem4?=
 =?us-ascii?Q?6PIJbM8pFoH2L9hJOCuQSePKPDOehijYdmQ662Hvg8bEpNFyl7NXGcd4GLAq?=
 =?us-ascii?Q?Pupop1V5Gb/1NhhQkQZNWZtlOZUD7MVifsjYNttdWhMMyyta4bt7K6Uv4J9S?=
 =?us-ascii?Q?ORrIx+JhG85dRfJX3jOvDrQj7CrnlKqsqg/HYVTqGo93n6a0p9ZN13FVjffv?=
 =?us-ascii?Q?XIVjU7GJcPvZ3kBsny27f0RW8+OLx3sYGf+dZj9y/uygU8Z67Vl0gzeuiDek?=
 =?us-ascii?Q?PYyR2KiOClcA9XhTVYhYyj7wK3699S20eKJtDzMGIjelqy4snmOaiu+vxZOL?=
 =?us-ascii?Q?0A6+uAgRc5L1ptmsY8428Uatdp/VEMka5oJyu5gqb+NPngqeQrVaisTXjM01?=
 =?us-ascii?Q?j9AWoxqlXhta4esT4s9/xfHnJ4jIdOHI8HObo5qf4W0e47DBOTfUxzJ3W6hP?=
 =?us-ascii?Q?HjMUJ2sLNSLHqQpRD019VrryhoxhmDike+XinSb4eJPvo4HFlOzjiCnS0SpA?=
 =?us-ascii?Q?X/70NJGlm7ci2WyGlqPcfR7NSaAWBezfnTKrjHYevfftjt/OPYB3p97N55jU?=
 =?us-ascii?Q?/EAdPHSN8ChGl6iWdb3zLMlgByYsCTGBhTiBsQeC73xb7QOiahEDCQAZ/MDs?=
 =?us-ascii?Q?sWOUTx46yXEN+V5jbnUUqSHQ/aExgyP1mx8qhFbTXM/XHBEyXOjeo7UtN/JM?=
 =?us-ascii?Q?/rsDqbS1R/s8uuPQ20C+bZqkZQoO5e1/fCj+hCXKl5gh6x6Y73tHVYKUc3tT?=
 =?us-ascii?Q?GzJ50hKJUKAaleIvKhHKwusJik/o0OA2WAyb2ukPYjnXRHsvF7zKwqrZMVcj?=
 =?us-ascii?Q?QibL8cVJarFS9l/15iDlfhu6Zy7728BkwLaialF+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a05fe1dd-c767-4f67-3801-08dc21c35698
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:43:23.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7GAzN5sKj872Xmc+1oQFgXovW726FJDHvNPKggT5k7ntUt6CVgGSVm5BECj0dWuQyssD9mOyx31RPS4sIBOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Fabio M. De Francesco wrote:
> > Add cond_guard() to conditional guards.
> > 
> > cond_guard() is used for the _interruptible(), _killable(), and _try
> > versions of locks. It expects a block where the failure can be handled
> > (e.g., calling printk() and returning -EINTR in case of failure).
> > 
> > As the other guards, it avoids to open code the release of the lock
> > after a goto to an 'out' label.
> > 
> > This remains an RFC because Dan suggested a slightly different syntax:
> > 
> > 	if (cond_guard(...))
> > 		return -EINTR;
> > 
> > But the scoped_cond_guard() macro omits the if statement:
> > 
> >     	scoped_cond_guard (...) {
> >     	}
> > 
> > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > to handle the failure case:
> > 
> > 	cond_guard(...)
> > 		return -EINTR;
> 
> That's too subtle for me, because of the mistakes that can be made with
> brackets how about a syntax like:
> 
>  	cond_guard(..., return -EINTR, ...)
> 
> ...to make it clear what happens if the lock acquisition fails without
> having to remember there is a hidden incomplete "if ()" statement in
> that macro? More below...

I sympathize with the hidden "if" being confusing but there is already
precedent in the current *_guard macros.  So I'd like to know if Peter has
an opinion.

Ira

