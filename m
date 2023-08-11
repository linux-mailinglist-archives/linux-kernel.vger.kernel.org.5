Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA12779403
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjHKQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:12:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF910DE;
        Fri, 11 Aug 2023 09:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO+0akZoVpfuXNVjwPASpkfZxH7aSzrw8Nof2u74YA0bSzuGWw9o+LMcgwaQKOpYuwJHH5dGWBnvk4SWDnLBg35619Fwv+h36EP5Wi/GnCadU8lRKuop4PCaV3gROYhYktKRaHzdBNXOnnnJS0Rit9xRQci/Y7qfQhd5DNpqxSeYgh/ZnCMrzBnBXmovlUd1TdX5KcRLlkr/Pk5tYE0dm37IOOjSUi4ChC8BJhJvWO6pDc27r+182u61qbz9U5CzLqOAoATNyiE9qQof1V6n998286PBzyTmyY82Fed+i+r2w3dhBbJU6/0AsM7x/bbZCzE8BMm04xXwgA5EC3UozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf/elbfRvxq3oabQE8Q8VERGtGZTjnZODKdMpJc5wwI=;
 b=Pky8Ntdd5h9NBTxy3AJUZ77eSGzfcVKkbGWCVHHfYAkIt0yC/4aGIWrJCGNQnx6cM9HTAbTASuf5nQkeLK9r/hMR/FSLHMIAglxXjp8pdFgdkHrbANASxdgDHQjeYfOOazYtE2s9BN2PknFO18UFsPAc8LcdLJycQs5uEY6EMK+OozofIAlbHv5BFuyg9/aOUXPbA7n6Yt3PsKieDZiPfwCufk6LsyfpFFfD1BgXvEZcgDM/O+YCaF8ASEEvBdQKB52KWq/gH07W3wbSxZncotPMZzIRjLMGzmAm6ywc1SSUB3NPP3V8pY4y4TGMnI9eAyGeXjgzbu/VQokXd4pBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf/elbfRvxq3oabQE8Q8VERGtGZTjnZODKdMpJc5wwI=;
 b=GhYX3IRh2X1UcJGnJ/nHHKnj+4ejJFxHT1oqsNfKSkUt11ZxfLFAkjJScOc85J1ShnPdobdeTNIB6M9EKZwVsh273MpAIMqGm0TppwR2xMroveieR5vHto1SUxouR1TAIMlG3VeFRpmt2UfYJIVWxCYSWHOXnGoopRpMkvs0DVEizYwWKWOJUnCNerj+yzSttXI2RQWoshKqx3ctYGjoQjl3zWVwcwbRjcfvW5HFdroEE+O+TiO2/Aw8gUu9sWR4lkpg7f3XBds0F/pAa1vL/079xaNcgUt6eIMZZC0K8/KYPbRyxnYpwzr0qN/LpCjcHG+h8Umy0dCnAvfcvMf7Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 16:11:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 16:11:58 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Date:   Fri, 11 Aug 2023 12:11:55 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <14C73423-C643-4B72-B3DD-573F5636B5E0@nvidia.com>
