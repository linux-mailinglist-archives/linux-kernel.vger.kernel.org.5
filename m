Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72470766D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjG1MZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjG1MZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:25:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1D4EFE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSUOIZEcX//v0OYKA6JWD10cQ6zxwzKxirNXHxY/oHZQJyajmRaPkb9EbV/RLj78LfXL1l1lBf7YicBnf/HL2h3CvSZP5dcRFCfr0phu2pFWE+dp6u7dH/MQ63lyANEI7pzXZjYs1Azim5dC4G9SYzjT8+d7oClFqEkti/QFNt7i6AyUdGZJHf/GUxmASdFf5mHbRLSt43aXRenYeOhSQKw/jePuDGxDeZIVg39Y93N3jAQQNNSqbjcyWNnbsSnXCEHnz7Chc1M4/O9gz0w5LGvsYtITRCxyWTJUMk3iLuo6RdmiokbsCCCjQqea4NBWG3emDeHdyAPTPn+QL1ofpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBb/oi8pQ6zdpSzg2luwlme1AzLFR6/hgdZyBQ6YjTY=;
 b=lRmkq5hl8K893v3qNfVx2iiJX97BRKn7rxNBSZEr/fcW9YaB5hIOYKTk44VZTJ8Lpw5Ykihf0AMkeZq++s8z1db5K9D+XHrAirIAqfGpJASenNSt/vQbp+7OufObEVISx6SVTYIeqA8OthisH6laFq8OSVHJdeMbiOgTtSDWDLNvSPVptAJxd2keHOGXQEwiD8r5Ny7tM2XZjMxQ6u3rSYmUSgy3t9CeNTySk0gOgKVxClzt9/3vnOCROsKev9gDpxKudyL3dOeJ0ZeZGCX5guFt33IwdKZikWvvle7+RaiUD8KblbF7AjGDn6nTiEacEIFde/hVYoBSE5HSrKDVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBb/oi8pQ6zdpSzg2luwlme1AzLFR6/hgdZyBQ6YjTY=;
 b=o7bTpiVvWtQmMxC5M63lOMLkCHslO0jaSwuZ8S2oqSGkOrRMDU6C38xpKAtRlZJE/WfGDNi09mBxI8IwN4jmpmJ2YRH8HPbbsUowTn3Y4UMG7jgwSJOhcFGqg1NE+sTXwh5UNXwpA1DIUJ5zB8qHF6/A4uLmpH5u4VYnddl8UMyo1cEp1msXztV3V96sOGyjYFm6WpuyAh/r06G4Vkp4GrckTxiIOTYsxn4aKdQnWZjovj6EQ8wDyd+OKaQYQP4juVl5QNP/DZQM+5drQ8Kaid3qo4288Y798PdKLSVHwZNiR7LucjTdGBksLdbnkLio9ltx9yp+8MiY8Gs/DpmP4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:22:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:22:55 +0000
Date:   Fri, 28 Jul 2023 09:22:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/7] iommu/arm-smmu-v3: Replace s1_cfg with
 ctx_desc_cfg
