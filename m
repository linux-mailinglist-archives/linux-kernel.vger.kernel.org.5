Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C27AE7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjIZI1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjIZI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:27:29 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2104.outbound.protection.outlook.com [40.107.121.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53BBFC;
        Tue, 26 Sep 2023 01:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6P+B8q4ey/47TLLqjNpxjF+8lliyLpMafGtIkwCVBbxYE1fYaNov7LiO+3iV3fI9UKK/pin5grBvfkxJ3q8SvyODPVxqJa2fbQHvU4TahCLQj7LBbbfeq0XFrWWQQIWl3QR6JX8HKTx8HDaGaSIeG1bhl+JW1xZquxIUollyferZHd68Cl/R9UH6jEHTrd56CbVKEd7lBlAdr3DghQl1FVlhElnQUVs8qX8jRme+nf+pTsvZTMqb4TAugBrNHMd+qARcpCeegSG5UyNgaiOsY3sURwE3PGSzTu89/ryr8zNZ9y33+x1ennSn+0EOxUmVw/dFGZFNik8woR4NSx9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AcxoBKS9YjbEwv2THSG18VHhGponiMjbqvC8lSyuqo=;
 b=oV8BD0GvmWPWbgk95No0uzNex7t4ZbePtRnZ4KyXWChSm306LVUWb3Lwp+G3vVGchJaG89UdlVlOihr2YpyZ5e4r1th/nZK6w3IVxjmoI2LO0fmZ+VQBIpxK0XY/syWIlnPO42MSO50NoGAvzPiLxZ+bbCpzVH+fTUjmahyxGcWjyHTpxdDEJHbJOkklrq5hHuwCIRUUFfc44BXwUn9cK/LTUUBiEYXYeu+f7R3PiVP49PNGYBHJFXKHDI0kl7FoorGh9DH1B34kqdaU1T9oan+2URB4TD4oe0oQ/jVXuyWWVU7WwKiQKy9I506pGrjp7sVETOmG39hjzDOPh8g5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AcxoBKS9YjbEwv2THSG18VHhGponiMjbqvC8lSyuqo=;
 b=gZYBEqab+cSXpmbGlZc47FQHTsWrWYib8ELPDuYQtQoR7axVy5zERNcrNCBO/LwUBHGB4D2fxq4fzRwurVyHMD5ckWSdPQ3sTssc89qRFMDhZbdvQr1Iuq2BwFZGbSURj7dMWEldbCHVl11+SEWx8XFAwqNKWVwNWmLVVUm5498=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2589.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 08:27:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 08:27:18 +0000
Date:   Tue, 26 Sep 2023 16:26:59 +0800
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <alice@ryhl.io>,
        Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <20230926162659.6555bcdc@gary-lowrisc-laptop>
In-Reply-To: <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
References: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
        <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
        <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
        <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
        <ZRHWqbvYlXBXEOh-@boqun-archlinux>
        <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
        <ZRIB0hXNvmJtmyak@boqun-archlinux>
        <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
        <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
        <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2589:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a46c79-e123-4930-d20f-08dbbe6a657a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P9xHlr9DbMEeRcMXQI9oSyEyK32FBr2F6tVMfJEtEJSM/+tVaiulyva4zq7t8Deqhax8E/V5trCpmucrH9v2bBLLBGm/p1gIOQwB/G5p5aMsE4Dcjh0IVGwrocTgclLRXGjldVJ+e8nYuGgwlWaAkTkt9GBA1UiUpJnrWXGEDltux4mN0QejhLNJAe7i4JwijFVKbblUzaej5XNLNOD3jKnQjV0KYNY5LimiPN9R70eHD/WFwckV0LnKL6M/BgHgyV47+EXqr39FVvJV+dI/QOYoHAd6frhIJRQ/hMXoqQkvDDNz7l2wbLlqxJLi8DBTmM5b5i7FefBNOX5/+P968tjBoRTxl4fIiW8/M7UjvAXrTDhGCNDT7tb7k53ttcVys2u4BChvJyHN2BsRO4U4xdo2b5nSWuRUsBHNRdjISI6hknflkIsJWJS9qs746tbLucA0PFvlBsAN7XMcaDHY5RkPmqCwmhuELwpXmf5aywdBAdJfFw8VLzxoicPmsXwUjxB1BZdZXHfDYVkaj+Poy26OhIm/kL9uwb2QO50C6tvsds/5vuEj1XwwVtW0Rd/om8s7zUftB6lQlhOrf/6u1Q19fg6ptRTMyYc2Vlk8aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(136003)(39830400003)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(6916009)(66946007)(66476007)(66556008)(54906003)(316002)(478600001)(38100700002)(6666004)(7416002)(2906002)(33716001)(86362001)(8936002)(4326008)(8676002)(5660300002)(26005)(83380400001)(1076003)(6486002)(53546011)(6506007)(9686003)(6512007)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zztt07cjG5xoME4gX35X6n8aUckzEeny5vodkWXEJkULultUmKbm2pRcEmv0?=
 =?us-ascii?Q?SGpwvQG9RV5UE5FSHzF0RDZl/iYnonVy5vrq/llzKHnymyo42mtphOQU8D8V?=
 =?us-ascii?Q?NrvcNz7cImh3i05hs5xtzvpt6qanhqt8GvBMYFpehStckkfvwik9blEK0lVC?=
 =?us-ascii?Q?HPYLJwV7oHBELCB4YZ3ynN5ZY0wLUaxHo+igrRhuAzo2vCFO/rKYl73j6ZXK?=
 =?us-ascii?Q?5jhOiTCWnSaoImDzC1q+ikyzd3Q8gyT3KnFuGHFXTqEMt6cE1AzUfDi/lTR/?=
 =?us-ascii?Q?EueCYx+JL51nqK+VN+LOoieWgAf220VbLEo6dH0xxpLK6B9/kj3J6UA7+jI3?=
 =?us-ascii?Q?H/Gzuyy0Lt0iLFJEfXWnv0fYjemuNgLFcvR34lFnJDUxpQtwM5uX+DzIr6fZ?=
 =?us-ascii?Q?sqFTv1kPOjGChoXRGcdEcy3ib+niUVFtSBezmtFEMi0YkeYk1nAQu/HftynL?=
 =?us-ascii?Q?/08Kc1CtP5fdUhJYi4MXys834xhx7lyHPD1Gbn3BtDvr+lwEOiAFKOJdPbbQ?=
 =?us-ascii?Q?AWH2b6ehIP0qz2m5Bi7bCHpmAttYDEnGVd3IRpt2JprvDufLI5qmClhOrPoc?=
 =?us-ascii?Q?Titb0Ea1gnkh9rruKvyYdOmXsqd6di1qYxwrWHJhXtAWbv8KfUPZUbQIvCzk?=
 =?us-ascii?Q?y+y1jILnSrau6GY37flkpPhyjDW8L732ofALT+yfFeP/1PGAf9dOFIXNkGwZ?=
 =?us-ascii?Q?5NRuSHdcUfU9pHvJVHB5+2SLe+w9a2C6RRqtB5X4Z7KaPydkwD+7oh6EE52/?=
 =?us-ascii?Q?B0dPj8SAz5hP+ub3Ru8Z72FifkXI8OEsnscS3sQGO0dIOl/s6yHPSzvR/98z?=
 =?us-ascii?Q?zMD0/1q+8esirkd1QtpzUQDmveI5inul3g5h0jhessgLLeEE9YrwMAKA7r4z?=
 =?us-ascii?Q?xLRjHFbdvtcC94ZhGe8aEVANGBvmVEf0xE/6y3FL5w+j5LAOm7Zzu0w+2xAT?=
 =?us-ascii?Q?HzdAApxS/UY3t8pSTm/EHX1i6D35FhFXFHzSQ+xyHIcnHRfmbLMOhqF+HRFV?=
 =?us-ascii?Q?cRmm2qartBucXwyYkpXzUVQaoOo8odEs92J/u3QGqGwdcpDJ5yoyUlAXAqcK?=
 =?us-ascii?Q?wdhSBaPi+D5Xhsto8W+EDAygiccJf81HvTnthPi7MJn+4c9GUgEusMkxzT4l?=
 =?us-ascii?Q?1b2GqcZpnX/NP6MawubSjbjGNQdFyOts9pTtlR+1VKg9OjDOTHMZxwJ7jcZF?=
 =?us-ascii?Q?I0HOT/cLBRlCmsEkiVIZivnec7HVEykyANFRLLyRgJ0+nyShFXMJrp8uhGgZ?=
 =?us-ascii?Q?XvlOKC7P3/aM2vEFYCnndR9cdOZUaj9Nlcn7JePTn2YChIO8TM5OxDNVLIOv?=
 =?us-ascii?Q?JeQ/Cvkewj5xUae3zjA+7QWrVtO3Nw5K2P0LnVbZieUnFIss3Vc3GyBFWwdd?=
 =?us-ascii?Q?5OeQsRUbB0QHqTC4lIZvOgTWbJYBQKA9/e2SpY/NBhGsSwWiBbF+OUSEGwXV?=
 =?us-ascii?Q?RsGsiIw0BMqqP7BlIf2pP/A3xGj6ji3benNvPtx6AJ2E2c1EahoV7qYCMhor?=
 =?us-ascii?Q?hz7lhWQ2L6SE46ZE7/nZpKs5QCdY05x0N5T4wKcdfP+whAEBT6NFD80INGbl?=
 =?us-ascii?Q?ZnGuC5s6B/HRyi8cagC9Zi+UP0FC6OK/f3EwDgYf?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a46c79-e123-4930-d20f-08dbbe6a657a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 08:27:18.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghqLyDtl2lWAvVAYGZhoMbxHV0dWfEMCjXW+xNalCQhN9END2kYg05HTlmVavsTSgtmZ4FswDVRbDm/EBqvRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 22:26:56 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 26.09.23 00:02, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 11:58:46PM +0200, Alice Ryhl wrote:  
> >> On 9/25/23 23:55, Boqun Feng wrote:  
> >>> On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:  
> >>>> On 25.09.23 20:51, Boqun Feng wrote:  
> >>>>> On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:  
> >>>>>> On 25.09.23 18:16, Boqun Feng wrote:  
> >>>>>>> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:  
> >>>>>>>> ```rust
> >>>>>>>> struct MutatingDrop {
> >>>>>>>>          value: i32,
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> impl Drop for MutatingDrop {
> >>>>>>>>          fn drop(&mut self) {
> >>>>>>>>              self.value = 0;
> >>>>>>>>          }
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> let arc = Arc::new(MutatingDrop { value: 42 });
> >>>>>>>> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> >>>>>>>> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2  
> >>>>>>>
> >>>>>>> More precisely, here we did a
> >>>>>>>
> >>>>>>> 	&WithRef<_> -> NonNull<WithRef<_>>
> >>>>>>>
> >>>>>>> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> >>>>>>> `drop` to get a `Box<WithRef<_>>`.  
> >>>>>>
> >>>>>> Indeed.
> >>>>>>  
> >>>>>
> >>>>> Can we workaround this issue by (ab)using the `UnsafeCell` inside
> >>>>> `WithRef<T>`?
> >>>>>
> >>>>> impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> >>>>>        fn from(b: &WithRef<T>) -> Self {
> >>>>>            // SAFETY: The existence of the references proves that
> >>>>> 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
> >>>>> 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
> >>>>>
> >>>>> 	// SAFETY: see the SAFETY above `let ptr = ..` line.
> >>>>>            ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> >>>>>                .deref()
> >>>>>                .clone()
> >>>>>        }
> >>>>> }
> >>>>>
> >>>>> This way, the raw pointer in the new Arc no longer derives from the
> >>>>> reference of `WithRef<T>`.  
> >>>>
> >>>> No, the code above only obtains a pointer that has provenance valid
> >>>> for a `bindings::refcount_t` (or type with the same layout, such as
> >>>> `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
> >>>> it by reading/writing will still be UB.
> >>>>  
> >>>
> >>> Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> >>>
> >>>       	pub unsafe fn from_raw(ptr: *const T) -> Self {
> >>> 	    ..
> >>> 	}
> >>>
> >>> , what we have is a pointer to T, and we construct a pointer to
> >>> `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> >>> gets away from provenance? If so, we can also do a sub(0) in the above
> >>> code.  
> >>
> >> Not sure what you mean. Operations on raw pointers leave provenance
> >> unchanged.  
> > 
> > Let's look at the function from_raw(), the input is a pointer to T,
> > right? So you only have the provenance to T, but in that function, the
> > pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
> > have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
> > question is: why isn't that a UB?  
> 
> The pointer was originally derived by a call to `into_raw`:
> ```
>      pub fn into_raw(self) -> *const T {
>          let ptr = self.ptr.as_ptr();
>          core::mem::forget(self);
>          // SAFETY: The pointer is valid.
>          unsafe { core::ptr::addr_of!((*ptr).data) }
>      }
> ```
> So in this function the origin (also the origin of the provenance)
> of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> Raw pointers do not lose this provenance information when you cast
> it and when using `addr_of`/`addr_of_mut`. So provenance is something
> that is not really represented in the type system for raw pointers.
> 
> When doing a round trip through a reference though, the provenance is
> newly assigned and thus would only be valid for a `T`:
> ```
> let raw = arc.into_raw();
> let reference = unsafe { &*raw };
> let raw: *const T = reference;
> let arc = unsafe { Arc::from_raw(raw) };
> ```
> Miri would complain about the above code.
> 

One thing we can do is to opt from strict provenance, so:

```
let raw = arc.into_raw();
let _ = raw as usize; // expose the provenance of raw
let reference = unsafe { &*raw };
let raw = reference as *const T as usize as *const T;
let arc = unsafe { Arc::from_raw(raw) };
```
