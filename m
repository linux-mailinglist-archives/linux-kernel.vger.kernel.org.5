Return-Path: <linux-kernel+bounces-80094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79922862AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D31B20F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6CA134B0;
	Sun, 25 Feb 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aY7FM++E"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB014A81;
	Sun, 25 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708870904; cv=fail; b=QROqTV0yYgKwMhSaDjVlQBQZSvyTRpSYceVaXj/hLoAwSHqlIZHKSbVwuDJuLnnvYeB2kKC+fV/YY6CchF1+sPm+WA6C4KWykE/eGLhR4wwmOisQaxJECgZbOIAbCnI5Fxgi7NxSl720GZK62pR29xpQ1AUyX+bK3PIXSth0SdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708870904; c=relaxed/simple;
	bh=yp0Y5Svf6MXdHB6BEJNaAsC5OSpRWKqGkadPnCh25tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OnOyMayYOUqYHF+iAyH2ovYnbCC6ql4k9OSJX2ZWpqxhkweT2lsYmDe5idMVe/rludD3EPAXFa0v4lZrdWhGKZcCamV6bKW6a/hon5qGqa3hsoNA004rs8N9ZkEydqqHXCYaaItUSMU9wCiPpKvuCWXGi6dW/5aCmUa+uL/eg7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aY7FM++E; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgWAXTsguL0NTFj6f1yqqcdEndfowXOxcX7vNTgx3B5E80m0KkQjnHtO4qJ6VTGEjR4qu3iq41Ua9dzw0Zex8tjf3BX4PklggHDfu49CHh4FxgVc5k9vrPwzKgFzDd7f1WbVpWR5ZwdQtHe0u0t1stWlrR2Krz02KWk1wlzma7eFembCF9MOu4ckexByWDUp/ce3vqGgh+ckC5jbX39IaYvvUC9D3K5tQq64+agQzhtSOeA52wecMVc95C84VGdcY0HlLn9rl0d8cS0NIRwHimNcYvCG25zzYwGUbBpRPhl2KnytmTLlytY10u5EWjUs57PAFGupTfLOGVnXnZeR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVU9HODqslZjHxPtCElUGFAixYE1eu1W7XRSTYSHvBg=;
 b=cxPfCUEZduoT9W4IkuVHmgfLgPFxRgksUKiyCIV0sRdFaHvBuJfyWC+I0AFlKCHix3Dctbe4ayMFWIwvmdGBfIRfk76CKW2szsXRJLjWKad7TVswiqmGXV36dmYveLtIVNQqJ3bnGq7BgVkUF0R/lIIsSKEmTo2WD9yC0nmCf92kbUck1ND3UpMGl1/HAEjB0WgbWbzxttj5lN1K3BaRiXQInyFgl4FnHDm8W4VtmAljkF6SbPa33uhcLA+oleHOa1wmeXiqP4vXg6+uzo/3DizGnjli9L389789RmrkL0/GGhonNVy6ED2mYjPslvzFR18fMobV94Z+u+e2AIynnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVU9HODqslZjHxPtCElUGFAixYE1eu1W7XRSTYSHvBg=;
 b=aY7FM++Eu1wZFDIZG8MObpavzPlrCTPALgGrL5/y+I/sU1WhhXrg9n7l12kwkbGSk5Z28+4yNQW/Br932yUSLjDo4uf3fR+BiyDKhWC2AUwwyQoLWoV+eg8+p2W+yWIq4oqlD619fA6e2ITQa8Su29oYgRaWdmBTTn3H4myZu+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Sun, 25 Feb
 2024 14:21:37 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.031; Sun, 25 Feb 2024
 14:21:36 +0000
