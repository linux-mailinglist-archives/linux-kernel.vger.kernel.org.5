Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022297E7483
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjKIWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjKIWpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:45:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4C4211
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmAeJKaBMCBQAE55V3ruZM+tjXw2YnVWg6pNeYr6yFTuBtPRFNcCYLD9ioQTl94tV6zeKsRPLz0iE9FM9S1+rjSa62WshwetZY6+A1GfO6lvzOKBQMYU6vBfLYW8sG56hhxSD5SgME8xUiOib4KOdZ7Q+K6ZmqkTfYkwI/wjEw5D+hOpoUmvQ4NMzdhr2JDbt/EexSzHhKmaR7JJ8mwPSuO0S2SmwBmrl1U5FvAf+nCP6C/er887sjZJoAJUblGsc8y6v7sP1JZuUcGkcMbmJKO3wq5uUNt/++L9VxVPT7Mm+xmK4eahXrCJ80AiZsQkgd9JYRh2j15wL6igAFOB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSGnsvMmu4XIJfJuCRCFgDjv0sfCsq0BJtH4wiAG5z4=;
 b=IIANNw4ds9GG8sT1Ui06X4Io2oJldqiErTFS0SC8vgWaCDKEul5SGVZFuCQihHL7RnBnftf8BMpSNFcBf3AMOVKK6HJ5EJUYcwtwcOUEATblIjKECYcwuA96blWeJEjRX2Gu0q4qYWMtHMa5U+U7wvK3eK8KBR5emAMgE5ybI8zJETeU63hv7B500lza+lwHCD7eJ4y1AQsl+7AnW7BY1nF6NIRDa8VQ5DqKp4lxXR0mRW8ZHBXGIXT3lcaEvVXcEyQYdFc0dbkEFKhWe3MEBlBgfU9mlQk4ia2TyA06xgGY3T2AnBGQnYH0/3u0UwhRZgM9YBelClm6iGBnXdfvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSGnsvMmu4XIJfJuCRCFgDjv0sfCsq0BJtH4wiAG5z4=;
 b=M/RGqnejGiSSl3dZlxC6IMqKL38qOEHQjr+jCyMJX/eYwmnA9xS0SwLVOCsJeftIIuQsma4AwVDazYT+JLTU++zjusS0T211iZjPJMvSK/XTIbeBarRbAEYD6hUU32qjF80S/9nTfmGiDLcrtPyaHnx4DJ3I427F4ZhL2hgzPSPIU5CqrASkG0q2JGHuQKuVMe4XVE1Axn02lx5Z4yQ1dhcZ8xExh8cwCdQjf8c6YbBnAoxJ+bNIciYfBBjkFwpVEevnVjuIuO/eeuxOJBJ+5e0MnBL9Dcq9Sl6zlrpO0n+Trtz9iZ5sqODPpCRkS7/hOn41ohX20xWAKOQo8uRtzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 22:45:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 22:45:47 +0000
