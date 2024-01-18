Return-Path: <linux-kernel+bounces-30561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FC83208C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009481C235DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8DF2E852;
	Thu, 18 Jan 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHBAh22B"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2B2E63B;
	Thu, 18 Jan 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610540; cv=fail; b=vDSjwtl2aNvyf3SjJnhA7yhnL6lTpdN7f+m69+GIStaBD6QERASB2JccS3dS2u+I1bdAZz/RIOQhw1mtfP10f8K5e5dHoaxy44k+KM4/2ikByjAzy9JsRCO6tNAknMm5CAAtW51Q0wsj66Iq7Svjn7Gw2HLxKQGfEf87toMwZx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610540; c=relaxed/simple;
	bh=ia5e4UJfTcqezHzSaqvD08csE2/RlKlaqpIOyMIR7KM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+/C52r/FIG+xR6B+5wRqUSz0mrZKxiDj4LqLScQP7+z/zBoFkHcPs0iI1NM9wT+FwbDXuZbM9tzO1209UgfAS6S5HOqK7jHLBkGvwn/VmMbcfIcg3OXTQTCCqib1tauiqBL4Xs773T6Xs44LLaWBtHqCfYkkq/rzXQ805H7aTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHBAh22B; arc=fail smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705610535; x=1737146535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ia5e4UJfTcqezHzSaqvD08csE2/RlKlaqpIOyMIR7KM=;
  b=lHBAh22BTiNwePN7ogw8vS3Ezy+ANIYreogAS52SehyeepnEmAqC+4jq
   vpZpS3iFSfEyW3z4QP2Xjd3jFH3W1VQRiyXFOvSJIXUvHEudQxHaJieKF
   qjCYY6CCZ1AGQpap18S3nHOLnB+DWAwzCZo+2YqCM57aPIFEog8FDp+h1
   g6VoyF1OdBLxwGlq+Vc7Tn8ZAzVAOfPXkF7pndqRUCyvfNZRVCDLy9Eta
   +wi+o+fD/pXgNft8o9F5NzZzoIuPXUC11Gvk2ncKh1lqJriXQHrhTBU8P
   Muhl/hjBCLplLmD291BIJxc1b6YjY9jAfXGVghg4SHuwbRFmvs5sdwXmR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="466946551"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="466946551"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 12:42:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="875193206"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="875193206"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 12:42:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 12:42:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 12:42:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 12:42:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHNyMuq66KYtSL7Z2+NqKyNSJOtHXmeJzFXM9ICLYcGViaXgQ8Ees+rIJIRBB2uglC3JHC44rMKeWsmJxvA2oRFBZ1cuTHsgW6HM+mb2lU8zfoWq9bvYYpcZQPOjWjw183NQCsmhsI3lDlLOMBG9kT+osb/VDe0VkbUVruO6hPn0SCvYaTe/nM8cmxQmUGSOYVQsE+6GnINfxyR6ubWGJM/krk4w8qR/X34+1wW07VGUqJNGzg9SWayaeg6YtlCKpXqjZtIFUoIEioiGP00/3cWk839DSsx3AJ6hBdHVTQ6Aj5VgtuH0GNAQmtMWaAnnPwaBJzFiBKvDhbJn5qkd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6S5MRm4d1RhR3SFLrf/+FcvvBCC1L3zAO9p98dSS9E=;
 b=WfhRCTeTMwZCLrYjGopjDw7j0phsgB/k5bR1yZvSLfv5TnTanSSQQQGk0bBZsXfOHPBUN6ezc5NoA83R92all2iOL2Ue5rowj6v88ZV9LIIkkJxrDOmI03NZt47h98EcW331uXIwS9iYF4VTVE7nQwQs3XHBeyjoIvJ/PNlyLoumybdzU7rVGO/MT6+m/KqDsXhA8/gO/O1fCLT+1Vl15xzzWljeC1isXwhxhZj4Tx27RiRSCVs2VyCnUXZw8ujLVFw1XbQgBV5nbB8aWf0m1/U5N2UBsQKs1uQcI6fB5ese/P+3gD3QQudy9FusiGM/pwPWewvCHIXMmLAwSig7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6057.namprd11.prod.outlook.com (2603:10b6:208:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 20:42:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Thu, 18 Jan 2024
 20:42:06 +0000
Date: Thu, 18 Jan 2024 12:42:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dave Larsen
	<davelarsen58@gmail.com>, Fan Ni <fan.ni@samsung.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2] cxl/pci: Skip irq features if MSI/MSI-X are not
 supported
