Return-Path: <linux-kernel+bounces-22514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6D829EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686DC283E24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240B64CE0D;
	Wed, 10 Jan 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSNVrsRF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E54D100;
	Wed, 10 Jan 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704906853; x=1736442853;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nG7QxOkytXq+x6VgL6rrTcsFf/yLV1vA+1rlh0IsTm8=;
  b=HSNVrsRFv/Ff60rT2tMtEe83bDP34E6lntqqR9nEAxYyQuQKspCFmZ57
   1wN0F5h1eq1gPQ7KBDpAulu2tguCyP4OylGXDrrKQ1f65yG7n74W9xJMi
   P7xBEqdchCGKylbdxh3PouzchtNXrAHfT8vRIo9R6Ob4fpNGppodiIS7J
   kQ6k5NRFAVzVyO0vfxpPzwiFNGNEbzI0iuJTOWav+zpw6Wc5lLaXm6pMG
   aFiSnCN035g/LBvtep2AbY3ZdAA1IOY/GvCKeYh2qv2RM7oqzuAx9gFvD
   lSlc4qWw9k39Tne4N3lmoazOiTHNNOfgv9jgQsy3tZpIR9pAchFI2PKsq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="17177373"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="17177373"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="731905901"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="731905901"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 09:14:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 09:14:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 09:14:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 09:14:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRYTZ4SewJzja7074W8uoxIQ/s9drcPStxLvnl24AFL5KhYgBi5lS6KAcXtYE3ZPHf49S9PLHP4EEW8DguVxizbLqET+EbEOV4UuvWMl0MliGJm5iOVuqB9UGFOn9LD4MkRsvYFK0R9Qagj/9+y2y2/jl9meNGn3bSkUvamYqZU49EKT2PaPC0UlAMXAysE1FNziqPXEG6ZulXlBKIbjR0LVNQs1AsdAPUHEuUZ7bXk4uAbYJ7q6detRSgw4BO9tuYUR3VneyB+KNLjVNFXTwAO/UOx+QrkKA6knVMd7vOv6fAUaxfS5Wugs7nvpPuwCjbjjTi2+WA4EITvlR5j+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRTEFf8qPh5xIUb+kicpSNsgYMMkQZsNSQVnZYAagX0=;
 b=NPo7DqIMmgkzpleVpLHmgDsWlNrXMQuydJdShqBthiDbdaGKY++5KfY+qSY0LUwJGPwp4t1Fpfhmr+8l33N429jD+QPOD0rOSm9q1+MgUMJdd2+LkN3nzbUQmzuY6HHVaB07moJAV3r4nuUk/y1F4uEZoiVE86MgTqGx16Zb5kEn9nzI3DLCUMxbRsMFXChOkQgV3O0TLtAxtzHS+7zRziIzJaPOg2BgJQZXMoKCl+H1A5MfzQ9cWDU9uzutWuulsFjPsgJ+hxMFHb4H5jdHCKd6KyivtsLYK3tncx6VGuuL0YTcy7JBjUHsIWf2u1dYJ++BPDABbu8RVhSpx1t66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 17:14:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 17:14:02 +0000
