Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5648E7C71C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379457AbjJLPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjJLPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:44:47 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7CAE7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQpZ3bcY65+VTSgsEoSO8iNlsy/9suBVNVRzofXE2vGQ1otWqGeHvhxa+3FY8HpOCPjFyx1vRktMGP975RVq5tVwtlIx7pqGbBiwnMJpng09Z1otVT0TzS5JX/K7SeVDDo+kyvfEXHjXomZ6eQq4Q3we6cKZHd1mtZrfVdQBX4XduYardrPel4zBKaymagsxaiDXUNdUe1yPqp9kPQRdGeRUIk+F8gSBMG6vaKST8zrdfn4LvxAuvERZ9R9mHSI4hsN1hcyImdMwfSSuuOdLOlSm2fWmTxQY2/tvUfID9UAIPexVcNcJIMfG/GJ6fxWXn0vV6n601IcyUCqH5Ci9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uei7TCZLVM2MeDTgJnK3gdxRHHtzyOOsnTbPNy2WSFM=;
 b=PAAwDGdqredSgCplhM3MqWNg0tyPiP5wFDJYDwCwHZ1XOPzzXAIaPMGOSjRlu1rRu9d48TWUZeWqFaZDf22xAEpLubReJmj+mMTnZreg+X9jECqjkd+8fQFZ5NRHtyefeFc4SJRT8UJUSsIJE0C7i6hwQMH97f1qjqNrZSz39xuo4lwOawpjoEPDLapv+cqfXSFBjDtfb9AguwjDekjWpt46F3g0M7DSr9yJpXpvkrq7ReBsLhQDtniIoSFMrzBD7aNAX9vOWTi/pKVYKoQ0zFEnG6+l/9RRXci+FIrSTJScG3WADrr0ZKbc6aR1Lx5xpzf1UfLhX2nHEz2DA1257w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uei7TCZLVM2MeDTgJnK3gdxRHHtzyOOsnTbPNy2WSFM=;
 b=E88tCk4cYerF2R/z1nZpoq3Pv7zAJU7VYPN2pg5+i1tH1DcZiqDkYqZGC6END/QCcGLlGU2xvwEBuesd0+6hqWIYQ4Rs71a4I/att4AWH0A/njNw07I76yDIUzadim7vl6qHru52zPIbitBM6x1bI/NsXdzxI7fxOcdobczmQ7gD1crZqt8S1NBkXLPm4rNWGAc05piQAMSWSCwK7/feFZWDdhAMpeS6OH8rNVbiLlXYuZP3rtrYGpQcae91HANH8SVdsUcZKcattzcXWb/KwyFV3qhqQMCPJDTxYFTCIdys1OWyJWBXiLZhbilbY8qeJQ/3FRx8rfS8+ufCdrYoIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 15:44:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 15:44:40 +0000
