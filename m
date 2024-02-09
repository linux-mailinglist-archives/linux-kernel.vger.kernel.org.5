Return-Path: <linux-kernel+bounces-59289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83E84F48D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8841EB25A88
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366A2C6A7;
	Fri,  9 Feb 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4tXsv0F"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19520334;
	Fri,  9 Feb 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477831; cv=fail; b=cVe6Stdwm3WHnamS1ENBx68sX6KE0AEV8r4PVlwf9jthZI2mB2CJxJKPXqD4K6SA2M1+EZ67mvV8CbayJ9W5yZy5qRsJaD11vJOkmHL9ZohGY924YBIeDEPswAZf2/Eaf8nZ1Lyw70GfGpNFcisSRetBVbqJ0YnhOB/LqOscN/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477831; c=relaxed/simple;
	bh=U+iRoPookFEAoSxdyiW9DPYY3fZlhtcUlvHvm1Y7hS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/sPlUoudKOUxkWJOygFtF6RbK5oARqvNXNQfvedDsP/hWpY/CT9vyvRuIyhCUizac6iePxQmm+EQ8swtdoqKr8lwyJ/mVnheOb5r7YGOYN3JJcD12t9tKwFC8OST1OgnG/Wrsr0p4/ZfzUK3nARrMPjXQ7vriqujo7u3jQxY2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i4tXsv0F; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqVtgExxJn9igPCjFW7XP5JOmGs4p/OiD39HmvuXHIlH4G6L0x/oq3aLY003z6VaPqeZ/L/8rpeCFBkIXjeQQzgooNISc5dPwja7mXkFqf5tWXD8ZghoHzS3XU3UcLzhdmU5dvOxu4EuBO1FQ5KALLCByml5vZwubVi73pXd7d6wzS3yFvYRWgwRNeR0zfVmt0GpTePJhmVOIO9TmGsf0GD8Mk4oZUVCXSyDijCUEVgSjCvPGbm9a4uUjD9WRRu3vSN+7p0pg5zKpR+PogzurxkGKF2HBmwkRT2+ODHZ9sXsFJizBt+yIo0Y33F4tSGwavWG8SXW2rmVvtRvAgOVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r84iCx8MvRbHms2azQFvn+Jc4ckLegaflOZJyiQvXtU=;
 b=SdWOx1vQLjHV/tUJXBfEL/HDQLgoibNL2s9PTxX6QSn6EBtSNAJuNPxsLI6ooxHP8geJaec/goR0NFox2EboVdaHBGAXu9Lx5grNmqZ/ehgqAemlIQl82RxOWBCupd80+cMFNymQ9K12NFQraxE1C0bS1FnbHwph+kZ3MjhGjwUytBAvhuzq+kfQZZjG+1sMhbTaAY24PJymOmgHoKIPbMHLl7QrRqjQRGy5lZgLF0AuSk7rxYxxa9ZB9ZtjJfNB1Ih443VojOnKQ4IWzpdoknt3h8IoUWYeoKLKcHTLJJuRD5OBtoKEuCmyDs3HZBm5nOW6Tc1+gk9S6WMwUC8pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r84iCx8MvRbHms2azQFvn+Jc4ckLegaflOZJyiQvXtU=;
 b=i4tXsv0FRq43c4W/3z+Qwi6qgNfDxkHnDGY3lPyI+zIByk2cRYj6qfYo7pN3jBtfzFvbIvk5ykE4bBTwr850al8vXpTrdUelmJWJiL1oVoCDKWrgkBzqJbCEbX8MlS/v7tbuufgqjbGy4C5PfggJtXZ+VYVaBNPP40+MRjPWHow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 11:23:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::fe6d:7a67:3692:7d49]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::fe6d:7a67:3692:7d49%6]) with mapi id 15.20.7270.015; Fri, 9 Feb 2024
 11:23:45 +0000
