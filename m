Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F5378CBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbjH2SF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjH2SF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:05:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490319F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChkHdcLGGyqBbU44VJFaw49JuRvSdPi0AcAysYmcj+dtRHSrOwMQAD4i7IJQWq4VfsTiuyWnfL/Iaz1ytR0Z+lfIOf/WacXQqeExd/MktoFwlXg0U0a94SuMTwCUIL6gOnvq048BQnvt5/+dYoRaoEF9HRBmdw0iyQtgXYOXdK87pVxOYkg0DW5k3dgfvOBq6+CKF+zZ3OfTSqiYXa2OWOC2+pzDsV5xPho57oFjftOoMGEo6inBaXbCRabWN8v4J4nvphTCoYGltwK7giyXoNvNX6UJQI+podvY/N2JTe4X9zzB6YUUR4/sei2yW5g2wEu+BA2WyiqZ5+aSbAy/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdlEBHh9YFJwbdOSVbyBQjO6Cr7LDYz1NAxZnqqJiV8=;
 b=ZjiYSrxeDkyTKfMelSyeak/8SUWxJVXYIYo6x8We7UkNh9/fqFiYO/8YiqslMMuzFGCI97pqFl8/nuNJ6TpS9l7zu3NA+gu0f+0fs1g610GR0WiJ9D1qhQXI7d6zBFNag0FpvcBR4adBV63v1Dwur1fP7C26a8ls64uPzgzCNd4ytW/TVaNnfWysjgLv1KgPeLlTCHpvLU3u0CS353/ppfUbnq46SUdul1hyH0gtvJwwFTSGqzEUOmMO24D7qoL/EjdlwdtDygrI9r2AM1oo5lQjO6chUq+UrGfabxLCra/vjYBSKLFu5Ihqn3eyjlL12MRu/x1g2KdPV+7SZipG2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdlEBHh9YFJwbdOSVbyBQjO6Cr7LDYz1NAxZnqqJiV8=;
 b=cjpnnVKWQll2/umPy3qFKf6xtnJxjB0MAZKcPj1fX8eZpUz6jC21yKDX2RgrjXl7JJ5ou2JuiRSsNN+7FiB12vtlPXjZYwCIHGc/B9PrWJBoCQ9qDGAMMqMC6B6cCPxBIe9ELYsYgs3HdRYxajEoOKrgOba0g3vCaTx3isFrpDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 SN4PR01MB7501.prod.exchangelabs.com (2603:10b6:806:204::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Tue, 29 Aug 2023 18:05:50 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661%7]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 18:05:50 +0000
