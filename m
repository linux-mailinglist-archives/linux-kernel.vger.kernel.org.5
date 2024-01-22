Return-Path: <linux-kernel+bounces-34058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE98372AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD43B1F272DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A83F8E7;
	Mon, 22 Jan 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qrhe2/lN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317C3E48B;
	Mon, 22 Jan 2024 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952135; cv=none; b=NKdf+YKKD8fJ7CnDMzEvpQ2uBHnmjyHJb77e07xaouS7ZLFBoaNz9w2CoMsAa6KZs+2SHD4bzv5PvLsDYWvm/vNPb3NzTDrlDfWjUdo4yjFvqXDdGdqLdp1rlegGqllzI+ELkVCZdLUA28a7NuzLDg3cSHyx7GTYONRH9IGe9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952135; c=relaxed/simple;
	bh=1lXOq5qDkUOa83Aa7WVT5wfgzQWPcBZAWgjgHtQo6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYC5gbeHsxB5f+HP4kQ0gfcEMJf1BK7qSqfkwNoieGBhDDvgyDeNOPK/38dyZ4psKL3XVYk0J/Od93iirgR554pza33HAQGLo2De/dLp4FVWdPOS0IlMa4AMmYT+DY6EQIwS4GIHnQipLhBNCV7RbS7+wycCMUa3Q7C+1ZR70CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qrhe2/lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EFCC43390;
	Mon, 22 Jan 2024 19:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705952134;
	bh=1lXOq5qDkUOa83Aa7WVT5wfgzQWPcBZAWgjgHtQo6dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qrhe2/lNlzMbLaFZRMOAm/C/oaHx6uGK9m4wem30PrUcGh2FkSk/9KmYD/7wXd0Rm
	 hU2tILOfmfuoJSIe1D80A/EbKhu8S/FVCC/+K0bK4PE6KHya9Yj/E3Y1xvMuX/6H7o
	 nJ1RxGKqPq5YmhTEMp806hubvEpG/NQoQNKJVRO0=
Date: Mon, 22 Jan 2024 11:35:29 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Message-ID: <2024012252-attempt-tables-e3fc@gregkh>
References: <20240122184608.11863-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122184608.11863-1-dakr@redhat.com>

On Mon, Jan 22, 2024 at 07:45:57PM +0100, Danilo Krummrich wrote:
> Add functions to convert a CString to upper- / lowercase assuming all
> characters are ASCII encoded.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/str.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 7d848b83add4..d21151d89861 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -581,6 +581,16 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
>          // exist in the buffer.
>          Ok(Self { buf })
>      }
> +
> +    /// Converts the whole CString to lowercase.
> +    pub fn to_ascii_lowercase(&mut self) {
> +        self.buf.make_ascii_lowercase();
> +    }
> +
> +    /// Converts the whole CString to uppercase.
> +    pub fn to_ascii_uppercase(&mut self) {
> +        self.buf.make_ascii_uppercase();
> +    }

How are you handling locales?

thanks,

greg k-h

