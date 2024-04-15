Return-Path: <linux-kernel+bounces-145535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D738A577E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E031C22E03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A880C03;
	Mon, 15 Apr 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9dJsEwQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4D80BF0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197819; cv=none; b=jOk2eUmyOfm0cZzROuI7fcb9y8eYkqvsk8TfNeQR4dEGorhk0VX9gngzabj8D+ssufWT3oq+UWqSSFFAu84RfaSzZdY9TJFltidh9UMxLIFr7ubJtAy0vOgr2a+il2x2XA8alBI7tGbV3PL95AkTslw2/OsUPvqi0+ofSsXh2Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197819; c=relaxed/simple;
	bh=Lh5jHfeqmoxBPj80NPylZDokwvnjtT1xO7DB/e/QTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSMuO9TuMSYpVMMn5aq2RS12qi4J0ZuYBVrOswDuggjOfWFGMlfVYGPjy/mA74Fsa/FqyTW1CM5YHXzBcUCY3OU57q5EYhUJI0dQ8qlzl1d5Izs+kF4W3JnLEJxIzLMJ5vTWLCY9sOz6hzSM2cK4M8RNjbBIhMEB2qfXxtS5T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L9dJsEwQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ead4093f85so2675973b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713197816; x=1713802616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Wuy1kFscarp11LSwiP+LELXc8a3c+7S4sus+rZZCwg=;
        b=L9dJsEwQZUV7UF5qrsYmxyjgq4bd65AnkhOcLxH/X3VD9C4Pn2pH+6HJ8amWZ8MxeP
         ekAfUfaoHLLKytMXPdsLlxN0jdlh+QZRaDgPSp+gQlTxlCzFikPgXUun49QJZZ9tbawH
         AY84nyuhPjNrglxxRweBq5O9lMb/h694Lmk8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197816; x=1713802616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Wuy1kFscarp11LSwiP+LELXc8a3c+7S4sus+rZZCwg=;
        b=h/T5mYuRHzftJ9JW3VsReAwRad6vfXPFNQNAB5WLBVlsGqOJ9ua0r30eZZjnNph2x+
         nXv4qrKEjoEA8GWply5ZubFvNK388Dxfs9y37bM/9CM+RRLH68AQETorZ0Db7zRg3aji
         6y4KAjWYO8ujZeA8R9Xcr+qtAu9ZFNP37dn/nJ/1cK+wlXtapjarXN6TtzjymNMkVGig
         N1vJ98MH6i+cC1vgb4rOd5V/iNQ7ddWIzqC8d36VeBJ/dpHpP0F8+63NbQ7kHd971hse
         L8FP4/+k2WW0Oyx1OuovzB6GKRDZMYtIigf4ooI6kAYSyWLylHPhwd/mtQtOa6B+gS1S
         fFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUerjqLQcM2AevQIJhaU+Yq8Ym8OkR5VHUl0f8TsxcG/Fe+v63WNd19KcqIMWq3d7KCmw+Af0Uwkb1jabebbKkyE5YR+bLz8y05hSSc
X-Gm-Message-State: AOJu0YyBI2eQigsCOfzSTR7f22PSG7BxqmirwQX0ucU/7TVSqdYxofYq
	cpxq9a1Z8D6KuLp9PQCEmHbMJD8l4CRmFmXOUK9lpuX772qYv+vTaT4MmjBnBQ==
X-Google-Smtp-Source: AGHT+IGOZF6sdBlFUMf+8k4Lae5iNbktkJ7avY7Q4jWYEWVVyRkPV21G2LuPlS3REiioA0vSPOcfBg==
X-Received: by 2002:a17:902:b906:b0:1e3:e256:44e0 with SMTP id bf6-20020a170902b90600b001e3e25644e0mr8045502plb.31.1713197816058;
        Mon, 15 Apr 2024 09:16:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001e223b9eb25sm8109561plf.153.2024.04.15.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:16:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:16:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] [v3] kbuild: turn on -Wextra by default
Message-ID: <202404150916.7FD484FD4@keescook>
References: <20240415122037.1983124-1-arnd@kernel.org>
 <20240415122037.1983124-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415122037.1983124-2-arnd@kernel.org>

On Mon, Apr 15, 2024 at 02:20:32PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The -Wextra option controls a number of different warnings that differ
> slightly by compiler version. Some are useful in general, others are
> better left at W=1 or higher. Based on earlier work, the ones that
> should be disabled by default are left for the higher warning levels
> already, and a lot of the useful ones have no remaining output when
> enabled.
> 
> Move the -Wextra option up into the set of default-enabled warnings
> and just rely on the individual ones getting disabled as needed.
> 
> The -Wunused warning was always grouped with this, so turn it on
> by default as well, except for the -Wunused-parameter warning that
> really has no value at all for the kernel since many interfaces
> have intentionally unused arguments.
> 
> Acked-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

