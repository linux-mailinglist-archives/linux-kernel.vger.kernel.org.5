Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C077F78ECF8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbjHaMWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjHaMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:22:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548719A;
        Thu, 31 Aug 2023 05:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUlgSbjppXLRQMYYOw9X3t84vlAZNNNu60W1fXc8xOvLZOxpmgU1YSG3LYg8fSNADKgIk/VbavgW3E0RWdL9TShcLsf2GlOYZ+QJJfCG3i7nr+oLKrlPNiDw01xyIiWFiFyXxssdVQ0sMxORV1WvCf7oMkppITbCSrupMeVUArkBb8LeT33OzP7xr6b2PlcwMNTVCBl9GDmwyt2qgdO+cLI7snlmfyvgCglKqdaEA9lAO3tyR90vulas10mJN2cmaeKFUlZ1JAqbh/AltHXnTftFtw0E0S1a/bp/aFHD66szpW3dUGtZJDVBC3cUtx3vj4/ehC8giOyqbrRRNcA9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDl8HbSibBRN8VtbYHLrNZ5XJu9z5Upg5bpa+kDBpFk=;
 b=dI2ZtgajYrxmKPO37YO76Qe0kxV3WESEKPKLIX5heJmp3MVuCO9bfHbA0PdYnc0zauuhX0QQFm1EGLvtFqAPvCcu+Pjt4rMJNq1BlT2oBfHMoiI+ng+kzm/8vwRaIBekoEJak/JGloacLfv1iqCR3BuCQnKMTFLA2yHgqHpxwhog87W36pfSvNvZcG/gdZDaWaPogmFmskfD4Hdb1F2Q+c/0rTvFNZK6JZ4f7JdlE9HnOuCiEcAvfozeeejty4q0Gen51R1n0W4v1xP4vEFwwyiHtxnaYWOfkNRC2AX9SwtparWDN5R3U33Y+x2lzhNI50cPHj/XnphH893j7XbiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDl8HbSibBRN8VtbYHLrNZ5XJu9z5Upg5bpa+kDBpFk=;
 b=g0OO5KTp98Y9URoCQ0/2864fr4Va3qDMO+Vb+k74ZyM468KDrINTvimB4tOGMefECPEHP+1OiLFvuwtkXisSRe7WKbA3iFJNeOqRaN5+AT0iTWb3bNiph5N3ZpgszEISt1nPRVPwSSgHjH2hD2MrZz9v6Z2vHRkKUpNXOOilYDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 12:22:43 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 12:22:43 +0000
Date:   Thu, 31 Aug 2023 14:22:35 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v9 01/15] cxl/port: Pre-initialize component register
 mappings
