Return-Path: <linux-kernel+bounces-84117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EF86A24B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BF31C23E73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FD1534F6;
	Tue, 27 Feb 2024 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L2nop85b"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739F14F961
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072351; cv=none; b=tG+9KmH3J0GKvsbSLU/HbfAHmcvJz5KV904iIQUJEou2L6aOVoxEI05kC+2qm+yZh7TfRRHS7eqnVxBOrsawoeq9t3tStSzcMaI2DWM38a+BFwblE4WqiBvuhLLqfT/IwlNHVVxYUOcZsYANorGNpwjhf+wb8QWNfqCCYzJ67hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072351; c=relaxed/simple;
	bh=gUm8H8I+QgXLVB74DB6uSSt5ePpLI9Jus5D3udBOKFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvK1FrSDkMh6KPvyopIFsFrY4skK75szN7awviEF1R7Q4aTBLtwUboD2B0hekZ5gL4PQiYRQA55ay0qdKG+HpauqOQ18MvxSZsCsL6/KxBZsiLF5qOUaPRphcctge6O8QDRu122zDV2oj9+UTFWZ1p/uHfAG3OiCjkJm+Fs06g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L2nop85b; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so43000095ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709072350; x=1709677150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YXno1hnt7boGnl19WCbZvgiFqTnjZ41kOP+QrpWStfo=;
        b=L2nop85bNPThTi4hpL6vrutfMntxeT00M5VDsoZO6lsJbZLsMh4JEZippvUrU9LnG/
         8j4c9JFbW4IXJw7ApmaFS+atdkbK4U3zkYzsIuLAjxFwHeuxKXTQkWRhu0MH8H5UG85z
         PD60B8UtqnIQzkuRjaruJGgI3yzYP6WkF0mQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709072350; x=1709677150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXno1hnt7boGnl19WCbZvgiFqTnjZ41kOP+QrpWStfo=;
        b=qoOunOFBTnTSSsGqskcpOvi5EEwy+tJGdDQN3+7s/Etwt20g+NZu1HPsp3rri0Umr5
         eGdCPsyz26VTQQU69P8o1cO18jVr13SZhtQHuW8V6AS3yS56eTTUiDq+K6HaT6IYVShQ
         jAEJx5ztIfoQClqxsVG2rQkIdvZCanJmLKMvsQaJeOIw+iRmEpvmRnqj+IL/QReWL4Lz
         BemGh+zeKXWRXHThRCmxIdgOwq0N8kO/q4SdiFrmS++7cxIUUE2AZwVI5vQX9xiFdT+5
         UfdfWJQRjuB5rLOY/suqhwOU26jCfh7MoRqKX+1Kny7eIfhQhMmLkmCBQWKmHL3o8N2I
         VUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUOKnGxmY+uc7zTNKPEuq84RSC6tkjaJnTw4LO2lOOanQzpcyV49Vnte+AzKSC8VxAit0cS0yezVRR2sLl78C4M2o0fM/QskmerH6Yt
X-Gm-Message-State: AOJu0YyW8KhcDvdhkDxK9BLVo2DkhAdHaHV5Ec2fTQN9HqiSfKv4Y7QZ
	3UZVCrNL+xH8cWknUhejfHfVCDhtv4o5j+sbq5+i8wLeXVF0S2eqzfoc4XUepA==
X-Google-Smtp-Source: AGHT+IG+T1sHKc1Q9CDhQJZHUfw1f78cfUc7tp8sJTwGJrblb9ZLNC6Lovyr5+eIAS7QGdDeOkubAQ==
X-Received: by 2002:a17:902:b7c4:b0:1dc:b01e:99d0 with SMTP id v4-20020a170902b7c400b001dcb01e99d0mr4732223plz.1.1709072349723;
        Tue, 27 Feb 2024 14:19:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id la3-20020a170902fa0300b001db5432449esm2022819plb.18.2024.02.27.14.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:19:08 -0800 (PST)
Date: Tue, 27 Feb 2024 14:19:07 -0800
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: stackinit unit test failures on m68k
Message-ID: <202402271401.CB43AB2E8@keescook>
References: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
 <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXMsxRRMV8g6+9vTy_4o8HF49SUh2deNdFjgKwDLEWrxQ@mail.gmail.com>

On Mon, Feb 12, 2024 at 09:34:02AM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Feb 12, 2024 at 12:06 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > I see the following stackinit unit test failures on m68k when running
> > the q800 emulation.
> >
> >     # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
> >     Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
> > stack fill missed target!? (fill 16 wide, target offset by -12)
> >
> >     # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
> >     Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
> > stack fill missed target!? (fill 16 wide, target offset by -12)
> >
> > Do you happen to know if this a problem with the test, with m68k, or maybe
> > with the configuration ? My configuration is based on mac_defconfig with
> > various test options enabled. I use gcc 11.4 to build the image. I tried
> > with qemu v8.1 and v8.2.
> 
> Thanks, I see the same failures in the logs of my last testrun on ARAnyM, too.
> I haven't looked into the details yet.
> 
> Only two failures does look like a nice improvement, compared to the
> previous time I ran that test ;-)
> 
> https://lore.kernel.org/all/CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com

This is complaining that the stack frames across subsequent calls to the
same leaf function don't end up putting the same variable in the same
place.

It's a rather difficult set of macros used try many different
combinations, but it's specifically talking about the "leaf_..."
function at line 208 of lib/stackinit_kunit.c. This test passes for all
the integral types, but seems to fail for a character array.

It is basically doing this:

static void *fill_start, *target_start;
static size_t fill_size, target_size;

static noinline int leaf_char_array_none(unsigned long sp, bool fill,
                                  unsigned char *arg)
{
        char buf[32];
        unsigned char var[16];

        target_start = &var;
        target_size = sizeof(var);
        /*
         * Keep this buffer around to make sure we've got a
         * stack frame of SOME kind...
         */
        memset(buf, (char)(sp & 0xff), sizeof(buf));
        /* Fill variable with 0xFF. */
        if (fill) {
                fill_start = &var;
                fill_size = sizeof(var);
                memset(fill_start,
                       (char)((sp & 0xff) | forced_mask),
                       fill_size);
        }

        /* Silence "never initialized" warnings. */
	do_nothing_char_array(var);

        /* Exfiltrate "var". */
        memcpy(check_buf, target_start, target_size);

        return (int)buf[0] | (int)buf[sizeof(buf) - 1];
}

and it's called as:


        ignored = leaf_char_array_none((unsigned long)&ignored, 1, zero);
	...
        ignored = leaf_char_array_none((unsigned long)&ignored, 0, zero);

The first call remembers where "var" is in the stack frame via the
fill_start assignment, and the second call records where "var" is via
the target_start assignment.

The complaint is that it _changes_ between the two calls. ... Oh, I
think I see what's happened. Between the two calls, the stack grows (and
is for some reason not reclaimed) due to the KUNIT checks between the two
leaf calls. Yes, moving that fixes it.

I'll send a patch!

-Kees

-- 
Kees Cook

