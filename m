Return-Path: <linux-kernel+bounces-24188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64482B8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B0FB24D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD54A13;
	Fri, 12 Jan 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBlzWxp+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4423C3;
	Fri, 12 Jan 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705020312; x=1736556312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lfD3wYyufOmi7Ttwd9/Jrh8zR6HmakwyY7erC2+gkxw=;
  b=gBlzWxp+YqQ137ZOLMmMB2dmxRz0iBpr2cFxhoolxF3TBRZs3io3/5Ot
   /lKvfLtYqwg+5gIoqkhN8dnIgo9QMROY5nzQ+q5nkVWJeqZX8LD2yOBvm
   V0FCxLXLMICpzRn0q0on/s8zRUN4+J09zrSsTJoRUye1vO1I0RCjE8hlB
   Oq13J5TSJaKAJyQlQLGLL0oDML8srSQEoyi5oxa3WUaGhiz0lWZvEjeo2
   mi6JP2ahIIjqkP1DClG8GCn4Xspy1misOwpj1siLyATATY7PdKj3FvPY/
   bpf2h9faTf7umq3ZK0CUc1aj6gqAGJR9qTnxyul+45T3+8zVISTYjO33Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463327958"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="463327958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 16:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="31204885"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 16:45:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 16:45:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 16:45:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 16:45:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqIR6kI2Fr4/mJXZHdayuTF+q0gyMIqir41Kzlwjkfm0ZHRPcxh4xUvgDobDY1/hmjAOqskFvcMX0FK5enbpkRgkAqmeHYeXY5sOfMJpzabVPzvRsz3BKHK/CgUiyve/iqZdPH6Pm9osF5PcMVw1QySk6VbiDT/5+GydjDX6pJfbMHEamLP8ONnTD2c76rcyyqkLleYnm0DNWMv4E//T96dCUE/zpMs2HSkxptS+4CtZPEuGVrcB2u7b3W/1TfgisPPt0ZW/PS+7ymc3J1CDcWbAT6HxH/i6iPtcbnwP31GZEsSRlD6qCSZZyWQ3MTr78O8Cf6Eo/bk2DxRnWlibpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS+G3KqLKHekoP5omGEZN1AewDvtgA8eMnrBmmFR/Zo=;
 b=M5Wk9+DbMuzEekBKaYi4V4X7fN68Tnino+FkJErkhATDJkhgvtdANSgz40T5hIamk8iS3sMhRrwoi5M0l0dbw8td90pj24hRo8D2OYSmKBPFj17xmmdws/boxFWk4Hsnj1jRy/t6p7kIYb3BF1lMFlcurFY9zseMzkBxnpwN+6b070CrnTkHt+IckR3QesXR4fhddNp0OpXhhBGdvY/Kaf7evOHkHoomX7AQWkvmMdCgfdhpxZmr42qcVLZ63CYUIJhNS9JBUsbIJ52QFor92qPlWRBt2FLCw4JIHHp1lIarNzyVbwuYuRBYkdtobOsGmyI6h7g6ize1ckneXcpEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 00:45:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 00:45:07 +0000
Date: Thu, 11 Jan 2024 16:45:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Yang Li <yang.lee@linux.alibaba.com>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yang Li
	<yang.lee@linux.alibaba.com>
