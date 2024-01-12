Return-Path: <linux-kernel+bounces-24928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3E82C4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05DE1F23681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384F175BA;
	Fri, 12 Jan 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBfRq/53"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456E17569;
	Fri, 12 Jan 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705081382; x=1736617382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ULXzmlL/2uf0uPDuJBBMkCrMFnBfNtHg0w8+WaNL1Yg=;
  b=fBfRq/53Rqxx/af7UVzvxAF9cMeqTCR2Ndd2tIltJ7ChR1Adq+V/mcha
   DOxJGRbKybr47Bylx82OSFa99wPbI2IcM7/zxTCwNGLHgZyrsN8UEGzTn
   b0iTcMFruN83jye7xI5lW5io33prOay05Vi+OeWBl3ao6GCStcXc0EFfP
   X4xTAxum+l7n339kFemD8GamGoS5kSNPsa63dVKcH38+SUY5y9xCHFbnK
   FmfJrpOp9krpOx2Q00cpFbaYjlURvaoqDWomiqpGzMSz0WL2iHqNBjVd/
   Ta9fdgs1ZUdXRR7ijYeXMzoKRuG/0EC6fxRIxXeGo5JeXbUYReAkg9b7i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="20713517"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="20713517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 09:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="906383557"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="906383557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 09:42:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:42:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:42:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 09:42:55 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 09:42:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlHZeUxPMM5vcOshy6ExyOTmzAzb4MKpRD1cLPnjDM4CeY9q/MJI10WPolaTz2JmUqNY3DOvq/hJZH2O0C5oxWRAfAtiWM39QifIra9UkXImu7bk7UZ6SW4h6xc05XYWly7i31OLnUHXdmgfsREDAKeRVJ7DGwY2Bchq1KImxT+lybY4WJ0zQvciL2H3ePSpyqZKTTV1hcYtiaDeHlv9LTIq8IGjey+/qYoFRBglFKO5pEraf0kCZNhNaZG2AaqVMq+dbXyiF5a6BE2qyjmedjF95EVdxaJ1cMitggTdb+cz6oyyQGeBdz6H4ydLetQH1d0r8iw4SfQsOMbp+vEddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0sOb3yXZEt3wu+3FCX/DYTGCH9wrZVuIy5M/nHOiwg=;
 b=W93JqRCKp8yokZThKyymFrjnf2hqjh0qQ+glXU1N9HMDc0A5KMryR3naiLEdxrxQ9KHPnLVoJyhwyit3OARM03U8lgydHJiZsz/qzs43R4kaViPtizcr3ryYPeR45GwXNGOwwRMUo2ubCRDKkW9L+gPd92aZTzzTVQ0Nnx/eG2JX82Z+Wu5MatQe6kYme3EJO0EFWvSYBRx+x4uKoWeXP50TcT9c9bMPafA7XaCNyDB+1FtYoOAPNINHqIqHLN7lYht0Jbi7vFGAvH0yLZNSn+WB8kyTWwd8SmhghWiPdo+cq2xmgvZNONYCjH20y2zBHyj0YTepWQJEyM4nc/cBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6764.namprd11.prod.outlook.com (2603:10b6:303:209::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 17:42:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:42:52 +0000
Date: Fri, 12 Jan 2024 09:42:49 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Skip irq features if MSI/MSI-X are not supported
Message-ID: <65a17a19c5528_10b19f294a7@iweiny-mobl.notmuch>
References: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
 <f4cabd98-2759-4cd3-81ac-4afdf9aadf56@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4cabd98-2759-4cd3-81ac-4afdf9aadf56@intel.com>
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dcd93c-dedf-4297-d57a-08dc1395e710
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvpFZwleLhoqM8A1Memr8E9YhCl9aMqq5f5YCE32zf2779RYMB9w1U0XfcqlWrROnvpvRNT+FcaYg2DaCFU2iHsz0+R3WYD5T1e75mX8AL7ThlIdfuo6tvZ+OevTfkh3n/TuyRgOXLq+mmq01kqqtCa7HSOMxFq7duJhkSoKjcFdy8pRLN1yma3g2SEHDs/i4xeerskxkYGD2qgTSwpc+FEydUdrtRFeR1GAyS+7m8hj4LtgmGC6kmVUmGQS3OQo1Epp+PmzwVoUFrNhLpVKPX0cUgCKyAdYlY0USqP0qQtCYFfateiWIyZ207D8k+Acyh3HaT9OL/hPoCta+FV9yiOKwRqIV4GU20hXwob8TUz2TrmF9eJFRGNzgLtE99txXqPNsSYsgmKChOaLYSzrhFLvsECqtdaTrYuBitAcDw5zW+mcPgO2ApiBly6KKaWjh3Ozv8IwbBJ9A1WlZE2YmhxrN5KAvVPJgX8B8jTmCpX5moc+x4yeAzRfGLXJVl+uu/ujEsn6Ka3ITIeUKehp8ag7z5evaGB6Tq6xm2ShuGWj+bNIu4sj3Pi9FKtFIGN3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(38100700002)(82960400001)(8676002)(8936002)(316002)(6486002)(110136005)(4326008)(66476007)(6506007)(66946007)(478600001)(6636002)(66556008)(44832011)(6666004)(86362001)(4744005)(9686003)(53546011)(6512007)(5660300002)(2906002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GFCwLDiVpgJ/gma3rnhGq7cPcakun8eItwnH1kUu/d29/MZ8R/Uw6qezKVq?=
 =?us-ascii?Q?orjcsy7tOxHFkbhIlNkMkY6Y5iZFXipG869nSVd5OdJpVO+p8w7faYgKlTQh?=
 =?us-ascii?Q?JTnjmElYUYyXHEeOoenRJHQbfo4COkx086lB0mcS2V9T+DYZoBCMjUGsmDpJ?=
 =?us-ascii?Q?afKRBP5tTygsXwyEXpc2yK2wGUYnUvmZdNUtUVZB7KUwusFwy93nUMjolYcg?=
 =?us-ascii?Q?J8+0g2hnvzHlBBfCVUJhosLPEK50g6tkkf1miz8T47eObvynpPhGU6vQLTtD?=
 =?us-ascii?Q?0jrXMPy1RD4G/BuWldAfqDSw4BXteRPSr7DtbYk4RgRuBdT8c13G7X42AT+Q?=
 =?us-ascii?Q?6gifVEO9HK88j3Hj/mlz/osfif2N7Z48qKRV5JDP48EEUR2rupCgCH9RJ8Oq?=
 =?us-ascii?Q?TZ8KxrjR2G5t1NBvh9+RAbhuKkc/lNrCj3mqI+CC7o+lKYUvkl05eZh6cwp8?=
 =?us-ascii?Q?Zt+1CRUDjrE2DmyVzixyAC9XpM1LTvRtz0iB84n0ZadfJW8lBnMJZJBXXFMn?=
 =?us-ascii?Q?co4EcyJnV4Uo2Q93qQRyxhC6YagAprLrDWJlZr+p3kp5D9xfD7BtTBslNr99?=
 =?us-ascii?Q?/xfkHE79L7Kcw8l9GaxshWZDkduwpN5Yzzcyf/WE5uba8L36WwvRU7kBSb29?=
 =?us-ascii?Q?DQCvxirkdzViWERN2DWBe/vDpG8yT0j2sgWGid4Wr9wTUJ1zNH9NMOxqy5ls?=
 =?us-ascii?Q?pTFa3rP2GE4iIujg1wnmCykN2wKkbfuxfhPHfcuB/mHGNbAxKsWNN72e6o6R?=
 =?us-ascii?Q?lt+/YqQv3aMQFCfdl5jajFcLi6NvQHgBLPG2ceQ6Ee2iRAGI1jUh8vP00KMy?=
 =?us-ascii?Q?2b9cZziy4l1b/pSgBjN7A6rIQ728eWTRVUcH4tvLhTQgTdyZO3nJQf9RxRuj?=
 =?us-ascii?Q?stEltR/NYeMyBUVdHt0hPIGAd3cU5C+lRaVTZT/hF+R7AjjF/AugPdDnbAXT?=
 =?us-ascii?Q?b5ic5U4hApwVVMwqSxu8Y9hpO/mhSFNacMxKUE68PjDfv27XhGFt2coDZjo8?=
 =?us-ascii?Q?VRNuyzTRY6LST0sUPLIN3qZMhXwqIAOhMzV/wzg8m9VqN0wDh2DiUQwDdbqa?=
 =?us-ascii?Q?eJ/FjA/eOm1DDFAYHEJ9gvejJkP3vEUzfDR1SCxFtBfgPAgRSXpdU6o+h5Hu?=
 =?us-ascii?Q?ZM7OssL6a1cWiaWaFLAs+mN/kbc7co7mcdLa+EUv6/hOXYG5S3JPCu2BEcwl?=
 =?us-ascii?Q?++lusydK770GmqHxtsUZnDY/1hdqW7YxhJa7oMlwfXmMsE2o6Dx4NNEq2dp/?=
 =?us-ascii?Q?tueelUyTBZlNYDjTo8DRySpbYSfCkPPdGCBekCN+Q1nndxsl9v7V1H/wrKft?=
 =?us-ascii?Q?gHcdNkfUtEDdTxP/Yfg8/JlOERaUo64JwFuhlo0CQQV5dBQlBsSzB1se9noh?=
 =?us-ascii?Q?DcQTBco3CGrGcL5I5UPt2rqPbF6uBfWh0Z3tt2e01/3cw0JNRwMVDPhHO9fX?=
 =?us-ascii?Q?Uo7Vp2sNZyDhKZ+OQ9XCubJsDmUWhLfeC9Dzg0o45V55pH9q3NBqZ1uloZIH?=
 =?us-ascii?Q?vtFWp/2J0ZclkVxAdzP0gwFGdkbfOah1v1kmX7X/5/J04WSYjPhw8XRLjKBe?=
 =?us-ascii?Q?rh5D29V4Hqjx1bz+CDJdukXhM5YYGZTVjOeY5Dnh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dcd93c-dedf-4297-d57a-08dc1395e710
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:42:52.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX24P9jf51MQr7IvlQQb14Gwtrz1zslqLFnQl4mQ3vGHm0NkJkqXtyxP0VCLU80GaKeOloYljyevb4K+IE/OcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6764
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> On 1/11/24 18:54, Ira Weiny wrote:

[snip]

> > 
> > Note that it is possible for a device to have host based event
> > processing through polling.  However, the driver does not support
> > polling and it is not anticipated to be required.  Leave that case to
> > the future if such a device comes along.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> v2?

Previous was RFC and not tested.  This one is tested and ready.  Hence V1.

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks,
Ira

[snip]

