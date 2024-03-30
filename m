Return-Path: <linux-kernel+bounces-125741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114E892B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DFD1F21EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637737714;
	Sat, 30 Mar 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zoq6aIJA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41C2E407
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806874; cv=none; b=N+CjyDm23f0Tpm8jlTiJT/VzlXXnNN1qBrkcYs7jVSsR/R+M3hlTBjpExqTW7ueJvA4wmS4TBAwnl+DAuoy82+k/rOmWmufVNB3kw+Y7mVyUEgzZsqettA105y/1KD4kkAJxW2yrE2da7vKx1sx7CdToEQQLs1Gl7INSUZbAs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806874; c=relaxed/simple;
	bh=waODuIiKSNDd9BAEAEk9s/nTmErFfSejLtoE+ZVPbno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4AuRDm09Rd6JRaY6bgYnPZrC52vDrJJWcEA3KNDwsl4wxp63/X3km4xhuH/jzyMcYwVBtSBRi9GBZGemF0ZHJjGEW74o8nf7p3XrwCzZPUBLUWS2VIVc6rKrTRM6XMp6ofmLUu4noCzrlAOqjrDzvgv+TcelXXtsZaj57ovJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zoq6aIJA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e8f765146fso2280804b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711806872; x=1712411672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibSv13LulnYSCMmIWpRhwId+c1oxu5wnos6tEIpHMo4=;
        b=Zoq6aIJAU2lBU/MH/7JsV3O9dlGZJB8gr8KvLn3gZFs1fVTRkYrEZDei2mCA0GsYYL
         gzaQ+OQUCmpYQGpGFfajRrw9HqQ2qgSekgPB+CzASFzO3EyONTx/+yHWEIFKoka5KK4Z
         vT8vxHxROl39MRlCITRD4+uYvI+BC9HciiR5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711806872; x=1712411672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibSv13LulnYSCMmIWpRhwId+c1oxu5wnos6tEIpHMo4=;
        b=I4L82xZveFz9gjvL0zc47fzHgS+fFt+utnnj0jqGw0GondNvZTpBmV17ASy+qz/Jpy
         15H71gnR9XR+WoW9LJZlbYDxQ1gzgo7fwe5j96TxXxrXhz9e6HAoQtTu3Ka7hNExCLDr
         C6koxVoGZJ4iuuyXhOnlDQmIDNncpd+21kz2wCpFYoq1QzQV+SqVWnbTmLUwTC8Dql3Y
         d3Wfs/D/8KpEsSsNKYGGLhf3a9iPjBCi6MEIyDTl9A+Uz/ZQPULP0oZM1Os+6ycQWMd3
         5dip+qzi9ItrNxorD0nPp49SZ5aQBgIxkNI4ydROTquawL6vot/y+yGu1DubfAB37ngc
         gilw==
X-Forwarded-Encrypted: i=1; AJvYcCUl2hTxTRFranwcvPJ6bJN4Da6N32g0KiJ5KRGO9U2bB9SQYxzqcuFRvdL+qMK2o0A95x3GNBcSaZaX+hq5NcQBvU+vg1BfuOE5yfr8
X-Gm-Message-State: AOJu0YzHUgMq30CF3QioQs/2ths9zZQOin2+qUhrArApLzNV2ygoU5Fb
	5dzvByV+PA1sgG8RP6IhWdq0NHZFpq23d5lO9drjDIbclQGHH2du+EqfKs5OnA==
X-Google-Smtp-Source: AGHT+IH6VflVv78mDb15GZ5dF0KUozwwz3wOqmzgCo3uqyKW0t1xV8CXjg7ofcHYn6tAS3xGtFZeFQ==
X-Received: by 2002:a05:6a00:10c1:b0:6e7:8047:96f0 with SMTP id d1-20020a056a0010c100b006e7804796f0mr5094804pfu.28.1711806872210;
        Sat, 30 Mar 2024 06:54:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ln13-20020a056a003ccd00b006eaf3fd91a1sm1362668pfb.62.2024.03.30.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 06:54:31 -0700 (PDT)
Date: Sat, 30 Mar 2024 06:54:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Lasse Collin <lasse.collin@tukaani.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [tech-board] [PATCH 00/11] xz: Updates to license, filters, and
 compression options
Message-ID: <202403300652.7EAF7B53@keescook>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
 <202403291221.124220E0F4@keescook>
 <87h6go3go2.fsf@meer.lwn.net>
 <20240329195602.382cb1c99bb70e3d8c6093ae@linux-foundation.org>
 <20240330144848.102a1e8c@kaneli>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330144848.102a1e8c@kaneli>

On Sat, Mar 30, 2024 at 02:48:48PM +0200, Lasse Collin wrote:
> On 2024-03-29 Andrew Morton wrote:
> > On Fri, 29 Mar 2024 14:51:41 -0600 Jonathan Corbet <corbet@lwn.net>
> > wrote:
> > 
> > > > Andrew (and anyone else), please do not take this code right now.
> > > >
> > > > Until the backdooring of upstream xz[1] is fully understood, we
> > > > should not accept any code from Jia Tan, Lasse Collin, or any
> > > > other folks associated with tukaani.org. It appears the domain,
> > > > or at least credentials associated with Jia Tan, have been used
> > > > to create an obfuscated ssh server backdoor via the xz upstream
> > > > releases since at least 5.6.0. Without extensive analysis, we
> > > > should not take any associated code. It may be worth doing some
> > > > retrospective analysis of past contributions as well...
> > > >
> > > > Lasse, are you able to comment about what is going on here?  
> > > 
> > > FWIW, it looks like this series has been in linux-next for a few
> > > days. Maybe it needs to come out, for now at least?  
> > 
> > Yes, I have removed that series.
> 
> Thank you. None of these patches are urgent. I'm on a holiday and only
> happened to look at my emails and it seems to be a major mess.
> 
> My proper investigation efforts likely start in the first days of
> April. That is, I currently know only a few facts which alone are bad
> enough.
> 
> Info will be updated here: https://tukaani.org/xz-backdoor/

Thanks; I appreciate the update! And I'm sorry this has happened to you.
We'll all know more in the coming days. (I, too, am on vacation, wheee.)

-Kees

-- 
Kees Cook

