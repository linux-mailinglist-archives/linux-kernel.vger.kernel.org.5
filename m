Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ECE7926F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349707AbjIEQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbjIEC1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:27:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E05CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSrovdv7PrbtddOSSmVy6KpgbWAe/zzv7kJrssVsg7wrE/YHiHEHZffErY6DDfLI6wxCohn39EXw8x0GFJ2Oij4gNvcmUCqhazC94B+bZsxniHhHM6OtmXg+xU1K9FpRjvIeP64WFTt3W2DAoPxicJTksW4mQy1+ych0cLSBhevF4OnniNSx5EM5eixibTRnAK14KZcYbupbfqTtHoSFi25Utfx13yPX45IwQQVFmB1SJS4EOZZGBskE7lx3q1VQ7OveV996z0pW0ItMIksCtuhfQHlBsXhboc5qMraCGdRoVeM9NaLOtVDvIsxiANi+CZTQJQ3SaFLZtxGEXBKpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7lAhuFpJa+jHYzQmyUMpiK62yP4xKHO0n0ChBVeArE=;
 b=PQQhj0KnQ/GvYXGhXqtBDyIYfV5mnfxma3e7g7DtsmI2tV22VmaDwlXMRJfSIvVLFtkGvGWAYpr40c2iC6rPNwAHOVo6grGpKvfNfQUl9oiQz4WgIT8Ew53t/CaRfmrkzSSHo0V9n/aaRyNVWUn3f8t5LBCRF8SNy3kQv3DowNFACfkYW7nmePrLYfiM+403Ib89qlMycHWyPAetgsLfYPCLjMh3tFYh7q3ARF5JjcRInVJYLfHYVqNPOcCvl8KjEK6ccNUgLy3pCH2z3FAzVYfPxjvDU68+x1fGHk6M5qh6b+YC51n/RbE3wMYHA/GPrnH35u0Bt/13dwU2iRgzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7lAhuFpJa+jHYzQmyUMpiK62yP4xKHO0n0ChBVeArE=;
 b=lhYNYPnRv6euZ80ORkaFvYAiAu22B//Q7sWIcDjSE0xwJWo6/mNati1x4FAOHAzXKUfAVhON4NNXE2P3gl7pB3ccKgOyFUEk0WzCy1Xc+G58KzaEhTX/QuHn9AU21st+cTQRfS3qSbQ1dAQSEZUPnmRKiTw52LWN+ceKnYD+DWRAib6D2IoWcCozeYaJp+CT9Qao09RFXZeOHSlH925QXAx0Z9drwSaXbL+BFAb/hkYMtJYElKuXdNZ8OLoU2CefR0dECxMuUU970fJ2/mRpf4dz3n7JW1ybOcziCGgno+8GMMGz2MsPmocUlkH8lJVX6v49sUNftJaGPkHr1QBJPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 02:27:36 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:27:35 +0000
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org>
 <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com>
 <ZPWNTiAxZZh/kzew@dhcp22.suse.cz>
 <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
 <20230904182234.GB30774@sol.localdomain>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
