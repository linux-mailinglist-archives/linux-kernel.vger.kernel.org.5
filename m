Return-Path: <linux-kernel+bounces-74541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE785D5B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812A51C2099A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD30125D2;
	Wed, 21 Feb 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jDWLI7z/"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68298525B;
	Wed, 21 Feb 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511768; cv=none; b=CKSVi53WkcNgK8a/H222xQC7A0q5EeOJJSV3Z3A2jouIV0lBKCmwo6r0Z3x1l5pr9JLqKEPzdy8f/EU+e5sJLkhpfrwM6u7wcMgis+aW+0Xk65MFUEN2B4a1ClXhcuDPYHwed6d2l5CO3HiUpuNVk+r1LkyBeN5kW0y97RrTB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511768; c=relaxed/simple;
	bh=b+/eYVccINIlmc3LBxFxxwIsORefdL0+/grPD2buXro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1/8lSA8JiKgS9bv0SfLz1lWU/UkI+Rnz2JqbKPPaKi5OPx0yeDUiWAWNcexsnZX8eX55nLnh1MnyNiDKjry84RDcKFEbFdcTKSsO2pC8o8hSlLkvSoqoeL8LzXXPYK5ZFFNK5vLLksfYtnCogHtAPDhY5j4RQx3rhgUSPMZHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jDWLI7z/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F1FE24000F;
	Wed, 21 Feb 2024 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708511764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WM3lbi5SD7TMlK2uA7uUOTbJXYmIaYKYABuhjX0tD4=;
	b=jDWLI7z/Bl0tj75SNtHjqskAdJnko8loDjuiXCn+aDNaRqqXB3P3JNIeu911K3cax/xhj6
	/aEBUjiWhJ5jcuUTSGozgpSjxwcWDJgt91ayrHVDeyLoSQUui1ZZRF3AFHx7V50USxyz4L
	yLm7h1T88rQLoAx2gptFOTonHBMu+qvMw4KVUg0j+ZD2mK0CS/dPdr5/ioG8ZiVABLkCaK
	0RP50Y89U4rzhxNReyKNxA66mI5UrsZltcRag3df1MDTnRIJXpcFFFJDtnnPbj+36O0vhG
	WGVxDUpocBrjn7CrzztApXpcCbpB39p3OyVpe91BpFo8BFOEa9lAlnlV3XOEjw==
Date: Wed, 21 Feb 2024 11:36:03 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: don't warn about removing GPIO chips with active
 users anymore
Message-ID: <20240221113603.168ce245@bootlin.com>
In-Reply-To: <20240221102103.10099-1-brgl@bgdev.pl>
References: <20240221102103.10099-1-brgl@bgdev.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Bartosz,

On Wed, 21 Feb 2024 11:21:03 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With SRCU we can now correctly handle the situation when a GPIO provider
> is removed while having users still holding references to GPIO
> descriptors. Remove all warnings emitted in this situation.
> 
> Suggested-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé



