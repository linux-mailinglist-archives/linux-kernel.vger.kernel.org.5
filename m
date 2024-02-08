Return-Path: <linux-kernel+bounces-58291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD484E41F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D2D28238A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB887C0B1;
	Thu,  8 Feb 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQl0RuAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C47B3E1;
	Thu,  8 Feb 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406549; cv=none; b=FV56CAGP45xSoqluT3/PQCKL2lRuLmTUo0KlV5lf/WNto+GXij6PS88NNB83LA3KW/NwYZyEU4qTi/AuYVrWh/o1J99CVThzz3HfRSOCPittg/+RyymIC9Kvu0YySZD9rnMIhGj6/B6f2Q6M9pkYKh/NXyLJrqe6KDxBqintrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406549; c=relaxed/simple;
	bh=Oyd+0UxjHh1jKnK11zlznPLxJVZq1YhY3TWT2JBQK4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES4wRzeksWQoN14x9VG5yafU0nrRUNSWBhf/WVulSSULDRJbJ6bzcgkRpagQe9xrEzlQEgdl1U9p8rrBrN2Qp2FoJI8yoIqJGoksQjRwKUmthhB0hMVKg6py87qSVCVCmbzK/CgCiI56e0+v+wYM1xGy+H2s7bS3g3aAeIT1i/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQl0RuAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68F7C433F1;
	Thu,  8 Feb 2024 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707406548;
	bh=Oyd+0UxjHh1jKnK11zlznPLxJVZq1YhY3TWT2JBQK4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQl0RuAMe+WdOE/LDDy3xatZEz8RXFLJ2liVNPHOOif2Ui/V0aymQ7CZRV2jT1OQ4
	 beAM6RNDfy49jWgzm09Plsu7hram53aUgPfAOmrMdLTy4y5qPfb2PUkZuPWA05JgMP
	 07+IOiEeobpR363RjzTmorEP9HVwp8jiipWIWjI0=
Date: Thu, 8 Feb 2024 15:35:45 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
Message-ID: <2024020859-lusty-ladylike-29d4@gregkh>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
 <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
 <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>

On Thu, Feb 08, 2024 at 01:53:20PM +0100, Alice Ryhl wrote:
> > Is some sort of `Debug` implementation useful?
> 
> Leaking pointer addresses in logs is frowned upon in the kernel, so I
> don't think we should include that.

s/frowned upon/forbidden/ :)

Along those lines, you all are tieing in the "I want to print a pointer,
so hash it properly before I do so" logic from rust like we have in c,
right?  Ideally you'd use the same logic if at all possible.

If not, that probably needs to be done so that you don't accidentally
start leaking things.

thanks,

greg k-h

