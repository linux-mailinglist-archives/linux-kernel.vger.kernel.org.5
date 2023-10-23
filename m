Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91E7D42D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjJWWnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:43:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE5DF;
        Mon, 23 Oct 2023 15:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbx+w3R2WlWT5wxbpV4qaUuJfJHX1/cXtMObMw/gv3GRdnut9wXq1bzPC5qwL2EkWivX/tggaUPuSdeVZozPMyU9oSy2aZp43y7n9AUEcB3CpKgQ284EqlcadghvwIAb8akRtQsZvHRSi7/B+mQe6BnI30SkvCltJXUbpjfgw3LFVfzF38sq2Qecbm7j8oK48QGKMeFjuZx4uTIrSF+ddKEkfRgybbBRqdEb+68rhZWMZSxvXo3qE77dQ7ml+lenk/uGqI0uOdLHZ8wpi8NYJXWlPaC9lP3LPPgD1zy+qLnplwK1eoCYv46UACVg/JEitDvbh3+gAH+0fMqk5WetGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPy6/ezeWf9IoQ2g6GIOJ4EtuUPlJM6q+7ge7KwDLKQ=;
 b=eZIfEN64vNTRv8V9VJSBRL3AyXYKoYK8d2r+9noFQundTYFJkNQ+NoCNybNH6/ER6ctkuH+OcwrXXB1EwdunSBSTxknlgWdvqhSgduqu9eeUzH3b1im+aeXj9jDYznRZHo0ahEbK2w2f1CZ0RGl13i25Lq4ddWHaA9gxk258VgO87FjUzkUUVge6/botcqkvC3PwYWWzebfI0WbwhQEd4xoAJYgq0ud9TkQM2nbYcMtJT2l1Sapucwk/bcTFGW1UPRlydR5SQvk82Cr2/oeVCtBavtD8ZJ4p073MuslenCLS3hBxZPslSlF0A4qnwpHJyW0oRfN2skpac9kXXQz89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPy6/ezeWf9IoQ2g6GIOJ4EtuUPlJM6q+7ge7KwDLKQ=;
 b=Nf51uFKMQKkWPPrY2vOhGZCFjgHvMAnF1NMdrBi7trIKeUfEu0kobNCyBkO/2Lb6EUMW97xtSN8e34unfh5cbYcCPGpQZgRxvM4+wRSHlnCoBqoKVO32qLSlinTr3slGBUkGPteFCKvZT3/qJpd5T9XkTlXma5+zWJa2CH80ntCKhcfFsy7EQxxjK4PraSZdSUnIxRZd6AsFcApVu5MmZNXklUTC1PfWPaq+pKx5z2hfBBl/+g1yXnOaGfqf4sdjgblvrjV++8Bg9HvaN9AyZor8B5pC//jA8QRBgXeSZtHTJMX+MV+TW4Y2tjxs6u2AKvsx9EMAcDDG6kRboGlyqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 22:43:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 22:43:08 +0000
Date:   Mon, 23 Oct 2023 19:43:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: Re: linux-next: Tree for Oct 23
 (drivers/iommu/iommufd/hw_pagetable.c)
Message-ID: <20231023224306.GH3952@nvidia.com>
References: <20231023165831.30d525ad@canb.auug.org.au>
 <9e56e94d-536e-435a-afb0-4738e6eddedc@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e56e94d-536e-435a-afb0-4738e6eddedc@infradead.org>
