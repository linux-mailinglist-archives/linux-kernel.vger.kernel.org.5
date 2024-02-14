Return-Path: <linux-kernel+bounces-65019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C51908546CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402A91F24248
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6618F171A3;
	Wed, 14 Feb 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UoaJejy6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2E168C4;
	Wed, 14 Feb 2024 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905208; cv=fail; b=NFBFdelBGC95PKvMgb70ekpbzspzMBuH1dp1pNf5rwHx8rEwKBRqgMwJHWVxW3uJCflII56B/jrSyBHDyQbHd6JwK/ptfns4c8csnAJKQCVGNiTC4cl6bJFds5VqdKUVxVGGBvQXfABiJ5OHxDUvfTbDZpnOhv+3NDo7vzMy4B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905208; c=relaxed/simple;
	bh=QzF38Agdj2eWmV/q5wo/uShLemi98T+mORL8yb5rMdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E+ZydtzlXEruKA3hg94MJHbRHjlmgXfOrp/leQAFpgwU2s0zu8jYOoWg6fCYC1ltznOhpfYTpidHnKmZfOGVawQB05oxWZp4pWX5JOz090dsJYCgoHjDB0RSBj7o337PzvNn5Ye6PnlWdkjWIB+rYpL0UeyZF56pJ7zQhSIIhg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UoaJejy6; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz+s7bFibRPqkGNDd+WDO5eMZtThyvQCqYeElW1yi4Q5W19PZpljdffSa6t5rgzJH+ZqKldyIqFX2SvhlkABFa3xjckrlb2MkPv70/ee0sFNp64vn6JWbEjSRtLNYY6uD5iRAlVkCdbgEraq3qTyOhim67tWtpXltquE2yRbVSH2wEWqn5v8dusrS/1GM+UN2nLaQMqZ6Xh8jUaYRVx5H69ihOzcZBIPbbIb4vxe0z6X9xAKruQfnwfb3QFfqjrxUX977FOAuCNcSj/leEQxSOsEyuSKaHiq5iJ+vzz5PcoSlxnHy3+6zXJxbAg6hxldTBns/X+DxyPbTbg4W8MS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8PvC3Au7ciYpEGUZzQXQ/fdJOHpOMy37ITIjuwQXi0=;
 b=hjeTXUqtnu+hEzSkWvb4yXjwpszJ+svsf3yCD5CrK1skwes900kc+H2zg2gD+nTjXZZOJ/XzZBVLGea7mZZVRdtC2NKv/8tMxuGvkaCf/rfVjA/lmNAvg665sS/JEiPM1ClgwIHot1CLvPtjrt9CbE2fyk7uQms9sQsmFPS8zC/hSYWILYZIJMhY8C+lD19L4d3Z3QlHGRutZ3yRHb6OkYUNftwY76NoFvxSRMiyTXzZQXg6hjU+0Vm5l0mANSgUsPmTfISfNIMFPWBn5bDSeOD11zl0GBfVqc+OIuNahy9l33gEKy/QXWjE40oHu4gJVbSFQy55OAO9IL08jng+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8PvC3Au7ciYpEGUZzQXQ/fdJOHpOMy37ITIjuwQXi0=;
 b=UoaJejy6VLcDTEEUu/xV6OR78osQKyWpueLOJTy4KhCzHhu7OklhzfNkIDzmOaFhDsrZisdOOqTyS87R4wUKxw7W2aZWeEK+zSUlgml7+H+v0ir3IsFUCBG+OUmIGvXO3jqWehtopW2RNQxg5N59HKMzj4Cf3CYsLspjewVZ/rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 10:06:44 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 10:06:43 +0000
