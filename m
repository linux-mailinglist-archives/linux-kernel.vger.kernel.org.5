Return-Path: <linux-kernel+bounces-68558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4385857C57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D9128423F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E9C7868C;
	Fri, 16 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grUmTPQ3"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D577F15;
	Fri, 16 Feb 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085427; cv=fail; b=uGMbH5iU0Q1eSuhlEqoHnY58/nYcBPAwrC4a0OxH3k/0WmIhqg/uaPXajtPK5gdRt1BY6WFSaObQ+Oj25pEIKXnhdbwblY70vkqeyhDLoqTAikzGzox9VuXa+iHfcmbDD0Cb4KIOCI3sJbg7uNIo6DwJNXgidK1Mgf2nkqdf7XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085427; c=relaxed/simple;
	bh=5ayKootdds6E3Ik0/kKnJVL+kJvQbubjgLPYpUHqUeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XWH7Vgf7yDci4i2Ko6hbVan+q4JpGRF1lRyHuRURBuaA9udAxznbXkfKOsRdh3ko6l5jwOBRsrr6NERn/09vh6ZzN9C0wKUC9jjENTrB4Aq4QVBZs2fwQaUaA1nZkkRCuQB+QHRt1489RUokAQeAuDL5MzR9C59JwVD3Y8RY6W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grUmTPQ3; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWWHOyxIvkjQNLLOned3g895BAelbvIJnOFwgtJPlz41AYj0RL1glRVbxkcQZk0JFNU7eqy6siOcIvZl8+Th2TCeEmSL6ygS8ByOptVPd9y7ZXbES8frQevJlIH6nrbMiR9t+ObO7SUz3d5mmskLGjV2KdHrLio48Nhn0R0xUXDl1EOLDpUj/XVsNju4ETmnJsNXsnzS8xMMSPwtgrJ2Yh4dmu/KIcQToar1uN2i+w7jaGioLApsYwtEOp92cJPMiObKvjGpvKriAx5RtbVXIkEWVVAMuQyRCP8TVo4aWuhiNLyTwk1sJMNYqdeg8tBzw2gzf5D6+5UvphNKdRIv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEXXcMdcXNUXB1WvCSPFUsdlNAru8w33PLHAXMVmvQk=;
 b=UZj+L7fP+lIBYMRWrSKj5BpY3Z9yATcYL0EkEGHzA2BDsZBp5HqkjGQTImYTbMO0pkBd1guWPGBarQdUeUCYQoBe3M7Jjrbev5vjBYJEjCmHOyyFvc9B0zwh7gj/FdnKncD59zuygIVGK2Atee7SkhkCWhcPpMsm2O/0eoOwH6I+sUt2JMH/4+ns2j9BMige4rAWAgEr5KKWqTTKWG+EH9jBv+qIrJ5cX4DPj+SKJAUwf9jAZcU2CMS1pWKi2S5O35eqQs64mFgSh6rz4VXqOpPL5E/j9UGUaTR5WodDwooajM2fBIpHtYKrlBMm6jiHo5UH1ui52wMIFD7BMZ/frA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEXXcMdcXNUXB1WvCSPFUsdlNAru8w33PLHAXMVmvQk=;
 b=grUmTPQ3cszX2/VEtM3G0FFozTNKTYNzL+0JTWgCVFJp3mSwDEnRMaGmINTv+85UejiG7+6OqzHND7QEaIVu71HxXoC37sNCFJln3RZTj7dkKpX+tRjlCeslyfeqFL4tPITDLAiYVY8AZ2fVuFhBVh+QzBgqhDyLdFne1GTmI9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 12:10:20 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 12:10:20 +0000
Date: Fri, 16 Feb 2024 13:10:14 +0100
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
Subject: Re: [PATCH v3 2/3] cxl/pci: Get rid of pointer arithmetic reading
 CDAT table
