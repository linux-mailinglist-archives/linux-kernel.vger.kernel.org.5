Return-Path: <linux-kernel+bounces-65731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5E8550EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D09286626
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E03A12837E;
	Wed, 14 Feb 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKuyTVQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD41272C0;
	Wed, 14 Feb 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933354; cv=none; b=CbPvI1Ms4WArayWhn4e9qulAih2adHbe8GlNf3QGd/ZqtAXqXmvCxzx9hP0XapT+N7AwkTjX7eyAuBmPTxkW1lyZT/Ghov4qzMfi+ufSXWAmon9QqSpZW4Oir9nkhHWtzQsejQ0LEWyVcwov/rMsqZtjoAz+bzmU+zhNd8bp3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933354; c=relaxed/simple;
	bh=AekKESNH1YzcWERD9WvAuc+h4Br5J7sxCXJp1H3DgIw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LmaG1qlw8P7SXOUVSaANJjJ7TjPqi8aXOPYyUDgh+vEfV7RHzOLis9Jx4V5Xe7UOWU+Brgk3IdUD2fck0Y7FPE5mKdb0akorvXRM5q4zdLj3f5a53F0jrUu0it/qtTWODBa6vbaYH+evs+Ku4koFa5Ky+C8qSsHt28DZ5CPpmEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKuyTVQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF503C433C7;
	Wed, 14 Feb 2024 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933354;
	bh=AekKESNH1YzcWERD9WvAuc+h4Br5J7sxCXJp1H3DgIw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hKuyTVQDqnFOOiIzi24tJPQ1jaKR1kx1X+NHUv51k/lBi9dzWWY7AMgukTmxA/xIV
	 aNU+95ZSw2gZx2SH+v+Kxtc4tAbkqpQ8/DbBwj4Y7Lz9dYyeDxyufOMtTJhxHqXYdq
	 4TIcd7sX5ZiFUNPeG3yV0JxRWhNtV/U3jMSSnUfzF7tLk5psc5Qf2uZEktBOjeZJGy
	 VYaBibDRgvKyaHFO8itr9h28IGow/I+UfuFF/EnF1sINg9b8tp6VDV6+bMGY2eFXUK
	 to9cGho1TZ84A1p+tJhsu1XO2aXsYs/08XblS+r01W1VDlZqM3j1lKvaazWvKrNjCb
	 WtuOcfbL4Rj0A==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arend van Spriel" <arend.vanspriel@broadcom.com>,  "Arnd Bergmann"
 <arnd@kernel.org>,  "Nathan Chancellor" <nathan@kernel.org>,  "Greg
 Kroah-Hartman" <gregkh@suse.de>,  "Pieter-Paul Giesberts"
 <pieterpg@broadcom.com>,  "Nick Desaulniers" <ndesaulniers@google.com>,
  "Bill Wendling" <morbo@google.com>,  "Justin Stitt"
 <justinstitt@google.com>,  "Artem Chernyshev"
 <artem.chernyshev@red-soft.ru>,  "Jonas Gorski" <jonas.gorski@gmail.com>,
  linux-wireless@vger.kernel.org,  brcm80211@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com,  linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev
Subject: Re: [PATCH] brcmsmac: avoid function pointer casts
References: <20240213100548.457854-1-arnd@kernel.org>
	<170790035300.3179441.9169506478575963188.kvalo@kernel.org>
	<fd36f032-3bf6-4cae-a0d0-213604cef024@broadcom.com>
	<3f1c2d5a-ba98-4ae5-a7a0-0328b7552113@app.fastmail.com>
Date: Wed, 14 Feb 2024 19:55:48 +0200
In-Reply-To: <3f1c2d5a-ba98-4ae5-a7a0-0328b7552113@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 14 Feb 2024 16:07:00 +0100")
Message-ID: <87frxvnd5n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Wed, Feb 14, 2024, at 10:23, Arend van Spriel wrote:
>
>> On 2/14/2024 9:45 AM, Kalle Valo wrote:
>>> Arnd Bergmann <arnd@kernel.org> wrote:
>>> 
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> An old cleanup went a little too far and causes a warning with clang-16
>>>> and higher as it breaks control flow integrity (KCFI) rules:
>>>>
>>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c:64:34: error: cast from 'void (*)(struct brcms_phy *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>>>>     64 |                         brcms_init_timer(physhim->wl, (void (*)(void *))fn,
>>>>        |                                                       ^~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Change this one instance back to passing a void pointer so it can be
>>>> used with the timer callback interface.
>>>>
>>>> Fixes: d89a4c80601d ("staging: brcm80211: removed void * from softmac phy")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> 
>>> I guess this should go to wireless tree?
>>
>> This has been like this forever looking at the "staging" part in the 
>> Fixes tag. Is it really so urgent now? On the other hand I have no real 
>> problem with moving this to the wireless tree. Just wondering out loud.
>
> It's probably fine either way. Some maintainers like to backport
> the warning fixes to stable kernels, others don't. Since the
> warning is currently only enabled at W=1 level, it's probably fine
> to fix it for linux-next only, but if we want the fix backported,
> it should also go into 6.8.

Thanks, let's take it wireless-next then.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

