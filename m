Return-Path: <linux-kernel+bounces-75493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF1585E97F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418BA1C2261F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A908F126F1D;
	Wed, 21 Feb 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpDs7jJD"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA288664F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549594; cv=none; b=GTcuUVBN/qFU8EZYFazGP60iM4inyhziNqMlXzU0iL0agyN+UGM6Zj9QNMyAgcOtDLA/waxOgr/+V9mSvUgPw6s1UHimEPbhrOuJjukASWNFK9BWmX4rtZciOfAZnfhYnswKFgNcdCSYVqrKE6YQCPAYvE3XjB3r1hEGk5mkTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549594; c=relaxed/simple;
	bh=dbd4jsxBGwYIp3VjbKuVkI9DXoIGdk9CI+527muwnNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVDWpZgDr0K+2tweP5gAbxR3WNnRc7Af9HZij3zILgfkSWpM+sxWWOEwRSCR/1Xd/aw+7Yv87+wiVfOJeEHOhmPVGVP+Cv3P/FxzVWBklG8EKRTvxWgyCL+mLm96s6rPeu3W8JJZBAySl8KpAbDD8fYm/XZqJeTYDDvUvLCLLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpDs7jJD; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso330516639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708549591; x=1709154391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XxARLNt21W5VmobeBOcLL0WanHWe98+J1gabaOyO2/o=;
        b=fpDs7jJDreH7H+GfS2hEWuuoVvwRO/pL2IPdnYk9m81gIG57urJn+ROEUMw70PPuIc
         7DlBjWcBG4fZ8gtPUi1MNYKjhqgbf9HvzuS9NoBgEqdN4t6TGMg4bG/1Gh1jXtiR1H4j
         4cTeo8u88ZszUPYCLUnvDHEE1EIyoS8ih+CZ62mU4oAiS45gAhRoun3zaJCPpx6pLIYq
         5j9iu/K/IO7ZUsZZnDf00B13y05gmdlf6ACZEvTMZfRrrCX9R9HnmpLfD0BjuJwJzG1M
         IhtwEAuCx/vmuX3J7zDUMKdHhYSBjEU9dFoqNO021Wa8zfyDfOWWInrziYdkmiSUF3Pl
         bamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549591; x=1709154391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxARLNt21W5VmobeBOcLL0WanHWe98+J1gabaOyO2/o=;
        b=Hqz6qooYshgmC1dLxXY+lKoFeR1ZGWlFQhDH03ASA5wRU68HzNe4dOGY+q+3kvL+Ul
         Gj+27fiB+y64GzUnRwO3TvS5eEqIauKYmsT2UmrcqXhrF4h5o4FiLR3hTjXgxScZ3lnh
         SNUG5DLMO5vRlx7PB2etAQ+CkszAFR4Lm9MTx83ximlU1kD4W9ShxBrgD+bg357mUw7o
         l4hB4bRkqmaxtvPW9YOgng21n26/q+qW+aP8d9TMuFp6v68MxC2MgpN+7SN73EAiaX5t
         5jvjAR6weq9Cc3NNSrzuOLXlTpX1ldGqcSdzWufkff5r4+OZgti+d2Ca+DfD9S7S8MNV
         VJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXXFZNipjs9zDF3OFXYE4a1fMQLFlagdrF9Yx83/8NfCwFCykQCsuAIgGJjqdd/ISwyOwcW8zalF4w7i/rmG50L1o8dibeyW+t9M4u
X-Gm-Message-State: AOJu0YzB0vLMyGJbQEz0S6P7UQ0i07ykdu9saeahw6w4avgVWH9EYJw8
	OjEnnPSpoTLsCVnLGU1yNL0nCPLdK86TbD3LX7UlowY/5Jf0Ac9hAQiydy8UTg==
X-Google-Smtp-Source: AGHT+IHqbTAIdmbfdrW7leotGJWoTRmx3P/Ksrvh7bnDyBM1dx8JyMMMiikIoom0nj0o+fE8Ko+j0A==
X-Received: by 2002:a5d:894e:0:b0:7c3:f542:66d8 with SMTP id b14-20020a5d894e000000b007c3f54266d8mr21472703iot.1.1708549591657;
        Wed, 21 Feb 2024 13:06:31 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id fv5-20020a05663866c500b004741f7683ebsm2272779jab.154.2024.02.21.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:06:30 -0800 (PST)
Date: Wed, 21 Feb 2024 21:06:28 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/9] time: test: Fix incorrect format specifier
Message-ID: <20240221210628.vshmqtyeecemin4k@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-5-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-5-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:17PM +0800, David Gow wrote:
> 'days' is a s64 (from div_s64), and so should use a %lld specifier.
>
> This was found by extending KUnit's assertion macros to use gcc's
> __printf attribute.
>
> Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  kernel/time/time_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> index ca058c8af6ba..3e5d422dd15c 100644
> --- a/kernel/time/time_test.c
> +++ b/kernel/time/time_test.c
> @@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
>
>  		days = div_s64(secs, 86400);
>
> -		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
> +		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
>  			year, month, mdday, yday, days
>
>  		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin

