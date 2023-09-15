Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273A7A29D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbjIOVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjIOVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:53:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C9193;
        Fri, 15 Sep 2023 14:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJVoTfFXytUt3XvVkBdT4zvjSGyfM8FRNatqdjxe2PR78j4rkZJv5N9VCVjBl1WQtuE9E3keNHvDc7IO/SciPh3jd1kDVCQ3TLDfYLLHB/SgG7gFVdx1ecidUwazuGe/6CkP3YsM4qQ1tAXseA/vnMAl5ONmTHy9gNF17NYY0MpXVydTJIcmUAuFiDjSFDH+QA/9zBvVeyEThAEZ8VsfhYXv4PPAOh0FR+o4uE+97nw/gpZU8BkhclvPeIiqCBqm/QqPryuxO91CdflA3qQOekghsLSEyW2jt1g1jzHfC4CYx/I6sANBVGXzVQpG4g3jrW15tz4rg073QyMAElZYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD9u2O1AQN1Whbs5d6j8wJxakAaBdZBTxeAvvNKfWG4=;
 b=QwhCS1vEQegq8k3tjVJmlJ5w9udBrijbUjO8bDBkpI16Bm+uMyZqBcT85vZoHhBv4XqIoDLp9tJ5D3FbEPEccd1mkwpBwEsopGwsbWSMQ85Iu943gn+CvHAJRmJYxAp5Mm+UyFZeCR8XKdaHjzYY2OEAc1BKJxI61D2Z5VpXLCe8Uh2kHNqTcUsl/zdCaeS8IIpJFqWL8VxEQCvSeGgMSeKz0XqHgXLvZk3DqZsinFNpITLibeHqr1FZTcAKjq+hwsJXVeI5XWdI7KAWqdin9SJ2HRUJXYnDIV9tLpmDlvGuX8OdUnGXuNo8T3q5GxCnfxASaHFtrwWPh/kAgWwL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD9u2O1AQN1Whbs5d6j8wJxakAaBdZBTxeAvvNKfWG4=;
 b=2VPdsybi0VO0QjwKeKBDMU+E9a1V87Mugc4rTg1aXlQZzeuwVxSqugupOVHwHyAXl8vvaqamH7nf1/St7XJ8VBDcgREoTAVaJGJ1XftX31SqSHlK/LDgaU9GMgc9tzKUlWOOqUIoYBpUVpMRWuMJOE7YOUFqevm19BE2TCv7Zo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Fri, 15 Sep
 2023 21:53:19 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 21:53:19 +0000