Date: Wed, 14 Feb 2024 11:06:38 +0100
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
Message-ID: <ZcyQroz_4XZAgbv3@rric.localdomain>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
 <Zctg4Lx_y_hbChUW@rric.localdomain>
 <65cbb787e73c_29b129432@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zcu-cVG9deqfwdiV@rric.localdomain>
 <65cbc6ec7a0f6_29b129456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cbc6ec7a0f6_29b129456@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: c50b2433-a833-48c6-3e7c-08dc2d44a586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZhWfNB0gQfU7wKuuVDC7shAHoTkKfNiV5Y3UU+fjxKX9wLnY1d6Ljp6tIvHk/byTsom0J2RwwefCGOaQA0gFG4cZzTrWHz44145KVN3jT0brAeJG852hFMkBqhk9UBhv6JS8/Fr+7WpNdKBLwFVCQ0djp9shIw6TKqklO8f9sraT+HtG/XSKJHJ6AdWjwaORGs2KYSXAIAstpQWDtV4or9gUCYDxRpyldgR86JFFNiG+IBUMaCrM9ZhzGXHYAlsvKztLoYJtoABxRI6m7zges2Y6e6SutjtyrUAA46P/FrP47tgXCG8aaolJ0rAudIjy/FiZ7l/z+aA98K/DYT+UYypF+QW2/0zbANjjqm5wwJ3NXonferAqMZ9nPSBMb9FwnwRgTeO/CYlfDfmmXcKRh+Fe3aLeBQIEg/1RPDxYhTP4rqZ9U/2W9SBTXB+9LKkuLFIr4Y0M7bEe/lUjy0+nE2+X9GQwXqBpNiqf1AFvBamRKBF0V4H8NndB8/YRNhIV10EcIhUgFqms4eQySMk+NyQ09HknhfoX3peFKFeR+Xrefc6HKKkgBFVnaPen130l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(6666004)(6486002)(6512007)(26005)(9686003)(6506007)(53546011)(478600001)(8936002)(38100700002)(66946007)(66476007)(8676002)(4326008)(66556008)(5660300002)(54906003)(316002)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOXLOXmieeBCCwtOPNQHdbCGmMSiX8ZjiTwdsX6fPZz6qvn3j2pKqS5R+eG7?=
 =?us-ascii?Q?dcFiWUNpWgfvXBKkPjZIj8oDlt0VEp0VyOhkpUdsyUmjZVyXNIkyeALJmA+b?=
 =?us-ascii?Q?DSvGUAGeFjencS9yOqCrCUOax9lvGxsCFeJ20z8Jbr4JnjDzAf5edBotdP0K?=
 =?us-ascii?Q?uFHdSQepvaUtw88+r8nYe/uzm73nIX+gVL97zBDsjwDLGdjLc/8JYPdyuP7t?=
 =?us-ascii?Q?ZbK3Y08YZJUL4SMZxoPvLwjexTtJXyC2GMpBj78v23fdcdcTvMUvvxLHDBKa?=
 =?us-ascii?Q?CtnIHJWu8e9pTsEoDlCXcDyES1313HaF6lRR5vKqDjT+gd9su2HAjRbDcK0O?=
 =?us-ascii?Q?dLQJUgMMqywM/GvWMp7deKGcg7u3Ql8xarr9iPm47x2t3aXKAmEezXcdbL5G?=
 =?us-ascii?Q?KfNJn01/wrEbdNG4mRerI0TbW8tk5jSHk5G+LZO9NaZCFnF5ibV4o+I7dZY8?=
 =?us-ascii?Q?GxgtrLn2nUr3SCHf/RP2lM4mpOrjgW8e1o9A/1EQELkzRlBJEXvDGQ2Rhgtv?=
 =?us-ascii?Q?tLisGBKZ2AsVCm5vCl+7aK+tetWA8/zyN5sbqQvZQfCVesTf/uIWy2nmV7cx?=
 =?us-ascii?Q?lMW01hi4qiD1Uu8qXzFTQ4WHqpu6oekvfZX6qeodTv/R7RDb3N4YOBGSOPpb?=
 =?us-ascii?Q?64KX0RLQ1/9OjB2act6/+rwX4HTQP+mNa5s+8DS0OR8hr+xNltuZzgcpLpVT?=
 =?us-ascii?Q?5D3L+fDxtqk5e1nBxak5gRzth8AFywsFwngAFe7XYqJgLJurIzJJZ35CPxbB?=
 =?us-ascii?Q?fX5BlNd/0e1AVLSg/bXCpuGp0J9b0AxVf53hinTz9Qd468cCp7Y8FQeS9BIA?=
 =?us-ascii?Q?jnssMPT8Up9dvVxGKCTjX0RziLcxCs0EdaZ8nE/aEdEkyGqV7hCIpcnGYNuF?=
 =?us-ascii?Q?Z/VyWokSK3nR2bH/f++SKPSAi2tDiE3gOS/nz8Vo6lZFPU6rs0JyfdTYCwQC?=
 =?us-ascii?Q?QdyUPwAvGpqnBJrMSkqu82vqxcKq2JtyScPMfGVMaFw5xuQ4UmtTmn7TRKBI?=
 =?us-ascii?Q?W5aGsIs66VHUobBIr+rJXPDRMRUpl0z2YtsktYWHmmEx/6VTRGtkmjX/SdTW?=
 =?us-ascii?Q?IxCGaU7uiuVZhswWH58rh4cgw3aHSuGLPuAiHberUk91qB349sx4TBDkcv5x?=
 =?us-ascii?Q?k6JLJiLY86/u0govw33F+XjUxhebDYu4MbaBjmd7Y0q9W7i78uMsq5dvjiJm?=
 =?us-ascii?Q?v+UF6cDuslgAYoUXsZPBVBZiPGlwXCKxQmGvJqsI7d4JXgpgmLhx7ZkMktpP?=
 =?us-ascii?Q?zUtgf3GkTeE4cDDrr9lDt0Bow7GZHkVtrYi8vCTMtz1SD1e54ZyV8Pc89g73?=
 =?us-ascii?Q?kYC7pNdv07jLnzJryN5xtwWkg9MyJ652wsW0XtSnlAFaPCF7UGCGe6xKOalQ?=
 =?us-ascii?Q?wbp8dufftExNbxBZ9TiukcpVKyqPzDQXe7HjZ0n93ASSJjZ1oRyjsFTjxqk+?=
 =?us-ascii?Q?ARVDkYgytkxaUxEqoaRHGZH9RZmrazn8gtup4X8be0ln++FXHqVvCHgE6ifx?=
 =?us-ascii?Q?XWKYQ2pKoO6H1SyvWbAeMRlNdr2F49sXhnRW9BMpG+tn7/nyNE2mE/kTHSzr?=
 =?us-ascii?Q?P5R3InSPSRz2mHHQP8gGj55MF96O1DgYnMTJM4LX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50b2433-a833-48c6-3e7c-08dc2d44a586
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:06:43.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nTKLdJBK0wtAtRAOUXHSr5Pt+nGff7JlISZRV7v7f89m56WVwIVmT2SimNeVR5Y2HZiW/xbgYelacOfQle1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

On 13.02.24 11:45:48, Dan Williams wrote:
> Robert Richter wrote:
> > On 13.02.24 10:40:07, Dan Williams wrote:
> > > Robert Richter wrote:

> > It would be sane to just not use CXL if assumptions on it are not
> > valid and not to break system to boot.
> 
> I can get on board with that.
> 
> > 
> > > 
> > > > This may take system memory offline and could lead to a kernel hang.
> > > 
> > > Yes, that is not an unreasonable result when Linux fundamental
> > > assumptions are violated.
> > 
> > BUG_ON(fw_table_broken)? If at all, it is not mandatory to have a
> > CFMWS. Btw, the check is more strict and also checks memory
> > attributes. It is very likely something can break.
> 
> Sure, I'll take a patch like this:
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6c9c8d92f8f7..e4e5a917f1f4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -477,10 +477,11 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>                 allowed++;
>         }
>  
> -       if (!allowed) {
> -               cxl_set_mem_enable(cxlds, 0);
> -               info->mem_enabled = 0;
> -       }
> +       WARN_TAINT(!allowed, TAINT_FIRMWARE_WORKAROUND,
> +                  FW_BUG "%s: Range register decodes outside platform defined CXL ranges.",
> +                  dev_name(dev));
> +       if (!allowed)
> +               return -ENXIO;

Would you be ok with that? This aligns with all other -ENXIO kind of
errors where some unexpected firmware or register behavior is
observed.

 	if (!allowed) {
-		cxl_set_mem_enable(cxlds, 0);
-		info->mem_enabled = 0;
+		dev_err(dev, FW_BUG "Range register decodes outside platform defined CXL ranges.\n");
+		return -ENXIO;
 	}


Thanks,

-Robert

