Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC547AF0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjIZQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjIZQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:35:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE52BF;
        Tue, 26 Sep 2023 09:35:14 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a645e54806so1121117466b.0;
        Tue, 26 Sep 2023 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695746112; x=1696350912; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n9VUrp3V7HhkEVK8SdoBuIWv58SmS3/mbAJKD44Sc9g=;
        b=E0Aqtm4IViZ0XpafzoDDSxs0ML+JWfHCOJxZFebC4pQmEOCc83YEj4A9RzsRGrVQ1x
         DCBCisVUt/GLXXty+8Px5VOdYIk2BhVgjZNQ7TaQfWZLbl+ugP0furDpcCpuY8wmZw+o
         J1TNDDM5gf2r81OOv47nGG0mGPPFi7H4NDc3yns8G2JIML/bdR73otTTEeUp7G/7c7xi
         zaIQM1RmjUdPInwV8zGEDuThkSbQgvZGzZSEoxOwi88eRB4ldpSP12eGf3Aj/fOcyjYS
         FCqqU+9fSwyO7s+2XXGOd9W0/TiBmi2IIYVEuO8C743PBlYAEZCoEw+Q0seXeLUvyY1n
         WDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746112; x=1696350912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9VUrp3V7HhkEVK8SdoBuIWv58SmS3/mbAJKD44Sc9g=;
        b=B/u83Jt1ENy4Ek1z88OXnKlQfQtw/sfEahlEEyVsgyEjisuxFq59RhTy7xWFuzbAb/
         DklAWwedA/l/6DwSnsIZIWiaUbucKTg97ypOcwX+CiatpfPbP6yLH7mkMeDyK+Lcry4F
         uO6I7mVfyiz7WZpheOai3Vkk3WXS9n3EBCuJF4suaqjEWH8KAbqnwXOU2kezIIa4Q3IO
         RNKvGFXXAi4n/FMT0exot2R8cmkJvjOGJUhCJOFGsZyMfLi1DAYcMjaajqRf41tRztNb
         5+eRT/e8nGYDeZT2B+AMjE0QpTGJAiKGGfrUwfsd5wj9ZPHmas4arHJHM6oadyPjs2G6
         nQHw==
X-Gm-Message-State: AOJu0YwtLwBrJD56ndZvC/khhcUJZs31UJAT8sWNFCuOsbSagGAegQFs
        xl0cejaiQh87ijHjwECFH44=
X-Google-Smtp-Source: AGHT+IEDLWkIJgDZ0H2XXbmFyqUel2oZalabN2K27PwNVCODwC/UED4KoXwMx6pVZlzANJ10qMJSnA==
X-Received: by 2002:a17:906:2d7:b0:9b2:8323:d916 with SMTP id 23-20020a17090602d700b009b28323d916mr5182924ejk.17.1695746112168;
        Tue, 26 Sep 2023 09:35:12 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090639d200b00982a352f078sm7904773eje.124.2023.09.26.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:35:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3823227C0054;
        Tue, 26 Sep 2023 12:35:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Sep 2023 12:35:09 -0400
X-ME-Sender: <xms:PAgTZSjx2OXrVQY8Y57C2hd0q4Qf5mwAT1LzWGF9ncPoLhVjp0CJzA>
    <xme:PAgTZTC63g7_elbSXTlI2GsGl42eSxlQfFTMXX2yJYU6QzKPalxDBPtGjYOCU8aIQ
    mQWhU9NeClnbzTnhg>
X-ME-Received: <xmr:PAgTZaG-vKvDc_owcuQOh7Besoi7dk3MZ-7Q8NrX1w0TmqkgGgo5gjAstoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtgeehvefghfegtdektdegtdfggfeitefgffetteetieeihfdtkeffieel
    vdeigfenucffohhmrghinhepphhtrhdrrghspdhruhhsthdqlhgrnhhgrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:PAgTZbQ88VF4AVOl2DEDirtKBBgOBEDV-HOZ49csbEGMepMLDbpvKA>
    <xmx:PAgTZfxUdOpCEb_WxhewKb-l2GvV4-LBJCtdWdhqxJ9qG2DueDYSLA>
    <xmx:PAgTZZ4zGblsopQnkZqHfyNkz29B3jKFCt_fp8lcg968yqXDC-ACWw>
    <xmx:PQgTZd5p-xOW0KvirkyjoNZhe2iOCNJcZ_0o-lmRJDxoD7DR5DHIlg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 12:35:07 -0400 (EDT)
Date:   Tue, 26 Sep 2023 09:35:06 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <alice@ryhl.io>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRMIOsi6-GjFaYLW@Boquns-Mac-mini.home>
References: <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
 <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
 <20230926162659.6555bcdc@gary-lowrisc-laptop>
 <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home>
 <CAH5fLggUPQtNjLg6BnYHcLmefuHdJpg0_eGVgX+dARUTRHexsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggUPQtNjLg6BnYHcLmefuHdJpg0_eGVgX+dARUTRHexsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:41:17PM +0200, Alice Ryhl wrote:
