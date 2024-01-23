Return-Path: <linux-kernel+bounces-35087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76765838BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B121F22502
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E65BAE7;
	Tue, 23 Jan 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSw4b3hU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BDEEA9;
	Tue, 23 Jan 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005601; cv=none; b=LlMoAkXiiW9xMFvwgpTn7j7iGTr/2EAFZAtSO9lOG2Vx3zYXuE1E8VQyAV1jp/1625MffLDHOYGlRN4HSCHiaGiERsZS5d1BcBufykSfZleqC+sxaizx0w27k3eRbozk2kqCGgagAlbSbgDX7O0NVWO4w8OCZmhV2WpBUtRqJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005601; c=relaxed/simple;
	bh=DR+zgKNWJaIggO6xvI5mXauOg5o07Q+mfafKQsQ+U+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=shGx5TUwXby2GUti6Jm0MAQsHP/XLUthIi7AeMDHaOe1Uu1WfWWsPkDyfYfO8/ddJuF3yTJYlD3f4b7nZD59Xn/6VW+61AY+b4KDUkeEJWPbcSgfSuwU+AIsrkYg2P7Agzv0L4LM2Ru3boJr/34xQToDdkCDejYkk/hGhXLjLIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSw4b3hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73EBC433C7;
	Tue, 23 Jan 2024 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706005601;
	bh=DR+zgKNWJaIggO6xvI5mXauOg5o07Q+mfafKQsQ+U+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BSw4b3hUDD75X2tFed+8I/YY6i8CeyPlTmboyQP2YuWBW2qz3NCi49Ax2yH+qVrRs
	 tIuOrWy4J5mq/GW5BEoHwppfiQy1un2ty4AazL+fMaKwqm2KYX6k8Im5iTGVan7O7b
	 gp/b1+e7sdPGFrh3Y76fkBAlGjiieGKiZOUh7o/wjpODIH7g37eKyMM4jIIrWK7K93
	 rIlE8ZH2+8oWvbiuOFGh916rIqVe8NTEocmEytQNWe7aQnclTpC/0N24PHLn51SSOG
	 Wab5IoYBlzojMG0haBzp4I15HEtjUPK93wHoqNDEjovnI7GVCe7TIej4GYJHDtzIzc
	 8H/0U4EUtTD1g==
Date: Tue, 23 Jan 2024 11:26:41 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Doug Anderson <dianders@chromium.org>
cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, benjamin.tissoires@redhat.com, 
    Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad
 on system suspend
In-Reply-To: <CAD=FV=VCoB_uBontRk3WVn-nqzZnutSMCHBpdBqNOFwrYv=8xw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2401231126300.29548@cbobk.fhfr.pm>
References: <20240115045054.1170294-1-kai.heng.feng@canonical.com> <CAD=FV=VCoB_uBontRk3WVn-nqzZnutSMCHBpdBqNOFwrYv=8xw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Jan 2024, Doug Anderson wrote:

> > There's a Cirque touchpad that wakes system up without anything 
> > touched the touchpad. The input report is empty when this happens. The 
> > reason is stated in HID over I2C spec, 7.2.8.2: "If the DEVICE wishes 
> > to wake the HOST from its low power state, it can issue a wake by 
> > asserting the interrupt."
> >
> > This is fine if OS can put system back to suspend by identifying input 
> > wakeup count stays the same on resume, like Chrome OS Dark Resume [0]. 
> > But for regular distro such policy is lacking.
> >
> > Though the change doesn't bring any impact on power consumption for 
> > touchpad is minimal, other i2c-hid device may depends on SLEEP control 
> > power. So use a quirk to limit the change scope.
> >
> > [0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Use quirk instead of applying the change universally.
> >
> >  drivers/hid/hid-ids.h              | 3 +++
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 6 +++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> This seems OK to me. As per my repy to v1, it doesn't feel fully 
> explained what's going on. Why does it only wake the system without 
> touches if you put it to sleep first? Is it truly a hardware quirk with 
> the Cirque touchpad or is it a bug on the board you have it hooked up 
> to? In any case, perhaps it doesn't matter since you said you measured 
> power here and, on this touchpad it doesn't seem to save significant 
> extra power to go into sleep mode. ...so I guess I'd be OK w/
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


