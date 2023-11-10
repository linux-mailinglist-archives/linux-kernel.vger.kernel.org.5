Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676177E81D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbjKJSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbjKJSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:34:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025338E9E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAMSOqV9pP2EdHc7T7GjGKdDPl9UTnKD56K51eY2VgfuwTY8M4W6s0O5t95LtsJC996e1afOJylTVfojMeRVNElnJXvde8uAp4R9owbXTcyvI59SA+Y4S2Z5pmzjIht4V4Z3VGmf4yk/WzHvANpUSBwWU39HIdyJEQADvsR/KSK8BbjPjx3GpTNpINPnxlWYHhLew+EPwu3AXOL+gkmiNmnULz7lRHPQiYiR+SKr4Vfesmj9VTO1qRh1pG0CSa6EEvuBC916xVN5czIfCsrzAsK5hiou1ATBzKnD+HsQp9aSO11z0Za0446XLlTxG0ENG1LipzbBG0Bh19mmeM78YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgGCqMqul7q4lQCVRMNd8p0coaOrLfdPgFD69v6hjU4=;
 b=oLOe8TDa1B/GT8xEzPJ3POH9jg05Kdz9LJlpa069anOZmXketMktmgftUoIlH3SBkFMuAtNLj4j3jQImDxqxlMrb1dOp5sEkt2MZYNqYv2TH7T0Mcw3ZIhQOYy6n0Aca7SxEjYLfXrMWkz8SqegN+S9c0naqlsdIYrKgees5+c/nJU/tzQGYX573kUBuSzgFODBpZJjlDY2EGTucHG4scsEzCt3alX7+Wu8Egp78vuLNELLsL61GfsLhTFvga8/ezNLTYnGCQdOjSMhXwmGgVRwigidjfJ7UIivTWQD5u3RW8KaFAFnO9I9vcg8v8GCCmq8gOBhleE6tvE8dekNj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgGCqMqul7q4lQCVRMNd8p0coaOrLfdPgFD69v6hjU4=;
 b=FOnD76HWlbDiDKDbKBnHnaKaFLx1hsYPSCrtemAJow3WbIFMKH1fWsx5GTiPUPOk+2LXlVqhuuzZZQNgALCA5VBrIGjGitmd7Lk8jPr9Ztu4ZwqLqRhiWrIiGxeBMq/vTPs2J9dZTpfk5V/iHccDkA807XgcYXYEzelPy5Ca/YOMAwCWbx/lDc+U+prGRa/oE0uicXi0c4wKxmDDShRbjsCcKOKmtsw+LFOpIM/ROeDLSp32OzuNQ0l6/H+oja5/Sbw/9Qfg4RfmpaMRumiybRAR8lqbxLsTxXfgFugPUblu2OlLBtumWsGLz6X1mfEQIuF50+pKN2NkzZtnOyhjZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 14:26:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 14:26:51 +0000
