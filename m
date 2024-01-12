Return-Path: <linux-kernel+bounces-25093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655E382C7E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BEF1C21B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBAD18E34;
	Fri, 12 Jan 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnq+P+N9"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DE715E94;
	Fri, 12 Jan 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705101422; x=1736637422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=obnaWFn3lTodJ54g18Z8F/5Kp+oCU9DiwTasrEbgFyY=;
  b=Pnq+P+N9AZILkNkV3H+z63ZIn9iTuOqj1hhvVislGoLoy+uLUNP92ICl
   WebjQaxTV0JuwmUZu2izZLHaRQBkDS6zkxMtocQTAKTcH+GfFV8wRIPGb
   FJyduPSiqxGHBS218ekysAAXVLnTsaEwsw6PtDAEQVg561AiF376u61X7
   OaIXyygcuYZu9/0PeeJuGsPTnC7HRqDe4GUXtgcJG+66/gky/Q/gF/1eR
   +VkwZNPxbvAyjpGzwpJ7kquY8UTgGxXTSXi+xlHQUc0Y0HTrvh9j7/cuk
   +iPoselAPGqOOshvR1Q/v3ognl8HpUhGi6YlypSaPjwFFqwSQcQ1j0LrM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389757455"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="389757455"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 15:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="906450982"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="906450982"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 15:16:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 15:16:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 15:16:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 15:16:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YADsTNjZ5BuQoacApK5uyeO3TeymfFJLnoRQ33rg/ZWmRTgAdpk/+D5RSLq4KyFX4J6YIT65VpYEMYi7PpZiH43f3wA/gCQ/K0od4YzBqUIprYoDRJvaMoAbhq+8H85BubG9bcKTCxzoepgYQVU1449avlX6s7xX+czsoA4zqBcn1Xt/m5mXQjlnAIpBMGj8u3+emm1FSYoWH45Z1XwPPsEHlJV6nf3ThjT/T5Q6vsj5US23M4XImimy2eJ4kJoZ3O+74awV2ejMQWRpXB3MG8wIEt3pt8x39HVVwdBRvO3UkMoqOEsMKl7dRyQj8h0HQODsOfujnNTDgoHUQn2qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jW9OXlkUVKWHbf8wjF4bdmnmWuz0SlmzBxzcnf4WBg=;
 b=hdoWObclZZXhrGDSz/b8AmLCy3UQ+6uryPz8CqJEColqffG5euMdf85sGQZhnEeKVD+nn2V4bLuguQd18kKqpVisTaRzcTqe9IBeTR5MxU8HirHPoxu1qj1/LqbntHAYxjuXWDGTeHkW9VEwPksAMS7PIwbie9cwmAMrMpyRF9dIUAvC0ZJvkdMCykN4K3N/ab92eLgahJC6vJklKWb+TuGpRWbapqmzKKxKhsjzOpKZkFU+Dhp9jHpku8+5mCPWTTJas+w7yC2xufFCPodlnDPH97UVfzV9ad7xI4j4/3D+3ZQ76wLOq7+8Nql8/3goPmecUC5q7yrYSChfT+mrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 23:16:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 23:16:48 +0000