Date:   Tue, 05 Sep 2023 12:25:58 +1000
In-reply-to: <20230904182234.GB30774@sol.localdomain>
Message-ID: <87bkehbbhs.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:10:207::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: e7979784-363b-4e71-6c9b-08dbadb7aa46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jc611jT2OgBCFjijytNvdrnlWrquBst9HCGtrChmWNv4lj8ocCHbUR5nrHv0uzXW09b69jp/OsBj8+gF1/DK9ZKyWCU0+2/K1iBwMJOKJNxM4VF/bAEn/t9r+KRSU5Z5isjg0BO+w0SgZHAN4eQoxAmlUp92xvoOU90JIWTLWc7qe7bOl8brE987Mm9KrjveR6Q6ipqkLracsULdJuLtFCchVWqXoKd1suMCm+CCPxwiA9by/OGDyQKwLv5sN76CLOkP12IlNeuASHpFyyfEzyPTkEbTlLKL6XFaL5gUV87fM9r9mLdUHMzw1kv3aTktwQvqk206ou5oHfd/Fy44tyZiWEk1hMFuxATmMk3/EmDPbWYQAIbGKU0XHoLpS0KpQBvtws4dGCOrD9UcciIZvxuH1ppn0W4oRaQWEHZPWY/0lK4QK9duBWU91DlHglaZh57wz4gHCXMq5HBtQt1ixBfyX4xYUm+30DDNc24ryFHRNt+U88Tykujy5NxYmhJ3GRVxdILwOWJUA+95yysWwZ6aDk2YNjPVAqqbmzDR7F6B67H2YLK0qUBCixkGzPPDKgc+hAxk3BN7Dem23hbNxD15AiDL6CSwJmctozXPKakrQHGvvhnVi0NntdbgKdRfSkr+Xb/doV1QRuj2nlOhlNGDKtUADlhfkoulXXq5ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(7416002)(26005)(6666004)(86362001)(478600001)(38100700002)(83380400001)(6512007)(9686003)(6506007)(6486002)(8676002)(66476007)(2906002)(66946007)(316002)(54906003)(6916009)(66556008)(8936002)(5660300002)(4326008)(501974003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0FeTUS9J1+1lhAiq2sY2hFqOJBkFMGAGomjPXupqru1LhM+ekHk7yxCAB8R?=
 =?us-ascii?Q?xv0Vngb0++yyGN05TIUZarZm+iD3yaai0NF7xQTvyBIi4xzOR1tViOJP4vj6?=
 =?us-ascii?Q?H6FwDByRoTtfOMaYeInK/7kSQbSXnl6vHAtcyxd15+Fe6M5QgKzS/1trSlkJ?=
 =?us-ascii?Q?4hjAZ6E8vXR4KZGnk08zPpcV/9Fg3nzT7hG0X8HwmPGLEUDK8XcB11Effvuy?=
 =?us-ascii?Q?HgcIYftERATjdP04ng3haUKNWxSTE6h4U8NBOpQoVX+ptAdt0zPsY2nmin+w?=
 =?us-ascii?Q?KpF/2JZqLcCHt1aIsqHRIRE7453XfmZR/2EsYTCftQdpvxaymh7z/YT14xKZ?=
 =?us-ascii?Q?FjE42tncjkgyQRLxr8/SwkhGQ2PX13lmd0QWT6tKSNFLU1Jrw1Tma4DdhXcL?=
 =?us-ascii?Q?SmeF5oonWcB8PKLNy1kfn+DNtY/MyNUzdza8I8+6T4z03qjvrK39nVpzJ9ck?=
 =?us-ascii?Q?D/hdyV/WNITYqqDWC8ABcnGOciGLo/e7eg606voKHYrA5UXJb2VrtjXAOTLj?=
 =?us-ascii?Q?UWkU8aJfsv18oxvxFx3ljHyBqlga5V4t0nmtoX/HSVhJiAgpsjlSVqJ5zYB0?=
 =?us-ascii?Q?4vwT5rUWu/d8jaLLVoFIqd5wFp0iOaO/KSoMgObW2z64/JhFwkoHAoCk+M87?=
 =?us-ascii?Q?Puq7/MIn+if20p2asBJ2xxakedYoLdEx2C8+J18lAQ3QQ2u/ANqmpteuYa0z?=
 =?us-ascii?Q?/Sfy7xx0DaE094gqTscsSRehqWl2ZLxXJpA+R5P1IuG46vHfR0kuKEfps9JQ?=
 =?us-ascii?Q?zXlyPm/o6G0ksl367U0SgadzyUPeFEBYtyBDgWTEfkla5QwiQ8NxVAeM6bed?=
 =?us-ascii?Q?fF5xkGJBacT245z9ppg+EHnrY6R0sq0elt1Ay3UXk2yNNAR9MZ7+j1Vs0bWy?=
 =?us-ascii?Q?itTjFFYtVUUAmqg66kc54FgEmSYDt1TAUHIIKODzC7nM89QI/qKjy13pke9h?=
 =?us-ascii?Q?pkSiENUOIF/hUPNKTsRNtTMPFlBv4meVhYgHFBaefz0DA1Tl3af/EQJqPJi0?=
 =?us-ascii?Q?/isy6rIV1muG7lYHC020swkx4JAfa+lnQ3NN4IE9G94D1zQwHbw85tBAIEJS?=
 =?us-ascii?Q?UhJ0TYMoV/0t1JrygPTvmjPNK0/NASGq3rG4LIj+Vbi7PLiyiwb3fnKp40K4?=
 =?us-ascii?Q?glCT+YR6NFFcbFXoyb3v3iTUCF0AbjIv6aCT5Sv+ZwoP7Wn7AjHX1piIBYdV?=
 =?us-ascii?Q?PsHC2w7IIXxJb6uKPRmLUPe0yPGo7v1fd4+AC7T4PUwPLTjvfstzPbj28vtL?=
 =?us-ascii?Q?vy62QlJbiWzeowJOrBh0S8one5IykHv6bdFH++ovA86XSmxUtgfAloi8+r0g?=
 =?us-ascii?Q?6BBKWaawV8RoCXKnZisnPnEFbfWLKPRtZhjaSmftX+cZShKvMyRMlgVXDT0+?=
 =?us-ascii?Q?EcG8kVlHmcwHIFRltrhF1KhvomUpQ3fT4Vj2O/uxs4TXYlqibw3fqM6QDZ+U?=
 =?us-ascii?Q?uV305Jt2NbeRctfCri+6SxNPfqG3TStzMRpkYDA/pRBl/0VmjOrvgRg+tA6D?=
 =?us-ascii?Q?OWyjzHQ+Zfehp4Slwazv/f431yOOVOcncriTDBqLR2uXTrSZ8RRct0j73jr5?=
 =?us-ascii?Q?JrSHOxNoF7JpwteLLb8+rXdnoVn55QRn6hYD57UU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7979784-363b-4e71-6c9b-08dbadb7aa46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 02:27:35.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azFHw31GaB5xlrs/lNTHFChq9t4G9YGwBlpjK/4vOZHSw3lwt/VHwQ3TfwwiQuidPhmxkjeAKyotXdEoyDukUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Eric Biggers <ebiggers@kernel.org> writes:

> On Mon, Sep 04, 2023 at 10:34:25AM -0700, Linus Torvalds wrote:
>> On Mon, 4 Sept 2023 at 00:55, Michal Hocko <mhocko@suse.com> wrote:
>> >
>> >       Sooner or later this will become an
>> > unreviewable mess so the value of init_on_alloc will become very
>> > dubious.
>> 
>> The value of init_on_alloc is *already* very dubious.
>> 
>> Exactly because people will turn it off, because it hurts performance
>> so much - and in pointless ways.
>> 
>> You do realize that distributions - well, at least Fedora - simply
>> don't turn INIT_ON_ALLOC_DEFAULT_ON on at all?
>> 
>> So the current state of init_on_alloc is that nobody sane uses it. You
>> have to think you're special to enable it, because it is *so* bad.
>> 
>> Security people need to realize that the primary point of computing is
>> NEVER EVER security. Security is entirely pointless without a usable
>> system.
>> 
>> Unless security people realize that they are always secondary, they
>> aren't security people, they are just random wankers.
>> 
>> And people who state this truism had better not get shamed for
>> standing up to stupidity.
>> 
>
> Android and Ubuntu both set CONFIG_INIT_ON_ALLOC_DEFAULT_ON.  I think this makes
> it clear that the init-on-alloc feature is useful for a substantial amount of
> users even in its current form.
>
> I would caution against checking the kernel config for the distro you happen to
> be using and extrapolating that to all Linux systems.
>
> Regardless, I'm in favor of a per allocation opt-out flag like GFP_SKIP_ZERO.
> There are clear cases where it makes sense, for example some places in the VFS
> where the performance impact is large and the code has been carefully reviewed.

The performance impact for some drivers is also large. This came up
recently where we've seen some large (2-3x) slowdowns with our GPU
driver on some systems with Ubuntu due to having init_on_alloc
enabled. This is exacerbated by the fact drivers can't rely on having
this option set and would generally rather zero memory themselves with
faster DMA engines or by overwitting it directly with valid data. So the
end result is memory gets zeroed/initialised twice and we have to
recommend our users turn this off anyway.

So a per-allocation flag would be nice. Of course I'm not claiming
driver code has been as carefully reviewed as VFS code so maybe there is
need for an override, but the performance impact is large. If it would
be helpful/motivating I can get actual performance numbers that show the
impact to post here.

> I don't really like the idea
> (https://lore.kernel.org/lkml/CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com/)
> of making the system administrator have to opt out allocation sites individually
> via a kernel command-line parameter.  Yes, it makes the opt out less likely to
> be abused as two parties (developer and system administrator) have to consent to
> each individual opt out.  So it theory it sounds good.  But I feel that doesn't
> outweigh the fact that it would be complicated and hard to use.  How about just
> having two options: one to always honor GFP_SKIP_ZERO in the code and one to
> always ignore it.
>
> - Eric

