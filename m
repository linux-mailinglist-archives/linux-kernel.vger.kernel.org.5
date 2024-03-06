Return-Path: <linux-kernel+bounces-94223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82534873B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D928B2549B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3A13A86A;
	Wed,  6 Mar 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8xe60q1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDC137904;
	Wed,  6 Mar 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740970; cv=none; b=oasRNsGNkT+H1D7ehUTapwJGAhI2txZ4TrMa7zSMsEMiDPmEPLvyTPmoUahG3paR2jYFxbNZ0RwuPzOHeO61sCVvRux89xuoUaphtHktUSxaRvM+LH3gvWJzmG5t9oVGYl6sAGg3Iyy69WfNNYi0LsXEj0duywXDx7UFqLv+SXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740970; c=relaxed/simple;
	bh=IG8ko0VxIq5wqmccJeKPMEw+wW9fETH2/U5QZozNYlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0JtDgeVlbpx/H+X+VkurTltPk5RIl8b3Qo97dUiwbAPr23F7Ei6X9/k9W5YjIJ65YbzRhvVaLvge0EEwQy6NKFJCT8dqW8wwjCmL4Gbjs2gFIM9jMP4UWHyWQDnLgbDj4fjNn8fHhRz4Rtab1LCd/LuV1bk78EJ1tmHGnE4478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8xe60q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C5AC43390;
	Wed,  6 Mar 2024 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709740970;
	bh=IG8ko0VxIq5wqmccJeKPMEw+wW9fETH2/U5QZozNYlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8xe60q1U4UDSVgM19Kfn8IQ3KbWk/TOY6ykEVfiCuow4FBb811BhgFZHXYqTw+YA
	 sYRIZuRtcj6NbVqPUlHFiDW4wcm4FrxATY1DCxlQWv7zhalsJcuLYAn6zFyZiG3aMx
	 23TSIPOGxLIwvRCHaJg1R5Zepuiz0rkQ65Y6O/0AwpAnzxV1HdwX9CbeEzcNWhQYlw
	 lgoZdmkHPO3vIcOjRwzV7va+8B7wjJe30bs3PwYULC788JvXpIvY+NW56Yjk4U/aDI
	 S8Vqit6socqN0kKKV2ILZlfOyWLcmpj3r6uG4v9Oy+YOVWB0FjnOdKC6sJKxTDW3TQ
	 ubsCZETCragQQ==
Date: Wed, 6 Mar 2024 08:02:48 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jiangfeng Xiao <xiaojiangfeng@huawei.com>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	gustavoars@kernel.org, akpm@linux-foundation.org,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	nixiaoming@huawei.com, kepler.chenxin@huawei.com,
	wangbing6@huawei.com, wangfangpeng1@huawei.com,
	douzhaolei@huawei.com, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
Message-ID: <20240306160248.oxeblpwa5zvplmgw@treble>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
 <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
 <20240305175846.qnyiru7uaa7itqba@treble>
 <Zeg8wRYFemMjcCxG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zeg8wRYFemMjcCxG@shell.armlinux.org.uk>

On Wed, Mar 06, 2024 at 09:52:01AM +0000, Russell King (Oracle) wrote:
> On Tue, Mar 05, 2024 at 09:58:46AM -0800, Josh Poimboeuf wrote:
> > This is an off-by-one bug which is common in unwinders, due to the fact
> > that the address on the stack points to the return address rather than
> > the call address.
> > 
> > So, for example, when the last instruction of a function is a function
> > call (e.g., to a noreturn function), it can cause the unwinder to
> > incorrectly try to unwind from the function *after* the callee.
> 
> I suppose this can only happen in __noreturn functions because that
> can be:
> 
> foo:
> ...
> 	bl	bar
> ... end of function and thus next function ...
> 
> which results in LR pointing into the next function.
> 
> Would it make better sense to lookup the LR value winding it back by
> one instruction like ORC on x86 does (as you mention) rather than
> the patch you proposed which looks rather large and complicated?

That patch *is* an attempt to make it match ORC's behavior.  What
specifically looks complicated about it?

-- 
Josh

