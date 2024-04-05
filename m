Return-Path: <linux-kernel+bounces-133257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F889A146
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AB61C20D88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3416F90D;
	Fri,  5 Apr 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IozsLkcW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668EC16F901
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331145; cv=none; b=K+Y8ncAtahYuUnJDu+8ECLh97e0iWcQE6A5viaitQ0nSDuLOvZ3bXM9a9SBkE4KkLPkHHDbVqK7HSpiXJ2uuECOqz7LPkKbMdQpU/QXjzATuWr2QR461MtfOsypT4mI98EEStsqsBe2193PTF2JNs8g643bp4wuIsh1OBY+tcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331145; c=relaxed/simple;
	bh=7EromWr0XaULO1KfVY9RUjIf9QiuQBRV6BTlvsJvh6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shd2iNQ3/3AUt8Gg45OJ0E/wbRaUn5FxDuXKlGuo1lWgxotl7of/8xqr+PQQpIQHMd7j5OKy261hVhJg1hnI+QYy3Of5NH8NnmXhpGtSn+6Kr19sFh2/FZcN2gD4NTCOvbWskucTXXmLI5c13NPDnhYHGe8+HffQjVQwqR+btdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IozsLkcW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e244c7cbf8so20585985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331143; x=1712935943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zCHuG1riB67zTF6cGFfKkOo6cTBnZXN81xTdOBpCWY=;
        b=IozsLkcWRI5168jxUKU/GQcSs9LOPpGniS3WckvW/fu2aEpu5cSajns+SXuG17A2vI
         LiziQjjmbUruurUN1jmO+0qRgxqnVmRjDrshsDhvAgxTU00y2SvSKMCjXVbhhsFsvR41
         a4kUdgEFDe5ovegHuA1MxMD4CO4dRkjxnSuvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331143; x=1712935943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zCHuG1riB67zTF6cGFfKkOo6cTBnZXN81xTdOBpCWY=;
        b=DpjwjjWXuJT4Gc8F5NRwQrFDEZOPZrtZZhPQBeOTwQLIjrazbX1w64NI/TEMhjv8lk
         7wWxGrHgZLaH4l+xtAPLlUKEL/J6TV4zI9zi7GNjRQMEIS0yFl56i2ijjYtNHJlOplhF
         1Gw9sjjPqa8KUc3x8xmKkBXvXeeM13+oAhyVZyjblwTT2Eb9C90PRhwDndgFxgzR5Mz/
         NvGNvUu22cjoUJJ3PR69uqO7Js3cJN0RYUqQRdKukECqFufSySKA8txEwdlYRAij/aQC
         tSQkk8Khbu4FoFDcsAw8PyEr33R8IucHpGvuINbaEY2WUEV5X3rogh8HXfDZNdgzybvK
         xbrw==
X-Forwarded-Encrypted: i=1; AJvYcCWiu6NuLbLhjvwA5Ty/lZOoSKv1xI5HyjVNlmgAf4FYwEC8jYfCb7zxGY3yCY0w3ozQ01/GOcFerS6t0JrshcljqN1tcRt+SuP1j+OC
X-Gm-Message-State: AOJu0Yzlaa1PdMDQNDJ1gjp0cgy3PpgtLaQWGgDyETSE7j8LGVDCNPar
	o54x8ePDTFtHvGJjj8USDFKdjw2VWX0TFV6WOLl7jyQ5re3lzO94nhkJASHodg==
X-Google-Smtp-Source: AGHT+IEcd30JQvThROXLk6blXSCc/d9PBNI1VHjF0rNb0/xAuRQY0RK64NghWzC/QEFJnHzUbp+dIw==
X-Received: by 2002:a17:902:ed8f:b0:1e2:577:f694 with SMTP id e15-20020a170902ed8f00b001e20577f694mr1785714plj.61.1712331143586;
        Fri, 05 Apr 2024 08:32:23 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b001e29c6d5084sm1698784plh.227.2024.04.05.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:23 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
Message-ID: <202404050832.187F972C@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>

On Fri, Apr 05, 2024 at 08:56:31AM -0600, Shuah Khan wrote:
> On 4/5/24 07:17, Muhammad Usama Anjum wrote:
> > "Bail out! " is not descriptive. It rather should be: "Failed: " and
> > then this added prefix doesn't need to be added everywhere. Usually in
> > the logs, we are searching for "Failed" or "Error" instead of "Bail
> > out" so it must be replace.
> > 
> > Remove Error/Failed prefixes from all usages as well.
> > 
> > Muhammad Usama Anjum (2):
> >    selftests: Replace "Bail out" with "Error"
> >    selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
> > 
> >   tools/testing/selftests/exec/load_address.c   |   8 +-
> >   .../testing/selftests/exec/recursion-depth.c  |  10 +-
> >   tools/testing/selftests/kselftest.h           |   2 +-
> >   .../selftests/mm/map_fixed_noreplace.c        |  24 +--
> >   tools/testing/selftests/mm/map_populate.c     |   2 +-
> >   tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
> >   tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
> >   .../selftests/mm/split_huge_page_test.c       |   2 +-
> >   8 files changed, 108 insertions(+), 108 deletions(-)
> > 
> 
> Andrew, Kees,
> 
> I will apply these to linux-kselftest next as a series since these
> changes depend on change to tools/testing/selftests/kselftest.h
> and need to go together.
> 
> Are you okay with that?

Sounds good!

-- 
Kees Cook