Date: Fri, 12 Jan 2024 15:16:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/pci: Skip irq features if MSI/MSI-X are not supported
Message-ID: <65a1c85d95649_37ad2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c26f7b3-e2e2-46d6-e68b-08dc13c48ce7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1k20M+Om8zZR+hxKhDxDlnexS2OwSG0oQpExiPS7aFBxAQfwdpx/GQpaAoFAooxkCd7Fw5dZ27ui6fyJmiQS3gUAkmfg5cXgQQADNI5Qu8sgSfRwGTwCEpn+aVErGUf+7jazM5uhDcUyX72gRPPf5oEYOchRpmXPAt2K+l7oiy8kDQnajOwr+fHTLH1Cet05arU86rgpZp/Psp9AzMbD/qgi8xWxEnm7n93rowI+6rs/yIR3UggjBww3lIR71gaMXHWYkW5Nu4DixwoJkXmA7QnTpIORccBp/9c6wLqxIEvuR4Dhaq/nz/2pE9a6ugzTTsufD+PLiZSzi5AUY4UL3Vwkoxyfa1xSUWcTe6fJm8rAk1or0jnTS9Y3dbpMznqKBQqOIgTh0DCwPM7y+ZL2XL4g1yFBbDcPDTMqwThxvF5RkLucQ4mHoxMDJAfQJxYkWobAUA5qPoAB++A+wa3oXd6F7YkfrodO7uoLIlE2/PGNyhDpC/BGCCRQpmy+FL+vwcUHA66k/XUwph4rdUYcrWPQbqwfplFo4fUaLX4dpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(83380400001)(26005)(9686003)(6506007)(6512007)(107886003)(86362001)(38100700002)(82960400001)(6666004)(4326008)(5660300002)(66476007)(110136005)(8936002)(316002)(8676002)(478600001)(66946007)(66556008)(2906002)(41300700001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V0fENChNb9wVaKxz5ezYKIyur8J2k1avj/1gVE/YhgP1i4eJ6/IQ6f1Pj6KX?=
 =?us-ascii?Q?1YGjawDOcBOUKPWlXpmQZtpmT8K+EwfbBRwGDPsq8H/7b1EXaTbTRHP1qNKI?=
 =?us-ascii?Q?6Rn4ZeFYVHPaCNlkTVVb91ClTcRaDEE1f2YNMKERmQ9ZzePUAzaHIO59BxUB?=
 =?us-ascii?Q?EKlFGOYv+DP6e6H7ajA81YYHqVJz6GVil8hA+TpkmnbQ6pyPgUyolRU+2Gwa?=
 =?us-ascii?Q?BvZOFurmq6NETvKldV7I5JHsFHt9PX8Y1yopACAo6Kcpl/NGXy+CF3ItjJuM?=
 =?us-ascii?Q?RQQuFyPncecjD4Zs7uTYjOhIWQOLBFRb+IfJkvASrYita18x5yUURVz6QYvc?=
 =?us-ascii?Q?LCB0yBqR6lR4OByAyDS2sOUyYvVvkmvIRim5xxjk+ViosyR2IZurCnpYUQWp?=
 =?us-ascii?Q?2omz3/skXouqW6b4m39ax5SqfOqOhS3TQ75IfyuzzqTpd6jcSwTUSm58onAG?=
 =?us-ascii?Q?MDecBRKrA+DnBAhNuQ6R/7ePnXkzxGNL4wmLwiWo8qVZu46iCrolPVotui80?=
 =?us-ascii?Q?QrOptbZNB9o44khRCwiVJWa0lU1jphbj0cQ22O1a4zJYptEm4OY891z4ErTD?=
 =?us-ascii?Q?QYmTIUJFgLnk/1lxr7Sjp2I7k04jEn4KSy88FipiJHl4LHxDnu4m42Y8dPFw?=
 =?us-ascii?Q?Hq9KFGWG+OYat74XT2YygFvuyuaf415CyDijiPycs/2TSDFilmE27U//oJqY?=
 =?us-ascii?Q?ykNJmYkwxyBNhLkdNHWJYMBMPKtSKQihECTStVaBmngtZruzoRCLtc5MiFPK?=
 =?us-ascii?Q?K72WOyAbRy+rhw8r6Eb2fV4vn7XPkFlAA9Tw+lTRtV6vovoN/YaoUP/jCt1e?=
 =?us-ascii?Q?T5L00FbmDmDrlT84jABQXEtR1PLoFe+e47vv4BLA9sGxgGivHb7X3qdVJxUN?=
 =?us-ascii?Q?DpC14o7eG+hkZ2Rg792gTSxQjpKYCb2g3/hvlJ+EFfkDsNFc1/QTu1ZDnLp1?=
 =?us-ascii?Q?/Xu5Z0EpzjVjgEdFbfloreIFVkOiaN+o2anUOGuxp85vTXY4ddxurMI4gATB?=
 =?us-ascii?Q?jcu/RvSFTX9CHcU7e5kAppbxLRzaSWSQGlGYBrE1pD0/KRTGasDjP0wCmsiT?=
 =?us-ascii?Q?2+jUhOlSRtLiPZBdfIL6ZAyImu909wMP8xdhW60KHAaESyOdGMRlGh/rauWT?=
 =?us-ascii?Q?rndWsXbHLwPUeh1jwhei22MkwykWWTTkQuv/YH5u6d1cgPEFDBPSt4YfPrqq?=
 =?us-ascii?Q?CyUjZreUWACRdDE4m47ZLZPrsd4obLaf5b9HAL4Re+pV4NUpxg01BUS+mo7f?=
 =?us-ascii?Q?SzncJuEhi1HOQbtygNADBSbTum9rBVoDccy2mDSH5JtAyFXO3Jzbr+6IHEF0?=
 =?us-ascii?Q?C4sOjUNXM4cgfhaKB7+V8tHNiQGSL/4hqgrptQSBdnH1L83xiD+4cCR0JBCL?=
 =?us-ascii?Q?hIYFjfNVz0IgGQxavLMRPEdQgv9t96LVJW0NjFYefxg7MfZJ7uc/qK3Cx1NX?=
 =?us-ascii?Q?ie8RP/nbAxdmzyL/1mfywfzk0W6zOQmXRUkLWlEXDems1/kI6pkm5/LxnqEc?=
 =?us-ascii?Q?5d2ZK5jj6vdLPwjmsSPNwy+cIQZNpkzsw6D45QRHH+XCpsfWF0rD6UG0piFT?=
 =?us-ascii?Q?1vlukfu5CfmVUifKTJUoKC78J3RDQ1nFJrYQkGc8R560o5631irqk2WjLIn8?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26f7b3-e2e2-46d6-e68b-08dc13c48ce7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 23:16:47.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDuD79DiP1vWLfPAd0f4/1C62VOTau23O4jC3BQVwzgr49jIqrqEZB/sb9KBZQDkofmmoyQw8/BR/85eqgx5H+RosSNKp8uNe/gi2P3FigI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
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
> may disable mailbox interrupts and be configured for firmware first
> event processing and function well with the driver.
> 
> Rather than fail device probe if interrupts are not supported; flag that
> irqs are not enabled and avoid features which require interrupts.
> Emit messages appropriate for the situation to aid in debugging should
> device behavior be unexpected due to a failure to allocate vectors.
> 
> Note that it is possible for a device to have host based event
> processing through polling.  However, the driver does not support
> polling and it is not anticipated to be required.  Leave that case to
> the future if such a device comes along.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v1:
> - [djbw: remove persistent irq boolean]
> - [djbw: Simplify error messages]
> - [Alison: spell check]
> - [iweiny: test]
> - Link to RFC: https://lore.kernel.org/r/20240108-dont-fail-irq-v1-1-4407228debd2@intel.com
> ---
>  drivers/cxl/pci.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..bd12b97bb38e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -381,7 +381,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> -static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> +static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> @@ -443,6 +443,11 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_err(cxlds->dev, "Mailbox irq enabled but no interrupt vectors.\n");
> +		return 0;
> +	}

