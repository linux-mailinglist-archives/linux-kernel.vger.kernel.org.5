Return-Path: <linux-kernel+bounces-49681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7D846E12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4756CB29B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F513BEB7;
	Fri,  2 Feb 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrx9tZLd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4A82896;
	Fri,  2 Feb 2024 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870101; cv=none; b=RKAbu7cNGbtTaKpZiP0ItLd4KUETUoSJ8f8uId8/sncjuAjWsYPy6/FqyeMHMbJtUU3eL34mTYVlfm+kqnh/OkjtCraXQzDqBDhFit27VeIVTkbb3vbGfoh8WX1sYJl3PCj5qIeAr5hpKbRwo+fivmjj2UmeqTIII3GsTvKq0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870101; c=relaxed/simple;
	bh=uD/sPc7FMJ/uY13jycAiw319CMk1mhe2FbFR5UM4LCo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BM3R6+GG9XFfT8yDPv4rBlAdl1qf6z1+FCeKxmzyxKwDIRKupMmHB/5Zb9vL0gVpTAJYzYE2TujwPZxfUwK6VNouO9xn3bF2NHlYrVVTF6MQA+6hP+TnACVh62sD1pxYvHZ2XvZLdZAU66HhHnPPdIjypKgmG/BnkSshv7IhBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrx9tZLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E41DC433C7;
	Fri,  2 Feb 2024 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706870101;
	bh=uD/sPc7FMJ/uY13jycAiw319CMk1mhe2FbFR5UM4LCo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Rrx9tZLdm0GUAzf3hhCrj99t2K7tE2YFipabCOhmLwfTwbP05vhk0npEfIycZWRQY
	 LDXyp9K5JgESqlVT3Si1xDf0UlR+CePpjDYRZtQmonq5efdbNuyrMe7dvvOpRSIgkF
	 AAu1NVzwj65B+bCxC+Pgf3ahfp96h7ZP4MV1O4iQ1WjhhROuzLY1RzlwYa+SEtHEfy
	 +6EputEp7XjMrfLzfOPCsifhzBNQeyU/3xL9pB++tf0nhs1YWkSSp2luaoUDpPmSk0
	 GQKUdjXcG8C6/LbXJdaqrs2W53Jl5C2wvDoCz6Q/gATd3c+APGY8keSSAAUWR79m1D
	 bvBJChBiCeB6g==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <aspriel@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,  Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
  Chi-hsien Lin <chi-hsien.lin@infineon.com>,  Ian Lin
 <ian.lin@infineon.com>,  Johannes Berg <johannes.berg@intel.com>,  Wright
 Feng <wright.feng@cypress.com>,  Hector Martin <marcan@marcan.st>,
  linux-wireless@vger.kernel.org,  brcm80211-dev-list.pdl@broadcom.com,
  "Gustavo A. R. Silva" <gustavoars@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>,  Jisoo Jang <jisoo.jang@yonsei.ac.kr>,  Hans
 de Goede <hdegoede@redhat.com>,  Aloka Dixit <quic_alokad@quicinc.com>,
  John Keeping <john@keeping.me.uk>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
References: <20240126223150.work.548-kees@kernel.org>
	<170678189299.2736043.11616312910656558919.kvalo@kernel.org>
	<a91c6a28-6762-41cf-bb85-09e79f3d29d4@gmail.com>
	<d4855223-4323-43f1-9a29-e279e2cb128c@gmail.com>
Date: Fri, 02 Feb 2024 12:34:54 +0200
In-Reply-To: <d4855223-4323-43f1-9a29-e279e2cb128c@gmail.com> (Arend Van
	Spriel's message of "Fri, 2 Feb 2024 11:00:51 +0100")
Message-ID: <87v877tar5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arend Van Spriel <aspriel@gmail.com> writes:

> On 2/2/2024 10:58 AM, Arend Van Spriel wrote:
>
>> On 2/1/2024 11:04 AM, Kalle Valo wrote:
>>> Kees Cook <keescook@chromium.org> wrote:
>>>
>>>> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>>>> cfg80211_scan_request with __counted_by"), the compiler may enforce
>>>> dynamic array indexing of req->channels to stay below n_channels. As a
>>>> result, n_channels needs to be increased _before_ accessing the newly
>>>> added array index. Increment it first, then use "i" for the prior inde=
x.
>>>> Solves this warning in the coming GCC that has __counted_by support:
>>>>
>>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In
>>>> function 'brcmf_internal_escan_add_info':
>>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46=
: warning: operation on 'req->
>>>> n_channels' may be undefined [-Wsequence-point]
>>>> =C2=A0 3783 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->channels[req->n_channels++] =
=3D chan;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ~~~~~~~~~~~~~~~^~
>>>>
>>>> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>>>> cfg80211_scan_request with __counted_by")
>>>> Cc: Arend van Spriel <aspriel@gmail.com>
>>>> Cc: Franky Lin <franky.lin@broadcom.com>
>>>> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>>> Cc: Ian Lin <ian.lin@infineon.com>
>>>> Cc: Johannes Berg <johannes.berg@intel.com>
>>>> Cc: Wright Feng <wright.feng@cypress.com>
>>>> Cc: Hector Martin <marcan@marcan.st>
>>>> Cc: linux-wireless@vger.kernel.org
>>>> Cc: brcm80211-dev-list.pdl@broadcom.com
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>
>>> I'm planning to queue this for wireless tree. Arend, ack?
>> This slipped past my broadcom email. As the Fixes commit is in 6.7 I
>> would say ACK.

Thanks.

> Cc: to stable?

Is commit e3eac9f32ec0 in stable releases? (I don't follow stable and
don't know what commits they take.) I propose that as we have Fixes tag
let's not add cc but instead let stable maintainers to decide.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

