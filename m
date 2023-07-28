Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10606766D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjG1M0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjG1M02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:26:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72764C05
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/xbTyY3+tXYPn4DzAz9tPK5f63YP6pbEPdr+JHj4MeA0VSKpbyZ1eQMYnkHKvKNJZpaMAXEkd0T57kdoA7h5MM7WE1NOKijYmRo231ZYUqKwBVd+D5hORZpYhn+AP3WNtcZRfM9rZSVO2t385uOXGKaP8LYc5KUblNxGWEav0CbcnLmUPPPcWzzztoBIG+tQKEDXxwnXR4vZeiNj5ygObL4J3SBoJSNCvZ1bEd85Q3It70qB7ZVyXupWN3tbjW5o31/DoFOm27bNV/vfxQ70szVPvXFe+m4QO8OSMdZrx2iirJQcP7yjio6zbmwAYSe2S6OOPXo11tFc9UTgN7lZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3hX1qY/mNHv4jZKFEnmiUWDv7pdk/lvmd3TqI2EMLY=;
 b=g+Rk2Jkt6BcHsiLXNgniQj/VcNs4u94v6G9NPSXx33HkBS9NXJj36gN3cSH+w6ZDTbmh/ezYshAR5iaLrU6pF19HXM460K07iQL1OxRAEqlnQase+NaELTsw+9dAwXYh/RJ5KZxHuaxXz9jVcZxaDSdp31N0DzgKQaZH4mNWIRTWaannAYy5YopX8zeujYNJJo8vAoTjInsQon5Qx4JUrKwZxfHRQ0yLuPiRTaZ+BU3dCAllNb0+TKsWVmIblYhJGaonHgWczCpgM78nQ2Q0i4BmkRLJlM2V2i3DhoP3qJQTbVLRcwKSIeRRe87t7x1odPLqQGZCY9c8bL6Gl/ffiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3hX1qY/mNHv4jZKFEnmiUWDv7pdk/lvmd3TqI2EMLY=;
 b=q4RpFB9zfiyGzFD23XCz0EVFoTbMgxS5Bn6WL/Ponq+OJH0naICdTRSWuGMhlP55t4CAqXP58aRvjChrmD2D4hVtfCm72Hdx4HKxUCCOYQBmJuIzXdDuf8AvLGmF1JjJilVahBrqnL77oSAmLggzHX4iI0c1QceO2ZAG0t1XJY1Dl8KLXoLRc+EB1HHRaOKYHfEhrhJNYF7b7ht0yX2JcfqPbS3ED0GoAdz+4QF7piJznHCaY3xnjgYO7H5QwwnkRRDwh4HzTuWXorYiK5VrT9BQuNeto5fFpF+8DyPU7OHvatRT2rp+iIN/OG+HihPwnrsVen2N1JZ7bauC/IOKAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:25:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 12:25:25 +0000
