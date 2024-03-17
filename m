Return-Path: <linux-kernel+bounces-105530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164887DFC9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1497281750
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78F1F605;
	Sun, 17 Mar 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dltRHZ8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3C1EA84;
	Sun, 17 Mar 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704739; cv=none; b=LT/3CC3yQZTSjFe/omtu2Z/cJWw6ZArj2Sve1WLh+hVYlyxJD5soDJ009VGzTXuLFL3z9rTk5aQACTm1gaawRhCg4+sr2STj5vqNIAwA3sGCzBuy3uPYSzUFKTtr/k4Daa6NfKStmMGWGbdZ3eKImAIytW8i3WSPkYfDL/TDErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704739; c=relaxed/simple;
	bh=hkVeux51Cmhvp7Xg3Iab1zpv0mwTLFU+W3UsYrIQPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGNxXLdZqI46rb9nt+PIWVO/O31tjY2pKXzga3lYWD4egk+b92yqfaDBDlp29H/8b22WiZNjdaAEIGat+VK2/xZNOCD+B7SQQTFp/9YDEYSkqwwNSbKc7iDJfXdK04KI+IgWHI+3v9RXzNO2kGbT4hHP6BoZei60/fmwgFNWv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dltRHZ8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55260C433C7;
	Sun, 17 Mar 2024 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710704738;
	bh=hkVeux51Cmhvp7Xg3Iab1zpv0mwTLFU+W3UsYrIQPaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dltRHZ8b/HGv9D1TGsihU+XD5kgo7B+JJEUXHnQQDEiDeYKbO7oS2ou3j2gTFCkeX
	 cIFHfIjZzp5+2Kcn5zBqJCnZkHaJHF1YzR0qjzRi7LvCXXjaa6p0pmi1+UlFwr5wks
	 /6wf1Vb7f6rPfBqtMEnBG6cdfdXPw8ACFUXfEAcRJYy5cwDwn7A7oBRuE3XbYuhAmO
	 cD6fhw4Jbr26lPRJgnSoSKnY7odLk8NISMo24Z6u4icPmc8F2q4yGfMItGFeFLP5bD
	 HIvKVZClMT+EZxJLdjgVXqb9KkaocIHZvyI0klslGICo71sObO8zV5a8NM3xFed+MT
	 4wbyLiD1wYf+A==
Date: Sun, 17 Mar 2024 13:45:34 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
	Dmitry Rokosov <ddrokosov@salutedevices.com>,
	kernel@salutedevices.com
Subject: Re: [PATCH 22/25] ASoC: dt-bindings: meson: introduce link-name
 optional property
Message-ID: <20240317194534.GA2093375-robh@kernel.org>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-23-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-23-jan.dakinevich@salutedevices.com>

On Fri, Mar 15, 2024 at 02:21:58AM +0300, Jan Dakinevich wrote:
> From: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> The 'link-name' property is an optional DT property that allows for the
> customization of the name associated with the DAI link and PCM stream.
> This functionality mirrors the approach commonly utilized in Qualcomm
> audio cards, providing flexibility in DAI naming conventions for
> improved system integration and userspace experience.
> 
> It allows userspace program to easy determine PCM stream purpose, e.g.:
>     ~ # cat /proc/asound/pcm
>     00-00: speaker (*) :  : playback 1
>     00-01: mics (*) :  : capture 1
>     00-02: loopback (*) :  : capture 1
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

This needs your S-o-b as well.

