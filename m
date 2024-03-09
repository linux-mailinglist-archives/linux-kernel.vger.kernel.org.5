Return-Path: <linux-kernel+bounces-97709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5F876E2F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A116C28327D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1CF15AF;
	Sat,  9 Mar 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVoVrmAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA7627;
	Sat,  9 Mar 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709944577; cv=none; b=GZtrwdA6N9r0BRCViv8k2tVdvavhZVDHJTMnmXqUTV/waYZWhe0mVvFJBCDaDwe2C+BvLoz/Veu5cXxuddUJ7XAYyJCuiiRwpaHyqtt9CRdAAxgnOWmlMJvmVwH3/M34wQdEJxCZjCwwuR8AmSLUgr7Gyk655DddNyssjjY2qUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709944577; c=relaxed/simple;
	bh=Bng1q+YJswEAXf80mAEaFjx8w+gbJ2x3xqqQcut85fo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fRtrCRHymnWov7S3GKzZhJOR/QVU/8unzo2XNdgbjvoW8KccQllSa0MTyNLc+R3p0VAxe0BPYB3452Cm4jfjNVNVYkdBlDLdPf3FvhZd9+8V5mmZNBLzMhYAa0n4NHXN1NhT3tx8jVzoX13gPVDIJ4fKxQWap+zDYSDFUjT3TRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVoVrmAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F13C433F1;
	Sat,  9 Mar 2024 00:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709944576;
	bh=Bng1q+YJswEAXf80mAEaFjx8w+gbJ2x3xqqQcut85fo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MVoVrmAEPP7/qY+yUiy5AAWJhzqgmxORvnh1AbY4b81TvTIW9Jf7UChHZAjPgdJFp
	 Nepch4g0iSfcCGbzM14T4zKl8Qh+DX/ecOyYdfmAl4J2/PHD2AedHKVd6D1kOimSgc
	 Y1s3WVb3WBqh2n37w/F2S1wBP71BCc+dkqslvWGzaNpx2MUfhY1vwHitRJep00VSJ3
	 jWYsnn6ruJJpDPr9AYukJt13KgZHFvAUdQ0pUbWGD3OtvpDT0FPDG+Do44y7Kyud0k
	 EZ+wLCzKyG4YCiEWT6Ad2k7aTh3WplRNuUOResFTQeu30+8VM2MTo2gvBqKb/SJkE8
	 iAjDfX8EKDMhQ==
Message-ID: <b809a691de642231b687358eb4bc03aa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-1-25f348a5982b@linaro.org>
References: <20240302-linux-next-24-03-01-simple-clock-fixes-v1-0-25f348a5982b@linaro.org> <20240302-linux-next-24-03-01-simple-clock-fixes-v1-1-25f348a5982b@linaro.org>
Subject: Re: [PATCH 1/2] clk: Fix clk_core_get NULL dereference
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rajendra Nayak <quic_rjendra@quicinc.com>
Date: Fri, 08 Mar 2024 16:36:13 -0800
User-Agent: alot/0.10

Quoting Bryan O'Donoghue (2024-03-01 16:52:14)
> It is possible for clk_core_get to dereference a NULL in the following
> sequence:
>=20
> clk_core_get()
>     of_clk_get_hw_from_clkspec()
>         __of_clk_get_hw_from_provider()
>             __clk_get_hw()
>=20
> __clk_get_hw() can return NULL which is dereferenced by clk_core_get() at
> hw->core.
>=20
> Prior to commit dde4eff47c82 ("clk: Look for parents with clkdev based
> clk_lookups") the check IS_ERR_OR_NULL() was performed which would have
> caught the NULL.
>=20
> Reading the description of this function it talks about returning NULL but
> that cannot be so at the moment.
>=20
> Update the function to check for hw before dereferencing it and return NU=
LL
> if hw is NULL.
>=20
> Fixes: dde4eff47c82 ("clk: Look for parents with clkdev based clk_lookups=
")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

I dug through a bunch of old patches and this looks right. I'm not sure
why a provider would ever return NULL though. A NULL pointer means that
the parent is never going to appear so we shouldn't treat this clk as
orphaned in case the clk needs to be clk_get()able and change parents.
This was all part of my plan to introduce a clk_parent_hw() clk op that
returns a pointer and then implement probe defer through clk_get() when
a clk is orphaned. A NULL clk also means a clk is optional and not
there.

Anyway, I've applied this to clk-next. I hope to send out the
clk_parent_hw clk op series soon.

