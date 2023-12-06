Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A90807389
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442538AbjLFPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442533AbjLFPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:16:01 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C28DE;
        Wed,  6 Dec 2023 07:16:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL4B4cLcCuii71BCQVgIzQvKebCiygZMz1afOrRgHaK8vZTPKfKaUebQNJn7UFABvIpYv7/hvNcxEWX8deISoqQ7j44B+rINbYTOacFxbtexBrrVO8X+xz6VgA0KQwfHq+NBthBWFUYBxMfHnJTTSGbuXJTLiS7I6WMTxbY4Q2CPWRqwphLIb5o9OA49EdL3bfXU62yFR0DpSMcs4QdnhKVY+mVsJeRL9nVCd8BExxplck61Ilv1k0Eg9GZvF5iR2hE/9PjA36oNCD4l2Kxwy9wZmfaiU07vujhe2PHK5Hn2RfTw9IoPOovAV1atSr0PHuFhI0H9X4REmlDZwtggLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymmu/Nl2kSbmAiDjxMgWh6/urOqn4egc/Xq9+qTIhQw=;
 b=LpW6Ks1IaHbbTbjww49vZo6RAQCH1IJ3Abn67tQY86Sgbht+UfAiZmqh/XsmNX0mahnecu7V5hLU/VvQeLT2qvOBvWVU8Y37Lk+HVGdxtU1UU4V5jrfEcaOu3iBfG365XhaY1iE+fQdCyTjSEZp4BGgKmrWCrSfbdmEArIU+MYVtD+D0HFTyeLnvr5kto64LobLqjiQA+g+onr1U+UFf9N9z6pKESbtmVdMksjum62EYTIICVrs50xat/s8thkUKwAKK6S87U03V90VHzOpNucG3Id0jDsYiDjgYebom99xbLF90TqnuebqeI1R8/XsIadmXt+1GO5KofGKCSvGtRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymmu/Nl2kSbmAiDjxMgWh6/urOqn4egc/Xq9+qTIhQw=;
 b=BPVGOAx7nxgpH+ZIuiT6rI/qm29ku1Yvz0/eK5COkpDEl0SeQ018Uck6Dq3Ic8pJPa3y5ZqyVGyWrybe2uisw4F27GNGLGdhSPOEeF0Srh35uGrjTjHoCytLdeo7U6OXw2iIGYfcRUO5DfPRC7gVVZL4vdqRt2RwtbLpsZjb4JpGsGO+NiGitC6RsiYswZN0oBZnbXcPU4kfzRHR6akyPErh5GLPoQpBDL/G4HyW1mMAgrUCMmsaj3SmHoUBLdIgdGB0Lwjfyu/NV+yD83GPQuUaBka4F4p5784Aivs1EEQ4AR1vMmMXF+Jb0JruB3xpLfn9lUYY3oE7OGW2RN/RXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.25; Wed, 6 Dec 2023 15:16:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 15:16:05 +0000
Date:   Wed, 6 Dec 2023 11:16:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, ankita@nvidia.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, oliver.upton@linux.dev,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, will@kernel.org,
        ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        mochs@nvidia.com, kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231206151603.GR2692119@nvidia.com>
References: <ZW8MP2tDt4_9ROBz@arm.com>
 <20231205130517.GD2692119@nvidia.com>
 <ZW9OSe8Z9gAmM7My@arm.com>
 <20231205164318.GG2692119@nvidia.com>
 <86bkb4bn2v.wl-maz@kernel.org>
 <ZW9ezSGSDIvv5MsQ@arm.com>
 <86a5qobkt8.wl-maz@kernel.org>
 <ZW9uqu7yOtyZfmvC@arm.com>
 <868r67blwo.wl-maz@kernel.org>
 <ZXBlmt88dKmZLCU9@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXBlmt88dKmZLCU9@arm.com>
