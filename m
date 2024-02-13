Return-Path: <linux-kernel+bounces-64138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A5853A92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB98B26722
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DEF171A5;
	Tue, 13 Feb 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3txjAUnM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBC5812E;
	Tue, 13 Feb 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851387; cv=fail; b=VPpr5qGMgDCeYrYumj85BVkrw6ypQHPN1tZZHbeLhmIyyhpPtcRCY8iYOxfxFZ0UuF1Za3ruUp/3BaXpEmoyjBdxTgstCVCG+1JFF89MTBOtKFtiFUjA9M9hZ2M2jCHN293/MUEQ8L/u9UkvnbKqrInLQjxqDqVOHGzMeedmpS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851387; c=relaxed/simple;
	bh=zLgenNz0tyfdlL7m1Gz6jImB4Xu3czTJaE+xK6x/ImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W4lRnZgyI76MZ/PwFc4WeqxpFaAlEL/JWYtyvgRlRQaC/s9QGKR1GknGlynjKklerN5qDoAQgVSdrsHnkzJ8c0Hp462Aa1EscZgc41PLWotTYhlG70LDJZzSsN1FE1MxfsR/4b7P2P0lRKfZyCusHG2ezgIvXAtlKlS1KcO4j00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3txjAUnM; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOPCm+HfOkSRmKeDMoz1qe2W09lH+I2XZNUPmMcplxHOWI/vLsglhUgyUPfeOdA01d3JLAGKVOSlANyzS/GWeJw7ZpNlOH2PrV8rBQfazWrtuTnDGYMIb5T9lTJ3BozGKx1wCeoX85vbbpycZBgzGIm2Xu/L73RuqV206BdKxKWUUyl5RaTYYrxY9B+OvP0DIhrwxpxxLLm8ORRJD9BR7QkVYZpbCJ/Goomdp6UZF0JT1JTC+L+emVhRMPeTDlggPNTcSaOpuVUCS/YlfeoIprbjD1Qx/HgULeyI/b2oXfEYh5//PpuvHoDvBAx6v4PDxNwtVmjyttV1uv/KnP06Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+mJR2xUiZ51j/6VUVf4c/0KwA4gHgdlHF3DFdeXnag=;
 b=WjeZJr8+G/n+84pqFofMMpUYG8zAMXtHsdQRqEgSLGk9qCt/p212KYQVkqOEXmdMfxXA2eVfiGWX3TquNnmo0cHE4N1Wi8koZPQnYgZZ41TRrKFQHnpmMx1eCEJpddLmYvxhp5jvCPKZ+Vs/ZxTH4iIkbt9UPUjssGaGJLypR5PmfPPk73sPrfumVAPuMFoFd396FqBE/T0xuuo9eq5+IOQCAEntSQFp3PfN0M7/PGfeQyrmsRi7yY7N9wyFvGlh3XDOsqt1fNb+NfDMnNS4cTETt9CIkMB2PNaZAaxMpl6ULN6VsFlG9dB0jRaYqhvRelVH7v2DE01xDsdVfrdb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+mJR2xUiZ51j/6VUVf4c/0KwA4gHgdlHF3DFdeXnag=;
 b=3txjAUnM+CKUWyX5l/PJjAOo4cSde/tFhHmhJRGmTqcLpSJDva5FD7QlXoAOaWgkBspdgJoJjwxAkSRRJ1zmgvlg2cQvBVuY30+4lvjcuJ0p9sHr1cNyUjlzCGndOi9m2fB+ZlzpeVxGXPLc8/rOjzVD1Im5+W2sTCOt/rsbTOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 19:09:42 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 19:09:42 +0000
