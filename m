Return-Path: <linux-kernel+bounces-167024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5098BA389
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2482B21FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EF1C683;
	Thu,  2 May 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lbq9Zoo5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435C1B947
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690539; cv=none; b=bEfdnWHp19GPu1AlajzR3+ze0QwCAtFgljQQenHwdOFpUI9Rjrr35b5HOmzv8jO7kTJceZPMyLMQcotYM2Spf85K+JNtPNmK087ZHkjTzIY/vBVM1KabMKrqU4FFLvUIpYHE7C8be1EJERDPLi6IbznKzHUZyuZ0vNtOToCzAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690539; c=relaxed/simple;
	bh=jdAiCkqZVm00u5Mpkujq7LizhSxkgvjQSLxjSmd+0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNk98A+vgfFcde99wJo/bX3QsIE5Vgjxhekpcp3xa2dAyMlCfixmCQ5mB41fXGhnQ+vTg++rAJi4QXrMeKW+h+YDo819nG7xfO0bBdVs+NzrqZIR/aUoGEM86q4gbLscBqFmxzfZbECzGo47lgcwsaGcwM2xFJK29pzgcoXYA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lbq9Zoo5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f43015b763so894162b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690537; x=1715295337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVZTpe/CdBBd4zno1lRIevv+TY5Lijp2ynWtx6BFty4=;
        b=Lbq9Zoo5ADuUvFCZS6aZyFRnbZNe/xhaxiwCetCzf+SPd6d0pcGtz3C5AdBpBU500c
         zYVHM3DDMHk/OzmdJrYJ3hGkN02AzUwbE1v/2qiR9ynwW1HbxohOZuyC+0TsERKI1Eb1
         Bz1xkH9ygggoGOh6zCdmBFE4zpmB5vZ31od50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690537; x=1715295337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVZTpe/CdBBd4zno1lRIevv+TY5Lijp2ynWtx6BFty4=;
        b=bpsASZS5xKR2Uq4KUJ4mW129CfWdwk2W8AonNOxRbNVBiF/D0IeLtsxkf9Owb8tgYq
         c5vVuTfJOCe7saFHwmXGcf6r/OaETpWOVqhf3GsZS5Zb7I4me/InbSX0lNyC/DP0Fzh1
         tSpcuru1RlGEhLpX0y/6j2S6pxDQS9a0wgYzYV7oKrZ9zKcTpa7mcaXwBTvjCI08lRG3
         eVp5+WzxoiAMLZCZkRYQABxxNHyhIx9ks1/HJ0tV7vt9tFcNfRUkha0SwK7uf50wjoYN
         BlRbj3Wk5y4l9lOU3fZsUFwvVkMfafdR/WDfUhoxrFRRQ4/N4lmonYWn01bXR1FE6hgW
         EB+g==
X-Forwarded-Encrypted: i=1; AJvYcCWQsQeHI4xolTKouodY98QR6mgTP8AZ1dh2A47vOdEaAEWc2z2UJAiOgzM2r3+Asd71hFXfMyep3ZALTYY58YoBSGTDJR88dIYEyPvI
X-Gm-Message-State: AOJu0YzZ+9M/N0zL07T37ioqoIiu/rP3BR8KV+u6bpTPo/4hByCaa4N7
	g7rSC3qMXhPucaZxFUTf3BTNEgMhWD6opWkYuX6iMDl03qF2d3ThoPqRRMhR3A==
X-Google-Smtp-Source: AGHT+IE3eOeOzKAoJovEuP0RnaA3tq2hqa/aT1L12pQ6aR7WKuRKsLt1bl+kuCC94IGtD86XBl1D8w==
X-Received: by 2002:a17:902:fd50:b0:1e0:c0b9:589e with SMTP id mq16-20020a170902fd5000b001e0c0b9589emr4838945plb.25.1714690537346;
        Thu, 02 May 2024 15:55:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001ecb2179da6sm1877090plg.56.2024.05.02.15.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:55:37 -0700 (PDT)
Date: Thu, 2 May 2024 15:55:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202405021552.5C000EA@keescook>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
 <202405011317.AF41B94B@keescook>
 <20240502091837.GA30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091837.GA30852@noisy.programming.kicks-ass.net>

On Thu, May 02, 2024 at 11:18:37AM +0200, Peter Zijlstra wrote:
> On Wed, May 01, 2024 at 01:21:42PM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > > > This is an effort to get rid of all multiplications from allocation
> > > > functions in order to prevent integer overflows [1][2].
> > > 
> > > So personally I detest struct_size() because I can never remember wtf it
> > > does, whereas the code it replaces is simple and straight forward :/
> > 
> > Sure, new APIs can involved a learning curve. If we can all handle
> > container_of(), we can deal with struct_size(). :)
> 
> containre_of() is actually *much* shorter than typing it all out. Which
> is a benefit.
> 
> struct_size() not so much. That's just obfuscation for obfuscation's
> sake.

It's really not -- it's making sure that the calculation is semantically
sane: all the right things are being used for the struct size calculation
and things can't "drift", if types change, flex array changes, etc. It's
both a code robustness improvement and a wrap-around stopping improvement.

-- 
Kees Cook

