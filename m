Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611C7E5E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjKHTBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjKHTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2246.outbound.protection.outlook.com [52.100.165.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F92596
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRNWWcux5lwxTP12mvWW1P7q39hYy8X702OmBnBGavolVNEs/7hIsVIqbf+xtng03Nbt5PikebT8HY80hL9WebODsmKq5jaSmJ6kI8V0CcP7582JWRg1GQKZ2X8Jl53ohOHumthXRLJbI4cjfi3fL55vlBcEKaRfxUM3tq22z/mK6g4BrcL80bLO13t8L68n3Lr/NXK0N6ABi1oWMtybRvUXpIAFBwwdJqJqQkqUL6t5OJt2cKzKFwoQOhLB47xvbCxyr/6ld1796c6bkAjNRokc3juY0Rcdd4aDui1K0DW0POfhlfHGRyzrcxfeogsa6knT2kycelS/AFcRxtXbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UZBhI3Fm8A0U8YUIhaWvAcXpkPhBup9vcy4MhfWATc=;
 b=a+ssPzNTKABrTmInW3Ffgw16dN7GFeL/BSONEp2KiAQQ2LZ2YrrNWDwgRyOyCW90Vt1iTgrWMjIWzUr6EBnV5GOfKSVSKpABY3h9O5+4698uBkGqsxOXgB7Jc9jd4+zQQWzMHsIhv5KA3yeJsl27lqeoCDMcrQXB5I5ReCW5WAv9wpaaIuF+Yj1eXQKtnLbkdRJeBo+JpUcoYRTPY5j5xyAXS2iby6Tq8hUAk8iy4DkM9EkLW6xgNQtz13n2M5PH5S6ZLHNn51jxJL+LENJvyjGFfi2gaRKSl57SaMAZL+7I0PPXfPVgPGXqPb1P97RjdPtS5GqGANqOG2TctNRRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UZBhI3Fm8A0U8YUIhaWvAcXpkPhBup9vcy4MhfWATc=;
 b=qc2XEdAbZAPJew54tZSKmXVnp8fx/KjgVaQ2r8Wvcb6HKalNL7+7Cesa/NPIX1HBBQmt4npgWcgcOAUnwr1NGx8Acu+qNqKPKMY9rCTMpRIQJecrCs4b1HHjw1jzxUMXTIFexq01ZyOvCIo9Op5gVym1fFrGv+dZ8/wZgSnOMr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH7PR01MB8467.prod.exchangelabs.com (2603:10b6:510:2f6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 19:00:28 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 19:00:28 +0000
Date:   Wed, 8 Nov 2023 11:00:15 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
In-Reply-To: <ZUtdfkISdtWtJsV8@arm.com>
Message-ID: <3f37aedd-af55-2914-7b9d-29118f079c2@os.amperecomputing.com>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com> <169936667591.2397489.8626905802471861575.b4-ty@arm.com> <f3661af2-7fdf-d828-ef88-5732a370c0c@os.amperecomputing.com> <ZUtdfkISdtWtJsV8@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH7PR01MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 58314a91-52a7-44d3-61e3-08dbe08cf914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y0MMUQsLWUKDf4HA+0B4ZfSVeynCQXmcUTW0KLqbD7RsddVvs1V61gCMpntV?=
 =?us-ascii?Q?+LAqlQaAN4FI1Huzs5lNRvcFsf6dcwEJWI7yj6fQihvrmrXboepSmPFEspEI?=
 =?us-ascii?Q?ZuwLUezSdluqLBE5gsC+ASMTQGyS8g57yETAlkCfcpGNoSfRyUpLyzQfw6Zc?=
 =?us-ascii?Q?YNslEi1J2d5AhWG6QzYgsiKfLeRkYsvo2MQb3oQIAbYb5MvLKlcJUrm4iY9c?=
 =?us-ascii?Q?86Qjee0drr+pJ7Vp/9RmzHFXHMqdqKUh7hlOe5KnsaghTYp8ZCHMwnMzRc0n?=
 =?us-ascii?Q?zQXR2zCxIt3WIA+Z7r+kQnaiuakNnXu4qbOunVTEA5Y68agUhcyNRmfSGMHR?=
 =?us-ascii?Q?tJ0fneaTXByCaqMJml8fQMQ17rvwjH+WAGRedUkGZKSaTyQn4Rb7O/AbZ3ne?=
 =?us-ascii?Q?ZPyhf+zF0OfPcadlFl9ezdg7qQhKrcP74HcxujPv8OEmUwv7uJaNKlLy22vo?=
 =?us-ascii?Q?qSkagbMWwDC8GDQypn85L6euqdySc3L/LFNpGd7R3IwVnxmB91DUbP4ZHen+?=
 =?us-ascii?Q?BbWfyaQOuAL27bJWweiyvvZmTBdgxNSXB4rrRkP0juW68RK+HoSPSc8LPt/p?=
 =?us-ascii?Q?0dVRlmdbis2xl2HUzaUGN9CHCpJqMlfl3eZ7sP/lru1soUJxiyVYqv1HMxxd?=
 =?us-ascii?Q?y4Wy5SiWsRCnsY4B6i8cFSbNAkohsC2l/gyZsDEHILxEqNH0DQPnoaMb8jBX?=
 =?us-ascii?Q?wvAppxixyz3UXJnpKCx/OBYTuNBvOkV3QsleZ6JyLBQbYt98qbpn3lEaJ8oy?=
 =?us-ascii?Q?+1VVkwk3kEjiblyvpiegNtLiqJDG5zqu3p7k98s947XaknFaEes2zgZGS930?=
 =?us-ascii?Q?6KJ+vYtJNlOQ2ypjMrFLJgFLDQPoToYLe5Yjoc/zHfAX0SK4qlZZ4U2uQTVx?=
 =?us-ascii?Q?3Cpcq1RIKtL8ztqN58oy03n3Z+jPDbZcTf84D2mKfifdU5CEwSky2gr/qKRB?=
 =?us-ascii?Q?qks1IHSFM/bWHiJeA/sRIkqJ1XadVSrL2ps23lfBVUpvap0ppF86QP+/fGiv?=
 =?us-ascii?Q?jBD+CzEJD8IisBHupOAbmf4EsQngV8M00vrcRT8keWBSaFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(136003)(396003)(376002)(39850400004)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(66899024)(26005)(38350700005)(38100700002)(86362001)(4744005)(8936002)(4326008)(8676002)(478600001)(6486002)(6506007)(6666004)(52116002)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(2616005)(5660300002)(41300700001)(6512007)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODBhmuGtzFTtJTUhumm2WzL55EiD75Z9E9eCDAdArFQ8r5LszLYNPYdVQnXv?=
 =?us-ascii?Q?5dxAVNRnSiLSa4OgovzrGD/xiJ6Ad9ps1KzLHxl9cVv7hYvEmGzKBT6lMLh/?=
 =?us-ascii?Q?6WWvVmmuNp7oUuBb3OFO3Yv8/wq4KfgxzbwXd7Yl21LOaBkleSi9AsEz+6+9?=
 =?us-ascii?Q?yEb+01TqBFBvW0kGp7dL7se70fhDxRC/99U1gUBiY2+UZG76ORMYvWJYnR28?=
 =?us-ascii?Q?6Mq9eUm9WGGRPc44VSdi1wNDlOlS87dZicsn0lM0QrINsjJAm+Koc1rTZfBx?=
 =?us-ascii?Q?PWzXudGS/m6JkinNseuWbBbenxjUPsuoqQna5YwsHveqm7dkttt9w4QoUAVw?=
 =?us-ascii?Q?N+rBrzSJmsRt0YCgIuPSlYxXRznQiSsBAU54xRJmCE8Y0td/lZyWkYkjXbg/?=
 =?us-ascii?Q?zbUkoOkbyJEEsQEyPCnTTrn+nqWvzx6j1zAQPimJnhM7rd48yfXvjFG4Dq4O?=
 =?us-ascii?Q?h0CiUTs/eg12LC/6Ghi5qnCj5F3VTH9eLL0xEs+FJOLtg2Y/8QZMcw5dVhdi?=
 =?us-ascii?Q?4n4rjmc+rSGyfdmQHPJFDXHHcZ4ZpcEJTj2Uxfg5NFm1iGNSeSxL44pyMT53?=
 =?us-ascii?Q?ae5N+Dj4eNmApQPpTc46eBTMGqO5bwoUy+hyn9OmN9nYhXkiyHzH2Fmc4f1I?=
 =?us-ascii?Q?v+h6nZz1zfVB/E8gwXn6DBYrBiHdQXkhm7b0AE4kKpRlUzMPo2IKcGDKOS66?=
 =?us-ascii?Q?TPjYE8WYQ1TNrZNtbewMIZF/P+gEVSJub/UALUPZCPjgG0NkpXobzBL7BrdN?=
 =?us-ascii?Q?0u91tkSws5tmU2s03Nibjfl44bvkiMlbb1kXtCBqgGoKrj507uYI+V9tvRfS?=
 =?us-ascii?Q?Wt1JZfTFIZl1CHq005/kQ2Pr5ntB8BR+euRnAKZqpe+/3+rYmRuNt2nBl0L1?=
 =?us-ascii?Q?Dv4pE4y14IwfzE+5rXDLJto5QcLZgmSF9jX0NrrOKSasH2kY5IC7UdgV9Z/D?=
 =?us-ascii?Q?0vIeQq6m5rp1NgWNkSwrDGy1hvUT0Fh6e/c9a+8R3chtXusOraFYBR0I4zcZ?=
 =?us-ascii?Q?JrFZFV3erJuMIHGNq6OHlT9bLPZfYF85sr1UdgvH66/3urEbyPWZuOis0AWH?=
 =?us-ascii?Q?A3s7NULXGHkfa3PWTViesrB0zUhjWohxT6Aa6wbrllzuohOKuxCjYKYqP+sg?=
 =?us-ascii?Q?5TN6x6rtsW4ummnf7dufzJYGoHBVhQGJ7GqmUmHv5s89oec+nHCTiQw3U4Zl?=
 =?us-ascii?Q?M7dGAjP04AZElWQP0l5EuBV6o4EHbNgUrTtpsT+erUABfNPzkKM3zLLrDHG0?=
 =?us-ascii?Q?B1nF6jLJKvVPmUvUUwabBM8iykd7CVLIC+QGpP040IOBgkTVPL+Ko/g/FE1p?=
 =?us-ascii?Q?6cX2dYhWPkT+UaysMtFt5zLwtik5MM1Fm79h23aawnnW1/sq8zfzqyF+0Vp2?=
 =?us-ascii?Q?4j3/MuTB5rVn9SaDMt3Fyiync7pBrOJVyz8mKncevF7xCDSLizqFsMxf0kuq?=
 =?us-ascii?Q?2+xfbWQnHPXG0yS45ZlLAA/H1FqQW2jTaF4TRNCQj+T1PPqFce94Z2eXgNG7?=
 =?us-ascii?Q?n/axOpVGOj4QTIRIbpkjYu9QfUrXizhkKNsSmXVFWcRbla/5PisbY5jp7lxn?=
 =?us-ascii?Q?oO2tczDPIEmesgGgX6OHj6zskaQ6+gwvF4nQJp2rZiZMLsTffLZOTPs6DshR?=
 =?us-ascii?Q?arvFCkHANazcFb/dQmacerY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58314a91-52a7-44d3-61e3-08dbe08cf914
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:00:28.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8FDOSCpsMwIYz+w833UnkwZBqM8FmxyshF+4IJoBUYkbpo131cpxvRdNPAaJORQrBSrGiWq60Mo582eGDTqQYtnf2IstwQW+cHr/o/YeZjLUqjHWxvkIK06kgeT5Fst
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Nov 2023, Catalin Marinas wrote:
> On Tue, Nov 07, 2023 at 02:12:58PM -0800, Ilkka Koskinen wrote:
>> On Tue, 7 Nov 2023, Catalin Marinas wrote:
>>> On Thu, 02 Nov 2023 17:16:54 -0700, Ilkka Koskinen wrote:
>>>> Coresight PMU driver didn't reject events meant for other PMUs.
>>>> This caused some of the Core PMU events disappearing from
>>>> the output of "perf list". In addition, trying to run e.g.
>>>>
>>>>      $ perf stat -e r2 sleep 1
>>>>
>>>> made Coresight PMU driver to handle the event instead of letting
>>>> Core PMU driver to deal with it.
>>>>
>>>> [...]
>>>
>>> Applied to arm64 (for-next/core), thanks!
>>
>> Just wanted to ask if you are planning to submit this patch for 6.7-rcX as a
>> fix? We have found out that one can even crash AmpereOne by running
>> "perf stat -C 1 sleep 1" without the patch.
>
> Yes, I'll send it for 6.7-rc1 (probably tomorrow).

Sounds perfert. Thanks a lot!

--Ilkka

>
> -- 
> Catalin
>
