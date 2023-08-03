Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA376EDEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjHCPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHCPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:20:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F6E75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy7yc7pnhU5H1wIkHeGSRgPKfKVRFezZOYMH/TYMbow4O6ASbncsSC2ZVAOoYO9T9i/QeE+y7pDTpmUwghZBlP7KtqKPmoWcdisBMXSTiSCBhNMH8f2YWsa9NCUV7aw/KWRKT5NVTiNlrpaLjIIR/M2f1v9s6du1ioh0ibEJ3hkTLwsYZmVtZNUFl0xcijuSMKMWG1pK50P1Ol3ZkBmcZHKx2SoVPhs5uXESiRr0+Q6hKRJePa/aw7f7k7oLURnpa5E5xcDgdgK9WhAPghek91b+FBzbiCbhWrgdVJ4szMA68xCznz/SM8yJuma4mU3k3Er+dOUmuv3Z8WV59QaaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHtsx0UoawmgGMMb1A6Z+kJ3aPCj1fx1vIO7weGOXlI=;
 b=XBmC3J0yQvIyBPqAUrgQtUsWO45OYQL83TDpv32rcr4psvf1Iy4afgTNUUMVqg3BK2/VIpkfnL9uQTXM/eMbf9oxdz2xmlcsX7qYUf3Y9C0i/asnpxXuwbqYlsV8/DqGC6Z27KSP7hahHQVNfCAFoM07griWwxdOgV52jY7o33jmfxEkBwBOb5j/pexUCerQrXsaeWvFU5rOK7dHHZAUpppA0rQThQ6eX+KfPmlkOHhXzP9foFCLpGkTE8wWxCE2p/eHj77746lqrhPoO2UR8Pkq9edWM/9ckH9RgmD2BKBMoHHm+Wtz75UY0DSVryy7/dsCDsmQ98IOFhjEKW8fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHtsx0UoawmgGMMb1A6Z+kJ3aPCj1fx1vIO7weGOXlI=;
 b=iDKeg91qMsHQHWswr+MNvQRr3bZ44Sqx1EYrrq21JsDn3FzX9AIaCD3v0DJG922RqJkcJoaXP7DRCa/ayVQ+u8jB9IG1h/SGMOmTCjRPeF4jRL3LuiUCp1B9IiUrpono60sc7lJFk2fDMj1XiHcIH50REqtgayMQMDNt+xoIgY31BzSCpru4DYcRs+2V3JhECN4dncm4ziAdnI5m3HTz4vRV/BLrBPy4lQ8DTg8BKT0FxRNSaPPvEDuRh8Ef013myB4R3UY1nm1PT9/phXA1A6UPN90ldMruMhchh50FAzJe0MIil61Y76K2+kUP8GoqGWVIMk4J8QlcVyHUiHVC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:20:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:20:50 +0000
Date:   Thu, 3 Aug 2023 12:20:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Subject: Re: [PATCH v5 5/6] iommu/arm-smmu-v3: Free pasid domains on iommu
 release
Message-ID: <ZMvF0HfPkn3rdnJZ@nvidia.com>
References: <20230803101351.1561031-1-mshavit@google.com>
 <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
 <CAKHBV27=9PJkWi8oJbhBbHYw1BLkdBKXEUyGSMcNmL9yN1-HPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27=9PJkWi8oJbhBbHYw1BLkdBKXEUyGSMcNmL9yN1-HPg@mail.gmail.com>
