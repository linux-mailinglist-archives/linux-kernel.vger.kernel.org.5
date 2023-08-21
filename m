Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF942782865
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjHUL6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHUL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:58:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE493BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlDd7xTDcpagX9b/ip/jruN8bmqJiZ1v3VRUiIVhFDgsc4OM2U2POjgy0De/pXnnmJEQKkfHsO9MECWjgN7c12Mp3ntWbmNFBkDpSw5/ysY1KtcGB6wWLkYOt3Q+1NjEvSe3W2gK6pZRFLaUsZXpOo8WMOMCa7OQc6/NaO3IJyVXJyP20Gkdkncj4xqPi5DpoD25rmnPe4h8Pi6qCQVBnpMeRTJU83CRNMJQ3MPYmOekriB5xi5/WVTu5xarZaP7pyBqAI2Tq51suwbQkrYK+HhvYMpQ/GOVbFAteDM/qgL6BWNVsFdpGwv/NEqApkUmvKUaJNobGo3A2GxNRVDd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycxcvEF+6SH7MC07D9iAEJ6msqu6OJSablnofSa1Syw=;
 b=aWYy0nDk8QbfOWy/6WG76IWQ+g6bein8VDJ1KLdEDMgxJVtj0iUgZMhRTRwXMkyymkf7hNSjH7orgG9MixiJmDVKg+wAE5hPLRtO+9SPxc42jFAvKldyDy3jakDGkwhXtYXf769EWsFyE/yM33txLug6G04lC49UYprpXB1iIlNZ115TA+frYHLzoKUJAIJnSC/LqJYlBz2b0cNcORwAzdwuAdTwr67MNUjPmP4zQ8vSJOnMo8qC/9E5h40aZq+OKWHdohG4b+4INfITWJvc7SxpAGB8WwpSZsfDR4jEmbNCpP5AFSNAfY3XxJYVkHs1gD8AarCjmxiB9ZaRbRyYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycxcvEF+6SH7MC07D9iAEJ6msqu6OJSablnofSa1Syw=;
 b=b/0ShrksF5rlV46jb0gS+MZ3zCKI8dDFXP5sd3zSMkGuu2Cx+/tEGzSVBpkQU1FgfsjzYW+Rss9oZbR9W9ZJsQkjuheSXxij/LUg+IsobZ3UUKHv7Jj6utiHQQ/PPPxqYQuxJ3dttAnBLUFceMUbSfvJLhs2qTV83ojSRKa7ljkfwCs57joj/PQioE9T8EhjTZ21QRd3fysQWhzPBLwztmRdvXDgl6HTIED7EXMwUWcadn9ys3m+QYS3A13hvJ2F1oLjOwE8J4XG8lmqBaNkGOMeeGVOZcCTPe8BmywyUc2xqagfiGV4OaBD0fnTwflbIwF3bZGifx36yrm13SmDYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:57:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:57:59 +0000
Date:   Mon, 21 Aug 2023 08:57:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over
 installed_smmus
