Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE7754950
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGOO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGOO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:26:01 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2132.outbound.protection.outlook.com [40.107.121.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E90102;
        Sat, 15 Jul 2023 07:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz4qqwPx0XZY6X4vTQ40FQKRXK05g7/WhHC3V9wUZDlRzbpHd/F0VLvMp3H9lFmG0H547R12Kn9DBFb4Lytupoa1va8ErP8GrJcIR2jwcaXIpqfV8FvZuaj02+txotznggRjynbpLpBjExB9h6fCJKRp5bAVPwOjGgvQ3K8O/mq+rInoHqyoy0/qg3QSHgM8jTLTxKLpcjxnPviZiOLPaW0bH7Kd+s/9Q1K1c4e47djiB9jpq6hNmZXOKuDT8dvBQWDghnOpbgvGquQjMEESC31QoveUP3EyGZqFItTMSSA8fD/dTWKUVI4EFiTwDAqlXUB/aIoSbU0Xbq1tQJmiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhssay3+OnxkKxi48XeW0Eyz002WO8fxYfHH+EK5b5I=;
 b=kKtap4ESyYF2jgz6jQlM74CDbAr+i2kjlekyyr5NXTmiSCqy7eDhkUFZh8IAAfBu9/gXGtjWej1wc/tYdWZxrqhYXz5JnczyZZMWwmcLiHi5/3cIB2bPX6mLUclmbTezI14Z6yvrp67ay0GRlR3BY0Gz7Wdekby/SZR7rtVwYZIV6Qw1JGIFEX0wnCuSUN1qj+/EYwDdZAtBbaaXYO1yfttPzGKoZb3KksuH6RwjNvvwddyKCyk12iqftmOZNWBD4J6XSRQAjIM41pgr4phi4+apd1iiigr9ct8XGAGnXl/KXKKrFZ6k4xufATWLsM5cvdhGCYbLf/4ck1VQhnl2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhssay3+OnxkKxi48XeW0Eyz002WO8fxYfHH+EK5b5I=;
 b=ozVtk/3WhpFC76LcGGLiyXYPf9R+QzqcJWwTLml1A4OVblo9dx7glLKCkkjVI2ieJkNnZ9oRYoq1TXao1xRKfjwDTt/DlMaDJNE5uPeRGzFa2Czu0Zjxi9/xF8Uk8+0wgQ6JGd1EKJ9IUfYQnPM7N1STWi+/BJkenc4ZF8V0oRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1786.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 14:25:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:25:57 +0000
Date:   Sat, 15 Jul 2023 15:25:54 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     lina@asahilina.net, alex.gaynor@gmail.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, daniel@ffwll.ch,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, marcan@marcan.st, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sven@svenpeter.dev, trix@redhat.com, wedsonaf@gmail.com
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
Message-ID: <20230715152554.5b585d22.gary@garyguo.net>
In-Reply-To: <20230714135926.382695-1-aliceryhl@google.com>
References: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
        <20230714135926.382695-1-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1786:EE_
X-MS-Office365-Filtering-Correlation-Id: 00161d96-561e-4fce-a429-08db853f67ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GMZ1EhiFHlZWwU6nNlbcezlpKuJCT7FkuEf3roNYqEYx31BsjPD09v2m7QOpAKzK7WZtANnSEwMV09K9V7XgZcAfiDPxtqNQsvR+T0gnpNuicexfWFLtJJFXCt8wPl7L8cFuukTcnyu8DYgProCD6i5T+zzDXcqE/XQlWXm8v304aOqo7jrSjqMIhuwPXCPmCLR5aBbioGfo5gfMBLo46begKc6nCy4iZK6A0RVcLmEciCOOLILx0Bk1vvaYXs/Sr5WqB0FIdGbtNYabiDzrQDe6XLm0sDKg3uXUq1H3qffWLLBRq7IS7Nv28bKVZESsaCIzmaw6qakWvbURKFu/C4WEj5Ypuiiz2sTrrKpKPzS3uv7I22lGLNHCPKFitaFrzDY65mNSb0HHpTrPKG+5DhEUHoARLExvkBzKPkOzRg/A/sE/2jd/oNpMIfUyCbwoJhbvoNaMqdKUgf1jzZNv1g4JvVn+1LgvFrIEGlRf6bKFE6UMi5SSoLnv5ru3MeCT4VSdkBpUsdz+8lwG4iMIurKUzQK9Pm25jy69QsREH6pIVOX57Q+8SLwXtiJxm6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(366004)(376002)(396003)(136003)(451199021)(2906002)(41300700001)(316002)(7416002)(66556008)(66476007)(66946007)(6916009)(8936002)(8676002)(5660300002)(4326008)(478600001)(66899021)(6666004)(6512007)(6486002)(6506007)(26005)(1076003)(186003)(36756003)(83380400001)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u45pPfnXJhrbykWBCwPD93+7/xvCyJ6cgJcuvmPSuTXO1uKO3b4RuQp7T1P5?=
 =?us-ascii?Q?uYMDuBp9z/Gz6Ol4OiTolu/eh7gs/TB4dinoMXzE5Gs5v9j8Ypod75hri2n2?=
 =?us-ascii?Q?L0ziamkVjHb7CtQ7inpkuG8FzfyiBhl9PspktG+XYrVuYEEm2858Z7t4/nEr?=
 =?us-ascii?Q?i56WWvPiBF58M9PNDhrgkSIXMfUqm5ye/SGr7nMfYtOTyyKNRF/G7jRKCVjz?=
 =?us-ascii?Q?LvGZ8pof7Z7b9sb8vAky85Ub+K2EmQTLBiIc3TX2DqrdobHwkWOcLLD1RxuP?=
 =?us-ascii?Q?QYLhKrR/ty5kwKyJtzEyRlShCpW5N+ljAgIn58YIaWPeUWDexWPDblJ/OMp8?=
 =?us-ascii?Q?YTaZuKGLIB8A5xZn74uoXKr60Mu2T9t39aBBANgOD/aBcSAEUEZW0cAKZdr2?=
 =?us-ascii?Q?JQ2WRqy/ai6/S4blbGiZVNYiGAvuSF17molJihFWCDqJl/l+JvDh6ZRPkGLf?=
 =?us-ascii?Q?8jY6GWZQY67UNq3hppgpk22tZyRZDtuv+7eZ1E/cw4qwsabXZ6BtCYB7VjAP?=
 =?us-ascii?Q?sd2ng/voRIqMNNVGpiXtjXJLia/SXBvstOq6+AjQ1V3v7wcy9IDw140BUqyb?=
 =?us-ascii?Q?YJ1xddjF3UlpUqMA55znViDLiSfRHHoiTMXjoPjbyDfRflHNxDZI/aIcStld?=
 =?us-ascii?Q?UDav+3PCap/6qcA+dllcXsYibDfAETtSTF/ZzLccoXAFu4V6D3Oz9Jgptlg3?=
 =?us-ascii?Q?V0rIYZ/42aywE42G0xR2eOp8Gx9GBA4Uy/YLYq6RIPAEc8pAJyPe6Fr61FfG?=
 =?us-ascii?Q?dF/VXZy34PGrDgZ87OoIqvSeHpisqJ5F9HwQsE4JYTEt2m7JV5Noln0vEeq0?=
 =?us-ascii?Q?Oyl4l1tKPVZNE8VEN+yM9U8r6m2vOdJev9FCf467IbJZWP2sXpi7u70ePMae?=
 =?us-ascii?Q?+njA4kBQGsAkK7TKaNtpHGS6rBGAEwZ/SwmsEcBjWFUyEBmxxEvvAP4Nn5qO?=
 =?us-ascii?Q?VLga//NvnuTJTA1QMeX5Pbqi0z0tgCVsoj9VRrAGDYGjagALurS0RX3wCdhx?=
 =?us-ascii?Q?upvEu0cWZwrE8boqjObTdCtY8UC7YvG9r/FMgcjMicx/j+TVMLalT1ADm02W?=
 =?us-ascii?Q?+rgLUMrSc/9KGMGNNlFKbn0FjhLsviNoHrVFZpuKuwMVNLF0/pyi48gvUhq9?=
 =?us-ascii?Q?RoeQHT8RTvReUBSTGH49Q++7K+mc11aak38YT/7QmC+U7bIwJOMHBfhFD1aV?=
 =?us-ascii?Q?qdPYM5CB6Ya+2FnvwFrZXojWhtOLucrMf2JzvdbZVhDQyT/ScolijyNhk0AW?=
 =?us-ascii?Q?V0v01ZT1zhswIK5cHoCGuck5WHOUG8pGpGwpxZ2nhpf5O3vYhzaF5Hpm6bWJ?=
 =?us-ascii?Q?T7FQGomZ/7tU1/9EOJt2V6rl9D9VPThStAsPgptHHIMvZsMmESrvT2meTh14?=
 =?us-ascii?Q?XJg8O3hhWi7/GjrZeBmNMX9LeSeruH/tBLQ9sol/eUKa36N6sU1t7fc7yN82?=
 =?us-ascii?Q?d+rJ52B/t3pFGsVn6RqS47s152h955olzDE2tVBY0h2EEP4c22fWo6h3WjQQ?=
 =?us-ascii?Q?NMEae4rowNVDWK0+AD48JdkiPZ1Ff3C534WB203xzj5l/2XhY+XB4ItaqiCj?=
 =?us-ascii?Q?FqfO+nDJyLvN6/UNW/Q1SPpG/ULno1xU8KDpLOnC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 00161d96-561e-4fce-a429-08db853f67ad
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:25:57.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MwFlAbXH8xwIXSx1Vai1UjkfqML3vnuLmyCiau5ajRMr3kq0PwQmTqLkZJWfBgwyrNpsqpL2YAi2HDglmP+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 13:59:26 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Asahi Lina <lina@asahilina.net> writes:
> > On 14/07/2023 19.13, Alice Ryhl wrote:  
> > > Asahi Lina <lina@asahilina.net> writes:  
> > >> Begone, lock classes!
> > >>
> > >> As discussed in meetings/etc, we would really like to support implicit
> > >> lock class creation for Rust code. Right now, lock classes are created
> > >> using macros and passed around (similar to C). Unfortunately, Rust
> > >> macros don't look like Rust functions, which means adding lockdep to a
> > >> type is a breaking API change. This makes Rust mutex creation rather
> > >> ugly, with the new_mutex!() macro and friends.
> > >>
> > >> Implicit lock classes have to be unique per instantiation code site.
> > >> Notably, with Rust generics and monomorphization, this is not the same
> > >> as unique per generated code instance. If this weren't the case, we
> > >> could use inline functions and asm!() magic to try to create lock
> > >> classes that have the right uniqueness semantics. But that doesn't work,
> > >> since it would create too many lock classes for the same actual lock
> > >> creation in the source code.
> > >>
> > >> But Rust does have one trick we can use: it can track the caller
> > >> location (as file:line:column), across multiple functions. This works
> > >> using an implicit argument that gets passed around, which is exactly the
> > >> thing we do for lock classes. The tricky bit is that, while the value of
> > >> these Location objects has the semantics we want (unique value per
> > >> source code location), there is no guarantee that they are deduplicated
> > >> in memory.
> > >>
> > >> So we use a hash table, and map Location values to lock classes. Et
> > >> voila, implicit lock class support!
> > >>
> > >> This lets us clean up the Mutex & co APIs and make them look a lot more
> > >> Rust-like, but it also means we can now throw Lockdep into more APIs
> > >> without breaking the API. And so we can pull a neat trick: adding
> > >> Lockdep support into Arc<T>. This catches cases where the Arc Drop
> > >> implementation could create a locking correctness violation only when
> > >> the reference count drops to 0 at that particular drop site, which is
> > >> otherwise not detectable unless that condition actually happens at
> > >> runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
> > >> to audit, this helps a lot.
> > >>
> > >> For the initial RFC, this implements the new API only for Mutex. If this
> > >> looks good, I can extend it to CondVar & friends in the next version.
> > >> This series also folds in a few related minor dependencies / changes
> > >> (like the pin_init mutex stuff).  
> > > 
> > > I'm not convinced that this is the right compromise. Moving lockdep
> > > class creation to runtime sounds unfortunate, especially since this
> > > makes them fallible due to memory allocations (I think?).
> > > 
> > > I would be inclined to keep using macros for this.  
> > 
> > Most people were very enthusiastic about this change in the meetings... 
> > it wasn't even my own idea ^^  
> 
> I don't think I was in that meeting. Anyway,

Just for some contexts.

This idea has been discussed multiple times. The earliest discussion
that I can recall is from a tea-break-time discussion in Kangrejos 2022.

It was brought up recently in a discussion related to DRM,
and the consensus was that it's definitely a idea worth exploring.

>  
> > I don't think the fallibility is an issue. Lockdep is a debugging tool, 
> > and it doesn't have to handle all possible circumstances perfectly. If 
> > you are debugging normal lock issues you probably shouldn't be running 
> > out of RAM, and if you are debugging OOM situations the lock keys would 
> > normally have been created long before you reach an OOM situation, since 
> > they would be created the first time a relevant lock class is used. More 
> > objects of the same class don't cause any more allocations. And the code 
> > has a fallback for the OOM case, where it just uses the Location object 
> > as a static lock class. That's not ideal and degrades the quality of the 
> > lockdep results, but it shouldn't completely break anything.  
> 
> If you have a fallback when the allocation fails, that helps ...

I am pretty sure lockdep needs to do some internal allocation anyway
because only address matters for lock class keys. So some extra
allocation probably is fine...

> 
> You say that Location objects are not necessarily unique per file
> location. In practice, how often are they not unique? Always just using
> the Location object as a static lock class seems like it would
> significantly simplify this proposal.

Location objects are constants, so they are not guaranteed to have a
fixed address. With inlining and generics you can very easily get
multiple instances of it. That said, their address is also not
significant, so LLVM is pretty good at merging them back to one single
address, **if everything is linked statically**.

The merging is an optimisation, and is far from guaranteed. With kernel
modules, which effectively is dynamic linking, the address of `Location`
*will* be duplicated if the function invoking a `#[track_caller]`
function is inlined.

An idea was flared when I discussed this with Josh Triplett in last
Kangrejos, that it might be possible to make `Location` generated by
compiler be `static` rather than just normal constants, and then we can
ensure that the address is unique. I tried to prototype this idea but
it didn't seem to work very well because currently you can use
`#[track_caller]` in a const fn but can't refer to statics in a const
fn, so it's a bit hard to desugar. I am pretty sure there are ways
around it, but someone would need to implement it :)

So TL;DR: while in many cases the address is unique, it's far from a
guarantee. It might be possible to guarantee uniqueness but that
requires compiler changes.

> 
> > The advantages of being able to throw lockdep checking into arbitrary 
> > types, like the Arc<T> thing, are pretty significant. It closes a major 
> > correctness checking issue we have with Rust and its automagic Drop 
> > implementations that are almost impossible to properly audit for 
> > potential locking issues. I think that alone makes this worth it, even 
> > if you don't use it for normal mutex creation...  
> 
> I do agree that there is value in being able to more easily detect
> potential deadlocks involving destructors of ref-counted values. I once
> had a case of that myself, though lockdep was able to catch it without
> this change because it saw the refcount hit zero in the right place.
> 
> Alice
> 

