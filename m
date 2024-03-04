Return-Path: <linux-kernel+bounces-91007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CC87085D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130101C21348
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05402612F7;
	Mon,  4 Mar 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7cUH+H9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0A612E6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573786; cv=none; b=YSJiV4JRpIyWRUy4grmVBrdYbDhAwP2SOuTrMdse2CVT6q3beE9wOFsqce6Cc0zgdhS1f84woCgS/FmhRyTyrbbySK8hSp03+eMUmICY3dP4VQnVxEa94EI+YacAFhlzuVHHS2+PSoloXyQhgWBLfbZaIoeVRE8YwugIl2IFL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573786; c=relaxed/simple;
	bh=8ooV8dB1mFGHQY9jMgeckMAWoFF0hDH+vzsJ4I6wVLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDBRC013A8PLUXtv+DvfdPgi6Yi3Qxbu1l/dRhtBMfwLixwkdBeHxxy4o08RjHWAiP0mz92AXrpucQGZmIIWgvtbJDnun0y/SSEzxPjZ3xxwxT0aFj4zAhBbN64qrC21q+55qy9NNLl+6vza1n0Pan1V8WGGlRLEY9RUMg3GoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V7cUH+H9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e55731af5cso3627187b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709573784; x=1710178584; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JWlfNcQD5ehyoT1o3mhe5Duet0Ppnvl8B0mdktks9m0=;
        b=V7cUH+H9ELHH0cNKbSVsG/WWfSt8TMCgu0abHVykmJfVEAl/4GkEo1M/lbG0U8Rmz7
         mn84RQVeGgkL5c1Rlf2FUmQFpEhoGInrOZmR4EewGnaTNE87dat43H3kFoN0ZcHiidsq
         haq5MxwsSuABBTzFU4NnIpXSiuK2qdVILvb7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709573784; x=1710178584;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWlfNcQD5ehyoT1o3mhe5Duet0Ppnvl8B0mdktks9m0=;
        b=pJ12Ox3Vm5zsg8FpkeNgNCn/eOrqfv//CQCk19ZRbHTOnGqNIPBZdc7qUbrsx/E+Nx
         gqt8AydQos/Dk4xfYuwQ4bAlqEe8F1Q1YxPpP1jGrGTQllFBkrD91V4t1TPmgAwKbJJ/
         3RsgwHr5Je0J/rb/mxNnjcfsQkVFKJGV6RAj9ibZtc5UmAqwxEA0zkK8r/OF2ToUme87
         QZsYsa9xarXjswngV1i0V/COuLcXJgrdnqWlfxs8g+RxOO+rGob2xQ42UrWo5IMdtAQe
         zc17FvMzFAtpUISpoGfvMktnfHzIB1lfFJRPMdU/CPKWasHNyHmbUbHg2aubUtPtcBvn
         BOTA==
X-Forwarded-Encrypted: i=1; AJvYcCWh2YTyIP1YAVhYj/QRGt84e9KS30zrygB8c69f3tpnbebHKdUPdqS3/itoEqx0fLhfXks8IRNKkEzA/f5Fwh8D6aPZMDyLrqHSdENv
X-Gm-Message-State: AOJu0YwfnI8hGH9ZQh96uG5AU/F2EUru7Yp1reTsXn2+cwg0fEAhruB8
	QmjVGtvUJQNIj+ShYjkfZi4yD9mAFFrUe5UGtwvP4g1kP2BGVN3PcwmGVVM43Q==
X-Google-Smtp-Source: AGHT+IGH+PXOCFE8Sx+8SDXrIRe2J4LTaRX/jocxs+KNVTAxz1MSfGPWTzHpvTrkX9a//yribdgf2w==
X-Received: by 2002:a05:6a20:8e16:b0:1a1:4d74:cc48 with SMTP id y22-20020a056a208e1600b001a14d74cc48mr3248181pzj.21.1709573784240;
        Mon, 04 Mar 2024 09:36:24 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7845b000000b006e04d2be954sm7484585pfn.187.2024.03.04.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:36:23 -0800 (PST)
Date: Mon, 4 Mar 2024 09:36:23 -0800
From: Kees Cook <keescook@chromium.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: axi-spi-engine: use __counted_by() attribute
Message-ID: <202403040936.E933B96@keescook>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
 <20240304-mainline-axi-spi-engine-small-cleanups-v2-2-5b14ed729a31@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-2-5b14ed729a31@baylibre.com>

On Mon, Mar 04, 2024 at 10:04:24AM -0600, David Lechner wrote:
> This adds the __counted_by() attribute to the flex array at the end of
> struct spi_engine_program in the AXI SPI Engine controller driver.
> 
> The assignment of the length field has to be reordered to be before
> the access to the flex array in order to avoid potential compiler
> warnings/errors due to adding the __counted_by() attribute.
> 
> Suggested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Looks good! Thanks for the respin.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