Subject: RE: [PATCH -next] cxl: Remove duplicated include in cdat.c
Message-ID: <65a08b90ce17d_1eb429469@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 4209277d-6f9e-42ac-39b7-08dc1307b8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLP6N65bNn6wXel+DUTh1h96jWGpSRkPaYE0rXD9CrD9C+tfktPwGHkMK3Isr/oyRLGQkX1BsgPGyVOCvqm+d70ZUnW4azzrP819dykcii+edNi1M87JDNBIfG1YVFEvlftBjT2yhWNxmNYkGhHDywtpJ4PVn0ZB3ImL5Ubg3t12emiqEzysumBE/9oD+OIXB0bbrIssBPMsBA4XDKuKuI5c5FzKX7TQlEYoszX1gOaAXHUiGuApGeo76RNZFXYybwlCOzDFmXkyomStuUV54M6GRKGe9vYpoQoR63PIf3qm1fwGpomGODxrPvmqRIjLKGR0W3x158h/NCFNJUilSx4f4epVnC4Gky3oTHOp0ZYKcbVQ2ta1IMiT8vAh4AYZtQZW9ITn+aAq6V5hmK/y1OGx7nc57ckYt29jCuxktBKOAITlgmg1jc+xY3ap1hlegk2FUgNghikHzrpI0o0prlr2R+tDEQyyo620XxIWfThpQFDuH3nxZlBnppo0nPjluIhQwfGYPElfIcgrnwwcnnMTXeXqzVmAaIgM055M6NnI4+5CkQ/944bsdsr3dYUi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(5660300002)(9686003)(66476007)(38100700002)(4326008)(8676002)(41300700001)(8936002)(2906002)(66946007)(6512007)(6666004)(6506007)(478600001)(6486002)(66556008)(4744005)(316002)(83380400001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dI70M/AFdhb5RZm6pvoScwxcSJxZ++O36Jx5y0y96Yjp/k4cLVzNwjkn1gf+?=
 =?us-ascii?Q?sI408AUdG3quaDrzCoZ34dTQJnq6qYbd516emh0RZS0dgGkMuzTGfotYKSiq?=
 =?us-ascii?Q?KyOzhSrR6mF6o6HVK7M4+jxLI/V4jxCriV7W7MzGGgWhjrbVXDHn8R/7KRiY?=
 =?us-ascii?Q?W9IT4JLPITYAqXvipqOfitg0HdtbQcXXervxAJZNRbxNgD+UeDMdeyZD7/mM?=
 =?us-ascii?Q?douBeb6BagOaceICmO11fDs5dKUGrBdFPAIZRK06ThdnAf3FGrQFIjHPJ0XP?=
 =?us-ascii?Q?H5mqAnNfkEctXe8GnYSy+eAa0tilUTvTbGvlhrPf4pDr/qEgwUU97+/ShVLP?=
 =?us-ascii?Q?V0DzYqpYT4g9X+VdmgqTQbBpou0mELHu8lWGvB5LMdFl0358d2rVM7/tEoXW?=
 =?us-ascii?Q?spxyADlnXa8+bxKhr0qHkm3A9aiJSKlRoNK3jm/ZvEBtFhUFUmFu70AN12BX?=
 =?us-ascii?Q?wou0saZs2PAWFmUPbgN/LR23MYwr2R0aTpi7CH+I9CmFS6Eg+jRp1UjhssN9?=
 =?us-ascii?Q?jan3bnya047NZrOkT1uzjp/9qsN+zViyHMCOXgp4S5L70H8Q3ep4r17lT+sT?=
 =?us-ascii?Q?wTCupUhfNV4sce8DGUX879eqw8W9V8eSTNUKCjcqj4oRrAzU+XyKWNEmF6Re?=
 =?us-ascii?Q?kyl+evNFlU55JoO6L3vNKYkqqHbRDg1tlM3YIk/s9e0QMmC4aJnyzKb539KW?=
 =?us-ascii?Q?saKBTrX+DIL4524T2Y9+TDaXRrFiV1Ma5/1zvObRyvWI1xdSi/vr1Fm/7v3+?=
 =?us-ascii?Q?lpoLq5tonjxXP0Tr5GdfZi+RlEZx60r4v+ym0KgQtJQVpipnf0dk9ZcsJsUt?=
 =?us-ascii?Q?MowrTel3W8vMVjR8k4iUH+ZY0jV/y4Y3g7o5UpTRFUB85sszBrvM9hCkKOZq?=
 =?us-ascii?Q?j47dl3urWw8pd3xOw+BXnuDbZNazexS/1yRbgFKsbF83E3V+VEs/FBM2hat0?=
 =?us-ascii?Q?x5sz+Db7XvHw7+hT3phJeKQJ2g53CFcJKbwXI2mohZ9OBfCv/haFeOIhdZDh?=
 =?us-ascii?Q?yyV6vWqSTQksFn/bxKhlNNuwW3pwjZQwTKR7ru/OX9++HRVehv4rRHnYQBdl?=
 =?us-ascii?Q?Y7AFEWa274NSYD9PSIXxr3H/E4m68S1pHGrM7COETi8nlcNnMiPHXzTEyAQu?=
 =?us-ascii?Q?nProo6vSL14rskPluldUp3PrNAOiApvTwYGLGlVvW9nRQRFCMCv0UKK/j09M?=
 =?us-ascii?Q?rnqao6wvkdJqLlDHXvlYpkm6ClwWKbOMCAsnozB7Wh26SJFCq1NbGLW5vMzR?=
 =?us-ascii?Q?NAdh4qb1IMXJhZ8aA7otmKBnfgM/WA1KKd9lrAzewWWI+nw1tdPFOku4GFHV?=
 =?us-ascii?Q?OZuwCC6Tilgg6n5BSlAjsnHLRIphvSTG5yMlXLdiA7VINF6nXB7sw76zJSXE?=
 =?us-ascii?Q?Tr4wJjzrYVNSNvllYNmbSSPcH6jiuhqj32shst/iyDHxzeKElYCug327mmoT?=
 =?us-ascii?Q?S9g54gCQQxX7zn3wQ4DivPm54Mh2CCHpzzwxF4v76sh6/iPXpKIgIn00/rCJ?=
 =?us-ascii?Q?v6gjoy0T/P6uf+RZ2uk+BVmUXvSUOb2RjgWZ5qQPEHxvfQ7evPD9/QNtd7AM?=
 =?us-ascii?Q?SU4sBFOI0/Z1vctIedFOq2t01ODI1yyEr9o6DsMeiqy8hh/6rdCIKCfc0QTd?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4209277d-6f9e-42ac-39b7-08dc1307b8fe
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 00:45:07.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MkIFAwouJifkJ0kW2J1irTJb95D+iah4L+TIU+Vu0g8vHnu5YtB18Wl+Z4Bce/TAvDuHCZ4xwaOA6OPJt01fZs2PCTFXsgmWzhooKivIYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5603
X-OriginatorOrg: intel.com

Yang Li wrote:
> The header files core.h is included twice in cdat.c,
> so one inclusion can be removed.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f5e649407b8b..6fe11546889f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -9,7 +9,6 @@
>  #include "cxlmem.h"
>  #include "core.h"
>  #include "cxl.h"
> -#include "core.h"

I believe that was due to a bad merge by me. That's fixed up now with a
better merge commit.

Thanks for spotting this though!

