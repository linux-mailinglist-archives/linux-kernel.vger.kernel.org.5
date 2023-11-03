Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324AE7DFD95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjKCAdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjKCAdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:33:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D2191;
        Thu,  2 Nov 2023 17:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPam4wERpoMx2XcTrJsCRLY7UfjTRD94cKkKzGCM+bNS2F32jbJXfHmYYXa09qD/GhazXwxNynDfIO/HFfX/jHjbYfd3c3MtO4N9SoTvgwsx8RIHz2xHYJyAkAgjCp3Q5PZG/MUoP+iEq+3ZSEFnyId6UkWy5VFAOeBK2P9njOChUzFUr/UPQ/RNatW+IYWnV/0O/NBq+7/vcRKAOnn1AvqFHaQRpeLvqcYSbtoBe9lsgblRYixoGG3cPyRvl4ACiWGV0bVhxCeXiflcdg7z6jBycQERvIlxocdhGRyaWmBNt+dL0Tbv3N9NB4Enchp9M6vkOwZiaMy5DUlSyGbC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8UQw029eRphTr5Gw2Yuj5J0LhL68gTNlDcdwEdNGD8=;
 b=QU1h1CnIeYj79/zQTuNnjF04qASOd7KG4OyxXWDRhytz1Wr/nMKhpUWG8Po2+82VP8FgmuZgAZek5V9pLRfUnQ6+2W0InMGN0NorC/ngpCtYg1QXFrCBnAdWI3YZ0FlaaXgqcSENE6w3P5EPbEewd3EYHtDSrPiH7JkC447S/Og3YMzODXfMBM7lyAy82li4E1qmL4UmLw8UlzzQVhwuD6rhV4UDbF9DKnmJAPfGq5XBXs+2dx/7+Zk8h9lQgP+Kcy7cmPGod9H6v4RqJplwwG07oFiiMt/9VeS+J9yHvq7QZ07NHkjS715Lnxzlsstz4MJdAXllLcZ1lOH+PlxJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8UQw029eRphTr5Gw2Yuj5J0LhL68gTNlDcdwEdNGD8=;
 b=cwBdL7vw5bhimcLylGjeeI2VeU2o/PbKBm+HFmOo8L/qkZSeb8WmfzCvgWYc6Tlf8fKEGvBMC/BnZjRGJdSdOsqZZE+f8/EpoDgm29jGKH/mdhQFGJXTQ9KfE0BPdl+3ClrycIzDPptaRx1bg+5cNJfOIIOTGQAom9TfznCo0wz0tjnEmgyI24th2I2Ul3XnZ+ea1ebnI9IjOtE2l76qeGK9mTRNNIsbDJsia0l8ol+sSdcxZSXm7zOlNqO3I3hHeOrifAMavnyT77OWlwSMMOjJ7HBsh16J5n9uvtcUuMWeCBZ4LEICVlT5X6lULyh/LtPeNfqTxGvk2j2Drtp03g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 00:33:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 00:33:36 +0000
Date:   Thu, 2 Nov 2023 21:33:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231103003335.GB4488@nvidia.com>
References: <20231027155522.6b2863a4@canb.auug.org.au>
 <20231027171522.692a58ec@canb.auug.org.au>
 <20231030182621.GV3952@nvidia.com>
 <20231031161214.25560598@canb.auug.org.au>
 <20231103105312.58a99ef5@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103105312.58a99ef5@canb.auug.org.au>