Date: Tue, 13 Feb 2024 20:09:37 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <Zcu-cVG9deqfwdiV@rric.localdomain>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
 <Zctg4Lx_y_hbChUW@rric.localdomain>
 <65cbb787e73c_29b129432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cbb787e73c_29b129432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c75b9e-0e2b-4be4-ecaf-08dc2cc7559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2KrFKoukcdlAFRiGti/NF7l63UD1RLOp7ioPKTOq9jm3RLBj6n1H7vz/Px8jhzKz6A6mZEXB+mSYMMNleemk3G6XLPc4jXe5zvCOwQ83YxFLxL3VYkjHw4d3JXREbl9bZbUDxZ5OKpeHmTb+3kgfmaEieczJJRcrwBqX3UQ3HjjFYjWhz3RKX9qYa18OB0Qs8ioZNRuAkSJXe7OZGGrOBGZi87Tq/mVProOWrk268OR5K8swf6GGj5PuQzWfsrv7kKMEKQBEPM3ozHiqf3XX+Z0+ip4+NwLtxBeQGQOidZSJzp94kZA06UwyHZmhQS2AGhlGX8STK8cBsmSuMLt7/jmdmHeGRiG2wVoCTgPMcsJf/lMNGDbZB2PoYYjJSNXA+AOdxMS1HX8gYVaow6nDbgOwWE3ga1Xl8jiR1xx4m0+UyL8Cdku2UWiCYsPZ2Pakdk0YAGn4kc2mHBDOLE03F8z1QYvwJc8cYEgQc4PcCmBL3kU/APXIh+/9BALFudpmmiTaVNqsEjjt2QpETMDBCGlXfsxP1JZ+7q7yHrwswCGl6SMZzwuYv77NdFem8SXD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(53546011)(83380400001)(6666004)(6506007)(6486002)(6512007)(9686003)(26005)(2906002)(6916009)(316002)(8936002)(54906003)(66556008)(66946007)(8676002)(66476007)(4326008)(5660300002)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EoWwK0vH+8l7gkSZ6Bi+qsy4r6qz764lwvm61VkPzGRvKj3MvNdx6REuk55U?=
 =?us-ascii?Q?z4RjuhMziNk72d7J+RFqVAAj4IBvtx8unkX66+GYT0EULr2jyyJbZ0VE42m/?=
 =?us-ascii?Q?AnHM4gevHgWmXDvi6HPUh6TOA2UwOQqT7B/1nGDMUUjhyMXjqXMdbw6y38uP?=
 =?us-ascii?Q?RHlDhy2j/Cmn082/WfQbI5lsQ+Fz486lDTZQfgV8pUgeEmigt24iWMO2tDum?=
 =?us-ascii?Q?xIz0/1mZXrU2PmZAezr9uUwp+okmLA5A1aZAD5FKHeBI8g/Jr80SUIFZ7BHy?=
 =?us-ascii?Q?lMn8BxUokYCo/vmj1wDFIvvVr5IfYm663xI8KcXGhEW4cm76ESecOrAPZZn8?=
 =?us-ascii?Q?JNF7HRsTM51BOfhEBCzUN1lS7zf4KE2WOc+PX37El2CMwatEnz5iHsOSnevK?=
 =?us-ascii?Q?HoD75U3RrcSNUH2eiI3nLyAJzF97s3wdTdB+ntcvcajlFvJWZFlxU14OcONk?=
 =?us-ascii?Q?3zpgKaP7NJXwj6rlMXSbyBdWxVEn1mHl8ucWpeKHx8p+Q6NjAPDwwftvvboH?=
 =?us-ascii?Q?sjse1L6sD1imGGZ7yMd/6PUh+ljG5wiCwNe9XIVK6whEBCyFGUXdh6/PN5E2?=
 =?us-ascii?Q?3gcG6EL3VSQGPus0zPju7HZR4EanVsYRsIC5Xnng8b34IPMX/becr05JO7d0?=
 =?us-ascii?Q?iCkxugAmbgRMXqPzMw+YH4Jn8LWo26zBXnQ9TR27FbShZFOa4g5UV2om5EjY?=
 =?us-ascii?Q?1qHNgGTbZDlSWrEZriK9Phghyszz7vDuV/7DUThKg65ZlIiL/2XORyvvuPKf?=
 =?us-ascii?Q?JSUi7OCN6K2Vf5O/bRR8YszNqOL1qYFmdIrNHDWR++sFjGzWDswFs1o1afrU?=
 =?us-ascii?Q?IVUwYSXRWa8uI5Kahj58aCscE2Bn9SEZ9M8tkO2iJedc683lR/FcfdzA58e/?=
 =?us-ascii?Q?7+wHIC4r+gmw+PUsLcpAvtRhgXLosohFlV652wZMa66QkWLcqep5XfNUnhM3?=
 =?us-ascii?Q?dqlOM6L+IfucWNnI9Ia55eBSbjC7zw+kpwqGB1M76i4JJgk0+8ke7xb9tKuM?=
 =?us-ascii?Q?4Ar/0IbAKl/Eaqz+pZwizTpjEANTsnLDjj0CE/JOeBkoGM9KJeegS4QyHUFT?=
 =?us-ascii?Q?mCI4J75E4JOyek7f/2yarSwD49v5S+1wISNhKdPgf4GQVLtjEkHUTz+i+JkE?=
 =?us-ascii?Q?dmXBYWOGNPqhDIWeqx9DmgiPjT6FPoj3mnTcEQ81UovXXd4E/mQ/QMQ0fOH7?=
 =?us-ascii?Q?NH/p5vY0d28/vNPxzQ79Cc7zO9dSRpy9eWwvSPxRdyvdoT9rnYDmpCNsO8Qq?=
 =?us-ascii?Q?B9pYq1wwXtWTP6St1XBFrulUSLnC3w55w+u2BPS18hc0FOcWCSYUBy0i9XvU?=
 =?us-ascii?Q?zQqAeqv+6QaOiWIeHFBOVxVR+bA38CjS74Cjc3ICjgXY+awwFTkWVGeYRHoK?=
 =?us-ascii?Q?tR/l29jeGBh52JY1mSrA/Hmu9SrJFiXi/RQCHQgoshXj4C7s3WA/IzHjdwpZ?=
 =?us-ascii?Q?kHarRVHWp8IlbvwpQdZHhQx341rGR4+tzDRwkO34rS+r4n3H7al7gFzbRzKd?=
 =?us-ascii?Q?TGAQLiEs1q0+FXiL7vRJtem/mLXs9AY4v+jeM63cRVfL3Ag2ROYNo08boqI7?=
 =?us-ascii?Q?kCWRt0zs+SYBNAm8jKIJIKHBqrNgC/L9Bz7e1ajk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c75b9e-0e2b-4be4-ecaf-08dc2cc7559b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:09:42.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsEf+yvIBbAEdsHio9LtuJOTYwv8U7ap+ZPgYDT3IocoPdTUXcr7nirKNJo3dyfZ1sSFGPRAnO1hkepzPg5drg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