Message-ID: <Zc9QpsNa2kNQsQsR@rric.localdomain>
References: <20240209192647.163042-1-rrichter@amd.com>
 <20240209192647.163042-3-rrichter@amd.com>
 <20240214173158.000005c0@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214173158.000005c0@Huawei.com>
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 48613418-08c0-477b-d23f-08dc2ee83edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UE2C0td+Az1jTEHdmt6Pz5uG2m4qH/YiyLyS4WrdAL4rcgOdt1H+sl1s91Qz7VBEHl5ZA0GcNvudgrq6o90dddviaUxZDGhNte8dTUs7F2EFvRR7fT8/pRNtvndotNPBxKhDe3gBviQ0VzzpQG/Rby4LEenF6gCu85vRctD7upGWowNYkyjhV8FKL+9L29d3gvitRMmNtusn9E5vJq0l4wApnnFDuFwYSA+LDVVjt1altYUZQA6TwgKEIZUdCD6Almcn/Bn47PX5yixfKPbkk3OQdQ8GSIkxrdRM8TuZkQRuroP+zhf/4Cn3+n1ldDAlcq8xZcvxZ67I/xZz3SZAwALMwdHbORyv9DXCwk0woYkyXJqx/isfvb9ItecHiq9hSh7bosZGcZ5cI+ewIv03yvMDH7mm+6T4A+zzbsiOSr+YnCT40sZso6iJP3hZOYvuUFDjFWshi9kwln4Pfz6NOY1wJl2Iv10TqEy6800w5o7JXP706IjdNdQNazCsojZQPKS61+edLoJTnHLVHzlm7kttiYebS/U2gngS4FliS/XXa6FeW0P82WemJ7QFLbFK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66899024)(7416002)(8676002)(66556008)(2906002)(5660300002)(8936002)(4326008)(66946007)(66476007)(41300700001)(83380400001)(54906003)(6916009)(6506007)(53546011)(6666004)(6486002)(38100700002)(316002)(478600001)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZEkLrThcQmYBhKKs9fX3CPaqpUmNCLZDeWNe1Jcc52SXabmGgOagYuGbmmKk?=
 =?us-ascii?Q?qEQCnlULzLRFR7Pc6HAJ0MT5TlAzPh4/cD2asdefDGPTgkBUU1M4A2MOtBY0?=
 =?us-ascii?Q?EWR/1HR8QCvuccjdx7MTFi0yWo81n4VLnF4d3PrVknSsCxlu2NLElqupxiLX?=
 =?us-ascii?Q?a5EWG6yQnnnKtF6EEuAM4PGldsZ8pgME4dHDB/E4jYe7qpdGXYUqbt2YbhO5?=
 =?us-ascii?Q?5/eUse1kJ2ZgcPqZkxAGVfthP51pelk/P/+rU7czT57ExGq128p/gPUtyaRn?=
 =?us-ascii?Q?zYmvGWJyOekL5d4ZkWEetCh9tUMJN9xuJVTAH9OAxryqlZHOmLmLbBUuDzeS?=
 =?us-ascii?Q?aCG1qex3MeanMxV/qRpoozSlczUMorSIZowl4rBrfqKCK3Xya71fI0i2sZXP?=
 =?us-ascii?Q?KKJXGz/2WSBPbCFpSvRqTheuUo8RiECxji3uSef3OCSJKz/XKJ2kws6ire9X?=
 =?us-ascii?Q?/rBphY39oEruQYnl7R1JNpk7nTaQGeR8WJMtBAN3JJXTIVWGRiKV7/rxufQk?=
 =?us-ascii?Q?6IsEKYNWmGXo3BtlVbvmvTNkxfaqL5tOHmYUFqw+UUYgV+k/dspCoxGGHgoT?=
 =?us-ascii?Q?C4uOlMx223ymx9DBLzphkqWtXB7KGnDKju5jBLGb2lGsod3PxttTXY/kayIM?=
 =?us-ascii?Q?J4/gVmCYCfQ1tA9nRuIayAoRhUEWyA0uZ04zyC+JgRhehAn89JzpQGzDEuSM?=
 =?us-ascii?Q?2DrTkPIt74lTPIhQ7FI2K6opUXElxjOVQQvA/CRFRCHKzr/Lubo00Y8tfBqd?=
 =?us-ascii?Q?pF03GIxDC48gESu2k17nOvhncv58nJrfbYcGHkT1dzxxWloBEW4UOwaO3K8w?=
 =?us-ascii?Q?mWKC5ayKHX+p5UDakRu3ZyPlv0OvdFb46huvdMinmXrwSUcY/3tiUMb9JubR?=
 =?us-ascii?Q?O2uHS7L/EXW3Dtv6t7i8iM8CnPGQOCtjURooelM3tkp0IFF/uzPhLX8XWh/K?=
 =?us-ascii?Q?b0spvWSGIzA2FAiDvN/wnttKdpUrnrDEa6LDhM90U+uhdeNaiclfjfN9IEDm?=
 =?us-ascii?Q?W+j+T/4Qb/Z1oVw4kxslGSNy1g2iwUUqQgEq1MUCWDAjMkTBGnAolR523Hn5?=
 =?us-ascii?Q?ZnRdZ6qlzpn43eUeCRSVJYSs34/E3W4n7loT+XTCufaLo75D62AWszu7gZaZ?=
 =?us-ascii?Q?C0+QRVwJhvU7pXtRbtDp6F5JXdsA5WXUMJt1ipvgA7wOac8uef2GzBH0v1uE?=
 =?us-ascii?Q?O5kZAP3261K5P3BCo5HkPDKBgEFsFTiag7XCEhMJzsst3A1sNyfJDmgvfy88?=
 =?us-ascii?Q?9Z6DOyk5EClMLWMb9OcSQiQYnQ6V+6uYeybQ8mfzNhih74M7hHUpNUfRBwCB?=
 =?us-ascii?Q?8KS/q85PK6mWwhll4AFGMnzi7D6FGcDqYv5V+RvjDCoEDj/RVH3AV6bEtYKo?=
 =?us-ascii?Q?0PyToZJpmSEtaCcCCpXlQGKVrwWw6Qnhd4qubzc17IJLghVYUXJg/fQvJWek?=
 =?us-ascii?Q?ZNg+mRq4TNLwZ7Ac2bAdrf873t/3MaZNyvN2PFcCkb0UdbrKDYsv4ebSeKRd?=
 =?us-ascii?Q?1ULkTJY3C018/paqg0f7rGCoQlpTqIxak/g/+Ty/TQp0DPVZNjnpviXqT9FM?=
 =?us-ascii?Q?Vl2MtMG8beMt86K87IR28qGAwRfCQ/tNnPr/AkF2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48613418-08c0-477b-d23f-08dc2ee83edd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 12:10:20.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXja+0wzQKXa8sdHIKDjo3dwsbdHdUL5WjcJxtq/psJi8kQV48qJJmcZCUtpVORXLZQ2GbCOODykb3Z0Hvl+pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

