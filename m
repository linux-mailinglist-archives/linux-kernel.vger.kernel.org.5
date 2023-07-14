Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B234753B50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjGNMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGNMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:50:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E16173B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NptHiRZOC1cd6wRIVpYkwmqY1vA0kT4ZL8vdmlZ4JZv91OdvgvJJnu9I3pZ48Ying+/YojplV2QGf6mlPlEVh+gOAsMFGIpMbaTteucAxpXoYS9bsI0YgSpdLzKNQqwYF0a6WWs80QexUOVKeriYWwSbQqmlKa9j/9vU2E2H0vNraOSnoiPSLlRMPEq55qEQXoeVmDDEc4PRMCOaAV5M3Iagj9Pf16NTWQmx7Srs0cG4j2E0WO48UKq3cgtOFq6o6k2vGOPh6N9+JWWOrN1LnYBsBadFFlDpAwOpQi7sNFfJuL8Qis5TzuUr/DpHNB7sgVxf0oZkPtM4EKj8WUym3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMqMMWWxofp3lsiQBL/uHdCoxOg1tBUIv9qzZ/cuEAw=;
 b=HLh4tgNhAT34D7phMt6igiZoo06gOZ+cWtKIHvHvG6Xqi5p0asbS+KPFkZG/KicvaDqffA4xRSMyHPbeMQUNHZlyLMdENwHf/nyQNA1pVDr8FIwzEVji/WuEpXB4g/qm78KXAwEupUH6oUF9SvyJXzFAtMK2JvMiLblXFanKNUBgZqO5RfScJEFcaZ5a+h0yDz6OxJsoSSZZRM8m2Sw6KTI6xKJIFiRrknaQ3M717uih/QoelLzVLkodmdiiNJAjKCbk1UKwwOVUUr3JQuAoqz5TvsxdiHS/pHY8d4EXypK9XwscgqfVggnOS3AccQrqenPhZslC/CvEtO2J+Lr2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMqMMWWxofp3lsiQBL/uHdCoxOg1tBUIv9qzZ/cuEAw=;
 b=g1JXAOoXoPkFMNpd0Ua45OjAGhqTzjt5Zli0dtS9Rm/dHydHqPHYOzhTVVL7tS2Wgtxr3WFmvOuXmPX3SOW4hUIlrJI/LJQHo1zbx8Gru27xBMqnFT5M8IcGYEWEMjlMJWlwof/PBxGDNlqFFYgqJOqevveowgsSrnyGHUaz7bioyXjx4cwtQ4OJzmVPzktZTtThR8pfsSK7NIwOowcEreWncQyIL+vqOVgWcncPR2Ouz9/UUhwE8JXkUFXOelB1O9AV8dyeRcgSIqSomZD5srIkTjEAfeDc1XI5kV4qkV/F8/5x4EKCKJvWeusYAo02+9UQQMfoQOpP0TL9Ie11ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 12:50:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 12:50:42 +0000