Date:   Thu, 9 Nov 2023 18:45:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.7
Message-ID: <20231109224546.GK4488@nvidia.com>
References: <ZUkXojmVf2CmkXHh@8bytes.org>
 <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjHyBy2Mttaj8kySJBpZ9hUiCe09ZJPo8trCRHfhi7NBg@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: a77a039d-0745-4b62-8f88-08dbe1759da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38/k9MzOiq+fmz1OZhAA/S1XnY59RvLDuKP09Bt2mk572CoBbOEDgQW4mDWf8g1CtP6i+VES2AmO+ygKA8wr50vlFyJK/5ISS7J2b098bDPvfp85n4yqH+YrzH0guPDN+jZn3RGldqzjy0yDloFT1yTv44O4HLH4ExJjIwGXknf+/AjORMVX5yCGy80D7qDyH/Y4q+cRIyMopg5DYCpNc2GohQjvc0MVtkkgFkIxaSdLkjnDX4P259w63HoksyQ6Zo4TnXJqPw5YdLhYNQlx1IW41cJeFoOLPinNL++KNWpN2B0yANWFBl0WZO1ZNUhHcCQPWalW+eBV8mnUsLTEGBsJE9xHiVSM73wezsuwO7z8BUMem/KMZu4aSoFlfLacylE/vjSUFqhXHBZ6d4064AhA23Q1hzhVBaRBuWwXsjHLO6WKIk9dUbhpxmGcLYj3weoh/iT9lYLKz/jycx9R1NhIYmj6aevNAELfmTK3uHOb+wXrW05sljZyQd4xj62z+prZYIhUnScK3otcJK5U5YTe2tayVdSTHl4a8mobfXeh8v6h5DFefq6GWRemb1fm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(2616005)(1076003)(26005)(83380400001)(66946007)(6506007)(478600001)(6486002)(6512007)(66556008)(66476007)(2906002)(8676002)(8936002)(36756003)(5660300002)(4326008)(38100700002)(41300700001)(4744005)(86362001)(6916009)(33656002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QZFhpNOjQ488w4Pj/lbjIOtCp8PmLSAISEw/1mT0uiDs3DF0+/OgAN4a4iJK?=
 =?us-ascii?Q?fjDC6GIYmJCI8oLPQP68yMFqlVsYid9KEImUi8dMhiMDIAsAuAh1Hj++/Mgw?=
 =?us-ascii?Q?enV6s0ZntpRD1X61k2EBLo85bNWEDn9+GmvzlW5hrjAhId896pAMsd0LenL5?=
 =?us-ascii?Q?mpSBajIsCVtGZCeIRixZJM+YnkLXHEafuyHTdHw0vwKcOdiPBNtjsaQw8XDP?=
 =?us-ascii?Q?tfnHRUPjURV78MgxqkLYs+xX80ceQIJZnamLKW1xbWhwDiM1hg9nS+ZGre+i?=
 =?us-ascii?Q?g9vkrnPFoZBB7SP6H14tWsVz4snf2++OmwppHUWi50NrHzxQpMxCUGv6rs3w?=
 =?us-ascii?Q?V8cLHrzdjZtvcfTjlJhm+wn3PfdNQAJv504NAVt+lXt+u7BXwHk+fScsa0US?=
 =?us-ascii?Q?s/1mUjl+USMp2qct4zEXh4xXCRbcHOvX2r4z9Aw3PRU3d/n3bHVx7uuXwj+D?=
 =?us-ascii?Q?aJ/J4IK/JxulklVViojmx0SIu1EZsMukinxo/O2q5MUWMB996h/Ldi/Uv00O?=
 =?us-ascii?Q?Wnxv2Fq+CTSvq0GkhQlZAgs8dVkSxlST11sENCxF5wB6JmzuTANyX3nhZpZt?=
 =?us-ascii?Q?hribgDLcih5WOGA58bt0XjC3FsRS6BkcaS9tO2LF7rtSs1lm/VIx5kyl+8Re?=
 =?us-ascii?Q?iqu9fBL3188BCcGHpIog4i2wqcE3y8J3ST7hm3wpNWVmOh/jxfx/wuGubx2l?=
 =?us-ascii?Q?pAo7NhTlF060xTcp/ukKn75YbQOn+qG/p80gmSQt+Ps3yCLKTmfOQq2NDB5W?=
 =?us-ascii?Q?IS5NiVmUWRFDxd6sUrSH60XLtPAbYdsmbiTSH9zidM0gIgJGIzt5qP6b5Zvd?=
 =?us-ascii?Q?+T1uVvxMwh2JvF3+dJ8UF8v1UIrQX6jkgU7jLVSFrwiJb/K0+ZwCuZXtE0tq?=
 =?us-ascii?Q?IvRdVa/HH+owArIrwLZguB/agGJAllgz5FS4rs4yZh6SCANIgIBLsR7eoa75?=
 =?us-ascii?Q?4UwsFdNXaYL+HMMlFnqp+AwcB3cx0tg3dJ9gQenkq3eKhHeCmmT/PJWADUoA?=
 =?us-ascii?Q?nHfLrtNGcIVLIybj9+SwE2XzLDTSheR+JEiTUwmrxxRhJ+EIy3Af+xdu8u9t?=
 =?us-ascii?Q?Nlw4rIaWu+JadTMHUqWPkZ8KZhRtSaUfeMvYd9s5KHQ5dvNXz6ZUlMnrxB4q?=
 =?us-ascii?Q?X/SPvOV9DEwH4TbqD2Ah6qFqQT9pp8MymFq6yb0IVnoYfbKP63cts8gIAjMX?=
 =?us-ascii?Q?/sma1YGP0AJtlfjPpNWowW+JExCktzlZ4LGYkZ5wAsuRzCPiq04kAT8L+Nrs?=
 =?us-ascii?Q?hc9Dsns566fSKpe1xYHlVZPgAmZFBRPuU+v0wzYaLi/HAFC3lKErgGGhTsT6?=
 =?us-ascii?Q?Fh85WQVfnkeKJYfl+J2L6GA1LfmzydcUoVVRBfdY6czOg0RK5fjh4/BE9pVS?=
 =?us-ascii?Q?JjfdYILFnAaq6zXstQZRu5Y9qQR0oIN6Mq2XCCWhp9BjGNafm9owgoUccubO?=
 =?us-ascii?Q?JiL7p5jDGf2NMNlASgaTyq58cGL+j4PKE2LMFg4sKJZcKLvhG4jP3uu4XoVB?=
 =?us-ascii?Q?Wc4+c0/giTGMyaVQTU2GwOEN4Ny9D5uoqvOs8FYQJBT5krX6lbLJoGHEhrAx?=
 =?us-ascii?Q?fsfO+9JnMexeveTcxswoNNY1TskXbtXQDjGqndYD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77a039d-0745-4b62-8f88-08dbe1759da2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:45:47.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngk972thgEdpTlGG5bJGgaH5e5isVNaGvD5vQlDyfSidgQgLh3nEYmhya/kGizau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:47:11PM -0800, Linus Torvalds wrote:
> On Mon, 6 Nov 2023 at 08:43, Joerg Roedel <joro@8bytes.org> wrote:
> >
> > There are conflicts with the current upstream code, mainly
> > from iommufd changes. My resolution is attached.
> 
> Hmm. My resolution is slightly different. In particular, in the
> selftest code, I removed mock_domain_alloc() entirely in favor of
> mock_domain_alloc_paging(), the same way commit 13fbceb1b8e9
> ("iommufd: Convert to alloc_domain_paging()") did.
> 
> That not only seems to logically match that change, it also matches
> what I think Jason (cc'd) intended with commit b2b67c997bf7 ("iommufd:
> Organize the mock domain alloc functions closer to Joerg's tree").

I ran through the merge using my for-linus-iommufd-merged tag and I
got the same as your tree, so it looks good!

Thanks,
Jason
