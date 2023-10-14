Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501277C91F3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjJNBCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:02:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E25BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 18:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgSRkDeNAXzaGZ8m4jTbiNgzMDme0LHMP2G+kccpZO+KLXAr9gKbfLd04kaFeEfV2s9tK9tzui9P4AAELZIOEokda3oEguRGjmRKgEuhgMtCMlRxJe7qZrVbmZ9EUg+3J88d6drvOiByoM/btEfd1NtjUETt4p1SErh/KgKUp8ZXslkDjoLclBCVT31CedZbzQd5LLsWaHrYvlxKxYR2aj12VKeE8G8yn/2R43HfVKnYSgRcF217NlPknsR7WFhLuP5dkZO1Ur4KCbXuDhnAhD3BKGCTXMzZop0ZpJQsbbJSVJ54PWYigkPgLDAcVG0U2qg7WiC2KrS1sVyQNftAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWElid/sVX27Vke5EpEKw9XGh4o3Tyu2gIgo4ppOvD8=;
 b=LbWTX+/320JK1CPZAcLJQi6TkVZGyDs6NVtu/eqkTmAVaFKQwPNWLAGqHJO4HUT/6Qa8lnHRs75wQK/bRF/zW2w1zaQWg7a0ZZGZhwgxdwihK5esHIsju3sDnCaftSrG5bqPRKQyT8IxooK4ftaj6Um4b67pjwFiBGBPWBwZn5eYQhtNqWcVtKGckjlmrYh03j14i0MHUd6vrESbRtnKPbwIN2ItRRkg2aDe4YZk4GAguRGx2Af/2eHFRZoAnngO1X5QglaJFDvcuq2nMnsjD93FKafdIM1HwZKisski2JWghhjMyPoxvtokZ1PMBCX2rYZ7O/YOZgbjesq9p9thfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWElid/sVX27Vke5EpEKw9XGh4o3Tyu2gIgo4ppOvD8=;
 b=Ifj/EnYQJFHX+kDCkILfHmS5XtqMviPSkAjdK2TMHOPfOXRt1hzYyLVKeLkJHmNjUq6/RlJB5MSchVdI0Um+QwQpdFe8MtAaeShtmmd0IgU5UWWCbl04XHsVELOms0fGZYNpsXVqDAOhexNMXOSnTI4hcgQfSELGoJSjwYWAE+u+AzTRQ/8cZOxfdHPGkM5GhvhdhvNw6Tx6vxVfKFm0n6SSnYcM5TJoE4/+Rxrepk078/Ylzhdl6YYZ2GNHrjXFWvhl4uMEOmuDH9RZpyvB4yNo9dHgPpmI+DoEcRzV4HP1TYrfrEKzO8hn/xmXVA84bbasvi4RnJV3gSZVTSqBBQ==
Received: from CYXPR02CA0012.namprd02.prod.outlook.com (2603:10b6:930:cf::27)
 by DM6PR12MB4974.namprd12.prod.outlook.com (2603:10b6:5:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sat, 14 Oct
 2023 01:02:09 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::d5) by CYXPR02CA0012.outlook.office365.com
 (2603:10b6:930:cf::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Sat, 14 Oct 2023 01:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 01:02:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 18:02:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 13 Oct 2023 18:02:03 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 18:02:02 -0700
Date:   Fri, 13 Oct 2023 18:02:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZSnoiPBLFATdtlpk@Asurada-Nvidia>
References: <20231012030112.82270-1-tina.zhang@intel.com>
 <20231012030112.82270-5-tina.zhang@intel.com>
 <20231012134310.GI55194@ziepe.ca>
 <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>
 <20231014000320.GC282036@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231014000320.GC282036@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DM6PR12MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0183b3-dab0-4436-1179-08dbcc513134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Z4TgFahWVr3n6fy4VQCU3HHNUU+RZukeiFSkYeo7QsDXgtuOJ1wdSY2sG7ZLgPxRIkOe6WAKJOScL+0WuxnOhOiCqzX9Qxtt8h5aPvbPxSEZk02fRPdtewF53vdnP78EUHfksdgtDzsg3gj1UKNlwoUsHrp1cSjehWhIoLBFHRvi8Rbe0Cl/ZteAKz/sJgLAxJF3o5PVPO/AUY+PpnBQY/ZKnhwXQvZ0I3Bpio37tIU/EBGfzI5GwvFsXX4uzTqI/7wO3vdnbOCjlqApW3kSi9OjCcBOp5yqtbT1y5szVfoO+jMgEvRxgkLMGnEaAPbyIL+EDS/Avhh8O9vO5r1/Fg63UO5isQON0/5YqGwI4f/fGMg+l0Uk7EohuHX9esXfecxHbCb9+S0dEN7Z7Ks0e/xH7vgFXoJp6AUBGyEaIoFvGr4JahMGjyMSpoLX4OMd60beFekmqPUGugulp5mDN8Dw5wpA5zwsna5ZDJ23z/OrNea4vrU7f1dsiPQvhBqq2/u8+qnOC/8tb97NHSCiwDZPNGuQ1dXdb8n3Zb1SxyIDHV1+zPJpqx7TMtEeAQNYTfOzo0hcE3xFuAEmAkaOEUjuWnTjuaEY42ASzTK2X9Oh1LUoJw9UXydJW6cqTeeTq/BIc58k3ojdhvIy8agm0XtWxcRcqlTYC3T+3PWcmM/dKedkGUElqz7MA9O2C2Lp0epmkqSGZ975bVyhTNdR2w4rlk13IE/RnjHwin1OxXSXEMAiAKHZUfz1OCri5uh
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(9686003)(478600001)(83380400001)(336012)(426003)(316002)(26005)(2906002)(4744005)(33716001)(41300700001)(4326008)(70206006)(5660300002)(70586007)(110136005)(8676002)(8936002)(36860700001)(47076005)(86362001)(82740400003)(7636003)(356005)(54906003)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 01:02:09.1876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0183b3-dab0-4436-1179-08dbcc513134
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4974
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:03:20PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 09:57:30AM +0000, Zhang, Tina wrote:
> > I think I met some problem about my mailbox when I was sending this
> > new version. It didn't cc iommu@lists.linux.dev. Should I resend
> > this version again or reply to the patches with
> > iommu@lists.linux.dev cc'd?
> 
> Tidy the nits and resend a v8 if addresses got missed

I was actually wondering why it missed iommu list. And it likely
missed those maintainers too? Perhaps should run get_maintainer
script and add the person who's going to take the series.

Thanks
Nic