X-ClientProxiedBy: BL6PEPF0001641B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: dda0af61-8d25-4c5d-6093-08dbdc04846a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h393Q44WcfWeKIyDoLrnA2xGfVK2fT0VHWT+P9WOk8XU8wInS7TEHJq0Rnc7qOXacLdb1zRZZUcJtdkW/DBVAd6bJDTaVjs2/FXS3AYdrVYh2aRw+0TBxPG0SAX9DrCn7T2dFG/lUaX7RnAPCtr5CrW/mrdXJY+4TJOqo1Uv7KPZSWsYb7JXA/zksqI5CodaMWYk4bXV4fhIdiov5taDbEYIz0wKn6dNUvRgUIoiR/5WymBF/LoaxL6qc7jEDGmGIYDH1G3pb5hCZchEgGbNd/6b2wIXVFtOVOAutbe8J2rvBUc32jp2LDKbf83JUtU4F9jvJ5AP1cNi+SwTpGtUxhbkKblaWNh+suLJZUqwFzwNYxjcxcKv54+cTDf7/5UNm7Vg1cHJzuYoGQdkiMgP29QUBi0KbsXYJo22YD5XA3p2q5gRbaF0C0Lhg3Wo7b98I5f1Ci6mNGNQpUYrwWEUB913TlzVPRqHuOm5pfmCL9zlIffYhXBuq6OXaJc59E+WXRupGuQpVOb/6PmeQFiP4MYqAgEM9tF22Sffi+X8C3qtyJPa9JAVOibae5bdw03fvNOT6WdMFp7O7myyxIvgrJndHKGWymnQa4M0ITpI+rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(26005)(6512007)(38100700002)(36756003)(86362001)(33656002)(2906002)(4744005)(5660300002)(4326008)(478600001)(966005)(8936002)(6916009)(66556008)(66946007)(1076003)(316002)(66476007)(54906003)(6486002)(41300700001)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/rP/AVRB2sa0gCyAy03J1u3XfWJ2a3o0VTVxKwS6jcHNZM5GcCxacpnXKLu?=
 =?us-ascii?Q?rSiv5/PSh8TBy2ZpuXKCaBKrrBRQsGeDT4780F689YoUPh3PfZiUL4xhvVdV?=
 =?us-ascii?Q?klUhTwWpjJl5YZVH9ljSyGbN1c6PVL9A5uiM5edGvaq3PTRIEfoAFb+TD0KA?=
 =?us-ascii?Q?m2+PO45LIUpWxKcXKP/pSODBmGMfJispTzxVcJTPTC/Xf9VyyHNEt7/1U+rK?=
 =?us-ascii?Q?3Mcv/pK1N0ndSPSZM1o2gM3l4v82PRaJtujA7DkjcaFjidCEGaEcX+69yaAV?=
 =?us-ascii?Q?IA9hW7tQ9nxjr2cTucOrMnxNw4E36VIkAZvpQoACJkU6oMvaTMyWgsZYtmqB?=
 =?us-ascii?Q?xpUCnxNbtH7r9Pr3ha7/jGYMSBAGnXy1oQQHVbodKnu5DI76daT5QNUGFmaF?=
 =?us-ascii?Q?0zTQowTydvhbMA81eW9PXfedzbueOsrbZ7CzEKq8Zv33/2MbeHBJMHtKPqUc?=
 =?us-ascii?Q?Jj07nadByJT7bUccMSXRYoWcOA5L/BCVHDGPdAwqexFOnsBL6PEvMzykkDZo?=
 =?us-ascii?Q?+U+G5EW1VewohZJ3pgzSwQS+ezL3CvdX+VrLdGUL4e2qnMRIzv0Pz4gimJDn?=
 =?us-ascii?Q?1qogz+HT2RjiFnzDCa0W5B3F/NlRL0SkhZS2iWfsvy60dnu6A3FFR8vc9xka?=
 =?us-ascii?Q?BYEqtYjFGhcdosZ36M4+BOVeqBYM7KjKAYpt1kN2ix46OgalXaMyuw4WhUNC?=
 =?us-ascii?Q?HXylALovpwjP3xmVroJExOaCB8SMsUuKfmQr6DbgSxoYihAl1ibBztjySNzO?=
 =?us-ascii?Q?SiJTkdT73cJqBy443XY4pWAtT1Ru6zXU7ttGzfD0kaFFSQzq7Jok4sil5UK2?=
 =?us-ascii?Q?fm2MkG/GdPbH3gQSsIiJVJ+9Lx62TqYYO1KiUh+kbMuDgMFADCz90qKTOrqN?=
 =?us-ascii?Q?MohHZfV9UDcIP6RJ/Bz80k2nTMNU2wGzRxIiriC5zTnzNNV9ZzPmtOjmuT9i?=
 =?us-ascii?Q?QIx1WSR2Ob8/UI4SJqjbGZ1+6XaPNU7DIVMEc6vxzacXIk55mYuU5MdCMr3k?=
 =?us-ascii?Q?AsWqWiyXD+kLhMHGh7F8wieAYm1yjYoeIFMNl+VFlzfAIkxMftx6W5CDQKCb?=
 =?us-ascii?Q?BmRlDu7QvRDwzU9Js/xOHJt6xil0e6VxzYyRBIXv01xnLfeOo8bY0lM7ddJk?=
 =?us-ascii?Q?bKuFoqOYjhdjrJMla3xwP5xKaamNuYJ0hH/WLXhTpw6j2IE/YIqiJ9Ccm7jj?=
 =?us-ascii?Q?HujjhIosmeMf7v29pCTirsgoFD5fNiIlS6rPjVlVZ/aSrYylxyCI1gpGNhFK?=
 =?us-ascii?Q?7bLiwrDrqHAoa1A8wHgncEXLXYI1HsHCoIsH8VWsIA/yZDYyjZiS70YPZtAR?=
 =?us-ascii?Q?xoCBu44mRbK3BONxpsOwmhT5aJ12VSecwexcoi3eBs4M9k1sAdBQ6AhX8/oJ?=
 =?us-ascii?Q?7sQ/CRoyiems6qDbwCtQIZ1pXnd0Z2PGFJExeaSfJoKpr8ErOAJsW/lXILhr?=
 =?us-ascii?Q?2C1dhJ9/ySaFOgxRhDlGNYYqGEWmxmxBhmcrYgMFfosgDgjLCxB/EjBE4Ko1?=
 =?us-ascii?Q?mcbK9DsGiiC7vT2Qw8Heqtw1RbdAvfnNoSouDuN5bQVFfC7DyNh8wK0wa+R0?=
 =?us-ascii?Q?eTypM5aAGWCkhzErCZo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda0af61-8d25-4c5d-6093-08dbdc04846a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:33:36.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SluTw8eSkrtVv9MO27V5+wIPPHA8Kr8SDVywLcvpzvMkCKRcgwUey+RIJOgLD/Wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:53:12AM +1100, Stephen Rothwell wrote:
> > I have used the conflict resolution below now.
> 
> This is now a conflict between the iommu tree and Linus' tree.

My PR has instructions for the resolution to both:

https://lore.kernel.org/linux-iommu/20231031131417.GA1815719@nvidia.com/

Thanks,
Jason 


