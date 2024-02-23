Return-Path: <linux-kernel+bounces-78119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A67860F27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EFDB231F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14735D499;
	Fri, 23 Feb 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgkVfhRH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349D5CDC9;
	Fri, 23 Feb 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683840; cv=none; b=eJPjNuZiB3uidDzJ8ljvy/v6Qy7tQUrRqWuyAcYMW1YEColXuHOIyqAPNndDI88/f54elIyoAn7yoDfLUiRj6KvIAnqc0VpPDnEJxyKm1pUZpfQ2xmB3fmCCvsFhCMsRE7yqZfY5NhoSgcEj/LWG5AuOqygd7m2hBnt12eRbndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683840; c=relaxed/simple;
	bh=TUpf1TMi8/v/dajmGrZPvTcvt4+6l/4QW5aVOHL197s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiJtRcKzJ+Mc9sFmAdGcZvMg7iM1yle4+MOvZdAGQHnRP6KWKL+lTNy/iNaKVPsB00izZok+Hqi80uFogJQfwGRTxUDt+/ke9hpY5xbkmOZohV2MrYAVRLQakY+puXWNda7Ft7lZa9Qa/wrDy3hy1efKQdmk2YlCnq/lGbvZAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgkVfhRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF256C433F1;
	Fri, 23 Feb 2024 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683839;
	bh=TUpf1TMi8/v/dajmGrZPvTcvt4+6l/4QW5aVOHL197s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgkVfhRHjIiCfjWglQ8yIsIYnT2fq3V2ODZQh74QZrEyckVdrTGBgdz0nzXtbc4xE
	 vhP26Si4LDTb7kJPGEhE1/hgTxVx0pYug7X+Y2bk1lYk8F3LIISlqkqayys6f7Ya2C
	 CdYZ6YZOSxZOJdwnPW0v3ITFRvi154xg6z276UsBhe2VPeXxezDzkNKKOf7UPp6eLk
	 oD1/C7AqzfVc5DIGoYTCF2PhVLVjLmiSUc/Ll5EIkB71UBL4nNQ07wm3uDJn1YU0lx
	 SrhiJVGLN3I3UcxF10d9uxsvOM7K+8+iK1/xM1NKd+a9WQNTel/IbgWV3Nf9oWpR/K
	 xBn7oqfEiwyGA==
Date: Fri, 23 Feb 2024 10:23:52 +0000
From: Lee Jones <lee@kernel.org>
To: Dharma.B@microchip.com
Cc: krzysztof.kozlowski@linaro.org, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, Hari.PrasathGE@microchip.com,
	Manikandan.M@microchip.com, Conor.Dooley@microchip.com
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <20240223102352.GL10170@google.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <ffd43756-b24e-4f19-be33-0e33047ad70c@microchip.com>
 <20240220082026.GG10170@google.com>
 <9dbfbeac-3a00-4571-95c0-83e4d47737c5@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dbfbeac-3a00-4571-95c0-83e4d47737c5@microchip.com>

On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:

> Hi Lee,
> 
> On 20/02/24 1:50 pm, Lee Jones wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, 20 Feb 2024, Dharma.B@microchip.com wrote:
> > 
> >> Hi Krzysztof,
> >>
> >> On 12/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 08/02/2024 11:43, Lee Jones wrote:
> >>>> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
> >>>>> Convert the atmel,hlcdc binding to DT schema format.
> >>>>>
> >>>>> Align clocks and clock-names properties to clearly indicate that the LCD
> >>>>> controller expects lvds_pll_clk when interfaced with the lvds display. This
> >>>>> alignment with the specific hardware requirements ensures accurate device tree
> >>>>> configuration for systems utilizing the HLCDC IP.
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Applied, thanks!
> >>>>
> >>>> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
> >>>>         commit: cb946db1335b599ece363d33966bf653ed0fa58a
> >>>>
> >>>
> >>> Next is still failing.
> >>>
> >>> Dharma,
> >>> You must explain and clearly mark dependencies between patches.
> >>
> >> I sincerely apologize for any confusion caused by the oversight. I have
> >> organized the patches according to their dependencies in the patch
> >> series, but unfortunately, I neglected to explicitly mention these
> >> dependencies. I understand the importance of clear communication in our
> >> collaborative efforts. Please feel free to provide guidance on how I can
> >> assist you further in resolving this matter.
> > 
> > If this continues to be an issue, I can just remove the commit.
> 
> There won't be any issue if both pwm and display binding goes before the 
> mfd binding.
> 
> Could you please pick the display binding as well?

Only with an ACK from the relevant Maintainers.

-- 
Lee Jones [李琼斯]

