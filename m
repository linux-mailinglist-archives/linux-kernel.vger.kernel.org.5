Return-Path: <linux-kernel+bounces-88820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DE86E724
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377F1284DB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5097883B;
	Fri,  1 Mar 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5I6PWUI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EF6FC3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313911; cv=none; b=hy7vVeMyXgw6tiyzLK/3B856m/xSTuVSJNEeLAbcbtIBMsoIxIKO3Su2RgeuUdXbgWmlybvdv0pfGEtJL+ZyFiuBjXyZeaBYG6d/lFzg53y140FMNd2+a7JFQR1tL9BAxAXFL6TDLv/1KSPpRdvGm/RtNvzfXneFucGLu2Kyblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313911; c=relaxed/simple;
	bh=VcXtlf/XeXr2PobHBVHkid9ZaTLChKSRWS1muUvaUck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWp0hTATtVO4fUOtF8BfCtP9ib6tWATEqF2sUZpDMJ3OyE1eDEtevQaEN1h7iRRWu0oQp2RUt7xo9fMsFV1Uxv3K6XrkGgLo0G1CUvtB7ykKsjDI1yGa13PHTSs3Q6YcHlQutF7c1Jak0cgN4T+vwJ0vjGROvV7l4sYcdC76pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D5I6PWUI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93edfa76dso21969955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709313909; x=1709918709; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3TCjvJYZgSg9yWOOlR3AhfW0G1oI5rbUeEwPh6CwQQ=;
        b=D5I6PWUI45s5wzCKDlHWqTjBY+s8k1vna3KeNoDPcqvSubCKUi9xh82wCeFlozPq2g
         2BbAPiMhNM1+43ap3Ezwp5fQFN0Sef1GWzf4dFKz7+VmcVcYHndSlgvO7MLeYvN6v891
         OVCn8RqOoPA1pd+Ur6r7QCD6VWIDm62tH7aBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313909; x=1709918709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3TCjvJYZgSg9yWOOlR3AhfW0G1oI5rbUeEwPh6CwQQ=;
        b=RneT77BpydUZRwbGrkdQ8t8YK3LmuT3QB5gFySdF7+QGpqKGMncTfvi78IDg//473t
         3khNCMN7/rJFS7SoO0gTH6lriYgL2YnLnDbJ+t8AHJ11m3+ncy1HDg4LBkmZafdTXASC
         ajdcSuJejSUJDV6M5HhE0b+SKzvL+aMIcdoEa8kma5dW9osG49hub18sRdV8AcSOey3v
         9iOr/MRmtDZMPCmutwLyqHKSUlaXOV4/GBaIkfKSRb9kAN6St3BaYiTgYukqoz80tl3k
         bgdp4BNoQ1LUXgUhrvS9+w8yet3lYlxXnB373mn2+NyY/OW61CBnULA/oA+MHVWbuoG6
         5pXg==
X-Forwarded-Encrypted: i=1; AJvYcCWofXIuPD5VlXUGbN4Z0sNQfEdkiN5Ph+kK9faP88psQnjo8qlJM5/jy0u2peEsZ43LqjAOqss5fLvNXxA9VHNBTVbaVr82n/6f28t+
X-Gm-Message-State: AOJu0Yyeu2Bf6OAcN2J0mogLnPnTFHDuDGNzWQaobbgdyzpSfR1TXo8O
	EcdrfyDz/I73vVw+HeCD2P1OIAI4J5kaPhokPtW4E47iP9L0t2bl6NkXoTj98GtRBBCIyW0wHVk
	=
X-Google-Smtp-Source: AGHT+IFYOEPfuMi7RE8d8lflSS9kWlCHn0kDcNrMzQOwSeOi+RK6QIs7nrpl/DVQLtbCnM7pieIqJQ==
X-Received: by 2002:a17:902:e843:b0:1db:9a7d:2e6 with SMTP id t3-20020a170902e84300b001db9a7d02e6mr3155921plg.48.1709313908823;
        Fri, 01 Mar 2024 09:25:08 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001dcdf24e336sm2984379pla.47.2024.03.01.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:25:08 -0800 (PST)
Date: Fri, 1 Mar 2024 09:25:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] string: Convert selftest to KUnit
Message-ID: <202403010921.65C845411@keescook>
References: <20240301002416.it.092-kees@kernel.org>
 <20240301002650.1544829-1-keescook@chromium.org>
 <CAHp75VdhY6-OmNYtbpnb+dv1Du=LTnignsTRSU9+8yqpbFqPsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdhY6-OmNYtbpnb+dv1Du=LTnignsTRSU9+8yqpbFqPsQ@mail.gmail.com>

On Fri, Mar 01, 2024 at 01:09:27PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 1, 2024 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert test_string.c to KUnit so it can be easily run with everything
> > else.
> 
> Have you run it?

Yes:

$ ./tools/testing/kunit/kunit.py run string

[09:21:32] Starting KUnit Kernel (1/1)...
[09:21:32] ============================================================
[09:21:32] =================== string (6 subtests) ====================
[09:21:32] [PASSED] test_memset16
[09:21:32] [PASSED] test_memset32
[09:21:32] [PASSED] test_memset64
[09:21:32] [PASSED] test_strchr
[09:21:32] [PASSED] test_strnchr
[09:21:32] [PASSED] test_strspn
[09:21:32] ===================== [PASSED] string ======================
[09:21:32] ============================================================
[09:21:32] Testing complete. Ran 6 tests: passed: 6
[09:21:32] Elapsed time: 11.545s total, 0.001s configuring, 11.327s building, 0.183s running


> ...
> 
> >         if (i < 256)
> > -               return (i << 24) | (j << 16) | k | 0x8000;
> > -       return 0;
> > +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
> 
> First of all, this special value encodes the problematic patterns, so
> you missed proper messaging.

Yeah, I see now this isn't a test but rather an encoded report. Since
the failures are caught earlier, I can improve those messages instead of
doing an encoded version.

> Second, the returned value has a constant, how do you expect 0 to be
> equal to something (guaranteed not to be 0)?
> 
> This needs a good rethink of what you should do in the KUnit approach.
> 
> ...
> 
> > +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
> 
> Ditto.
> 
> ...
> 
> > +               KUNIT_EXPECT_EQ(test, 0, (i << 24) | (j << 16) | k | 0x8000);
> 
> Ditto.
> 
> ...
> 
> >         for (i = 0; i < strlen(test_string) + 1; i++) {
> >                 result = strchr(test_string, test_string[i]);
> > -               if (result - test_string != i)
> > -                       return i + 'a';
> > +               KUNIT_ASSERT_EQ(test, result - test_string, i);
> 
> In a similar way, all returned values are *special*, you really need
> to think about them before converting to a simple (and sometimes
> wrong) checks)

This encoding is trying to report "i", so I've adjusted the error
reporting in v3.

> I dunno if KUnit has a fault ejection simulation. It should, in order
> to be sure that test cases are fine when they fail.

Yeah, bumping offsets and such produce expected failures.

-- 
Kees Cook

