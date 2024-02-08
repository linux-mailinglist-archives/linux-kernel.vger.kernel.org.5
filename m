Return-Path: <linux-kernel+bounces-58317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506ED84E490
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4ED7B23F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1097D41F;
	Thu,  8 Feb 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaOt+WKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBB7CF3C;
	Thu,  8 Feb 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408003; cv=none; b=JSPerapgcdRrRkcHuvVx6ZZlfUPOG80dDOiTqP3LgSnCN+786QHBGOMJS2nYVY6yCDBbnlrRxSzeRH1ykBCog8DbkihGgIrVVRHRl7eRjDUjWocoGe3slhqIWrl1W9TQlqD33zKbww2HbXjhHolHPva+YG45GViCZcQQE16BIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408003; c=relaxed/simple;
	bh=NFml/Mcl7A/mi1oKcXg7Sdv20bTJSW+STEYiKv1z0BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj2umXupOLkRUGPJ1KuK+3FcGNCsGHBhhDtwGqa1t3k8++yVLmj8VhbMEyaO6weqCutPcswCAOFOdU7YewdxygQUCKJb2A+8m6+/wNPqhQNpdeWtTItrTFLdFnTsrsLraATQvxVHaWXqynpzj7R4Ju81Kvo6NsgeMIuECCLTncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaOt+WKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACC7C433F1;
	Thu,  8 Feb 2024 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707408002;
	bh=NFml/Mcl7A/mi1oKcXg7Sdv20bTJSW+STEYiKv1z0BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaOt+WKQW+SW6lNAF6OPmoLeYLoCx8RbhR361T89bM/NJRaG4fEuWEYkUp9RyalNf
	 CsYypFCB8PYAi5YuT63EpakdpjsfqnFixCkDacd0UGczHXywv0Mb/CNQipCCIDRUq4
	 5OrlajV8eSZoqOAbERNuEkUq9BaUCR7eljjwRTw4=
Date: Thu, 8 Feb 2024 15:59:59 +0000
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
Message-ID: <2024020849-smog-mothball-8723@gregkh>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com>
 <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
 <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
 <2024020859-lusty-ladylike-29d4@gregkh>
 <CAH5fLgikdGGdjEUxyMWjkfHbRmvtMavwHFDwRC+4GVt46qmHWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgikdGGdjEUxyMWjkfHbRmvtMavwHFDwRC+4GVt46qmHWw@mail.gmail.com>

On Thu, Feb 08, 2024 at 04:41:52PM +0100, Alice Ryhl wrote:
> On Thu, Feb 8, 2024 at 4:35 PM Greg Kroah-Hartman
> > Along those lines, you all are tieing in the "I want to print a pointer,
> > so hash it properly before I do so" logic from rust like we have in c,
> > right?  Ideally you'd use the same logic if at all possible.
> >
> > If not, that probably needs to be done so that you don't accidentally
> > start leaking things.
> 
> I don't know what the status of this is. For anything I've added, I've
> just made it entirely impossible to print addresses, hashed or not.

Even better, thanks!