Message-ID: <ZMOzHJO23ZakRs8b@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-3-mshavit@google.com>
 <ZMLaM9QjHDu11iKf@Asurada-Nvidia>
 <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV252e5Cx1nssFTPVBmr_iGqLhvp1jjBfR5euRynAzHC12w@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ba3c14-7a51-4a52-263d-08db8f655eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWe6G6GzCNx8oDOVuHPL4y6RH0k2QKLsStn2WAAYuNl+tf/9UVdRslnGGtU3akeFFuCGnymI/bTu5q+akFjQV2opiFtcEWkv9oEEQG1ZHKJG3BV5a7nmKW3UkaKmdjKG5NY0ekiYeWbita8hnZWMPtavxfFndgnba/h8/kbJaRB3v83BKYWjI5Ip14NrHNUJxYJ+ydvFK8jep/Ptz3CFMoCKLdZLj7gQkJIqh6l8dIP3SUtF1Fvx0Y39jC4/slAamdGBpMb9InC2NWOBUyvpS9HxbBsbCwI4cHiMo0zUAlMg3FljNpHwzjJTJ3b1cmsZvT4lcMUphpM746DVXSDG6A7cQN87OD29yjeccEb+pqsgeignZLHaUDxsBJymlg6NqZCVA4HKKz/Lxf/wtvh0zUmJeAN34q9uOAEjZgP0FrMyr6d/5o2xVyDlyd3Qhav/+UHpB9CTQGxJXl/q/kqS9Xxw/IXcQdqvZqSb8YEe7EJG/18ecmpQ4+H7InuVdXLNFaNQ7DMpBUlsLI7IrHxHonUb6KciMg9WL40akKUKSI1oJ6sjY+nvLReEJV1g9085
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(478600001)(54906003)(6512007)(6666004)(6486002)(6506007)(53546011)(2616005)(66476007)(6916009)(26005)(2906002)(4744005)(66556008)(8936002)(316002)(8676002)(5660300002)(41300700001)(66946007)(38100700002)(36756003)(86362001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUV3YTlhdlpCbkJTcUlyUnBycFNsaEdHOUttS01oSkp1VnRKM2hybXFOS0lY?=
 =?utf-8?B?RmxwUnlJSmNVS25qSFlrMHljZjRSN3g1QXpyQmNXNUpxTlMwcTUxd21TUzdk?=
 =?utf-8?B?RGNQNWduZFlHSkJJWE9hK3hSdUxUU1hLYXlVbERsaER1VXBIZWhsZ29McVVl?=
 =?utf-8?B?K2dPcHMzdCtid3lSdmpqVldTclJCclllbHgxTTR3a21JMXN1V2k3bHJXTWVn?=
 =?utf-8?B?Z3I2a08zT0kzQTRvWHRTb1gxSURPRkhVcDcrTjMwVmw0ZS9VU2ZVRmpvbXdv?=
 =?utf-8?B?UjNIK3g0WWluQ3pENFZqU3QvMUl5aVVoZWNOaXFWWVA3VVkxcXF2aDkwV3NS?=
 =?utf-8?B?NFBnVjRaVFFUNytuajY2Z1p0RWxzMjhidGZOK0dyb1FidWV3L3hOU1N6bXZL?=
 =?utf-8?B?dVZYcXkvMDk3WkpraFVycmRXZGVqMzVtcDQ5cG1la3MyL3N3L1QwNVd6VWNp?=
 =?utf-8?B?elV4dGFpWXhHdlZUZTFHNUZLVEY0UlhaS2VOQ0FSelVxMlBjSUtuTmJxNTFN?=
 =?utf-8?B?c0hjNHZpZWtxb01LZlRLOTJ0VEdwWThuVjE0Rm1zMUptKzRQVlJtcmNldldo?=
 =?utf-8?B?ellhNVFJSThZQVpwNk1qSjB2MkdGYlk2eWErR3BJbXoxQTFZZGFjNDJUSits?=
 =?utf-8?B?aExHdHpYTEpKc0ZHOENFaS95SlFaUk9GOE9wTUVxWlRMTHRYSXAza0diOHVB?=
 =?utf-8?B?eW5tdUUzQUZLYTU4YXVLK283amQyTXFZeVpZM01MdDVBd2tjM1ZLMkxBWmp4?=
 =?utf-8?B?K3Z3MVBBOVR1eGZaNkJQRnh2VC9HTXg2eFFBczdYOVV4dXc5akZpMk16VmxZ?=
 =?utf-8?B?dVJXTEJpNkZ1U3MyblRPdU1maUlLUW1sRHJXZ01TQUdDR0gwdG10MDFCN1dx?=
 =?utf-8?B?S1dxWjAvL3p5bUVqMGVlbVpRZ1N1WUM2QWVBeEgwdXpGbGlTcllSR1NnbEdw?=
 =?utf-8?B?bVBYYjhNbFNieTlOeDMyRDJJaGNZNERRYUtJUU9hcW1IaUprUFFscC9zbUpm?=
 =?utf-8?B?amhWL1ltOXluakNRQmJOaFI5Qk5vQXdQWm9kTzFiMWQ0M015R3BodDhJNWRK?=
 =?utf-8?B?S0F1VS9CK1pUdWRYSlZsOTMzb21rb3JNZThKZmsvWWx1cmJYbDg4bFJXdHdr?=
 =?utf-8?B?V2JEQ0hvM1pzdXIvZlNRT1pJd3drYm1vbTZqWXZnUFJpVnJaUmgwQkF3ajBq?=
 =?utf-8?B?UWN2VG1ObVJkbWVjSXZlNkpScmw4N0FaV2xrM2RVT1pDblNpRm90YzNOd21u?=
 =?utf-8?B?eUwzL2NSbE5zT2JONS9VM3ZxQThGZmQxUEFycFYvSVRuRy9lN090eDVKTlVx?=
 =?utf-8?B?bUx2czEzanNESWFJcFh3NCtldS9LSkM1ZVd0K2FabnQ2S3F2N1NFSVJqbkE2?=
 =?utf-8?B?RWdwbURMOE54NVBNaVNXZHY3QkMxTkcza2ZURTlpYmJXU2MxQnE4SUJOSGZo?=
 =?utf-8?B?cVg2ampibWM5MHhGTWUwUFNkMUY0Sk5ObnVYVlA3NjNZbjdKNTd1RjlzUkJt?=
 =?utf-8?B?ckYwWU16b3cxaVZESlhlVFJuZWJUTC9ISS9rVHcrWVRuU25GZ0lsd2VlV1FL?=
 =?utf-8?B?elFrUFdIUGxSL0ZTcVEyeEk2NDRtN3hKT090VTlnWjRuK0h1dzRkWjRQRmgw?=
 =?utf-8?B?U29USjViMy9DMFM2WSs0ejhNU3g3RUJIck5CMFBqRzd2b2M2N2lrT2pTeXpp?=
 =?utf-8?B?Ny9XZjl1MG5UTlQ3TEIyZk91dEw2OFNjQlZwbllLa3ltQWx3MHcreFBNYWtS?=
 =?utf-8?B?MnpqTmFjbkllbU5uTC9iMXN3cEQybHlYRDJlQXpoaGRCUmJFVHp3ZCt3VFpx?=
 =?utf-8?B?U3ZXbk1PS0VGOFF2am93bEtxUnEzVDlyUGZoVmozYUFKRkk2RHVZc3dzQ1VK?=
 =?utf-8?B?OXh1YjVWcWVrUXRNNlNva1dWSmc1TnF1ZjA5eDJBOWVQVjMvTjZnblRINDJh?=
 =?utf-8?B?eldLREphaWFFT2lRcFpjVnRvRTBZdk5EU2hBU3ZyTWI1U0JyekVQd3BhZHR3?=
 =?utf-8?B?WjVzK2R3SHdaQWN5K3M4MER1WjJuZ2J0RTg2RFd4djNiQlV5Y1lFRm1zNFJs?=
 =?utf-8?B?bnppTkRwUjVTSGNReHdsTXlOVFRKbHR6MCs5VjZzT0pPUXJqLytUaS9qWWdx?=
 =?utf-8?Q?Rag9fH9umC8htBcy/Oznf1TgU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba3c14-7a51-4a52-263d-08db8f655eee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:22:55.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cv1+Qs7OlqY3/4dhG/O98Fy8gr1D7Kk64eG69uWpUbnNgtzRsrBDNf5c22Eozh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
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

On Fri, Jul 28, 2023 at 03:47:45PM +0800, Michael Shavit wrote:
> On Fri, Jul 28, 2023 at 4:57 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> 
> > It'd be nicer to align all the variables to "cd_table" like the
> > 2nd piece here. And if we rename the struct name too:
> >
> >         struct arm_smmu_cdtab_cfg *cd_table = xxxx;
> 
> I agree that renaming these would be nice. There's 36 usages of cdcfg
> in arm-smmu-v3.c, and 6 usages of  arm_smmu_ctx_desc_cfg.
> I can rename the struct since we'll be touching many of those in this
> patch anyways, but I'm a bit concerned of the churn from updating all
> the cdcfg usages.

Will was not keen on churn for clarity so it seem better to be
thoughtful about what is touched to get this merged.

Jason
