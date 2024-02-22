Return-Path: <linux-kernel+bounces-77531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C18606E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AB7B23E35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED713BACA;
	Thu, 22 Feb 2024 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4/nyA5B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C62137933;
	Thu, 22 Feb 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644052; cv=none; b=HEcq6ODCK1wWO6jw5VLS0nKKDFbcsTqbd6pR/QQmGi4yW5AB47LoavFztkiza8PMTECwaGQLUcmwjgWOmYUj2zB/+nkK8bIsgRPv4Zldmj8aU1DViKBflWR8MlcyWi5sqcD7NnJSC7OV9uP/G0Dck5gDaDtme4KprZa+8rehb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644052; c=relaxed/simple;
	bh=Y6o9VsjyTfZlt/ma3RPwq/TFdMyO1XRt/4IORTwFDy0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SwTQR+A2PxdeBawb1EID2TL7qEEl21pShpnwxl5iZ2H8XY6vTdHm+blvmXIaBv6F6ip15ND0VoSgThJqHYj1424has7UfVEDNWCxuMmrqUUERt4tY8oafo3PQNJDcBof/FxqxbM8ybTU4hYApeSAgPAjRsyEMCfEhoRgbwAm7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4/nyA5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16C8C433C7;
	Thu, 22 Feb 2024 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708644052;
	bh=Y6o9VsjyTfZlt/ma3RPwq/TFdMyO1XRt/4IORTwFDy0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=L4/nyA5B3xHgkBMZCAKK8tZodBCng8xc5aBKftryCDGHYUE4LwIywUXsACUZaSPkP
	 a8eHL/07HPfMIgQ9cRwdYP3kqEt9m9Jd/6BzYYVo2VwQs2lCvXXOM/km7WKCyEt/Dz
	 MeORyVyf3Sg86ZaPkelEmgUK+AICfFuKUMe0hsophLShjQwQosOm7gTPwvqbZYyNKZ
	 GjnrIOb7IYMuWn9RFj6NBbe8zH5Tl8PU9FGgxhEl/Y9baO+1ih39j/jTO1xmvhmVj4
	 OzXxd/b+G7Yz7X6kcXapWS33amTt2jJQiW6nFl9aDDBnbnsgspbm2rCGFa87AupdKf
	 oAU4tLbfeS9PA==
Message-ID: <c79909e4e55badc8f094d2ff8c4d34ca.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
References: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
Subject: Re: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@salutedevices.com, Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 22 Feb 2024 15:20:49 -0800
User-Agent: alot/0.10

Quoting Jan Dakinevich (2024-01-26 12:14:33)
> Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
> case of deep hierarchy with multiple dividers/parents. But if the clock
> already has exactly the same rate as desired, there is no need to
> determine how it could be rounded.

What exactly are you trying to avoid? Is this an optimization or a bug
fix? TL;DR: I'm unlikely to apply this patch.

I could see some driver implementing round_rate()/determine_rate() in a
way that rounds the rate passed in, so that even if the rate is what the
clk is running at _right now_, it still wants to change it to something
else, or at least call down into the driver to call the set_rate clk_op.
Applying this patch will break that. The contract is that
clk_set_rate(rate) =3D=3D clk_set_rate(clk_round_rate(rate)). It doesn't
look like anything needs to change.