Date:   Fri, 14 Jul 2023 09:50:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLFEn9/rc0WBNBfA@nvidia.com>
References: <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <ZLBWh370pPjx2B+z@Asurada-Nvidia>
 <ZLCNUNRsWy/YuHhQ@nvidia.com>
 <ZLChc4A58PkU2Fe5@Asurada-Nvidia>
 <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV240_0bUE-25sND3oSG57jT0yJiZzAt+fPTXehjm=zmRBw@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cbf939-26c3-49b5-3634-08db8468eec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPMkdYss2pu1tcdS8RIHLCEGrQET8cldcc4F9qx6gWpMCqyZnhfn5ySppt2wYA+1q1j2fvZbpVcp6G60TfKeZRUH00wCPmFXS1GXSXjVaoBp5B6hECRp4VLsHTCVFvftV+qAW72/mIhtGLcIlCjKL4hgIOEI1mpW2DspHDNB7aaRQ0d0/Cd1htvQWQmnsVatml0Ty5xSwEcIc6VyFkQOpagylvCyxaj3wocs0kLX27+LM7+4DvTWALX4NoYgZez22/7c9fZvCP13s+yYNzoUGxrMmVPNKz0xYAjNivPWZGUEaPNbNS16+mNOrRW5VCXmAEhJQg9D+8vKNzKxTVVX0ptF+kGIgzKHpFjIy7+0Jn6VYEWJN4N6A7slORn+UWtOdW4M9RL4VLvryITZN19hWdaB7d30UGSA2kn10ti82xruz+EhcgEMHSDAJlaOMCE8xg4AunSkB8pNEhwJ69Ruj/MWtzrAYq85yeHxXPKSibujekrNtnTyNvFdKWuAZXKxIBC7nCvgowV1ExRWZb5uAzdaP9f9gqFoxZlVlAlH/YBC4sXT2LT92iWTo50XRNbn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(186003)(6506007)(26005)(53546011)(41300700001)(6512007)(83380400001)(2616005)(6486002)(478600001)(54906003)(6666004)(4326008)(6916009)(66556008)(66946007)(38100700002)(316002)(66476007)(36756003)(8676002)(86362001)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hWR1NYOTBEU01QNlpkN3lMMmlmUVZaZ3N5ZWRBNktDV0lXeDJabzRGdWx4?=
 =?utf-8?B?bkJrU0h5S0lHT2FzQVNrVUtaZXdBZjE3dXlacjdaR2xDcU9XL1pscEFVQWlp?=
 =?utf-8?B?VW91R1pCNTNnUUZ1cFJkWVJmQWZxK3NiVW8yNWRTM1FyQTJKN0JLT0x6dDhm?=
 =?utf-8?B?UUU2U0xpQlNCSlBXZkI5a1pBT3hZcUVhR1plQ3hQNjkrRUt3RFRsZERYTUlU?=
 =?utf-8?B?dXdNaE9jRFFPYU90SlJLbS9RVDNDaHNIRGEyUm5aTlFPR3hlYmZPUWRxN21X?=
 =?utf-8?B?d2tGWHh5K210MWxJOUpJNGtRbllMVVdXS3lQd1k1Rk9PaUxaZGJ2WHBBNEtj?=
 =?utf-8?B?MWZGMWd0YTVCRWhEaHA3TzdzMEdhY0todmUvdnNUeDdNSEMxaXcwYll2cEZQ?=
 =?utf-8?B?QzQ3VmZmY1lTVnAveklwVmhnMmY4YVp5YkRRQjdGR2EzMzEveEpOaDVpQlJr?=
 =?utf-8?B?TkFhWUpQTUZ0Wm5jaEhQR1JibjdmeWNPWWhpQ1VpeFBkRUhwaXVlU0UxVFRQ?=
 =?utf-8?B?TmtOd0pPcWd3allseE82bTZFTklhaE5kV1NvRjkvc29ncVNNdGRrQURURjhJ?=
 =?utf-8?B?OXQ0ZVV2eUlpWDR3bzd6dUpQSllINGUzTlJBS2U3KzdZK1dCalM1bkJwUC90?=
 =?utf-8?B?elJxeWkyRWlhbUZrekdTVUp3VDQyTXJSNVZ2ZTFWSzZZcVFzeVJXM2g5MHhq?=
 =?utf-8?B?YmZFLzF2K3YyMi9rVitnc3BSL3o2RklaT2FRWWRFYnZNeSs5VnIxU3hoWGtM?=
 =?utf-8?B?VmF6aE10dmh6SjdXMWYrVmVzKy8xOTQ4WXNsdzB1a3BYOWtjRlM0Sm9ud0tF?=
 =?utf-8?B?N1RsZzJGOURZSkcxU0tjMHRvQ0FiTG44V0dCdHB5VGxVTW5EZ1MxTjFGbWh5?=
 =?utf-8?B?azhJQ0x6aWNJamthNkF4TmNkYXR6bm5yNE5rRXdiRmd2R0Z5UkpCQVhEQUIw?=
 =?utf-8?B?Qkk3VWIzSGFkTnRramFjSk1SMkVYU2RtTGp5eTk2cENZL3MyYmxkRUppNklV?=
 =?utf-8?B?QjMzV25yQXNLdVJ3MHgxRkpiSXcvSldsNGNqZksxWmRjcnY1YklrNFR0QXhV?=
 =?utf-8?B?aHI3WDErN1NLRjNoZnAzVmtJNzRWbisxdTgrQTZGMFVjb0NDR0I1SnJ3M2lp?=
 =?utf-8?B?TXJIT2pJOWNpSDFyT2dMQU9HcnljZmsyK2IxUm0yTEU1cWYyQlRuUGlMUURZ?=
 =?utf-8?B?TFFINHFrTlhTaG4zLzBaYnpsdEI2bHJLSjRLZ3NtOXZpTlNoQ044RjlTZjBt?=
 =?utf-8?B?V1ozS2VvK1pyRk45U2U3ZkpWK1pZQnZvcVZlS2pGcE9CeWNTZ1ZKMDZPcFlv?=
 =?utf-8?B?a1NJRENXTEVIai9OZzFFVmJjbEZFSkpVTXpscm1YMUhoK0VtUlhHMTBXZFBp?=
 =?utf-8?B?ekZESHZvNUt0KzBwUlhNVVpLUEJweXI2N2oyQ1FGK3JNdklmclM4T3hqdlV1?=
 =?utf-8?B?eFY4aG45WlhpNXoyWGdCZEhUeTBCZDRUWUVLWXVIdlVrd3h0MHlWTktRbzJZ?=
 =?utf-8?B?SklrVisvcy9LS3hyUHBxVktobHRjVlVWblhTb1dHeUpRL2tFZFVncUpmZ29D?=
 =?utf-8?B?MFVJN2FxZ3FJTC9kVkJOanIvN2NjVzRtU3N4b0MzRFpJRm1rM25EMHVvOEdK?=
 =?utf-8?B?RU5HdmZDUWowM2lxdm5QNEZicW5kTXY1aDRBdUxzRTBGSmFYS0lPRnFYNC9s?=
 =?utf-8?B?WmxMUExFZnNxaEd4TWVBaWNhQW5IRTlZMDhxVkZZSWJKNDE5N0tmemp2Y2ZN?=
 =?utf-8?B?ZlVHbWFjOHFKVzhhR3ViTHkxbVJPYzFNS3B3K1M2QnB2dU9qc3ZJSGJWem9y?=
 =?utf-8?B?NkM2RXpWNktqOVVreTI1anFiaTJHYkVWL2hrdEFhcGJLOWdqcVo0R3lNbHpp?=
 =?utf-8?B?eHFQaHZKdmk5UG1ybTZBblVkQXA1RE9aaWIyemo0Y1U3MEthVTVaTnpGSW5v?=
 =?utf-8?B?ekExRmFuWWp3bnRFRERINi8xQWRxdHJUM3FrU2k4NUo4NG5TMG5xeTFYZ1k5?=
 =?utf-8?B?cy9yV1FxT3BFSDM2a0UxaGQ2bWhsYkpjMVhuSlhJeEFrRFlwSktQamNzZGd3?=
 =?utf-8?B?OGRySjh1K1liSjZvd1ZCMW5rVy9KTWl4dURjQ2FoQ0QrN3Y5TzJRMHVheXpV?=
 =?utf-8?Q?nw6Jc2Phd2cOjLax4z0zrcJg8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cbf939-26c3-49b5-3634-08db8468eec3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 12:50:42.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a38ERtaoDlPEuI/4P8r1lgJKaH7vFpIEy7XWyKlsdQpSVcjj3yQ279tve+ABbrNF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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

On Fri, Jul 14, 2023 at 05:12:35PM +0800, Michael Shavit wrote:
> On Fri, Jul 14, 2023 at 9:14 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> > @Michael,
> > Would it be possible for you to update a v5, following Jason's
> > suggestion overall? And I think we can have a smaller refactor
> > series first without set_dev_pasid, to have a common codeline
> > sooner for us to add new features, such as set_dev_pasid, the
> > use case of IDENTITY default substream, and the nesting series.
> > I will help testing with some pasid/non-pasid use cases too.
> 
> Want to make sure I fully understand these last few messages first. At
> a high level, we want:
> 1. arm_smmu_master is allowed to own a CD table, but not an
> STE-precursor (s1_cfg/s2_cfg). The s1_cfg is practically already that,
> and we can probably get there with minimal changes.

Yah

> 2. arm_smmu_master shouldn't point to the currently active CD table
> (which may or may not be the one it owns) or STE-precursor as a
> shortcut. All code should figure it out by looking at the master's
> currently attached domain (functionality could be provided by
> helper).

I think that is close.

Most likely the master should have a pointer to an STE owning
iommu_domain. If that is !NULL then the master's CD table is not used
and the STE is computed from that iommu_domain. Essentially it says
that iommu_domain owns the entire RID.

Otherwise the STE comes from the master's CD table, and this means the
master is in SSID mode.

> 3. arm_smmu_domain shouldn't pre-generate any STE-precursors. The
> STE/CD for a domain should either be computed right when it is
> written, or computed ahead of time and stored as a copy in the
> smmu-domain.

I think this is cleaner since alot of the STE/CD calculation is either
constant or copying data from other places in the domain struct, but
maybe you'll find this is wrong. At least it is not super important at
this point.

Jason
