Return-Path: <linux-kernel+bounces-34254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDD483766C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2351F26718
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F112E62;
	Mon, 22 Jan 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAU+r2Is"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FE1095B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963123; cv=none; b=dlN1hu6plPGxYDwrudsM67M/ft8XHmW+1tNBrBFZ00N2neDC1f1//bz4MtY44oo2r+dTK/WEb3uvhElViAsP6ozX9PccXAlIkyER6uAp1cGylCGh4eZl6veryma56ewQCiUbfKPdIz0lwr2Clpb3Aqx2YgqopzYjYQ6Yq+uiO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963123; c=relaxed/simple;
	bh=hZdkVnfwFjmDlBOTViB0mMy+VBl8pl2Yr2tuAbWx04U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfclRMSBZVGn4zFB2Cn0gFbmXwO8ODA8PqWkPv9ObhORAZ6HRlOjnng+tGZhHogJiuEV8BMvaa503O5eUNrOaRSHxYZwG1bAFjHiNGekh5oEteZNMgfq9cMx2AF05n1IsQJ8GIuCCp2ExKvx/dzHIiT+/Tn3DQtHBGH6PYqWvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZAU+r2Is; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705963120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFRdHTL6Ly9q0NNwJrY/4XvTerjAxGUKqujlL2DaAm8=;
	b=ZAU+r2IsTd9KTatFc44zndyVV6TADBtGJ2QkoVEdkI/544CRjCLQJFr7P6WIgoBH28pV8J
	kx0O7NuuIm7XyGzO0M0jDRbUe3SXKp+85Ys6+mwv2qr6TfUiCOM3iOfdd9jC0k2jwdVFD2
	WdHvsax5TCc5pqf+8me7VSYVFJGaLNQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-ULhsw5O9OGun2GPcnqDq4Q-1; Mon, 22 Jan 2024 17:38:38 -0500
X-MC-Unique: ULhsw5O9OGun2GPcnqDq4Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3367e2bd8b0so2706323f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705963117; x=1706567917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFRdHTL6Ly9q0NNwJrY/4XvTerjAxGUKqujlL2DaAm8=;
        b=qeM9WsCVq18z9MrWuHZOTtrJvbocX28ONOkK+kiM0ZIWedm0JlBxmtbM/Y509v7qrr
         Sh1Onfx6DEcU/K3YEJzVeWwMwMDUyBjZbVywyw8eJnaqZxh9MfT2d8no5hdos4OUEDPH
         kXMOsfIiNPPf59m5StPVdSpQL9LHzvIsls/kw3SUKREJDWyo76LewV3taU9lJS4hIeLD
         AdCXaJVT9hFBe4K9sSAnO0IMpTg0GecRYmlaJZTdv3zypItONe4sLZ4cKmt3lhrxXxif
         9/Bpi2eiIEefqDAhyw5ZL+tydf5eCDrHg0XWQdOjX2sQhsRDaS072RyC/FkwjojWU8Gv
         ZmVw==
X-Gm-Message-State: AOJu0Yw/ssObdxyiUW/LisnfFIDrF8PEh66ren2W3VT+ns2qJE8wmBCS
	r+/RXNAuCEwfJ3Rh3aJx8OznR5+GsnNAg9czpUn+Ix6salKpsLeD+dKlrbYq3rSmerAqOyeMF89
	QVI0SqnMfmv3GjQd5QAuvB6QiTYtVEFf7HRb7z+4N2HFjYLsyn5G3hIWUGYlRcA==
X-Received: by 2002:a05:6000:71a:b0:339:23b3:124c with SMTP id bs26-20020a056000071a00b0033923b3124cmr3058613wrb.135.1705963117788;
        Mon, 22 Jan 2024 14:38:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFKwwS9qaywjZeX13lqLHKwLGkjf6Lj30G70HSph11PaDETHfEPqYly1VbL3iFzzIP3Dse9w==
X-Received: by 2002:a05:6000:71a:b0:339:23b3:124c with SMTP id bs26-20020a056000071a00b0033923b3124cmr3058597wrb.135.1705963117482;
        Mon, 22 Jan 2024 14:38:37 -0800 (PST)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d4251000000b00337d84efaf7sm10959936wrr.74.2024.01.22.14.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:38:37 -0800 (PST)
Date: Mon, 22 Jan 2024 23:38:34 +0100
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Message-ID: <Za7uampZiG2IP8dE@cassiopeiae>
References: <20240122184608.11863-1-dakr@redhat.com>
 <2024012252-attempt-tables-e3fc@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012252-attempt-tables-e3fc@gregkh>

On Mon, Jan 22, 2024 at 11:35:29AM -0800, Greg KH wrote:
> On Mon, Jan 22, 2024 at 07:45:57PM +0100, Danilo Krummrich wrote:
> > Add functions to convert a CString to upper- / lowercase assuming all
> > characters are ASCII encoded.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/str.rs | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 7d848b83add4..d21151d89861 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -581,6 +581,16 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> >          // exist in the buffer.
> >          Ok(Self { buf })
> >      }
> > +
> > +    /// Converts the whole CString to lowercase.
> > +    pub fn to_ascii_lowercase(&mut self) {
> > +        self.buf.make_ascii_lowercase();
> > +    }
> > +
> > +    /// Converts the whole CString to uppercase.
> > +    pub fn to_ascii_uppercase(&mut self) {
> > +        self.buf.make_ascii_uppercase();
> > +    }
> 
> How are you handling locales?

For ASCII only? Not at all, I guess.

However, std::slice::make_ascii_{lower,upper]case() doesn't seem to handle the
extended range, which tolower() / toupper(), according to _ctype[], does. Do
you mean that?

- Danilo

> 
> thanks,
> 
> greg k-h
> 