Date:   Tue, 29 Aug 2023 11:05:46 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
In-Reply-To: <87h6oi4bzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <d7443045-abe2-2790-8a66-b867abb553bc@os.amperecomputing.com>
References: <20230811090819.60845-1-ying.huang@intel.com> <ZNYA6YWLqtDOdQne@dhcp22.suse.cz> <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZNxxaFnM9W8+imHD@dhcp22.suse.cz> <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
 <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz> <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz> <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
 <87h6oi4bzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: CH2PR19CA0018.namprd19.prod.outlook.com
 (2603:10b6:610:4d::28) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|SN4PR01MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: f8182245-383b-44e3-8aa4-08dba8ba939c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyooN5ck7MpeNL+xfxtJ59O4izHXnIU3vL6tnmJukvt7z1c/9y7k+vkXYjcHNdaC+NYrozUEgXNuohZWqVeWJLa8VWm1iYJt00vlV+7ORibpUj/sfhoXbhfPenUB+U9nG1FXJB8QVaVagQewFP6p9G/RJanZZvVBIzYz+3OrKHZnlcmZVsEI8nkqtu7dvsitdbUknqaPkLXDCTGalj65rbaF6qj0toyWxjJy/gSHQb8jI4hGeG/k1+vcm+5xLCV9oW9JF/5f50FTzWZvIc4u1Ex/0yd6AViRcedLnT+wMzv4XyvxerM2bjZBO/xrG/gkKVDJPOQZVoTMz1DvxzU9BmPCHHIjrka23AUSz56h431qMwSRj94p4oVj1vIhK6Hsyde0gXU5H+75W8sVQ6zxrlkXofZkQW4zVfNjUQUPZcx6rOfSUsYQJ4IOIOyjg1obaEtU0IWe1hBMTjuYQ5BaMV3UffxklA4COGA567l39jwHN1gKy8xBtW5t9Tx4v/AlRu0TOCFZkvyHdMo/FHDoQIpsuN7q+6HYR8izQ8gBlbTno4PHn96pcfGuKJ7iBwGD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39850400004)(1800799009)(186009)(451199024)(8936002)(6666004)(478600001)(31686004)(6506007)(66556008)(66946007)(66476007)(54906003)(6486002)(6916009)(316002)(38100700002)(41300700001)(6512007)(26005)(5660300002)(8676002)(558084003)(31696002)(2906002)(2616005)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkM4VjF3eWM3YVJJQjF5YXpMbHJWell5Ukl4YWN4UVMwaGg0RzFoZmRkWkh5?=
 =?utf-8?B?eHduSzlWSThTc3BLd3g2TGlwV2pBellkWXo0Ui95YWNBZkFDZ3NseWxBK3Rq?=
 =?utf-8?B?cGN3ZngrSG9icG1WTWNEb3N6UzJKUXJMb0UwRjNBd3BoZVlUT2p4bVVBbGM3?=
 =?utf-8?B?b3dSZ1QxVm5PMWZlU0VxVEhKeXYvamVqUnVranJvR1MwTmU2VTJZVW45ZTZx?=
 =?utf-8?B?L0twRzJocFdpTlFmcHE2U2syMkh2QWhpOEJmVUc2eFgvVlY5SDExdGJic3JE?=
 =?utf-8?B?MzdqRVhjV0tYRnhuR1JQTy9oQ2tkczNNM1lBekJ1WjVVK2ZzQ2JQQWNUbFNJ?=
 =?utf-8?B?NGRteStQZjFzV0oxeDRHNnVWK2VkQmxITVpIeXFGNWpHZFhHTHd5VzQ1TFZ1?=
 =?utf-8?B?MlcyWkNGZ0JQb3hqQ2YxUHpvWTZmQVMxa1F4R1l6bll2NmVXTUNXUFVZR1B1?=
 =?utf-8?B?VCtoaEtZTDBtYngzVnUwWVl3MS9JanFQbEpSczYzTjdOY3JnM0FrQVlQZC9t?=
 =?utf-8?B?MkJBYnNNUlhiMGNmTVN4eEp1allmQkRGRllCWDJyZ2Fia25oQmNiOWx1em5r?=
 =?utf-8?B?aVVmU1FTaDRFN0JRMERZQUMyY3NCb1BHdjBtTUw3V3JjcDJqMC9QbTMrZHdz?=
 =?utf-8?B?MGFIMGZUM2VDbjZrNDZLbzJJZVdYZFN2V2ZJL1ZLdnJTUVlCTlRPSmJpR3p2?=
 =?utf-8?B?dU45NXZtVFJDcHI4dHRCVy93M0w4cjNuWWhFMU45ZmZRbE1IVlBEdmYxYko4?=
 =?utf-8?B?M00wN1hQZ1NySThQcEZjQkNOMkZtbzVORy95UFBwb2J6SkZTRERJQnlvdks5?=
 =?utf-8?B?bU9VYkQxeDJGRkN2anpRQWJodVRpdW83RDFIb0szckdMNkhJaXNaSDIyalRY?=
 =?utf-8?B?bTN1SEZRN2p2Yk1uMEVpdi9ob01BRVk4d2xBeTF0Q0lia3JvTmRlRWtKVDlk?=
 =?utf-8?B?amE3L1ovK1B5KzlSK1BINGNORDdlNXhVSVNqTGVDdlRDYW84YnNWalRVVDF3?=
 =?utf-8?B?VUZZekovZ1VCRTAyZUNPT253SUl3ZEJabXdrVGczVmdMS3dxUnd2Z05YWFVO?=
 =?utf-8?B?SGJObHFKY0tQMkRoeVptS2FGVXV6eHRMMS9zbURUNW8ybmoyS25rekJtNnVU?=
 =?utf-8?B?Y05PT1QyanZjRUk5a1o5dnhpRjcvUnpIcjNRaUE4eWw3am5jNjlINkhMZEFJ?=
 =?utf-8?B?aENUZS9ZMHMvMjhKZ3dJdUV0cVd1MTJMVjhiUVVUVXNYbjlod0V6UEd2MU1I?=
 =?utf-8?B?QUJPQmxBb3hTSVEyMEZyRzlCa25CZ3d6RmVKZDY4WHgwZ0ZIOHBlMmt6TTRN?=
 =?utf-8?B?Rk5hUFlBcGNYNDFQWnhmSmpndWJDeVcwM3V3YWNJbm41ZzRYcEVCcmNoSUsy?=
 =?utf-8?B?ZHo2Q1J2NGFPUFVyR0JzeUk2QlBjemc3djRUZkhyWXdLWmNRaEw4cUJEbkN1?=
 =?utf-8?B?Rnh4N281anR4UWpyTExGRnJFcG16alZwcGIrbks4R0FqTHBhRmZwVnRJU2th?=
 =?utf-8?B?ZGVzSmVBaTNkTkw2b2p2Zmg5ejBIcWgxSGhSdVZpY093eUFWRkJjTDMrU0h6?=
 =?utf-8?B?cTVaNHNPRTVNOFpsUXJYblI3S2NZbzdIdGNwRkNNWUNsUFJuVXRmMktrTDZL?=
 =?utf-8?B?TU1janhQY2gyVkxMcjd0WHVGQVo0aDFLZnJXSEp3MGFob3ZCbWNzVERLT0Jl?=
 =?utf-8?B?WHg4dHFiWVE1NjdsK203NzF0OGZyMG1ZK0s2blk0MU5DemVFWHcwaERjU0dm?=
 =?utf-8?B?Rlh0dXpNMzVkd09qbUFIclVuQ0Z1bmM5QTR1VXUxRGdaN3hiSXZxQ0VBamp6?=
 =?utf-8?B?b2FCT0RkaUNQM1ZONHNjamZqbCtrWlh1emR5cnZOdGRScDhFZmZ5d3JBcjhq?=
 =?utf-8?B?TmdLbk9OOFRwY3NUN3RQN1hsaExVb3JsMER0MXl1RnB1Q1UzUEJVVHJ2MzBz?=
 =?utf-8?B?TkNRY1YzOURjeWdCdXRaWmhjYnFnMDFocHlBVFlpcHlnNmNVeWpuTGk3RzA0?=
 =?utf-8?B?YXM2V0ZjdVRjK3dLNzFCaGExY1hMcFQ1K2ExZ1JJOSsrbkkramNkZGtyaWor?=
 =?utf-8?B?cTM5Z3l5Y0JRa0hsRTErd1VlS3RvVXdtcER3NDUzd2FjRTdxZGdZYXNiSmVs?=
 =?utf-8?B?K20vUzNtUzAwdkludlhIanBKQlVrZ01zQTExajVCS3JRNjFOdEo1UC9lQlh4?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8182245-383b-44e3-8aa4-08dba8ba939c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:05:49.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGQRDt+UMbfqZcYncGPHXWpvOaCxlRHzuYbkPIBvL5+4Ivna71f2NP9bIhnzDngUQepjhNb4fmF06rl13kacxd6P3bz/heVm8a3C+vsXe/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7501
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023, Huang, Ying wrote:

>> So I think there is sufficient rationale to apply these fixes.
>
> Thanks!  Can I get your "Acked-by" or "Reviewed-by" for the patch?

Reviewed-by: Christoph Lameter <cl@linux.com>