Date: Fri, 9 Feb 2024 12:23:39 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <ZcYLOzd0KUX9ckYo@rric.localdomain>
References: <20240108114833.241710-1-rrichter@amd.com>
 <20240108114833.241710-4-rrichter@amd.com>
 <20240126164603.000040fd@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126164603.000040fd@Huawei.com>
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e0d2d4-a536-48af-3b80-08dc29619421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cy63pJU2V/qh1SokEVK4JH3s81CY0wZnuhFQz804a4FTBCxVYyrZa584vxksvYK+0RokuEUyknu6tQDnMYfdtX4p0NIT9NMsQeAS7wXsaatTa4yf+pHyuRt9QZnKrTvQ+zn93WY1IIH2xLap/JVHOSfcfN8sCnHt9pftrd4m/l5lKxC5lxQn6kc/1VpVkS/gpEmJ3KexLzOoSbXXfoWN+VNOz2eESAxPET3UzY9bmCg/nGHMiDdWi3fzT9B+O0U7zcV8BojyW4Noglf0Y4joomeyvbsKFArjbkRrEpwuHwNvPEySiuqMNQ/eom8Y1aMzJUetbZOH84f/8A3feAPQ113OmZJi42+w+7OWNa8J/WKB5TISOjjfXgE/MiiaR3aybCiSoHBTlEwhdl1Sv7dsJv4z+0/kyAQcZH077xj2zxwK+RgQ2aB8CIdq2eamscErFifN9wh3ZpQ5UIHEoRMn9nMUbwmss95Y0+yyOA5yt2F78Qiy3yQO6tazjQm7lgVtb62NooTTUg5U43UvO4MYVHtNQvttE9IELnkyAHbPSeUlDN3HkaE8LqvLQL6lMFds
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6916009)(83380400001)(6506007)(66556008)(478600001)(6512007)(26005)(38100700002)(316002)(6666004)(6486002)(8936002)(7416002)(8676002)(66476007)(54906003)(4326008)(5660300002)(2906002)(66946007)(41300700001)(53546011)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/77eTQ0ITETxcjXwZO196nqURPKOfFNd/93kn8Ig0ISlR2+sUUTzF55ZVvlJ?=
 =?us-ascii?Q?p9/O9RbMG2lbRb6x+6trL+6kVBbQCtVckJDA05bqIWoWNn58UUlZtl45vczf?=
 =?us-ascii?Q?mb1nmi/2Vkz20C2n6zQR8woorakXjoeSGmqyXOdVYUQWXijFzskvISlurZxq?=
 =?us-ascii?Q?SwvR5NDV/3EsdMbmPHBD9CiuuBQiNNifYrvTLPheGoGuTJJmMdCy9jUlBswo?=
 =?us-ascii?Q?gFvcJshh3cg/u6bBMpQNYeZmD5AP17BxSlqR8Z3dV5JNn8X7+nzNfue22//E?=
 =?us-ascii?Q?e+N3ebiYw0LTMwSu0b4JYzbMK6DG6e0IrVZtEeyxpgERG5ALJJr9YkRfgWUF?=
 =?us-ascii?Q?AdVeux32pshRRkWpQvAqodIK0pDXZrM4ylWNPqWCBiQ271DnpejQALLJVaSE?=
 =?us-ascii?Q?nogoz4r0h6nAWeB9QtQUcPhQ/Tz3H/nOe++CbW2Tnp9kUyM9vrIB/AsD67XQ?=
 =?us-ascii?Q?YjcnEd9Pl04bKt5A/IQnUAB6Z1X/VrwYI45NHsD92BiqVsWFPFy9TcNypWPe?=
 =?us-ascii?Q?T7smMwldIZiwN5elKPWK2c18K7an5kXGGSV6uyj2SnuXC6A44X6qrlHHN/lw?=
 =?us-ascii?Q?Oecrw5+lgFb7OGAe3iVLq+9kyATHY6V7Ea9V0TNDhyrcymZ7TRhMD9YU4OGV?=
 =?us-ascii?Q?btPjHgexCBAkKvSQQs91XuQg0zqP+sH+jUl1bXdYz/g5ENeHRq12OpEChha1?=
 =?us-ascii?Q?xL3k6QGR8ew6tBWyGokLdrvzQ6S6cb2iN0KFK/g1InCUP8oz+xm4h/YnE0zi?=
 =?us-ascii?Q?Uh7Dw/fmBJELuzirnR/Y38VmDNjsnFgJlP5Q0ko2tIi/D6ihfSxz0Gp6y1PH?=
 =?us-ascii?Q?1lFBfD8kmQ/kp83dO/BYzVNWlAFyt6ylQc/p/NMcRX6brvnW9l1THbRyrfBW?=
 =?us-ascii?Q?2kJjoAdEfe+Oqd7PXFDhqjmTfdOh5+kn+pcKKo72Yo887v/i0Df5WeMcSAZo?=
 =?us-ascii?Q?w58asO3bZHu0SFOsPmESws6AHgWTwYt1bCXLOWssNQVP5Esi0ZOQIWlX88Kj?=
 =?us-ascii?Q?VJuhH4N1UDKHp0A2ekRy4Rc+p7WrldgZHC7cl/sm15SzIlhTMW7cFyuF2Am0?=
 =?us-ascii?Q?+ZjwmgM/3OSg+qX6wZUBHYvB1T3OI5WFOXLsG5IXPp8+k1Kpa5jzjH3xXpP8?=
 =?us-ascii?Q?yDIkwIn9fODWnRuipW+OJLtps92cjof/tSdCTCIwl4StvObuWH2rQbid+jMN?=
 =?us-ascii?Q?ND1pCbZyrXK7ZE0Gkbh//CmdyN/H3P4pl8jTgM+7uaPsGpS0KenggrYjbwTl?=
 =?us-ascii?Q?SYG2lfonl3KlM8Sf2B5cpYMBfsvO3DwL4RBEk5CCTqYFrygsf++TwyL4IfNp?=
 =?us-ascii?Q?HBcVsDK814F55LOye1hqMRbXtwV/ZWbdZ4WEsr++gOxDIkUnZmxWZe5FovVj?=
 =?us-ascii?Q?XiTpKx5x+AJrx/SBtewX9J5Qo2FqKg4taUIav8INU+46wKcTepBi1rvrj/78?=
 =?us-ascii?Q?aozbRVxVrtAKdOCLcpEykGPo8hpMRuqSvbX5b8yM+bVng1sMKWHgeaXr8aUd?=
 =?us-ascii?Q?PaRwVZ3JPOmMUJsKxXw/ejB+nqq/iRk2ORK6QUiiQmpgeAwFExitnKM62dLk?=
 =?us-ascii?Q?mwD5Q8MD21y14lBuXHy91xwXJ/BdZg9/v4wQYeI1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e0d2d4-a536-48af-3b80-08dc29619421
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:23:45.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOZnUWhb1ItWBrdnCbzCI9Bk02jkhWp/zsPFnLVFN7fZB1LvTMiN/hzyMuhyDMag11Em9C2HHZGBGcX2QHRgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