X-ClientProxiedBy: BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb5dae-6929-485a-02ac-08dbf66e4440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufFBavntYVcoKVvBxk+NvNkM7IYFEzOzgiBBqJ8PiZMJ2KZuUwS+NDBmStzjEYSML0iJnugHFuKFIKGwaIHg84pK6RCASUuNh9iseNsoFXgjLv7V0oJ2Wb2xkU+uCqug5MEd5cLkFrEoh/fR+oNQx5vJDNjmRitDcLHlK7trNpEkLWsy4H6kT6eACPf9+sEcINoSy4JsGHY85aPBDItyuJl0lwTFso7TZy3cDyYaTpIxHN2Q/06JKO+zFbdUU2eH7FFhheCP1NpzKfCmXdRnrP2a47E63wmPT2KmlxlOlmeOYt/U4CXj2gIMC27Z5dDlTAQDrN7SrfLyoIqGPymunLbRXKj7pdEFDRFZRfx2hHyGqq5qMTCseOKnJv3ATgzfenR4ZHq5VkZO1W4MrRphLSs6rNqVNdRQqhISpkrqWImyt9BaHTCIufyovK9c3Dh+b3d3ppCa08qouV3cIc2V3pNoAMWuCn1kQNRHtIBXXKCUIf+khX+ydQ4RPEbu7JVFkMMLgJfBXBr30VdkqKHFGfQPC95G0/bs+GLCaU37RGodGj6IaFu3DLzxI6ejQtAW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(1076003)(26005)(86362001)(38100700002)(33656002)(7416002)(5660300002)(6506007)(36756003)(2616005)(8936002)(8676002)(6512007)(4326008)(41300700001)(6916009)(66476007)(66556008)(316002)(54906003)(66946007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BlEFFj3aYFv7eciTqq4JHyZPjK+swFuIl530cJGn/AobrIP10psQaZU+SK7K?=
 =?us-ascii?Q?FG+f1qrUUHpxv5Ml5cYXZe/JMEO+3bLYY7UO3JeNiq+7jbpIpq9nwa3MuGSx?=
 =?us-ascii?Q?yGLiAIH8tabVa8qAJaINmAGPiNiczlmxn/sGMAzZ+nMkluf5cTGIObFq/Zop?=
 =?us-ascii?Q?Z6o2dauWFQApmT0J+j26P2s3OR1X8/t+h/nGRMLiT2bqc/MJlc3uJjA6zh2V?=
 =?us-ascii?Q?CyLM4mG9pad4ioq1StF9wCtL3pHQeRi6HD7oLmJgbQ/uBOaFS4TB28w4djBU?=
 =?us-ascii?Q?td/TR4+4+xIhJ30cWJGmL9Yyz5tb0VOtI7V9lg3dPID6MxdpttpkbnVmKm+q?=
 =?us-ascii?Q?JU2wrsMcm7W/HmvyF/Mk75BqYRCSjrqQGM5Kil7CFvmhtRJ5Fl5UupFss7iH?=
 =?us-ascii?Q?nikeq+VPWHA6Tl31n3ds5rJLiV8b/Vr46QMA7mhKW1BtAVnV5J1fMnydO9AN?=
 =?us-ascii?Q?la3SMmwyjRYyVhF3HnHz5xqba2n5iUDveki+AKeUdYLSv65WGWp9+hXR27ql?=
 =?us-ascii?Q?gYBwNx7pdJP6KyNIBHebsXvr57HpH7pxfCRGPJHMprWabOjA+obGMS7ZVQ7T?=
 =?us-ascii?Q?uOQ4P+CmMcNXPtT/KgkIYgMGPsTaar7Qy5qoa21RPkUH6vO0VmbvMg7c7lq7?=
 =?us-ascii?Q?ZeKuK3zliVJbsEmOK6lF1RLLHnjfgXWBBmgC9/2bcnEoorWtDc9OLtM1/wTS?=
 =?us-ascii?Q?85OMBKASxtPg2cLTKoz/utJRbxVB2QuXGVDk8iKbXDPr1gOLaedDXowhUr+0?=
 =?us-ascii?Q?35rK1iRejklFRxU+0QFg3dsgA3fp45O+okw0XouydIFquNzp3dWFmk9FCJPI?=
 =?us-ascii?Q?re7d4XoG2SEvW009ELEe/wfnIviTzIpLwKv+YwxIaK5ZZ6FvcK4hhxxbgeGr?=
 =?us-ascii?Q?Gy8nFx4T/cu76Dnqume2vZdcvhoEshS2Y7KK7neTq7x2i1HJJpqvBh/jj0PL?=
 =?us-ascii?Q?2kZwHau7ajHGQ/5Bt9QiuZ0EvEIAntAlrm4JhIViE7ESBdgagVIZ8l3HAM7M?=
 =?us-ascii?Q?s4oelHOO6EYeXqG11YFrG9OCSOclBYQpb7Y26Bqq5T+LE1BM2+De9wwZQj4b?=
 =?us-ascii?Q?0jit/0soDLdQEaLwFDIxcxSHwTHgrSC3Fi6sN36tF/tBQAXsv7yHh5PUcxpg?=
 =?us-ascii?Q?sIMQZ80C/myhZpmbDmJeHTNO49cMNJ5zFUm2/lY2VkcVH3X1eZM143zOkjQc?=
 =?us-ascii?Q?yv99Vay79d7JmiNVX2PRufRTuPC64FoZgYtw9LRxj1NxfuXLQXv07M964nvH?=
 =?us-ascii?Q?NY/UuCRjZ0+QUmiCweKe5BQtlqMVcUsPxpTQIG6Fr9M76e+JR2m9xiFHnWYR?=
 =?us-ascii?Q?Ms1k+ztQTlqveydAeZ1YK7mlxThEd/hdTjxnjuOMPGbLQEil638CvjOe4RWl?=
 =?us-ascii?Q?h6FN7NDErmZVfghRtKcQTjZy0HbP2g0KxEmnu0JJn9USm0pXzZUScGQsu6ZJ?=
 =?us-ascii?Q?vYWKnxwVE0dMgpM+QIBx0zz4Bt3bf9nbMr8P6DMw1C0+kVpm6QnpO7Q7icg0?=
 =?us-ascii?Q?vMvx0NbAixJl1/dmdxoHTXxn/MgfGCqVf/pxo3YfqI2wnz/SJPZkEs+kLTn7?=
 =?us-ascii?Q?kNQbBeVSnlohlJURkLzpWvsItvd5H/Xw504bd2sd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb5dae-6929-485a-02ac-08dbf66e4440
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:16:05.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnWT+fPtl4NNZefIdjD0cs3S4d72nZYB/MNa0gQRed3WE3eM2f75kN/BkdvZZy8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:14:18PM +0000, Catalin Marinas wrote:

> We could do with a pgprot_maybewritecombine() or
> pgprot_writecombinenospec() (similar to Jason's idea but without
> changing the semantics of pgprot_device()). For the user mapping on
> arm64 this would be Device (even _GRE) since it can't disable
> speculation but stage 2 would leave the decision to the guest since the
> speculative loads aren't much different from committed loads done
> wrongly.

This would be fine, as would a VMA flag. Please pick one :)

I think a VMA flag is simpler than messing with pgprot.

> If we want the VMM to drive this entirely, we could add a new mmap()
> flag like MAP_WRITECOMBINE or PROT_WRITECOMBINE. They do feel a bit

As in the other thread, we cannot unconditionally map NORMAL_NC into
the VMM.

> The latter has some benefits for DPDK but it's a lot more involved
> with

DPDK WC support will be solved with some VFIO-only change if anyone
ever cares to make it, if that is what you mean.

> having to add device-specific knowledge into the VMM. The VMM would also
> have to present the whole BAR contiguously to the guest even if there
> are different mapping attributes within the range. So a lot of MAP_FIXED
> uses. I'd rather leaving this decision with the guest than the VMM, it
> looks like more hassle to create those mappings. The VMM or the VFIO
> could only state write-combine and speculation allowed.

We talked about this already, the guest must decide, the VMM doesn't
have the information to pre-predict which pages the guest will want to
use WC on.

Jason