Date:   Fri, 28 Jul 2023 09:25:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/7] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZMOzs1/xoEPX2+vA@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-8-mshavit@google.com>
 <ZMK60wm3BBk038r7@nvidia.com>
 <CAKHBV24QkjnLKXp1Hewo1nTJnBTPdJWxiSfiXdNPZG=zqQWFqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24QkjnLKXp1Hewo1nTJnBTPdJWxiSfiXdNPZG=zqQWFqQ@mail.gmail.com>
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b2c97f-50c5-4dd9-6f8d-08db8f65b8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7svXxgo/Bx4Dm47SsAL0/9/9YQlgkyh3ptQ3DjPXFKgBfPl1V6bhIkUgyMDcgAzfcPuXq9ej5VJ4qKCff7txuQzj8PcjCNkvkJd8ANV2sVBDWBOcvcPMCiqzCNUH/H5vIzqJPicbguU3PL2Qc9CICPNXjnWQoW2K5vpBDxnxeHQidv97/p1V1kUH+CH4yr1U8TUDqRskpzjBdWw74r9Jh9s96DJ4CLSS+alaew+DJLifip4n8INDfv13K1YaxAaTAOW1Nx2y+FLQtDECnpgR0dk3DQT7XaZQQV5KcsJzJ6Ts4Ud+syf2tP8ZBUt10y26gB8bGjQZBMZC/rQNDajBjcQsXDf1NpyuqhT9qcWnp5zOkwlaX6bVIke/iRrQcCnKTTRP0ZQXy7jUL1ksPHyeIwZbJNedmgo09y1GIS8anH6XEbvlKp4RTORuI+itdImAwDy1+SE3Ld+7iSoEWMMNC5OeNTK3MS8THjcLg/Om8xjeQImkl65R0sNUJV4sMHsWdAcAbu7ENVAA9ABsUyiKHlZLb+KdJ7jws14W2rgkOzb39uv8wnw3trP078yyFln
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(316002)(8676002)(41300700001)(66476007)(8936002)(6506007)(26005)(53546011)(66946007)(54906003)(6916009)(4326008)(478600001)(6512007)(66556008)(6486002)(38100700002)(36756003)(4744005)(2616005)(2906002)(86362001)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG45YnVwZG5ZdVd4SlViOUE5OEp2dWVvWXc2bFkvMkV2bzFPdG9YRThuc29Y?=
 =?utf-8?B?NHhvdmRDNzN0OGt5UXdVNzdGVFZtMUpOeWFOdEdhWEZRb0phR1J0YWR3c2lY?=
 =?utf-8?B?eWNQcE1GQ3RmUy9udkJVc1JMaWFkMkNnSDFiVndjb3FNYm5lRENDNUxGWVQ2?=
 =?utf-8?B?U2duaW1xVVRzYnF0amY1bUUvc2NBZkVpZ0JDcy9Vb3hVemR3aGlaRTBTRnNI?=
 =?utf-8?B?Qm1xbm16SEtXbFRDUVEreHFxOWl4REJ3SkdKcmVMZmhWOTAycytkcmRuZVV6?=
 =?utf-8?B?NTROSWo1dUc5UFRqWXFFc3lVYXg2SmU3MzVWN2szTEN1Ty9nL0w3bHgrOU81?=
 =?utf-8?B?eWMrdHppRkNISlZWVW93U1Y3cndoUUNiQVZ5TjlEbjVja2FtQmFZWEFKaFVE?=
 =?utf-8?B?RFA5Mnd1SmRYME9RWlpSS2psQXhoTzU3ckNvZE5DZ2FFMG9nWEZzcjM1d25h?=
 =?utf-8?B?dnNWNW1nbkxSMVBmdWRkdldvcTBxb08ya3JtVUZjaUN6UXhGMmNZd1RHNEpZ?=
 =?utf-8?B?c2tBUnllemdxNHp0eG5kN3kxK1hZYi9uSkwwaVJscm00ZHpkZDFkdWZmKzVl?=
 =?utf-8?B?QnAyTmpzN2dobThZSlR4SnpnR3JZSXIwUkhUU2I4Rk1zNjlPSWJ3YUVIeTRz?=
 =?utf-8?B?bDgyMUM5QnZkcWZBeWtqc3JUR05HcTlHdzJzZzRDdFFBb3M3clM2L0VERWdO?=
 =?utf-8?B?WXFZelhYSmJxZittNyt6SU5XZmN4S25nVndoYis4M05ZZU0xWGZsKzhnUnkv?=
 =?utf-8?B?TWptTzY1WWJXMTJJcEVOeVJaWXkrandlZjVQeHVld2VUL0J4d2JDZ2xOQmdx?=
 =?utf-8?B?bGIzWlhNa0Y1WnhNNm83Z21hQ0FsaGtTSjNmaldTbkErWnliWjBNVzlwVTJi?=
 =?utf-8?B?NldGZWlwRGRqcmYzbkdvSjJEdFMrNktNTmtwemc3cmtiR2JUQnorRlF4T0lM?=
 =?utf-8?B?RkFsWXBtK1JOdTI4OWhRY2p2aEJMR1lIYm1yeEEyODJJQ29QelBpNURVWGhq?=
 =?utf-8?B?OU5ON0FhMjkxNTVpQ2dSYWpvRFpQQ3lLMGlMNGd5N1lZS2hSNDZGMlNkcUh4?=
 =?utf-8?B?VUduUzA2Qjl5OXFmaXFHZWozR1FlUDFpNzREcHdDSzFjSzVtckJaVytXVlUw?=
 =?utf-8?B?QmVuNEJqbW9TLzFFU3RaZVhaSmxLK1JsbFZaaEUwZHdVNXNVWDAwOFpPMFM0?=
 =?utf-8?B?NnVLRWJTOG5ZWUFlei83RFhycXdkc1JWSG5EYmRWV3N0UWhlUlBuaVk0QWls?=
 =?utf-8?B?b0FOSUR4bmJyOW1rc3lqeGdGamRKNnV0MmYyRE5VMUhzRitraFI3eTdUT1NV?=
 =?utf-8?B?aSs0Q3RIQm9DOHFMS2V2YnYzNW1WMjFjR0ltMGx6YnNteXU1dU5jY3ZlZ0l0?=
 =?utf-8?B?QTRSbk4xWjdzMFEzV0p6TDNtWnFsdWFnUndaamgzSUh6LzNvRXpMQW1pTWxR?=
 =?utf-8?B?VXpGelpGVUJMY05saHFkZE13b1lLOHRmaWo1VzVMNXM1REV5dlZ6ZzVBMkFq?=
 =?utf-8?B?RmlaSnRDSGxZc2IrTnl6eFhVNjNVUm1OdnZPTFFjOVowWGRwRm9ZN3crazRI?=
 =?utf-8?B?a1l5R3hZeUdNMXZERzZpVldCdHNjdHJIUUVkUThEbUwzSUxjNlRyQjQyKzN3?=
 =?utf-8?B?anlnU21ndmVLWURXVEd4ZGRaMUVLelUyeVR6cFV6Sjk1d2RTWUZDb2FDZjc3?=
 =?utf-8?B?MmI1NEJJcGxaY21vZXJNQVRxaHlQREF5ZEViN2FOOGtMOU1zbjZyTG85VXJv?=
 =?utf-8?B?dkJSbjBUVzFPbzZhOWpjWGRwbmlJUlZaVEtCaFRNL2tnNWdrdVZSTFlqaXlW?=
 =?utf-8?B?RVU0OUJpTU9EK09GNG83MkhSSGNUaE9nbkhic01VQVRoWXdCRnRUVmdsTlNa?=
 =?utf-8?B?UFNJcm5nb3dkWFZibTBHelNpWVZueXZ5MzNSUm9aeXRZQTJWYXhZZTMyQ2l4?=
 =?utf-8?B?cG5aUkFobXlYTk1PbVVjazRTQUZObWVKMUlDS2o1dFhEaXVSLzM0dTM3Rmph?=
 =?utf-8?B?TDg3alVBVFJNSmIvSDhobWl6Q0NpUFJYQkZpTFlkYlVNVXJTVzZGMEtQaGFC?=
 =?utf-8?B?RTVBL3czdGQwUzQ0ZGt5d2RwNDJhMUFVNmp4bHRLNCtMblJ0Z2NaM2tDVTBp?=
 =?utf-8?Q?1qDpggDyhphJOlfnQcgio9RBz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b2c97f-50c5-4dd9-6f8d-08db8f65b8c4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:25:25.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba0mPgM4TTpsWfivHviVAITiwbN3PpeouqYRm9FQWBM/n7n5JmugKCRnjbN+1o6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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

On Fri, Jul 28, 2023 at 07:11:46PM +0800, Michael Shavit wrote:
> On Fri, Jul 28, 2023 at 2:43 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > Then you can put the free in a detach op once the CD table becomes
> > empty and it behaves much like it already does.
> 
> This turns out to be a bit tricky; the SMMU driver detaches the
> currently attached domain whenever a new domain is attached with
> attach_dev().

Oh, yeah, it is a bit quirky that way

> More generally, do we really want to be de-allocating
> the table whenever we switch between an S1 domain and other domain
> types that don't make use of the table (such as IDENTITY or NESTED)?

Probably.

> One solution is to defer the allocation to the first attach_op, but
> only free when the master is freed (this patch's v1 behavior).

That seems reasonable, just don't allocate it at probe time since
PASID is very rarely used.

Jason
