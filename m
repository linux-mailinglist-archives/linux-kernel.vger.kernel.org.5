Return-Path: <linux-kernel+bounces-66658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1EA855F96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43931F2125E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F63132470;
	Thu, 15 Feb 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sra+8tV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B2C12A14C;
	Thu, 15 Feb 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993209; cv=none; b=DgjJwoeyhZlDSTJFqL5df2JcqU7BtIdYwkqHejUQ1793pZaUAp9G7TAP4NU9x9mGO/1Z0KP3vMthJo0RxlvMz9ShDAuPz+jNofgoW+59NHEnSBU1J0vfY7AiLy7bRKFIcb2PjE5elrL5QXdoxVEjMuyubNShfxeGBrCbYIQgLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993209; c=relaxed/simple;
	bh=YMmvKWmJWQ8GBJaKmsMH0BhA/75UXDRgZSp4hIO813I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=XG4BVZzHj8tVra63zPiJQDmCsOQs2Rb6qmWblR/458SkQ2ksMhUJTwdsdoDgnsDnAG2lYL+Pd5Ufoq0PKln63YbfENtu/vOCi441xRqSa+sYSlPLR0Al/eWnDNLuD+ZLOc2r59i1ZS4b6D6/T6zxYnPE1jahuNswXh+g1O/zsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sra+8tV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47017C43601;
	Thu, 15 Feb 2024 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707993208;
	bh=YMmvKWmJWQ8GBJaKmsMH0BhA/75UXDRgZSp4hIO813I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sra+8tV742RUlVmTCl6D0FHDj6mcBgZlGlhaG4uP2BZC/wkFEAVQVKxi3Nnru+WUb
	 uTL5AXjtBjys+ilIcD9S1Vi9+MuNbFfQf46sYy5GIrPKloAeFqAmKaXyiYRKU0AoEF
	 h2vqCATeeVolv90hCrNxIUBQxgPXtea//2gNahoY2LmtuWPGXwhBKMJ31svuRMKUOT
	 JsFHxqIR6cQ6U4VBoGSJmuwX2dB72IjzJZQhEabIA70lWBGdEd3Niy9x44yLsyi0p3
	 MW67ESTUB9lAtooxyuJaWCW4SQWqj1CrHs5VzA4zZS9tcY+wBk50MlFQxoom0Un7qK
	 +hxv+vuRdCPMg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmsmac: avoid function pointer casts
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240213100548.457854-1-arnd@kernel.org>
References: <20240213100548.457854-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>,
 Pieter-Paul Giesberts <pieterpg@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Jonas Gorski <jonas.gorski@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799320307.3764215.10635499094580279814.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 10:33:25 +0000 (UTC)

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> An old cleanup went a little too far and causes a warning with clang-16
> and higher as it breaks control flow integrity (KCFI) rules:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c:64:34: error: cast from 'void (*)(struct brcms_phy *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>    64 |                         brcms_init_timer(physhim->wl, (void (*)(void *))fn,
>       |                                                       ^~~~~~~~~~~~~~~~~~~~
> 
> Change this one instance back to passing a void pointer so it can be
> used with the timer callback interface.
> 
> Fixes: d89a4c80601d ("staging: brcm80211: removed void * from softmac phy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I can add 'wifi:' during commit. Arend, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213100548.457854-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


