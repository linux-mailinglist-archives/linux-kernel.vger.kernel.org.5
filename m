Return-Path: <linux-kernel+bounces-110034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5A88591F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDE282C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5AC7B3F6;
	Thu, 21 Mar 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh/Nu+Pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C237B3D6;
	Thu, 21 Mar 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024294; cv=none; b=WTcMIsWHk6H4p6Wam2cTqU30FZHofUKd7QySicB7J7bCNeEjL1t9mbxiIZxR9fh4U9yB3HtVLytmDd4qO0RZiFFNJqMBF5538Hcl66GrFF7q5ZrSptPgvxBju44/QMTZm1tek320oGSIWbjBn5RTi5XgOsCqkLlL4qeVlNLyC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024294; c=relaxed/simple;
	bh=SbHg3cfmOZNQ5ge7TMv4zrHjYMVrSWom9DWWszG5nhw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CR/eVdXAPcQA/H8oal0ODXpdbr6gUJN81p339szaUETIhyhQ4zFB4iOVcmFqQGYuLM7EKHKAMHoVzMRN1+Kx86Hzi25snboNdY2JDQU/HpO0XOJd7DlZwT/a0r8YbuybGBgWaZja5nybiMsHKJepd3M5cVSg1SQHtPKzRKbZKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh/Nu+Pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF56C433F1;
	Thu, 21 Mar 2024 12:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711024294;
	bh=SbHg3cfmOZNQ5ge7TMv4zrHjYMVrSWom9DWWszG5nhw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Xh/Nu+PiRo2Q0dtPt7L2XTMOj84lkLGHRnUiXDN/n+TLvggfsQvznofOMEvb96r0H
	 D9kD2nCs3MUXRJfNxZZjbXiFJ4354hrgibKO0KEYWiBTS32+uJOzFvyKTbHtNYn628
	 SvfPVoPhhF2vUiAjWEllrkgr7Tk1WRBD3BwtUG3W8juSwT+/oFIJ1xIexBkXMixrMR
	 NMoj7Lf0nH9kjPByIxiOR0OW4dX/cfwfCdqqjyvDF0zYUmEzYiPy7SABa3DmwunpOa
	 WGJczgHz00ElICoqfzFIoh4cbfAAqf3JSpB5cJ/VJycHewFFUzYBG7BjradJRHVWMx
	 r6nid/IkdWWww==
Date: Thu, 21 Mar 2024 13:31:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Nam Cao <namcao@linutronix.de>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    Douglas Anderson <dianders@chromium.org>, 
    Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
    Kai-Heng Feng <kai.heng.feng@canonical.com>, 
    Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Eva Kurchatova <nyandarknessgirl@gmail.com>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent
 lock-up
In-Reply-To: <20240318105902.34789-1-namcao@linutronix.de>
Message-ID: <nycvar.YFH.7.76.2403211330380.20263@cbobk.fhfr.pm>
References: <20240318105902.34789-1-namcao@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Mar 2024, Nam Cao wrote:

> The flag I2C_HID_READ_PENDING is used to serialize I2C operations.
> However, this is not necessary, because I2C core already has its own
> locking for that.
> 
> More importantly, this flag can cause a lock-up: if the flag is set in
> i2c_hid_xfer() and an interrupt happens, the interrupt handler
> (i2c_hid_irq) will check this flag and return immediately without doing
> anything, then the interrupt handler will be invoked again in an
> infinite loop.
> 
> Since interrupt handler is an RT task, it takes over the CPU and the
> flag-clearing task never gets scheduled, thus we have a lock-up.
> 
> Delete this unnecessary flag.

Hmm, right, good catch, I can't figure out what extra semantic 
I2C_HID_READ_PENDING would be adding (rather than deadlock :) ).
Why RT throttling didn't happen and let the system in a completely locked 
up state is something I don't understand, but that's separate.

I have now queued this in hid.git#for-6.9/upstream-fixes

Thanks,

-- 
Jiri Kosina
SUSE Labs


