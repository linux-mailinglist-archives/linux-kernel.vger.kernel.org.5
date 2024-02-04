Return-Path: <linux-kernel+bounces-51748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B480848EDB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E32283702
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E90225CE;
	Sun,  4 Feb 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBLdwUHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6766225AA;
	Sun,  4 Feb 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059946; cv=none; b=NRlLKHu0IzJj1ECLoo5IuKAcffiYk9CQ99T6JJJ+7UzYf2oQPc8g/+v+0IJvBGK/+gCRgmLc3n4L50tFr8nUtoKP0AbhL69+jUdBGlgNl+cT7n+q3qDivUhiqziBEj3KYrdbNuV8oTrxaU9q9lfo16mn4JvBvCO5aeg4kIlTsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059946; c=relaxed/simple;
	bh=VAwbFSaHpu8yNPzwtRSQDyXC7qrgpVyDPy/iQqXhAhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtFlWdTSyTTPiFczDxHxqiiccJuAp9+AzhbAKD5fK95JJK9CvfkpnapDqehew8CLGA+6Mm8KduMMeiPnbsDqxCLzGJwS00oj4Szdq9+0WDkqb+YsuZ3X2F1uKlkBpMGmN2HD6k63GLB0jtgCgPMhyXvpAGSvxlM6OHiYNVdY68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBLdwUHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48471C433C7;
	Sun,  4 Feb 2024 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707059946;
	bh=VAwbFSaHpu8yNPzwtRSQDyXC7qrgpVyDPy/iQqXhAhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBLdwUHGhO9+zhHGUj5626zUZFBcaCgrv1rmdfXnBzufVXHE1S6DXrE6afHw4mqzj
	 Tn4LsXVO6WTVePEcnQWgUm15Ttbs0m6Jl9g2tTOF8oqAzZjwGL33HpPb+VaPRBFFoD
	 LqcHC5nz4L3tm5h0QZqbkODc5JoBf9LXrLR7hFbtLLUcBOwE0b0nOOadlJffLiF5en
	 DFVGoOwVMoPuDXH/E0FCcmO03/sJYl+jYluRZiVT5dha+QyVJr2jX9qa28wEIZSSCe
	 CX8l73JBwJA87TbBwKTEGb1oQxLZollO2oRjcUjRUWRmEAy6SMo2rMjeo7t8hUR/8x
	 BWo1twgB1g3KA==
Date: Sun, 4 Feb 2024 15:18:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] iio: sx9324: avoid copying property strings
Message-ID: <20240204151854.581fb780@jic23-huawei>
In-Reply-To: <CAE-0n5031k-5Gv+jFuWJekgPfHDw8yjUobqZr6+=UzgOEqOO4w@mail.gmail.com>
References: <20240201-strncpy-drivers-iio-proximity-sx9324-c-v5-1-78dde23553bc@google.com>
	<CAE-0n5031k-5Gv+jFuWJekgPfHDw8yjUobqZr6+=UzgOEqOO4w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 15:38:03 -0600
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Justin Stitt (2024-02-01 10:55:03)
> > We're doing some needless string copies when trying to assign the proper
> > `prop` string. We can make `prop` a const char* and simply assign to
> > string literals.
> >
> > For the case where a format string is used, let's extract the parsing
> > logic out into sx9324_parse_phase_prop(). We no longer need to create
> > copies or allocate new memory.
> >
> > sx9324_parse_phase_prop() will simply return the default def value if it
> > fails.
> >
> > This also cleans up some deprecated strncpy() uses [1].
> >
> > Furthermore, let's clean up this code further by removing some unused
> > defines:
> > |  #define SX9324_PIN_DEF "semtech,ph0-pin"
> > |  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> > |  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---  
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied

