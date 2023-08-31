Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1778ED82
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239985AbjHaMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbjHaMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:44:07 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638DCDB;
        Thu, 31 Aug 2023 05:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFl5Ms9g93ApTgNHoupzu6swP1GxNOFsfEzrl9HA2MSiLeU2zcu6obglIqowEU/t7QNRo9xs8X7CqAfPrvMDQ74kpsubAXQyqPZYuSEJt1DptWLAlhNeSUfm5Sj3rFN9ahgIZKMAjx59UCAVap4KtPPgWNhu+mUb1G4Q4RkeipXPzj3heiw2jfoX+e0KfHs2d1yzujYR618IJcCuo5gpaWPIIt3/TrNCTyT+pmUa1jrBGcKGyn1DBEOV8ul+0ZPA3a1UHdwAo0h0s+yEaTOXznoz3J+f6hOqIpCNPzC2u16Cz2HRTaF+Hjq7cn56ypJPlaWt3gcSP6xNlRN2vXteFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9g0VfqM/vFZRPnxhSK0n8E6J2VT8EdVl/kE4eWG5Cc=;
 b=DXjron5rJxxnt81CnyDid76Al41rBMpLaqBccSEBaI9ROFpXkKmjieFINBuE08NX8F/2FfVsQb2G3RTqUfwC/juQL8tozNoG4DthCMCu1PLqFyGGy/skaSyPGBO61GU3AU7hPzfV2ByJvLqusIwDMOzj/QAgPJoWXc6Wrmh+kCg6t+FwippS7xnsp/mnD5hWsACyiIETbOLcJzJ0rNjhow2ViZ8IyB3X1tYbgHjOF2e/2wNp2zt15pMYLrF4oUiPlA1JosKOKiW/2z5V2pPvyyjmKEZ67dr9NQlxLkN2G50CrKJxQMRj1UvEjdiuUIrNZx0q6dYbL9MV0QR/fyERqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9g0VfqM/vFZRPnxhSK0n8E6J2VT8EdVl/kE4eWG5Cc=;
 b=KNtrhnKmEbu5dXkCzmIdQ3oA1IBi7jT/KI5xT6MgASa+2AgMbxSvxc2Wz3xZvM/93Kt1cec15DL1UoWVkipg9kER3duYQaqHFQkzNPcO9Q4KZRxnGTa/V1SyxgLDlJtbggrQXFFEh//mbBpsxBJdjI5tMv4Ws3fQACPq/WA2Dxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 12:44:00 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 12:44:00 +0000
Date:   Thu, 31 Aug 2023 14:43:53 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v9 02/15] cxl/regs: Prepare for multiple users of
 register mappings
