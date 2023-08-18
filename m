Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE0780CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377347AbjHRNvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377442AbjHRNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:51:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438473C3E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ0FSYS1I+BE5d8607oOR3LZEe+dN1SO+xJ8QZYqhVd6Nw5xbbGFF8A+Czs3M/tcxOSDx0NazcfUr+MHQSJVaf+PWJdPil7RIm4A4SLp1ZtszPcrsp63lU+ehgOJmplNB7/6mV/gu/llmSiwixP92vzswrYmEOAp+19diYg+KUxMyRBTOcC/imIsHRgFHFTRgpcpp3kXiScRohcmVfSRZXWsE5eLlqAMvJT3cBd1xbqsoKYl94nH/rfO9KYUhbOYy4yX2IkE9lxWjqapRSYO6glkKqW8XmAYT/AQ0dBi3+04wLNO6U1Hw5rYQltJ93QiXY9Ztdjtzl+tAyfwwHevTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkkSCKWZ6Lut4WIE57c7gT2YWVHjetc+2w4har1jJmg=;
 b=Iu4SCBhLBu1+KTlEoM+TSM14viCRZkeZzOvMtw2ei3uTrqpKO04oHp4aW8YAwQhCgQ55d2VcUDNzmEKbvugDozqjNZ/N4a2H1qDnk2x3aPukJtydjwD4hs11ixpoAwsLcmG9wmCNKv4CfHteMByi2xbOFZQEiwHTw+g/98utcSplgPBK7bzKHTz4TYKUoc10YnT71tB0FE88xuUNb9ONXzyPi+Zjb/QORw7+x8UjT4w5cIEiH6BuWXBeifTc1gaFQ2xeHSanSSnSRiYj+i3M12htBKXfbXKAx5K6HitsjkFBKuxUUc4XquAQfvrTEodX3ip/nCNyYlkAsS146h7YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkkSCKWZ6Lut4WIE57c7gT2YWVHjetc+2w4har1jJmg=;
 b=ifFBYIKYcIxBoloyOprOeQ3kutGL8aXuBJ2L+OMkFONpTQvXO7nQtfKYajLZ7gqFesWAwt8aHX1hgs2qd0CDpf9elNVQI4biVe57A6pZzt2aHX3a33/xdTZks9gfak/8NzoH69VETCmUYq7TRQF92P+8JMdTUhE/mXoFSKOdUqhJHxRCEgVP1MMb9qD27d0Z6Fh3LZqER2bHQ6Y8Y/fcEVMthWhR+mPPRnEovwoS5dqBIamlsPdLwtdrHpjaqvtfcQ5vaSe6rCOqa7/RJGtCalS+5w0kmzdcKZ8YTu7Lna8QmnX6Y9+MwO5yNcMhV6OldO19KIJZB0mApKl2RXGBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 13:51:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 13:51:09 +0000
Date:   Fri, 18 Aug 2023 10:51:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over
 installed_smmus
