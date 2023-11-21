Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBA7F3422
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjKUQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjKUQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:45:33 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842E191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOF5JM9xaTn+VwQKxVhngK5QT0tU5KRVKuU67UmQAJdeiVGO/1kFIJEXyq673MMjLQrciCyyaPDZNbvrfW4qk9JXt8oLk7zLzog6W+qj7HJd5jcR5nj7etxSHHblhAmYgcJlXqpRJoQkfFN6hvlhBgX7CFppY2cBsRNLEaP9wlVToWozQv9aZG5fK6pI1ZHGxavuCkc/i8GvntCcv39E0xIOxNiuUFG0gqlCXw8xVG4H3ye/gJoJIHFMkxGSRgstlMi4DBcqAOkePcgVwC+s63O4DeVE/tGv1ddz7SQ6DVgqrf4exTuIY3VbApL2qfqJmA94l66SB8TEMxBTbOjYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QAp5baliZSfDsdfAaBbkxYAjIo8u/1GS4F3gpn23MQ=;
 b=Sri51UohoFh8UrkZCD+pQzqCQrUBoEEbNdrUlcit4hczWqkRVyVoeMnfX4RZcuAR1/8cDuDVa6MtcctBGJBndhkFkV3HG/SL+xb9xr390h4d0/jHGEyMdC7hyxUp9WylA4hPsITcbrAYRJCKzi7O44EaRdEjP/eYpJ5V8PGrRQ3EnGA+CIsWm0Tmx8i5gfMftMUrRi9So5ucw8baEPG02ckxI7tEeLErdK2BxF23KkjidCNoeg4hdrhMrh2ArRsW0nTVbOpnqGs0f6qaERyKLADoSScAYRAzYF1VN9bGyGZzkW2e9cj83Yk6JnZXvlL4Qcc/rqVh1sx62zEypCjtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QAp5baliZSfDsdfAaBbkxYAjIo8u/1GS4F3gpn23MQ=;
 b=fifZsv5hTvCfHsKbGFDzAi8by75Oxhzya75FAaq3/tyEApjbCDLt4ISEnXlEdTY2ekT64VhRJ89LVXSD3IReJwa8bwxl3Olz4rGme0HILTLKY+3VMcilbhjCyBSEoUsHh8G7pGQUtoUhnEcVfQ5NaRmKd+Q0R8P8NN10bQTCgqh6tseYzyv595QoWvV/c900N1cPHy6MlofhFr8BzLNPnFaFxrkcLk6aI7iUWQ59HmGfm80UFhZKDgY7RxLgQFCIg1WlZXZbWSqWm/8xinF1Oy1ak8oC5R5ROJzWriNDwFQejVlWXDmz2ZyMyJ7f04WmCeBPKm5t9OYQLSOk2diiDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 16:45:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::a7c2:45b6:7733:2bf1%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 16:45:26 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 0/4] Enable >0 order folio memory compaction