Message-ID: <ZONRRubvUK7GXO4i@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com>
 <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com>
 <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:236::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d5c0cf-26b2-415d-96b5-08dba23ddd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI/rzJpwMkqX7dojogKJYI7EJbRGcY2gnBg9pRIFYl0uIIEDkEEpw2w2iQIXzoHrTb55VJJ/NIWQb4X9gCZXP/t/xN1d174tytd/Pjb27XFOixZyx+RCVG0o2uvs51D7yyG+KtyUJe7FFlYTsoSL1EC/Fdtn2+YWXnMbjhnvBBjcSSoE/nKoIYkOztSjomClIaZ2Gm06G/Va/05jloliQcIfUbenOMuc2iVB+49c6Wo27sXBCcf6SO9BK70dSzjZ9D8AhQlXUgNRboBoxxG/BmzTLBTeRKcocgC0BcFUEyS1veWFLR0IKItL5f0r1VjrqJj98YLEUgc15GQoH5GzW7JcNdawrsSHpjfgHsbmcOSoOuonIQ24MMu0QlHmivp1+IEqWhYSuw8mi1kztG1J5L3yR03SwHemuOt8yywX36okM3jOaKQL9I+aPTNVvM9wAnT8bvyGwkLCghyEWZcs/Z6PJ2WvGaBdfU+xf0DXD3lUcZheiLyp7iuDU4k7VWiN+jRxJwHK2ZFcZc6hXSWUYaXbSzJQKO6yU9BvJmW3+HVt8W827yQJh2TLaon+0R2k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(346002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2vTH4LQKnu51UqMt2k9cVaNv2W5Et2cPJsEqH7HT3lAcGb/RdcNVaOgD/KTh?=
 =?us-ascii?Q?tLOp8HTrD1euMmtpvn1uwL0WO1aVWGwCmF/m8PFonvpyoD5NhXlRaKP7UrZA?=
 =?us-ascii?Q?rAWYaP358HJv9oHhlmBHgHvHYefULzgxsA6AeOf7QDlvQG+zWAFeRoFJJHAx?=
 =?us-ascii?Q?l9GiSkXdcpdhwYcimcYU3u/a8Q8kzSiD2+hjqi2IEzC/jQUpFnWnmSO7uxUi?=
 =?us-ascii?Q?bzYNYsgtYZArY01mLImGF/MY/YmvBhwntVbnCrUtB3bTPBI4rTSzw+O4I9ro?=
 =?us-ascii?Q?0RaGdY1xCw5EBtP6CzUDzWxH1cUe/kiYVf3yJF+BHBIZLBiz1jVuQHyQHQ+8?=
 =?us-ascii?Q?rAWOxV6puRjPG3A77tiTYX+a1scggcftomqsax+YxHciMoXm4hcTJnTw/1n+?=
 =?us-ascii?Q?sbJJsfyRaklgiLUYHNSVgwyYYaDXSPPLzltZn7t0GkCVSwvNPuxdEI+UkfhD?=
 =?us-ascii?Q?X2Qh1fNpxYTFThuBgXvF6wjwaKSGA8jcMue0hn5ESFLWMnMzSVYMnhxFSYH3?=
 =?us-ascii?Q?kl7sumtxAxHYWM+G04T2U81bW0kdJ/g+e3ooxKPf+gPyxf7x2USMFPt/bbgs?=
 =?us-ascii?Q?58/iE5lq6bVjnGJKYP/0sBLq0cxa3eLlBwIKFzH3s8r3UT0Z46qIY45oKPVT?=
 =?us-ascii?Q?vy+fs/A1M4Kqi3PRXFe7IzMu88/yHhMMsyLIa0aEGcEtuK7vi0Q7yeItHCRJ?=
 =?us-ascii?Q?J+v+iD3tNHBPKpNC6w0x9rN0bYOGNB1J8CuJ4XFrgUyzoQZifHHBoLSeaka0?=
 =?us-ascii?Q?whkMgvd+DfXMiOIkklxr69+aWuvlI1+qsi8VI7RCiPe2PwFoUd+GEyO+rO1l?=
 =?us-ascii?Q?jnDdMMhRnRGoJRq/7fQcKEoG9orLq9Gbmih3hrgN6mXCeFweDmcm1fj0FChb?=
 =?us-ascii?Q?fGs++zLhYX91TNWtk6LWQn1iBC2o1cLCL3r+9Mbc7TQyUCClpnxXs+ni8mHr?=
 =?us-ascii?Q?2lKqFiBCGD6K6lJpmQ07MxaNTsOGVDKFK865SUU9VmuKk6HD+ayZXf6YapDc?=
 =?us-ascii?Q?C5XPFzl847SJ4riHZR5bldN5ilBGmMAnUHLH//8/xAgHliou6TTGxdWoYww5?=
 =?us-ascii?Q?9T63kUhAI2OXqViE4ZB2yZLEa6O10rJKoWr9DpbRrH4gYEMxu320ttD5xaSA?=
 =?us-ascii?Q?6ebnG7iiDEmSPDXaecNDOyA7g8Wg/0BWTkR69pgnMzPQyjN0gR7LRXrVtQFa?=
 =?us-ascii?Q?rhHR1YS9DVqZi3UZhw67EXn7U6KodZpahP7LS5XVmOahCQT8Vp7B8iY8BKxg?=
 =?us-ascii?Q?Oagav62Msyr91WH9ndy8O4PJ84K+XTJNur22kK/H42ewUlt8WpeiVHdETzX5?=
 =?us-ascii?Q?g0O5eJphX3w678QaqL5DSvTSOPAn0M8CApplPp/V92GqkOzNH8ZzKUESbjnR?=
 =?us-ascii?Q?mUxU6YKZkwKu/5NCrae4gTNUfR83BUUT/1t0ROPFcrmxXlcBbemxwyYKeSuE?=
 =?us-ascii?Q?G3hfQptuD/FBtV2dYqqc3rPZ5N5qwSifUMQ2sjtnJAn7FTFPPBZJzfdEccqa?=
 =?us-ascii?Q?zmSHX9Kj5AC84cE5JaH5BYU7UmSg/wRbed4KLcVDJ3ElB5dMTKlncBG4elJx?=
 =?us-ascii?Q?A3c8aV8RVqQnDlEyRgQuJxyNdDKcSXVvJprUf7C4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d5c0cf-26b2-415d-96b5-08dba23ddd5c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:57:59.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H80KMD52KtGi5Gma3st4Y8SrhnzUZpB3ozjaUGkh4ipNi9fWb+LGnqvdrOUJHcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:33:36PM +0800, Michael Shavit wrote:
> > Notice that arm_smmu_tlb_inv_range_asid() already duplicates
> > arm_smmu_tlb_inv_range_domain().
> >
> > IMHO I would split the ATC step out of arm_smmu_mm_invalidate_range(),
> > get rid of arm_smmu_tlb_inv_range_domain(), and have the mmu notifier
> > just do as it already does:
> >
> >         if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
> >                 arm_smmu_tlb_inv_range_domain_no_atc(start, size, smmu_mn->cd->asid,
> >                                             PAGE_SIZE, false, smmu_domain);
> >         arm_smmu_atc_inv_domain(smmu_domain, start, size);
> >
> > And make arm_smmu_tlb_inv_range_domain() just call
> >    arm_smmu_tlb_inv_range_domain_no_atc();
> >    arm_smmu_atc_inv_domain();
> 
> That's a nice clean-up but doesn't really solve the problem faced by this patch.
>
> This patch series eliminates the smmu_domain->smmu handle, replacing
> it for a list of SMMUs. So SVA can no longer optimize the
> arm_smmu_tlb_inv_range_asid call away by checking whether the SMMU BTM
> feature is enabled since there's now a list of SMMUs with possibly
> heterogeneous support for the feature. 

You could also go in the direction of making a SVA BTM and SV non-BTM
domain type and then you know what to do immediately in the notifier.

> Since there's now a loop over a series of SMMUs inside
> arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> that loop. This technically works because only SVA is calling
> arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> the future since it's not obvious from the function name.

Well, I would remove the duplication and add an argument if you intend
to share the function that loops

Jason