Message-ID: <ZPCLCSngB95EGBMk@rric.localdomain>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
 <20230825233211.3029825-3-terry.bowman@amd.com>
 <20230829145254.00003259@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829145254.00003259@Huawei.com>
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d57228-ba76-4ef6-8e92-08dbaa1ff2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUzOjTOVyf9NEswxjf+hbAuXPRt0fkpxdKjJX9Br3N+0C01cHmvjBQvhpBYP6Z42vt0kwNZZ4XZdUDYLegqqULjDOKXFBtqQHEuZ59E8knLt+JoJKBx58EUHh8f5ktFEWIkRClxL/2uWyR4J5qbvTUtRliBGa4vcX7Mp5zPgbD/uqtNO15pXG8aHxAGyGweOxRtEIuk0QkLZnGmjYCQGuroz8gtqOMiDlpY1kx3tBIzZ8xzC6DEvuHE2BFRKosjsdNG8BI/4zlUQDwQoVg9QOwTspbFRK8ODhC9DG61tiW3HDBAbm/ld7/+VXqpDiFtpXJHOpaVFHHnYwGOx9QOMlv29KDxAIJObk19/gepflZBPXkq0Zz6aVuCjvbQCy/DY2SqfEKobnAYprRhitxaR5Dtqrf67onfnqCMhs1in7OmDP4M7RZrue5MYBegaH50N+ByHy6LsnydW8ESibGf4vZqC9kB9/hEhZ0qlH0KlZmQDwBPSA++XaS9eWk/s6quL29PuqLRYw86zVYePdeJf60VdZOynuzr8Xw6PJDzX0HlYkeboLZwqHwhp+xmhu5A1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(9686003)(6512007)(53546011)(478600001)(83380400001)(2906002)(26005)(7416002)(41300700001)(66476007)(6916009)(66556008)(316002)(66946007)(8936002)(8676002)(5660300002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HtgYaqc5uDHOvmSRkJdnEWskdNj9NPgqDhHwYi+hsz9uBoDwmNSElbSgYOT9?=
 =?us-ascii?Q?pen0h1ZrZHMIaGZRwY5JyeiN+CispJCu6hayqhdZlmz+fAZewHw5d5aVJX6z?=
 =?us-ascii?Q?6ieH6j+k7C2VfMX01/9jb4ml5IauFZQTHx/rx5jpG2V4uFrFUFs1cq5Egu1w?=
 =?us-ascii?Q?7euaBVodISHi+gJAhQXl4ufDK1LDbPNYH7H28eH7tQAGan07AJ/lwFW/ijfN?=
 =?us-ascii?Q?IcdYfHfACrf4I/ef/Krp1+t+KoPFpwp7uKI03h9hlv6il0RjFCqWZMe3k41q?=
 =?us-ascii?Q?helfL9FXqGqJLI03rK6oroTNl/uIzlHpDrCb1eLpJ5T0UV7InWvSUR5VbPpE?=
 =?us-ascii?Q?XZoaQdMLTWOxKJcTnEJhsCPqgNOt7LyOiAZCiqVPKFVSn+BDPtLKiKlHhg+4?=
 =?us-ascii?Q?A0aF9G/mSXB1nx5JKsWD3CiGL8OaOArA4tv8p//fPctdZpaJRlSexK6w6s99?=
 =?us-ascii?Q?onCtIPN1d6hsa3n2eEu/lB5Rx6ot6k99sALjP3w6fonKJVZ8+IcQ8uOlICDG?=
 =?us-ascii?Q?3pLtXBMm6okhlWvvRNVjw1jcFMLjpNeaROcMtI0MUn92iUY6R2og4Yq3fqg7?=
 =?us-ascii?Q?yMPL23bTTNNWkYp+OZR3p0InMlXJdjD7+etTw+CWcOyUGd1m/qZtPupysVtq?=
 =?us-ascii?Q?/zRnt2f60MUwTvugwrNQ+5UKZTrF2PB4sP3ljdOEhsmuj23uBVd+5IjwKP5O?=
 =?us-ascii?Q?GevaDNbA0FFwm972Q6+Rh/9D2FHTQ1icyfFtfu0Bkb252K+RBN3os0WGMjmf?=
 =?us-ascii?Q?RaPlYzP7kE/ey8OObTDTmn6YICBowBE3wSLbkeZYO/0+AOwo/JFU0XgQOmyh?=
 =?us-ascii?Q?25ysjtDig1GFYNV3hrJDQGd3onJYbU6/Ow/xlHd7prS69j7no9Q1Mh4ORksk?=
 =?us-ascii?Q?GeoSuTnKz3BwrYXFwCerncdpx2cHR04qFdvh4a/ETKsyVzi1OVvVXalMO8+q?=
 =?us-ascii?Q?boZJytu77CHwd/UdOF9KilewbkA1bC4TZ1K5qNO4wh8OUHg7DjYxEyMydTJQ?=
 =?us-ascii?Q?Gl/EqYrinPqrx7yJcIoIwJukdUeRAxHBCh1S27ziSk8dzgIa3Mq2evXbZNHE?=
 =?us-ascii?Q?r011zBK9uBJkzupzm+4xhal+abyZhcr+1vj/XwVq6aqbFmlJ25blqNvs9vSI?=
 =?us-ascii?Q?S5w9cqyTm5pbXTRFkbS2JwvVdk1Erpwulfdrrck7bsNey0L5mpHFuTWeLmHr?=
 =?us-ascii?Q?LvgywEN63Ilv6ZePOe+cGGApAHJvi2qgmm0Wo9CfuLTiId7eiFPYTu5aI/9Y?=
 =?us-ascii?Q?NwOg5Vq7mAnQPSxZBGwsZCaYBeYV9+rQ6iXvtiEkl8ae8sh5S9Z3skAMcmqF?=
 =?us-ascii?Q?zXQ42uOSpRzQuvwM5gV0pyT0Od4208lumb0m928n+PWoFgSAVaS+iAxy9e+Y?=
 =?us-ascii?Q?ecvcFjhgAV2q09X0KHbGWL3bSwyRPjATvX7P99JT4GzWpZfIpD8hPF+FhP8e?=
 =?us-ascii?Q?etZkCEPwaV0BPoPRZIhPx7RMO7nGxg5LdnIQdynTuCN0dfZVuviPt0gbGzEZ?=
 =?us-ascii?Q?1Rgu5P7zuf2PU5QRLZ0DDlsfORZKWngUeTBtV3DpmHUFGh4IHeCqsu22Gq1m?=
 =?us-ascii?Q?mYu1La7HmqKeBIK9V4zSFT8hoNupm0KZ1ezzzaHF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d57228-ba76-4ef6-8e92-08dbaa1ff2f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:44:00.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs6XaXHV0IcTxfnHpaVIlJGA69nDLhBmbywcoGq0PefUus3ir3Cr7GtOmFrtlrVvT3TIpgvSPk3Y516GgIW2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 14:52:54, Jonathan Cameron wrote:
> On Fri, 25 Aug 2023 18:31:58 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The function devm_cxl_iomap_block() is used to map register mappings
> > of CXL component or device registers. A @dev is used to unmap the IO
> > regions during device removal.
> > 
> > Now, there are multiple devices using the register mappings. E.g. the
> > RAS cap of the Component Registers is used by cxl_pci, the HDM cap
> > used in cxl_mem. This could cause IO blocks not being freed and a
> > subsequent reinitialization to fail if the same device is used for
> > both.
> > 
> > To prevent that, expand cxl_map_component_regs() to pass a @dev to be
> > used with devm to IO unmap. This allows to pass the device that
> > actually is creating and using the IO region.
> > 
> > For symmetry also change the function i/f of cxl_map_device_regs().
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> I'm not sure we should leave map->dev around after this change
> as it's not obvious where it is valid to use and where it isn't.
> 
> Perhaps we just need to pass the device into the few calls
> that use it other than the ones you have here.

I have checked that and it turned out we would need to pass @dev
through multiple functions (see cxl_setup_regs()). So I left it in as
devm is a special case (mis)using it.

> 
> This patch itself looks fine to me.

I will take it as a Reviewed-by:?

Thanks,

-Robert

> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c  | 3 ++-
> >  drivers/cxl/core/regs.c | 4 ++--
> >  drivers/cxl/cxl.h       | 2 ++
> >  drivers/cxl/pci.c       | 4 ++--
> >  4 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 4449b34a80cc..17c8ba8c75e0 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -98,7 +98,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> >  		return -ENODEV;
> >  	}
> >  
> > -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> > +	return cxl_map_component_regs(&map, &port->dev, regs,
> > +				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> >  }
> >  
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 6281127b3e9d..dfc3e272e7d8 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -201,10 +201,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >  }
> >  
> >  int cxl_map_component_regs(const struct cxl_register_map *map,
> > +			   struct device *dev,
> >  			   struct cxl_component_regs *regs,
> >  			   unsigned long map_mask)
> >  {
> > -	struct device *dev = map->dev;
> >  	struct mapinfo {
> >  		const struct cxl_reg_map *rmap;
> >  		void __iomem **addr;
> > @@ -235,9 +235,9 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
> >  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
> >  
> >  int cxl_map_device_regs(const struct cxl_register_map *map,
> > +			struct device *dev,
> >  			struct cxl_device_regs *regs)
> >  {
> > -	struct device *dev = map->dev;
> >  	resource_size_t phys_addr = map->resource;
> >  	struct mapinfo {
> >  		const struct cxl_reg_map *rmap;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 76d92561af29..ec8ba9ebcf64 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -274,9 +274,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> >  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> >  			   struct cxl_device_reg_map *map);
> >  int cxl_map_component_regs(const struct cxl_register_map *map,
> > +			   struct device *dev,
> >  			   struct cxl_component_regs *regs,
> >  			   unsigned long map_mask);
> >  int cxl_map_device_regs(const struct cxl_register_map *map,
> > +			struct device *dev,
> >  			struct cxl_device_regs *regs);
> >  int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
> >  		     struct cxl_register_map *map);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 48f88d96029d..88ddcff8a0b2 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -827,7 +827,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> > +	rc = cxl_map_device_regs(&map, cxlds->dev, &cxlds->regs.device_regs);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -844,7 +844,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  
> >  	cxlds->component_reg_phys = map.resource;
> >  
> > -	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
> > +	rc = cxl_map_component_regs(&map, cxlds->dev, &cxlds->regs.component,
> >  				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> >  	if (rc)
> >  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> 
