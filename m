Return-Path: <linux-kernel+bounces-39888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B43183D713
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34D529B40E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB61CF94;
	Fri, 26 Jan 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP4gaoBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A371428E;
	Fri, 26 Jan 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260058; cv=none; b=e3FBPlxHgb9ICTpjMknEFrtdm7E9AUxp/EyydM0ligi7qJXd6DP6LOdZxQn1HuinyAWbXtANU33v8zsmA1nJpEQJxXRuUHfm04SmMAyiigtohSWUa4CX+ZmRe4uqMGEYafg955PB5BX8BDhPaN4V9tjuxKqkiCQmFtVE+8wahyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260058; c=relaxed/simple;
	bh=oebNiettGESaAJQHOpi1TBvd5lz5JYV/8vgPP+Wae1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYiD0fJwUqNhC7gWyNhtMwwuC1D9XpifsCa3C1iyAqITCXauqtk6gEPlK/LPe2MTQFy1TeClqOzUNO05swc1/SsN2g/TnKZVa9eBnF6DxRpz+uWPKgi+WRSbTJehfxpZUlelCxt4pCykKNygB0+9k9RrgQQbWoclv4Puh1/hoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP4gaoBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB06C433C7;
	Fri, 26 Jan 2024 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706260057;
	bh=oebNiettGESaAJQHOpi1TBvd5lz5JYV/8vgPP+Wae1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP4gaoBruqekm9lG7/v4GzhWqKcrBslGTXHkPsfOrj5f4FZ4SZRGrvBXjPmy32L72
	 SGbQmqMuyCeTySeVSLglKkKlwY27DCPP0csJWQgleQpFC/Zlr8LQ7ibJOhX5UfiWbi
	 DMIOabubA1aSFLvknmwsZWqRTJKBrWi48Eoq+fjQ0g9o85pva6vZDTxxZIPc77s6UU
	 glX9IXTcXG+CLZz/TfeXoLIrYzRavgUkfKxSwTnT66lfnzEuKmPo4R3qan79jrOaaX
	 XlMYSqhEvnrIgtQQxKBtI3TPlO39ox0Wq2XXFQtXB6+n9O8GIcK/vIs7yI4NgliRgF
	 NTx/BQhq9/q3A==
Date: Fri, 26 Jan 2024 09:07:31 +0000
From: Lee Jones <lee@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: (subset) [PATCH v3 3/3] mfd: cros_ec: Register EC-based watchdog
 subdevice
Message-ID: <20240126090731.GP74950@google.com>
References: <20240119084328.3135503-1-lma@chromium.org>
 <20240119084328.3135503-4-lma@chromium.org>
 <170618986350.1469172.17149163593213396683.b4-ty@kernel.org>
 <CAE5UKNp5oorZMJwor=8Z_2wtCSS23Q1-25_RNoDHNi1USx5_7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5UKNp5oorZMJwor=8Z_2wtCSS23Q1-25_RNoDHNi1USx5_7Q@mail.gmail.com>

On Thu, 25 Jan 2024, Łukasz Majczak wrote:

> On Thu, Jan 25, 2024 at 2:37 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Fri, 19 Jan 2024 08:43:27 +0000, Lukasz Majczak wrote:
> > > Add ChromeOS EC-based watchdog as EC subdevice.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [3/3] mfd: cros_ec: Register EC-based watchdog subdevice
> >       commit: a1958f84deb5cdba020af725fc5003a05af4819c
> >
> > --
> > Lee Jones [李琼斯]
> >
> Hi Lee,
> 
> I will send V4 of the patchset to address Krzysztof suggestions, in
> that case I should skip adding V4 of this patch and have only patches
> 1 and 2 in the V4 patchset?

Yes please.  No need to resend patches which have already been merged.

-- 
Lee Jones [李琼斯]