In-Reply-To: <8aac858e-0f12-4b32-e9df-63c76bdf2377@redhat.com>
References: <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com> <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com> <ZNVPJ9xxd2oarR3I@x1n>
 <ZNVbObUGbos73ZJ5@casper.infradead.org>
 <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com> <ZNZRTmvkAlm4yeAd@x1n>
 <b001adf2-238d-1708-673d-6f512a53e1e9@redhat.com> <ZNZarsR7cVn/QH+H@x1n>
 <8aac858e-0f12-4b32-e9df-63c76bdf2377@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5CCC8A46-CD6E-4F55-BF51-A34C06D51A6A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:fc::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 755f1075-9aa4-49b2-e6e7-08db9a85b025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKx20tl3KXe5WTmo8Cjc7JNgLqizk37P9QN9w8Wuz7IPKo1ncwce/Xxad0SQLphqQruK+9AjlYiG4CKWNNohD9C4CUjzf4hSyDefiVULraUnfD7hqPXdgW/iaQ5ikO0Z7SF8trgB/NDZx0WKjj2mt60mVnMLlxn1g5V2iBv0ht0yDKpZkt1Pk+WBnPrnUTy5lW9PWX1Flr601pQZjk95jcVj/XCFNI5Ii6eXt6GssMkL1VLYDV0YLT303DoZGbHDag+LRETnO8cKtZuChO6hg80RWyZWr60bIa+T0ndQ9mq+mXkLWGAL8ef3Bjnlu8Qa/KwtZYImg4c260CrUo8kCDbNMbIVJMUhhfljSTIIY5H5My9kSMQD/DsKeGDGtzyLjGXrQEp8TYnwpxTbs9QgqZN7xrTNBE3dYxxkb506vaHK4cYS2XQHth6Sx+Zf1ztvb5FsJkfyhc+rd159YbCnOyKTE4Uxkc3swZUEcn5D6FVXzcnyaTILVtk+sASWV0aZl5+B9LD52Q3Gp2dONbvvDGrwcRuLAcaMglr7iynszbu4U0Ez9up7WpPq/Xro7xlAVa6RhOYHc/DChDiYntIOFbspJUInBwWrukiu4yjFqhNf0G6BewSGwp+nD6cSDT16Ry9MmrL5bvR1eP8ZkgTGIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(186006)(1800799006)(6512007)(478600001)(6486002)(6666004)(54906003)(83380400001)(53546011)(26005)(2616005)(7416002)(2906002)(235185007)(66946007)(66556008)(66476007)(5660300002)(4326008)(6916009)(6506007)(316002)(8936002)(8676002)(41300700001)(86362001)(33656002)(36756003)(38100700002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65BAXiKXbKJaLyEYvtlOiuQAQuECabOiGV2ARUnRxvi7BfHMCPWDxLy0ItCT?=
 =?us-ascii?Q?3rpYo0I+N6F+Z0COe9QrWDCJXS8hQBUzowEcrHokNfeMoJy3V/QG5wWd6N/G?=
 =?us-ascii?Q?6I6jIlibsJd/kW2NGTuycCo0dXwDv/KG1IOJKd/5/b78JQCmFSmCiBwXH3M8?=
 =?us-ascii?Q?Gza5HPgXs2mNyGghXnGorAfJFjHV34I+4AfCT0T3TlfKBE0dF12793CzK9YE?=
 =?us-ascii?Q?Znt03kSypBplAT7qFusOgfoJStMdYa+TKuYBYeTWKjz5t0zbzKcUlU1ebfXb?=
 =?us-ascii?Q?FmETmLwrjSmaVVmqbhJ1vqq+lpz6nrPGzhQON/eBZ6pSpzxYo2ZYB2/r4GLL?=
 =?us-ascii?Q?7ewm8AwY3kqUhNf+5QKhOCFauiDKe4N/sVn8Y5KPcGbsvn7vv9x5w4+dRBz4?=
 =?us-ascii?Q?9zkniRbnWIEwJYKKbMuLsTeWLUDKz0WvLctXcfDlBRusJM6PFRj/GrkbliXE?=
 =?us-ascii?Q?eDFeHM8nj2E+BycIa+5CWzgMpbnkmHxVMjEMxff373GtqsOR0Ey5AOQLgErh?=
 =?us-ascii?Q?yjcRXG4ctCPKo9szFPC16M1HFSiZvjhVFpuRh6SNaDutKIRZBJ47H4HhNdwu?=
 =?us-ascii?Q?LPXoXxvvlXcc2pSAtCD7LQGVM7JRZpDG6MiJDrOcI+TyWWLrYyOMRuvyZMQj?=
 =?us-ascii?Q?nb5i1r3VLm6CtjlwvefVJyQmNwZ+651p79EwhHchVZOJ29GI3xBRv9dzwG4W?=
 =?us-ascii?Q?GK2sLa2HjC5lzdKDN7TmyG/Zp5SOKZONgVK7OUaHo9N03AHI6N/fkHYEJaam?=
 =?us-ascii?Q?Bfjrii3rQ61EZKtzn4iWsnKkfeloo6fwlDMcCBP+yV48iycVgHQ4JS+aE31B?=
 =?us-ascii?Q?d50L4HjxWGWq3wRc3nxDZmWmtKSRBQX+5gnzGKKIu7AN609XjKqYlAE1CyD+?=
 =?us-ascii?Q?TT2TKHbKHQKXShdQARz6PLUzqThloHP4cQup20gGXAW/u7ImoRG8ACtdOjO3?=
 =?us-ascii?Q?gtsS6J50/A11jlgDeXYgnHt51JDG/P2hyziMoW4c8fJlYzQGb42UOjZg9cgq?=
 =?us-ascii?Q?ThKUT6YQpcpvXrZ8SGdwdxjlEo6C41PF3DmqYziHexq7CzU2EpdcjSTY7/0t?=
 =?us-ascii?Q?fvivqwBtzhho9UWBQaeMWToG+mft/R4ceiTWywLqEP5l0azeYMXDL8xJlLe3?=
 =?us-ascii?Q?MOkWe3LUr72O3IxhrgF1f7O3ZN+uXGNDfFMRZrQc7pbJIu2gPuKw0sJ0Fwvk?=
 =?us-ascii?Q?cQBdX01BBY+u5e0Kxt3uNmOBYrP/f9FC32iDjgbIY9hp3VEllG7VK8QAkH+v?=
 =?us-ascii?Q?Qgw5gVofy0PXQ9ARexHwOLRd1ajIxo1MtdlrsDCWBQJ8mUM7+OnIA7hgcxZl?=
 =?us-ascii?Q?PY4w8fXGHCOaK3FaKnAU0RjdHsuGD20oqbFxt+dju6LxxTZXFIME3dhHvQ3a?=
 =?us-ascii?Q?bjlgufOKbeX4xTdGAc0m5iyumRZgiWA7eAMV4AlbFrYUbe3xW8OXNQeYOiDy?=
 =?us-ascii?Q?pC03bDHSJTfbb2StBjj2UAB/h5AYQP5Dmysg/bhKvRJbZE+AAbpxom/BncOK?=
 =?us-ascii?Q?PyFv8sbG5iJMZVMDP+KJncwijsxGPYOpgq0f9JKdJ9PC+t/7/aqIjMOkxOaD?=
 =?us-ascii?Q?F8MRTASLrtkNrBv8tPN6Tq6kNpOr0BVPgx2MtG5x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f1075-9aa4-49b2-e6e7-08db9a85b025
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 16:11:58.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G58GKL5osBy7/NPV2PLqWGUviT++tq/A8tFxAbRgbpd5KwpgTa/8nV4tZj9/YuTE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5CCC8A46-CD6E-4F55-BF51-A34C06D51A6A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Aug 2023, at 12:08, David Hildenbrand wrote:

> On 11.08.23 17:58, Peter Xu wrote:
>> On Fri, Aug 11, 2023 at 05:32:37PM +0200, David Hildenbrand wrote:
>>> On 11.08.23 17:18, Peter Xu wrote:
>>>> On Fri, Aug 11, 2023 at 12:27:13AM +0200, David Hildenbrand wrote:
>>>>> On 10.08.23 23:48, Matthew Wilcox wrote:
>>>>>> On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
>>>>>>> AFAICS if that patch was all correct (while I'm not yet sure..), =
you can
>>>>>>> actually fit your new total mapcount field into page 1 so even av=
oid the
>>>>>>> extra cacheline access.  You can have a look: the trick is refcou=
nt for
>>>>>>> tail page 1 is still seems to be free on 32 bits (if that was you=
r worry
>>>>>>> before).  Then it'll be very nice if to keep Hugh's counter all i=
n tail 1.
>>>>>>
>>>>>> No, refcount must be 0 on all tail pages.  We rely on this in many=
 places
>>>>>> in the MM.
>>>>>
>>>>> Very right.
>>>>
>>>> Obviously I could have missed this in the past.. can I ask for an ex=
ample
>>>> explaining why refcount will be referenced before knowing it's a hea=
d?
>>>
>>> I think the issue is, when coming from a PFN walker (or GUP-fast), yo=
u might
>>> see "oh, this is a folio, let's lookup the head page". And you do tha=
t.
>>>
>>> Then, you try taking a reference on that head page. (see try_get_foli=
o()).
>>>
>>> But as you didn't hold a reference on the folio yet, it can happily g=
et
>>> freed + repurposed in the meantime, so maybe it's not a head page any=
more.
>>>
>>> So if the field would get reused for something else, grabbing a refer=
ence
>>> would corrupt whatever is now stored in there.
>>
>> Not an issue before large folios, am I right?  Because having a head p=
age
>> reused as tail cannot happen iiuc with current thps if only pmd-sized,=

>> because the head page is guaranteed to be pmd aligned physically.
>
> There are other users of compound pages, no? THP and hugetlb are just t=
wo examples I think. For example, I can spot __GFP_COMP in slab code.
>
> Must such compound pages would not be applicable to GUP, though, but to=
 PFN walkers could end up trying to grab them.
>
For FS supporting large folios, their page cache pages can be any order <=
=3D PMD_ORDER.
See page_cache_ra_order() in mm/readahead.c

>>
>> I don't really know, where a hugetlb 2M head can be reused by a 1G hug=
e
>> later right during the window of fast-gup walking. But obviously that'=
s not
>> common either if that could ever happen.
>>
>> Maybe Matthew was referring to something else (per "in many places")?
>
> There are some other cases where PFN walkers want to identify tail page=
s to skip over them. See the comment in has_unmovable_pages().
>
> -- =

> Cheers,
>
> David / dhildenb


--
Best Regards,
Yan, Zi

--=_MailMate_5CCC8A46-CD6E-4F55-BF51-A34C06D51A6A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTWXcsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUszQP/ifkV5X26yq76tNdVlHwFW9dNDFwf5gV8p4C
j61jWVteaRQ7lvIrztbtVbBr+ZMfDgo3WAtNl2xHmnxYl8ip4JVvFKfFxsnU7i0y
OIxTw+G+SAry/PzjmWglc4IrKVupGzWcJJcmcW4yDTg0yFmL1N01AY30eJLGwfZT
KCa1hJcKavDkc2Fs3dhHeee8SGqKefgkWcfLH4et5OlsdKz4eq//aJQCGiNqnNgC
qsemzmDZlCc0fa2YpBfodbz0CKb3nAoCmhHUe5wcr8QrWBG6LyMxC3s37Cl9+bDX
Nl3zpSy3HQtqDv+DtvFULw4x0tXbeGARczRgfg+Un3xomch9z63GrFz3o6ijSaRf
1/yAAsQD9YjFqF7ZPERzMcg8absPjsjbkqGnkwBJMN+OsT7xmDRhZGkF7KjRaIMg
nKj09rNUtZNRPduOWqFZ9pOw7be9qEaxtUBWy/Usq4gXFgq42pl4nyqQWBboPwjs
m85qpuQDPz7CCrE4BCf4gJISRQiuZYp+LZ8DoIdzEF3ZNdERVhb34RCEbHXqn1D2
vOjw7Mz2UymXAY2j9aA2ZB1Lp1kk1xpxGgcW6a0umrwoNZl6SJe6M9Cy9h1SPvRj
0NIlU2fD/NJeC3ODMJ00NGHg6Ke+NLnW+HKTOtYTupYJb4BPKwPIH/pVz97o27ou
wHj5I1ZA
=6S9U
-----END PGP SIGNATURE-----

--=_MailMate_5CCC8A46-CD6E-4F55-BF51-A34C06D51A6A_=--
