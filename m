Return-Path: <linux-kernel+bounces-67259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1708568D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49EEBB28482
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A881350DE;
	Thu, 15 Feb 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKH5RhUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6D13540C;
	Thu, 15 Feb 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012989; cv=none; b=CqsnVpJHq+o08GHB+0CxFBfnC9UOt0bO3N4dJdlt/bxYRHxr+MVtTEgkyRjvStnU8jBqdu/Ij1k5kvmjFmXEkqFXuIl3Ir6EXXFvRJE5JOBaICcOWifCnGyNYXiyyF3WfGgYhNl8vLPYtYyz+GplTyK0jSo+h+HZ3vTkHXiLPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012989; c=relaxed/simple;
	bh=79NMCjGVQ8o/aukHv1MK2+ZjeVYKoQY4lIw9oAyTvMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phNrjlxUgFBEbRgZ6gs7QQbgBxuc5Y0kFduU58y7poNyuiP646Mb9g0b6wB7MP462gg+q1mN+swvHGvE4FZb4KzVxR9t876c4nPDJ86Y36RyQ+B+z0ZqRInMJ3dhXMRGPIpyYoT75GviA1Qv5yEhG+FGqtBUZNQlrd8S1RUzdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKH5RhUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6816C433C7;
	Thu, 15 Feb 2024 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708012989;
	bh=79NMCjGVQ8o/aukHv1MK2+ZjeVYKoQY4lIw9oAyTvMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZKH5RhUQF/Q6d9WZLTMiHfEC0TacKXYO7iX8CZBuwk2qpOCoxBSot0uZnzwRwf99M
	 +YyF8y++prYvKdAan2n7lZOlBS9wtujOzDetCH+hUZJ+BOiJEquk9ZAEVnw4YFT9bc
	 6InmAbrad8Y5jEEr1domAQ7XhuP6bS6nKcAZXiDLC6dbW4KU58U+5nFxtf+oX5kkhM
	 gqnm6juP57GFgF+r3yRr5iFkd5NqgCHQtJe+6DvHn33bfCXmol9OTzOO1IFiHjwdSF
	 X/gs//RiYORqbWudA50WcBDv6p/cmlKpeYSAb2z1HE3wK0jEDnUzOc51HzeuDkKxge
	 NygetD2Jg0Agg==
Date: Thu, 15 Feb 2024 08:03:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Nikita Yushchenko
 <nikita.yoush@cogentembedded.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: ravb: Count packets instead of descriptors
 in GbEth RX path
Message-ID: <20240215080307.226732cf@kernel.org>
In-Reply-To: <20240214151204.2976-1-paul.barker.ct@bp.renesas.com>
References: <20240214151204.2976-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 15:12:04 +0000 Paul Barker wrote:
> The units of "work done" in the RX path should be packets instead of
> descriptors, as large packets can be spread over multiple descriptors.

FWIW one of y'all may also want to look into processing Tx completions
before Rx. Tx completions can free memory which Rx can then consume.
More efficient. Not to mention netconsole being able to reap Tx with
budget of 0.

