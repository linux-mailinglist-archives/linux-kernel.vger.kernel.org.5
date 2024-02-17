Return-Path: <linux-kernel+bounces-70094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AB8592F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480121C211A0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228787F7F6;
	Sat, 17 Feb 2024 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZpwmHTgL"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507C7C083;
	Sat, 17 Feb 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205272; cv=fail; b=kl6po2kk83mMn7uJLVgE1FXgqH+aNf0/JPfHOTw8BbSby4iEamLk1WUepzQB9/WoBBh6B17rZM7rYdsNqU73sefJiFOjK+M8YPB/za0DvxJWAtffQ9tCFHg7bTYhFfOUrKcxW2yiRLQeQpZP67GEwoQp6GuFN8c9DHnQxSIsTIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205272; c=relaxed/simple;
	bh=O/sH2HBlZYptmobJjDGliVtAd2l0If+dFNq1tFy0zxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfWqJyaDg/dTXBDTXtOLjZYMn8yqKbQLeDaVsrO0dlwIYrBKP6MlTVXOObpuZJzRy00ahDn2OlNedUJs2ogPb5bFOM4OKa/5vzxP6r1aTIYE3JMjSSfUen6KCFlzdHq8K4VxNujfFi1v1gP0zLgz7izgTnTxJqRNnOJDEJT38xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZpwmHTgL; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnWFkjuNwu/jEgahTAkXyOmeDIuWZYWEQVtRIMqrqf1Qx7k50osZ8xtWnSy8COPMv12Ox3PIuBTLpx69zk5f6T1E6/XuoIJYzUfjFoj+8BMdxE+yQMIddTjD1CvjVodwU63wl/4lSyLWsJK0PBvjP8UpD+B3fNDdRhjBAs+a9lGG2mRpiPBGnUNHbcW7Js0D1ti53jbVhEq0w2cNr5ob3uMevl3JO+uATfgHXZz/mRxB0EFlY1uU+bh/I8pyMdnkPusowLpSba7M1IR3XU8xDy7o6cLMTFIzCOhPLbZMJtG0DosmqvIX4cuu7eacJKOTUYwuK+zIG8Ahbt+gDBdNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cI+FOK9ocK1z2jnw1KRC7DDotKVVzkIzXoWsNgWD/YY=;
 b=I1AyXIF6PWLAQ5HjFWgV0Diip5DcdSiNh0KaWuMVXv2Gsmmwjj+jAGRi5L2q4JCpFjkrGbdYl43ExwzigYiM8CFAkBBhCtGjwGbqxuFggNrYSDQvAMDJ03wzx5y7IDeQwCbT+/z6ZNhfF57orwSR5bhmdRRmhxv4LTM/+xJHYO7C4LFjZ7tk8ODfpCwvJbxVguSqEatJjzbcZV1uJCYmXTyjx7xGuPqsBUeyzV2EbG2fZD40kecJYrYerKntMYx0V09Ch/BehBKrRmHhnxmW84QDY8QhrWXUmPk5n8YRH8d9wquKvjgIuFKpiUkd//6FnUJnPaWFyDKnM0oIPzwbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI+FOK9ocK1z2jnw1KRC7DDotKVVzkIzXoWsNgWD/YY=;
 b=ZpwmHTgLXp9KN7duPb3GZ/2rXb48RQbHBV1bEOshc9Oo+Z14i0djYXeDxD3w++DMBXIGAhYtStkGqZawniBznZioj1DANsEqtIrOusllVDTXjVf2tgoB5f3FWN6Nv9Mc/offvSrwN7ELhaIp/OYdbpSUl6qTV+poUvriH7tjGPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Sat, 17 Feb
 2024 21:27:46 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Sat, 17 Feb 2024
 21:27:46 +0000
Date: Sat, 17 Feb 2024 22:27:40 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does
 not match a CFMWS window
