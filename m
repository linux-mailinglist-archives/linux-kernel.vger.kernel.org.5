Return-Path: <linux-kernel+bounces-68982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9698582F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967F9284960
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6624130AF9;
	Fri, 16 Feb 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t13bw/xR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B91130ADC;
	Fri, 16 Feb 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102202; cv=none; b=X2Y85ub8iLC7F5UIbuzP1XtRE7PGWD10UHWzaGvMJCnyJ6TJbcftVnouzaNJsM8tBN9z8TGkL+MpALA8hwd2rcXjQ0DqM5yO2k4vnCTpxIeVEcfQ46U0w2oP4SKAQ4/z9w+WHdK/k9A/iPcPloMMrs6etCaNvFIqJfYzMhuCN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102202; c=relaxed/simple;
	bh=SiMGhpq8b0aD4618CGwGq2cc1u00rf6CQNT2TIldlcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpQu8h8q+/mTdhgOrkeVmJXJSCIBCC9yA3zp9oLD+KFCn8yptrBhf8AdZVwyCedA1vhCEEqkZwijy+RYZQr8OR3HLyHX194jYSrKkRLtW8CafwLlbq+r5ATf/vdaBijRlLTofMG+amf+WwI6E4PpPhhkzi4fYKHZ8DTp6x6C9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t13bw/xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA8CC433C7;
	Fri, 16 Feb 2024 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102201;
	bh=SiMGhpq8b0aD4618CGwGq2cc1u00rf6CQNT2TIldlcc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t13bw/xRU9jFyduUY9Bns8DBfpplXuB0QbjWinrIUc8qlcrD86wb2FNtSjpBw9j29
	 iWvaqLf4CSz9pkLvwiuB3WMTw/hguX+0UHCJoSn0S6zGKpzU7Z4dMRufrRDPgqBZ4g
	 wEJ0nnFsa6dy794NHVgcdmVHVQc+nOlgtAVkAmVJ06oJcr84IT7or8yz0yZpwZ9Z/+
	 mOLCm93vnyFsexzgtsDacq2u/bJFRpPE2bhTDoI2tJ4rbYU8r7lhD6/0eDnua1wMtK
	 /gG7iLWgLz/IS/lLMb5fGb8d3N9jiZDtqQ6K93d9xY4TWZCNx7kEUjj1qGdjyq6z/I
	 6/COYMhlV+uGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1D3DCE0B70; Fri, 16 Feb 2024 08:50:00 -0800 (PST)
Date: Fri, 16 Feb 2024 08:50:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: cdev: avoid uninitialized variable dereference
Message-ID: <a3bc8b0f-7f14-4b46-a432-d3688104f11a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240216125959.3766309-1-arnd@kernel.org>
 <CAMRc=MdBbzff5BppY4Hjwfi=SnmYopnFxg1AX4QsGt3Y+-g60Q@mail.gmail.com>
 <14ab7b63-b2c0-41e3-8104-da5515b379be@app.fastmail.com>
 <c6290c26-8d06-4032-8599-83556d44687c@paulmck-laptop>
 <20c18087-dc18-4671-b4ac-c54f7fe4ad21@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20c18087-dc18-4671-b4ac-c54f7fe4ad21@app.fastmail.com>

On Fri, Feb 16, 2024 at 05:17:06PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 16, 2024, at 16:51, Paul E. McKenney wrote:
> > On Fri, Feb 16, 2024 at 03:04:14PM +0100, Arnd Bergmann wrote:
> >> On Fri, Feb 16, 2024, at 14:19, Bartosz Golaszewski wrote:
> >> > On Fri, Feb 16, 2024 at 2:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> >>
> >> >> From: Arnd Bergmann <arnd@arndb.de>
> >> >>
> >> >> The 'gc' variable is never set before it gets printed:
> >> >>
> >> >> drivers/gpio/gpiolib-cdev.c:2802:11: error: variable 'gc' is uninitialized when used here [-Werror,-Wuninitialized]
> >> >>  2802 |         chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
> >> >>       |                  ^~
> >> >> drivers/gpio/gpiolib.h:277:11: note: expanded from macro 'chip_dbg'
> >> >>   277 |         dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
> >> >>       |                  ^~
> >> >>
> >> >> Use dev_dbg() directly.
> >> >>
> >> >> Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU")
> >> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> >> ---
> >> >
> >> > I seem to have beat you to it[1] and my patch doesn't change the log
> >> > message so I'll apply it instead of this one.
> >> 
> >> Ok, thanks. I thought about doing this, but could not
> >> figure out which of the RCU primitives to use.
> >
> > I will count that as a bug against RCU's documentation, but I am not
> > sure how to fix it.  Thoughts?
> 
> I didn't really try at all, I just figured I could avoid
> thinking about it by using the device pointer at hand.
> 
> I'm sure the docs would have told me if I had bothered to look.

OK, a low-priority bug against RCU's documentation, then.  ;-)

							Thanx, paul

