Return-Path: <linux-kernel+bounces-92035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9481871A06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68703B20CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4659537E9;
	Tue,  5 Mar 2024 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WDSLeQKN"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDE4CB58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632494; cv=none; b=qYKkN/Ujl7FVol35naU9kNzffgjv9X+nnnOCU1dsnRKB4Delxg4UDkI4bs/dMbcEWdj8/hH7uI+jyxP5vvdhN6uvNW/tqVuCZIPqtqTLdi1CrNNZsuWMf5G7IqzBHMZ7CnkMIIrA4nomjBV/lAm/L0lPkp1LA7BuyzbiKB6ivMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632494; c=relaxed/simple;
	bh=FzZFZgyknEs4e3j86cGsSsHpKR/7l45G9iBLLSVc8AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehGAlv9/sp2j/bMup4BIAxVgJ2eFXw82f4cOV5xNeLGn/tQO9RifJpYQ0D6tRIwtgjwRD7jvCS6q/NFBPrNQImS8itPLt+QOd/XAZGXfQpp6KOSyCejD+KG128I7Pj2ymlFwM7753fc7/gAjsGRCRPce1jmymwnHjK7tRINfYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WDSLeQKN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so5258705b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709632492; x=1710237292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WaxZu8cu5F/ocXV2z6I3xNk7GCsZx8449ky6SPWxlQ=;
        b=WDSLeQKN5lQbnyACdsSmpxmXliSWb+A32mMTReGML0+oDJgysyP7YXZPIY/Zag6JTr
         II0+wkBnXFYfx2xWMzLqSbu8+yhtzV8AOONtVeV+8oWuHimObnjX2d/Yi5tfcZvY02nz
         j+Fnig+jAt7O89IF0nNcfwtuRS1WisJ9UmUd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632492; x=1710237292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WaxZu8cu5F/ocXV2z6I3xNk7GCsZx8449ky6SPWxlQ=;
        b=kbIel0mdHLUaXi0tz4X9Ss4dpGiAxy1f0RvJb+rKVdP0QAsM2w+c+E+wYS6FJxiYO6
         NBQx4OM2WA5AbiuujkTHAd0Ym6grOofJVRIjgNdQsVuHvo6550FnB5hFxVbVaYg/OKL1
         HeBkxm5GZ2LlJ/wxAGDKbLUN5CXAdTQAjjPV4FZFwRM8oGYAoz7S/G81VNeo/jXT+DLo
         Df82bl9ZydBgybeMe9sR6MpbJ4FFOHiqP1Ljjl75zUgM96cNd0nXhUqi6gMTKAQkfOnn
         sPS5Fdr2sD5ejAEomioLtRd0gdXM33iyKxjM3p3UShtz+R6uhzIsgQzeWWFDwR132OCc
         gftA==
X-Gm-Message-State: AOJu0Yw9EEhmwRfY7BdSNZeYR+Xrfvrswa8xrUqE6isVTas34Ha2JhaW
	A7cERX/10mFRnSGf+PRBnLADPARoc2uQD57AilwkZvAPea9Oj6hfK1G/v9rh8g==
X-Google-Smtp-Source: AGHT+IF8R2lPQE1BAnZGj0uGjIgyHQJOfW9Km2P3yA0Lw0k0iHZ/gvHtO6acTtaCb/1N1sMxfuQfLg==
X-Received: by 2002:a05:6a20:394a:b0:1a1:41a3:9b54 with SMTP id r10-20020a056a20394a00b001a141a39b54mr1311201pzg.32.1709632491974;
        Tue, 05 Mar 2024 01:54:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b006e0debc1b75sm8753970pfo.90.2024.03.05.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:54:51 -0800 (PST)
Date: Tue, 5 Mar 2024 01:54:50 -0800
From: Kees Cook <keescook@chromium.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202403050153.07D12B800@keescook>
References: <20240305145018.39b4e37b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305145018.39b4e37b@canb.auug.org.au>

On Tue, Mar 05, 2024 at 02:50:18PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from lib/string_kunit.c:8:
> lib/string_kunit.c: In function 'test_strspn':
> lib/string_kunit.c:176:25: error: format '%d' expects argument of type 'int', but argument 7 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
>   176 |                         "i:%d", i);
>       |                         ^~~~~~  ~
>       |                                 |
>       |                                 size_t {aka long unsigned int}

I was really scratching my head on this one. I didn't see the warning on
my end because this is actually a result of the merge, namely KUnit
becoming correctly stricter about format strings:

806cb2270237 ("kunit: Annotate _MSG assertion variants with gnu printf specifiers")

I will fix the format string! :)

-- 
Kees Cook

