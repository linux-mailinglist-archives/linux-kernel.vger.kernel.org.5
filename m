Return-Path: <linux-kernel+bounces-83409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEF86989F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D55B22F70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03113EFE9;
	Tue, 27 Feb 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbNUhTWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE435FBB3;
	Tue, 27 Feb 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044987; cv=none; b=As5++8SCX5ZBrou5qmDruEe4I++PuY7+hqBbkWC/Ky2JRrnNZNzg7eGjovr35KkNb3RYUwl73EkBewLW3tf8piFzNhB4AtLQZykumOhArUhfNWrca3zTuj830GNG+Vp2aYf34oV4k8N/O8gK5yR3a2rEsJluizjJ8WXSqweSnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044987; c=relaxed/simple;
	bh=DytXs2Kq0REoXTCul2OemM5lmaQM/IuOHuGspWgLqzE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qlftXM16u2YlCI19/aGUe2aAPGxYwDzxAlZI0QMgVv+X0WWes6T02BC6kHS8Zs6veVwwCLRbu4toI16J591RVrQ/nqh3dJYHK5Us0Te3XNDBiN4ieQtyzE6QL2nFjW6ZIXSAGWTSUo2AkcTaprD9pDvADViw6VIcwnPuJuA9IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbNUhTWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AC5C433F1;
	Tue, 27 Feb 2024 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709044986;
	bh=DytXs2Kq0REoXTCul2OemM5lmaQM/IuOHuGspWgLqzE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=EbNUhTWrqo+/uOMGcfFC5ZLud5wfMJbPHX8Otm3B0bpuLpcQ3IMmM+zlMSKf5Sn6z
	 lvqLVvy7L6Z7skS7FNmTuqiz03t6SuTTHRTjXcsY0Et5wfVcs+D8cBCt4GmBjdr44s
	 kQx9y0PKNpzvOO9a72dNEPyzfseNNNMNKTvsHWjxnaJpkUom7xBRPcfz6a6LC7LAzs
	 ZGN+JQYRA1gbr+W4bzYJFKBD9GoLtd/w2U+4kEbFuHyvsIveXqj4xYaPG0HTy0BmrU
	 i6+hCLqyBrWwjzF+cYrNSanCLqmWSXPhw6eg4UNevsFVK/MLqkX0ryXMs05kgQpoKk
	 3onbxDufNjDTQ==
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
Message-ID: <170904498245.3524945.4143383846872449498.kvalo@kernel.org>
Date: Tue, 27 Feb 2024 14:43:04 +0000 (UTC)

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
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

ec1aae190c77 wifi: brcmfmac: fweh: Fix boot crash on Raspberry Pi 4

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Zc+3PFCUvLoVlpg8@neat/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


