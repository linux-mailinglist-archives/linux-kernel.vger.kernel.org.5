Return-Path: <linux-kernel+bounces-35773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1476839652
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CE28614D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC07FBD4;
	Tue, 23 Jan 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W19+QUPn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1E60893
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030693; cv=none; b=I1KU4jWWPLYBaqMtx8y3cGbDIUTDA4F5f3c/xOm13G51Ut9ASP35Dj0trwRaTF2Vj61oIe1vbUDFjRP2Sn/9Sk9UaZhJiwwLjPD7JUrfPJ0922LLyM9aOVvEEdnrXXoMX3hlBjd9Ah5nBruy13swacg655Urq5czmOV/dy2QmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030693; c=relaxed/simple;
	bh=G0vvDDoof+vP2uhA9zjhNoseUNL3kPStIcJ0SqGI5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNVA1ITU+hG+uzJPvaJtyPyK6E2ci0Dh2HRcwlTf8cXFbbo006XFMzzPtBcFxMSPanEVOL167RRwmsbvtDw+xY0vvRTPphTbU1m6kzyWNHGQlkhhR16Q3hSQRb/3vggLnwf4fmrHIpfiRxpP18OUqO2UegQ+U+n/eq2nfnWOobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W19+QUPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706030690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37DXASSNR87lle+b09IUrlUqS4JJgsnqsvmxnwmD62o=;
	b=W19+QUPnOJzi5f2tqhuxzHLs0rDrEHhxxsTw/ovKbtMo3G5eUY7hlbBmA5gxksc694A01v
	ZXkDZ9lFUloYVfm+QFJFrQ4fUVucOwZD7K/QnFE+jVUN8jcMpQRsRNO2dZtyBv/I1RQQdt
	44TFuBPkN2iulGGaf9pNWlZrCaFZbLg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-qapvhaV8P0Kejou3GTmoQg-1; Tue, 23 Jan 2024 12:24:48 -0500
X-MC-Unique: qapvhaV8P0Kejou3GTmoQg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b6c2a5fddso213300266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030686; x=1706635486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37DXASSNR87lle+b09IUrlUqS4JJgsnqsvmxnwmD62o=;
        b=hzdggUbPOHiSZ7/bL1Xvxs95LEX0tRu7Annd5eFl+gv0MT0yKhDLvRgoZWo3+jQe3L
         cAf6URDjgHQDqLkzjTy9aJDFeGsfVCG+2lXE+QRoheeupJtGR4ZSae/CmvfAkDXrtRzY
         6J1KdkHFKL2BI1NHM1BklO3/XSYVVFxeets0sZpGRg9nwLhhC56Ne4RUEHvEdqBy0aft
         wQMwu4tDuHOcjHWcuWZuRVHBFAytzbS/CyMBo7ErmDzF6yPKmZ1JWtauR9l96tD1dMRx
         to0DFpdC8+GIdwbr4MjrQ9SILZQjOwcL2r3K1kkWi0SKotbudTE2gLN1wEgrOP6WlFra
         D02w==
X-Gm-Message-State: AOJu0YwkGEvTY/3gqSbiIdfGph3CALI/11fMgOiFstqQ6czgLshXj8ut
	qkGB4cDr7taSOyjIUDDtbynLoQkqsgi/Egjo7LCl5uZA7MSJ0l3aq54hxxjDSWSFzVBERZ17HfK
	DKm1KeWCXq4GK1O/PkXn6x1ZY01Pjo6Xomc1EVQo7jevaAnW7ew4hxAh1Z32Q+g==
X-Received: by 2002:a17:906:3686:b0:a2d:222d:2c76 with SMTP id a6-20020a170906368600b00a2d222d2c76mr113374ejc.12.1706030685843;
        Tue, 23 Jan 2024 09:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGsC+QeNmROh1wvugPSuVwubL4KphHbAu/5q1igozq6ZIItQG/EysGQKAz1Fc3h8xb7i2/Ng==
X-Received: by 2002:a17:906:3686:b0:a2d:222d:2c76 with SMTP id a6-20020a170906368600b00a2d222d2c76mr113365ejc.12.1706030685533;
        Tue, 23 Jan 2024 09:24:45 -0800 (PST)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id tz5-20020a170907c78500b00a30dcbd4254sm466180ejc.119.2024.01.23.09.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:24:44 -0800 (PST)
Date: Tue, 23 Jan 2024 18:24:42 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Message-ID: <Za_2WuQh9vr2Na7S@pollux>
References: <20240122184608.11863-1-dakr@redhat.com>
 <2024012252-attempt-tables-e3fc@gregkh>
 <Za7uampZiG2IP8dE@cassiopeiae>
 <2024012251-geriatric-morphine-a275@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012251-geriatric-morphine-a275@gregkh>

On Mon, Jan 22, 2024 at 03:12:04PM -0800, Greg KH wrote:
> On Mon, Jan 22, 2024 at 11:38:34PM +0100, Danilo Krummrich wrote:
> > On Mon, Jan 22, 2024 at 11:35:29AM -0800, Greg KH wrote:
> > > On Mon, Jan 22, 2024 at 07:45:57PM +0100, Danilo Krummrich wrote:
> > > > Add functions to convert a CString to upper- / lowercase assuming all
> > > > characters are ASCII encoded.
> > > > 
> > > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > > ---
> > > >  rust/kernel/str.rs | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > > index 7d848b83add4..d21151d89861 100644
> > > > --- a/rust/kernel/str.rs
> > > > +++ b/rust/kernel/str.rs
> > > > @@ -581,6 +581,16 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> > > >          // exist in the buffer.
> > > >          Ok(Self { buf })
> > > >      }
> > > > +
> > > > +    /// Converts the whole CString to lowercase.
> > > > +    pub fn to_ascii_lowercase(&mut self) {
> > > > +        self.buf.make_ascii_lowercase();
> > > > +    }
> > > > +
> > > > +    /// Converts the whole CString to uppercase.
> > > > +    pub fn to_ascii_uppercase(&mut self) {
> > > > +        self.buf.make_ascii_uppercase();
> > > > +    }
> > > 
> > > How are you handling locales?
> > 
> > For ASCII only? Not at all, I guess.
> 
> Ah, this is ascii, yes, sorry.  So this is a replacement of
> toupper()/tolower() in the C api?

It's not a replacement, but it's kinda analogous to that, since the CString
module is mainly used for interoperability with kernel APIs that take C strings.

And I say mainly, because there is no other string implementation in kernel
Rust, hence it might be used independed of whether interoperability is required
or not.

> 
> > However, std::slice::make_ascii_{lower,upper]case() doesn't seem to handle the
> > extended range, which tolower() / toupper(), according to _ctype[], does. Do
> > you mean that?
> 
> You should support whatever those functions in the kernel support today,
> otherwise why add it?  And why not just call the kernel function to be
> sure?

Well, given that CString serves as interoperability layer for kernel APIs that
take C strings, I agree that seems natural.

On the other hand, CString and CStr are designed after the implementation in the
Rust std library and there were requests already to align those functions as
well.

We also need to consider that simply wrapping tolower() and toupper() would make
slice::make_ascii_{lower,upper]case(), str::make_ascii_{lower,upper]case(),
char::make_ascii_{lower,upper]case() and CString::make_ascii_{lower,upper]case()
inconsistent. The former ones already only consider 'a' to 'z' and 'A' to 'Z'
respectively.

As already mentioned in [1], it might just depend on whether we see CString only
as interoperability layer or as the way to deal with strings in kernel Rust in
general.

Just to clarify, personally I'm not worried about whether we consider the
extended range in this specific case or not. I think it's more interesting to
generlly figure out if, for such modules, we want the caller to expect C
bindings to be called or C logic to applied respectively, or if we want the
caller to expect that everything is aligned with the Rust std library.

[1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust

- Danilo

> 
> thanks,
> 
> greg k-h
> 