Date:   Tue, 21 Nov 2023 11:45:22 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
In-Reply-To: <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_84E3D06A-6D91-4F40-BFFD-80D59E6188DE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bfcc85-0e35-4052-c140-08dbeab14340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaJpNR5yejaGjBlH+vOHOznsLuWTcXMfl1edStIaBFXhj9eBr+LcHYO8RVpXcMTIajc4UWyzKy5TcX9PYuYwUSY6X7BlD/r03qUROkBqvZHftS1CYiuVd5+awMa8X6FP/KBLBGvUoTFABD2G6eUTWdOquM2c0IKArxDcEZB5t+vqOmHUXvYgX4cDi/j6xRKiHxwjeHMmyWj24p+eWD2KSOVHTLd3NgafYifD8Bl9Y0thUa5osxp+eTKRVHhiqUoftH0KfVjY6rCIPLSnM+2WpLf/AwxVd7jgO5liiqxSoW29lvycZXK6n9BscrSXYH9iHC1oK12kNqua9VcgkWcqsw2ugNMj52RiriAScx5SsPodgoC6h48jX1/QBfGj0r/KPZuDMVv9s79NYETlvJxBEAGeJmn/KafHGVlGqsPlD9TPaev95SO4lP7++VHwAKlnpWoo8gqNXcU45GF7vDYeRNzs/+T0V0FJY+dAIMeMoKTYYg3ZU4GiXMO1W+waXVF3xw8eInhFkEVrDQJXjWerXe0NLX0ch3UWf/GR/y72Iqo9ylAp+MQQCD/e5tqA8/+iUIRV3bdeI5j6tzOlhlUUb1HYtQIWSW8GYCN+9o4aTZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(6666004)(38100700002)(33964004)(2906002)(4001150100001)(6506007)(7416002)(53546011)(235185007)(5660300002)(86362001)(36756003)(478600001)(6512007)(33656002)(6486002)(8676002)(4326008)(8936002)(2616005)(54906003)(6916009)(316002)(66556008)(66476007)(66946007)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pSVkoyM0ExYUh6aDAyRmJzRlc2SUpIRkpERS9sN0tUUnZlcTd6K01JS0Rw?=
 =?utf-8?B?MzJmM0xoenRXajc1Sy9hT1lzSUNkU0Z2OUliYklhV3FkZndRa0hqLzhDQThp?=
 =?utf-8?B?dFNHSm94V0pYYkpyOTJDS1puUmhPUmU5ZW9vVndrc3RKdC9xVWdpNHJHWXI5?=
 =?utf-8?B?RmMvcmNjVTdYM0dYNDl4VzVKeTlaekNPN2pCWThrcmdwZlZZT3ZSU2o5U25z?=
 =?utf-8?B?NVN3c2VTQy95VUd1Wk0rTDZEcnlLY04xUUo4bUE5bDFtUU56TnZZbDZ6NUtN?=
 =?utf-8?B?VHZQQmxJNW0yUUVjMlNKbi8zZDlLUG0wR0VJT3ZCaHBhVXRXME9wNnpqLzIv?=
 =?utf-8?B?c002UmtWOTdzVGVnWDc3RllTbkc4dEtzQzlDS0R3SEsybk5RQ0syUXFub0pG?=
 =?utf-8?B?OUloUm96OWZoUXU4RFRvNHJsbTN1ZkxnYS9zTzBGSUNOVGFCc2tESkNrTmha?=
 =?utf-8?B?REsrWHpGS2g3UUFUL3orckxsM3ZreitMNXk4dU5qenRZcE9JUDAvQlR2YjZm?=
 =?utf-8?B?NnFtUUJZTk9lQVNoWEUyU3NhY1BmT1R3VGpyQ2ROd2VuTk5mMjJQbTZXVUF0?=
 =?utf-8?B?em04cGo0WXU0N2dNYzBDelNzb2UyVXFsVU1QSDZoUm05NGxaYnhpZnVETXMw?=
 =?utf-8?B?bnd6ME1OVWIzSURoaC9ybHhhb2F4RjdtNnk3c0V4SElvOGZ6UFN3RlhIVnFu?=
 =?utf-8?B?WENTS1lybjVXQzNkOGZxTVVVNlRaOGhZUk9kM3hRQmMxNkFaUGxIV1gvN3k4?=
 =?utf-8?B?dW5sUFIxWitRNWtBL2tocUtVZXVTNlJLVmY2dFBkd2lDWDhTQXplMHMvTnN4?=
 =?utf-8?B?eFd4cjZNYm0wVVJ4bGYrZkZWVHBWb1ptc0NmR3prd3BkOEROTDFvOFFubmh5?=
 =?utf-8?B?NmplNWE5UmlSUk1uY3JMTC9YUXhNMzhlclg0NGZFeTBQbDBpOEJQdnJtUkxO?=
 =?utf-8?B?Q0puMEZlYlcrUmkweDk3eStDd2VkbWFJL2FpQW5MWkhPSG1ELys4bGYxU0VQ?=
 =?utf-8?B?UEhBcEcwQUdjUk1Gb3I1K0EyTUxoNS83VDZDV2ZKN0xvMVd5bFZFWjI2RTJG?=
 =?utf-8?B?eDhQUVdIUXNtcVhkL0tiL1hicllnbStyR3lxcjVCbkVvRTRpbmJVcVRVb3Rr?=
 =?utf-8?B?NVIzQWRPU3NmdmlobS80c2o0aGVqS1ppOUlHMHRCQzZ1NlkxZnQ5Vlk5bld1?=
 =?utf-8?B?VXRBQmxyU3N5ZWYwUVM2Wk9iaFQwY20zajN6eWxLcTk1Nk83T0NQZ3MzdE9v?=
 =?utf-8?B?aVNLcm5xTGJLTWVZMFpFOTk0cVNOVGY2NHZiMm1na0JhZkpkakZ3czByM1BJ?=
 =?utf-8?B?UmMyWmRZS2k3Z3dic3pkOE1mV2RmMjljcnZVeGljdHUyTUZuL01la09rRWRp?=
 =?utf-8?B?dzdwSnhQSGcyVHEzZnZ5QjVRT1EzekZCOHFsMUt5WER6bE42eWFXSFRUQUs2?=
 =?utf-8?B?SitMaFg1am02b1NaZVNKaHJnRlJUeUt1KzlYSTRXdzNwRDdwbkpVM3REWWUy?=
 =?utf-8?B?a2FHT0N6R0h4RlVPZExONjFvaEUrRmRCSFE1eEsxRXlPSE9aRndsaXpuOHlM?=
 =?utf-8?B?Y0hSemxpV3VkdWRMSEVJRWtuSUQ3Ylc3Wlp5Z3hpR1ZhNmZYbUpQc2c0aUlL?=
 =?utf-8?B?aVAxUkZ5U094L2pLWVlscDVTTTNycVREY0J0V0lCWS9iR2gra1ZKWDZjWko1?=
 =?utf-8?B?WmRjdnByWnFhYlE2cktPeFAyNTNjblJxR3R5K1NKODQxMHIybVMrSDN1eVQ0?=
 =?utf-8?B?L2VuTmVZQXluMFRtUkpkOVluWTdncW1KSW1Tc096dnRUUGVVdGVDbDlFRURw?=
 =?utf-8?B?ZmhLYmlCWTN0Q2JHZUFZOGVrbEFjRWhvY2N4NU5KaCt0WlYrY2ZHUDVPSUtT?=
 =?utf-8?B?TlF5QXNCQm0vb2ZRSWRKZElqRytwbitJa0cyQVVtMXd6bGFzZ2R3RmpFWDNa?=
 =?utf-8?B?ZytMdmgydHpQOXRTbnZ1eVJhL0I5ZzlIRFo5cUNEQW5NMHlEay8zU0ZRYlNi?=
 =?utf-8?B?WTA4VTN5d1Z0dVpXZjFLcXZOaHdNRllYazRFSWhmeWxNeTcyNHJmN3VuMVdS?=
 =?utf-8?B?RkFGSjdlUWlMRXRjdGFKajZONytjcEtBQ3N4S2dDdzJ3WW9reTR4b2ZDcmw0?=
 =?utf-8?Q?CEok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bfcc85-0e35-4052-c140-08dbeab14340
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:45:26.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1jE+93zMGNKnEVYiZnUFzad9w7a7TMSFE/r0wll/3n/5VWX2NkB7d4eJx6vl2IH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_84E3D06A-6D91-4F40-BFFD-80D59E6188DE_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21 Nov 2023, at 10:46, Ryan Roberts wrote:

