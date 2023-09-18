Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916CE7A4ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjIRQ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIRQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:27:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE8349CA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPdMx7lkPPkH4szuAvcaOUAjhtqhZekxJG+iCHHZyXdowyDlKXtBJy5nb6s5qwpZfxeE4CpKDis8tB6XSb08TDt8tWS+7g2qEoQ+pw13CeypkuGsijOUB4/MJjECpjhT0kQcEkRk8lY+2uLDSxBFwQwMIYD64jke9IOATkTr++Hnn2aTVrjYSc+Yc4UQ72xi3TMRgcQih4uXdjIurZ3VUE/B3n2ENJnWGn5nQfPcnefynk7fTbHKvAUVGCkRGB8wPZVR4eHql1IJHhZJs612KA5WgKs5dLyiA2nCFhfRgOt8o4PcamAxcer729+nTyY1cF326z4hEQ1oKP6EU1Ir+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyfvf6o3M1177WCa/UX1b/Li/kIT/mkkNlaVhPdbfLI=;
 b=EBA65kk2srObrm1O+WEhBPGGJ0QMRPfVvea4SbmX+pRaGh934uhOt1/QlMK/ZS46Rrg7/mNU8eqAGMh2FcDsVUINf6wXxMVpWWEi2OF7Grp4tzqsa8cBp0KpE/4BGjvf00tLrQJsHGkbj/gC+iPgRUkF7elRd9no2gg0RaBfkXDkoX8Fn5iYuzjuPp2UfuMVdtdcm7bC8Uk66ECDnQEvwHUFJBZSSeGbyUxzjCGQnmODE0b74oAhrNN7P9pF2z7s0jak0o4WwRFcfvtOqcjCE18+wpjt0XQiILaZENiZYJe7L7ZMH3yOoO+/iHb02ELyLtm6OcZAuSCO3fG+vGJQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyfvf6o3M1177WCa/UX1b/Li/kIT/mkkNlaVhPdbfLI=;
 b=qXvY15FSKYGDol+KMtDs487aoIMNbJDwwMTfYM1nfMsV1iYLT9YpekcEvUTJufARq3xP04S3zTh2PNocZb4zgiYeDYLQMIWNag3hpDTqQiZJ1mlXwOoW2sLRInM82LRGY4FBWQ0QHC7I0l8IlPde6O5Ibd/Hp3YvMf781mlxe4YGFOmnq6JlemtXBPuqTcW/0Qvs9RDMcGeEpSo+jzsVQLkn2rV3sP7E8LiMZzd2NwYRG7ELFFxpvBt89Vq8Md0boV/CP5gTq4KJcBspmEbAvcuVfgQum2+ZveGiNHhBxrY7zgMErbQesBZ6YRzSY/83sAX1mn55xn79zg4j6eiYfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:24:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:24:09 +0000
