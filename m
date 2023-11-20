Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B877F14AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjKTNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:50:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F53D9;
        Mon, 20 Nov 2023 05:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/3LhmKqsoH16kULP9hsICGGazOLItrVOEcxsnO3oR8Ztka8bkl21YF5bqBKOnImZvRNM4YdscCXPMTNiH625/zvp8HziajhAPgX8nG/wL1zww073VDjlBtdJnbO/2WCCJJe1H+zFTKcd2pgvhlkXeq02kj4FvN91emLnOKWAjpuQWuFFeDU5JBqS71OrPdiymIGMzca0rZKDENEJX+tOkitKRuv1ERPg8VEsNIfvI1w7T2EE34Vza1nh9kWYiOsLRMyRw2MDq5RFaaTsgGwNuXG1Q3Bz5HFWbyRQCNJPvC0fQjBiVFs48QG4nxKWmYME7Rt7l9punwf2UlveDYgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afgkpMEbphgsiZGdKzkqMHUgz40TuvNRTj81X5GzDj0=;
 b=I/oA0hqWDy7Yd4Kr/jICS4GvZyXq+sGkWsnmVYvxAQa7hF1JCpDMJfHXuPXHTT+Tk4rEbbwKnfAnJJjx6So6dQMWL/sJHDL9Ggj1MU53tHA2YOGObUTCjO15hfL+eXiu+igvOFkI2Vjoz6wGkTTVrcYetsf7lQzBC2aSrqGG5foFDpWZj5QN4hroHIYoLHgV/EVpqxY820E+Afvw+bmLR17JnyoPZb9IGHByoexW0/EUmzcL1QxC9mebqQaTNjHAt85Q9dEn8MiRVj98B7/oQfVkjUBeaDw8tFplKbasFpldaGyjcrE0Md6sWVnrKnKT+UcKsm7F5k6Xe7V391yEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afgkpMEbphgsiZGdKzkqMHUgz40TuvNRTj81X5GzDj0=;
 b=pj4g8FHInjQHtTnIL3sK7d1NlI0vilfpVV5JvM4PpLkBX1eXTgs5LotR5FouKzYd+hNzAel3Cv5JUiQxPYgcLvKVNefftgl4w9clw/I15EnxrMX2dNh8jx99qwK6lwZQCIeVWxo/nT3PxFVZYE99MypZVggWrdyCBob4RAN0yzqkONYC/hcxQU5jv4sW+pjgbr/CK8yRpuvONu49av1yM/hVbK7I7P+5QuN/3k/TmW1vGwHMZIoohuat1m6K2rKSsV/dBZ4yADDWO275+SckJqTN4cr9RYEgNvh6IAEDSVYhHNPurqqAYFAmsiLKlzSfuPN7ZZb6uMGDJE3Hnpns1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 13:50:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 13:50:28 +0000
Date:   Mon, 20 Nov 2023 09:50:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     yaozhenguo <yaozhenguo1@gmail.com>, yaozhenguo@jd.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Wenchao Yao <yaowenchao@jd.com>,
        ZiHan Zhou <zhouzihan30@jd.com>
Subject: Re: [PATCH V1] vfio: add attach_group_by_node to control behavior of
 attaching group to domain
Message-ID: <20231120135027.GB6083@nvidia.com>
References: <20231115020209.4665-1-yaozhenguo@jd.com>
 <20231117152746.3aa55d68.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117152746.3aa55d68.alex.williamson@redhat.com>
