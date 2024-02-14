Return-Path: <linux-kernel+bounces-64881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8669854436
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649621F28F07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41F79EE;
	Wed, 14 Feb 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEjFvACH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CF79C0;
	Wed, 14 Feb 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900359; cv=none; b=UMCXG+EvKxUzdIUYAqWhJyPKLqkvO60TkQB1fP5BzRklrtPoKsz3HXEYReAIHZq+6ga/ge3/B0rAvoJZw5I/kyyJTwkwBxVAMvSW2sx1EBhHqQxsEeoEaSTPRtchtMO9iWdUd34mfDn05s2HU1ThxCU0dcCp7uJj7Nkm9gIvwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900359; c=relaxed/simple;
	bh=80PMX4RRZXC/T1+Nh/TK7dabMmwW48VhI43ZD1PxROI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=W1gi4zroZ47OzHlhBbI8xzXZSAf9nsYFgI5E2qNyg3EOByHUiWSScsJM+pe0MnpimcK0DEWOuIcwW2dsKK+TfnkFrid0RpA9KpQkx7fhSYVrtHq8ZA1VW9yIzOvC1oMucm/mtdXV9chmkjhLlEjT0FaeaRBuJeyn7YMlQxSPKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEjFvACH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B443C433F1;
	Wed, 14 Feb 2024 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707900358;
	bh=80PMX4RRZXC/T1+Nh/TK7dabMmwW48VhI43ZD1PxROI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eEjFvACHOyLYtBiWnd6/VT8fR7wf5ctAfkoEf5UPHRDFIa8aDerZZ97cKcPsCKLXC
	 ih1N47S+tp5348Cq9IAt0NAboF7UAV+3fwRF7dZMnZvvRPvbZZMyOaIHy0an58Xvq0
	 NJmqHMWI8KsznLVpVEYUI3fVijSVc07wBAJp1qXioZoWLpscEGVxhXfLhAnpn+ZQ5s
	 H/5+3XI/30y5orQ9aL4BW9NNYyGoBDTS/B61bYyi7y42Dltozqrk/mfIo7NfES6v/e
	 eIT1Qw5PqhNg4SBOVCFVv6oqycnj2Z2OgdQkEN8mM+y7Hcj0cbUOQUKkotWUzHUITT
	 +bJ7QF9JYy+eQ==
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
Message-ID: <170790035300.3179441.9169506478575963188.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:45:55 +0000 (UTC)

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

I guess this should go to wireless tree?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213100548.457854-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


