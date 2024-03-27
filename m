Return-Path: <linux-kernel+bounces-121867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0098988EEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3F11F2D6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D51514EF;
	Wed, 27 Mar 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF3JRb8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015511509BC;
	Wed, 27 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565868; cv=none; b=sOt25esHaIKMUiWs8EhVUK9PC9Jh9BERkdIvR4NUIBBEViUJo5Y1N1VcSfr73GuAONg0lEGFKIDv9Ky85HzJyqN7gs5TB8Ey1kg9vAbxY337EE+9nDJfTobsUlE+9gbBspAxwsDkLvi7dYQWxG/+nwzr9tRfZIBQCN6aeFadi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565868; c=relaxed/simple;
	bh=EC6Lhxkjvx1RpPe8rDFDyBQQQkJxJTIgY5bGiM+h7Xw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=taolIKfuO8g8we1k/8V6b4S9D9NOVivL49Nj6N1bWrS+6AoCBPi8Vsr5mlwV3CZ6u93ODYz0CIxO4pmKtvjSlS5Gjt1UprESaEohAnbtNfZY2qbM6+IPai6XnpHvKL+Ad6/tdqvKjKV/ovh0Kj3H64eEBWLJrruI2vL7u+yg9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF3JRb8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB5CC43390;
	Wed, 27 Mar 2024 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565867;
	bh=EC6Lhxkjvx1RpPe8rDFDyBQQQkJxJTIgY5bGiM+h7Xw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tF3JRb8K0zVTMpTpEUINfK+CRCiKDrrRZ5kQLkb0BVenivWSPFCRLdve5w+h+93Xi
	 iJw147g4OWCBX4pTW+AmkcfeD55W5Aj4V0HHjt+6YScU5f3z2bVyhoPS+NXr4E1D0b
	 tc1Vpgiok1EwSVNyiioQnJyL5xxC6WrfpCMYmdAe8i6nSQhqqAUbW4GKJOtpH8ETYH
	 z5K/yMe5sV7UERNL6DRbl9gO0SsgkBbzcepH9gABgkx4C4u0IMQ8TWZPuQNXiDpuZv
	 HkSyX/5+9hkz5vFoYB9/Gwm59PlzoW5RXEIhX9VR/cS+yGr+W1mtH5mTRmDflGq8O0
	 2yDSlN55MBqjw==
From: Kalle Valo <kvalo@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: cfg80211: Use __counted_by() in struct
 wmi_start_scan_cmd and avoid -Wfamnae warning
References: <ZgRqjGShTl3y5FFB@neat>
Date: Wed, 27 Mar 2024 20:57:44 +0200
In-Reply-To: <ZgRqjGShTl3y5FFB@neat> (Gustavo A. R. Silva's message of "Wed,
	27 Mar 2024 12:50:52 -0600")
Message-ID: <87edbv7b9z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavoars@kernel.org> writes:

> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
>
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
>
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
>
> So, with these changes, fix the following warning:
> drivers/net/wireless/ath/wil6210/cfg80211.c:896:43: warning: structure
> containing a flexible array member is not at the end of another
> structure [-Wflex-array-member-not-at-end]
>
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/ath/wil6210/cfg80211.c | 22 ++++++++++-----------
>  drivers/net/wireless/ath/wil6210/wmi.h      |  2 +-
>  2 files changed, 11 insertions(+), 13 deletions(-)

The subject should being with "wifi: wil6210:", I can fix that. (Didn't
review the rest yet.)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