On 26.01.24 16:46:03, Jonathan Cameron wrote:
> On Mon, 8 Jan 2024 12:48:33 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The last entry in the CDAT table may not mark the end of the CDAT
> > table buffer specified by the length field in the CDAT header. It can
> > be shorter with trailing unused (zero'ed) data. The actual table
> > length is determined when reading all CDAT entries of the table with
> > DOE.
> 
> Can you give some reasons why this would occur?

I have seen card implementations where the CDAT table is some sort of
fix buffer, but with entries filled in that do not fill the whole
table length size. Which means that the last DOE ends earlier than the
table end that then contains padding bytes. Spec is not entierly clear
here. It could be interpreted as a spec violation, but DOE is the card
vendor's firmware there is not much that can be done to fix that
there...

> 
> Need to be clear if this is:
> 1) Hardening against device returning borked table.

So this was the main motivation. It will be likely there are more
cards with that issue.

> 2) Hardening against in flight update of CDAT racing with the readout
>    (not sure table can change size, but maybe.. I haven't checked).

That is a side effect I realized while implementing this patch. To
prevent an out of bound buffer access, either the buffer needs a
length argument or the length field in the header needs to be checked.
The earlier is more reasonable and natural to me as no buffer insight
is needed for that.

> 3) DW read back vs packed structures?

Good point. But that was not the reason. IIR the PCI DOE code
correctly, there is a DW access but only the missing bytes are written
to the buffer. The CDAT structures are all DW aligned, but the DOE
header isn't.

> 
> Patch seems reasonable to me, I'd just like a clear statement of why
> it happens!

So regardless of padding bytes or not, a length check is required in
any case, one or the other way.

Will update the patch description.

Thanks,

-Robert

