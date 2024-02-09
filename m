Return-Path: <linux-kernel+bounces-59112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A784F167
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB59028AF77
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDE657B6;
	Fri,  9 Feb 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sgLaDmZI"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984887F6;
	Fri,  9 Feb 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467706; cv=fail; b=eCfWzzFEMeZRLY43FNcIA3aVkHR5P9P6LTJnd+B8+ldDjLAYJSu3xopcYUd9RerKp1H+VTXSQC5m0otFst4/HxoJBUxDkGB1Jd14FGlqFVVbmhNDJmnlhhFGpknuS1E48XMxChK104iSnz0dr6tnBJ7+tchK9TL2y9u7O0KVyzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467706; c=relaxed/simple;
	bh=iBiQDyiyvS4kzLvmek8t2UgYtjADeMlM6q+w9Vx5Sd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzNvX/++xyFCHj/AdVzfdeIByNAPWJpqK3Y5qEJ8BdmFMiBabdZ2DvgSmy7eaBHk+sR0ncFmD0fgxCr81kGf4AEwIn/wbj1T0eqhkZFDv9NCSGg8g1UwWWd0zpzBETZ+Bpg4DKoVW/oVSaXRSYtYQBCSOQFEq9PEqJAg9fSs5sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sgLaDmZI; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssju5JPU4WDWh4Uj7Tq7LNMy0HfNzojP1MQNWGgbUBtqIfhkgvEAssEfwN2ffhLofAHZHfJrhv7pt9qQMQQ1F46hUCmcpKjMepRGFJU3hzALxST7uf71k6LcbX3XYgo3TNmGnxokC7/2ycvBA6XHtViJ6cQuKUUVmH0FFUbHlc+ruLHs8Ks3bXJlMAFyGc7fUHIDUdHtB96z52J6y+vSL7CEfxOkd+PsKvM2SIgVQ44PijDAdmYTrfhQoMOKpWaf2DqohJlCBlBQqYbGYO1YK58W6btr1ehnE1eh1jywiB9iQw2AoHkZxAWm05J0D2oCJlT59A15r6IE7KQO0048ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpiLSa7UjL4/i6ZdluOsxoULuWbewSQ20SovM6wvSrM=;
 b=DNISI7NvPgne/POzc5OoiW6iYm30iSw8IkaernNQnf2xeATgZIylL1vNGUBVLENH4CthFhUxjy21HbRsk5hD+zrgXkEjn0K9dHMpj5RBMWHo55oaFgA0ZgeBmdrkb4Y4hLBOOsUkU2XGZJ0a2Phn3Snw9h1/vjv8cawTTh1dxA3ICtYaFhC/bTuVfpv1+ATRVkSaLn4u6q8TyHPBWii9ir2mVkdcFCaaKVcE/CJEzvTbJDSlJsvZ+7SXEjSLBZWx01KTx+CHkDg4JsOMtz/4ZxyJWiHB+3sOK4c22E+0XttRR1o4JdFdv8v6C9hrEkIsbOo/4dYSE/CFIEVJlRPh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpiLSa7UjL4/i6ZdluOsxoULuWbewSQ20SovM6wvSrM=;
 b=sgLaDmZIPYt8dYZPRF8+FeJEFkK/lyP27eMndqr8tdbB7Dvlct2zO3yhBgo6Zp4xvfJXC5kqfPKSe+KztwV8+3lPhbf61ez45wVVJTtsLeQI2uuN4Q5aAQsBbfwaakAbaUi7mCm0vU6JkifLB+1fY50J6iClaShmV0NcS4hh/hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Fri, 9 Feb
 2024 08:35:02 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::fe6d:7a67:3692:7d49]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::fe6d:7a67:3692:7d49%6]) with mapi id 15.20.7270.015; Fri, 9 Feb 2024
 08:35:02 +0000
