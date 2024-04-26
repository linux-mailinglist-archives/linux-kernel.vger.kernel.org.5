Return-Path: <linux-kernel+bounces-159502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6288B2F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5D41C22B06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7E139D12;
	Fri, 26 Apr 2024 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po0R7TXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B7343ADC;
	Fri, 26 Apr 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106247; cv=none; b=EcBybhQTY8T2+yimx1ZNmFqyK7K8UyXkPJ/l4iwQFG+RMvdDclcwRfsf50Tjwv4w9zeI5SrCoECyPlwpBPgfAHUHxJhIwUOyWPkRTPB60bEUS2V6+BHjMmBoasCzzpMUJTPg/oomfldg/ytGH2ejw1ApskJxdLRTq+ygAHTH1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106247; c=relaxed/simple;
	bh=HVslDCGQSbVxPzywsWFcgvSyrBbXdafmwApe57VI3ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yaq9aTFNP1K2tjYuzcczgVPLFjaaX5RM5FXOJVQosNtLwIOG4zcW5yn9XsDeP2WLy9LanQ0HUo9aN8Bpg0EVD2lpR6bMnCRGN4wYnmVOfeilgT0cN8w/DOH/KtY3EYUX6afyk1n0akF1FsoDZqPPTo294UZ/88yz6UrJrHOanfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po0R7TXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26742C113CD;
	Fri, 26 Apr 2024 04:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714106247;
	bh=HVslDCGQSbVxPzywsWFcgvSyrBbXdafmwApe57VI3ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=po0R7TXxkdSTICIkaevplkiueulozFOGYC9wdnalQ6KKq1TZM4XsQCyW0GyzxtBtM
	 kzBbF353pydHiLuXMrRoA/3VIGVIsQhdGYmZTfUUWjXqlPxCqfi9G9s277dX00+4lB
	 SaKf2zDv5gXC6qKbc97kfO2IjLRtnCwJ/0cQ4mRvihY0y0MnzuYiFaDN+36tl1z1TG
	 XDVdEL+sGvonJP/ZNJiiQbtyvABCu9AafdprYLokZe5V21GkG7cybmNc8cR8hhfYS9
	 2ZdSlpTnJFvxXvNBBBAcUo+K5pqg6EP+zMRY69u9PwgcjaESFDyzxZ5W/VOOyjWs7B
	 Mt0oEegd2ZQXQ==
Date: Fri, 26 Apr 2024 12:37:24 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Lalith Rajendran <lalithkraj@chromium.org>,
	chrome-platform@lists.linux.dev, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v1] chrome/cros_ec: Handle events during suspend after
 resume completion
Message-ID: <ZisvhAg5Jy_IE-AV@google.com>
References: <20240425143710.v1.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425143710.v1.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>

On Thu, Apr 25, 2024 at 02:37:11PM -0600, Karthikeyan Ramasubramanian wrote:
> On boards where EC IRQ is not wake capable, EC does not trigger IRQ to
> signal any non-wake events until EC receives host resume event.

The sentence looks irrelevant to the fix.  Presumably, EC should send those
pending non-wake events after it receives host resume event.

> Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
> command and irq disable") separated enabling IRQ and sending resume
> event host command into early_resume and resume_complete stages
> respectively. This separation leads to host not handling certain events
> posted during a small time window between early_resume and
> resume_complete stages. This change moves handling all events that
> happened during suspend after sending host resume event.

The regression you see is probably not due to the "separation" but an unwanted
code reorder.

Before 47ea0ddb1f56[1], a resume is:
1) Enable IRQ.
2) Send resume event.
3) Handle pending events.


After 47ea0ddb1f56[2], a resume is:
1) Enable IRQ.
2) Handle pending events.
3) Send resume event.

If there are some more events pending between 2) and 3), they would be handled
further late.

[1]: https://elixir.bootlin.com/linux/v6.6/source/drivers/platform/chrome/cros_ec.c#L381
[2]: https://elixir.bootlin.com/linux/v6.7/source/drivers/platform/chrome/cros_ec.c#L438


I see what the patch tries to fix but the commit message makes less sense to
me.  Please fix accordingly.