It is just odd for this to be dev_err() when the very next thing this
function does is:

        irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum); 
        if (irq < 0) 
                return 0; 

..which is silently return if using the interrupt does not work, or
there is a problem with the device where it returns an invalid @msgnum.
Why does one device "bug" deserve a dev_err() callout and the other
doesn't?

So at a minimum the dev_err() should be a dev_dbg(), but I would just
fold the @irq_avail check with the @cap check and be silent, because
nobody will care that this device is not sending mailbox interrupts
polling will just work.

> +
>  	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>  	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>  	if (irq < 0)
> @@ -587,7 +592,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>  }
>  
> -static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  {
>  	int nvecs;
>  
> @@ -604,9 +609,9 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> -		return -ENXIO;
> +		return false;
>  	}
> -	return 0;
> +	return true;
>  }
>  
>  static irqreturn_t cxl_event_thread(int irq, void *id)
> @@ -742,7 +747,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  }
>  
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> -			    struct cxl_memdev_state *mds)
> +			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_event_interrupt_policy policy;
>  	int rc;
> @@ -754,6 +759,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (!host_bridge->native_cxl_error)
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_info(mds->cxlds.dev, "No interrupt vectors, no polling, skip event processing.\n");

Not going to demand dev_dbg() here just because a device is mandated to
have event command support and it is driver policy to skip enabling it.
However, do drop the "no polling" that's implied. So I think it is:

"No interrupt support, disable event processing."

