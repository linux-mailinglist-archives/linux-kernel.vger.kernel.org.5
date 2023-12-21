Return-Path: <linux-kernel+bounces-8742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA181BB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1332B23DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8A76DB6;
	Thu, 21 Dec 2023 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqHxzRBq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C476DA7;
	Thu, 21 Dec 2023 16:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C21C433C9;
	Thu, 21 Dec 2023 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703175016;
	bh=XsGNm0AxLUX5TyAOH4kb3dbYCONd1jCjNAPoAGbgUWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqHxzRBqprviCEjX4TSX525TtrRC+DrWK5vfRRRPInYxRq3M4FtPoKPCiMwcva6pp
	 rabxccGeq586WlCdJzFh+m90tDMhvAqrQhSCDesoz1Y443g5Hoj9xhJnC92dcGitut
	 spf8qIgNQWfVtgrvwrm4/+C9PhbwTPxIF+hKgcEW2aTfRpI9tFSe30F5alXlT2E3mp
	 QplsFJ+WsKMvjo+2QlMUheOlhUbjz8cbD810DsdKolrq7qmsiEfiwhA5ST6GAEcb/U
	 IT0TWPkMXI9XG6bBx5Rm75223yKnK2I4vLPPFU25CpukFt7cHolFIPoMVpC672u+IW
	 AX8p3wNd3of/g==
Date: Thu, 21 Dec 2023 16:10:11 +0000
From: Lee Jones <lee@kernel.org>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@salutedevices.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <20231221161011.GO10102@google.com>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207125938.175119-2-mmkurbanov@salutedevices.com>

On Thu, 07 Dec 2023, Martin Kurbanov wrote:

> This led-controller supports 3 pattern controllers for auto breathing or
> group dimming control. Each pattern controller can work in auto
> breathing or manual control mode. All breathing parameters including
> rising/falling slope, on/off time, repeat times, min/max brightness
> and so on are configurable.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
>  3 files changed, 1031 insertions(+)
>  create mode 100644 Documentation/leds/leds-aw200xx.rst

This interface is bananas.  Exposing an entire register interface to
sysfs does not sit will with me at all.  When we add support to a sysfs
class, we usually require it to be generic and work across all devices.
Adding device specific interfaces is generally decried and to be
avoided.  Don't forget, once we commit something to sysfs, it becomes
ABI and we have to support it forever.

A far better approach would be to add support for this in userspace
instead  You can use the standard I2C character device API to achieve
the same result.  That way we don't have the same level of commitment
and is generally a much more flexible/future-proof.

-- 
Lee Jones [李琼斯]

