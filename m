Return-Path: <linux-kernel+bounces-34284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB9837790
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B00D1F24DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051954B5C6;
	Mon, 22 Jan 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZdMB3Kot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F434B5A9;
	Mon, 22 Jan 2024 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965130; cv=none; b=gho24qxPL4X50anZ8Cb0yuVGHpBXIsZJZhDlNbdCV0vNO8Fen4jKVpUuVApYs/H/BADt+RmAMJ5cr7IWZANZtrn0J9JF5PXwIoKk9Og6nwYCWzRXGIhQK3YjSgapq++6vizVraWJSdDU+XDMaPbKjJ1WvNWVxw1ltuXkfDT6ZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965130; c=relaxed/simple;
	bh=gXtBNeC7Ai3fVJS+hGdCDxSf4KkmEkXm40cCAWIaHpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEPqJzetMb0R3fa/21JELt99ri0FtY0pL7VnVHAJdGp/nE70fyDY1tcNgaFLPLXxmirC9yTm9uiAKMZdZlCP+sXakosHAPtIBsLICr4eW7GfR2qRA3pnq0TJE5gAyq+1AHA+BEQOXf37yJtEf+CQPFI/2dvDchA9clX67lXCO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZdMB3Kot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E349C43394;
	Mon, 22 Jan 2024 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705965130;
	bh=gXtBNeC7Ai3fVJS+hGdCDxSf4KkmEkXm40cCAWIaHpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdMB3KothuLg+aYqJPR4hiFvif0anai2aMHcenceojYi22XHCqo9i7R9CSEUcFCkO
	 RBtKZlPGV+C9Mduio+ldoghJ7V6in39Lof1jz1aIeaJQP6WW8R4afPgKhkHSiOSHRi
	 Si68motDSI+dDSSkAtGzHBIrJnucRjUcqAr1Oc7A=
Date: Mon, 22 Jan 2024 15:12:04 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Message-ID: <2024012251-geriatric-morphine-a275@gregkh>
References: <20240122184608.11863-1-dakr@redhat.com>
 <2024012252-attempt-tables-e3fc@gregkh>
 <Za7uampZiG2IP8dE@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za7uampZiG2IP8dE@cassiopeiae>

On Mon, Jan 22, 2024 at 11:38:34PM +0100, Danilo Krummrich wrote:
> On Mon, Jan 22, 2024 at 11:35:29AM -0800, Greg KH wrote:
> > On Mon, Jan 22, 2024 at 07:45:57PM +0100, Danilo Krummrich wrote:
> > > Add functions to convert a CString to upper- / lowercase assuming all
> > > characters are ASCII encoded.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > >  rust/kernel/str.rs | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > index 7d848b83add4..d21151d89861 100644
> > > --- a/rust/kernel/str.rs
> > > +++ b/rust/kernel/str.rs
> > > @@ -581,6 +581,16 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
> > >          // exist in the buffer.
> > >          Ok(Self { buf })
> > >      }
> > > +
> > > +    /// Converts the whole CString to lowercase.
> > > +    pub fn to_ascii_lowercase(&mut self) {
> > > +        self.buf.make_ascii_lowercase();
> > > +    }
> > > +
> > > +    /// Converts the whole CString to uppercase.
> > > +    pub fn to_ascii_uppercase(&mut self) {
> > > +        self.buf.make_ascii_uppercase();
> > > +    }
> > 
> > How are you handling locales?
> 
> For ASCII only? Not at all, I guess.

Ah, this is ascii, yes, sorry.  So this is a replacement of
toupper()/tolower() in the C api?

> However, std::slice::make_ascii_{lower,upper]case() doesn't seem to handle the
> extended range, which tolower() / toupper(), according to _ctype[], does. Do
> you mean that?

You should support whatever those functions in the kernel support today,
otherwise why add it?  And why not just call the kernel function to be
sure?

thanks,

greg k-h

