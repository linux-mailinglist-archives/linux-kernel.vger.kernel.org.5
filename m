Return-Path: <linux-kernel+bounces-82198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8C8680AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14E2B2A94E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1713540E;
	Mon, 26 Feb 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3XZR+6t"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECC135407
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974256; cv=none; b=nI2LloyGRTon5mx71gqT04c2vHiKknvH6BYmGMlBgxJNj2rza6REMfLLkg5cAvi3av/RubTmwKx4CFxArer2dy8ifPVavqtCREyuuhqtGrc5pggafACvUnfBEtsx8fg5bjJ166Hz5YfjrwtFLEaHeOCDaSfngqM1vLeebUiW9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974256; c=relaxed/simple;
	bh=JIqIxUB3Ayzkf/mD0blka6O8DKfFWgrE9WEYSScIHy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBU199Gd8TSC25p/FzS27G0xfChg56Sec2NOzvt/u3Sg+nTgb3Ek0AgnqxthmV2vm1Bd2nk2dcsWZw+AQy/jMTvpj2oOQ6kngRyQZOB3XtlYDGGzRy4WCDOaOvNJ2CAH6CJ7kOU2XhA5c3rM3cc9KMxe+U/07IxTSLkclQj/E3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B3XZR+6t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49b00bdbso29522095ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708974253; x=1709579053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=B3XZR+6tYaiLmvO0ormzojOJS7q2VNS3VFHyapT0mYeCoLK0DxsW42E/Fyoss/kqcp
         mLiKMAOlbl9wyTCPu5nS79QgEgum9zDXpFi3SNMTipdU+yE37Q/xZySU6Z2PWb7019Hi
         5m35Vb5iqfIONp2TiVTpVr5BtosabOcNFViMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974253; x=1709579053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqEaslcv+csbSpF6YQBGR7kuM3sWH8YoMpbM5vrlm2I=;
        b=Xwd0ZOhgXKMWzbws8bTIb0Mn+XywQQQYtonenDwwaC0i8wV60MSmJaGskNWW3zc91l
         EEZPzIyksBN9ObgneF57OE1weKe+vv6ON836PtELH5+oxYLW5FZ5r0mqYqRq6AGUzpix
         xW7F3IZ17OmeN0ZQrA/e+V1hoOWA+T/xAt44kJVQgMjADSlp1FfAjbMClbhDzaWNS8x+
         7YYQczmJtD730qjuaNh9It1crY6h2ckWin9CV7QRDKsq2vKx7EZer6pc2tMmK7DuCASx
         OGmhc8wfEJ0nI3V1/zeILCN8dxohr+udygUKgJG2wX+XIj3tW/ocd0Ik2gTGaHYaWwjP
         Si7w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+8gl+SGYUuXEw6AvsedJoOxcGbbxOQCtPnwKVU0JDGiInNhZFl1x1N9vW1qyOOPITnd1Z9Y5gDuj1JxvqKqVn0DRpCiyqZHcPrF6
X-Gm-Message-State: AOJu0YxYQGG1pgLuKI9AMV8k99T5b3Ojrh99VxmRHZGdm0Kghp375Wc9
	erV4OuVE8xFzzDiAetxCnEgSn9aSHQZrtJ2+iRold36dL5NzDVo33s4ll2wY6A==
X-Google-Smtp-Source: AGHT+IGFFetjjHPW/ivkyZlW9eIrIhfwZbvoWRltu7/bfVEDnv3KZmmFg2wZd+UfH3HTAx1gx80+dA==
X-Received: by 2002:a17:902:d2cc:b0:1d9:7095:7e3c with SMTP id n12-20020a170902d2cc00b001d970957e3cmr8949703plc.57.1708974253283;
        Mon, 26 Feb 2024 11:04:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001d8aadaa7easm31822plr.96.2024.02.26.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:04:12 -0800 (PST)
Date: Mon, 26 Feb 2024 11:04:12 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>, edumazet@google.com,
	jakub@cloudflare.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/harness: Merge TEST_F_FORK() into TEST_F()
Message-ID: <202402261102.3BE03F08DF@keescook>
References: <20240223160259.22c61d1e@kernel.org>
 <20240226162335.3532920-1-mic@digikod.net>
 <20240226162335.3532920-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226162335.3532920-3-mic@digikod.net>

On Mon, Feb 26, 2024 at 05:23:35PM +0100, Mickaël Salaün wrote:
> Remplace Landlock-specific TEST_F_FORK() with an improved TEST_F() which
> brings four related changes:
> 
> Run TEST_F()'s tests in a grandchild process to make it possible to
> drop privileges and delegate teardown to the parent.
> 
> Compared to TEST_F_FORK(), simplify handling of the test grandchild
> process thanks to vfork(2), and makes it generic (e.g. no explicit
> conversion between exit code and _metadata).
> 
> Compared to TEST_F_FORK(), run teardown even when tests failed with an
> assert thanks to commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN
> for ASSERT failures").
> 
> Simplify the test harness code by removing the no_print and step fields
> which are not used.  I added this feature just after I made
> kselftest_harness.h more broadly available but this step counter
> remained even though it wasn't needed after all. See commit 369130b63178
> ("selftests: Enhance kselftest_harness.h to print which assert failed").

I'm personally fine dropping the step counter. (I do wonder if that
removal should be split from the grandchild launching.)

> Replace spaces with tabs in one line of __TEST_F_IMPL().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Will Drewry <wad@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

One typo below, but otherwise seems good to me:

Reviewed-by: Kees Cook <keescook@chromium.org>


> [...]
>  			_metadata->setup_completed = true; \
> -			fixture_name##_##test_name(_metadata, &self, variant->data); \
> +			/* Use the same _metadata. */ \
> +			child = vfork(); \
> +			if (child == 0) { \
> +				fixture_name##_##test_name(_metadata, &self, variant->data); \
> +				_exit(0); \
> +			} \
> +			if (child < 0) { \
> +				ksft_print_msg("ERROR SPAWNING TEST GANDCHILD\n"); \

typo: GAND -> GRAND

-- 
Kees Cook

