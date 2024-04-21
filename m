Return-Path: <linux-kernel+bounces-152628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63A8AC1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DBF1F210AB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08B4AEC3;
	Sun, 21 Apr 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+DmL6vK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8D481D0;
	Sun, 21 Apr 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738579; cv=none; b=PkkwnW0ZPGx6r1Xtgz+NT7MsNSALyzWe6KmT96EsVmcvKI+3jnOwTfAZ/u0GdEtISrcR10ecAFmirzDSdisdL/TevIcRz4ehMo6eJN5kfo8PIGGhOSUrH+tMR7R6Amks5vUferiFVqLp+ye8KCywlE1bUqfjMdHUtmxJX54UIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738579; c=relaxed/simple;
	bh=TvpB4hNHca+7QPnuaPal+6j+stFWkCCMVIxc6A+e3Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljVASlL/pNFVx2QWlGCwroTMlEbOfqwSGtLUwuOnI6tu+XTwcRW7kL995bDrSuaqeQxQWwhFr1t/LVCRW3y/awHfJ1DYorfvP+dK6p5edqqCW0kmqQsrIlWHsGk+8dpuqm38hb8RpbZJLNOoKMJ9hDR4LND+wBuYRmbv+0iWIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+DmL6vK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBC1C4AF07;
	Sun, 21 Apr 2024 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738579;
	bh=TvpB4hNHca+7QPnuaPal+6j+stFWkCCMVIxc6A+e3Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+DmL6vKsziiILMVbPIwntt81GBKnEDr7GfEzu0gtz+yW9ZK07+FI41uENdEwvI3S
	 2XH8ch84I1qU9riWPHwmt7Z9mcbk82Yo2zvNnEd1zl0H9TIq9U6e002w7g37pyfnpa
	 ln6XZmdOlwY3Fq/aSuUzUL26cQ2xoqLmublOzBFq+GoYWaIf2ncY0xEdOtIWu2WlY+
	 fc8SAtwWqEIydUyHC+2ORuVFf6gkXyeEhjbRoGN3JQbZuu+iVrosv5GjggYyBzCY7K
	 FPX/VN/59YKg9KAmN87mlcAtZQhWP6GxH4Opti21Ee1bHMLn5wYjv8vOkIr9qt4/jN
	 mzRfEWTbXyWqA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] soc: qcom: cmd-db: replace deprecated strncpy with strtomem
Date: Sun, 21 Apr 2024 17:29:13 -0500
Message-ID: <171373856769.1196479.1804405630456306049.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319-strncpy-drivers-soc-qcom-cmd-db-c-v3-1-aeb5c5180c32@google.com>
References: <20240319-strncpy-drivers-soc-qcom-cmd-db-c-v3-1-aeb5c5180c32@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Mar 2024 21:19:59 +0000, Justin Stitt wrote:
> strncpy() is an ambiguous and potentially dangerous interface [1]. We
> should prefer more robust and less ambiguous alternatives.
> 
> @query is marked as __nonstring and doesn't need to be NUL-terminated.
> 
> Since we are doing a string to memory copy, we can use the aptly named
> "strtomem" -- specifically, the "pad" variant to also ensure NUL-padding
> throughout the destination buffer.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: cmd-db: replace deprecated strncpy with strtomem
      commit: 166db01007ea802ff9933ac73ec8f140ca0cf5d5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