Date: Wed, 10 Jan 2024 09:13:59 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH RFC] cxl/pci: Skip irq features if irq's are not supported
Message-ID: <659ed057283db_aeafc2947c@iweiny-mobl.notmuch>
References: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
 <659de32baa491_5cee2948f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <659de32baa491_5cee2948f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: d9691b97-b43d-46f5-d70b-08dc11ff8b00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6xTcM8lMr+K4mhVXRJUDFNFDmIDpz6+daTaMIwnyrTXS1aOF3wAyjUBusQwVBlrK0Km0p2d48lSaokApjWOZ5po7wn/6ZCbKgeUDE2LkZ2Ts3gI263AAlmHOcYbnzxjQ2YhIFqC3aSS+RwsvFbFEPwN7SUAFswK65/JzVk/8/hGu6BQh6zezBUMVc25TXhhH0hMxBrhcIygbvUqJuhcc6F8PMyatgi4RKNfAVZTtkq5YW+Q2L3tARL0ABx4azJs7rndT8kDQVSw5el3AInFJ/rZ0IVPa119u0OZwXXbCiuIgBfrMp7Hd7HR8Ts5NgcoL7+HKnkivS15D/PaZjyv0FxbZ2tuiTjVtOoGvRbQy/qNLJrDOQ5rNy2azNdfUu9XEYROGie3c25CnOXL2GCIQSSdNVk+otrUfnzgWNrKYnQ0zb6pYSRtEi9jCQCTQR8AZ1LHVcPOmYd2dKrDM3ZGRCljd4+4R0eav5V3Ug+P/U3JVMcS1W2374IjWIY1euyPY7LRHvfuIHryqNP8ZLZqU5zTIuGAUyNM14vVSqxfvlWIKF1rWFsf9zh6440/aRl0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(107886003)(38100700002)(8936002)(5660300002)(44832011)(4326008)(2906002)(8676002)(6666004)(66946007)(478600001)(9686003)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(6636002)(110136005)(41300700001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qY5JNTVTWnLzpQHsBmq0/x03uxtIuQZKSouI9ZwAOmVBgLYad/h882igkl4O?=
 =?us-ascii?Q?8lexFQqUMWWJHNxGYpht7KOiHYUzfzz7GbLPcUuTC0Qj/bNVaf5vpUdEy+Mi?=
 =?us-ascii?Q?sESCOpaDE8RFLMbb7e4VDokN5gsmknhAZnYDqLZPKX4UvykY90/ErBV/hu/9?=
 =?us-ascii?Q?P8hh+OgfWFTZPYaHTErr+NE8oLwTV8IDgaOsz1715ic+Bxat3edS++Ngz8B1?=
 =?us-ascii?Q?+V+2mEWyRJ0NxIiiYIjWFAd1MD3Y8NlkF6vOHxUQ0CIx79HS2SK8Vv4rGMDq?=
 =?us-ascii?Q?VOz69C9KGXXbhMg4gaItk2XDax87L7mUjUhac+63klkI/Wb5DqoXhakwIYlY?=
 =?us-ascii?Q?BN4joMQvRNOeT8MGgXiAqVIyFGWOgx3Y1ZfJvWDYASk7X42mi9IMh05XQmdN?=
 =?us-ascii?Q?KNHnfxMJSJhI7UP2dpkdglGG1YVTlzHs4p7u7Rz+tSrRzhqMuY4q4BqZvAgl?=
 =?us-ascii?Q?kC3a+ywNeji2jFZbM4vz9O3IJk7mTmVt4BYTp1+grc7D5+BXMU/GYlCQebFC?=
 =?us-ascii?Q?7wFujjLmY7P+kD4gHWjN5f8I8E8m1iiGGiz/nT22zoK2KtUI/EMFv6VTgW6y?=
 =?us-ascii?Q?wliq9d+TipKIDQLHvWvv5TM4ABFr1VNAmb8ZR/jtG8cCBhLW7cJyZGVO9yqe?=
 =?us-ascii?Q?9JMpXMkyBCp9eeqMqirm3GR0oxcyxCcai9M1q20l3Qb7L1kqHIx2IbEMpaF+?=
 =?us-ascii?Q?RbCIvN6mh17NalBW6YudsOBs2Z1+uCdt5iSbBZOeJdNmmhCoeMswLCtuQk+R?=
 =?us-ascii?Q?yRbQLq38//AzlR0yc5XRPpa7weZVTio20U5s5TF+SKSrgd9aonKnV8y77Uwn?=
 =?us-ascii?Q?Lleq0hwNUC5/aIpX6fkAMQaqXq1usvR69hIXqnhAN1ktSe8FMt8iPNyWNF6O?=
 =?us-ascii?Q?kr1dKcpoCqE3YHjo1IF3N9mb+z/XurH7tlXVMQL8O3zMEuOODW4OTuLc6RUp?=
 =?us-ascii?Q?tOT+cXR5UEIzxbOwS8Vkpry2zCv39UTcHEhr7OWIAfFphhSmieYWeHDmbnbK?=
 =?us-ascii?Q?KnvNKChL9s1bXlAPFyjngRZxN0dhM0xS+V61uhWwn0A0AGNdwMYKT99tWpx+?=
 =?us-ascii?Q?WG+L9P0JEycUCmuCLIbTiVmTj+kBDp/mXCQmryMHrXcyn6SDrPr8FhVlIBHd?=
 =?us-ascii?Q?3NUDJb9UWczpTyRJG3itK2hUc0qhn6pkpA/jQfw6H1zx9qZ25ZZ1ABGfUsYR?=
 =?us-ascii?Q?MeyIF0ZOSCPnzwWsXP1lHNld89/kawhEfH9B8A8yL0CDkwCGr/nJQNRCwWp/?=
 =?us-ascii?Q?ddEKZLbuj1VnQQ12+p3LWfXvx1PfZC8PgvmRaaOhp2RgMCaIcYBtgCC/Qx4D?=
 =?us-ascii?Q?C0NdOmBXwqV5MqyKLQC5EP7ZM4sy8cSRUjiFU74sUqTIVHm8VDk9wPseGuyS?=
 =?us-ascii?Q?3xsRvzRM1tjf5t1kl+VFVzNnHadvudfaxFTz2oWxAOjrOh5LqiqnBVVx0anp?=
 =?us-ascii?Q?zoisFLOkBnB1gEf/8wohqf+cgpMjQMAkDtXYQfm6F1ToAMg+WE5GOrMPU2yA?=
 =?us-ascii?Q?crpMqzmZY2kYLPOBNVT3+nHzLVmi8wCdcyNzu9/7xyA3brhBGrYBD32rQ/hI?=
 =?us-ascii?Q?t4MOnTuBJc1uJCM5GXGXX0EPn4agz9FQ2EmmBa2z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9691b97-b43d-46f5-d70b-08dc11ff8b00
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 17:14:02.8555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtYZxghrs8fzY8TThSXw1tLCdVVhqXWpP3H6oUIzb7ltMYPXMUNJSof35NGMDXiYGRg5oyu2cqT7IaobQZGsZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index a2fcbca253f3..422bc9657e5c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -410,6 +410,7 @@ enum cxl_devtype {
> >   * @ram_res: Active Volatile memory capacity configuration
> >   * @serial: PCIe Device Serial Number
> >   * @type: Generic Memory Class device or Vendor Specific Memory device
> > + * @irq_supported: Flag if irqs are supported by the device
> >   */
> >  struct cxl_dev_state {
> >  	struct device *dev;
> > @@ -424,6 +425,7 @@ struct cxl_dev_state {
> >  	struct resource ram_res;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> > +	bool irq_supported;
> 
> I would rather not carry this init-time-only relevant flag in perpetuity
> in the state structure.

Fair enough.

> Let cxl_pci_probe() see the result from
> cxl_alloc_irq_vectors() and then optionally skip calling setup for
> features the demand interrupt support.

yea better the bool is a local variable to cxl_pci_probe().

> 
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 0155fb66b580..bb90ac011290 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -443,6 +443,12 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> >  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
> >  		return 0;
> >  
> > +	if (!cxlds->irq_supported) {
> > +		dev_err(cxlds->dev, "Mailbox interrupts enabled but device indicates no interrupt vectors supported.\n");
> > +		dev_err(cxlds->dev, "Skip mailbox iterrupt configuration.\n");
> > +		return 0;
> > +	}
> 
> I see no need to do a emit a log message here as the code is happy to
> support a mailbox in polled mode.

True.  However this indicates an error with the device IMO.  The device
did not support MSI/MSI-X but yet indicates irq support for mailboxes.
That is not a well behaved device even it it will work.  We are not
failing the probe here but I think the error gives users good insight.

We could just make it dev_dbg() though.

> I.e. this is not an error that the
> user should call their device-vendor about because end user will see no
> loss of functionality.

But it is not exactly a nice device IMO.

> 
> The code right after this is already fully tolerant of IRQ setup errors:

Agreed which is why only the error was printed and the irq setup calls
skipped for good measure.

If you feel strongly about it I can just drop the hunk but I still think
it is worth some message for those devices behaving this way.

> 
>         irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>         if (irq < 0)
>                 return 0;
> 
>         if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
>                 return 0;
> 
> 

[snip]

> >  
> >  static irqreturn_t cxl_event_thread(int irq, void *id)
> > @@ -754,6 +762,13 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (!host_bridge->native_cxl_error)
> >  		return 0;
> >  
> > +	/* Polling not supported */
> > +	if (!mds->cxlds.irq_supported) {
> > +		dev_err(mds->cxlds.dev, "Host events enabled but device indicates no interrupt vectors supported.\n");
> > +		dev_err(mds->cxlds.dev, "Event polling is not supported, skip event processing.\n");
> > +		return 0;
> > +	}
> 
> This one can be a dev_info(), since there is no polling fallback and it
> is unlikely that a device supports events without supporting interrupts.

Sounds good.

> 
> ...or maybe unify all these notifications in the result from
> cxl_alloc_irq_vectors():
> 
>     rc = cxl_alloc_irq_vectors();
>     if (rc) {
>         dev_dbg(dev, "No interrupt support, interrupt-dependent features disabled.\n");
>         interrupts_supported = false;
>     }
> 
> Where dev_dbg() instead of dev_info() because the people that are
> missing features will report this debug log and upstream can say...
> "yup, there's your problem". Where users with cards that are known to
> not support interrupts do not otherwise spam the logs with info they
> know already.
> 
> I also note that cxl_request_irq() will do the right thing, so likely
> don't even need that interrupts_supported flag.

Perhaps, but devices which don't support interrupts by design (and don't
attempt to have any irq features) should be silent IMO.  Why spam the log
with that information even if only during a debug session.

For example if a user has 2 devices, 1 broken from vendor X and 1 which
just does not do irqs from vendor Y, the above would be printed for both
devices when they are trying to debug the broken device.  Then they have
to rely on both vendors to report back.

In the case of reporting an actual error they can call vendor X and leave
vendor Y alone.

I know it is more code and you wanted the smallest possible change but I
think this is worth some code.

I'll rework this a bit and send a V1 for real review.

Ira

