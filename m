Return-Path: <linux-kernel+bounces-21372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424A828E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9B1F24E29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9DA3D569;
	Tue,  9 Jan 2024 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAfY5LVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852473D554;
	Tue,  9 Jan 2024 19:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0E4C433C7;
	Tue,  9 Jan 2024 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704830215;
	bh=zkk7Wcpg9ZpGH6Lw1adVpVRSHJH154UMwD2xNTu+esQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAfY5LVmydoWsfif0YRuDxNyqPVMq5BIALeS+EjEqg05vSLShesDcwNMnjxXD5L/n
	 WXgj6+e8D9sT749flzBMnmftXD6hwkHglXYKTU4M22PyLVQ0xGzUNPG2ehrdoltncr
	 lKiI0fttVlPni+Y062WjDOi9wkeqT4UxbKKA0w7FvpQGCNOF3B4i5q0Pxl14Ak0ABe
	 /TAI6rlvRl8cEUB8wwjFgvd/y2TgPYeBl7lEEYe4YUQym6nhV/CFha3zNKdztW2r78
	 i7DV4kdbQrPo+pxj4Dx/pO2AVdIxZijU9kHtSH4s4tL+OcEATs6ZCYxMWpKgNw6maQ
	 sIqjze7Tyievw==
Date: Tue, 9 Jan 2024 12:56:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Compiler Attributes: counted_by: bump compiler versions
Message-ID: <20240109195652.GA1253215@dev-arch.thelio-3990X>
References: <20240109133633.1103876-1-senozhatsky@chromium.org>
 <20240109153249.GA205400@dev-arch.thelio-3990X>
 <CANiq72kjHCh-inyv1aU=eNca1-+E0_85MGU-8qbZZtzbC_VwOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kjHCh-inyv1aU=eNca1-+E0_85MGU-8qbZZtzbC_VwOQ@mail.gmail.com>

On Tue, Jan 09, 2024 at 08:42:24PM +0100, Miguel Ojeda wrote:
> On Tue, Jan 9, 2024 at 4:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > It is still possible in theory for this feature to make clang-18, as the
> > release/18.x branch is not scheduled to be cut until the fourth Tuesday
> > in January, which is two weeks from now. I don't have a good feeling for
> > how close that pull request is to being mergeable though, so this is
> > fine for now. I assume this won't go to Linus immediately so we would
> > have time to change it if necessary.
> 
> Yeah, I was wondering about the deadline too. If LLVM's `-rc1` is the
> latest time possible to merge it, we can wait the couple weeks (which
> are conveniently the merge window) and I apply it afterwards with the
> result :)

If I understand the doucmentation at [1] correctly, the first round of
testing starts with -rc1 and ends with -rc2, so if the feature is not
merged by -rc2, it won't make that release cycle. I think counted_by
might be a hard sell even after -rc1 because the feature is not exactly
small but it is also not expansive (it is relatively self contained
from what I can tell). So I think your plan is reasonable.

Another alternative would be to split this patch in to three distinct
patches, not sure if that would be overkill for this though.

1. Update the clang review link from reviews.llvm.org to github.com
2. Update the GCC version from 14 to 15.
3. Update the Clang version from 18 to 19.

The first two patches could be picked up immediately and the third one
could be sat on to see how the review and acceptance process works out
over the next couple of weeks. Up to you/Sergey. Thanks for taking a
look!

[1]: https://llvm.org/docs/HowToReleaseLLVM.html#release-process-summary

Cheers,
Nathan

