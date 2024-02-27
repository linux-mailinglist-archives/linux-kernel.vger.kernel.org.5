Return-Path: <linux-kernel+bounces-82946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82530868C42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A357228317F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEEE13699E;
	Tue, 27 Feb 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPM2wtJT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98A13664A;
	Tue, 27 Feb 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025595; cv=none; b=kRjQJBpM4JLvEJHjMr9fRl0WIXVMeTPXiFETvlVcQloEq52DFxwkkH4vblNpho96u5SYusuhF/uRQs3pxRE+yM43GTOTGy7MeBPr8VA+unft2RE8Efhikcq42VMLjpG13VAjUMRFkhCyu8lwA0eDv7HWVTbSKXn353OZ3pYkexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025595; c=relaxed/simple;
	bh=4FKpQ2YxhRM1cS9JvwGrN9mJcPARYZbWsBsplFmE57w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fEeA84JfLENS1BPQgC0BKwZxPQZZv9y807U23SuNHDtIR4drXCmMmvUHKwxFBj8hyViROmS2V9zOKJz49HyTtnJfjJm5Lotk6/AmJQhsdFZXNRJ41j4PwI27FMT0jNYEScjeIoIjaa3CiHoc/Qm/NMJn0cWb9f+7j9x8YNCl5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPM2wtJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEACC433F1;
	Tue, 27 Feb 2024 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025595;
	bh=4FKpQ2YxhRM1cS9JvwGrN9mJcPARYZbWsBsplFmE57w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jPM2wtJTHyWKh4fNtYM9y0G1BAyPnS/qGRUR/VbivdAJTPr7wGgbuuqenpnx+Te2X
	 b/2ePMzsnfZWFfvZtKjuNvKLq9kIkzPYhBYJ703NFRQNusIT1AWV8ATgJjrY0IcpS9
	 bgTKUDEEAzRqBBKgjJdTSd5wUxfMn2h9heYZ9D3H6DLfqWlqXR8gGYTX16I0eRj24d
	 pcHUikBx7/0JgxKXaQ2kS974YfcU59GQh72M4Yc/CP/4tdUtEkiV/Nx/s7WsqWgZbQ
	 wWcvZW65ZdwnZYRKWlbaOR+yRCOsTdKgmTqpriFzw7jT8Vjq9vkfat5IxsFo2t5JG+
	 wX14nOE3RDc4g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: brcmfmac: fweh: Fix boot crash on Raspberry
 Pi 4
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Zc+3PFCUvLoVlpg8@neat>
References: <Zc+3PFCUvLoVlpg8@neat>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170902559101.3280425.2706190192200235643.kvalo@kernel.org>
Date: Tue, 27 Feb 2024 09:19:53 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Fix boot crash on Raspberry Pi by moving the update to `event->datalen`
> before data is copied into flexible-array member `data` via `memcpy()`.
> 
> Flexible-array member `data` was annotated with `__counted_by(datalen)`
> in commit 62d19b358088 ("wifi: brcmfmac: fweh: Add __counted_by for
> struct brcmf_fweh_queue_item and use struct_size()"). The intention of
> this is to gain visibility into the size of `data` at run-time through
> its _counter_ (in this case `datalen`), and with this have its accesses
> bounds-checked at run-time via CONFIG_FORTIFY_SOURCE and
> CONFIG_UBSAN_BOUNDS.
> 
> To effectively accomplish the above, we shall update the counter
> (`datalen`), before the first access to the flexible array (`data`),
> which was also done in the mentioned commit.
> 
> However, commit edec42821911 ("wifi: brcmfmac: allow per-vendor event
> handling") inadvertently caused a buffer overflow, detected by
> FORTIFY_SOURCE. It moved the `event->datalen = datalen;` update to after
> the first `data` access, at which point `event->datalen` was not yet
> updated from zero (after calling `kzalloc()`), leading to the overflow
> issue.
> 
> This fix repositions the `event->datalen = datalen;` update before
> accessing `data`, restoring the intended buffer overflow protection. :)
> 
> Fixes: edec42821911 ("wifi: brcmfmac: allow per-vendor event handling")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://gist.github.com/nathanchance/e22f681f3bfc467f15cdf6605021aaa6
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Arend, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Zc+3PFCUvLoVlpg8@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


