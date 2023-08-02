Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DAF76CC12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjHBLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjHBLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:51:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482FC26A1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxQOEQa3VnM1uRx7af/jwYwQqg6aX3MQa0Uxqg+crZWxDcdd4mt0BerMk0W57KZNteGOK9kPb+I1t5Lqa0xP/ycb5ypoGrxsP3wOzXMhbV5HQXhDxjCKfqCTYHyiDzwhlzs8Vi3741cTUSwG+bvamClPxN5ac+8kT9g+uBCPBYW0ylp/0PRWfLyzMvBgXQ/SrRm4R+uLyrxqrHq4dYQ/4WMb9iwfZuUEJC1/oujvZcIwhM55AR2pcNCKU1LqnYUg2ut7PFsYxtebGD6lzDoJF/yCiHXtiW75O/mNMUZc+uP1O8R5Ere8FjKYK++z8/s5j+CROyQ/xc3r7pGiMGb3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vEoYo/18DibDLIsduNNIZ4vUAnhMxkcIur8wuwdXXk=;
 b=CzzTBFXZJMSttAwOyiPElNB9hcodtNefC9jm2hbsOLBVXBylKFOWuZUX1fPsBn7jsFf1L2Y1m878i7S2q4CJPMSRZENy0GcVnAgqD9hDa4esRz3mkbdgokkSbXifHEH/yenRNhfd1HJKiGZG8pq+amxqOaOONz3fureOZvqarerITduOG5ooT4TAfngpJI7u/CLR/dcjtJzuY+wtrDKQxqPDGWCoqNKxgYzvJLY6Epcqr95F2N9RIME/ll4m1N/xDOQ6XhKebMJIBh7f2OxPkGh16DjICgbYC8mDqD3wY6OJJqv9qdihPYyTAU4mxayQVMv3aDOGvy26qK2s5CO7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vEoYo/18DibDLIsduNNIZ4vUAnhMxkcIur8wuwdXXk=;
 b=HLvQ/wq67QHQNhGWV/AiHcXFybLuaogTNuNwgn+FXbzvS3eRYDtVOA5/6ooZLbYDQRiCfYmD8gCf0UFg0Jfi97KNMQfgYw7ihbG52I6uytgl706IxcV55gLR/M2lUIeQ9ZFHPv9j5DVHhzdrGzRdeq4ouGeisq2+GmWU3OIryprjnnn6OtL0gUn6n8HzJsbx0v+remjXM8beci1nrSIZVtfJd29QqmE7aa7ie/BlUHJOUJ15ZX5a9qwMF0a2VwW6CPS1SLlx43TjNh/MtXR8Fl7J0Y0rK5kriZGbd5CQViT6LzzPcocPK+9muYKwgd1WIOQlUlBPlyr9UOwN+SzF8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:51:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:51:34 +0000
