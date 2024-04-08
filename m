Return-Path: <linux-kernel+bounces-134724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C089B606
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195591F217C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0C1851;
	Mon,  8 Apr 2024 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBxkMY56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF94C8A;
	Mon,  8 Apr 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712543762; cv=none; b=daO46pb5Bnze6GHMkkh4V7okh2yUAQOebl16U+tXGOh3/yAC7w0Niu/moMoKXsLAibJplmG5POTQuUy0+4Km2uis292X2QCpLGerLELRcycGoNUUu4ujDqvB5OKJ8JUzFl6qW2FEebIh9DnUypARq5WrSRwnvKXZ1x8ROZegUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712543762; c=relaxed/simple;
	bh=vPKyhuBswSLMcWjuIQwilDEd+Az3YtYSaPyId04YfEE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=h5CQuuLVP+yLP99/ezNxGb2gdsuPVAKYXjwTzK45TRkwfpIbsvVD2ZFrBjobEnFWhpy88CG9XZnEt3ud2SR//LmuzWHfW6SRLpRuyi15NhR74m91mG6AYoEppGgm6yyrm0fKs4/KRklF/mZY5bkiyvGRIrQx9bQAumve/P32Uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBxkMY56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF8AC433C7;
	Mon,  8 Apr 2024 02:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712543762;
	bh=vPKyhuBswSLMcWjuIQwilDEd+Az3YtYSaPyId04YfEE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nBxkMY56Iy+gTlh1T98M4KTbfCUwyqamxEHqeqPu+i5O7z1V4MJ/ZPSsrXVbBxKAZ
	 UzzKOH9lbfqom1tYIbbdtJbJuN72IqWEUaS9gs4Rn/DfFgN01hYjVpEzkw4YYeVeCT
	 zlGgpBA9F1aKionVlbpznA5EybBSeSeDzBx4Sxg9/8gCRtmrU1GbKU9nHbvV5dy73Z
	 9GS1qam4q8ziPgGk7LiKkQzgqr86bS1UkS8qxOJDqpxWILrlGgPdGWjCED12nM+cbF
	 9U7M/4aKJPDu48FIAa+3tw4hpyRgme/PEasHGjxI8dukhXd9cq/I6YYOvZ5n1Qxtoh
	 oBskEjL5F6wpw==
Message-ID: <98005e3174d43b96e774458b37fd515f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240325184204.745706-3-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-3-sboyd@kernel.org>
Subject: Re: [PATCH v2 2/5] clk: Don't hold prepare_lock when calling kref_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Sun, 07 Apr 2024 19:35:59 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-03-25 11:41:56)
> We don't need to hold the prepare_lock when dropping a ref on a struct
> clk_core. The release function is only freeing memory and any code with
> a pointer reference has already unlinked anything pointing to the
> clk_core. This reduces the holding area of the prepare_lock a bit.
>=20
> Note that we also don't call free_clk() with the prepare_lock held.
> There isn't any reason to do that.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