Date: Fri, 9 Feb 2024 09:34:55 +0100
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
Subject: Re: [PATCH v2 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <ZcXjr7q-V_djYhdV@rric.localdomain>
References: <20240108114833.241710-1-rrichter@amd.com>
 <20240108114833.241710-3-rrichter@amd.com>
 <20240126164222.000022b7@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126164222.000022b7@Huawei.com>
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 61343182-b85f-4591-9a88-08dc294a0208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oY3pELiiULbMOLfI1/3dvi10+3nF8uz4+MG5ALQd7BXbo9ZiewNseEtRVYEDRL2pVHPE3yxHyTQWLvWWpp0I/WFuU3eyl6xRCURQAaqBbN8hHvs3b4KLntT0CBmrxVoJ1IsRwOkZ+dHIjVcItkC1vzAXImMK/ggK63dB6GvGQ3w+TbofMNkFtqxXZvWB6EtMfhwK8BRMzLSFZwFqQpSvJ8+wg8hMQcc2tgi5Q+2hW6klW2UfV7HNlLjYYOb5UQRE+PNPsntHoxTe5MEs6ojfqqZVawyyeANPYwATh9eLqP1njOmexMbs3SQ5aFSwrRyKUnsKLgSZn2tTXxBuaOS9QQ4iEGk8Huqs97bAAJVxj72nCFaI5NWhGEIATPI1V+ASuQOYkxOOlUDz/7VVF3+49bYcATw3oavu++B9PHDNKxd7wfq46lN6GQvTXZDTUhUHJKe/QcVxbGo2I9T6SGcQPTUbQJBSwRONt7VGKfREqjUv+/hNRqnbfsuUFeUDwUL3W4lr22g8kcSHxG1QNpg1pAWRZOOVEuxuGV/j1WGV8dI+5pXj+fk+oxliXlEzTisG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66899024)(66556008)(38100700002)(478600001)(54906003)(6666004)(316002)(9686003)(6486002)(6512007)(53546011)(7416002)(6506007)(4326008)(5660300002)(2906002)(66476007)(66946007)(8676002)(8936002)(26005)(83380400001)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iqyxu6v7JSU/IM09KufkxQhes1HYgRoUWzZ2g42K66zLwveG9e2DyS+Wrn1t?=
 =?us-ascii?Q?dM0o9vMhS3ewT4QkvrrAZ6N2lcK46MH5FzNQo475yD3hHyht4infE/ZGHgto?=
 =?us-ascii?Q?jjV4es15BeFwijjiocd7SpurWrGxlOZK9EI7/RNDdYO5gcWSUHMdcKfzq8NG?=
 =?us-ascii?Q?ALPvA8HOlRz928Wn7yAWQb6QKNIGKFqzjM7Xjuz7xU22aUyVs5ah94R6dX9l?=
 =?us-ascii?Q?DhboTtUeBteMfEY2+QjQe2lAtzCWHTrfXN/2YQWQz435u3wRz2Fm8x/qVwtX?=
 =?us-ascii?Q?SxqUC0Nmmo2Ba8Oar1EfN7wh01s+dvLuy0ZDC2txhXbN31pLyD5D26RkmoRg?=
 =?us-ascii?Q?W0wPjbPG6G/m9aN5l/PcCnTP8z3WqBL3P0W0JPMlyr0T1556hb/k8uVgSm3P?=
 =?us-ascii?Q?yFGkPpHRdSBlF6dU3x/o1L7+e8i10CE+jjNVNniYwFIPCtbtEJNR9DAlylyN?=
 =?us-ascii?Q?RWV6qvKni+Ki8TihgJ4bzg+Y0LJqyRqwG7xHUwdpHT2FN1GaCzZe7q9xXe3B?=
 =?us-ascii?Q?lwC185rdfWPDp4L922DK8kFihsaq16BVUu7zBDRdgHHyklqov2eRCnI9c4RH?=
 =?us-ascii?Q?AnLR+QBDFuDo7c8AYocSwK5brbWMXNkUIut1waV8MVcVAyfL9UDzQXjBvq52?=
 =?us-ascii?Q?zMkT7MQTCAbfVKCH32w9QCbU7iy//VEqgBf+31E+KHo244foUUAJWVvWNWPM?=
 =?us-ascii?Q?75PFA28gKCkXqzvP93nNKtdSuqMsdX5H/fyFoTFNnAEIy6/6ySr8mFEmhw5R?=
 =?us-ascii?Q?6QZhqWLZ+rPKoXM1YAAQnXLgoP/eAlx+RyCmk319EEzC+P4BPNJwaFibbYHC?=
 =?us-ascii?Q?jzaq81242bR3SZb942aVdMJuRYHmc6/adj9ym9454OuLmShzj5gE7iLjSm0q?=
 =?us-ascii?Q?z/WPH3gFzKsYSIYCsGurIs2JZceVFLjKPJ8xFqlZtKILMDzHt33pvu4LzdCD?=
 =?us-ascii?Q?wXcBnHmM6XdXsa44HJ+zTbyjBfISIcU4Edhc8MIS5hR6ApkSYc64S5Q4varE?=
 =?us-ascii?Q?GvApimFoYp66WC4dAJXGwEkMf1pgreu7IsYrs6w8dpyXi/UALyrmVwCxP/oE?=
 =?us-ascii?Q?/EjpXQAYMtnNDPvMc+G6Edgrlyf0oPsIdSeMwN4jtZYVy4LAbR2EI7GszFpG?=
 =?us-ascii?Q?sRT3XoLV2mZF8oCRyWqfOIDZrqU/t2POoHWM9cI7PMRnseAkpuAOsPgiP80V?=
 =?us-ascii?Q?Dt2pwhOVs3HbNn3BHqKsdSeqTBx6Sx3ZCY1g8YdV6x0zx3/eV2hsnhMINoFO?=
 =?us-ascii?Q?btXPMVvtELtDPrZQx6/mkeppiyW+0aRAsmYw1WUdDSqdqwe2cgcYqUqsb2yK?=
 =?us-ascii?Q?TFAmBaNEkvTTyRUEjAIzGMdZ9vkKairTB5PNQisYB9JnZuiTm+7L7Ma1LW03?=
 =?us-ascii?Q?RCArns+9FdoGjZquUukZvgMx/WEdHFzoryC97Ak+u0lK2Sqd/yOL83Nt5U6y?=
 =?us-ascii?Q?W/ZMA7pssmuyzwM/+KBF6yoQuMYJ2040KCVsowgQ3ZY0ELG/NqZl8i1SFi/D?=
 =?us-ascii?Q?UFUWDUIxnealudxnpzVMDZxHDKT+pfNMiIcGOH9sjOn/+X5EVLP7j5NqLH+2?=
 =?us-ascii?Q?apb25WlJ2GWgZWc1Immd5I2gxYhVMcYI/c06KcOu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61343182-b85f-4591-9a88-08dc294a0208
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:35:02.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7oUovZjBtYD7Sm4JcfMdDFZYEi7WEg3vaA927NMQoGkqxtevRzdRfqtC5CmGMF0tMEeho+X0+FskZUWsH/FQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