Message-ID: <ZdEkzBbm7aqcghAl@rric.localdomain>
References: <20240216160113.407141-1-rrichter@amd.com>
 <65d034a22e258_29b129484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d034a22e258_29b129484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 05da3396-9050-494a-7ce3-08dc2fff48a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sMDEsu7BGDGFJBj5YpzY0s3KJzEcvvc41PmjBw5ubqAXrwv/A/Nr6Qda6fhU4BUWfD1i6xChUlKNPKI/co18TonZuWzc7eJAjDbO4CkkC8nz8+tlRR+ZwZH5dkA724JY00n+ro1Qr8gqb9gkA8gLQuXOqjo0048VFbLt9T0lKV0igB8Vi/6cdVjIf1fggm3VnhZmECuKW1Inq2B1MbslJoDM/GsXcJMyA8rXQbTVQmzY6qOJ2ZOsIJNUHzJ7obVjGwZ+KjgAqhevWCmVXaYbPHaVaiNxZMnjnpwiOFAY10ksJlQnh5NHaOGsig9o69VAADwmEsAwmcKMF4I+s8z41ZbT/hIizX6l3r1x90QstgI3TGhyo2DQGoZtTREB7m8YolH+2bSxSVlrHaRistvSHm13JziC2JZqhGHtiJzKMB3KUQHKe7sNfFQRvfhKJGcEGpSRVckvIbRamqTFTDL1mdnYBtUczUvN4F+a+xkgZrHZI+z+SQulMC+8pA+hWWqMBwwPAZJWiSvRs3EGUfukkR172MI+iE6h6maXVL4CHrIAJs7LD5eO+kNZTJ2+vgbb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(8936002)(8676002)(66556008)(66476007)(38100700002)(4326008)(5660300002)(6916009)(2906002)(83380400001)(41300700001)(26005)(53546011)(6666004)(54906003)(316002)(478600001)(9686003)(6506007)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHd6bzeExtYfKicYX9/81Aky0nvJyUbSiCl5UEy2o+bHEMgzXhev7wJsZKx4?=
 =?us-ascii?Q?YMaTZpw5sVz+aYmRQEYVU/8u8BNGyth/uqp7Z3nreAHPJuUZ24hwsR8dda90?=
 =?us-ascii?Q?pRZndKt47/fw8E45lVNvszXhslMN98KJoI9OK1xdiPSlUMS1lbeMFgZDFTay?=
 =?us-ascii?Q?M/7UIEqZn8cWeydb7AJ3q9v69YUm4VDSFg/t0WY/lZl0z/x90Pnnp36LfeBo?=
 =?us-ascii?Q?tE6IOud3jx2Mql3SXtUAzdJEDQfGAvoCJQOT1iblOTZS4i/56oQKqXSVNQVb?=
 =?us-ascii?Q?uNXGP2p6oAITxws5OZbdAH9V4A5pX9okzVWlKwvTAzPDYHcAflyX9S+H/49p?=
 =?us-ascii?Q?6O4qjQrFXdzVS9DpEdIdC+tYXGaJ1yMFbenLyUcPhbgMa/6BJFMsIn2Ffq17?=
 =?us-ascii?Q?ylhSFd2f9wTzw4oLE7qfsTmZsm7+3OBOelWwbfWTHWyYkMeOovCWSuBfvwLy?=
 =?us-ascii?Q?qMA7XhEwRjdSJk4BOAYQkZIQjEbUGaW/CxtH68NShRZBp5XMFc08D/REtrei?=
 =?us-ascii?Q?fW//tBzB/GbP9QXF24S+Do2kLgTF36/fOuF5NASh6vUs4bHlIZ693h7eR/iD?=
 =?us-ascii?Q?gqucEnjaoqei+UQYkaNL28LMD8N06kGqjuT8D11FhDYXD4iZejC1u9OyBibH?=
 =?us-ascii?Q?rq71HomtG60xyDFdO5/YD1IszL525KeKXsL3Q8p0XATwZ5UcKxPywC3/KW8k?=
 =?us-ascii?Q?VBW8QomqBBrF9XFstAFiy5cx04ImuUOtDfYzNEudrj55bz3EOOlzfnh0Eb7c?=
 =?us-ascii?Q?LzXSQZCbzjyjD9Rr1K39ukCzQ3wdhdLQAjMt2aNooL0AoVn8DwKqE/JBxrp2?=
 =?us-ascii?Q?RBVmEzokxcojEmwplH4eonoChAHjuGYybV80XAMH6TUZFzC/F8W/JoTXG5B9?=
 =?us-ascii?Q?ur0LFQNDj1xwk9ZbuGCPei8AOll4jXKgnORoxlpB2jZ68R9o/wjzd6rPrs6E?=
 =?us-ascii?Q?hu9wsHc+OngHS5QWixo+QQBbFIN1B5uf/rimrw6KxBNeoKZm0GfOsoO4btUG?=
 =?us-ascii?Q?K+QmynPX5XkXehp/hCudbFk1pvThs6ejD7wbkX711gjyS32YDQz/TmQTKU2q?=
 =?us-ascii?Q?hJG6Y4YL6IglJbKVy5FMnPmS5ailZfX6wj+QGycG13X0av+NHriTZoMBSa8b?=
 =?us-ascii?Q?xwqK8JLnEQMK6S0MCQELr3mr++9TR+PJfZpgAdZ96NCQsCLcxqxDpjiEjSs2?=
 =?us-ascii?Q?jLqtg4k7bSNhWbKoOI4IkC1PlW6p9AkHKD+WulPNZ7DE+2ZmGuY3OOgMb7iT?=
 =?us-ascii?Q?K/f7XLzqU3+bCG63POyIN6tvHqht+liv1n/FWkXTHnZX25pQ30vXMmMQzT0M?=
 =?us-ascii?Q?PM7yPnh/U5zeGp1COFAKPWuNmQAwI+VXq8jOAaYjLqw5uBhD1m5xSBwOSqq+?=
 =?us-ascii?Q?rr1EZ54Hh0MXGnFHMjiFAq7DxaOQcvP3VPZffCXGFz6+MK7mJKOGCelI1yvY?=
 =?us-ascii?Q?5Zg0zzLloqRDmDVDDmPZmRpfMnyKKwW1JXjrZM+/9Gr5c+0THnvpgbL72fdV?=
 =?us-ascii?Q?bMqgoXdpQJrZJoqjhQPJWNBkaX1AULfIXhiSrebMNfuPZW8FHVXWdMOfK0/b?=
 =?us-ascii?Q?tiezDv13QyK5oLpba9OTTClb86Y9GHRxHhpR7I8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05da3396-9050-494a-7ce3-08dc2fff48a4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:27:46.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBn4HdZUKVFiMUoC9E/Frmn57unQoCkLKHwibXMoPsmZmpC9b5pxwRC2TnoKEDf8x+FMRQ4F1tozX8sZTkD5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974