> On Tue, Sep 26, 2023 at 5:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
> > > On Mon, 25 Sep 2023 22:26:56 +0000
> > > Benno Lossin <benno.lossin@proton.me> wrote:
> > >
> > [...]
> > > >
> > > > The pointer was originally derived by a call to `into_raw`:
> > > > ```
> > > >      pub fn into_raw(self) -> *const T {
> > > >          let ptr = self.ptr.as_ptr();
> > > >          core::mem::forget(self);
> > > >          // SAFETY: The pointer is valid.
> > > >          unsafe { core::ptr::addr_of!((*ptr).data) }
> > > >      }
> > > > ```
> > > > So in this function the origin (also the origin of the provenance)
> > > > of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> > > > Raw pointers do not lose this provenance information when you cast
> > > > it and when using `addr_of`/`addr_of_mut`. So provenance is something
> > > > that is not really represented in the type system for raw pointers.
> > > >
> > > > When doing a round trip through a reference though, the provenance is
> > > > newly assigned and thus would only be valid for a `T`:
> > > > ```
> > > > let raw = arc.into_raw();
> > > > let reference = unsafe { &*raw };
> > > > let raw: *const T = reference;
> > > > let arc = unsafe { Arc::from_raw(raw) };
> > > > ```
> > > > Miri would complain about the above code.
> > > >
> > >
> > > One thing we can do is to opt from strict provenance, so:
> > >
> >
> > A few questions about strict provenance:
> >
> > > ```
> > > let raw = arc.into_raw();
> > > let _ = raw as usize; // expose the provenance of raw
> >
> > Should this be a expose_addr()?
> 
> Pointer to integer cast is equivalent to expose_addr.
> 
> > > let reference = unsafe { &*raw };
> > > let raw = reference as *const T as usize as *const T;
> >
> > and this is a from_exposed_addr{_mut}(), right?
> 
> Integer to pointer cast is equivalent to from_exposed_addr.
> 

Got it, thanks!

> > > let arc = unsafe { Arc::from_raw(raw) };
> > > ```
> > >
> >
> > One step back, If we were to use strict provenance API (i.e.
> > expose_addr()/from_exposed_addr()), we could use it to "fix" the
> > original problem? By:
> >
> > *       expose_addr() in as_with_ref()
> > *       from_exposed_addr() in `impl From<&WithRef<T>> for Arc`
> >
> > right?
> >
> > More steps back, is the original issue only a real issue under strict
> > provenance rules? Don't make me wrong, I like the ideas behind strict
> > provenance, I just want to check, if we don't enable strict provenance
> > (as a matter of fact, we don't do it today),
> 
> Outside of miri, strict provenance is not really something you enable.
> It's a set of rules that are stricter than the real rules, that are
> designed such that when you follow them, your code will be correct
> under any conceivable memory model we might end up with. They will
> never be the rules that the compiler actually uses.
> 
> I think by "opt out from strict provenance", Gary just meant "use
> int2ptr and ptr2int casts to reset the provenance".
> 
> > will the original issue found by Alice be a UB?
> 
> Yes, it's UB under any ruleset that exists out there. There's no flag
> to turn it off.
> 
> > Or is there a way to disable Miri's check on
> > strict provenance? IIUC, the cause of the original issue is that "you
> > cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
> > there is no other alias to the same object". Maybe I'm still missing
> > something, but without strict provenance, is this a problem? Or is there
> > a provenance model of Rust without strict provenance?
> 
> It's a problem under all of the memory models. The rule being violated
> is exactly the same rule as the one behind this paragraph:
> 
> > Transmuting an & to &mut is Undefined Behavior. While certain usages may appear safe, note that the Rust optimizer is free to assume that a shared reference won't change through its lifetime and thus such transmutation will run afoul of those assumptions. So:
> >
> > Transmuting an & to &mut is always Undefined Behavior.
> > No you can't do it.
> > No you're not special.
> From: https://doc.rust-lang.org/nomicon/transmutes.html

But here the difference it that we only derive a `*mut` from a `&`,
rather than transmute to a `&mut`, right? We only use `&` to get a
pointer value (a usize), so I don't think that rule applies here? Or in
other words, does the following implemenation look good to you?

	impl<T: ?Sized> Arc<T> {
	    pub fn as_with_ref(&self) -> &WithRef<T> {
		// expose
		let _ = self.ptr.as_ptr() as usize;
		unsafe { self.ptr.as_ref() }
	    }
	}

	impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
	    fn from(b: &WithRef<T>) -> Self {
		// from exposed
		let ptr = unsafe { NonNull::new_unchecked(b as *const _ as usize as *mut _) };
		// SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
		// guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
		// increment.
		ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
		    .deref()
		    .clone()
	    }
	}


An equivalent code snippet is as below (in case anyone wants to try it
in miri):
```rust
    let raw = Box::into_raw(arc);
    
    // as_with_ref()
    let _ = raw as usize;
    let reference = unsafe { &*raw };
    
    // from()
    let raw: *mut T = reference as *const _ as usize as  *mut _ ;

    // drop()
    let arc = unsafe { Box::from_raw(raw) };
```

Regards,
Boqun

> 
> Alice
> 