Message-ID: <ZPCGCwakf3BeV7gp@rric.localdomain>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
 <20230825233211.3029825-2-terry.bowman@amd.com>
 <20230829143851.00006467@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829143851.00006467@Huawei.com>
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a846661-7720-4671-b3bd-08dbaa1cf995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVhSxv+Uo+ngqR4P14j9Wr+K+W45mgUw/TXrT5h2kmbLrqVCrpN/nuTykdNLfw6FDNNU4zc28m/PXtO1VBofAznLkZyWTHCr3wPX8zpWyOZBCA4m1Cd8z2tcshW43EXiCbMrh0A41C1ocuRBJrfrqHDs+Sgao1BnIM3lvz3GgC149zNbqv5dCmg7BniSGNG8wf/+ZJYJieVVOgi5Ddu+8mDa5zKehRYB4TpLlVMDVZgERS3wqkJUNNCbK0WSH7Qu2cMW96sOa2sKnlvQJOgSqCvjmOzmOcnmPd4/tWFJ4w/57f4ocd41PUCI924lQwPLfW/ApCSDyTbzG1ryPoIEAx/+eUd5pTRTA0QUInyNn3fQNjpCPLhOHBgixjDSnfM84heRS2BJG9dB6xxLg1r2c7lBDpiQbBlwy+aGogKg7psVnyzoL1TGMmqxm68lrYJaJ9PxrGkq+/HiCBSj9BppSogKkub+URI60uS1DemQZEYNioTAUf/hcgQd1BSSsdHVtuo7WDmhgLzxjVcBAvwbez51EtFz7cACk7skCDXukA0+7NTZ10AEJ9AZbuB8UAXY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(9686003)(38100700002)(41300700001)(316002)(5660300002)(4326008)(7416002)(83380400001)(26005)(8676002)(2906002)(6916009)(8936002)(6666004)(66556008)(6506007)(6486002)(66476007)(478600001)(53546011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wT8tFwpmx+LtXcz1JdMGUpNdDAhI2N6dMC3WOAuEhWTQs+LLF7Q+i9DJlpEv?=
 =?us-ascii?Q?IBeKl1RSG/rWtERebce0/8JmmjmYU66r1QT8X0zwaTe3A+Cx4yq37XG1fyf/?=
 =?us-ascii?Q?Y9MwaDjZVjA3g+6l0mSpES4TAL5/2cQiXTX7daA6E1FVpnYVnTrGvrlISQCU?=
 =?us-ascii?Q?WPSxkNexIhM+WTt+wISe+OBtWXnHddgiE7WA6/CQ8V5ztmi7wWK1kVa/5vlp?=
 =?us-ascii?Q?2tuLQ3CrzP1Z244x7TlIsIf1+Y4yzZr1V0vTBqom7P0rF8mXGR4omXOJpK0N?=
 =?us-ascii?Q?mYl8Twp1PyUsmwiY7CFuLn8v0vGW0VR/8rhIVg894ILHayAOP8qfslcKfeuk?=
 =?us-ascii?Q?KXN9gwdJANMeXDBJe0mXatjH92IUFTAAcYhBaHW011N+rVdd/MGv9W3dg2wO?=
 =?us-ascii?Q?fmGUCftQ6c0dCAN4XM8VwLWi0IPSEcJrFOgJvDCDmQ2GB+AjPJWY2gE6mRfz?=
 =?us-ascii?Q?c4QmZSgZXGVFxi2HlxgYYPy+loifdgdXKjO/3jDuIo7VNFlN7vrEDFobeflt?=
 =?us-ascii?Q?ZJT02eYebU/Ze2rQpTstDjCOs9sp3XyZn6+r0LpO/FJlVkjpm4xPL5bF9Mx0?=
 =?us-ascii?Q?VGodIqx4Go3h5fq7PzJP8nnrIdMcajF2s+M61EhqDPjPH4AbFA2tkGku1okZ?=
 =?us-ascii?Q?Kiu1NoPwfVRLsYkfaY4v1WHjTGmuZkMr+EfCqW4umGp7t4rj6r+qjlzWstdT?=
 =?us-ascii?Q?dwwtnnFOIg9uP8WaiahWHxHoyDk0Q1/R2dv7k/hCTAf4Qbqd0Bx3711G60W8?=
 =?us-ascii?Q?0yOGVcnLaoe2pWQgkzZZsRmKlmf5lRpfMkdsMfjmXtRjeQCZWEYyw8SxUtyr?=
 =?us-ascii?Q?r4WOQSTXN4FI5es+YDVNtcE+dKHytHvilx/4vHcBfaMdCSsxyekJ6IogTejj?=
 =?us-ascii?Q?rUUFwVpYAmP/EaaI3QOWpLdeknzv/xKNntfnmnT+0RIOhVyMhRtPsnoMbTVK?=
 =?us-ascii?Q?onxiqp56CkP9s5BnPszwb/d78fimmx9FJcSVv/C2L8jjUYIxJBEKYKkq/wyV?=
 =?us-ascii?Q?ok+D/CqOAjdcDXEuDmNDHR+VyqpvsbVMUrGYFwQzaeK41Ypk5K+pXn+01Y0j?=
 =?us-ascii?Q?qxsnKX0JZ1ylCXzZhdQ7exJ7vf94DtKYjgpfiOOnm0pFvFbRHwIyCz9ksLXv?=
 =?us-ascii?Q?8kyN5bv2bOfmJFQfpqry+yiLtjrLdco2feksv5G9OfeJ8fj5XgzcRmKwXPmW?=
 =?us-ascii?Q?7SGG8PXMM+Zd3Y4SSV5f7sW3HVPvpfi1GoEQCYpGvkUDm6OERBRgahd4SG/6?=
 =?us-ascii?Q?Degm8mu/+QRwVf3SmCV4SI9x5d2zKFQxS8XGPq+R1RDcPaR/oPdMKXlvPV1a?=
 =?us-ascii?Q?rSs1kcJPTMr4TSwYoNHr+1MWbiifb+sY08aDRAjU+VNuZRPR0esEX2VTEpvT?=
 =?us-ascii?Q?l6KA+TepyqQsIzI7lheUe1bjtaM2WBGy3uD7oMmGqWsKa3MlO5OPu96OkoCX?=
 =?us-ascii?Q?95XffX14IIMD0a0asN/7Z8uL8Ng0FVs9iqpAlpT8WPB9hhYtYhEj+7FmHQxe?=
 =?us-ascii?Q?zYeF/SFgb0KclhEmVN3fwfLsgd8nukl4Q9heRI+UrvJxk5blytwuvkYfOtha?=
 =?us-ascii?Q?8EUCoVYkVY27wGlEnLcIjZRrvI69CpNAGI/wE0vt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a846661-7720-4671-b3bd-08dbaa1cf995
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:22:42.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dtitsov/XDF0J2FFPwawG2pITtk2UEqm8OqFXxMD2r9GPBg373ws8tebSS37u9m9K6fkFW1STRgoOs2u7ILLAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 14:38:51, Jonathan Cameron wrote:
> On Fri, 25 Aug 2023 18:31:57 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> 
> Hi Robert, Terry,
> 
> > 
> > The component registers of a component may not exist or are not
> > needed.
> 
> How do we now it's not needed in this function?
> Perhaps "may not exist." is the bit that matters in this sentence.
> 
> > The setup may fail for that reason. In some cases the
> > initialization should continue anyway. Thus, always initialize struct
> > cxl_register_map with valid values. In case of errors, zero it, set a
> > value for @dev and make @resource a the valid value using
> 
> make @resource CXL_RESOURCE_NONE.
> 
> (not "a the")
> 
> > CXL_RESOURCE_NONE.
> 
> It might be worth making it clear that this will (I think) only matter
> for future usecases and isn't a fix for how this function is used today.

I reworded the whole text:

"""
The component registers of a component may not exist and
cxl_setup_comp_regs() will fail for that reason. In another case,
Software may not use and set those registers up. cxl_setup_comp_regs()
is then called with a base address of CXL_RESOURCE_NONE. Both are
valid cases, but the function returns without initializing the
register map.

Now, a missing component register block is not necessarily a reason to
fail (feature is optional or its existence checked later). Change
cxl_setup_comp_regs() to also use components with the component
register block missing. Thus, always initialize struct
cxl_register_map with valid values, set @dev and make @resource
CXL_RESOURCE_NONE.

The change is in preparation of follow-on patches.
"""

I hope that is better now.

> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Otherwise seems sensible to me with one comment below.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  drivers/cxl/core/port.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 724be8448eb4..2d22e7a5629b 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -693,16 +693,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
> >  static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> >  			       resource_size_t component_reg_phys)
> >  {
> > -	if (component_reg_phys == CXL_RESOURCE_NONE)
> > -		return 0;
> > -
> >  	*map = (struct cxl_register_map) {
> >  		.dev = dev,
> > -		.reg_type = CXL_REGLOC_RBI_COMPONENT,
> 
> Could set this explicitly to CXL_REGLOC_RBI_EMPTY
> which is what happens anyway, but it isn't obvious that
> 0 maps to something that indicates this doesn't exist.

Will change that.

Thanks,

-Robert


> 
> >  		.resource = component_reg_phys,
> > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> >  	};
> >  
> > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > +		return 0;
> > +
> > +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> > +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > +
> >  	return cxl_setup_regs(map);
> >  }
> >  
> 