Date: Sun, 25 Feb 2024 15:21:29 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH v4 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <ZdtM6UJM733qAukn@rric.localdomain>
References: <20240216155844.406996-1-rrichter@amd.com>
 <20240216155844.406996-3-rrichter@amd.com>
 <20240219125059.0000737c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219125059.0000737c@Huawei.com>
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To IA0PR12MB8746.namprd12.prod.outlook.com
 (2603:10b6:208:490::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: bed342b6-6d79-4086-a183-08dc360d128d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SRvnxr1MtzoJeWrqXxVjJx2zyqm8h+xzO6cOMFbEPF1hcypkVV+9AXDHLg0eLQSkmxfs/9MNfFOGSOivwR3N+Tx3L57rk1TJxbTCwKpGlD7jUz7O9mSLQbykQ7IrJTn6HIM+qFYnrLvKx9LFsJGsTbHfOX3W1zu9yPgXbSC8H2Bys+mFB+6xabGYJ91CK3V5qTm5XwSieeZ0j3F/Zo3pDKN+H5MKIXtkoiE3IlfJ7im8FngmSURm4vT4bRTn7YMjDjJq/t5zjRCDEPx+WqdxqZthW8t9MnxuMbc0eR9b7b9ft+dmbMfTncG/5z+niTHfJMPRSkQi3vn00JxvLPmLbtQDhSVNBdC2SIipAaSbI6PabYVkR7tZdvtLluN2UFDhixGIA/Qyb1ekLp83rdHsBjjaCbEZjdszS6cMvecPns2SVZuWECjSSZ7vX8swAZRHpfZKjLdYpWdAgJUvQ4xjL6qpElNXT+9Tg/Rr2tHkUy72MQRmk685kL3pp+YnVXvDx+R4LyN9nE+mBRZ5CYqpDaGqK/13neOaQ8JcMGYOYC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaYsqFGsEO9KxwK9DEuRPWGLBC7Ns/VSVxOCF4mFqgVED6+3A/xjPhohfrSQ?=
 =?us-ascii?Q?BcxOdvTpz6ojPgnXOBIBXsuv8skSofMSPZydu/Xfxd6IdGoTDlC50YZtTyt/?=
 =?us-ascii?Q?I1WEKrOZWWn2KoecvUedUMLA2g909esZndN1vdqsZ7udGyI1gr7RQ9LSfDrm?=
 =?us-ascii?Q?GnfT0hozaIx0kXoMwaenW0RarHyLPbQp94fr/EpjgmJd0g3f3KHAdayznNOC?=
 =?us-ascii?Q?KlizaeH5y2/I5w/iEjX2nnGnxw1VEtfQ/Slg/vwpSe2Lf3cgXyPpKGO78kEB?=
 =?us-ascii?Q?Edhm330YLEgxwDoe8F7nYJygvG7d1ztotkB+X7pHl8EFRSDb6kQ4HDG9YNsc?=
 =?us-ascii?Q?xunrEixj/OlAWUGwRuoch+J7kCniHD4M6MR/3IYIpR5+n9WW8TSbRWqU8yUT?=
 =?us-ascii?Q?wSIEVZBeo/AmfLoU5OLJ/TR/jjRH2LxRPWd4F549Gt0wePM8bKbx7kfwe0DQ?=
 =?us-ascii?Q?aBkjjbjqnyVB2UxXcm5gW+20I2uDDZzLEakU4PbgxqZljAQ4be2r6m8e43HU?=
 =?us-ascii?Q?H6nzNHjijpRE263cUYbQWLfdUn49T5P0K/1lJLrgOGzUjS4KJCekXAFUdHA8?=
 =?us-ascii?Q?FoqFoRiILm2+R/nFGC0n5TNMdLJ4l2rV0vKtzszEzOS8N1wRvbrCzo9T3xFX?=
 =?us-ascii?Q?jM9foUhqy2yTMxTMbFigwpoWGOyAsmlwz93URoUnGin0xNbL4+u1XTbFT6sH?=
 =?us-ascii?Q?01+ts+OlTL9WKrvh3yE4oh/LaukxMlIjk/r5oG7AP3Qt0JjqEK51imvBULFl?=
 =?us-ascii?Q?4hY0P9BMzjSObBCflJ3M1XYgp+ZemaauSoYLEABatPGhdqddEmTP4qXy7sml?=
 =?us-ascii?Q?vr+/qFB/Y9UsVVvM/KAKgxfFlJi96QcI6RgXxB6lleJftgeqhK9rKxzjdhdX?=
 =?us-ascii?Q?ieq+PC4UcRIwG9GyLnU9BY/ilhI6OrTq26K2Jk1P1rZxmEvoVmRrfMn/6f3O?=
 =?us-ascii?Q?7WxxSABFMmuej5/zHYtXSZ7rfI+leR4WDDOTKeKlxxPTIX00POjk5L7A392p?=
 =?us-ascii?Q?WavDN+eOH6AHLwMtMbO5Nx45bXLBlcBVxWC3aCiSSJbh2hpLWmc0udstbao0?=
 =?us-ascii?Q?JAUizTCHH/4s1zrUSZNI01nR7ZVVrOi6RjZtRsyk8GxqmL0vpBSJlKExkrDe?=
 =?us-ascii?Q?F0jWcweW07qqPYwbQsEHBn3q5OLE4rWTWpXpyWJ18kpUH4VPMc93hmQydx02?=
 =?us-ascii?Q?/nrCJp73ifvn/xS3FiPBVNjATXz/O0+LmKdLnIZpoLY04W4TR6gP3bXh5YZr?=
 =?us-ascii?Q?G3zOfro1uKa9I4w2ibwbKBzPdd81e84uft9kqOwttN+FQFuxUrDj97JfpGNd?=
 =?us-ascii?Q?YOYpchnTKy8cAY3korMAw7pnEuxUyJWqIuE1BT9ZqpUX/m+S1k1n6+V8syWO?=
 =?us-ascii?Q?Z1iS5A9qcq+3xsgmvuxsZ+hml6aN7zS6dCsyiZgQzxp20IXZjAW6KJHajSXm?=
 =?us-ascii?Q?czcQLPWm/cKvSZE2w1H8ENCIkMY4L/ul80giUkTsIlV3p0aCBJ1GpRsPtGtg?=
 =?us-ascii?Q?rjVrT+omQW3Ork/m3CT+ii7HpV7oVrZls6gCT7OsZgL6Fo2gKojtWced7RVZ?=
 =?us-ascii?Q?LuwqrISEOix7AV9Ki18=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed342b6-6d79-4086-a183-08dc360d128d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 14:21:36.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDubTbRmmJtDOi4ShmbVSO5cIyiJ45b0rWC26Z2YISEkNmrWYNUyrcGWGFCi2lbYkIMriVnX68unaFsDvIQ1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371

On 19.02.24 12:50:59, Jonathan Cameron wrote:
> On Fri, 16 Feb 2024 16:58:43 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Reading the CDAT table using DOE requires a Table Access Response
> > Header in addition to the CDAT entry. In current implementation this
> > has caused offsets with sizeof(__le32) to the actual buffers. This led
> > to hardly readable code and even bugs. E.g., see fix of devm_kfree()
> > in read_cdat_data():
> > 
> >  c65efe3685f5 cxl/cdat: Free correct buffer on checksum error
> > 
> > Rework code to avoid calculations with sizeof(__le32). Introduce
> > struct cdat_doe_rsp for this which contains the Table Access Response
> > Header and a variable payload size for various data structures
> > afterwards to access the CDAT table and its CDAT Data Structures
> > without recalculating buffer offsets.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Fan Ni <nifan.cxl@gmail.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> Ok. I suspect we could fine tune this for ever but changes here look good
> enough to me and definitely nicer than the original ;)
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for your review of this series and also the v5 update for patch
#3.

-Robert