Date:   Wed, 2 Aug 2023 08:51:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Subject: Re: [PATCH v3 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMpDRMGOeN/bi2Vl@nvidia.com>
References: <20230801183845.4026101-1-mshavit@google.com>
 <20230802023524.v3.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZMma/qk0otN9eyW3@nvidia.com>
 <CAKHBV24e4YAB8J7MP=vuVarn5cVSWrB-NsjO-obH5CZECk0xNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24e4YAB8J7MP=vuVarn5cVSWrB-NsjO-obH5CZECk0xNg@mail.gmail.com>
X-ClientProxiedBy: CH2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:610:60::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: fe63fbf9-f76f-450e-3b2f-08db934ed1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bw2DIA/Li+r7xAvvD3ldkVO1mt74xb+PiRQLuUpbTp2jjzZMZUWKkCIFDU0hBkjOLPuYa4uNukCx5JHNW5aYovBUdmy91yeim8zsXD/tzcdbq3SLt9uZ0yHHMMtSHr71PyYOukMqfJGAXO2TM86Az2kCqxRqHpYmMbajz7EapM8aCdHVyGQshEspZ+vL38ApOna53JdZ3ATiPR5+H5EaAPnokkVYV9MWZ4iUI9tthRLUUGt1l2I/twkKXZTsLwNPwjoZbp72iHXG+aBFe6FEHRNPBsmOKeLXNspjDbeiVd0TTix/9GcjVDHP6LvlaUgD+LN1OdwDjicpqAtaR8Wv06gup6yiRnoFh3shCcNcDwboCQrNxMR8LKJk4ZlCfFYlae0uG1Milcr7+qpRbZHoyfXZEfq6zsM3gB3rydQeSR6y4DAhSuK6QZXtd4ARlz63QtF4ZLheqKSd4vYO1UqWsamUpX6C8sT9bFh9Va4XmbMJwMw3YZpu1nVFFigBmkPBxIjg4z2nGXdyAgGBC0+LUHNbB587OpPJ7fplmbMe0PrwqmlzhGHK09j6adYyvbUU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(53546011)(6486002)(66946007)(66556008)(66476007)(4326008)(6916009)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxEV3hmWHJRQ1lwM0dNSkRVZXh3dlUvS0NjaTl5QXVSRjdBeXQ0ang5WWtk?=
 =?utf-8?B?TWIrSENldXFraUIwYjVYLzlNRmtLZDAyMVJKZVJJVnRCZndybjFGZVF0MHFn?=
 =?utf-8?B?UWt3Y1RxaEM2eDFVaVk2cGU4aEtzWkFUN0JieWRnSk5mMHhzSnBYM3ZqZk5x?=
 =?utf-8?B?YXlGcmR1SEtRQnJLaVVaUU5aZU4xZDl4ZXNlRGwyTmM0RGRmL0FxSU0wQzQz?=
 =?utf-8?B?MjRtdlRLVXRkejhkU3BvcVdraGMvV2VONitIZTRzTERaaE92MkhNV2NwWnFz?=
 =?utf-8?B?eUYvSzdJSmtZNlY0TXhjYTB0Rjk4WUhZdHlGcWMwNzJTa1NzcklWTWhjWG5o?=
 =?utf-8?B?dGI1czlONTdaYUdVV0s5bUpVcElwRm5TR1g0enZHUVpRL1JuWlN2V0g0Y0Y0?=
 =?utf-8?B?MVJYdi9PYzlHWXJzNW5INHlsZmNMdkRHenl5TEpXdDNjL3RWLytpbmpSSFVs?=
 =?utf-8?B?ZTEyd0p3cDJtYnZMWkZrTVFMVHJSamFxY0FOcWVPSGRrK2ZMQ0VCZ2ZjOTEv?=
 =?utf-8?B?ck5VNlRsdXN6L29OWmt2TzVGd1FFbWZFbk1oNDBqaFNEVGlVY2NYUUdoT2hL?=
 =?utf-8?B?amtCbXNnRVZIdXVmNGJDbkgzVjRzdW5PeFh2UTBWQTlRb21admREdDg3RS9V?=
 =?utf-8?B?dWh6QkZyNnZhRzZNZmVvdWhyTldVSHh3VjVWdTdsQnVsdVNqWnR0Ry9yQ1U3?=
 =?utf-8?B?amZzUlhSUmlUcGVjR3BvU243dENSRTgzZFdwclFqMW5USGIzb2xHT01oY3Fv?=
 =?utf-8?B?TjhnYnlPbVA3MzQ5V2xzK01zd2RiUFFWblN1UlNiVXpheEZkRHQvR3lrRGR1?=
 =?utf-8?B?L1FQWngxVmpmd2krSEcwTHo2dVkvZGtJWllmTzhiM1ZBamY1ZXVxU0JhVEtX?=
 =?utf-8?B?TU0yck52OUtVd2RKbHdleENRT3FlOFk1d0g4YzBTR0hINHo2amdiZzNYYzBu?=
 =?utf-8?B?MEV2c21MVDN1WmNZVW5yTVhpVWtZN3lCMzJMQnpqdi9UQVc4OW01dkswWTdh?=
 =?utf-8?B?emRReGxGbGlKM2FBazNnWlh1U2JrTUxrTnJiUnc3Q3YzdVRRaStzR1lDMjRk?=
 =?utf-8?B?YnhlS0ZDUkN4ZWdDZUExSnZLdlhSOE9QbGVnaVI4VXE2R1NrSTlVQkc5U1li?=
 =?utf-8?B?Sk1oZnlrN3dhdVBSNSt6R0p6d2tiREREWFBFenNvNzY3NHNLWGNUVXJCcEho?=
 =?utf-8?B?SmExS2Q0MEQxQnlFRjB3Uno4Vm9lM1JnMTlFdWtPM3g0Y2JnOUdwUEhzTkdO?=
 =?utf-8?B?VW9EdDRXd2E4TmxVMGFTZnFxYVNWQzFUdUJwVC9JT1lqRlU2RzhRVzFERWFr?=
 =?utf-8?B?MkJzOEVSdzhNM25qdG9mRVdnUEFaNW1RU2x2eGRGMTAzbUVxVTdTMDlRQmJ4?=
 =?utf-8?B?OXJteWR4U0NIR0ZMVjNhRndhaXM5OEtKdHdSVGk3NkY0ZzlPaEE3bnlWV1Z6?=
 =?utf-8?B?MXJCV0tqeGw0NnV4NkJpb001NWZ4UDVkaWcySW8xckUzcUxtb1hwa0trZXJP?=
 =?utf-8?B?eldTSzJLSmlOc1hhM2ovOWlOTmxmT3dHcVNDN2ZpeTlZYjBMK2Y5eGUvWkZj?=
 =?utf-8?B?ZWFCZG1SbUs1YkY2UGNUaXhIWElkVGN2UE5YOGVKSWRaTHBmcjJLVEdwaTBB?=
 =?utf-8?B?blNOTmlzVDlicFFGVjJoQ3VvcG1LMHVVaXMyK3lmNlB4NEtrL2s4azNCK2xB?=
 =?utf-8?B?V3JLbjZjcGI4aXNvbTRVb2E5YlhybjhYQmdvM2lDV2RENWl1TnFMQXZGYlRJ?=
 =?utf-8?B?M1IxdWZEMG5HMzhwY2hYdFUzdUF0L3BRcXliYXZwU2RFclpIazFFRDJteTdB?=
 =?utf-8?B?SWhHQXBxZzFnYXF5Z1E3S2IzOVVEL0w4N1o3OHpKek4xbDRBUkJMeFl3amxH?=
 =?utf-8?B?Z3N6YkZtdXVJRXhickc3V0ZUYUNoamZMc2xRYjdHQUNBQ1o1K2FWb1pIVFk3?=
 =?utf-8?B?bE9sYzJxRWt6NWZWelRjWldiRkp1eVRZSFlZNzZrWVZKQlRVZUt4YlJlM0ZY?=
 =?utf-8?B?L1dIK29VRnZYbEp0bE9PYUx1RlZJRGpqVHdrTHYxR0E1eEtZb2RiUVVFRGpz?=
 =?utf-8?B?Tjh1ZmhDRGVTOHd3S0xEbHdITmxmZlJqbTk1VWtTekd3ZTNYWldrVFp0OTlr?=
 =?utf-8?Q?b6IftFvnns5F5Ca1ry6zB0xN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe63fbf9-f76f-450e-3b2f-08db934ed1f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:51:34.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLEyuk3tDnIr3H9mw9xTyI5D0XbYZZpegO/oNX1XG7qCYm7Vby6yEq8XigWHchUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:19:12PM +0800, Michael Shavit wrote:
> On Wed, Aug 2, 2023 at 7:53 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Aug 02, 2023 at 02:35:23AM +0800, Michael Shavit wrote:
> > > @@ -2465,6 +2440,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >       if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > >               master->ats_enabled = arm_smmu_ats_supported(master);
> > >
> > > +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > > +             if (!master->cd_table.cdtab) {
> > > +                     ret = arm_smmu_alloc_cd_tables(master);
> > > +                     if (ret) {
> >
> > Again, I didn't look very closely at your locking, but what lock is
> > being held to protect the read of master->cd_table.cdtab ?
> 
> The cd_table is only written into (with write_ctx_desc) when something
> attaches or detaches (SVA is a little weird, but it handles locking
> internally, and blocks all non-sva attach/detach calls while enabled).
> The cd_table itself is allocated on first attach, and freed on release.
> 
> Doesn't the iommu framework guarantee that attach_dev (and
> release_device) won't have concurrent calls for a given master through
> the group lock? I can add an internal lock if relying on the iommu
> lock is not OK.

Yes that is right.

So, a comment about that in the struct around those variables would be
helpful (locked by the iommu core using the group mutex)

But the code is fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