Hi Jonathan,

thanks for your review.

On 14.02.24 17:31:58, Jonathan Cameron wrote:
> On Fri, 9 Feb 2024 20:26:46 +0100
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
> 
> Hi Robert,
> 
> I like this in general.  A few comments inline though.
> 
> > ---
> >  drivers/cxl/core/pci.c | 75 ++++++++++++++++++++++--------------------
> >  drivers/cxl/cxlpci.h   | 20 +++++++++++
> >  2 files changed, 59 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 39366ce94985..569354a5536f 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -544,55 +544,55 @@ static int cxl_cdat_get_length(struct device *dev,
> >  
> >  static int cxl_cdat_read_table(struct device *dev,
> >  			       struct pci_doe_mb *doe_mb,
> > -			       void *cdat_table, size_t *cdat_length)
> > +			       struct cdat_doe_rsp *rsp, size_t *length)
> 
> Nitpick, but rsp isn't a response, it's the whole table.
> Maybe it's worth a 
> #define cdat_doe_table cdat_doe_rsp
> or a typedef so the two are different in name at least whilst sharing
> same structure definition?

There is a comment near the kzalloc of buf. I think introducing
another type here for single use will just add confusion.

I will also update the description of cdat_doe_rsp.

> 
> >  {
> > -	size_t length = *cdat_length + sizeof(__le32);
> > -	__le32 *data = cdat_table;
> > -	int entry_handle = 0;
> > +	size_t received, remaining = *length;
> > +	unsigned int entry_handle = 0;
> > +	union cdat_data *data;
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
> 
> I guess it's not really worth using struct_size here.
> It's main advantage is making it clear we are dealing with a
> trailing [] 

Yes, will keep it as is. Since it's a u8 array, count is equal the
size for the remaining data and we do not need struct_size() here.

> 
> >  		if (rc < 0) {
> >  			dev_err(dev, "DOE failed: %d", rc);
> >  			return rc;
> >  		}
> >  
> > -		/* 1 DW Table Access Response Header + CDAT entry */
> > -		entry = (struct cdat_entry_header *)(data + 1);
> > -		if ((entry_handle == 0 &&
> > -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> > -		    (entry_handle > 0 &&
> > -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> > -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> > +		if (rc < sizeof(*rsp))
> > +			return -EIO;
> > +
> > +		data = (void *)rsp->data;
> 
> Nicer to cast to (union cdat_data *) than rely on bounce via a void *

Will change.

> 
> > +		received = rc - sizeof(*rsp);
> > +
> > +		if ((!entry_handle &&
> 
> Prefer == 0 for this because 0 is a magic value here.
> 
> > +		     received != sizeof(data->header)) ||
> > +		    (entry_handle &&
> > +		     (received < sizeof(data->entry) ||
> > +		      received != le16_to_cpu(data->entry.length))))
> >  			return -EIO;
> 
> Given it's two rather involved conditions maybe better to do.
> 
> 		if (entry_handle == 0) {
> 			if (received != sizeof(data->header)
> 				return -EIO;
> 		} else {
> 			if (received < sizeof(data->entry) ||
> 			    received != le16_to_cpu(data->entry.length))
> 				return -EIO;
> 		}
> 
> More code but easier to see the header vs entry checks.
> Could even define a little utility function / macro.
> 
> 		cdat_is_head_handle(val) entry_handle == 0
> so you get somewhat more self documenting code.
> 
> 		if (cdat_is_head_handle(entry_handle)) {
> 		} else {
> 		}

I will take this but without the macro.

> 
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
> 
> I'm not keen on this looking like we are writing the doe header
> as we are writing the tail of the last response.
> 
> Maybe the comment is enough.  I don't have a better idea on how
> to make this more obvious.

I think the comment is good enough here.

> 
> > +		remaining -= received;
> > +		rsp = (void *)rsp + received;
> 
> Was a potential problem with previous code, but this could
> in theory become unaligned and we should be using unaligned accessors
> for it as a result, or maybe adding a check that it doesn't ever become so.
> The check is probably the easier path given CDAT entries are thankfully
> (I think) all dword multiples as are the two headers.

Yes, buffers are dwords. In any case, pci_doe_recv_resp() is safe to
be used unaligned anyway.

Thanks for your review, will prepare a v4.

-Robert

> 
> > +		saved_dw = rsp->doe_header;
> >  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> >  
> >  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> > -	*cdat_length -= length - sizeof(__le32);
> > +	*length -= remaining;
> >  
> >  	return 0;
> >  }
> 
> 