Hi Jonathan,

On 26.01.24 16:42:22, Jonathan Cameron wrote:
> On Mon, 8 Jan 2024 12:48:32 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Reading the CDAT table using DOE requires a Table Access Response
> > Header in addition to the CDAT entry. In current implementation this
> > has caused offsets with sizeof(__le32) to the actual buffers. This led
> > to hardly readable code and even bugs (see fix of devm_kfree() in
> > read_cdat_data()).
> 
> Hi Robert,
> 
> Referring to a fix in this patch set or one in another patch?
> If it's another patch a cross reference would be good. If it's in
> here this should have a fixes tag.

No, it is already fixed, see:

 c65efe3685f5 cxl/cdat: Free correct buffer on checksum error

I will update the patch description.

> 
> > 
> > Rework code to avoid calculations with sizeof(__le32). Introduce
> > struct cdat_doe for this which contains the Table Access Response
> > Header and a variable payload size for various data structures
> > afterwards to access the CDAT table and its CDAT Data Structures
> > without recalculating buffer offsets.
> 
> Comments inline, but I don't like using variable element arrays when
> we know that they are of size 1 but then rely on their minimum in
> the code being size 0.  Better I think to make it explicit that there
> is one of each and use more complex offsetof() handling that doesn't
> give the impression the number of elements varies.

I have an update in place that addresses this, will send a v3.

