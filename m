Return-Path: <linux-kernel+bounces-111317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B019C886A97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B89B1F22481
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8503CF79;
	Fri, 22 Mar 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlZfA/Ok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C27E6;
	Fri, 22 Mar 2024 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104191; cv=none; b=ME3zBfCJ2a350Uc4X11U0QxFk89WmRjm2hoynV0tN2+vLO8NsEgSsGWhlCr8QlriWqkYzLhz9CUS67pSoegYwuS0KWzk8CJ5r8Q7ca/UDKJD6TVScFcvfg/iNU+/NDIaI14bbSVLr8xh6p9oIr3i8qQrtUteLRLrgOoGEuue3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104191; c=relaxed/simple;
	bh=gIU75Sab8N34yflwxn9vXeXb4fy5IFzZtVW946fjV4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbdSWWF1ce1g4cdU9VQYfL2oMyB8fxypXAR8G9siSCe/+Xc6dC7jskRlPEL7iYiagdkN3luuoP7i8od1/qLIkNg6cYx6qTq3rNsao8CpmOQns38szsMF811oaTXPzNyn1uIgRZ6IeSajbb92yHzV9LhoMFfje9iEzXlV7tSD+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlZfA/Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BBAC433F1;
	Fri, 22 Mar 2024 10:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711104190;
	bh=gIU75Sab8N34yflwxn9vXeXb4fy5IFzZtVW946fjV4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlZfA/OkY6f1wSYV+TNcTlqIoHFpyJwc8UgryNf7aK3HaVV91TyS6q6yL7bcz50Rs
	 atf9f+wwMjib97Ei3jG13Y2HSOLhhh4lUAvkVeQU9E/y9LhM1qoSstkFGMWE9W1qf8
	 XmXUxlbpjjiFC/FeFs9io/i1X18M9KyqWydRV3zWU1DXeB2yi5BrcWwSarY71HyOde
	 HivAY11FODDdvLE1OYem89cDax2GcqPvmuDcFyAQ+wdKRctNbq+rzXTGc1z0kq27Kz
	 x2IqJZ+oYb/KLjZGbtmVxR0tRD2actyFdDkMI1T6SdjdrL8+M+maBDWQ+h9wUilJwP
	 aMG5F6CDgbFaA==
Date: Fri, 22 Mar 2024 10:43:03 +0000
From: Lee Jones <lee@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v7 0/8] devm_led_classdev_register() usage problem
Message-ID: <20240322104303.GN13211@google.com>
References: <20240314201856.1991899-1-gnstark@salutedevices.com>
 <20240321181133.GG13211@google.com>
 <9bfd0ccc-a5d8-446c-a08c-bbc36a4d66eb@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bfd0ccc-a5d8-446c-a08c-bbc36a4d66eb@salutedevices.com>

On Fri, 22 Mar 2024, George Stark wrote:

> Hello Lee
> 
> On 3/21/24 21:11, Lee Jones wrote:
> > On Thu, 14 Mar 2024, George Stark wrote:
> > 
> > > This patch series fixes the problem of devm_led_classdev_register misusing.
> > > 
> > > The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> > > is used then led_classdev_unregister() called after driver's remove() callback.
> > > led_classdev_unregister() calls driver's brightness_set callback and that callback
> > > may use resources which were destroyed already in driver's remove().
> > > 
> > > After discussion with maintainers [2] [3] we decided:
> > > 1) don't touch led subsystem core code and don't remove led_set_brightness() from it
> > > but fix drivers
> > > 2) don't use devm_led_classdev_unregister
> > > 
> > > So the solution is to use devm wrappers for all resources
> > > driver's brightness_set() depends on. And introduce dedicated devm wrapper
> > > for mutex as it's often used resource.
> 
> ...
> 
> > >    locking/mutex: introduce devm_mutex_init()
> > >    leds: aw2013: use devm API to cleanup module's resources
> > >    leds: aw200xx: use devm API to cleanup module's resources
> > >    leds: lp3952: use devm API to cleanup module's resources
> > >    leds: lm3532: use devm API to cleanup module's resources
> > >    leds: nic78bx: use devm API to cleanup module's resources
> > >    leds: mlxreg: use devm_mutex_init() for mutex initialization
> > >    leds: an30259a: use devm_mutex_init() for mutex initialization
> > > 
> > >   drivers/leds/leds-an30259a.c | 14 ++++----------
> > >   drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
> > >   drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
> > >   drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
> > >   drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
> > >   drivers/leds/leds-mlxreg.c   | 14 +++++---------
> > >   drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
> > >   include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
> > >   kernel/locking/mutex-debug.c | 11 +++++++++++
> > >   9 files changed, 122 insertions(+), 74 deletions(-)
> > 
> > Doesn't apply to v6.8.
> > 
> > What base was used for this?
> 
> I've just pulled git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> and v7 was applied cleanly. linux-next is ok too.
> 
> v6.8 is lack of recent patch 6969d0a2ba1adc9ba6a49b9805f24080896c255c
> v7's patch #2 depends on it

No problem.  I'll wait for v6.9-rc1.

-- 
Lee Jones [李琼斯]

