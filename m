Return-Path: <linux-kernel+bounces-68905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C143E8581BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F7283AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C4C12FB05;
	Fri, 16 Feb 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCvBItEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6112F5B2;
	Fri, 16 Feb 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098717; cv=none; b=JrNimouaOSi4/s/2ABVNHPFi3/2f2GCMEXoicNpSjGT/BO7UvaCvnOQf/doiPnlG4HB9uEgFwuodJbkGNbVn76ikMTmZFmr3hpCMbVDgcwAmUKSaL9yyytNMb0Y/47gM0yYGmP8eVsCjjwa03Yo+4uQa/07XFD26hBxkSpZ6XMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098717; c=relaxed/simple;
	bh=fWMKxBO0fPH9y+BU98ESj2z/A6lChdT3LPjmK4IL36A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3DBBsZ34jNAjMdOFCsQIKuTR/1ZCUTLxyH1gj6hULHgvu7eutx9bg1C29fC8bjdCUxFfFtFgxRbvw1hUTd9BrmM33aAV2R4pFfJuxcxoz/ekLTTpgxzWR8ID+gSFLUzWqa18AqhnaHvQbvGPyRYOnRoYmCWRqEgZfbcEYwnQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCvBItEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98905C433C7;
	Fri, 16 Feb 2024 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098716;
	bh=fWMKxBO0fPH9y+BU98ESj2z/A6lChdT3LPjmK4IL36A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XCvBItEqD7EqI8/MmaowEbXueSX7rwbd4eQ4HxgTKRHpWoDKGYvR7yi/JaXcBs4sx
	 eTmLH+UErL5BpDG6hqzls0w4iMQQNSEW14ioHVx5zdH6QEds7l617U3iaiR1Qm5R/9
	 inNNdskjG+oc9kpriSmH3s2H9SL78GH4RuvPExZnDlBkK73JCsGOU8fY8ZCF6wG1eB
	 i7QYGWUoxAjyhlSKUiXM0MTBt4zRELfBPXCqKndQMJovISeidz79gjNmwLkq1VK5La
	 IBZVTDC5mIqOp4aL0wcgIz+ICd0bfVDhMEm1jkEgl/8BsJsmBzgWWHky/lMuO2rgDX
	 mCCZ5XlcaGL5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 332E9CE0B70; Fri, 16 Feb 2024 07:51:56 -0800 (PST)
Date: Fri, 16 Feb 2024 07:51:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: avoid uninitialized variable dereference
Message-ID: <c6290c26-8d06-4032-8599-83556d44687c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240216125959.3766309-1-arnd@kernel.org>
 <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
 <14ab7b63-b2c0-41e3-8104-da5515b379be@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ab7b63-b2c0-41e3-8104-da5515b379be@app.fastmail.com>

On Fri, Feb 16, 2024 at 03:04:14PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 16, 2024, at 14:19, Bartosz Golaszewski wrote:
> > On Fri, Feb 16, 2024 at 2:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> The 'gc' variable is never set before it gets printed:
> >>
> >> drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is uninitialized when used here [-Werror,-Wuninitialized]
> >>  2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
> >>       |                  ^~
> >> drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
> >>   277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
> >>       |                  ^~
> >>
> >> Use dev_dbg() directly.
> >>
> >> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >
> > I seem to have beat you to it[1] and my patch doesn't change the log
> > message so I'll apply it instead of this one.
> 
> Ok, thanks. I thought about doing this, but could not
> figure out which of the RCU primitives to use.

I will count that as a bug against RCU's documentation, but I am not
sure how to fix it.  Thoughts?

							Thanx, Paul

