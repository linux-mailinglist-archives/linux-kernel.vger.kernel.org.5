Return-Path: <linux-kernel+bounces-68903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D808581B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31651C21631
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098E12FB06;
	Fri, 16 Feb 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzCS1Zj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83112F58A;
	Fri, 16 Feb 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098561; cv=none; b=YmIS/yhPQH2fug4nrtpTtNfo5O1lB2yfuIoV4p4Mrrmvtmu4WRPX2I35RdUUL1TfN321fiFgYi9HOLgvxEy5mKZK39TNu23G6nPHeT9VQtg6Q9DqnXGh/gxBY0sS2TAPhKsSECyZ4bA6vbyXDx/soqq2syKWyIxBVp0pDD4DswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098561; c=relaxed/simple;
	bh=hoWcoxaE9hHAP7DML157PhtnsOaCJzKVVuI8UORwRr0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=M7TqodDgIiFxqvhXuG+yNdryIrgaWln8eGYUlSBVW02Ao80XMJf7uYK5odJBaCHpskGSkVTDv0cTS3E0/0XeNFOaKLdnaefFFxdHz0NPUf3OMLYL4pCXyIGlF6O33HpUCDMuI+B5TegRHZWofkBQOCgR3V5cjfkOv3MjXjW6GDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzCS1Zj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A60C433C7;
	Fri, 16 Feb 2024 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098561;
	bh=hoWcoxaE9hHAP7DML157PhtnsOaCJzKVVuI8UORwRr0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qzCS1Zj4OpYfDwAJEGip/bFu3oVVNxDOTflazXII7mTfZLEPndyHMPfnwvH8vqj0Y
	 BdAW/36WcT5OBpxX+HtFo2fcf5+bk6oNEue97HAFimXKDnKIlcKsqkrJ1FaOFAQmNk
	 RLSTcQIiMq64ho4na5EgEaramAtiwI+Lugx8AeHe0uJGu9rYzkakyfje5ZHjGc34dy
	 k7ukZuxDSD9ajx/CqAOqXnbOVcAg38KTIabvO7RYdSCYR0SXiVxEas0RCEmiRVaNIP
	 Qirv99zXeh2X1a8nOdAo1VH8ApjFjigLFEOVBCoa3iXvH3+Vi2WyLHhirI1qfqSmAc
	 hA4Is9wFOXdTw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmsmac: avoid function pointer casts
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
Message-ID: <170809855575.4095987.6738667810057679701.kvalo@kernel.org>
Date: Fri, 16 Feb 2024 15:49:17 +0000 (UTC)

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
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

e1ea6db35fc3 wifi: brcmsmac: avoid function pointer casts

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213100548.457854-1-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