On 16.02.24 20:22:58, Dan Williams wrote:
> Robert Richter wrote:
> > The Linux CXL subsystem is built on the assumption that HPA == SPA.
> > That is, the host physical address (HPA) the HDM decoder registers are
> > programmed with are system physical addresses (SPA).
> > 
> > During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> > 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> > a HPA window that is described in a CFMWS structure of the CXL host
> > bridge (cxl-3.1, 9.18.1.3).
> > 
> > Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> > window and the CXL memory range will be disabled then. The HDM decoder
> > stops working which causes system memory being disabled and further a
> > system hang during HDM decoder initialization, typically when a CXL
> > enabled kernel boots.
> > 
> > Prevent a system hang and do not disable the HDM decoder if the
> > decoder's CXL range is not found in a CFMWS window.
> > 
> > Note the change only fixes a hardware hang, but does not implement
> > HPA/SPA translation. Support for this can be added in a follow on
> > patch series.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index a0e7ed5ae25f..18616ca873e5 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	}
> >  
> >  	if (!allowed) {
> > -		cxl_set_mem_enable(cxlds, 0);
> > -		info->mem_enabled = 0;
> > +		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> > +		return -ENXIO;
> 
> While testing I found this needs the following fixup:
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e24ffae8135f..e9e6c81ce034 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -477,7 +477,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>                 allowed++;
>         }
>  
> -       if (!allowed) {
> +       if (!allowed && info->mem_enabled) {
>                 dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
>                 return -ENXIO;
>         }

The change looks correct to me, thanks for fixing.

-Robert

> 
> 
> ...i.e. Linux should only give up if it does not understand an active
> decode region.
> 
> Now this SPA/HPA mismatch will still cause problems later in region
> creation flow, but that's a separate issue.