>>
>> vm-scalability results
>> =3D=3D=3D
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabilit=
y
>>
>> commit:
>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>   6.6.0-rc4-split-folio-in-compaction+
>>   6.6.0-rc4-folio-migration-in-compaction+
>>   6.6.0-rc4-folio-migration-free-page-split+
>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>
>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration=
-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- --------------------------- ---------------------------
>>          %stddev     %change         %stddev     %change         %stdd=
ev     %change         %stddev     %change         %stddev
>>              \          |                \          |                \=
          |                \          |                \
>>   12896955            +2.7%   13249322            -4.0%   12385175 =C2=
=B1  5%      +1.1%   13033951            -0.4%   12845698        vm-scala=
bility.throughput
>
> Hi Zi,
>
> Are you able to add any commentary to these results as I'm struggling t=
o
> interpret them; Is a positive or negative change better (are they times=
 or
> rates?). What are the stddev values? The title suggests percent but the=
 values
> are huge - I'm trying to understand what the error bars look like - are=
 the
> swings real or noise?

The metric is vm-scalability.throughput, so the larger the better. Some %=
stddev
are not present since they are too small. For 6.6.0-rc4-folio-migration-i=
n-compaction+,
%stddev is greater than %change, so the change might be noise.

Also, I talked to DavidH in last THP Cabal meeting about this. He suggest=
ed that
there are a lot of noise in vm-scalability like what I have here and I sh=
ould
run more iterations and on bare metal. I am currently rerun them on a bar=
emetal
and more iterations on the existing VM and report the results later. Plea=
se
note that the runs really take some time.

In addition, I will find other fragmentation-related benchmarks, so we ca=
n see
the impact on memory fragmentation.

--
Best Regards,
Yan, Zi

--=_MailMate_84E3D06A-6D91-4F40-BFFD-80D59E6188DE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmVc3qIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuNIP/2mVXWbVQL1K1+romdPjGU+yNUE90FXp5jy7
4cLt//cUnhAc87ecfuAVyQSauv4hvjNtDdTNXa+EqxViwv35IpbeYu+OTBu46gqI
kMXARaTc8uIAylPwgdGZzSNBmp1nevvyqUXZFYHLGz5XEYidtZ3mXt11jUA1vSqV
pus7bPVb+odOsLCp+4QWZagDfGP0HP6cxZ4WQBLX7r2Cpf98ZicgIRd7ihDMZS1V
+ikUj36M7m4wWScg2xPLD4k76uZLmWRYia7hCJVSl1uzAUf++oW/zW+Tezb6pPKv
Cz8BR4vGwGQ8lqlCqB5+leuQcOlf4ixmPG0RJP+fZO1T3H8Vydzazj+bqzhhKhwM
RosenItdTHpq153Zs3Ll1mVbXdkD0AikOJdzoXh8tJ3aKuzpNaXh80IbVCcGyxJV
v9AcJdzEmOD+XHiux0V0/kpeafcYuytHXkTapR798zbeXjMVacimc1HM5zOkQQMo
0KBvKp1ndm180y4PyiFXMFgP6TeJb3ZPxNn7ehRNwCTfmC43H1U+1SCxqYmZYV/i
Y3ew5qHGh+MS2XJcef2Dskj8fec/kZYJqteSoyDAqdI4FKNrLPIriNLmq0N4M+FZ
VFZvYuNESA5ySE9sSDMHOLTdnEmGBSLCpaAZsMyOhU1xMGyE8AC1VY5V3SSOhIXf
2dLcTPGh
=AH+Z
-----END PGP SIGNATURE-----

--=_MailMate_84E3D06A-6D91-4F40-BFFD-80D59E6188DE_=--
