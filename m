Return-Path: <linux-kernel+bounces-90300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BA86FD20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FDD1F25B07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9F22099;
	Mon,  4 Mar 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuJm+66A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51A12E73;
	Mon,  4 Mar 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544095; cv=none; b=gadWbYku6mElee2ogQhFFctaCTvH75OKOElxTch/009EhQGlspa/TLIUBEBATkahSZ5bfQTOYA7ozc+7o1K6/FHttFmLmr89gnfeDxfZoiCxG3qbdwHWzrB1TkNcLkiOXIcXuPTtx3pcx0hJaiM8u9AfJ3cme25YmwLszEyq6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544095; c=relaxed/simple;
	bh=lOa50vXkrUsDFtIi8C9JTx4wGk9mm9mtJoD1tNnorho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjXh+AU9vpnu1Cf5IO2hxl2RI8dBBr2V46MmHD9mCzsMEk6v2l/4nDffYM+cCpLUPlbm8aZ+2/KCMLZV52N0arda3h+S6Nuur0jMMtvt+9LWM7yx38PqLK1/WKYniRQdOvnVgpBBBbVMD41qdTzu9NPFTnN0OsEaPpBnelXzYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuJm+66A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F12C433F1;
	Mon,  4 Mar 2024 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709544095;
	bh=lOa50vXkrUsDFtIi8C9JTx4wGk9mm9mtJoD1tNnorho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DuJm+66A65ap4KUPFek0FET5sProtZDdcqySyv4Ul+T1yfNKR9kVXRW+8oDwbqxkv
	 vJZo3BSdIZMFm9s26GuEGVaWmLwUUID1UZILQP6Xn9Irz4uFM51yANy5RxC1sgR7Lt
	 zIFuf0aIuq68BiM7j56YWAu7uAS6IXzO1j64R56Uf0R+ThNBig/04DQFMfrH/qj7Kl
	 huXHMOqvpyO9A/YdbnUarXTi0IorJLnPtDTvziVbUHjkw+Dcfq92/G7XJDPzIdENUl
	 zR+cqviNLc2cVXHSgNl45BD/10truw82TOgP+5fhZ4WT3+UIHpmXuGrBsuxAVC/sLV
	 7ZVo+FTdL2Wgg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh4Vz-000000006M9-1I22;
	Mon, 04 Mar 2024 10:21:43 +0100
Date: Mon, 4 Mar 2024 10:21:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] usb: ehci-exynos: Switch from CONFIG_PM guards to
 pm_ptr()
Message-ID: <ZeWSp4ohOhHGclud@hovoldconsulting.com>
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301193831.3346-3-linux.amoon@gmail.com>

On Sat, Mar 02, 2024 at 01:08:09AM +0530, Anand Moon wrote:
> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM are disabled,
> without having to use #ifdef guards. If CONFIG_PM unused,
> they will simply be discarded by the compiler.
> 
> Use RUNTIME_PM_OPS runtime macro for suspend/resume function.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/usb/host/ehci-exynos.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
 
>  static const struct dev_pm_ops exynos_ehci_pm_ops = {
> -	.suspend	= exynos_ehci_suspend,
> -	.resume		= exynos_ehci_resume,
> +	RUNTIME_PM_OPS(exynos_ehci_suspend, exynos_ehci_resume, NULL)
>  };

This is also broken and clearly not tested. See the definition of
RUNTIME_PM_OPS() which sets the runtime pm callbacks, not the suspend
ones:

	#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
		.runtime_suspend = suspend_fn, \
		.runtime_resume = resume_fn, \
		.runtime_idle = idle_fn,

Johan

