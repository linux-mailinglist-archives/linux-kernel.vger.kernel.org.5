Return-Path: <linux-kernel+bounces-61909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BAD85183F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84F32868C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812663C6AB;
	Mon, 12 Feb 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNSCUkXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91A3C088;
	Mon, 12 Feb 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752292; cv=none; b=iMBgRq4Zkfr+3XxYvMvjj0jDkqfYlOHWmq9jOXX+fWiJDGzMakgJvHDgdF2rs51VXS6tVUXc56VSL4t/UeBkxdM17/9wUwMfXSd3Cl+vltIatOAk4ivirEYZl+QgLAW8AZi3D0o6zPvcU3MTmIgf4SvNkOKsBR6+NnNc75kgku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752292; c=relaxed/simple;
	bh=AKNvaHsgQo+M8zEEgaqhqkD3MZ727WnLytCZB7yGkVQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Ig86C40GDyjAvqd2eon8FmsSz0R8gz4G24lyVwKos6xGEh5wKFmyCFcXOUEDA3/CR8v1M/ol+APBw4ylb9v3iZt9y1ZQEI5Do2lcgLzVT9WM/I/r3s5YAJO6xaP7SuXZmxIm/Zhh93wB2JViB23dYSjTz/r6IU0UpHHGQdt6nL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNSCUkXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF16DC433C7;
	Mon, 12 Feb 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752292;
	bh=AKNvaHsgQo+M8zEEgaqhqkD3MZ727WnLytCZB7yGkVQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bNSCUkXodN4XgX1J8GbQcTLI7YMVUSQpLbE1+hebO5I/ARJX1bL0dZd8B504gyt2s
	 k/zQ6KS9V176qtdXBd/B4hG1yz8REsROm16E+2IMxtEOqcLy/SSOjzSS4eeTTkA/F1
	 l5CVw244A/3qoNPBxexMi5/chQqj6Xx8U97VM0hUctN2dybt8ZA/eXJ5qZ6524URyl
	 anNkudA46LDlGiR1TJDHvns1Qtb5M93a2wuN1bXEMPBo37smf+fe7l2Q2GKHELmPEf
	 T4/ZrjIMrovEBg/SFwvEJB3FnPWSVPzzDmxy6XsQ2rta0EvBEWdFeomlX+uv7Caq0/
	 Nb0kC5/Z2i/Eg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: mwifiex: Refactor 1-element array into flexible
 array in struct mwifiex_ie_types_chan_list_param_set
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240207103024.make.423-kees@kernel.org>
References: <20240207103024.make.423-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>,
 Kees Cook <keescook@chromium.org>, Dmitry Antipov <dmantipov@yandex.ru>,
 Johannes Berg <johannes.berg@intel.com>, zuoqilin <zuoqilin@yulong.com>,
 Ruan Jinjie <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-wireless@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 David Lin <yu-hao.lin@nxp.com>, Lukas Wunner <lukas@wunner.de>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170775228681.2851594.6070070242483330161.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:38:08 +0000 (UTC)

Kees Cook <keescook@chromium.org> wrote:

> struct mwifiex_ie_types_chan_list_param_set::chan_scan_param is treated
> as a flexible array, so convert it into one so that it doesn't trip
> the array bounds sanitizer[1]. Only a few places were using sizeof()
> on the whole struct, so adjust those to follow the calculation pattern
> to avoid including the trailing single element.
> 
> Examining binary output differences doesn't appear to show any literal
> size values changing, though it is obfuscated a bit by the compiler
> adjusting register usage and stack spill slots, etc.
> 
> Link: https://github.com/KSPP/linux/issues/51 [1]
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: zuoqilin <zuoqilin@yulong.com>
> Cc: Ruan Jinjie <ruanjinjie@huawei.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

14ddc470ba22 wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240207103024.make.423-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