X-ClientProxiedBy: MN2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 47836e51-3543-4db9-341e-08db94353815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gzl98gLQ8YA4SrwvjySd8a8lhWCyPBWQDqMW4OBdheS3RTO5pCZTIqRM+JwtWEjvIokoJVjVAJF6v7yVqAdT/TMPV80T8kqRgYaFLdLyMP4xvaQ/0f1kNGn20iU1WZjspq2TOYePZCen71Dv0ZcD9ZGMGaW0wsghPdjoovVNMnn/l3Vtjbnyjw2Lj7aBDzWWHIThKe7ch+QN9jyBH2TiSh8PbB2TkqhScZBrk4ChfurbGpB82s/ll28XOpGtZdeP3wuHBQd2jKvu0OdY137D1X8NqmfJO2XIz58BGLED8mKIGGHineJV4wQ/4OIZtKttSeNq/JYJPRK/tueryIkZNPxNKuQ4ir3o5qi1PatnZLP9IHG8u2saLYTDKKo27B9K/VG7wELD1qdHeW2WpMtn1o+852DenVZH5hQljxolrXBsN69gHoZndhrwn/hP4LcRKgmE4hU247nM/mVJGH8DeuxD+VAByL00kPtTt1dU4yEob6CpBl2P+1CfE0slf6t5JAQugDvBaqGFpcllgxRZK++DAkcCxJqVcjq6SIoYkHudnofOhSaZIUWwQg0LTuyK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(107886003)(53546011)(6506007)(186003)(26005)(8676002)(4744005)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(66476007)(41300700001)(8936002)(6486002)(6512007)(478600001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVoNndvMHhMaFdCcE9kMzZpOXUzUUJNVmRkU0Zpd1V4alRCSUwwcFN3ZlVB?=
 =?utf-8?B?c1dadlhFQzFHdDNtR1QrcU8vRVY2T3F3YzZaMmd1TmplMmZIQlhQQ0N0VlVV?=
 =?utf-8?B?NnBoNEZsaXFobDJEVG5KSlRzWlVFcjlVM3REb3dnRk5vUkw5VlFLMjlCSUd4?=
 =?utf-8?B?NytpcGxjN1h2YytGd0xOd2IxVExNbjhrY2czTWxrY0tzZ0V4NzhYSzhhTElQ?=
 =?utf-8?B?OW1ZTUgxY3lpd1lsK3VTNkdTK2xjUVVsaXNsWHdLMWNTWHQveE9WSytpTW8x?=
 =?utf-8?B?dHNFZ09sSFExNEdtU0RORkl1a1hNaUZFVkluMEgvNC9NeFZzL3Y2ajBQS0dC?=
 =?utf-8?B?c0lsMWdCSDJ2TWg1Rk9lYWlQNVh1eFgwMUZuMDRxTFUycXgzbHcybWNOcFJa?=
 =?utf-8?B?S1d5ZnE4c0R3ckRMQTJocDFmNWRRRXpxUkRLSXRQZlJ5S3czb0RJNUlQNDU4?=
 =?utf-8?B?ZTZvUEUwbEw2OGVoaE9VRDNkR3JBYnREUzVvSGRXOGFTRm50ZURaNEFJbTZw?=
 =?utf-8?B?QWh3LytMeDNEVkJhazlvTGpaUlFsWWJLRURDUExvOGJaUk4wRmttUkIzalpk?=
 =?utf-8?B?NzNQa2dQRUtyczZsKzBDODc4VGFTbldyWkt2NFY4N055ZTBUZDRCT1RhS2t1?=
 =?utf-8?B?bUk1NTlRc2hkUDY3MWl2OFBXdmd6L0c3T1FTenhwaEJpZEFldFVMVTcrRDMw?=
 =?utf-8?B?Ly9SZ2hYcHdISDdMZ2ZXN3B3L292WjBXOGhwWFZXbU1XOHlhemZwY1R6QVBz?=
 =?utf-8?B?ckFTM2RTQnE5MWxsbEpwNXY1YWVhOS9kcG8zMm5wWXpMMmRCUkpHendYOGZF?=
 =?utf-8?B?VVBpNlcxcm1oSTVoYXNjTXZ0YVlaQWFXbGxtdGxmeXMyTU9rSExlWWYwcWNC?=
 =?utf-8?B?ZnYwVVg3KzdVY1BlUmNRckdTRFZHK2xlMGl5ejFYeXYwMHRxYWQvVlZCZVd0?=
 =?utf-8?B?MHBtUzI4L2YzeDNGTVU3Mk9DSlB4bzRMZytwamF2QjlUK09wd1BDMWpXTEVL?=
 =?utf-8?B?R3d5K25rU0ZmWEdoUFEyaUVjYm02bWxWQUxFdVJZUU1NQjg1dDRjQThhRU16?=
 =?utf-8?B?elYvWXByL0IyZ1M5YWlNRHMwdlIwdDJtN0hYWllRbzQrbzNpWHZMU0lsREhv?=
 =?utf-8?B?dTQ3bmQ4VEk3OVRQTVRsVzljeVhPT0lsQWVZVk5BM3FoeE1mZnNCK3BDdHJu?=
 =?utf-8?B?NjF6Q3dlNWlDVXphUjRkS2dDWHpTdnFYZzZ1d21TYXczTkY4T2MrUlk2QVBG?=
 =?utf-8?B?OU1sNFJEUEFYWEhYTSs5QkZkUS9WQmFubFRWRVp2L3pNQkJ6eTZGVHd1eTZZ?=
 =?utf-8?B?b2dWK2VPQkRUclFQTy9WbTdBRmRzMXMzdFhxRk02MG9TMjB6TFRuaWl1OTZO?=
 =?utf-8?B?NHlKM3dzS2FBWmFhUmFYZWQwMGVkaGZvV0VXL3ppbHdablp1SjBOSmhnUXdX?=
 =?utf-8?B?WFhRNWhjTjY5RVFxYlhhYXVPRGh6eEhJa2REc2tDcFgwVEU3bERjaVIxUCtM?=
 =?utf-8?B?VWZIODV4ZVVJdnBpTnNORjZySHlDQnhHQ2xMY3hhT2lrMGtlYlJrS3ZlSXRF?=
 =?utf-8?B?U2F5bmlCQXAwdDdEWVdiVGVxT1RmZXc0M2VhdDVtb21nUGgzcGIrN3ZMblBv?=
 =?utf-8?B?eVBiNitKRkRac1JaZUczaEZZWDBBcXUwdDBhZTdMTm05TVg4ZlhBTUF4TVBn?=
 =?utf-8?B?alZIdGRndUNpZnFRNnltcWhJNUJTeFlnQXdyT3gvd1prYkkrRDRYV2M3NTN6?=
 =?utf-8?B?dmNSQmxnVWN1QkM5UmNVa1lxM1RsZTlNOTBYT2VDVmlOTWFZU01NcmIrYjl1?=
 =?utf-8?B?b2VDWUVncXZCbXdrUlZyUWdwenRsOG5yMER5S3pST3Z0UXFzNHhOWmtRY2Fk?=
 =?utf-8?B?ejFNSXhOR2FsU1dWKzZ5Mm1mU2FDKzB3bHQ1UFJ0U3AvVW1NNjZEekpsMlFZ?=
 =?utf-8?B?SE10N3B6WUl3ZXIxMG9uV3JBQU1vTjN5cFV5Q0JWUm1pSEVKVnlBbGhTUnFi?=
 =?utf-8?B?VmhmdU9ZNmhrOVIxdzh1Z0ViM2ljU3d0b2Zxd2RjakF2U0pXMkMwN0RIWElE?=
 =?utf-8?B?S1ZDVjhuR0VmUnFQMm94MHI4bmZCa3Q4NU9hNXRhOWJ4eFlBL0txWlhMU2pJ?=
 =?utf-8?Q?7isyL4dppDY499qHd50f1vVTT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47836e51-3543-4db9-341e-08db94353815
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:20:49.9527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aVer3+nsaPZqC9SH6UPGCogpsq3M/8HGj7WfTJrSbRAayzKgcdKS+NOBL+kg415
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:17:15PM +0800, Michael Shavit wrote:
> On Thu, Aug 3, 2023 at 6:14 PM Michael Shavit <mshavit@google.com> wrote:
> >
> > The iommu core doesn't guarantee that pasid domains will be detached
> > before the device is released.
> 
> I'm not certain whether this is possible or not. Is this change really
> necessary?

I think we should rely on the core code to detach all PASIDs prior to
calling release, drivers should not do this. I suppose that means we
have a missing bit in the core code.

FWIW, I'd like to get to a point where the core code can also
automatically attach an identity domain so that the driver's release
functions don't have to open code that either...

Thus I wouldn't do this patch..

Jason
