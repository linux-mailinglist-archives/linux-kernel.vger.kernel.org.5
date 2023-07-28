Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCC7675DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjG1SyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1SyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:54:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E608136
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2JBdIgOW37aRlw88btCrpw/Heh44usGkA39HLze8A1kEiA2XRHNhVWX95+3is4xhrZumFZ99bZBHwwA4FRLNFY4Wbuol2mgsDvsY4DhivYzY6hVBT20Lk5F8b/XDotPG+d/sr4IjES3/FI8SF/ZMx6fK1FudHtnZ0+Ufz8zp8A26V9GZZ6R+AftIqL6mc/ujAiJmJfXnyhandsKb1cT8KVxIfxfg6/cDMPwYmHrvh9fjOC1ST72gQ5PzX9SoJicFpSMtjx+y6YlAwqq8iB3VNi0yqsU036QGqgg1z1LB4kWOEw+R2XIYdc6sP0vTXcBzaho+QSx9qIkn+XCma5pGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLrC0GxL3phczp7hp1/wLEDHARYRSqvWZEd4miQjgFg=;
 b=e9Dg1FBE89lJaNDHfQXJjOrA9YuwVm2tL2PfD2F2laJB4h4uuneSJZdviiuvHBC5wxBcZrQatiwCNpHFehDqztDsd5HiyjK2OuxaI1pTqPdB6J8LLDBv7mtTWBUUIwgAJjiOoOFKhYdzav4vI8cuGXqx+aohZkXv8OVnmoCU6P47wnHKNV2C6jxIRY3LuXAxKa5ZR0C2fvDhQGAKVEWUv6Rm4DauGep6OPSZLyJ2JfFv2F50rdtqs7v7fgsn8LGhWHih+5f/xdS7fpFuprFlreCeMnG0dnb1BnFQsBrSWHjPj2GyklEvU/4xlytJJqq6SI6NtTsZsOAateBDl0gzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLrC0GxL3phczp7hp1/wLEDHARYRSqvWZEd4miQjgFg=;
 b=sx+fbqLfmy09d8WA87emPhN+uc2eBoraTMT6rGDwZxBkyjbt8m/3pIYZ/YGos2hLewFRBD/DAo60xprVQ+g1t4OYn9Al8tXoerrWgVBEZlNaMjhBeITZHEGk97fjCCecaxmyADdR8jZJKyc1AU8fu+J8s2vyJ5vsFPubolABYbPFYpaOCJrsAX73pzTAaSDLnTHo8IEZymYvWQVdxIc1QXUV6okfZABRlN0NA1xqaKbVnSWAZ7SDaz4Rv9I4soMep5lUICZoP5o9NJ4jXy/jK79CDeP3YsFfmY0VZHqQljvY0p1+oj+NkA1w1dNq3+PTGWmLED1nUcb44+aqKi37aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:54:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 18:54:12 +0000
Date:   Fri, 28 Jul 2023 15:54:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with
 ctx_desc_cfg
