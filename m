Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78472754197
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbjGNRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjGNRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:53:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BAF421E;
        Fri, 14 Jul 2023 10:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhG3Z16MXuGIeskMqNdndPb/t1PG3MahEfl5ZcR/CnDRZsdrIaDes7/OiAobEp/+y5VK/bV1KSuUdkQwt8BoLnOZQK0PzTSJwE2MmzSJKUiBmj5Am6i6FfbqzaSHKKnG6BOdZRMsWsvYXDgQOPnclfSGW954Ya6Wz338YgyKkJWkoOss5qhFdTEu/SqFwR+MmMzkB7ajLffcKrp9NyxLZA/vuHiE/VKrVXf272FwljUsajpSjfu6pfe7wKlcl8m26SJvV21zya6FCrArEQYCyOjanvh7UDy4ucSckNf9ytBjpAwXupuRNshd4f3IQUj5SNw5BaV/feuqBQ2mMyvxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlq/gzREhu7/IHJs+9DXnSJ3x5cVyk8Lp7NuN3zHoKg=;
 b=ZFOHLoM0qAliJrFCKQZYeBVWyymNVe8/aEa5p/PqEpR9u4ZHG0Pe4ukGQTPPY4CSiRlSHP6RRld1HrpIIA/LzQtYdkYPiIAPNBvjmi2pbz/lS563atT6aWI9VJKK0bIVf+IYATF1Uq16+7MxIb/CUSomRmOGIFPtsxsUqB5dbqwBKokn/bVl0Z6PQMhRLQFxWtucIrWIf73INxYfgY1nLGvvT47HgbY2OpncLzSb7hCVoTHdcnyh5N+/3RSHr2eJVczEa2lk6KlHkl5MaKksZgcg7kcJtfXxqN58rqIsUmB6QcFAPPJMvPxbZ5Nk1zXPx7FgsmNLKV1MsZFAMSb87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlq/gzREhu7/IHJs+9DXnSJ3x5cVyk8Lp7NuN3zHoKg=;
 b=fstRtje+WFrt3Oxq9aUIaTWs+1wN5avk30Woxhj9NgBig5JBqtBcNO0G7tJYoGYQ0+qBfx8sW0LjrQ8rZqfCyOTQMDJPZohccqSZL7HHPQwBOGSGYMNOYWXXwckoXN0saAUrFvX+nP4C7nDWZGc9TJ8DfTuX8uN+Q6R8ycEGyAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 17:46:32 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::99e6:13cd:ab83:9a2e]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::99e6:13cd:ab83:9a2e%5]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 17:46:32 +0000