> 
> 
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Fan Ni <nifan.cxl@gmail.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 67 +++++++++++++++++++++---------------------
> >  drivers/cxl/cxlpci.h   | 19 ++++++++++++
> >  2 files changed, 53 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 89bab00bb291..75d8fa228879 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -544,55 +544,53 @@ static int cxl_cdat_get_length(struct device *dev,
> >  
> >  static int cxl_cdat_read_table(struct device *dev,
> >  			       struct pci_doe_mb *doe_mb,
> > -			       void *cdat_table, size_t *cdat_length)
> > +			       struct cdat_doe_rsp *rsp, size_t *length)
> >  {
> > -	size_t length = *cdat_length + sizeof(__le32);
> > -	__le32 *data = cdat_table;
> > +	size_t received, remaining = *length;
> >  	int entry_handle = 0;
> >  	__le32 saved_dw = 0;
> >  
> >  	do {
> >  		__le32 request = CDAT_DOE_REQ(entry_handle);
> > -		struct cdat_entry_header *entry;
> > -		size_t entry_dw;
> >  		int rc;
> >  
> >  		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
> >  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> >  			     &request, sizeof(request),
> > -			     data, length);
> > +			     rsp, sizeof(*rsp) + remaining);
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE failed: %d", rc);
> >  			return rc;
> >  		}
> >  
> > -		/* 1 DW Table Access Response Header + CDAT entry */
> > -		entry = (struct cdat_entry_header *)(data + 1);
> > +		if (rc < sizeof(*rsp))
> > +			return -EIO;
> > +
> > +		received = rc - sizeof(*rsp);
> 
> As mentioned below, I'd rather see this as offsetof() to get
> to a real element in the structure rather that relying on a flex array
> for a known single element array.
> 
> It is still a little messy because the offsetof() variable should be different
> for the cdat header and the entries even though we know they are actually
> in the same place.  
> 
> 		if ((entry_handle == 0) {
> 			received = rc - offsetof(typeof(*rsp), header);
> 			if (received != sizeof(rsp->header))
> 				return -EIO;
> 		} else {
> 			received = rc - offsetof(typeof(*rsp), entry);
> 			if (received < sizeof(rsp->entry) ||
> 			    received != le16_to_cpu(rsp->entry->length))
> 				return -EIO;
> 		}	
> 
> 
> 
> > +
> >  		if ((entry_handle == 0 &&
> > -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> > +		     received != sizeof(rsp->header[0])) ||
> >  		    (entry_handle > 0 &&
> 
> Why are we letting entry_handle go negative anyway?

Will make that unsigned. The check means to be (entry_handle != 0) here.

> 
> 
> > -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> > -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> > +		     (received < sizeof(rsp->entry[0]) ||
> > +		      received != le16_to_cpu(rsp->entry->length))))
> >  			return -EIO;
> >  
> >  		/* Get the CXL table access header entry handle */
> >  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> > -					 le32_to_cpu(data[0]));
> > -		entry_dw = rc / sizeof(__le32);
> > -		/* Skip Header */
> > -		entry_dw -= 1;
> > +					 le32_to_cpu(rsp->doe_header));
> > +
> >  		/*
> >  		 * Table Access Response Header overwrote the last DW of
> >  		 * previous entry, so restore that DW
> >  		 */
> > -		*data = saved_dw;
> > -		length -= entry_dw * sizeof(__le32);
> > -		data += entry_dw;
> > -		saved_dw = *data;
> > +		rsp->doe_header = saved_dw;
> > +		remaining -= received;
> > +		rsp = (void *)rsp + received;
> > +		saved_dw = rsp->doe_header;
> >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> >  
> >  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> > -	*cdat_length -= length - sizeof(__le32);
> > +	*length -= remaining;
> >  
> >  	return 0;
> >  }
> > @@ -620,8 +618,8 @@ void read_cdat_data(struct cxl_port *port)
> >  	struct pci_doe_mb *doe_mb;
> >  	struct pci_dev *pdev = NULL;
> >  	struct cxl_memdev *cxlmd;
> > -	size_t cdat_length;
> > -	void *cdat_table, *cdat_buf;
> > +	struct cdat_doe_rsp *buf;
> > +	size_t length;
> >  	int rc;
> >  
> >  	if (is_cxl_memdev(uport)) {
> > @@ -647,30 +645,33 @@ void read_cdat_data(struct cxl_port *port)
> >  
> >  	port->cdat_available = true;
> >  
> > -	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
> > +	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
> >  		dev_dbg(dev, "No CDAT length\n");
> >  		return;
> >  	}
> >  
> > -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> > -	if (!cdat_buf)
> > -		return;
> > +	/*
> > +	 * The begin of the CDAT buffer needs space for additional 4
> > +	 * bytes for the DOE header. Table data starts afterwards.
> > +	 */
> > +	buf = devm_kzalloc(dev, sizeof(*buf) + length, GFP_KERNEL);
> 
> with below suggestion this would need to use offsetof(... table)
> which isn't hugely obvious but there is definitely a trade off to be
> figured out somewhere and I think this is less painful than implying
> a variable number of entries etc.
> 
> The implied structure of the data here is also disagreeing with below as
> I believe it's
> 
> struct {
> 	u32 doe_header;
> 	struct cdat_header cdat_table_header;
> 	struct cdat_entry entries[];
> }
> Which is not implied by the type you have below.
> 
> Hmm. I wonder if we should play games in the inner loop to avoid having
> that outer stray DWord here.
> 
> Something like.
> 
> 1. Assume that there is at least one CDAT entry of 4 bytes or more
>    (seems reasonable).
> 2. Allocate the correct length and nothing more. Pass that into
>    cxl_cdat_read_table()
> 3. Read the DOE header + the CDAT Header into that buffer.
> 4. Memmove result -4 bytes to drop the DOE header.
> 5. Rest as before complete with the stashing of the final DW
>    each time so we can put it back when the next loop overwrites
>    it by accident.
> 
> Your structure is still useful for within the function, but not
> out here where it represents completely the wrong data layout.
> Here we just want the raw CDAT table anyway so represent it
> as u8 data[]; is fine as no odd offsets to deal with.

