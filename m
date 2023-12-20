Return-Path: <linux-kernel+bounces-6408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F073081987D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C58B224C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7C1549E;
	Wed, 20 Dec 2023 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwJHPLXP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6614F7F;
	Wed, 20 Dec 2023 06:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F3BC433C9;
	Wed, 20 Dec 2023 06:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703052214;
	bh=caqI3j25my7HSQ3UGShfhpSfMjHkWvireTit8gq0UK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwJHPLXPF4L2EPRaveASgxrYYMqcYPglna+W1L8pljl4v70ImLPxswEbeJ2mN7oL8
	 PyZd8U16HYOfVhMCBChGJI6u6CJB9Cg2boGHSgp8AXcEA4W6Qtz7TQ1a4TcxfsoNjT
	 AnWE+BuJe73snbtGnM8zBJXjgODj79ZI0SbZ9gjM=
Date: Wed, 20 Dec 2023 07:03:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tanzir Hasan <tanzirh@google.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: removed REPEAT_BYTE from kernel.h
Message-ID: <2023122051-scholar-scribble-26da@gregkh>
References: <20231219-libstringheader-v4-0-aaeb26495d2f@google.com>
 <20231219-libstringheader-v4-1-aaeb26495d2f@google.com>
 <2023121938-stargazer-purse-0dc1@gregkh>
 <CAE-cH4p-TzH3zyJfmSg3r=fw78j8y-0t0dp-NvaLyVYAMULw1w@mail.gmail.com>
 <2023121928-propose-florist-5898@gregkh>
 <CAKwvOdnW_vZyiO3BE=Vce4OrcX4+pb6QrEFbmeya0Z+w_5d=zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnW_vZyiO3BE=Vce4OrcX4+pb6QrEFbmeya0Z+w_5d=zw@mail.gmail.com>

On Tue, Dec 19, 2023 at 03:00:22PM -0800, Nick Desaulniers wrote:
> ---
> 
> For Google specific guidance, I'll quote what they have:
> 
> > License Headers and Copyright Notices
> > Googlers should add Google's copyright notice (or a "The Project Authors" style copyright notice) to new files being added to the library if permitted by the project maintainers.
> 
> Then the relevant section of 1.Intro.rst:
> 
> > Copyright assignments are not required (or requested) for code contributed
> > to the kernel.
> 
> Shall I interpret those together to mean that the "project
> maintainers" don't permit copyright assignments for "new files being
> added," and thus Tanzir SHOULD NOT be adding a copyright assignment to
> the newly created header?

You can add a copyright header, as long as it is the CORRECT copyright
header.

Look at what this patch did, it attempted to claim that Google now owned
the copyright on the whole file, when in fact, that is obviously not the
case as a Google employee did not write the actual code that was added
to that file.

> Or shall I leave the interpretation up to an explicit discussion with
> opensource-licensing@google.com?

I think you should talk to them and get their clarification as to when
copyright headers should be added, AND what they should contain when
moving code around from other copyrighted files.

> For example, consider include/linux/sysfs.h.  It's 600+ lines long and
> contains 4 copyright assignments explicitly in sources. If we split
> that header file in half, which copyright assignments do we transfer
> to the new half, if any?

That's up to you to figure out, I'm not the one doing the work :)

Perhaps run it by your corporate lawyers to ensure that you get it
correct with what they think is right first, if you have any questions
about what to do here, as in the end, they are the ones that will care
the most, right?

good luck!

greg k-h

