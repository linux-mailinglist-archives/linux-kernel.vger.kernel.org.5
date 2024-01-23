Return-Path: <linux-kernel+bounces-35218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB6838DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230C41F235A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33995D907;
	Tue, 23 Jan 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZgXUmTm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C845DF01;
	Tue, 23 Jan 2024 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010637; cv=none; b=sbvEnfZ7aFfuVajXz1kWjBbXU9CS2yZLjZnTm3ywOcctffEUnJqM9htP1AkzCLAhqkYZNToq2Z17bgZjIisthvqBRFZ7FlAIj35rchNI2/3Ht/eaeJL76zj/uvU+lFXf+NeePemHT7aucDNaS/5Nwy08+r3Ca3Awk2anvKqfpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010637; c=relaxed/simple;
	bh=uSTO8tH5YxpcnUPEXZwGy9prSprH8Zu1Qe34MWqhmyY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=e6wevvrxQXnuGxnUiSz9sputvWp6fbd2v+m37y1d1sX0AgQuBjGKvaCd8GvVoAJhnta4RSNcHJFsrxHaCXbhAVtKwkgXQgXdGrnvfOq1oU9d2oytsIbP+InAf+uPr69yqpwM0ESpjDyBx1QvgmfbSuh+8VcKsaXUSRIhPt1pawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZgXUmTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE4AC433C7;
	Tue, 23 Jan 2024 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706010636;
	bh=uSTO8tH5YxpcnUPEXZwGy9prSprH8Zu1Qe34MWqhmyY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cZgXUmTmwr71LfYbg/xyAdSCYpFflWAb9FF9yaqxLkHGt+txt3QMj0ZAPQQ4VO8Vl
	 ppCBCvi8PgdTjeo67hXb0USc/Y/1RhWieCaoce5/aQZzSZO/t9hP+EpEw2DncoSk37
	 gDJYhys/PqHbJ5kUfnc04U4t84GPXl0lZAPxvT4AtoAWMyPbnjekAf+JeQFfEcvnLT
	 RbBp2gWc1VV0vneDDnXG4fVMDub1tIDGR9FgodUgaf569MFrKQ3XYHaPueqEDiwcQL
	 2s5yxB1YpGoq/G/hM9JPvCyv9+lhi69CAgCDg03V7ZiofHt6b4tcaU6ZC7qr8F7jYa
	 lJDfYW3nstsVg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240123002814.1396804-41-keescook@chromium.org>
References: <20240123002814.1396804-41-keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Johannes Berg <johannes.berg@intel.com>, Max Chen <mxchen@codeaurora.org>,
 Yang Shen <shenyang39@huawei.com>, linux-wireless@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170601063238.3962299.12030024839048269322.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:50:34 +0000 (UTC)

Kees Cook <keescook@chromium.org> wrote:

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
> Acked-by: Kalle Valo <kvalo@kernel.org>

If you can edit before commit please add "wifi:" prefix to the wireless patches:

ERROR: 'wifi:' prefix missing: '[PATCH 41/82] wil6210: Refactor intentional wrap-around test'
ERROR: 'wifi:' prefix missing: '[PATCH 62/82] mwifiex: pcie: Refactor intentional wrap-around test'

2 patches set to Not Applicable.

13526631 [41/82] wil6210: Refactor intentional wrap-around test
13526632 [62/82] mwifiex: pcie: Refactor intentional wrap-around test

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240123002814.1396804-41-keescook@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