Date:   Mon, 18 Sep 2023 13:24:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 0/7] Iommu: Retire bus ops
Message-ID: <20230918162408.GI13733@nvidia.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694693889.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: d78ea6ca-9247-47a3-2e38-08dbb863af76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1LvXPi8Fz14DWdG8/TjpTgxrfVNB5QY9JgIJFdXWyO7BEnrm6DdWXAdiHSY5vXUSMTOktNjzNgm8rbLc0ZblXpg59FAh72wZKoN6Ek4aG6BPVh+z0rPw1KNAOEA8opyv5vQ15Qfj5Q6sTw7nwP73EdkjTiTBB21+G1wROO2WR3PMrxDd68Pb/bPsuQHjAxPFUt6hn8WAiCbjWXRQa6PB9+XgrYBwBE74pFKshtNIGhzRiGDJQDah1KkPilVDNsiHF6Fi49O5vtDuzG4iGPvOzBoQXZJPZ6qBheWilwRCBpVnx5Bu6yguRi9Sg6NYqt58Jf/N3E8kDPvy1REABZcB46mo1/JwXXDNQeoRGOG83l01Jwl8FLuZ9jGwqa+HW0je4n9uBXJ2l2NORx1bpGEAOsNpOK7sW/5V5Kocw08+JIzRqSpEXu8hDnIo/B1j36Y2+HyAM06gR895rq20baEVv5grTF17ErJxHnkvpAZvtBH8NFIo1AgJizPDj6gcw2oDh07OydesQpG7FHnebhn28D967O/hxoZ5i+isx3alt68X2DefTGWbiDyUkY/3aynbWnbB+ifNU03yQCku6K10XK60/5ExzAWUgUdH4HEhZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(2616005)(26005)(5660300002)(1076003)(8936002)(4326008)(8676002)(2906002)(4744005)(86362001)(38100700002)(33656002)(36756003)(83380400001)(6506007)(966005)(6486002)(66946007)(66476007)(66556008)(478600001)(6512007)(41300700001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EsT5CBl7F+OiCmeNMhRfbs/h7Z4yGXTYKGzmNxibHbtRd1XURbxKW+5KIy9?=
 =?us-ascii?Q?52RVRmwCHuigyc9kUITexE37XTuwj1Fz7W1VuL9bFI5o547OsioOkop/ANLw?=
 =?us-ascii?Q?R79JhSsTwVWgGFAiw6UD9yPNMXsrkISyyMdXDu0Y2aoZiBIkq+gIajOmQfip?=
 =?us-ascii?Q?SY7QRnLVJZAPgx7QlwH3oiUY43yUle5n5FbDnk8ScM2sYEJPPasioS0CA3Cp?=
 =?us-ascii?Q?UbnNRHtGUpUAozTXYmOMGWtwV7EcnDs+sV47kDfAQTzAG+hpmuOJ5R4R1YKx?=
 =?us-ascii?Q?5KWEmlgAUTq+Wp7wUp2YB0RtVq5f3U5BjP5IuVrJs2rGcNtWRhDc2MOnR4Xf?=
 =?us-ascii?Q?aBJfJjV18qV1s4maGTdPJfm52oCPQmKatEDxRmCvlBQBybAfJmxi0XLMBBre?=
 =?us-ascii?Q?Tsfe/Zmio5sbvZmZ0Gn20QKm2km7fk3kCv4aw5w4GH26tOfIV6LOplzDqRTy?=
 =?us-ascii?Q?maZoTqOYDMmrFWLh+0NkMVUiVjL9y46DnmKwBxuQXbeEUlPpbfJvNlGtJpD3?=
 =?us-ascii?Q?apPA/MDjHipgIJTvFUEmg3vtgkdvoyYEqwn51Q2TLphUx9aL6/Bl6rNnFCoh?=
 =?us-ascii?Q?eSuiZsKMSGiJ2n8OX7b4pT38j6OwMFb+LojU3fBZYQHB1vKVExOQWXZss5ee?=
 =?us-ascii?Q?ruu+aT6WDLPyUuIMDsQxOdleH/gKZGZQKu1859paCV+L1uWY/WL8mcA31zXM?=
 =?us-ascii?Q?esV2rQYO2mfMM1ZihtqVNMKNBbaCV7u3rSQJYY9/C0l/ZcL8WdKtIZJT3HRm?=
 =?us-ascii?Q?2H8IK+aulyEseiIf84zXURRYYtn2yJ+8KCnYjPaPnvJ69O6ZSuehMElisDTV?=
 =?us-ascii?Q?GjDGdjnrvwcbgWWa9FGWRTJ48p09KGLrWCRlqBcD/Cj0GtjNJpIw2PPuyuC2?=
 =?us-ascii?Q?Q0I/jeI/4gJsMoEEeZl5YLzP1ITV7FvWHPEhlV9lnM5tFBTo1woMO9DczBqb?=
 =?us-ascii?Q?QZpfwsaImZ0P+0tVHiRnZ4740Z27b+WLmPOnOnWW8+n3aU4V/HOoCzkmygi0?=
 =?us-ascii?Q?zSsbTfHF1bM3pxHA/5kA6T2VDiW4t1BH6p9uJteENP4SQpzDxcdPgEx80HVs?=
 =?us-ascii?Q?SWEvsxRctOB+6qHHgTCUBX7xfM8hK3TfOATztFEP+GssoSJZsKLm9EEb+0Oa?=
 =?us-ascii?Q?NXxXWGz9NLc18j1xMLeD1NwxGUNzg2vM0lxuYKS3Pu+mMthgkYjkyY0KXe+G?=
 =?us-ascii?Q?sKN8ASY9H7gUYXewSrBZ+lq675lW2xWyJsAwhMoPQDQDzHxLX8veItw6iAMu?=
 =?us-ascii?Q?/CbOw0PNrphTNfLJsiJ3800Nlz8xfTv3gb5rtX+YkXD2dKAped0JxmCliF4X?=
 =?us-ascii?Q?WxAfxlzfoOp02mnPNGBKKqTiWyZpmAkieH7/uGgtUDbv3WzuGzzErHoo8ZxA?=
 =?us-ascii?Q?2SlVF7049tCO6wmngHakQm83Ui4R6DbcXj7d0355zGRVoisFMwonjysmCbaC?=
 =?us-ascii?Q?J6kGAGoEcPsscrfHkX+trmcSDsynmxn6Ya9nTg6mdMWypK4BmhGyZYgUXPrP?=
 =?us-ascii?Q?kG6syjKxHidPzlHucVaCNktAbtNsLw0IZ+5v0RpxRN9zCZjrdaSQzRzN5Ljx?=
 =?us-ascii?Q?DgoNzwUKCdv7cU2J0l3jc4VLTNaBuAJsQfvsj57x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78ea6ca-9247-47a3-2e38-08dbb863af76
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:24:09.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7ILMYxk7f/rC0nCpJvPUVdRWVdvVX6Hu3n5pYdnSWPeR6J7tByXDRzvozdafPVE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:58:04PM +0100, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> I've finally been able to get back to this again, and I think it is now
> hopefully ready to go. Changes from v3 are quite minor - basically a few
> cosmetics and small tweaks (where I've taken the liberty of keeping
> Baolu and Jason's review tags; hope that's OK!), the one functional

Looks OK

> thing around blocking domains fixed, and plenty of reshuffling from
> rebases. I'm happy to see that the IOMMUFD selftest problem has resolved
> itself in the meantime, and it might even be able to use the standard
> registration flow after this, however I'll leave that for someone else
> more motivated,

The main issue is the dedicated bus the test needs.

We can change the two wonky interfaces to two new APIs to add/remove a
new bus from iommu monitoring. Then the normal register APIs are
probably OK after this series.

Jason