Message-ID: <65a98d1bc2dcc_2d43c29495@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240117-dont-fail-irq-v2-1-f33f26b0e365@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240117-dont-fail-irq-v2-1-f33f26b0e365@intel.com>
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: be7b2c04-1e2a-456b-2a64-08dc1865eef0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BmG3469yDIqXrRWDqaUOKUr25yQc5Pq93vqskvNxhsyrIoW8wkNWHx60Y95pnBxgBJKScw+PBtf1FM4pzczb6x2uMUmORjzkQspu0oxAf8Nchye6l90hPq5ur/hps3j+eug53t0tqq+RZvc46My6hArbWSmhVLghDgHg0Y5QqnUcj2n4Lv7qJ+74HmYrxs+3y7Wg+VFrhOyfp4dxSN21vY1jIpichInCeBW4RnmT4n6qJ55ymNMhD3T5c+PS9Idem2LAscntLoJONpDd3wASLVy4kkLig2sJonLANVbvPIzQeG+pxOCiOSxyQ+3Yau6H4Efqy0OUr7JrpFcyBKvjZu1KF87rn5o+2/0Tzww9kgHQsFDWnB+Cp8c8Ov6smm4CDla49DahFgOhH+YDt8frmsTnn/YKHwL3BLcbAXXQr278hZa7IOSh0ZOmLSmGCmCH6/wiFKRG8GoIf1boTmivfXbNOecmD40pwwKhUx/jCGCKJf1yCdNnsKZ22AcFWBScZMGGvCkeLZWUkjOLQUhYa3U1wBAUTDbGoCtNQackgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(6666004)(107886003)(9686003)(6512007)(26005)(38100700002)(83380400001)(82960400001)(86362001)(8936002)(41300700001)(4326008)(8676002)(6486002)(2906002)(966005)(5660300002)(478600001)(316002)(66476007)(66556008)(66946007)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sqt7h8Kp87rwWjPsu2+b13suGa4WzGJB18UGKuDVisTDlNwb1YqDScmivi9F?=
 =?us-ascii?Q?jUskmlQyCCSkUvyi8DeR3QsEL2hcStaRiRtdJ5mekSHnAQ/HmArolD6n+Dxo?=
 =?us-ascii?Q?e7SxcZNN1OZdH4PJG2u029I6sXZyxJ35m1rp7Z1bovCMq9mjx7cR0wqkngzG?=
 =?us-ascii?Q?Xtbc4be0nkP0AscA8mm2tZ+3FLyr8wzgxusAffiJDMfFJWQdGkVq+eOk34PP?=
 =?us-ascii?Q?fJUfwPo6FSEteBtAZ/xRvnYJc/EemWLZa/h3HTw1kq2ggvauA3dTwkbmnHW8?=
 =?us-ascii?Q?QVOiKkiKMwK8NU9CLwrQE6YWPjQzDeXwxUFLGlsz/UaqRbolu4MWCfsMAdLL?=
 =?us-ascii?Q?o56uwtq04AY/B8KdL9ZotzwaklFuTItkFJujv1aVXttcTWJe8y3flg2SlggQ?=
 =?us-ascii?Q?/GATAzsUmm9jO/gcsB/YNaon236M01L+cYX6GMhtzAt8U9wWSwRAhyf0Uvme?=
 =?us-ascii?Q?F6eUy0XUBoYDolgRPf+4cQ59ofaVNlJim+DRtRVBipjKV9Ry1srn8qgDRAVC?=
 =?us-ascii?Q?ydefcroyhQkfTCf0X2m/8B+mzSd1jWDD0Ky6L30STg4Y7webhbhA8xLLaQzQ?=
 =?us-ascii?Q?gndmNdEpqBnd46gU42lcEPCD405muCWwhf4ls71X1a4xjJXZwV0SvkDEedb4?=
 =?us-ascii?Q?pZFw5pIrdw8NeuIagVTXde2d5jPua83VQAUiUaW+SmtmSeQYZ3GodEsy+j2x?=
 =?us-ascii?Q?Jrc4pN+8gc0NpDAiLogV50aGP153oDzNz/ao0VWmvwDz6JaOPDWR3gmk5XsU?=
 =?us-ascii?Q?q0spQIt4z3bRhYD2QFwVsAsZnUVVp/sGKJFjtt6NBlqGSzeuCprmTOZVECKl?=
 =?us-ascii?Q?AKtm4u3QeMxoX4OtluvOTPGtvjaIhcGqI5HLFO9I9KosAagJrgX183avAHES?=
 =?us-ascii?Q?f0ajBeAq7kpFtT65a+RzDL8WBFme3xxlTEUTa/x9ERLrrRut7Dm2nZ/SnSmy?=
 =?us-ascii?Q?g2EkvGe2FATpZtTtOH9AMOhelBvV7Y7ot0mF4EhGHNLfy0SH4Fp2Rc1BfK4K?=
 =?us-ascii?Q?XCYHhS5Xf8WbgwYcNCS/GQAJpsUgrchQTZ1MSmqEpIsUYFSUs0GJuTZhuSLF?=
 =?us-ascii?Q?UTpHO4r+ace7sJNx5e6TP7KD3IOE3oZMtKn7DipQD8SYVWqrnF848S4etnGp?=
 =?us-ascii?Q?5EgQZvO6vjwZjnhmtZuFk6CdppeGhW0kYZeLg9tCvL3s1WnqtfwSDDXzU7rc?=
 =?us-ascii?Q?jxLSIFVr8q/gXt+Ky1tqbGYCxELy+GHRnCOwhZczvNAiDThwBVf8KJuGVjzv?=
 =?us-ascii?Q?jw/EcbZlECYqTnxt3RajbY+bQ23K9kWLJ2YtTAN1ewZIuiZUPNRNn3IDCxcl?=
 =?us-ascii?Q?AWzbFxLRTXz+QBOEpb8bfMSoDbCtq037iOcRq4KL7krhNT809/+rqsgQazMv?=
 =?us-ascii?Q?tYohl2CRikClCw7vSaLc9T7G8rdxnaOcJiY3GpWAqoMUVhffaXyPP6zVquvr?=
 =?us-ascii?Q?5KnoRMYc1e4iFsdxL99BXvO4jVJKnB05L3RClGw54mNf4Da5hs7VwcO56I75?=
 =?us-ascii?Q?pkautzJTRQE7w8Jq717hA09hvwCQxFubu1YaEyZnL+8xMRivhYvMbFCjjBLR?=
 =?us-ascii?Q?Zmk5xKl0SDloKAqc76sJfMC7vNZiUoHvuUprSdeAKapRpDo8Ru4ZipLTcehj?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be7b2c04-1e2a-456b-2a64-08dc1865eef0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 20:42:06.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2mHxxzgY+lPCum0YxbPl24VSprG3536bjjproJhVKt6ghBiAVr67XkhXDbOqvaSZSNNZGNcdjz3EWOG2WF9VMTJD/UiWP9if4AWnvY9Mio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6057
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> CXL 3.1 Section 3.1.1 states:
> 
> 	"A Function on a CXL device must not generate INTx messages if
> 	that Function participates in CXL.cache protocol or CXL.mem
> 	protocols."
> 
> The generic CXL memory driver only supports devices which use the
> CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
> vectors in anticipation of their need for mailbox interrupts or event
> processing.  However, the above requirement does not require a device to
> support interrupts, only that they use MSI/MSI-X.  For example, a device
> may disable mailbox interrupts and either be configured for firmware
> first or skip event processing and function.
> 
> Dave Larsen reported that the following Intel / Agilex card does not
> support interrupts on function 0.
> 
> 	CXL: Intel Corporation Device 0ddb (rev 01) (prog-if 10 [CXL Memory Device (CXL 2.x)])
> 
> Rather than fail device probe if interrupts are not supported; flag that
> irqs are not enabled and avoid features which require interrupts.
> Emit messages appropriate for the situation to aid in debugging should
> device behavior be unexpected due to a failure to allocate vectors.
> 
> Note that it is possible for a device to have host based event
> processing through polling.  However, the driver does not support
> polling and it is not anticipated to be generally required.  Leave that
> functionality to a future patch if such a device comes along.
> 
> Reported-by: Dave Larsen <davelarsen58@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v2:
> - [djbw: add reported by and info about the card.]
> - [djbw: skip error reporting in the mailbox case.]
> - [djbw: clean up event message]
> - [iweiny: pick up tags]
> - Link to v1: https://lore.kernel.org/r/20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com
> ---
>  drivers/cxl/pci.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Looks good, I consider this suitable as post -rc1 material. Will get it
queued once the merge window closes.