On 13.02.24 10:40:07, Dan Williams wrote:
> Robert Richter wrote:
> > Dan,
> > 
> > On 09.02.24 12:22:01, Dan Williams wrote:
> > > Robert Richter wrote:
> > 
> > > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > > index 569354a5536f..3a36a2f0c94f 100644
> > > > --- a/drivers/cxl/core/pci.c
> > > > +++ b/drivers/cxl/core/pci.c
> > > > @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> > > >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> > > >  		struct device *cxld_dev;
> > > >  
> > > > +		/*
> > > > +		 * Handle zero-based hardware addresses
> > > > +		 */
> > > > +		if (!info->dvsec_range[i].start &&
> > > > +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> > > > +		    info->dvsec_range[i].end) {
> > > > +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> > > > +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> > > > +			allowed++;
> > > > +			continue;
> > > > +		}
> > > > +
> > > 
> > > I am not comfortable with this. It should be checking a platform
> > > specific quirk, or similar for the possibility of HPA != SPA. The
> > > entirety of the Linux CXL subsystem is built on the assumption that HPA
> > > == SPA, and if a platform wants to inject an offset between those Linux
> > > needs some way to enumerate that it is running in that new world. Yes,
> > > nothing in the CXL specification precludes HPA != SPA, but Linux has
> > > long since shipped the opposite assumption.
> > 
> > this check prevents the memory from disabling an enabled decoder. So it
> > just keeps everything as it comes out of firmware.
> > 
> > Can you explain the motivation why active memory is disabled?
> 
> It is a sanity check that Linux is operating in a CXL world that it
> understands. The fundamental assumption is that the CFMWS correctly
> conveys the CXL space, and that the HW decoder resources match platform
> expectations match Linux resource management.

It would be sane to just not use CXL if assumptions on it are not
valid and not to break system to boot.

> 
> > This may take system memory offline and could lead to a kernel hang.
> 
> Yes, that is not an unreasonable result when Linux fundamental
> assumptions are violated.

BUG_ON(fw_table_broken)? If at all, it is not mandatory to have a
CFMWS. Btw, the check is more strict and also checks memory
attributes. It is very likely something can break.

> 
> > The same could happen if the CEDT is broken or just missing (it is not
> > mandatory for 1.1). Such systems just die when booting. So the check
> > to take memory offline should be changed in a way that it will be safe
> > to disable it.
> > 
> > A platform check would fix that only for certain systems.
> 
> I am not worried about platforms that accidentally break the CEDT, those
> mistakes are typically caught pre-production. Otherwise, if the platform
> is designed to break assumptions then Linux needs explicit enabling for
> the address translation sitting between the endpoint and the platform
> address map.

As said, if assumptions break, just let cxl init fail.

Decoders should just be disabled if the address mapping is invalid.
There is no point to tear down the system.

A platform check is fine to me, but in the end this looks like a
whitelist to let systems boot.

Thanks,

-Robert

