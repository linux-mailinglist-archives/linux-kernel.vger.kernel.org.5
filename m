Return-Path: <linux-kernel+bounces-148725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1488A86A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132AAB27E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0B1422A2;
	Wed, 17 Apr 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO/dmyZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D16CDB7;
	Wed, 17 Apr 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365387; cv=none; b=UqONvl2avZHywsnRpQH4/06d5I1S9ntePs5eIrRkFHEIFLQXteOjKdXQYXEdaPRcxvMLJohJ0xkXfi1tCEEsQsc3oiwPxWAgjljFGuYpUUFSQshwMBUg6pNt/ywtzaYmas+tX7KnyFY+RrkdOzvvzrbsgmlz4y/tmycgCkPBBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365387; c=relaxed/simple;
	bh=R0aOa5afohn6PF2KyxeEWUALvw+VN/NOVHLEmXjYd7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvOmAAoUGvhm3+fTb+y2LCE2b184E8GVq49RRpUuaj69o7k2kYmt3GkPga5pHdJxXW6dUTx6WENQ0wjxxGoEhJ9BOIuKM05tEOXOCG391jmausW9BrYglqdkRi0PueIZBlwaj+auLFL22+vCD1AvAiIKw7gYFpn52TyYauGhBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mO/dmyZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C6C072AA;
	Wed, 17 Apr 2024 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365387;
	bh=R0aOa5afohn6PF2KyxeEWUALvw+VN/NOVHLEmXjYd7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mO/dmyZlngK558z58lqzuTXZG64y9BMcfZ/nKbNC/qQWJYvZtTocZeDAw2vNExDZV
	 opIUtKY5xG/XGbSG68CNNhvZQ00jqwrcyQTzDXkXr4Yydj2iyKS2diVWa2l2SZPItA
	 rP4Ct3+bDBgUHqduBUbD6ZDM6tZ+EsTz/GA7fn5wMBt+Gk1kHhc07XgsxKZRlmZ7zY
	 AR/CsRgZREQOYAMydC8hgsk/943wFVp+TO/mjOqXcaD0rhn5ADs0/C17xjmocSF4KH
	 HgmeYmqIWbE98ooTs9Bq13bRLVXtzFUQkZ4fztwAI6sPu5igUbPuN9bNbdR46m4kIZ
	 10WpHcMJSovMg==
Date: Wed, 17 Apr 2024 15:49:43 +0100
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] stm32mp1xx based targets stopped entering suspend
 if pwm-leds exist
Message-ID: <20240417144943.GA2399047@google.com>
References: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
 <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
 <256e3d3c-d43f-4bd6-9a7b-50fc870e75e4@leemhuis.info>
 <20240416121519.GS2399047@google.com>
 <dqibafuvizvltkblfizxvgrl3744lpxbwgdjid5ekxsju7gmxm@fys22ievmgz5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dqibafuvizvltkblfizxvgrl3744lpxbwgdjid5ekxsju7gmxm@fys22ievmgz5>

On Tue, 16 Apr 2024, Uwe Kleine-König wrote:

> Hey Lee,
> 
> On Tue, Apr 16, 2024 at 01:15:19PM +0100, Lee Jones wrote:
> > On Tue, 16 Apr 2024, Linux regression tracking (Thorsten Leemhuis) wrote:
> > 
> > > On 06.03.24 09:18, Uwe Kleine-König wrote:
> > > > On Wed, Mar 06, 2024 at 08:05:15AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > > > [...]
> > > 
> > > Jakob confirmed it helped in the bugzilla ticket. But the patch since
> > > then didn't make any progress afaics -- or did it and I just missed it
> > > in my search?
> > 
> > [...] 
> > 
> > > > ---->8----
> > > > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > Subject: [PATCH] leds: pwm: Disable PWM when going to suspend
> > > > 
> > > > On stm32mp1xx based machines (and others) a PWM consumer has to disable
> > > > the PWM because an enabled PWM refuses to suspend. So check the
> > > > LED_SUSPENDED flag and depending on that set the .enabled property.
> > > > 
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218559
> > > > Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > > [...]
> > > > ---->8----
> > 
> > Did you submit this?  I don't see it in LORE or in my inbox.
> 
> Yeah sure, apply it using:
> 
> 	curl -s https://lore.kernel.org/all/2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb/raw | git am --scissors -s

Nice try!

> :-)
> 
> If you don't consider that suitable, I can create a patch that is easier
> to pick up.

Yes, please submit it properly.

-- 
Lee Jones [李琼斯]

