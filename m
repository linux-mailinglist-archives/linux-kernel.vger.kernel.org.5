Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B1753BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjGNNV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:21:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DA1B6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAq3yNAcl8LDm7ZvMX1ztZZD62j0Ymh+FhxhpPxDD9Tog71CoY3l9UTvlsc1G+5DTwrarhTqiBh3p9xzECafFtbRr79TkBLMDIQkBMxbeq8xosfAtGMruEoMuZAnzyErQOSxmFZYWyHwRjSmA3Mk8krUQL+qosAHaEwOt49GXEkfF7ImN9TID4S7mMIzdhztHZbsD1hagatqC9U+jD+ic9UqXOAipRGcB5TMhmy+hrPYxPjmVjvlp/6D43ESA9YEvNvjNjeaZMCYe1RCMRxp8q7296+r7TCCF0mmMp/Yz9vcO+X7RgpPLvdVRA9MuG/PWWB0K5LE8CklmAH/g4O/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh7dGIyrUfe/kJXD7jc2k58MEsA/vvgHQgLGgTRXK/4=;
 b=nGsD87xIc6OsIVlIKJazTYI2u2TyJwA71LO+HPRpEmXjtulezCNn6vLsLahjXPeedF7SVYnByf7QcWfcXe+CaejGeU3f+aer64iIbRn0wws+cL6sp3Ki8oh5RmckdKWBygCtS/qGmbXZrBi6JP+9ocoNx2d9B0a/UdVwpW5KfSGJEHuAIn9J+vx5jG66An+PdswH2/u6i/4/gExJJKtaYJElifnT1tdfH3clYSqPSNDEy/dGCL5EhN/4EfG1EA5pJyEhxvIMjiK1h7poKsTe2do8iaOOogxo18JHgsyF4m9ivRqDHlOmwnFo8IjowANoKT/KaeBh5j3aVPRNpgtFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh7dGIyrUfe/kJXD7jc2k58MEsA/vvgHQgLGgTRXK/4=;
 b=mNUX2dhh60L2nFgERIKbBf3n616VmTt4vTG9a5vHf1Nl0/ECLl3gi+7TGu8oGpPAYNF0OyN/XAyQNZ/VL7FQftRRzAy2I63yC5cJ4uZS/tNE4uE+bVBzVkpoiiI5h+j39lV8Di4oGQHKWTlBoyCuJNW9EdG7uJfywndr6iqBWCgDZQ6WV0wLodEiR9BH8HPspjQ010FzA8iyBXBVsDNiauyHACe9xeoQpyp6eExXzj5NAsnayMpHiiEQLNdRv1cvH/wFTIZb4FEB3CqmpEWzLOnfUlJYgE+eyp9Pfs7lxl7yKkIYSAf5JImc8bS8oM+1U94XWZA8eS674REkpWlFQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 14 Jul
 2023 13:21:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 13:21:17 +0000
Date:   Fri, 14 Jul 2023 10:21:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLFLyh1b+wiqb7Ql@nvidia.com>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f59c63-da88-470a-920c-08db846d34a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ky3EAGPtqMO1CJzxwU5V+hXEgwcIJbe1LQX59vWZ/FrTBraasIQekLCMXjYnX7+s9CgLk3D/xJtQgVmCOq7JlnWIPFtowcVbwotUoF0hY2joo3dJ0X2RAY99k7i6h2n7O80g2lsDTjoPnrGs+nv0kb3qN99hzRH157/zew6la5NFMpL1++S2ITs1SPtSekjVswtux0c1bbD2jyo9M8usqcQDuv37IYBbQYnvSOcam8aLjS4wNkBO0kD6Hmwf4KqxgM1Yba3EDtnzftVjJgyXHyt/O6OLPzcNbcc//eIbAKL+wN4h/toG83icbOExTSFP+wkqGhj3z4YSJg/43QxLcTsTq9aESDUs3wIKJYAIm2w0ZZwCJAP7jvZ9E/Fg5p6G4LCLCIitASCXk2O/Dg6nXUOVi+LGkSNxVa8e19RaKB7Rzgr5K+iWK/TNbrAzH3Wl/s/B8Q4PVLASxjf+d2E5wJFwYDUf+GNzM9Ykfh4vhLxiC2b4lvrsKkeE24SqK+Tr0xA+El6Jg/YICGM7d04KJvbEQkDhig3gsMyAdU5lq4GmNdgViVWeelMevhajKppi1qqu2CHBXHSRCY313EDtbXViikBFxuc4hNk11Wy1LrCKkm/1PdyfYE6jIB4nKRuU3CB4EIIxAYA5AnCpEu4RNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(6666004)(54906003)(6486002)(478600001)(86362001)(83380400001)(2616005)(36756003)(316002)(186003)(53546011)(6506007)(6512007)(2906002)(38100700002)(66476007)(66556008)(8676002)(26005)(41300700001)(6916009)(5660300002)(8936002)(66946007)(4326008)(67856001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkhta0xPRkxWSDRlTXJ6Y0VCN3Axb2V2enFpeVBxTjMzRzJDdlVzYk1wWHJh?=
 =?utf-8?B?RmpMdFJsbWhId2tQTFJaY3pLUWtnbnVBeG01N3ZpYk1LUk5oZ21RQzJRVnV2?=
 =?utf-8?B?SVNsK29YMDlFQnp0aFUxbmhRWVoyUGIxZ2VSU0lKUzk4R3ZDdnNGdGpVOGRL?=
 =?utf-8?B?aWRPbXdEaGVSdisySk9KaWJBOW1KRmNBNW1kY2FsN0JXM280U2lFYnRMVnBX?=
 =?utf-8?B?T29ZeUhDcmxkVlBhcFhiNE1sN0M3cUw4QWcxVStDR1JlcHVmUUpSblVVTjIr?=
 =?utf-8?B?cng0R2xONUh3TjRtR05uNlNrQUlCYzgxWGlJRytjWUFRU2s0N3BVbmt4UXpQ?=
 =?utf-8?B?Mld6MjRpZUc3UWlCdG9lQjZCa1NOZFFqWExiU240RmY5QXR1TGwxZ1NkMjZr?=
 =?utf-8?B?QmVHbmErU3ppTW1CRS9ESklrVU5jbi9SNWxtWSsxRU1QVGVlTXVuZURhTnNz?=
 =?utf-8?B?bWN0NlZvUnM3UEUwMFdnZkVBK0UxUUJNZzlZWTQ3Nld1bDMya29uTDJ0UUhp?=
 =?utf-8?B?N1owRnZFOEZsRDVOcmYvQ2IvbkhLcUJHMFB2SjZKU2xpM29DN1ZmOVNLd0ta?=
 =?utf-8?B?UkpCT1hxRTZjWUNZaDFrV2tLR0FiVTEwdSt0WHViNEJmUVpyNjZuaFhldU9U?=
 =?utf-8?B?UmhUYVU2RUM5a2FabTZYTnM2dFd2TWVveGpzZWlWb2JDMmRMNEY4WXJqS2NV?=
 =?utf-8?B?WFVPWWtBSGJjbXcwZzZ1TGdMa1ZGWVRJZHFaOVowcW5yQ01xbnJPa1o0em5X?=
 =?utf-8?B?OUd5bzRMWDFtVWd0QzNQUDZHUWdEdHhqWnhtbTNaUXhsSUpBc0pzNkpROTdO?=
 =?utf-8?B?UldvQzJ1cGVRQmxCVzF3WGs3S2NTdElJVm5PVVl0VWMvbXdST3NVZzg5Y21m?=
 =?utf-8?B?UlJhMG5Mam5DR05NV0tPRllZa1dHN1gwT3FYRlduSjJzQVE0TEFjU25ySDlM?=
 =?utf-8?B?NWY0ZDhGOGxxYXIwTndNSnRrdmNTeW5wZ1RsYllXaTJRSldlK1FEb09XRTBm?=
 =?utf-8?B?UG9TU3AyM1RHbHRVU0VMRmlPSmhTcGtTK1VkTkwwRHJxVkVmNjRsd2ZQNWJW?=
 =?utf-8?B?QURLZzFLUGlKc2k0RTZORndoZzZhRGpaV3UycEFmQU9ld2RXUGlUNUpRdk9x?=
 =?utf-8?B?djlPejlINUdNQ0hQWjErbHRwTWhxY3NPb2tzUDRpdGpzK0huaTZKamRlb2ox?=
 =?utf-8?B?b2pxQUp0eXNCTi9hVnhmTHU4R3F3SkM4VC9paitKdzA2VjNZR2JSbDhUZVB5?=
 =?utf-8?B?ZWd0ZFFoQ3RHVEptWVdmUms1cVBHeGFmdXRLcGsvTUMvNVBiUEU3SFl1SmVu?=
 =?utf-8?B?VHlFK0ZBSmhkSkNqdUNWcXorQkl4ZThjNy9jTC92MHJrOE5ZR0ZiQUpJbmNo?=
 =?utf-8?B?S3dwdlEwYnlQSTh0dXFlVEh6UTVEbkpLNUJISlJjNmRGRUtxUGlvYkhkUEZp?=
 =?utf-8?B?dEY3Mk84eG9tZTlvdDZLYmR5VGxWb1hHK3VERy82c1owbEpRMk0vQzZLZlc2?=
 =?utf-8?B?Q1pGVS9GVmMzRnd5RncvbS82bFZsbWtJMUNkZ2duMTQyNVVja2EzZi9Td1VM?=
 =?utf-8?B?aFFRZ2xSQ2h2dlBNcC9aeW5UL0M3V1BpaEFIV0x0MkFvQ3Y0TkUzL0RhUldY?=
 =?utf-8?B?dUk5Mk9yVzEwS012VDZ1azBlZGpvUCs4cDk1UzBLajhnTVBnWFU5dkdzVk43?=
 =?utf-8?B?cGtTQU1pekZoQ05peE11Wkx3WEgzenhHdEdiVjhTWGhWQzhMbzRwc3MzWjk2?=
 =?utf-8?B?SVRmWktIWUZ2RFhNSmRMMDEzMjNZQ25xZ3BQTTg2c2FWMXJOWlN3YUxzTHo0?=
 =?utf-8?B?TFpBWEZvSWl6QTFIY0NRSW0xTlNEaXA3K2NqTmhDQlF3RXpoR0hDRjZhbmNY?=
 =?utf-8?B?QUV0V09oMEFUSnExWGRBbG9rajN0MU1ZTCsremtRZldwUlpDWEMzaEt6OHU1?=
 =?utf-8?B?Mk13em44RkFNeU9oeXVLcXNjR1ZEM2ZOZnNPcHp3WUlyNHhJeDZTdDBWUHMy?=
 =?utf-8?B?WGVVTzJYVitUMVRGbDI0eGRtWnVIRG5ad3dqSmxMN3VpV3dmQmtVRGR0RkE2?=
 =?utf-8?B?c0FLVjBFdGNXRjRydWFNZVV1QklCWjM3dXJQK0ZrazRvMytVSU0rTktNcFA1?=
 =?utf-8?Q?imkawTBfmy0Ip3SbqwQUm6TN1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f59c63-da88-470a-920c-08db846d34a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 13:21:17.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2+mWhY9GkMfyYYXCm2kxGBplv792tTwBFK0UNkdX/nbVZF49XMHQe1RGf6Q4PVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
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

