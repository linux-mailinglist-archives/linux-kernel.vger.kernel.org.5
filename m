Return-Path: <linux-kernel+bounces-21564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31B829133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CEB288BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A4394;
	Wed, 10 Jan 2024 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPSVjzeZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185A383;
	Wed, 10 Jan 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704846133; x=1736382133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GNlhTF4CTPDRgo2RYr7tCwsSaCKZn0UP8FqBKQjn3pU=;
  b=NPSVjzeZLIXSmYqxcGWJ6hpmJbZr2fqmYZT57f5E2PDkZWKwrOMvYS3o
   0w0AY11i2zxICXTxLQnT5xzllGHUIcQeA+fI4M5UPVwgg88HsQjR5EXeW
   vn4pO6Zf2J+MbyZAN7O11za38HGJJQ8rDXb0wSYsb7xX3wgiXscrtPvYn
   4kGP2gH/RCP8P4b0/ePHqMyeGjOfQX3FZ28YqLE94+Y5yIKNOQLWG6Y2z
   y5lRCplD2bXEI7AwkeKuRdbBceOlF/VbMBqy5yOz7kUYNPmKdyuxBcXi8
   JKcSnV2oZwUnS+R6q/VEM+rzpRuzxtwL8GZljJx4vAapbZEv5OhI63Lj+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5722372"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5722372"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:22:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="775036776"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="775036776"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 16:22:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:22:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 16:22:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 16:22:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 16:22:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp5bv30/KXi0frx+Tb8eReMIdvW50Aqksm4viJX4IkODwu0oUl0jEMcPMV/m9oK0oP3yD+kB6YGLd7mstO0dzWeO0CxXRMG3M4qbJKJZPIWTtpNoKmejJOEmKg6JQUnj4zUhihygCHFSrwF1D7p7TjrzMAKbtBG39P8DD2qzwohwkiSn4lM63+IF4WcEoKCXBiQJ1rwsNPfFv3nkvbb/SmIUB497hlCMuGsD1AL2YFpGctONWQg52Qu0IvivNgFsz8+iO7SFW7t0BjbUMogN3A53ABWtgcI15FGj8njHyfcuI8Xrab1Jnv+JFAURkMuUf3vP1157b0Rr3bebGzY4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aos4QvxAluE36KqTbL/ZpHx1k61lVqaFhafJ477uZRQ=;
 b=X4Wyyw4jSgwUTvALkLrOXO8+c8F0R05qGX9u47oc7O+xKOqF9lwN3GSSuD8g6Ut5G5g08IHFadr3iQrYJ1jbcoxJJhQ/A0Ak8gw8y/X2wVoOUtsXlNGx7a5sPspI3aZT5/0+kQxM0WpZZ+MIcXXzIebS9zyq8V5KxI/MH/VoaZF6YX4esjGg8F882cPyNlnvMmQq4Oe8QaxkVPO+JkMsbbkx3cULm4vP5P0mKBVQmBfmrDS3xtM3dDKqfyc1oQPSlaS1szVsFRK/VlT3B8iqjYQNH3/kBHef8xpEtkVig1uieO/4dayDZU3lif6X7ShShJ4kqKfa8ylJPLUyP4s4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 00:22:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 00:22:06 +0000
