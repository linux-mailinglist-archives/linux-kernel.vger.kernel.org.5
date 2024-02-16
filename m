Return-Path: <linux-kernel+bounces-69389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A7A858854
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEB81F225B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07221468FE;
	Fri, 16 Feb 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5PAlfKaX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7413957E;
	Fri, 16 Feb 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121093; cv=fail; b=BDqZRz6koLj+TYEn0RcxHk1ItvmMAF2uNOeyUdFwO69YFiwlV2qsjK0Zh/zjAKfxq5RLqVvhBplxJ2PaJFgGz997AKfKKI8cWnFmhI8IEqceOnsw0Aapr4pNMj6y5OeYXS+mECTm5Mpb39BMlkidskOCV/H+os96jNuVVcwcgYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121093; c=relaxed/simple;
	bh=SaB/QIj1TL6qNQ8QeIpBICnceq4s/Xj5rJj3JyS9nWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oa/9UnYakIkfnxc/0r6X/Jwk5ZvZm9h39nXc5YK51NmxTLt8i5nRjVHAIEZwXpLV2W5pASGlAPi2O9m4LWskhcnPkITEn9+cmjloTmINZZP7Uvb672nAtl4Y5EiZQMjP62uU9ykK/+gXI1NmK8hWsi4fhmcJyrGu2MYz9IBqLzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5PAlfKaX; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyNCpzOfOxCiCB7MIJ18v96xAAXofOEDYzZh/r3C1WTXN/6YDAIajh8n18HVeV+Id3nmYaX90hPQLlkHPk8YhvXj8tfCh2IUrRPG91gg+Tb8sQAAAEkaSNsBbllRT3V5ytMJGf2VCsRmT0/70t4zYkZw+rxUkpcNvuAqucTahFMtdW9KxC0+fJxC+uY2LKfh2QLRK3dlL3eeqjTFK+luGv2mbe8DLITvbCiFMzPudP9n/PoQM4llIYAqGEwczhD2iDa35GjXV/91L5Zf/+KfHSZAaxsV4JFjACtGkaD0G0hLcXCtpIFRDco6NGj75yeM1YTiBJksd2bmvBjFWvAgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzYL2mJBFzvsdrQJYlZhujwY+VlBn+16mbc87TR2MIE=;
 b=Ve2aaGpKvCIjD5RRXcrjGnyqhQldqJHpo0QNmm0qqndua0jR1HqfktuM22evYFE3sDKezf/NIFfaW0N2Cs/XD8xNgHupPKJ2CnWNQFvOFq/o7DJOHkTX/lRToJxpDo2oHTOquO5nMQgOIF+1cnjhlfY2tNr5jPBFcqUDV8VFF/nS+VT6BzlPQJ1uqLMN7/bIVKI1Y5qQsLPZUiXcjD+mnw7WVD1HjHflZ20g6DJiScD3rHLhHFZ7+bSAC+8dYJmGYq9aIjOvLG56ommm4Xtk6AEB2wJMSin8asyt6CUo+aWAsQ+P+LoPhRZczB1b+f63zoWU2MhujY/pJ8WuX8/N/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzYL2mJBFzvsdrQJYlZhujwY+VlBn+16mbc87TR2MIE=;
 b=5PAlfKaXlI9oGcIkS6YJ8oSKyRqlTm/u9yNtmAuP7b50QxxfZaZAQB0Sry4hDA1//QjKHnJ5HMqLBIGxhnw0HyLvcaAQaH6bospx9gt1Be4jlbd/+ZFkbtOE2fjmPhs2vVKCsGS+c5PSyPaejXI7c3dCFN5FFf+ZHEuVRTZLRaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Fri, 16 Feb
 2024 22:04:49 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 22:04:49 +0000