Message-ID: <ZN93TO9mRIrX1grw@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com>
 <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0289.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: e138b9cb-20ac-4d54-a337-08db9ff22cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QG83GMHWlKhxT+2cf+8LkpCl91dhJjwNejbJ/jBRo9OYJIZhF4XE/Pg4DX5Qn7R8o7dTl+XZPSaWkKm4lqY1/92xgHfafMcWZHEhS7rmxQX2cXz8mbkiD1uEfFCyR4N9LQVT/VEm/z8rgiUtmvT+xYSjC70caRMonJLS7RXJLjHORDs6kXfzzoSyOhMk2OhrNxNRYLxWhmkQxo85WlA/2TwBsQ4jsYcQ6RK6yBonYokQd0TxnLTFEvCWc3W3/N8XaiWlE6ugyw7jpCEK9x9amqqQ2xDeHTfQGOObcLjwvuvpZAlrG/kYGLPAVd84+wqMHI/LZCezkXOlFgrxPpCc1YnKDwyZOkJqE0qqTLfGEUj2WU5NR3D6wTimVuNY7m9ux/kvx/0DCemZLaQ5ZcCwikXyRmRt9DPiqAVNAVweCiNS9888cxUo8MnrjcNyLScvLqUc1YgbsK5gEwDUplyCjTkEKjTIzW/N1FLYwnpdwMYnY+QmbvGd6Gjs4VbCOEbptGPmXuCEfFRwP+gofqY4OzDHNxh0pcbeDl5NtlE4VeFYCg/ANUU/+x576MpRSXQq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(36756003)(86362001)(38100700002)(5660300002)(2616005)(66556008)(66476007)(478600001)(6506007)(6486002)(316002)(66946007)(6916009)(53546011)(41300700001)(4326008)(8936002)(26005)(6512007)(8676002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJMNnFMRDdHakpzLzFRTzh6OTdXQnBIcVR4L3VHMERGSVlyQ2huWFZJTGpC?=
 =?utf-8?B?dGM3ZlJLQUI3V2hiaHZTVWM1SENnOHhKYys3TFd4T0pKWkNIdElWSW9MUGd4?=
 =?utf-8?B?amRZdkozMkQzWVRrM3BuN1pBRjZHOStmNUVnRCsyTkZMQnV3eU1OZkRySk9V?=
 =?utf-8?B?bVErc1Y1eG1PdGJWRHpSU0FhY2FvS0YrdmU5UlJ6aGhGRTR5RG80RWdpM1Va?=
 =?utf-8?B?MVNNRGZHRWVPZmM1TTNIbDZPcXQ4bDAwVG9HaGZyV1pTZ3FnZVZhVHlVeVF6?=
 =?utf-8?B?aVJQcEx1VEFTZkE0TVU1bktnUGRHNFMydjVKWU1wR0w1N0dVbnpjL0ZXbStu?=
 =?utf-8?B?ei96Zmo4Sk5OMngwZnNwOFZsaFlBekxNZ1g4Y1IyMUQ5bzNtYU54Ull6dmZM?=
 =?utf-8?B?d3YvVFFiUE1Db0s0TExhSSt2R0pmd1RBQno2MC9aZjJ3RUprMTdVc0dPZFJt?=
 =?utf-8?B?blpZV1VuNjlvdUx6eEJMVHYyYWt3RndZRWw0WitTSVF2MXFBRTdSYUlpdFpZ?=
 =?utf-8?B?VjRRREVxNnVHemxXVzVNaU9sM0cwWXc2SHBETWhOK0FqUDNLNWYwUUx1UGQ4?=
 =?utf-8?B?ZytFOVBHMnNqeUw2ek4zTDRtOHdOalpjZ25YanhRcXNkV1ZUYVFVTzRHbkxp?=
 =?utf-8?B?eXB0UmFLOXhNNmQzengrUS9tYlZuTHJwUmkyOCswT3NFbTlaVXdaVjlQV1lH?=
 =?utf-8?B?OWZZY0tKS3BmRFNSU1dQZGg0WU1KN3NodG9xQmRtQXo1M2lMSEdLMlZUTlc5?=
 =?utf-8?B?bFRSRU16TjYrVzRnUkpJN2duTHZrS3dveXVWNTc5ZjIzMkxPa1h2WlB0N3JY?=
 =?utf-8?B?TUYrRXE3K1hLdnpvNHZ5cE05U25VQzIwQkF4QlV3MkFzNEozMStISVdMdFYr?=
 =?utf-8?B?d0d2bFpQRG9tbzVmVEM3UEFGalpaTTNFS0Z1WG5yaExKZFhYb3BRZnQ5NEVv?=
 =?utf-8?B?VkJFNEdVU1VrdTlWeHNmbFZBWExCc1VSdGNla0FDSkRCUWVqaStJcVNPWVlh?=
 =?utf-8?B?WnNJTnV1UEx3RmhTMzd1bTZITkVxUjFBd1VBN2JrZTZkbm91V1JFR1FHTE01?=
 =?utf-8?B?SWtGNS9pVGpKd0FpTWtGMUFUS3VLUXVGeG9vR2ppQi9Sa0NqbFB3bUtLWVBY?=
 =?utf-8?B?eGhJSk9qNC8wbjM1NWZuczhjZGs3emZ0eFZMdnVuQ2VvRGJSWEltbjNSejBO?=
 =?utf-8?B?Um9ha3BpcHNvWkpDMlc3d29HMGJVL1ZHV2t3allnTmM0WVJZZjRkZEhZRmdq?=
 =?utf-8?B?N1N4YU1VRzJmYU41UWEreWs2T2dlZlpFTmVhcXVRVFdmWmY1d0NSQkVXOW5K?=
 =?utf-8?B?MHFYcWVlbzcyTVUyNFpoeXlJbWtJdzJlZGpjTEtENmViRE5pM3J6amRkZkJB?=
 =?utf-8?B?R0ZTN0w5MDFkYUZ3N09FMldkdkFqODlhNkdZSGI2UXpxYkFhbE1IY1dXZW93?=
 =?utf-8?B?SnV3Z3dpTE5LMDlCT05oUlFwdHM4TDF1UE1saGhvNExKYTVDbDBwYTZraHVm?=
 =?utf-8?B?eEdwMFh0dlJUaW5YMXRjS2lDL0tST2ZhNnZnbUJNOHpKWHVnVzNVZlpxVE51?=
 =?utf-8?B?RUQ0bkF5a2o4TmJZUXBISFZXRzVLZUlxWGt5K0trejdBOTNaTjF5V0VDdWky?=
 =?utf-8?B?QkZRUXYwNEJZaGdJdEdpL0F4VmlyK25TMWkxbXVpSyt2R0Jyd2NNcVhzNlJm?=
 =?utf-8?B?cDc0NEtFdHpGeGVXdFVIWGIvYy9pTjI0ZUd4WEtjT0FJWjdQVFRiOGRWZG8w?=
 =?utf-8?B?S2JLNWMydml0VitaRkY4ZmxpOURsWWlCR1dJM3VYdjBHeFRFR0dvUWVyU1pL?=
 =?utf-8?B?dHc3M3ZwYmRSL3VPM0tIWDRwa3BSMFFleFNTejlVMWZ2Qnk2dzhaNTIreDZU?=
 =?utf-8?B?TE9FNENLOURObnRFdDdhZkliT1VzdkRGa0lvYXpxdXRVN0FaV011TUxIQlN4?=
 =?utf-8?B?dUQrbGNQZUNCNzBoL0V4WmhFeSt6TVA5QmtEQjJQQzljVEdaV2MycldLWmRW?=
 =?utf-8?B?VGp1d1Y1cGsxRmt6cGhhcWlKWStUVVU3MjRnU3VyZ2hpS1B3S2N0UlNxanYw?=
 =?utf-8?B?MVZsU0NoVGpHOFBTY3BHMW9yc1NnVEQvczBlWHl6QnBXbXlIbmRZNndWdnZl?=
 =?utf-8?Q?a8gf7IFXodHcUg5AHv+RGTuls?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e138b9cb-20ac-4d54-a337-08db9ff22cf3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:51:08.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5v+7XGXrCkSAXw8aL2P3nMB0FGWhnoORnMrCzWmf8dTXe8Yny8+ZBY0Sd08MNBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:44:55AM +0800, Michael Shavit wrote:
> On Fri, Aug 18, 2023 at 3:41 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2023-08-17 20:20, Jason Gunthorpe wrote:
> > > It is certainly wrong to skip invalidations generated for any other
> > > reason.
> > >
> > >  From what I can tell SVA domains should have their CD table entry
> > > programmed with "ASET=0" and normal paging domains should be
> > > programmed with "ASET=1". This causes only the SVA domains to listen
> > > to the BTM invalidations.
> >
> > Correct.
> >
> > Thanks,
> > Robin.
> 
> Would it be fair to rename arm_smmu_tlb_inv_asid (or move into
> arm-smmu-v3-sva) to make it explicit that it shouldn't be used outside
> of SVA then? Or add a parameter such as skip_btm_capable_devices.

???

arm_smmu_tlb_inv_asid() is generally used in many places and has
nothing to do with BTM..

Did you mean arm_smmu_tlb_inv_range_asid ?

Broadly, invalidation is not SVA specific..

Notice that arm_smmu_tlb_inv_range_asid() already duplicates
arm_smmu_tlb_inv_range_domain().

IMHO I would split the ATC step out of arm_smmu_mm_invalidate_range(),
get rid of arm_smmu_tlb_inv_range_domain(), and have the mmu notifier
just do as it already does:

	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
		arm_smmu_tlb_inv_range_domain_no_atc(start, size, smmu_mn->cd->asid,
					    PAGE_SIZE, false, smmu_domain);
	arm_smmu_atc_inv_domain(smmu_domain, start, size);

And make arm_smmu_tlb_inv_range_domain() just call
   arm_smmu_tlb_inv_range_domain_no_atc();
   arm_smmu_atc_inv_domain();

Jason
