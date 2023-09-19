Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8847A6A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjISR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjISR4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:56:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C5A6;
        Tue, 19 Sep 2023 10:56:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C8EC433C7;
        Tue, 19 Sep 2023 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695146192;
        bh=oTw5IJcJ7n9tX0eMkW/N8Wz1esHYNZcEC42vs2lJXvE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=XLFPSlnvSySUE75ZgJvK7r8LybpP+ITsN9JtmBGN6EMLqQ2W1A7Ej1jHgZg+f8J86
         RZPgO15umwMmwDOfWjUoLHbUcxxJkDLD7EtjO2CyQYaT2AHNgMajuzciDetfw1hKNX
         HqQqI3N5SreMRdLI43zCtjAfTgRWJSVMSqqmsKw7MvXP1AjkJrW3Y2K0rfa6IOyg+W
         UZhRvKxUeKOTEbcuIGDSIa1wQkoY9MdVjUBP5hgBnOeCQxiGF3nvd1jlbDblEOXUnn
         Vl7gRXEjSWgSLt5s/0OlNOpmkV7LiNq4PU5hVbOaHwEK/QLU23W5CCw1xzhsP+wRNc
         OeCwbk6WH+wBQ==
Date:   Tue, 19 Sep 2023 10:56:30 -0700
From:   Kees Cook <kees@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Matteo Rizzo <matteorizzo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_00/14=5D_Prevent_cross?= =?US-ASCII?Q?-cache_attacks_in_the_SLUB_allocator?=
User-Agent: K-9 Mail for Android
In-Reply-To: <782b131a-c3b9-7679-824a-70625c966def@intel.com>
References: <20230915105933.495735-1-matteorizzo@google.com> <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com> <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com> <ZQiLX0W2Tcr+wdJT@gmail.com> <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com> <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com> <782b131a-c3b9-7679-824a-70625c966def@intel.com>
Message-ID: <F5445DE2-CE12-49F8-BF8D-D63ECF6BCC33@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 19, 2023 9:02:07 AM PDT, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>On 9/19/23 08:48, Matteo Rizzo wrote:
>>> I think the whole "make it one single compile-time option" model is
>>> completely and fundamentally broken=2E
>> Wouldn't making this toggleable at boot time or runtime make performanc=
e
>> even worse?
>
>Maybe=2E
>
>But you can tolerate even more of a performance impact from a feature if
>the people that don't care can actually disable it=2E
>
>There are also plenty of ways to minimize the overhead of switching it
>on and off at runtime=2E  Static branches are your best friend here=2E

Let's start with a boot time on/off toggle (no per-slab, no switch on out-=
of-space, etc)=2E That should be sufficient for initial ease of use for tes=
ting, etc=2E But yes, using static_branch will nicely DTRT here=2E



--=20
Kees Cook