Date: Tue, 9 Jan 2024 16:22:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH RFC] cxl/pci: Skip irq features if irq's are not supported
Message-ID: <659de32baa491_5cee2948f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 067780b3-c754-4f69-1307-08dc11722d3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FClRXCduNgTHNeyb5U9bVGSkj4XiMpJ/s9hJoQuyzHmfX8Bo5MYaON3brVLBjHP0xWSNW5u5cLIaLJHIHcR6zhEpolSu8cL57PVKMBNz06X5BHRuzh8J989JjCr4qXxn+LiahGaH8PIIpK2uKMriR6uzRWigqlUfd7MF/TD2LE/+qRCcyqMxyn3lTlmXQw+qGEg5Vo4DMrpwxMUwFDKbdbqQEYo7GdBJmFKX2K0tMrSr7zUaZVivOrUOO7PwUkteNmFAVu6vPoMO01kaO0/vyioQw0duv+lCjdLMa/JWLI8SzywGFjgtm8ZsdhaiHPtmddu4pYDWJ4i7RpWlnOwa9U+xpblXpo3B7LiG5uYR5cbYaCSeBrtFG3wD3pmadjoW+b1j8nZ7H836nJnBauaodofL/5CstGkKnFj/B61i3nGXEjHELZxg/ESNGMn/5Pwz8+zFNarTQYwa9uxta4qaao+C8Hp1VEg7YofWDijBWv2y/mLiokB4byvPiQ/lvKVKwriLsq4Y+7Zk9Jp6MlrKORexqiMQjyL3SEIsM6Fd7sy14/ku4OVlKOuow4sl0qQ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(66556008)(66476007)(2906002)(5660300002)(8936002)(316002)(6666004)(4326008)(41300700001)(110136005)(8676002)(478600001)(82960400001)(107886003)(38100700002)(86362001)(6506007)(26005)(9686003)(6512007)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/FNZIb10DZ95zAUHFYrKX0Q6ULCVChvvDfSR92MuS2HEXL5Otu7AaNezNBI?=
 =?us-ascii?Q?13QJNUloAlOa1ERAAI7b8vWNdH/g6NNuCqyIU/CjKcfPbDTUYeBWWxhrHExJ?=
 =?us-ascii?Q?s9Fg4mUa18meR8KUfkvJA4kT3wEJrP8SQ37GecNQbwh8zr1vDmClSrpiYrDB?=
 =?us-ascii?Q?ocMHlzpKonvbYa+G+q7ajv5u53FVUkIOFyRNwGFg8UEEo3goQbZvHj7PdV4W?=
 =?us-ascii?Q?f/qa2K4mDxCHdYE+ZVYqAsR874mCYS+YCvg+JzOVZfBmJhyl9vcO3OAqHrbK?=
 =?us-ascii?Q?ny1HT80DxI5oXBavjPccsmYsxthgjxIn853n0vHv3q0httV//zuH/3/jmcNn?=
 =?us-ascii?Q?MV0VUg+tGR7jSZzTmyNmY3sN6JwKPaWBitGVYl2Y7zbuB7ReKY2tfEwOWDgD?=
 =?us-ascii?Q?agaqktVuRwwCcfT7EiqzqoGwChc+33J3uWyJ9zwfZAbJPPXv/T5OvsNhNQlg?=
 =?us-ascii?Q?X/YZHw17lXTYY0PrrbV0qD6gUO5KmFygMFib06UQ2WfrJq6Cw4gR7CyXFIoJ?=
 =?us-ascii?Q?psDLvzqyonglwpY8mH4LLFETNYDTIbWoTJE3HgecsOwLQ60JXe3cwi0GQobx?=
 =?us-ascii?Q?79BJ4uLvfGL0zM5brRptXPdsuGfCqaznrwX+wpbOnucT8asvKEpsjCs++JdF?=
 =?us-ascii?Q?G0v5uujINOMVuW1Fm/JgLZWDF9HlDww3moOHiWWDfa+xokstw5y6WSmIkC3t?=
 =?us-ascii?Q?ivCK6z++x6hA4hQgXMmSkwtO7CAXKLdF5jz9aSzxrwKXjZzMWuZ7r7sRJAYB?=
 =?us-ascii?Q?wNrelu8Ef9uZhCQiT7femAdrLhCSKgsj7OLhvcbTR8GVc0IDzK5n+R2RS1Ct?=
 =?us-ascii?Q?JoO9fSREcPaSOlFrTk1VlgW2H81fSs+esSr/oYyuDL8X+XTUSHW2xRhfn8xJ?=
 =?us-ascii?Q?uiKA4S7NT0Yqlm0dT0srptYAREWb3/2+htRbYzNAUsnDb0OPiDbi1IyR+l5L?=
 =?us-ascii?Q?2g3MCF7wgnFMoyTmN/xVmC+4GBZgBPPWDbT3msrzJOBOwUfkCa0OwHYX8jFU?=
 =?us-ascii?Q?Y8Jq4O9UGd0lmSChvj6Eze5dJ4K/n+USw5YFuzhZ/VNNQh7DZLVB1ViTlQCs?=
 =?us-ascii?Q?+tch+dcctVG3CSdDZ16hlJQweujqIvmWclWV4JlhbaFGZEFNtRT5MU4J63wU?=
 =?us-ascii?Q?lvvSzMbfn76HC4/zfgs/0T7R6MW83zM0mDpyVZJezw0MTicZHvpUvSNWW338?=
 =?us-ascii?Q?H3oC86CU2wptQ4OIrB+y3jiRqshoTyFA/gY3W9rrybe1D7h2AgMSI4zd1rpx?=
 =?us-ascii?Q?FlM/nFNeq7JsPQHoKYq7HFkNF70tw6YQCkb39YlxACyiY4KB4KcLleTYgjhv?=
 =?us-ascii?Q?sTsgWrbS1NY5P4tl+7wI2fUraZPIOuRjJVDn5e80NMn8Njr2YBL0nvDuPDBY?=
 =?us-ascii?Q?IxIRtd2sTxnIUclZQ+77EA5yKBFj56csol+WzjsCVe+VutqIy+6jbmB2T/Xn?=
 =?us-ascii?Q?dqjKNJvn/nX1PGwFQeWdmyQVKToC4x/xwTF7/p5eQT6tl+fLjTFVRbuJbtFj?=
 =?us-ascii?Q?bEBEAPuxBjcfpKi1g8x+sYO/sCmRnnrh1EojYp0a6xYNlhndz2hyGSsOFAbT?=
 =?us-ascii?Q?+OrB7Y5YGVWbn3TVzCSj0uQNLUNPyf2Rwvcw9beLTApCTRPG9sybrW1HW+A8?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067780b3-c754-4f69-1307-08dc11722d3d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 00:22:06.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/BR+iDHNc2pY35YPuk6b2nUXQom/u1eeXFhYPSsYVhnmj2uzDcqJot+vVi/bgd2rhSdM4QD8e1hXj7EllElTJSBPbsS1LP92nY+3Isp5tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
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
> support interrupts at all.  A device may not use mailbox interrupts and
> may be configured for firmware first event processing.
> 
> Rather than fail device probe if interrupts are not supported; flag such
> that irqs are not supported and do not enable features which require
> interrupts.  dev_warn() in those cases which require interrupts but they
> were not supported.
> 
> It is possible for a device to have host based event processing through
> polling but this patch does not support the addition of such polling.
> Leave that to the future if such a device comes along.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Compile tested only.
> 
> This is an RFC based on errors seen by Dave Larson and reported on
> discord.  Dan requested that the driver not fail if irqs are not
> required.
> ---
>  drivers/cxl/cxlmem.h |  2 ++
>  drivers/cxl/pci.c    | 25 +++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2fcbca253f3..422bc9657e5c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -410,6 +410,7 @@ enum cxl_devtype {
>   * @ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @irq_supported: Flag if irqs are supported by the device
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -424,6 +425,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	bool irq_supported;

I would rather not carry this init-time-only relevant flag in perpetuity
in the state structure. Let cxl_pci_probe() see the result from
cxl_alloc_irq_vectors() and then optionally skip calling setup for
features the demand interrupt support.

>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..bb90ac011290 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -443,6 +443,12 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
>  		return 0;
>  
> +	if (!cxlds->irq_supported) {
> +		dev_err(cxlds->dev, "Mailbox interrupts enabled but device indicates no interrupt vectors supported.\n");
> +		dev_err(cxlds->dev, "Skip mailbox iterrupt configuration.\n");
> +		return 0;
> +	}

I see no need to do a emit a log message here as the code is happy to
support a mailbox in polled mode. I.e. this is not an error that the
user should call their device-vendor about because end user will see no
loss of functionality.

The code right after this is already fully tolerant of IRQ setup errors:

        irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
        if (irq < 0)
                return 0;

        if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
                return 0;


> +
>  	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>  	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>  	if (irq < 0)
> @@ -587,7 +593,8 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>  }
>  
> -static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +static void cxl_alloc_irq_vectors(struct pci_dev *pdev,
> +				  struct cxl_dev_state *cxlds)
>  {
>  	int nvecs;
>  
> @@ -604,9 +611,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> -		return -ENXIO;
> +		return;
>  	}
> -	return 0;
> +
> +	cxlds->irq_supported = true;
>  }
>  
>  static irqreturn_t cxl_event_thread(int irq, void *id)
> @@ -754,6 +762,13 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (!host_bridge->native_cxl_error)
>  		return 0;
>  
> +	/* Polling not supported */
> +	if (!mds->cxlds.irq_supported) {
> +		dev_err(mds->cxlds.dev, "Host events enabled but device indicates no interrupt vectors supported.\n");
> +		dev_err(mds->cxlds.dev, "Event polling is not supported, skip event processing.\n");
> +		return 0;
> +	}

This one can be a dev_info(), since there is no polling fallback and it
is unlikely that a device supports events without supporting interrupts.

..or maybe unify all these notifications in the result from
cxl_alloc_irq_vectors():

    rc = cxl_alloc_irq_vectors();
    if (rc) {
        dev_dbg(dev, "No interrupt support, interrupt-dependent features disabled.\n");
        interrupts_supported = false;
    }

Where dev_dbg() instead of dev_info() because the people that are
missing features will report this debug log and upstream can say...
"yup, there's your problem". Where users with cards that are known to
not support interrupts do not otherwise spam the logs with info they
know already.

I also note that cxl_request_irq() will do the right thing, so likely
don't even need that interrupts_supported flag.