On Fri, Jul 14, 2023 at 04:02:50PM +0800, Michael Shavit wrote:
> On Fri, Jul 14, 2023 at 12:41 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > The master object owns an optional CD table. If it is exsists it is
> > used by every domain that is attached to that master.
> >
> > In the code flow there are two entry points to attach a domain, attach
> > to a PASID or attach to a RID.
> >
> > For attach to PASID the code should always force the master to have a
> > CD table and then attach the domain to the CD table.
> >
> > For attach to RID the code should do a bunch of checks and decide if
> > it should force the master to have a CD table and attach the domain to
> > that, or directly attach the domain to the STE.
> 
>  Yes. This is the current flow (except that we fail instead of forcing
> when a CD table isn't already attached in the PASID flow).
> owned_s1_cfg is simply a pre-allocated version of your optional CD
> table.

Really? That seems like a terrible name for the CD table.

> > When the master gains a CD table then the CD table object becomes
> > attached to the STE. In all cases we should be able to point to the
> > object the STE points at and don't need a cfg or pointer to cfg since
> > the object itself can provide the cfg.
> 
> Ok, practically speaking, are we just talking about reverting patch 3
> and keeping a handle to the primary domain in arm_smmu_master?

I think the master should have a pointer to the iommu_domain that owns
the STE or if NULL the master should assign its internal CD table to
the STE.

The iommu_domain structs should not have any references to a CD table.

> > I would suggest a 'cd table struct' that as all the stuff related to
> > the CD table, including an API to cacluate the STE this CD table
> > requires. If not in actual code with a real struct, then in a logical
> > sense in that a chunk of the master struct is the "CD table".
> 
> Sure, that's almost exactly what s1_cfg is today (with these patches)....
>   * s1_cfg.arm_smmu_ctx_desc_cfg describes the CD table
>   * s1_cfg.s1fmt and s1_cfg.s1cdmax describes attributes of that CD
> table. These could technically be deduced-back from
> arm_smmu_ctx_desc_cfg's l1_desc and num_l1_ents

Yes, this makes sense, there is some redundancy here for sure.

patch 1 makes sense, arm_smmu_ctx_desc is effectively the Context
Descriptor Entry, and it belongs in the domain

patch 2 should delete arm_smmu_s1_cfg and just put
arm_smmu_ctx_desc_cfg directly in the master. arm_smmu_ctx_desc_cfg is
a weird name for the contex descriptor table, but it is much less
weird than s1_cfg. As you say s1fmt/s1cdmax are redundant.

patch 3 I don't understand, we should not add something called
s1_cfg/s2_cfg to the master. The master should have
'arm_smmu_ctx_desc_cfg cd_table' and 'arm_smmu_domain ste_domain'

patch 4 should have everything working with the cd table accept a
'struct arm_smmu_ctx_desc_cfg *', eg arm_smmu_get_cd_ptr (get a
pointer to a CD entry in the CD table).

patch 5 makes sense, but something seems odd about the order as we
somehow half moved it in patch 2?

My suggestion for patch structure is to start by cleaning up the CD
table object. Make arm_smmu_ctx_desc_cfg the CD table, remove the
redudencies, remove arm_s1_cfg, clean the CD table APIs to only use
'struct arm_smmu_ctx_desc_cfg *', add the 'ste_domain' to the master,
and then as the last step just move the arm_smmu_ctx_desc_cfg from the
iommu_domain to the master.

And that is a nice little series on its own - you end up with a shared
CD table in the master, and no CD table in any domains.

Jason