Date:   Thu, 12 Oct 2023 12:44:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012154439.GM3952@nvidia.com>
References: <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012144807.GA12374@willie-the-truck>
X-ClientProxiedBy: MN2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:fc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b6a8ba-45b3-4b22-e5ed-08dbcb3a25a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tROLQtbr2aqx2pGkZC8Yq/YTR6Uua1Vv28i3RP5QyYuqO26oGxzCyqYaaCEmt3Mx6KOtcDM9IDY/oj5uoMoqQfrrk2faWfR54tYGr0EVxP9v1UOHbi+AvrmsQg5Ax5qrSxXsbK+u5iZgjetm0segIB0LrVOUe26CqenDcPWdrmtRnKGF6OfA0hLQVReQH7PlLQNHLgYiABfd/TCNuD2VNSQIdgPL36xUlLmycf9WC3wSNfl1J9vYeo2TCtzOvDeNkGHKpVXnQ/SnqKRN0JQsB2e4dPESw/N0EZ+tx5onbzA5VijpR9/M6L2pyuTsRijdHLPBSB8H2/BWfYcOAZZeHXbSxuAyOg6PLQEH0kfsvBwYXKWu6CyyJZAPeUvXlvXc7JjP+h1bHUAem5cz61VBW9DplEnObLAy6vHmzc0tt1iqAMmNiol118WnHWN9g9eFKGU47xcyFUZQ41XJSLiZYH7e1cRn33DQd9WcQW54yTVuzeS0HZE0EKDFqvI92Qu2HI6uTlxBWyf8lM3gzhIQ4jCOAGo5lekVMyl3gog4ORVOaM3KumZXdj3IYk5VBBj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(4326008)(8936002)(41300700001)(36756003)(8676002)(38100700002)(5660300002)(6512007)(33656002)(2906002)(6486002)(26005)(2616005)(478600001)(83380400001)(6506007)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBO4Y3HF4VQ/+B6d0CcrjisNxyQa+IIbHHgOx2gAQKoULJHr3gnH8hfLjWt/?=
 =?us-ascii?Q?nr3Inh3ugzAOxS3FDZlkZrihIXeNIsDJ1fv+c+kP86zj+RaXH0z0JchjxmOp?=
 =?us-ascii?Q?ZeFLazcsNEaZaCS1LwxwB3FmyjOjYjI00jboVKma0GltfomMYnvHg6mvkYhk?=
 =?us-ascii?Q?O59LHtJC1u8zq9WLVGZhLs8oiEHimvf/6Au72tqDv2DyrornEWutWrHPmi5P?=
 =?us-ascii?Q?4zjdolwTMnZllbQsItTzJf4cBIYm4LIxHdxMmMIqOP5WxcSjFcHidmfkcwEz?=
 =?us-ascii?Q?WM0jZjRXGBrlLieYu3/6hFvXanhsLLabr2BsW8X7c1mUrC01/JpnaAl2PHsW?=
 =?us-ascii?Q?eyEU+uHFeb6wxHKZPIdPI51Yye9h98eeygl4TRLjgWSZ1ekuqWKE/y+a/ZII?=
 =?us-ascii?Q?d+odcCIUT8etoVTsVPlJb3SKoPAJISfThhAOGc/e2hHcLZBSJy0qi1U+JBYI?=
 =?us-ascii?Q?lcXmlewNb9PoI6wut+SrFoX91SjR82U5wslkSsQsZHlBTcOdAfKz6P12fJdw?=
 =?us-ascii?Q?UuiwptAldsGOJQUiw8ihndz6jEOI72thGtGU8lmRyn+b/kM49QCbYHy3ehZ/?=
 =?us-ascii?Q?8xMaSXUDvsu4w0mvWe5M5XD9TsdSSRPDbYbonCBmL4EVi/ZEOF1VEY1r35pN?=
 =?us-ascii?Q?5OKlDFIuixJSN+Wm2Xx7i5SuTg4RiyJ7n+AV2Qf5+XCDBbqNNJK8ceHEttqJ?=
 =?us-ascii?Q?NaqY/n0JnJWIfth1qsaAWJpBpG7IrGmj59C5lvCGGr4eh0ssE6EWeX8LCGgh?=
 =?us-ascii?Q?fS7CUa3Lu3Yfk8ERpong+ZxiY3Xr/QFWt+6vfsNrbXvxiePoXDusrADIxY28?=
 =?us-ascii?Q?SQSM53pkvmlInstvFplIp2gnX/0cW033vCrsESipPgKu9kwu2DM0SxQPtKJz?=
 =?us-ascii?Q?s9wo3F1C5cOvfB8LFY/rOcYUAw7FY+r8e7U0nPrLg97T14iTylF9evVrDbTy?=
 =?us-ascii?Q?2phGfP/gIJ2iVooqX6pOujFfYnARgQp9SZTAPl8S26GH47Xmlou7ripqmw6N?=
 =?us-ascii?Q?jSwn7s1gM6qG1uXedpoI1D57xTJikLJSVLYViZh80apeyIKn1uHKon1wFCJj?=
 =?us-ascii?Q?QnYm9l+YKTyNHRHKUAm/IO5dX5CUc1Kkwk1GBFKY+z+9J92KqKThnCej1jFL?=
 =?us-ascii?Q?Bp5r9dwEjzqbCNf2aIyzoV9+KfFK+UuDG5SL056iFlchAFGHMTdXtNoYdr9Z?=
 =?us-ascii?Q?cmcBxDvdYvSWRofFNTK/8z2aSAjKvFRDOfguFGx0DqnXLlgoZRnwTVM4PWBz?=
 =?us-ascii?Q?wZ2HVVxt0q5RowFoxF3pM2JAoRXS/f0Q8akh+5GYLNliOE5M3GhrzNWAzDyS?=
 =?us-ascii?Q?HR4a6G/xPtfSURHLyiT2W5VQQSXGLHq4Ogg5iuphrbKWFFUuYrlcy8mgZw6K?=
 =?us-ascii?Q?Nh0EfeoWO/fsgNWs5W1gALNWym0S11Ycthcl1eaebe2aQ0vAVK44Ek1GxUj8?=
 =?us-ascii?Q?1aLys2el5t0dGMa/ZS4LaE6Ieg4Oci7jHUUAz2bGvv42X8fh8cxPJDgsQ5aw?=
 =?us-ascii?Q?huRO7UBjieSvzgjwsfd3IZ//BDPndZZywboNuKzppqQ8rvzL8ZJ3mwoxWRGa?=
 =?us-ascii?Q?F6vPdiV8de8w8aljqtVBbSaZJtNTQRYSgJAwo75Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b6a8ba-45b3-4b22-e5ed-08dbcb3a25a5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:44:40.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXRr415bNy4O0USnq63oii2zKkOsjYnxQqgYzjYNxmBYLLzGUxZmzITF311Q36Fl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:

> I guess my wider point is that I'm not convinced that non-cacheable is
> actually much better and I think we're going way off the deep end looking
> at what particular implementations do and trying to justify to ourselves
> that non-cacheable is safe, even though it's still a normal memory type
> at the end of the day.

When we went over this with ARM it became fairly clear there wasn't an
official statement that Device-* is safe from uncontained
failures. For instance, looking at the actual IP, our architects
pointed out that ARM IP already provides ways for Device-* to trigger
uncontained failures today.

We then mutually concluded that KVM safe implementations must already
be preventing uncontained failures for Device-* at the system level
and that same prevention will carry over to NormalNC as well.

IMHO, this seems to be a gap where ARM has not fully defined when
uncontained failures are allowed and left that as an implementation
choice.

In other words, KVM safety around uncontained failure is not a
property that can be reasoned about from the ARM architecture alone.

> The current wording talks about use-cases (I get this) and error containment
> (it's a property of the system) but doesn't talk at all about why Normal-NC
> is the right result.

Given that Device-* and NormalNC are equally implementation defined
with regards to uncontained failures, NormalNC allows more VM
functionality.

Further, we have a broad agreement that this use case is important,
and that NormalNC is the correct way to adress it.

I think you are right to ask for more formality from ARM team but also
we shouldn't hold up fixing real functional bugs in real shipping
server ARM products.

Jason