Message-ID: <ZMQO0iLDkgaDe7ZT@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
 <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
 <ZMOzHJO23ZakRs8b@nvidia.com>
 <ZMQL1qjHT3NE9FR2@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMQL1qjHT3NE9FR2@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e36b98e-c047-4c56-263a-08db8f9c0880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9DsqVYTG1eUU9BBj9NXeEPA3exjmtcRXJKxySi3cEeLXIc8T1qTa3XCbwpnm00xpKcOI7JpV2LxW91jEuQP/xb7GkNmzN9+ok4FwpfRvB36AAoPtrpCIT4kCun4+GMiR4aDz+FIFvFVcfmDnyP5RxMPXKpBzNYRiYfkKj9H105jJ/dADse9j4ddVHcbCJKmkUwxi19Ms3qYfkoaVX/uNhciqzTa+Div5IsAExlGh9RcXNhkK8QI0NbIfI96kLJXAo1fmh4ZJ8325RelTwkh6JXr5ndc5idO8peMQWwVq/0wR3mYvBI+0lgKRJuO29PghnZWLF6ybT7dU20/bYyXcaNzogzHKVsXmCgikZ+cA4eGIHPO9xt5bhiMoIDbM9wLhLY8cuazZO4gJ/PmHUweHA3k7YFVSmkwekF9AhBt4F8ZOc7YTVUkVKrT1pqp3Fq4tsT38A+n7Xm8p8OXg4zodVDwG2FYCnsuWcKSJEfnDRbB4dlhA0V+gq3y3s2R2dzSj5ZCd/ziX3X3+8FitiVvu3G9gymOV01tYOCSRTZSk9NXnDBtpWfx1fjK1lA397pIS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(2906002)(316002)(6862004)(8936002)(8676002)(5660300002)(41300700001)(36756003)(86362001)(6512007)(6486002)(54906003)(478600001)(26005)(6506007)(186003)(53546011)(37006003)(2616005)(66946007)(38100700002)(66556008)(4326008)(6636002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZNZzBYUkpqZENkSGNsQmNpbVVMQVRxZWZyUjhOMng5NGFIU0FKTzljMDdU?=
 =?utf-8?B?cCsrNjA5b3J6WWFjSFoxa3VjSXBYVUpzWnB6bjN5N3FOTy9JOVk4OW1aYyth?=
 =?utf-8?B?ZnF6N0lyc3oyYjRKVjNUVTVONDB6YkdJRXBqUWlqTW1RUVFiYklhQjF2SDk4?=
 =?utf-8?B?VVB4ZWl6QU1BNVV0QUZSbVJReFJTWmFwNWsyUkgveHhrYU1NSDZMR1JrMjJR?=
 =?utf-8?B?Q1Q1L0NJM1YvQWJKK0lZaW1SYTB1YXhHOTVJbVJlZ2ZJWmZEZmt3TXZhSnQv?=
 =?utf-8?B?VFV4QVlvSjMxM2R3aFpvUTViK1ZrR0pra0I2TzNLb2pYd0pBSFl2dUdlREN1?=
 =?utf-8?B?QjVQNzRPMyt3Y1BGUStncDVFSXF2M29XcVZBNERzaGJSU0FVSUF1N2Z6ei9Z?=
 =?utf-8?B?NXVkQ2swVkRGTXBTeWVvQ3VwREFHUUNrR0NZTWQvVU9PallpNnVtcjljYVZE?=
 =?utf-8?B?Rk5GNitQNmJEOEpwL3g5cnZrMkNhNjduK2J0MWl2Ky8xZXZEdzRSUi8zeGhR?=
 =?utf-8?B?UXU0RFZDUHlJczc5clQ3REtxdWM3alU5QUs3NHlBZkFxWndoWFVWeWkyMzNh?=
 =?utf-8?B?U0lHZU5wMFE4cWZrcHc1ZENtdlRZeXN6Ymp3VE9sbktiMFg1RGhyLzU0T2sy?=
 =?utf-8?B?SCtFU21teWhpVERIOVRuOFBnUkYyam5HVjR5U2U3aHlDT3lpR2szYWhNam9h?=
 =?utf-8?B?QzdSTnJDRm9kU2FRZzRwVFZGNEdhVXg5d1BHcnp3c1ZQSURwK1FXY2x1N0Za?=
 =?utf-8?B?MEtPTjhjNHFJZmdEUmJ3czI5cHo1UldXODdueUpPeE5oMFc4K3Y0Mzd2ZkhT?=
 =?utf-8?B?bE1UWm80aFZMNHhsM1FqeWgxY1BwV09Xd0Z2Qkd0R0phQnduaTQ4ak1ZMzUx?=
 =?utf-8?B?WW5CdEdkNnoyM29qMTZJU2VQK0tXdG1zZk5YRVVlblVJMXJ4UFNCZ0lMckk2?=
 =?utf-8?B?RXlPeUNwTUx4bmtCRFlhbjFKZW5BQlNVOUcwM1ZmQnJITzkxR0FXUkNrc09M?=
 =?utf-8?B?eS8zUDd0K2pxMVhoZlpBS3ZXS1B3SWplY1BmRlp4R3BLSDQ0SFQva2JtU0d3?=
 =?utf-8?B?VnE0eFQ3MWVpUmhyUG5zWVo4cGpXTllzRi9aaTJVNTMzV083L0g5L0JtZVYw?=
 =?utf-8?B?SXV4V21UY2FPMlExNEJHVzlNSFFPd2VRcnVla0dKU0ZraTExRjVINiszVEoy?=
 =?utf-8?B?OS9adXhsME5GMDg1d09JQ3BROVVWKy80MjR1ZFJEMGhnZlNpdFNTY0JLWlRx?=
 =?utf-8?B?TjBQdS9kU0pURElZdnZnYmlvOFJybzl6Sm1RTWp3UXJUbU5hSzFiQXhDQ0Zu?=
 =?utf-8?B?a2JBZHZGd3NxVStaUEhVbGRGRTl6YUtzeGprQjlYMFY5SkMwMVV1OWVVc1Ju?=
 =?utf-8?B?czd6ZWhXSFg2VCtwSktiTE5qZDlucnhOcGJtUmZNYUVUcVpIOWxZcUdMYlRF?=
 =?utf-8?B?enkvWlZVWUhtSzc3dExIeitTbkRBRWE2b2JRK1ZPK0xNNjA1aS9CUEIvaEpJ?=
 =?utf-8?B?bldGVnlzQ3pYMmtHZUNRdmF3S1J3a3o5Sjg1Q2FLWHdLRDlHdjljQ2M4S0NO?=
 =?utf-8?B?QlhJK0l4STAwVUxDbHFIOVlZZUhySHJzKzNFUU5EWEhqQkF5QnIvUWRSSGVP?=
 =?utf-8?B?MmlmKytFa09pd1BFcTg3Zk1YaGUxU2ZHQk9zcWlWaS91Y2xSNmozUFEwM3Nh?=
 =?utf-8?B?ZEpPSjdTek4wUGUzNy9VbnQvY0l3WCt1OWVIOEtNSmxrQU00MDByMXJTZjVR?=
 =?utf-8?B?U3ZqdDIwcWptMmNKNHc2Q1JJTFBoR056WExobnFvemx0TDFMS0hIWjZxQXAy?=
 =?utf-8?B?bzN1VFlKdVM2WjUwMGZvNFU4aE9BbmU4VUNrYTV2NEd1SWEzSGd2c2p6aWNy?=
 =?utf-8?B?N3p3dE50QitlbFQ2aHVuTGRKdUNHenp4UkMxRVg2VlJWbHdkTjMvcHlLb3ZT?=
 =?utf-8?B?eDMycEhJNkxYS0RPLzYzdTRlazZRSStvTUdtS3hsaXBWWXl0eExFM3VBSzBY?=
 =?utf-8?B?YlJkbUQ4d2RTOTBMUVBOd29xTWVmdzBJZDQvWEZFM3hONVh6QVpiZVBYQkx2?=
 =?utf-8?B?eEVONWNTZW1BUFpXbXN0OS9URTJQMHRaZzY0ajdiY2hsK2Y2Ry9ERnNJcDJS?=
 =?utf-8?Q?xHKhEakIsZ4EYrdwj6nMgHBX+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e36b98e-c047-4c56-263a-08db8f9c0880
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:54:12.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbMf0inifg99hloQbND/npLDJ0vXIGEcR4pfDEw3jRC7viElilnstGwVnyIO48/f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:41:26AM -0700, Nicolin Chen wrote:
> On Fri, Jul 28, 2023 at 09:22:52AM -0300, Jason Gunthorpe wrote:
> > On Fri, Jul 28, 2023 at 03:47:45PM +0800, Michael Shavit wrote:
> > > On Fri, Jul 28, 2023 at 4:57 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> > > 
> > > > It'd be nicer to align all the variables to "cd_table" like the
> > > > 2nd piece here. And if we rename the struct name too:
> > > >
> > > >         struct arm_smmu_cdtab_cfg *cd_table = xxxx;
> > > 
> > > I agree that renaming these would be nice. There's 36 usages of cdcfg
> > > in arm-smmu-v3.c, and 6 usages of  arm_smmu_ctx_desc_cfg.
> > > I can rename the struct since we'll be touching many of those in this
> > > patch anyways, but I'm a bit concerned of the churn from updating all
> > > the cdcfg usages.
> > 
> > Will was not keen on churn for clarity so it seem better to be
> > thoughtful about what is touched to get this merged.
> 
> Still, it would be odd to have "cdcfg" and "cd_table" at the same
> time. If we have to be conservative, perhaps we should just align
> with the old naming: "struct arm_smmu_ctx_desc_cfg *cdcfg;"...

Yeah, I think changing to cd_table in the places touched makes alot of
sense

Jason