X-ClientProxiedBy: DM6PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: f201c7fe-8a2d-481e-8881-08dbd4196db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXdiYsf8kioIGsWOz1xIkBa5P3SHHfyovqT8FzbiOxxXPVlZFYobWL/4jB4y3LhJB7j0wZ+BCJuEw6k71zslfql3ZVIVtdmmOgA1318egY4qqbhu0DaWiGeXRjF+DlZaiVvHSeGOH9QnhNY6wVGhIFSdHKmoaroqG92+8es1jnxgKu3kk/72YlOFvx993keFkjJWqxH83WT5YDIDlCVUH00pJ/KWWBSPiWlDvuO42ZlmApSLaO0ZOjNWdwPqs3+RtTjgj86yWV4/RDfo6Zd8oz3lhfQswp1AaNpoX0y5x6BpNxgxojMiV8wdONLxEaQabmohcWZG5sAUBrf6SLWyL7lXMEwF42Ccz7y0ywHaZT03fU917FZgkKkEknaOHA407gDAoZkbZZBtgMD5mnWlwaBTm2NptgChA/U8dQvfgma/vvCQZtmCQGbpGDGv0JW7+kCjvdj4GnxXFK8yODoiRH/yPsWw92Akq7fKY6+IOC61ZoVj0XDuDSW31dnwj9YzIcFvYNAb+YcW8Sk0Aof56fzZ16iJApiaLX1M03DzPOeCiGOQzKqdaCFJLRQc52Z5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(4744005)(2906002)(5660300002)(38100700002)(36756003)(8676002)(8936002)(4326008)(41300700001)(316002)(66476007)(66556008)(66946007)(86362001)(6486002)(6916009)(33656002)(6512007)(2616005)(6506007)(26005)(1076003)(54906003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6AEsEWPuAQBVzBEn+/6VZYftHoLA0p/doxWn4y0k2932kdiD1ueRVZUijWnQ?=
 =?us-ascii?Q?mzxQe9NAMgrmEkNwbq10jQIt9yguT9/tjAjOjIrIDFNJrxrD3lMjcic1m6rN?=
 =?us-ascii?Q?bMNC5LBkiA3XM96de84cMAAp7rYkBzDUYMutclt1tP/o1bpZsJEBAhDknVLz?=
 =?us-ascii?Q?vdvng0xKcZ7mCAs90ypkqZ6Hp6Bu0rxiNIrI4EH8+o2U5WrGxCo69MsjMlkm?=
 =?us-ascii?Q?1PdP9dO9Id9LknUSB1x9IbLReDquv7JzgR0r+kFNNYjzXK/PmDnCETdfUFlR?=
 =?us-ascii?Q?fNbg9lZRh5liMYP3JcdVIrrWp9Ve7oo9+SzwJXtOVEgeuAj3AedubqIJLQtR?=
 =?us-ascii?Q?04b0xsrGV34z+wy7AZ0pJ9+Kwd6PQcEa4VbDN8TOvF8GlMasEmfe7qO1obgE?=
 =?us-ascii?Q?+H2AOuKvilIRh1eIEcDI8/xAMcWChJCOqLguS8T657zz4Ny1WCOc40iUK3Ps?=
 =?us-ascii?Q?wjB6v7VbkL0w8j0semk1y/V9sBLHdsjEE/UJztp6i8QGtqwwaO648bwFIYqF?=
 =?us-ascii?Q?0q3a5H87uAw1tHgQBV6b1m+EzhvS/BtnWn2CUcnNwyBDzgKrEj26xcSzmPmv?=
 =?us-ascii?Q?P6qCx6gcMyBXBo7rNmbqPgodth8Y1s7G291pyAeQog0zL6ZkuzIemSjuAdR4?=
 =?us-ascii?Q?npLZf6Tc37tCvqnEeuVjxFlsjZ+TQ9n5kIHQnVE2XRh0Gu9dtEA3Sr/Ge42O?=
 =?us-ascii?Q?Jgqn4jrCn9wrFTjmeesccTeFVlPFB1VE8SPT+N5xtW3PAUa/9x9GIT97IG/m?=
 =?us-ascii?Q?KP/JYFsswANwUDG2Ztd0A4g9Z9yZdEW4CeN9eIMKb77Y/mMk/yTyQ2HgtRee?=
 =?us-ascii?Q?J0L+1ZIxwXkBotyIz3nGeBYGy7im4iywP0dcg9eP81RUjbLfkDZLzcT78Cvv?=
 =?us-ascii?Q?41L1yd5Ie5BTNd8tpNMHOzI8QD/s3l8Tzr2ZHDIrFxIVe/xgNK61W9bcHYrn?=
 =?us-ascii?Q?WIHZIHYdIiPO3nss8xeiVn4hgJSvUzy1xHvtxYOAbm23XpDysN25niF3sqBi?=
 =?us-ascii?Q?FsWgv3nnMWgWnipPwYARk4V80q7fYcIOmcW0g0SclLE8EGYkzUN2yiIM1MSo?=
 =?us-ascii?Q?O0lWBteZRRnrgFl2N7XPNOs3U5BI3NWuD7XS5bf9+NynI+w26N3UVJscGxHk?=
 =?us-ascii?Q?wd6J0Lv5coLB/j7NDDOr0DBN/bgQSqbB7BqVRbFbbxr9l7MMZa7jsZlpUd/t?=
 =?us-ascii?Q?zJPAngKSgulbrAsBMC6XHfcLYeTnz1gRzpX8m8kP84seJNvHhytdCNC4rc5h?=
 =?us-ascii?Q?JTc7QsoKR8xJgDijDZXvn5KbTUYk7dbblCs1PbJf2xeQrmcBGXX/U/dEqUuW?=
 =?us-ascii?Q?RQ12IIUDuPvMfNuOR+IqU5BW2WG4KWgFPQAiBErPqSMJuPE1Dx7EzeeVcj5O?=
 =?us-ascii?Q?OSw4/DarNRCappL3vKFa5TjH3Kd8NV8DKUUeNkEYeLuk3jko+XFZRdqKidyI?=
 =?us-ascii?Q?ynX9J9bN4PHx0Fs7ix8KvutYTMiBaOR+qf73fuE6fEnrZyjAp64jar1iaHRM?=
 =?us-ascii?Q?U1/o4pqYObj0p2MRGiE1/s9wIEulNbwShleSM8d0+EmvFxdAVucdXohg13dg?=
 =?us-ascii?Q?TuZ6YmiqzmRrGK7k90Bbd2BsG0TfACI1svBOSjX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f201c7fe-8a2d-481e-8881-08dbd4196db2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:43:08.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEB0O+zFbq/LzJfkxsKICFO46xLyZsAymHTexDwHUb9zv2hqadyvpnFp3Ok18RY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 03:27:15PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/22/23 22:58, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20231020:
> > 
> 
> on ppc32 or i386:
> 
> powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_check_iova_range':
> hw_pagetable.c:(.text+0x90c): undefined reference to `__udivdi3'
> powerpc-linux-ld: drivers/iommu/iommufd/hw_pagetable.o: in function `iommufd_hwpt_get_dirty_bitmap':
> hw_pagetable.c:(.text+0xa4c): undefined reference to `__udivdi3'
>
> Is there already a patch for this?

Yes, I pushed something temporary, I think in time for tomorrow's
linux-next, but I'm not sure.

Jason
