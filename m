Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E975251C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGMO3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGMO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:29:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC042681
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6dctKFrCaCwpZ1IVVAxn9Y38Qih+/axOvf76kU2RXeHfS2V+hiXnER4AXy58Ob9E1NZwBvB8Sq7ovpbN+i5iJgr1eU8n2GIMDDC3qfn8+HiOnRFecO6Fe4vSfsYfONKRZPR0b2dg7WkIvD7vm+DfGEI+axFrTHdvIBp7LuFAhjqoITs1uJ53/Q/emj9YD+xzvE/yvApJR710Chnh8wcVuTePb57yIEKQ4MeZmRyfi/z6ukhT/dYo37gEmaMtXvsqB9/osW8TALG29fwlEtFdNwUxZFZbCcT+MYAHbNl+CL1X3Ud3xE4zU/8MSi7HZDd03LuNUgAZjHGA9XOoEkijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SItqkXxEjSZn+kgtOEpKL+b2zkCNGjneJPnW7o//9XI=;
 b=Wqam2qrmMtgFQpZdA8j5ijrccXSHdyDPeXwyTzkBqPgJCLocAoGETP15ntHrWahqGJBhVBoq2cMIYwxe1cR+BruZhF1ytq17dZUYv6sA8Gw5Eiqo5G6ocYfu6XjnN7sHAaWlIUYd02Gd4k6FXurMtPdtwg4hI1/oINM3/5MqIfl039mlGQBL2G1XvHGZQUDMMNzxLdWM0P/feEeY3IcF/gAr2Rke5pwmiAlFhXlz5Du+37unrnZTO899tT2rK3+gKfWjuKTsciF5CiY4peTHS5AziKemWCVxztWZ7rhRIP5c/w0c34ensFlKQPVRRRx7DYxS1WPhpcri5dvGsVuxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SItqkXxEjSZn+kgtOEpKL+b2zkCNGjneJPnW7o//9XI=;
 b=crkkyI7foVyXKr5ODPUOZKtx4j+/Bi2gJyGhpoHuGCUgFyoVefSgW2PslIFK8X6wCPV/2DVjRnNPWeW0zMiFh2Uhb0sVsnDxDDgO3r2UaHakDMdmO2QOhy6NB4OeB0QZL/cVaObqx4z7aP6klV2Cnyjw+c/tgQUU7y71qTQH9Rv8XJH+kXTD+xwTxIW39hKnq/1CvTbXePKTz+K77XMJrPniqIVGQJFfr+BvTEAeID9mugluWCx6MGAG1F2Brj+immKG9sUUAoicDjcfJilu4LOIyCICI/BhU7Gi2JVi2rW+Xu1b51L5MRNmgmLsXsboh3e3l3NJ5NAthXT05BBYVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 14:29:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 14:29:26 +0000
Date:   Thu, 13 Jul 2023 11:29:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLAKQw+DzcpSRSyi@nvidia.com>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c95036c-211e-4629-a51f-08db83ad8f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oW1KsiU8koHJuON+qyYKih492MOqF7hr8cIcEEfpOyaY6WHjCo/mzggQ1m/0UgGpk5APCtAYQiLd4UZQvvatt3qPq2QIaKGBKvYkOFLX758JxiS5QANr1Ypy+hoehERDxsz4m8IkrnTHy6d7I8eUGzJMDJtSfMK/mX2Vsw30U+Rnp+UyXcJZXZfalRbwHixXz5ir5sz1yh4R+oX7uxM0/dLY0a3w1/LkcECS7rCiPnq+nuGE3+x6A18B9zOLJZn8jV9ELDsx29cWeu2UYtAO3hDYz5BYD2k/Z+3H1+LgxjTdgf3mWMvkK/oYgeU3GJbsm9FQ4+HMZvGntiH3Mn34t6jK494kXX7I/sgiH4lnc2pW7Wpz6pwhQu90S8RizOh8e/+9lC3dI4+KUrum5/Fuo7ejknLEXik6QQ+0+n9dl8GKfSe0O1yV42Uv/yKOaCUPUgbiFMtLZ9iVS36FzBlv0p63lx1fw6qHvjDKnCWnQyzd513Ti7EgibM53BXsD4f9n0i9EJBlwzDQKhNaRJfAdjn+P2+CpxqDMQTXajXPUdWR6c8RJDWMfD18taLobqITPqkEORZLx+FlepYanJ1LYuFP9fiPrgdHCBobnkw03Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(83380400001)(186003)(26005)(6512007)(6506007)(2616005)(53546011)(478600001)(41300700001)(6916009)(316002)(66556008)(5660300002)(2906002)(4326008)(8676002)(66476007)(8936002)(66946007)(54906003)(6666004)(36756003)(6486002)(38100700002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhva0UrQ0RaejFQSEFsTEFOcHlzRk84MTA4V1VDREVseGJOekFqKzBOUktY?=
 =?utf-8?B?WWw1WnlrSkdkNVlhL1F4Q3c0bmE3QURNc0k4NjZyeWk2RTUxbFdNd21WYTF5?=
 =?utf-8?B?QXlYeEdyQm5zaHY4NGhsakNsWDBHRkpBMmlqNVV1bFJZNnZnekNaUjdPUW9u?=
 =?utf-8?B?L1pIbkVVaFZvYnF0ZVRMOS9zWTRSblF1VTNlOXVaNXpNaUdYV3JQeUxobEhZ?=
 =?utf-8?B?S21DUUpIcE1oSjhmWllLdjlwSlJVMVgwbmhuTDVqYS9LQ2U3VEdRUGZYTGl4?=
 =?utf-8?B?UzdMSzBzQ0F6VElwMWRYUWJIQ0ZHelY2dGprUXkrU2ZYaGo1QVNHUnBVamJr?=
 =?utf-8?B?cXhiVytDcFFmRG45dUYvNUJvTUh2c1grcGxKbzV4aW4zVzFWREFPUER1TEgw?=
 =?utf-8?B?UW1LaFczZWtQOWZhczdPbmU4MlNRVnhyakk4cW9ETEdYRXhFQUVGcFdjZ0Ey?=
 =?utf-8?B?R1NNL3ZrUVo3VXQxNkVtQWtnSUVWeENtWEZMVTBNcVAyK0ZGZ2FTb2dFYkNR?=
 =?utf-8?B?dmJTaXF1MnJBd29ZZnlhenBiek81Rm0wNytSYnVjSDN0d3pxR2NBTXJtYThI?=
 =?utf-8?B?ZnFHdkhOZHFrcVQ5S3ZDcTJLODZYVnVTVnlVL0F0RUpBK2tLY0ZKaFJiNDFx?=
 =?utf-8?B?ZWo0RkNiUzl3R1ZYSGNSeUhJTVhpVStJVWhKdHB5eFNTeTkzQjNDR0wwWjJE?=
 =?utf-8?B?dHRqdDRLWlFZTUoxOGw4ZW1IcVFBcENTNXVRVUZvTDkybGE4d0RLQWRzVGZU?=
 =?utf-8?B?WUtXanU4ZGM4ZGZxb2tiYnM0TWRuQ1ZtQUlxQnFmYmJac0h4QWRYWmsveTNT?=
 =?utf-8?B?YkVTMUJ3ZlYzNC9pc0I2dTZsOW9RNzBCWWx1dDFjclk2ZlFqQXZVeUNzTjB3?=
 =?utf-8?B?dVFsQ1hoMGlzTG9JN05Dbkxyb3RvK2FvTWlhTUxEZUtmc3N1SFBoMnhCTUhG?=
 =?utf-8?B?azlOVGh3YitYY3NJZDJGSGxXdFRhSmhyZmVFakNZajBBajVVNXZuYm1jbzRa?=
 =?utf-8?B?ZVJpM1Z5dkphaSsrWWE1YTV1SzZ4dis3VjJuWmE3L0tIZHlvYU9UZEF6dm9n?=
 =?utf-8?B?UjBIb0M0ZmIxUHdQTThrc0VGL3FvMmlPVDZnMGFwMlVvZzBBSUVydmxrUG5h?=
 =?utf-8?B?QW9KZlZYNkNoRnlqdVhKYVk2azA0YUx3WWdMcTgzTVZPQUZSNUpDL0wwMEVQ?=
 =?utf-8?B?MzRWRWtQcGh1NnFmTDg3aW9hbG40dmlPMlNjeVpoMjFIWS91d1QzYWFjV1Nz?=
 =?utf-8?B?TjJsYTNLZTB3YTVlSUowQjFzSjVVWG0yT2xjQWhQWDc3T1VWNEJLd1A4RW9h?=
 =?utf-8?B?TC9teU5aQmd2SjB0NGJKRUJIb1Y0a1VYdWF0Z0o5SXllZ1BvWUwvRjVNb1FC?=
 =?utf-8?B?ZTdiUUQ4djlkRTFNWUNkUXpRdnJnVkxUVjN0dGloOTAxSUlEYVhjTXlwTSt4?=
 =?utf-8?B?Qk12V3dzUWxiM1cyV3liY2VLTFc0TUlvSVplZ29TajV2ZTE4R09zdnJrTjUy?=
 =?utf-8?B?QUs2SEk2NS9WQzJtTnR2NFRkT1FqdzFvcDlkV05rbGJ3ZElvMVc3VFkvNlND?=
 =?utf-8?B?NzBSNWV0OXRQVUJzck4yNkl4SWhMYmllUjJ4NnYzaWhvTCtPV2EwVFRaek5Z?=
 =?utf-8?B?aW1zclFhNkZKOWpVVmNIWE02aHlWR2REYUZQeHFmczZTWkYxWFhUZHc1Yi85?=
 =?utf-8?B?QllzYzgvVVhQWUxwV0lnSDQwSHh2NmsyQ203eEY1L1NKeGNvNE9USWtRRHVw?=
 =?utf-8?B?VHMxbTRGNDE1aDZXK0FRMWlJYmw1aXpVeFZQZVFNdTBDekVWZW4ydGI2d0lZ?=
 =?utf-8?B?OWVxN2lsSzZJTk1NTjFFUTdqWEhPeFR0WnJwOGt6bUVOYzVydjQ3blhtL2Vi?=
 =?utf-8?B?MlhsTHRvOEgxWTRuVitiRWVKSHhyM1JZT2U0ZXNQTlFyNGlZUndSeElCQUhE?=
 =?utf-8?B?VVZsWGxQb3pQUUJIVGMyeFZ5eFZpNjlJMDdxZzBpNDFad0NZZG9xOGg0MENj?=
 =?utf-8?B?RXpkeU9Lck5mT0tXS1BhZDJvbTBaeEg4WXlxK0N6S1VDWi9Ubk1ISm5ETktz?=
 =?utf-8?B?MXpkVFFWWXY4UlQycVJOVzJ3MXVoTzVvUjRoZjlqaVphUml0aHJzVGZGN1dS?=
 =?utf-8?Q?W1DwLx+BAr12uciDd9hzEf/R6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c95036c-211e-4629-a51f-08db83ad8f6f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:29:26.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEfsXASb3XksW9GVJV1OW2Ypkv85Gq9/n+lk47GuYjghsqN5yY4l16U0wy5RMVFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:34:56PM +0800, Michael Shavit wrote:
> On Thu, Jul 13, 2023 at 9:22 AM Nicolin Chen <nicolinc@nvidia.com> wrote:
> >
> > > Except for Nested domains, arm_smmu_master will own the STEs that are
> > > inserted into the arm_smmu_device's STE table.
> >
> > I think that the master still owns an STE when attached to a
> > nested domain. Though an IOMMU_DOMAIN_NESTED iommu_domain is
> > an opaque object to the STE in the guest, the host still has
> > a real STE for the nested configuration somewhere -- and it's
> > likely still to be owned by the master that's attached to the
> > opaque NESTED iommu_domain in the host kernel.
> 
> > I am a bit confused by this naming. If only master would own
> > an s1_cfg, perhaps we can just make it "s1_cfg" and drop the
> > s1_cfg pointer in the next patch.
> 
> Could be that the naming is causing some confusion. This owned_s1_cfg
> is very different from the s1_cfg set-up by Nested domains in your
> patch series. It's better to think of it as the default s1_cfg used
> for DMA/SVA/UNMANAGED domains. Because stage 1 domains represent a
> single page table, it doesn't make sense for them to own an entire CD
> table. In contrast, nested domains map an entire CD table and it
> therefore makes sense for them to own the s1_cfg representing that
> table.
> Would renaming this as default_s1_cfg make more sense?

It would make alot more sense if the STE value used by an unmanaged S1
domain was located in/near the unmanaged domain or called 'unmanaged
S1 STE' or something if it really has to be in the master. Why does
this even need to be stored, can't we compute it?

Notice that we have unmanaged domains that use a CD and SVA domains
typically would be on a CD, so it is a bit weird already.

I'd think the basic mental model should be to extract the STE from the
thing you intend to install. Either the default CD table, or from the
iommu_domain. ie some 'get STE from iommu_domain' function?

There shouldn't be a concept of a "default" or "owned" STE value..

Jason