Date:   Fri, 10 Nov 2023 10:26:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231110142649.GO4488@nvidia.com>
References: <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <ZUz78gFPgMupew+m@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz78gFPgMupew+m@lpieralisi>
X-ClientProxiedBy: SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 402569de-826b-4b4a-4bcf-08dbe1f9146b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eq/1aGeSrgZKTp6Azl1ZYAloBXkHAT+Myj4z2273BGM+DC6PYoXriyl9uuLIbrD1bRdDO8nV7J142mosIaPEXr/YkExAr5fqJuikX7czCjaVQu7WpW6H1jo9soY2Psx5krLdWEW0VXG93mfr9NnU41X8N/5Pun6e9Bpl68v3ALNaN8nzsBeEzjVbBV2Yyh6OPmt6iGqo3/a4XUngn9cOdKSMoITQKHe8UNvBTmUjIAL862MUIGeUcc84e5SRwxIE0LmyOKJJw7jJ7WxV8pBtu0XEhd78H7ScZr972cAknQl0cl2QE69HZN/bwRC/vQNrGrEv04lxcJPO7A68g3XH2eVEpOmfZnzwrd7Genk2xBGVi3LnLIwErgo2ciC58vFrJvNbbxch3sBW5bdyB1yMi8Zvf78/z8+OKs0ZeFse2TLZ+KkgPO6R8E7njv2SMNv3hsFgFWYxjbW22shiJvBdFPX6wFBCVYVasbs5mc2FFJFP8IuSPQd0s9A6/vpzvx0BWVaf2u8OXJaavcL34FkH2pMLKoFKWvk9Djm9vNyQ32ceYSwCIaddw3eEG5ayUkIX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(83380400001)(38100700002)(66946007)(6916009)(6506007)(2616005)(66556008)(66476007)(26005)(6512007)(54906003)(1076003)(478600001)(5660300002)(8676002)(36756003)(86362001)(8936002)(2906002)(33656002)(41300700001)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6izuEmhaG05QhXrhrNKyP3xgM27WjQ8PzmqjvX28Dm7oxPuThB+Cp0fZCBK?=
 =?us-ascii?Q?Lu+lD1CJr6/WKGvTODgMG17GcUmJ1ALFi7mepchcGa4h6wT/hjbq2txEZrvO?=
 =?us-ascii?Q?Xxp24O0QzeziCo82VidYiAZuSvRw6whimeL91Du6VAie79yY+lcYmYhewgPG?=
 =?us-ascii?Q?Qh/j2qHm+iJ+OYbHOjCNrfTqAYwQhmCORE1Fmb2tsZ9zY9JpNb2DNlsip+5T?=
 =?us-ascii?Q?NPQxHzNZQ01NzVvLsqgb7AewY9pFV0XPrqGzv+w1g97iwbrEJDjMCPJraVhX?=
 =?us-ascii?Q?iyIqj4rrhmWpl9HeVq89gbrqY9KtLMOXJdNfxRF8YXvrMhVbfaY1i1IlB7kV?=
 =?us-ascii?Q?Q+mda21UX3WWM3lnk3syXVjBwJ4fHTFkPcdnFjlAomQFszHzF3YhXDWjYciP?=
 =?us-ascii?Q?pH3sm7aU8+0Yn/UNAY458g6St7JHgFN/Vps1DH6yDvzZVbPPViLhxcIynwWq?=
 =?us-ascii?Q?bCGGKo3e5HBRMHhnWUIq2luTQxJxb6cgKZz/qUqa//zaLNxE/moebBlapV7s?=
 =?us-ascii?Q?uxtXFNM5KZYcS12Ud+0KN3seN6weJrbnKPNlOn2qXl+H0IBfjn71lnogPVD8?=
 =?us-ascii?Q?9fpjtvlkqkPUouFqkvK6HgRGCo+NkAnlcyqCRv5N7jQoBOtvnsD9aLA767t4?=
 =?us-ascii?Q?RliJCXr1MCVKjQCEYd+y4YCtqxR/fpxz4QbG4iQKVPLXu4GIY7wEm71Sjkn8?=
 =?us-ascii?Q?sz2E5NaUx8maTRjvIkoLFmIStPLIjAtJocidnDvwrUM7tRUnQkL3nWwQUz9x?=
 =?us-ascii?Q?R1CvvziMbzN1nuqjs+YsCzzUStdNOrGR93Zxx+9UdBf9Ux2Mc3QJUv1v5Bvu?=
 =?us-ascii?Q?OjIcTxrYYVPAV4ocykaWbagtzU6f1hVeijcG+dQdKtKjNZ//AcDcPX+DlIp9?=
 =?us-ascii?Q?yqNZVRCqfUqYnJOxGC3u6R1EzzkDyweQ1cuptAlXH/1YGDvk6eYGNUS7t5mw?=
 =?us-ascii?Q?ojHamikZvqrLZLVqV0twNfi/p0t2SWAKxIkBb0Y4mUBEHaVxUAPrJIOFqpCD?=
 =?us-ascii?Q?LCLrVNjx9XAHmKID2Wnbbuy0hyqgrXFGg3wlCI0UmxxoFeztGNtx98K2oYDF?=
 =?us-ascii?Q?cfoAnfYiHBOQ73CX7n0qJRYUqofCyVpzjvdcWq+jzR+mM7yvxg+Zo5YZmqnc?=
 =?us-ascii?Q?yGJp1o9Y0AMO1069KOS81bl3JB7AkMSA6P1cRfVL2QZmnwk/kygsADszVykp?=
 =?us-ascii?Q?74cZ85PJ5HIGg8y/NEpryQcjr2grlmDsUC9p4Uw2n+SourDd05rorUQMieQw?=
 =?us-ascii?Q?XMIW+SqD60HmIzfofDoZugn3G0NmaTu9/DSatxzTCsiPjp5c25NvgGEyGjcN?=
 =?us-ascii?Q?gBB9VBv+AacB9hfi737lv/Py3c+knnkf6x6js3OLj/kZWEW3SPtGkvMYHsY3?=
 =?us-ascii?Q?BR38nYXuqLw/MoNT1nz/aQKBk8hrDxRZmZ5eYmRY0HPeP8+Sl3AYL8pDocD7?=
 =?us-ascii?Q?9b2wNdSpfEHObUsp4L9f7oHi+LMlR6QZVLZgsgZhuUcWWG9Rh4RhTBMdMDuH?=
 =?us-ascii?Q?Om31E90ppQ2Z4WPbf7WxD2O21G1Zs5yuY0eQ1ws+HO8wW/KIW+RI9797rwc3?=
 =?us-ascii?Q?CsmEM6XdFtUUqrzyH/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402569de-826b-4b4a-4bcf-08dbe1f9146b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:26:51.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cr0FCYoTM0h6b36qLYXgJN8thjO/yKvMSfwy3d/Ric8ysfShF72tgI/dHPa/064s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:34:10PM +0100, Lorenzo Pieralisi wrote:

> Relaxing S2 KVM device MMIO mappings to Normal-NC is not expected to
> trigger any issue on guest device reclaim use cases either (ie device
> MMIO unmap followed by a device reset) at least for PCIe devices, in that
> in PCIe a device reset is architected and carried out through PCI config
> space transactions that are naturally ordered wrt MMIO transactions
> according to the PCI ordering rules.

This is not how I see that thread concluding..

The device reclaim problem belongs solely to VFIO, not KVM. VFIO must
ensure global ordering of access before the VMA is unmaped and access
after, that includes ordering whatever mechanism the VFIO driver uses
for reset.

If there are quirky SOCs, or non-PCI devices that need something
stronger than the TLBI/etc sequence it should be fixed in VFIO (or
maybe even the arch code), not by blocking NORMAL_NC in the KVM. Such
a quirky SOC would broadly have security issues beyond KVM.

> It is worth noting that currently, to map devices MMIO space to user
> space in a device pass-through use case the VFIO framework applies memory
> attributes derived from pgprot_noncached() settings applied to VMAs, which

Sometimes. VFIO uses a mix of pgprot_noncached and pgprot_device. AFAIK
we should change to to always use pgprot_device..

Thanks,
Jason