Date:   Fri, 15 Sep 2023 23:53:10 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v10 04/15] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <ZQTSRk6gOg41ybG1@rric.localdomain>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-5-terry.bowman@amd.com>
 <64f0dd4c8965e_31c2db2940@dwillia2-xfh.jf.intel.com.notmuch>
 <6503a23013cbf_12747294f9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6503a23013cbf_12747294f9@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: d829c376-6858-486a-bba3-08dbb6362c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC0PsTWAikp2crU/BmcOj3Eg9ydd+RKuF/WK0Cmz30WKRB90RJxsFOxfamlMSq3FtLyP/FjKgJDvzaYAq1xRDMUp2K5gv2XWqxDRs9JPm9vf7qXZtbntK0vEJ9kNWXQZzm8T60JNw+Agp5hlx4ynYjgQjjIbtEZTbraBMxdcGj2e2qolL4zSB+UH576nE0q4C0o2T0nlPrpmuRf3UvKGLCF+vScxLjyvuvW1W7/dMmCvOWF6V60MXHkejmdMhtm4nvYGJjDr8v4mogFE0DOF+C2HMaPAPMS1LwxUf3K7Um/lvKM/PZtSWQ/alM551Kyg3LgijaFl1I/+gbXbX6vfeIEvTolg2ZxnblSRj9Y3Qh7gEp1+CtRMp1379wva4dO9GmR9e6aS3KheHb9vNNylvNu1RSUdOLhqzveNpfmK48M4gWw0buKR4gmWUn6ljTojITruu+Fw6iH2t/PXjexp9opYmY++p/3vkTTovihhL6IRy/1Uqj9/tre1b9CYglF8nIjurTau4yMEuFzm7wi1UgrhfmWRSM8ol2M99N9WcLwiQRvh+EA7J7JUHc35Nwps
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(30864003)(2906002)(8936002)(4326008)(7416002)(41300700001)(5660300002)(66476007)(66556008)(8676002)(66946007)(9686003)(6916009)(316002)(6486002)(53546011)(6506007)(6512007)(83380400001)(6666004)(26005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qppW6BtNOLLTnXLd8M+aEQNaZWWu3ytooOBiU64t5gUKOzop+iA446OqndOf?=
 =?us-ascii?Q?I70600OToe5WC7Ils4aQ4WKthkuDQXwBiMTU/qvyjwBjU/50qkqef1hQyB/k?=
 =?us-ascii?Q?C80jFr5qt8n+8Mo5sJmv7VJJiSaC7ZOuwNTfRMlBZpmKAa3EoqNJHzdG0wxy?=
 =?us-ascii?Q?sQrsFUq3sDCnQpGfb4GZhbJ14pbYXz/O35w1q50iFxGcHumTArGl7czpjL5l?=
 =?us-ascii?Q?ZGY61z1/WRI+8CIaqoAkRQByucaIWCCZw1OQd5YJtqznCamYaKFctlXBENS5?=
 =?us-ascii?Q?E/b07ks1jOhNPy4q4mbVk6/HvXRNwychJGaVL7l/E61oN3ByJ/uypBBaPyIz?=
 =?us-ascii?Q?5sGPpCHs4BWum3bbnnmVtnk58iorNHXcQtSwpbk36qbNcQr6XHtL9g21YslW?=
 =?us-ascii?Q?MJ+Wmbuv5u25TFpcR5uGgt6KrWsiojZQBBWW/vnxPU9SEa+UmV1Bp4M1vtwY?=
 =?us-ascii?Q?DU/x/kV7s38R47VSsPE3w9IbjOg0+Dl8bc2a/6Wy1u12UFV5mu4+9I8jOaFM?=
 =?us-ascii?Q?fkcGUvOiun7Ii9ArEcDEuBa/MVo0rOrDLCXyHBMYgB+awHGzVrFCQ8ONxR7c?=
 =?us-ascii?Q?Xfi0N1AV/dLML/XNFmlmQ3/E2XS+xxPzMLMHQJan0hU4F/6dIlmmqmLeyAm4?=
 =?us-ascii?Q?hSCEqKCpI6Om8sd11U/WvtlxUfHZf0D/whrDAKgfNULJHm0SdiVetPeU5en5?=
 =?us-ascii?Q?jrQlqbb8iK1E/0D32jj/Fv5okxJEUpa/Gp/KU0bdruOCVuW69muCJk8f3Iax?=
 =?us-ascii?Q?znUPQk4wCe6zj+w+OPNvnzqPm3EiNON79EA807GTQAYhw+iTubAcwSTXqcjF?=
 =?us-ascii?Q?mK7UR+B0CfbH02q5LQQBzpcbQJaN7lj+Tt6gsaqtkTak0M/9JeUG2haIlZdS?=
 =?us-ascii?Q?r5mvYYOlTJDFWDVcabrwTLativCC1Tt0aA8w9CTpk/RnX2ZwY7GyBn+RUQ6U?=
 =?us-ascii?Q?i5j1T9R7q57ru2NunsOoh26d3WPNhPlgXHGIoiaaNaiEBwAwc4eQlN0VBdPh?=
 =?us-ascii?Q?Wvc1AtNpMA8mODV8lZaw/Zlj5s9F9fVef+aveF7ZS0V4m2R/gNRoQ/GtQVbw?=
 =?us-ascii?Q?K7/mzndWC2/0BTDrGiTzaxcwLBu3V7gwYjyr4izxFrbH0YUFK5o9lvaF2Ovu?=
 =?us-ascii?Q?DInSxAi/IqMhBkRlj82Cg9xdFoLw+fGRYq9biKE4h441GKqEeVWZuq91Caph?=
 =?us-ascii?Q?8sIwiZL2LqjWumW2uQzxVGISvx16pz9vevzFxK5o9SD9t7rrHizmx/mXks25?=
 =?us-ascii?Q?VdpOKRgZln/rg8Aoo1KqYwStGUcYyy4FVI/Aipdeg+DLKI1QNxujSzn/gi2u?=
 =?us-ascii?Q?m6ELitLG/vJ0jESguAuPAvBr84ObuV3wbdlDefNo7ONvFvNbi3gp0WmWiV94?=
 =?us-ascii?Q?Q1gom3rurTFucv+67nrtKfRpkgAL6yQ8jDB0SSoIH/sdutlcxYxnwEMxc+6D?=
 =?us-ascii?Q?s3gxpPuGO6rWNZZQiogpmFYvOztWlWbM3P4T2LWhqW1tb/a6cviw2/pt+nQl?=
 =?us-ascii?Q?a6lW6flFMIZC5mLY7ZMB8XL2xUkqB+CmHrZGQsSRslu77xBXLtS3WjeFdjA7?=
 =?us-ascii?Q?iHwGVQkOurgjYnKb1m4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d829c376-6858-486a-bba3-08dbb6362c1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:53:19.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL2RTFtSaSDki90faF96JcNRvNAlCGXZ9/oO3YcTDK7/7HrwhHRkbcYCtIuIuavSzdgeu8GYI+Va6eebeDvaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 14.09.23 17:15:44, Dan Williams wrote:
> Dan Williams wrote:
> > Terry Bowman wrote:
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > Now, that the Component Register mappings are stored, use them to
> > > enable and map the HDM decoder capabilities. The Component Registers
> > > do not need to be probed again for this, remove probing code.
> > > 
> > > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > > Endpoint's component register mappings are located in the cxlds and
> > > else in the port's structure. Provide a helper function
> > > cxl_port_get_comp_map() to locate the mappings depending on the
> > > component's type.
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >  drivers/cxl/core/hdm.c | 65 +++++++++++++++++++++++-------------------
> > >  1 file changed, 35 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 17c8ba8c75e0..892a1fb5e4c6 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -81,27 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> > >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> > >  }
> > >  
> > > -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > > -				struct cxl_component_regs *regs)
> > > -{
> > > -	struct cxl_register_map map = {
> > > -		.dev = &port->dev,
> > > -		.resource = port->component_reg_phys,
> > > -		.base = crb,
> > > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > > -	};
> > > -
> > > -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> > > -	if (!map.component_map.hdm_decoder.valid) {
> > > -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> > > -		/* unique error code to indicate no HDM decoder capability */
> > > -		return -ENODEV;
> > > -	}
> > > -
> > > -	return cxl_map_component_regs(&map, &port->dev, regs,
> > > -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> > > -}
> > > -
> > >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > >  {
> > >  	struct cxl_hdm *cxlhdm;
> > > @@ -146,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > >  	return true;
> > >  }
> > >  
> > > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > > +{
> > > +	/*
> > > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > > +	 * Bridges. The Endpoint's component register mappings are
> > > +	 * located in the cxlds.
> > > +	 */
> > > +	if (is_cxl_endpoint(port)) {
> > > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > > +
> > > +		return &memdev->cxlds->comp_map;
> > > +	}
> > > +
> > > +	return &port->comp_map;
> > > +}
> > 
> > This was the function I was hoping would disappear in the new version.
> > cxl_pci and cxl_port care about different register blocks and have
> > different mapping lifetimes. I think that justifies having the
> > endpoint->comp_map be valid for everything that the cxl_port driver
> > cares about even though it duplicates some informatiom from
> > cxlds->comp_map.
> 
> In the interest of time I went ahead and reflowed this patch to the
> below and it is passing my tests. I also noticed some other @dev vs
> @host confusion in some of the previous register conversion so perhaps I
> should just send out v11 with this all rolled together...

just a quick update here.

We were going to send v11 a couple of days ago but I found an issue
during testing, see below. If you don't mind I will send it out next
week with a fix for that included.

> 
> -- >8 --
> Subject: cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
> 
> From: Robert Richter <rrichter@amd.com>
> 
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Duplicate the cxlds->comp_map in
> port->comp_map for endpoint ports.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [rework to drop cxl_port_get_comp_map()]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c  |   48 +++++++++++++++++++----------------------------
>  drivers/cxl/core/port.c |   29 ++++++++++++++++++++++------
>  drivers/cxl/mem.c       |    5 ++---
>  3 files changed, 43 insertions(+), 39 deletions(-)

Patch look good to me.

I have a similar implementation, but did that with a
cxl_port_clone_regs() function in cxl_endpoint_port_probe(). I can
take this version instead.

During testing I found an issue freeing IO resources with devm for RCH
mode. The endpoint is not removed if the cxl_mem driver is
unbound. Then, the resources of the endpoint that also holds the IO
mappings are not freed. A subsequent IO map fails when rebinding the
driver again. It looks like cxl_mem_find_port() is broken for RCDs
preventing the port from being autoremoved. I am working on a fix for
this and will test the whole series again.

Thanks,

-Robert

> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 11d9971f3e8c..ced7801516d2 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> -				struct cxl_component_regs *regs)
> -{
> -	struct cxl_register_map map = {
> -		.host = &port->dev,
> -		.resource = port->component_reg_phys,
> -		.base = crb,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> -	};
> -
> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> -	if (!map.component_map.hdm_decoder.valid) {
> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> -		/* unique error code to indicate no HDM decoder capability */
> -		return -ENODEV;
> -	}
> -
> -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> -}
> -
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -155,7 +135,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  {
>  	struct device *dev = &port->dev;
>  	struct cxl_hdm *cxlhdm;
> -	void __iomem *crb;
> +	struct cxl_register_map *comp_map;
>  	int rc;
>  
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> @@ -164,19 +144,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	cxlhdm->port = port;
>  	dev_set_drvdata(dev, cxlhdm);
>  
> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> -	if (!crb && info && info->mem_enabled) {
> -		cxlhdm->decoder_count = info->ranges;
> -		return cxlhdm;
> -	} else if (!crb) {
> +	comp_map = &port->comp_map;
> +	if (comp_map->resource == CXL_RESOURCE_NONE) {
> +		if (info && info->mem_enabled) {
> +			cxlhdm->decoder_count = info->ranges;
> +			return cxlhdm;
> +		}
> +		WARN_ON(1);
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
> -	iounmap(crb);
> -	if (rc)
> +	if (!comp_map->component_map.hdm_decoder.valid) {
> +		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> +		/* unique error code to indicate no HDM decoder capability */
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	rc = cxl_map_component_regs(comp_map, &cxlhdm->regs,
> +				    BIT(CXL_CM_CAP_CAP_ID_HDM));
> +	if (rc) {
> +		dev_dbg(dev, "Failed to map HDM capability.\n");
>  		return ERR_PTR(rc);
> +	}
>  
>  	parse_hdm_decoder_caps(cxlhdm);
>  	if (cxlhdm->decoder_count == 0) {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3732925162e4..64fcb5b22372 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -741,16 +741,31 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  		return port;
>  
>  	dev = &port->dev;
> -	if (is_cxl_memdev(uport_dev))
> +	if (is_cxl_memdev(uport_dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
>  		rc = dev_set_name(dev, "endpoint%d", port->id);
> -	else if (parent_dport)
> +		if (rc)
> +			goto err;
> +
> +		/*
> +		 * The endpoint driver already enumerated the component and RAS
> +		 * registers. Reuse that enumeration while prepping them to be
> +		 * mapped by the cxl_port driver.
> +		 */
> +		port->comp_map = cxlds->comp_map;
> +		port->comp_map.host = &port->dev;
> +	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
> -	else
> -		rc = dev_set_name(dev, "root%d", port->id);
> -	if (rc)
> -		goto err;
> +		if (rc)
> +			goto err;
>  
> -	rc = cxl_port_setup_regs(port, component_reg_phys);
> +		rc = cxl_port_setup_regs(port, component_reg_phys);
> +		if (rc)
> +			goto err;
> +	} else
> +		rc = dev_set_name(dev, "root%d", port->id);
>  	if (rc)
>  		goto err;
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 317c7548e4e9..04107058739b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  				 struct cxl_dport *parent_dport)
>  {
>  	struct cxl_port *parent_port = parent_dport->port;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_port *endpoint, *iter, *down;
>  	int rc;
>  
> @@ -65,8 +64,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  		ep->next = down;
>  	}
>  
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
> -				     cxlds->component_reg_phys,
> +	/* Note: endpoint port component registers are derived from @cxlds */
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
>  				     parent_dport);
>  	if (IS_ERR(endpoint))
>  		return PTR_ERR(endpoint);