See my update I will send, it will be very simple and avoids zero
sized arrays.

Thanks for review, that will improve v3.

-Robert

> 
> 
> Jonathan
> 
> 
> 
> 
> 
> 
> > +	if (!buf)
> > +		goto err;
> >  
> > -	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
> > +	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
> >  	if (rc)
> >  		goto err;
> >  
> > -	cdat_table = cdat_buf + sizeof(__le32);
> > -	if (cdat_checksum(cdat_table, cdat_length))
> > +	if (cdat_checksum(buf->table, length))
> >  		goto err;
> >  
> > -	port->cdat.table = cdat_table;
> > -	port->cdat.length = cdat_length;
> > -	return;
> > +	port->cdat.table = buf->table;
> > +	port->cdat.length = length;
> >  
> > +	return;
> >  err:
> >  	/* Don't leave table data allocated on error */
> > -	devm_kfree(dev, cdat_buf);
> > +	devm_kfree(dev, buf);
> >  	dev_err(dev, "Failed to read/validate CDAT.\n");
> >  }
> >  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 711b05d9a370..b40c571b2ab2 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -85,6 +85,25 @@ struct cdat_entry_header {
> >  	__le16 length;
> >  } __packed;
> >  
> > +/*
> > + * Response contains the CDAT only response header of the DOE. The
> > + * response payload is a CDAT structure (either CDAT header or entry),
> > + * it may also mark the beginning of the CDAT table.
> > + *
> > + * Spec refs:
> > + *
> > + * CXL 3.1 Table 8-14: Read Entry Response
> > + * CDAT Specification 1.03: 2 CDAT Data Structures
> > + */
> > +struct cdat_doe_rsp {
> > +	__le32 doe_header;
> > +	union {
> > +		DECLARE_FLEX_ARRAY(u8, table);
> > +		DECLARE_FLEX_ARRAY(struct cdat_header, header);
> > +		DECLARE_FLEX_ARRAY(struct cdat_entry_header, entry);
> 
> I'm not understanding why these last two are flex arrays...
> Each DOE resp only includes either 1 cdat_header or 1 cdat_entry_header
> For table fair enough.
> 
> If you want a general response I think it needs to be something like
> 
> struct cdat_doe_rsp {
> 	union {
> 		DECLARE_FLEX_ARRAY(u8, table);
> 		struct cdat_header header;
> 		struct {
> 			struct cdat_entry_header entry;
> 			u8 entry_data[];
> 		};
> 	};
> } __packed;
> 
> That doesn't make it useful for above unless you use
> offsetof() to establish you are really interested in how far in to
> get to the real data.
> 
> 
> > +	};
> > +} __packed;
> > +
> >  /*
> >   * CXL v3.0 6.2.3 Table 6-4
> >   * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> 

