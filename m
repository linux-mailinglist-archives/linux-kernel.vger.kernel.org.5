Return-Path: <linux-kernel+bounces-34795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C64838789
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F928A7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1F524B2;
	Tue, 23 Jan 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcTUt/F4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0365524A5;
	Tue, 23 Jan 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991768; cv=none; b=jH1kyNum8kTS1hDi3gP14+cKE2Sgu+qDq1jZlUZkNKhl1Uwa4SRe1+Lrx4HIcw8XAgM9YWSMNhbcaBzaTWv8va2od8c3tDAfhDSJrRogMuIOp9fjclJAvHXDq1mhJX7M7wEXIkmsWmXw/6nKB3GsC6K5O/JLLBt2e9mrYyaEnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991768; c=relaxed/simple;
	bh=ukafp/8jphsufSCnQJqqiNhF57sNngiILnTZ9/2MUCM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fITbyQB/G3V1h2mjy4KsPlkg/nlymJ/c+JKNbDHtpp/5uzikaVK0GOhexDQWwvh0DfH9chGFpv+a8jJN2++APDgIuXdGGxFPWzVPP3JAHi2m+PZ4IAVRDWYHPQ9/Anr0jcTHJlhBiT9NaKK5EGhZMeYzkmeu5dUaD570sy1wACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcTUt/F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45237C433C7;
	Tue, 23 Jan 2024 06:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705991768;
	bh=ukafp/8jphsufSCnQJqqiNhF57sNngiILnTZ9/2MUCM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AcTUt/F4qkfV/qIWDhzXc2BDbdBiqbN+lyQH/Zv5qtRgRgn686G+wSEgXFB5Y5ZJl
	 4tcOIbAL8yf3kSXNfybhtuHMzjj9bjNmm7u+OuRY7V/aDmhnanpyH26JS4bFYC3GgG
	 yBLGwax0grx8SrooHE+SceDWq0goqKv2RDKXlljKSh8R6rwR/xACsKG7tmBZHA344e
	 kY1IZPt5z7FsuwKtcdSP3MqRTo2AnH+516c4GCwnJma7v5L6NTw0yTBJSW6GuPjVNg
	 VMogN/UCHUOZMAJtPkeraMKwwC6ZbkIvVUj2YUeclRChYg6MOws/oU70foVwnzUrPr
	 Wlmc0G/k2Oidg==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,  Johannes Berg
 <johannes.berg@intel.com>,  Max Chen <mxchen@codeaurora.org>,  Yang Shen
 <shenyang39@huawei.com>,  linux-wireless@vger.kernel.org,  "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,  Bill Wendling <morbo@google.com>,  Justin
 Stitt <justinstitt@google.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
References: <20240122235208.work.748-kees@kernel.org>
	<20240123002814.1396804-41-keescook@chromium.org>
Date: Tue, 23 Jan 2024 08:36:04 +0200
In-Reply-To: <20240123002814.1396804-41-keescook@chromium.org> (Kees Cook's
	message of "Mon, 22 Jan 2024 16:27:16 -0800")
Message-ID: <87fryoeeuj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Max Chen <mxchen@codeaurora.org>
> Cc: Yang Shen <shenyang39@huawei.com>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I assume this goes via some other tree than wireless-next so:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