Date:   Fri, 14 Jul 2023 19:46:00 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v8 03/14] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <ZLGJ2Nm1OD/HoqZ6@rric.localdomain>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
 <20230630231635.3132638-4-terry.bowman@amd.com>
 <64a36a4a39351_8e178294c5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a36a4a39351_8e178294c5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR2P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::10) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b1111d-dd48-48e7-48f0-08db84924265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w132C15X0V1C++8KMWA9Wa8NsXXVqywq9MksUT9Ad6/yhqpHs4QjJ8vR0hTZxyK0tH9u6WvD+0YymYkNhGV0wv19eaAr1HFX+LsNOopflVcLXoEZrA4EMVrCoZGZ+LjyCB/OdSpocbEm52vZkupprTd7pwPqDJWMGqaG9L8jgpUKjUQOuDFBoqP4+I2iz0p1L/SfCNYL5eq3VeHzdCht/NMhNWnyUvcR7SR3surz/l+mCxOXk5zCng6vrOO2MkkmAo+EEPrKFveX88r9MWQPpUVKJzAG5b0nALMZYnFErkATRrqhIrxntPbXLRK3pSyY1N0uaSyaDS5va51VbKkSJK8SIpQkL8pXmFavCcOGlYm8kPOJKWu6JVsyyU0nQ2xtP5MmAOO7bH+oeCOrqXOyXIr1Mny0lXJ1u4jwgodfCwCOYyilHEaUerewXEd2mXDe+n/MEIPldhJPlm9LKQceuWAjoD7PNUBToB7BHCNuZhXPWr0lqbOl3YdFvUV7wSMod6pVD9UxqUEhehJvqI1TyT0BB+NZhvEmL5ieGBIJIEV81h1Zp5RiBBUK3mC0Fxa1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(5660300002)(38100700002)(7416002)(41300700001)(8936002)(8676002)(316002)(2906002)(6512007)(6506007)(9686003)(26005)(53546011)(6486002)(6666004)(478600001)(83380400001)(186003)(4326008)(66476007)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Dsq0POgb6vJnR5+h7jbfIAox1JM8Ds1XFsi0dOocuhm+0ri525Lqtw3WLN/?=
 =?us-ascii?Q?U64xdJCWWsGXKLZLlI3YNKPGFBBAVuQ8fTaetzleIoHaRs/mRs0vdv34V0jf?=
 =?us-ascii?Q?sCpMbb1i0H6wRDTRiaEDtBJTbnTzrFmPGdObVAGnto8VamlDi4fDkrHJaFk4?=
 =?us-ascii?Q?BKloVrwBKioMm5zRwF+27V5X+cXB6g/H6/3cv9p2SF8xtE7aifUPwFmawo2T?=
 =?us-ascii?Q?8A3ZZLoBpxfmx3Xjbe7iCpo/f35KAZKOQ+HTmrn/26Fg3277bn4sf71aI8OS?=
 =?us-ascii?Q?B88LYglse1lQlOIhnhNqYlPADIWF+PajWw/JvqesKAcuW+4DVImtwdNcsxCT?=
 =?us-ascii?Q?M+ymLOQ5rFGFaFRpq0dNKtIoiJINAxbEJ/rbabwtiZ+k1xrPGRSKL7e//ZTm?=
 =?us-ascii?Q?XqgsZ3Ewx/fccOlxw/uE3h0qeyIBO2ikyzbxoLJMjNvCZJGNwbAxKChfLx7U?=
 =?us-ascii?Q?20x6HNN805KWmeqar8hEdGC/xTql15Ds0QlBr2PCNdIE/gALaM6JWcncyRfq?=
 =?us-ascii?Q?ufb4GzCLCH/CaipYVaYzNwAs2NajlOBHgwey9JYdG/0HmoI0OcJR3jzP+IwE?=
 =?us-ascii?Q?j/JJ3IDqnnxsC6nfTB61PER532TnCXWzGfsWH5C6VFtwguzCy3UsqHCZsbHj?=
 =?us-ascii?Q?UOiDHWY1cX5iDA7aMhv/pZHho5v0PBR+R7AOzQrPWbaAgRwQDKVbkCUChk8w?=
 =?us-ascii?Q?CdYsEqNBJq1p0+JP8ZQb1w/NxMxUMVxI1Y7AnOGl+E+X6igj1YhqO0iYfVjv?=
 =?us-ascii?Q?fvkWoR3rdtY1Wz9+KpC0OxqycRL3Xv7lwJVvjWS47FQdgeXEvN6BiR9wddNs?=
 =?us-ascii?Q?F4grMP1qKoF8SpE6wyoHjgRIv8/yDfaQQvrxVDVnN3AH3en6M7nqTRC1I3vo?=
 =?us-ascii?Q?sIvFFwJ3Xnfb4F7gdDLFV4c1VNw3Wzg0cr7RzrPI2I7OPrcEaHrxIX0L7NVS?=
 =?us-ascii?Q?QB7yUA7KmLillRtR7K4pnURFi7z4NcYBwZSq4HPYVI7mkczg7yQZuTe9Ysee?=
 =?us-ascii?Q?NbeYjZJN2FujFDIrygjMYPkmO3U4g2aMvzlOBup73UqZxcZPC2NLZjqBjAEF?=
 =?us-ascii?Q?PZKbF1JJFswaewzyoaxhnxGzi5phU1CZiXdtfJ0k1RmR4SVlQXhkbL1/+Nrc?=
 =?us-ascii?Q?xy7h2P3E+06/n5vucrHjUZUAhH2yh4LBTWJQq9iFj2CJBalS3SLMJnu6lztm?=
 =?us-ascii?Q?mv44E8JW1Kv6iaI/7jyEFC+Te/vdyPjGxKzMft5ar7qaJCIuVwDfN5ezTBRp?=
 =?us-ascii?Q?whRfDwuZpMQoLjacrmoEikHisekOBRA6d+Elkl3VYzfAmv4O47srKkaTjRZX?=
 =?us-ascii?Q?oOdR2wQbQt+mseFAXoWQaATyFGKMEru15bzz3CzG0JDQOvBfLU8G4QJH1yCk?=
 =?us-ascii?Q?KYtcwn+hCeS8X6/PdilqSrsI3ER3X/RfqM2mTfizwbICEI2n+yHMB2aFFBDa?=
 =?us-ascii?Q?bju3vMpPA2cHqlLpmxR2gqiE0Fu4mkB6kj6ZpB55GQn1EaMnJ1ATPzz5hVUT?=
 =?us-ascii?Q?x0s0tkpUqKGHL+jDN1JBiB7DjAnaS3NMLhpZSV32l5be/mh0PPgW6sgPWRLo?=
 =?us-ascii?Q?bRhS4hz9gGm0qqYw1BhlD1m2RXVJxewT0yrST5OU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b1111d-dd48-48e7-48f0-08db84924265
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 17:46:32.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFgSE5KHajx+RolQEdXpIzp/I9gg71zbY0k4baYBTEDaAGJsudyE9yYTajAVVCb7ho3YXEmnhubprvFXI0Z0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 03.07.23 17:39:38, Dan Williams wrote:
> Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > Now, that the Component Register mappings are stored, use them to
> > enable and map the HDM decoder capabilities. The Component Registers
> > do not need to be probed again for this, remove probing code.
> > 
> > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > Endpoint's component register mappings are located in the cxlds and
> > else in the port's structure. Provide a helper function
> > cxl_port_get_comp_map() to locate the mappings depending on the
> > component's type.
> 
> This causes a regression that cxl_test tripped over. It's likely
> something you could reproduce without cxl_test just be reloading the
> cxl_port driver. Root cause below, but here is what I see on a test run:
> 
> # meson test -C build --suite cxl
> ninja: no work to do.
> ninja: Entering directory `/root/git/ndctl/build'
> [113/113] Linking target ndctl/ndctl
> 1/6 ndctl:cxl / cxl-topology.sh             OK              12.78s
> 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.72s
> 3/6 ndctl:cxl / cxl-labels.sh               FAIL             1.53s   (exit status 129 or signal 1 SIGHUP)
> >>> LD_LIBRARY_PATH=/root/git/ndctl/build/cxl/lib:/root/git/ndctl/build/ndctl/lib:/root/git/ndctl/build/daxctl/lib NDCTL=/root/git/ndctl/build/ndctl/ndctl DAXCTL=/root/git/ndctl/build/daxctl/daxctl MALLOC_PERTURB_=67 TEST_PATH=/root/git/ndctl/build/test DATA_PATH=/root/git/ndctl/test /bin/bash /root/git/ndctl/test/cxl-labels.sh

I have tried various combinations of revisions and setups (patch #3,
#5 and #14, ndctl:pending/v77, cxl_test only with both, "ACPI0017" and
cxl_pci_probe() disabled), but could not reproduce this. Tests always
pass for me:

[51/51] Linking target ndctl/ndctl
1/6 ndctl:cxl / cxl-topology.sh             OK              18.59s
2/6 ndctl:cxl / cxl-region-sysfs.sh         OK              12.26s
3/6 ndctl:cxl / cxl-labels.sh               OK              28.25s
4/6 ndctl:cxl / cxl-create-region.sh        OK              19.56s
5/6 ndctl:cxl / cxl-xor-region.sh           OK              10.57s
6/6 ndctl:cxl / cxl-security.sh             OK               9.77s

Ok:                 6
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            0
Timeout:            0

Full log written to /root/ndctl/build/meson-logs/testlog.txt



> 
> 4/6 ndctl:cxl / cxl-create-region.sh        OK              17.05s
> 5/6 ndctl:cxl / cxl-xor-region.sh           OK               5.18s
> 6/6 ndctl:cxl / cxl-security.sh             OK               4.68s
> 
> Ok:                 5   
> Expected Fail:      0   
> Fail:               1   
> Unexpected Pass:    0   
> Skipped:            0   
> Timeout:            0   
> 
> Full log written to /root/git/ndctl/build/meson-logs/testlog.txt
> 
> It's not that cxl-labels.sh causes the error, it is loading and
> unloading the port driver trips over the problem below:
> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c | 64 +++++++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 4449b34a80cc..b0f59e63e0d2 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> >  }
> >  
> > -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > -				struct cxl_component_regs *regs)
> > -{
> > -	struct cxl_register_map map = {
> > -		.dev = &port->dev,
> > -		.resource = port->component_reg_phys,
> > -		.base = crb,
> > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > -	};
> > -
> > -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> > -	if (!map.component_map.hdm_decoder.valid) {
> > -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> > -		/* unique error code to indicate no HDM decoder capability */
> > -		return -ENODEV;
> > -	}
> > -
> > -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> > -}
> > -
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >  {
> >  	struct cxl_hdm *cxlhdm;
> > @@ -145,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >  	return true;
> >  }
> >  
> > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > +{
> > +	/*
> > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > +	 * Bridges. The Endpoint's component register mappings are
> > +	 * located in the cxlds.
> > +	 */
> > +	if (is_cxl_endpoint(port)) {
> > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > +
> > +		return &memdev->cxlds->comp_map;
> 
> ...but why? The issue here is that the @dev argument in that map is the
> memdev parent PCI device. However, in this context the @dev for devm
> operations wants to be &port->dev.

The cxl_pci driver stores the comp_map of the endpoint in the cxlds
structure, struct cxl_port is not yet available at this point. See
patch #2 of this series ("cxl/pci: Store the endpoint's Component
Register mappings in struct cxl_dev_state").

> 
> > +	}
> > +
> > +	return &port->comp_map;
> 
> ...so this is fine, and folding in the following resolves the test
> failure.
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b0f59e63e0d2..6f111f487795 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -125,22 +125,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>         return true;
>  }
>  
> -static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> -{
> -       /*
> -        * HDM capability applies to Endpoints, USPs and VH Host
> -        * Bridges. The Endpoint's component register mappings are
> -        * located in the cxlds.
> -        */
> -       if (is_cxl_endpoint(port)) {
> -               struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> -
> -               return &memdev->cxlds->comp_map;
> -       }
> -
> -       return &port->comp_map;
> -}
> -
>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
> @@ -160,8 +144,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>         cxlhdm->port = port;
>         dev_set_drvdata(dev, cxlhdm);
>  
> -       comp_map = cxl_port_get_comp_map(port);
> -
> +       comp_map = &port->comp_map;

Can you check if the following works instead, I think the
pre-initialization is missing in cxl_mock_mem_probe() for
cxl_test:


diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..4c4e33de4d74 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1333,6 +1333,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
+	mds->cxlds.comp_map.dev = dev;
+	mds->cxlds.comp_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
 
 	return mds;
-- 
2.30.2

The cxl_pci driver always has something valid or fails otherwise.

If that works the change should be merged into patch #2.

Thanks,

-Robert


>         if (comp_map->resource == CXL_RESOURCE_NONE) {
>                 if (info && info->mem_enabled) {
>                         cxlhdm->decoder_count = info->ranges;
> 
> 
> Am I missing why the cxlds->comp_map needs to be reused?
> 
> Note that I am out and may not be able to respond further until next
> week.
