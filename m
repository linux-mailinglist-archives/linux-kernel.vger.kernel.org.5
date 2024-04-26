Return-Path: <linux-kernel+bounces-160765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7F8B4284
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92326282E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD013B79C;
	Fri, 26 Apr 2024 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUehiLxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6639856;
	Fri, 26 Apr 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172941; cv=none; b=cAHG9Z2wyO0WcJ1SRjXPI2OxLhnMi6hqYg7DXJ/o5z03h7/+cGoJGddE8vP5E38RLb1uNfedAlpGY9NEUJfhEC59/tP8jutgdr8ICu+RuW1Y4IsjYsKXNrSIzGD4Qzy1kGbPzAtN22D26W7RxWO80o2q6cTd/ZIK3/rzcfH1HTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172941; c=relaxed/simple;
	bh=p+cKiUn2VL+RJktr+WjG/vP3wD27ZIONdGoHGJp9t04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgJJcoBYbtJGLLbnzEIM4vzL3GXPm321bHGumbiBlyPwoCfzw0V8yT6vtkhQMeN6xDEz0c7gEoM6PjBK5iuyZ2UQrwDJdoV9xRiSHqw+arDKeyuWZXiSBj810gHPUIHYpMHdabD0YKblb8ppOjxKw45eUxoxlHXY1ZohFWFYuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUehiLxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87E8C113CD;
	Fri, 26 Apr 2024 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714172941;
	bh=p+cKiUn2VL+RJktr+WjG/vP3wD27ZIONdGoHGJp9t04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LUehiLxWdJ8VO9fbFo4nDuWp8X7f4OUefScfhzwrzONX6U9zKtdaajfV8JtCHoHHd
	 g+Sg0d+PXwF5n/Oyxzq4F+5tq04NOnBENhyXqorD8+PCfvFfZHvcIXAMATNf0Pnbrs
	 XTZyTTwXVfSHfLtCuECmUvGXE9cgXaX01qI1wmAeovA6Uiw4qDTK4RAHpOhQnJ8xAf
	 TNvtKXNpkcwjUXU3t6gOoD64cylRisqMXt7QmXaniwNiY/Wu5kYmv2SNJK+9fOCUrq
	 2OKqO/E9lbwSSFdEmVlgVO5oO1yyJ4QMNDhvORldQs/Yh4QW7DWOKWw589cpUPdFh/
	 8APu90B7c0q5A==
Date: Fri, 26 Apr 2024 16:08:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu
 <jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240426160859.0d85908e@kernel.org>
In-Reply-To: <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	<CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 12:20:59 -0700 Mina Almasry wrote:
> -       if (recycle && napi_pp_get_page(page))
> +       if (napi_pp_get_page(page))

Pretty sure you can't do that. The "recycle" here is a concurrency
guarantee. A guarantee someone is holding a pp ref on that page,
a ref which will not go away while napi_pp_get_page() is executing.

