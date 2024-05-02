Return-Path: <linux-kernel+bounces-167013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D848BA369
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65746283A60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D311C696;
	Thu,  2 May 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8qjv+4O"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A81B810
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689664; cv=none; b=FfpXPzMpG48peSQdJLtGl/DbY6LfjqFO77e+A4APVQXKCNbTygIZadxsegi+MzNnErUOx13fLrRAFN0d/VTQFIJXEpUzakhlQ5zVrhqreRG3pJaS7xjBgva5rV7Ri61X2rVXopGQWNrxcFJsTBDxuVU/QRD1uDYFQA+8MqNljZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689664; c=relaxed/simple;
	bh=bzyP4Xdw6nGRMa8O/ZIWOZc2YGpey8Rpt1THkkiSlKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td6e8hidN6ufGheT5RP4saU9XdgEaenWurNBHBV+zG94SadyiqZo3IFVT8/hbMjporSQooqEcIO/XG1mxk/J/ywYI2gnEcssvQVSKP7hUuFG/QMriXxCHx9+I7vxh+g0rcoDLkeiCWtbfV+dJko/0ftJf0okCaWZ2NVRnhEI8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J8qjv+4O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so7496220b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689661; x=1715294461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L9jD35jpO4uNtUxWEojKtoKI6VMvNDOlsLmuwoeTBY=;
        b=J8qjv+4OwWekS+smq2pAOO2aD+7G0zxDDskE6DxYIMEFCqOJDEWRbgw67BNbn/LqVp
         /dF4BxMfu/exf8AdUS3KFyACeksI+tvM7dHgD2xT2KgOJi96dSQomKCnPmIE7NeiHkcA
         3qUG8xEx6vCC85Cn4OMcuMtdSxHYd464PTSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689661; x=1715294461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L9jD35jpO4uNtUxWEojKtoKI6VMvNDOlsLmuwoeTBY=;
        b=L1zkXBBzTeN1RukshIsFdbty2Vq6vqaLMchWzkcJIcq79Wl+iywniM/1TEraVF9SzA
         atU5HZo1VofHTucybbmBKaS9UAAVWM8PDGkJWBjFXS1brlLKOja2olh4lBTwbSFzIyGH
         Ooj55JUcol4BCOYg03/CTChoV2lrpCipSQjP6wUpLNH3p/hqI0jCD0R+d4JJ7vLb8tzM
         J9Lcpobn+SiduCRLOOWs8KbhAn4TbXpjnhM/EwZMSALSAsSgLo+YPKWJPeBbZPBqrEyS
         gfYHSDdJQvbjk9K34nLVjBarg4UwoXtzwX4CG+gIf5AAZKjEEZr/hrGcoIlIMNMlu6Do
         LYvA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3AirkkC0JdV7S5MVp2fQIW8kJXzvunoOeb5K+nZ0wyc0JUl+GnruJ8COGXwvlbvYtCC3VeZz3Z9lJewX3Od8xgCZ4SNvwrsL4/C8
X-Gm-Message-State: AOJu0Yz46xMCkWyAwpA5EnmRuCMXOCTWuoouNMIt5YLWgu2tkO/QoXRi
	hoIa3PClYkKWCkRWxmjsAlJLbWFIg21Y2DgiR3rM1+RJpJ88XeKPnQMO0+GXUw==
X-Google-Smtp-Source: AGHT+IHT/crKZRZ/k6RhvANBVZPADnzOe9chhI8JjANxhrQb7VX4JbkZba2YNbbf5dsZ8cKd3o/FlQ==
X-Received: by 2002:a05:6a20:5530:b0:1ad:8606:6484 with SMTP id ko48-20020a056a20553000b001ad86066484mr1120307pzb.8.1714689661156;
        Thu, 02 May 2024 15:41:01 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s185-20020a625ec2000000b006ed64f4767asm1845468pfb.112.2024.05.02.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:41:00 -0700 (PDT)
Date: Thu, 2 May 2024 15:41:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Mark Brown <broonie@kernel.org>, Edward Liaw <edliaw@google.com>,
	shuah@kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Define _GNU_SOURCE for sources using
Message-ID: <202405021540.3FF73DF47@keescook>
References: <20240430235057.1351993-1-edliaw@google.com>
 <ZjGiGq-_kUVht63m@finisterre.sirena.org.uk>
 <ZjJClMYEIyGEo37e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJClMYEIyGEo37e@google.com>

On Wed, May 01, 2024 at 06:24:36AM -0700, Sean Christopherson wrote:
> On Wed, May 01, 2024, Mark Brown wrote:
> > On Tue, Apr 30, 2024 at 11:50:09PM +0000, Edward Liaw wrote:
> > > 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> > > asprintf into kselftest_harness.h, which is a GNU extension and needs
> > > _GNU_SOURCE to either be defined prior to including headers or with the
> > > -D_GNU_SOURCE flag passed to the compiler.
> > 
> > This seems like something that should be handled centrally rather than
> > having to go round and audit the users every time some update is made.
> 
> +1.
> 
> And if for some reason unilaterally defining _GNU_SOURCE in
> tools/testing/selftests/lib.mk isn't an option, we should at least have
> kselftest_harness.h assert instead of making a futile attempt to provide its own
> definition, e.g.
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 4fd735e48ee7..6741b4f20f25 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -51,7 +51,7 @@
>  #define __KSELFTEST_HARNESS_H
>  
>  #ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> +static_assert(0, "Using the kselftests harness requires building with _GNU_SOURCE");
>  #endif
>  #include <asm/types.h>
>  #include <ctype.h>

Yeah, let's fix centrally. I like this approach.

-- 
Kees Cook