Date: Fri, 16 Feb 2024 23:04:44 +0100
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
Message-ID: <Zc_b_F5TSRSBwrNZ@rric.localdomain>
References: <20240216160113.407141-1-rrichter@amd.com>
 <65cfa34b741ea_5c762946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zc-k1TDk1hfvakQS@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc-k1TDk1hfvakQS@rric.localdomain>
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: e85f1118-8295-4d27-248c-08dc2f3b4b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ldxfTPBrPKdDvCF0uq3vXzlJAbcKq+PyH8iYfNuSv5vlQgJtWJIQ/tTmuM6O/EPMTJhM4i59Q6zil1V7ruSe4Z9jqb5ikwvT8NC2t4gfAaI1iwhwLY9VYQnSjj466vXKJb2bwQOmkVgGNxDDDahdCAUv70j6iVwQbj7EukdpgsN3jEk3QcBGy36u3YZatnd8UiwCJ68d0TIbXYUqstJ2ZZO7HsLc/nd9YMMqPr9/ayKIBGPUx+F+aZPTsSjQnRTlRtHd8ePjxMd6UL0heFvOYGKHFQ8hTj3AKdWt+6DX+lMqqiwHqmRtRqb+F+s9cq1chJUB3dT5sLKwhb2wy/gwbr6jJpXz0uCGF0La3ml20ynorbNsxbH016zQTEmJnIrRs6hsWJtzokV2eFFFCsdaAkc11A1oZqtZC31LQsKmYIlPMVvY7JZgWzi7R6exsavNJxr7P9wgHlYnUDhhJCEekk7DPeTOKuwBpx3ufKh+qTbUmaxnT6ylVPY9JkZYHFskHDdkzj5cysUyixCrYZu0OfryTHl9kE//2OvRzOvnLdA7YkosyjJeJ1WtgBDamrrz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(9686003)(478600001)(6486002)(6512007)(41300700001)(8676002)(26005)(2906002)(8936002)(4326008)(5660300002)(6506007)(53546011)(83380400001)(54906003)(66556008)(6916009)(6666004)(316002)(66476007)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nn1zcgPQvhdjkNnG8Y3BpLcmxtpUn45DGyi+HbvPvK18bgV3Yqq8UYPNfWyP?=
 =?us-ascii?Q?pzu3X9OT2MGG2bykx4+IYVbeX2NaYAnOOzDtsH06WfulhCvu+tKCJJjTpDU3?=
 =?us-ascii?Q?klcLLEogMlezOHI0zqYevQVCbIcLFPKfbX4ir076w5qFpZMQC4U/NQjnUwRM?=
 =?us-ascii?Q?9qwMgOfpZetAyjKDT0+QeRwMVugrkzMHru4l5CwfYbuXFUsW8MR7OCO9w1vF?=
 =?us-ascii?Q?9mxrqhQ2Yio1pmPfNL/mQTHLprnqKPuGZuPzSGVgiJsQQInkQybQHp9y8BJG?=
 =?us-ascii?Q?PmB0CQSZMwOI1NHnlXzVtQbVoAncXYEX+UOY4axhch/lVoLd3bAdqpiWsVHK?=
 =?us-ascii?Q?HzQotkss3H7DpAOCUJ7Pet0IS/JTNzB1Fpt0IMt4psLa4jrj41wwLzs2wBdf?=
 =?us-ascii?Q?oErZLg7DTa+JYEoXE1P70Tp46C/F4yPh9p5irx0F0cl5pAK1DNWY9xdgjn3b?=
 =?us-ascii?Q?AXs4QFwgdFYIyzLWqvIJ50WZDA+YifsgHbCmtlTBNqSqVqXGq02Y6k/nM99K?=
 =?us-ascii?Q?QEtCIUJPyanwRGUBu3fFxfzmwkVY9x2ErcL5JN8F1+9xXwBLpL5CDHWTXpai?=
 =?us-ascii?Q?xcYOMK9VWHKZ3+zYD8bAr1WMqzwodz5/E4vK5cj5OTPnM8wKoKwA1LCBmSYV?=
 =?us-ascii?Q?DNtepQxZU0ewNju/tFci198hR67VKXrQgesapl94Z9F9Cj1FqUtURdaeyEXW?=
 =?us-ascii?Q?8OwZj1/LhDSipdLl1hw5jxqWQfMzmxJdaV2xhs6lplw/IZIvSFwZR/1iVDcY?=
 =?us-ascii?Q?Lst3VjgCr5lC137onn5IjCxDaqVKpKSeEKxS3wIMCM73XUvXWOOte9wnlMhx?=
 =?us-ascii?Q?Lok7d7TXTN9L3cKn74YAocGxKdcWXETNeA99h9UiKmbgG9flVu2Liwyk0GEQ?=
 =?us-ascii?Q?POoRSYIfDKf+hPOqryODatpydxlZT2xhIlcEvcMrHVD8hPyG8uS5sBZvgEyY?=
 =?us-ascii?Q?cCfw0YloGsBv//UaXFdp9tmjg+uPHgOEFtEtLGtmOKKZe/95nyYaKigIj+3j?=
 =?us-ascii?Q?hTeC0CVVhnX3zz2guKjST0+mR+VrgI1dmV2fogM/1l0Szj8I0eJWkqiS40O8?=
 =?us-ascii?Q?V8gjNuXDGE+Swr0AnN555YYBlUJ3znrYD5dc4xIdMgVhsimo6PRZJX4A83Qa?=
 =?us-ascii?Q?iz6ecsrHQu+goDBrHjt+Wxo5j0NF4N6ybWx8l/xWq3/hyXnpQx0QJwOQTaJX?=
 =?us-ascii?Q?ItPSuE8mLMz6rGeMke0FpQHAkQildt7jKtNUzMBF0HNPxsKYfqKbhQqNdkex?=
 =?us-ascii?Q?zCB7fAgLpnAVPEWDStpsD78lWfl6NtHaxk3WRBikLJ7msY2fKRFCRoOy7RW2?=
 =?us-ascii?Q?ljIhnfDoYmxvEXoktGT3HnKoM3IDE17hnEzGSwM/PolIyASMIt9FKYe+PTx9?=
 =?us-ascii?Q?mQ7566NPcbJmHpg3CGAb37a2aEFrtvLDzA2LuvKxoTCHI4+/Vs+aRKCMgP1o?=
 =?us-ascii?Q?X+lbrdrNIOJaSCnHS7zbn/h7Vnah7ebslm3bpXFIwo6LgU+YHOZm8kmL9GEG?=
 =?us-ascii?Q?+jQq1RA1NhoJusc8fP7x8iUG5wNU2oDbpyj9M5RxnosM1y0RwgcmIccDChNF?=
 =?us-ascii?Q?KBuTpUOPN+sNB1BZ6ASPXT56CVFnnvamFtHX5EEx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85f1118-8295-4d27-248c-08dc2f3b4b17
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:04:49.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvbCiQfMCf3SWqT4QBbd2eRBb3gZLeKDDE4c1Jrqthmhvd7Ytd1NBrpfsJYfLLxWwC0VuoxABVDN1zzJuxKt2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063

On 16.02.24 19:09:30, Robert Richter wrote:
> On 16.02.24 10:02:51, Dan Williams wrote:
> > Robert Richter wrote:
> > > The Linux CXL subsystem is built on the assumption that HPA == SPA.
> > > That is, the host physical address (HPA) the HDM decoder registers are
> > > programmed with are system physical addresses (SPA).
> > > 
> > > During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> > > 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> > > a HPA window that is described in a CFMWS structure of the CXL host
> > > bridge (cxl-3.1, 9.18.1.3).
> > > 
> > > Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> > > window and the CXL memory range will be disabled then. The HDM decoder
> > > stops working which causes system memory being disabled and further a
> > > system hang during HDM decoder initialization, typically when a CXL
> > > enabled kernel boots.
> > > 
> > > Prevent a system hang and do not disable the HDM decoder if the
> > > decoder's CXL range is not found in a CFMWS window.
> > > 
> > > Note the change only fixes a hardware hang, but does not implement
> > > HPA/SPA translation. Support for this can be added in a follow on
> > > patch series.
> > > 

Fixes: 9de321e93c3b ("cxl/pci: Refactor cxl_hdm_decode_init()")
Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Cc: stable@vger.kernel.org

Sorry, I forgot those tags, please add.

Thanks,

-Robert

> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/pci.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)