X-ClientProxiedBy: SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d4a41b-79dc-4120-6237-08dbe9cfa7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ML/del772p75Ro/UOuaMaPq5F2DaEsmddVJkBDJ/CkBLSUpIXQeIETfSajPb21mVQUu+Vm6MsL9e3dEsc2bJFQtDBMOVzAmaoDJlBLqtskkKru67QjWsbdiQhV3Rdxz1AUC0qPTFUlNI0ZmHH5LIvm21kup9a5EWdtWu5qrVWXxfbKu9LOkjbdWXuBh7B9Xy1uGe/EtFK6yILBjgbD6rIC2qv/aWj6kIqBm3H4YTjqgrcpzl8By1fdZTRQKyAq2GFJS4SjCNUS5rM+MDfvZkpt3PAtX7Jth8dPuS5gUlNoIIx0MDHxOXRHAxrzgZb9EL1DjALVkwAa1FF6S6DIMW9eITe3VL5UJaxethpRGPfqQ4SspA9ctjYmgxOFUwZEvmTrk9dYSAd6Ewml5UQz5DdI2r4FC4RB5g9o0v4i8SpdKoiHwWx3xl5sii3st5bhMts9LijzlYo38c08yM4YQuIg7ntmbjwpv0nzOSLaS2ows4qNoVKV9mIqXG3v2sZFuAQuLjYDKXnZxLz4tUxpRfx5scoYLVAYpQu+Vt0196+zJsDIiGdDa/cgvs0HdVMZ+f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(4326008)(8676002)(8936002)(86362001)(7416002)(5660300002)(41300700001)(33656002)(36756003)(26005)(83380400001)(6512007)(6506007)(2616005)(1076003)(38100700002)(316002)(66476007)(66556008)(54906003)(6916009)(66946007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VM074vEwOB8fDqSIHdjuvOl3acQHPIxbJL0+227E1L/zikiknrnBguikNeht?=
 =?us-ascii?Q?h5/RHaFq0MnASUkyf9zH4OoUfW+C9IRxk3NzXtekkgwObiu3WZdFcXaJBKYM?=
 =?us-ascii?Q?wlJJel43YLp8c9VfSCHCCipkLG4efED2uO2nu+b1qmoHhTXNxy5D5omflae2?=
 =?us-ascii?Q?RlPNDmlTzHXoL97xCJrrau6a/h8h4/eppSwoonkbNyIzm2RekgzCwe2iXKxn?=
 =?us-ascii?Q?LS49lmFbqKkgepV+O4xGtHVlmPK8mwEDgZDnpqhbe6e08FHvisxljJsPgjsg?=
 =?us-ascii?Q?cHoUqdWFAuHCqyqfJfhJaRSKBMo//bLod54UN7stysFyZ3N7YtauxWnUN+pB?=
 =?us-ascii?Q?7usOMmk3LcSGZTO1ud62ZlAArrSrRr+7cRpvNLmAiOniJQtkGPo8gMODIQGm?=
 =?us-ascii?Q?YMze1ACl+kEiFiCDmMSrDDXE/y4nVvDrJ23hBlawuf7tDDFCB+bE7uRzZX5O?=
 =?us-ascii?Q?CLjIhAx44kMNoqqOmQ3X9Q6mvTS47y4hYyqivCpLwN9tChDuMpa2kpVVV9di?=
 =?us-ascii?Q?439rkKp9PaYrmkjoIqeVhWFrfHeKEMBEFDtXTBnwKfbjRG4d7ZChUCl2gB2y?=
 =?us-ascii?Q?fdB5pWKdvV9J8wPykj6YM3SdMiDul5uu7GZBTGLYi6AEYCxrDrpxJjRoywhH?=
 =?us-ascii?Q?1IG55ptLt5BgoxFpzSdVAAumIKJeXkE4wF4kduIg+bC/E3sRyFqBg3cp1x09?=
 =?us-ascii?Q?TJwA9kjkbPgo0xXkjL9K1Keve4bJ2w0f0nC0Z5onUFp9hDAz+UBaF1N4AVNk?=
 =?us-ascii?Q?ofw9fuYmwE2u7X4PeIqido1owENlXXt6d6aDZUBu+L0SSgGUcks9qffpmEY2?=
 =?us-ascii?Q?PMZuRD6IFuwLJ1tNh6HOmajvYUvQIHeLBLBXbfXGdDHN7HGokoQnUEQxZGah?=
 =?us-ascii?Q?KWBqrek74V43vNMRgg4TNIOH+WYu5KmQ+uen+Xgr37Lhrd4HILClT6Nc0R9V?=
 =?us-ascii?Q?JQxdv0YHfd4wnc9C4LrpLxjlsgPF5CyoacPQLOi1cip0Lm05AYAAJBB0CWxO?=
 =?us-ascii?Q?CfPJC8lfLA0qzuUmx0UXp6Z0xgDbjYhmfbL1w8OnJSQq6z5Ab/MTTmyafeTC?=
 =?us-ascii?Q?zgGSQ4uW2W/JEzS9zPiQJHg60ZewNOOKV8p4EysTjDr5VN7T9A/ZSoCJRHWx?=
 =?us-ascii?Q?F3w46fNOqYW/6fSppwhtiSZKZZSru6/5Pa62Sifz6gMNmmFQmd9IWr2oO2WM?=
 =?us-ascii?Q?2gPBEIzjUQh9UpIEsm/DtJKu5ce+6w0GuTEP19EMF6YBYi7sF7xZFyiJw8jx?=
 =?us-ascii?Q?/B8x8gwO/WeyDD+mX8+jaoNuCp58PHTdolBKhanySpyy6NSWu3mZTJjmbdCb?=
 =?us-ascii?Q?1ay/tz0cJGU9rvbDZ65muumuB+Qts/1mS3eMFD2ajhaazF6nIKmq34YLqzVQ?=
 =?us-ascii?Q?Egkmu0OvdKeMlB1ZBNwrFwO/voj3Vm71LyxzChwQF1Ep7ncCNp+iJR8Efpff?=
 =?us-ascii?Q?QN8e8D4Qcbwye17KtnNpvHGMFehDGZMmHtZUkrsqYMN5xz+NoiksL9erSEdg?=
 =?us-ascii?Q?3Vig3H3OsNjnP4107XKk5Su3aK2z0AY5hdQLIB4QNfWGm/prloEdU296iMEg?=
 =?us-ascii?Q?2AatvLnhAetC+FMrkUI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d4a41b-79dc-4120-6237-08dbe9cfa7ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:50:28.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Z2qd05favWayvWP76rJ4qMpLa+PKqxhl5OWwps/2j0cbgpggkbKsKTWwSTh5lCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 03:27:46PM -0700, Alex Williamson wrote:
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index eacd6ec..6a5641e 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -59,6 +59,11 @@
> >  module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
> >  MODULE_PARM_DESC(dma_entry_limit,
> >  		 "Maximum number of user DMA mappings per container (65535).");
> > +static uint attach_group_by_node;
> > +module_param_named(attach_group_by_node,
> > +		attach_group_by_node, uint, 0644);
> > +MODULE_PARM_DESC(attach_group_by_node,
> > +		 "Attach group to domain when it's in same node");

Definately no to any kind of module option..

> I question whether we need this solution at all though.  AIUI the
> initial domain is allocated in proximity to the initial group.  The
> problem comes when the user asks to add an additional group into the
> same container.  Another valid solution would be that the user
> recognizes that these groups are not within the same locality and
> creates a separate container for this group. 

qemu using iommufd should de-duplicate the IOAS though, so we would be
back to this discussion.

Regardless, I agree this should be handled by userspace. The kernel
driver should associate the NUMA locality of the iommu_domain to the
first iommu instance that it was allocated against.

The explicit HWPTs in iommufd already will allow userspace to choose
the appropriate locality. We many need to expose a bit more
information in iommufd ioctls showing the instance to device
association.

Jason