> 
> Jonathan
> 
> > 
> > If the table is greater than expected (containing zero'ed trailing
> > data), the CDAT parser fails with:
> > 
> >  [   48.691717] Malformed DSMAS table length: (24:0)
> >  [   48.702084] [CDAT:0x00] Invalid zero length
> >  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> > 
> > In addition, the table buffer size can be different from the size
> > specified in the length field. This may cause out-of-bound access then
> > parsing the CDAT table.
> > 
> > Fix that by providing an optonal buffer length argument to
> > acpi_parse_entries_array() that can be used by cdat_table_parse() to
> > propagate the buffer size down to its users.
> > 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/acpi/tables.c    |  2 +-
> >  drivers/cxl/core/cdat.c  |  6 +++---
> >  include/linux/fw_table.h |  4 +++-
> >  lib/fw_table.c           | 15 ++++++++++-----
> >  4 files changed, 17 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index b07f7d091d13..b976e5fc3fbc 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
> >  
> >  	count = acpi_parse_entries_array(id, table_size,
> >  					 (union fw_table_header *)table_header,
> > -					 proc, proc_num, max_entries);
> > +					 0, proc, proc_num, max_entries);
> >  
> >  	acpi_put_table(table_header);
> >  	return count;
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 6fe11546889f..012d8f2a7945 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
> >  	int rc;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> > -			      dsmas_xa, port->cdat.table);
> > +			      dsmas_xa, port->cdat.table, port->cdat.length);
> >  	rc = cdat_table_parse_output(rc);
> >  	if (rc)
> >  		return rc;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
> > -			      dsmas_xa, port->cdat.table);
> > +			      dsmas_xa, port->cdat.table, port->cdat.length);
> >  	return cdat_table_parse_output(rc);
> >  }
> >  
> > @@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
> >  		return;
> >  
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
> > -			      port, port->cdat.table);
> > +			      port, port->cdat.table, port->cdat.length);
> >  	rc = cdat_table_parse_output(rc);
> >  	if (rc)
> >  		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> > diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> > index 95421860397a..3ff4c277296f 100644
> > --- a/include/linux/fw_table.h
> > +++ b/include/linux/fw_table.h
> > @@ -40,12 +40,14 @@ union acpi_subtable_headers {
> >  
> >  int acpi_parse_entries_array(char *id, unsigned long table_size,
> >  			     union fw_table_header *table_header,
> > +			     unsigned long max_length,
> >  			     struct acpi_subtable_proc *proc,
> >  			     int proc_num, unsigned int max_entries);
> >  
> >  int cdat_table_parse(enum acpi_cdat_type type,
> >  		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
> > -		     struct acpi_table_cdat *table_header);
> > +		     struct acpi_table_cdat *table_header,
> > +		     unsigned long length);
> >  
> >  /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
> >  #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
> > diff --git a/lib/fw_table.c b/lib/fw_table.c
> > index 1e5e0b2f7012..ddb67853b7ac 100644
> > --- a/lib/fw_table.c
> > +++ b/lib/fw_table.c
> > @@ -132,6 +132,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
> >   *
> >   * @id: table id (for debugging purposes)
> >   * @table_size: size of the root table
> > + * @max_length: maximum size of the table (ignore if 0)
> >   * @table_header: where does the table start?
> >   * @proc: array of acpi_subtable_proc struct containing entry id
> >   *        and associated handler with it
> > @@ -153,10 +154,11 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
> >  int __init_or_fwtbl_lib
> >  acpi_parse_entries_array(char *id, unsigned long table_size,
> >  			 union fw_table_header *table_header,
> > +			 unsigned long max_length,
> >  			 struct acpi_subtable_proc *proc,
> >  			 int proc_num, unsigned int max_entries)
> >  {
> > -	unsigned long table_end, subtable_len, entry_len;
> > +	unsigned long table_len, table_end, subtable_len, entry_len;
> >  	struct acpi_subtable_entry entry;
> >  	enum acpi_subtable_type type;
> >  	int count = 0;
> > @@ -164,8 +166,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
> >  	int i;
> >  
> >  	type = acpi_get_subtable_type(id);
> > -	table_end = (unsigned long)table_header +
> > -		    acpi_table_get_length(type, table_header);
> > +	table_len = acpi_table_get_length(type, table_header);
> > +	if (max_length && max_length < table_len)
> > +		table_len = max_length;
> > +	table_end = (unsigned long)table_header + table_len;
> >  
> >  	/* Parse all entries looking for a match. */
> >  
> > @@ -220,7 +224,8 @@ int __init_or_fwtbl_lib
> >  cdat_table_parse(enum acpi_cdat_type type,
> >  		 acpi_tbl_entry_handler_arg handler_arg,
> >  		 void *arg,
> > -		 struct acpi_table_cdat *table_header)
> > +		 struct acpi_table_cdat *table_header,
> > +		 unsigned long length)
> >  {
> >  	struct acpi_subtable_proc proc = {
> >  		.id		= type,
> > @@ -234,6 +239,6 @@ cdat_table_parse(enum acpi_cdat_type type,
> >  	return acpi_parse_entries_array(ACPI_SIG_CDAT,
> >  					sizeof(struct acpi_table_cdat),
> >  					(union fw_table_header *)table_header,
> > -					&proc, 1, 0);
> > +					length, &proc, 1, 0);
> >  }
> >  EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);
> 

