Return-Path: <linux-kernel+bounces-31619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE72833100
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B952883BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037DB58AC8;
	Fri, 19 Jan 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wsj84mse"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9D58236
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704804; cv=none; b=oixtIt76SCxDkZP4JZPkEnmRrqgGEVgFSXolLnbqmU5TIwfDQQABdRPsq2aLnGlLNyMTCV09xKvvA+s4CTe/Hz++s4lot9Yo6HFTLHJpN5McedmgVlZy89tF59UV/2YDPP1ROLQmw06F2i5VZxKgSHoG7Q4Gmw5ePWZfZ1XvE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704804; c=relaxed/simple;
	bh=cXFQABVkDQ0a0E3pFCzVsdT8CC/V4HbLE2EFYUk9T0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBD7kfcmwp181vAp0RSgnq71OtDvEDbz3vhntfl97oaV4KTKtv7XZMnxT13/MmqOBjqy4ep0we1W2WVq9ZOmyzSn3C/dgaGcLZU+kdRnecdqHZgCxvac/e/ahdwDis0J9wqLnIUbQEv3DbtO1dIwfwYxxKJDa84GSO1lD9GdeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wsj84mse; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf495b46caso822439a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705704802; x=1706309602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWad+tkSe47JjCBUATlLgY9DkjlP39hvBfIJ4tcS5v4=;
        b=Wsj84mseOuuJwWKO5DTTHSZOePaHDDj2v9gpifG0cMQDIJvA47qHZb6hMliEhYd+9E
         vfuSfgoblCtjHtIVQ0Tjbp05dyrQ3EgeQd/0sIXLH9K2CNcqnB3HGCa/xfX4Wck3UBHt
         kj00AktNWWa/WnHZHI7sRgiROmZUW3O8sObMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704802; x=1706309602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWad+tkSe47JjCBUATlLgY9DkjlP39hvBfIJ4tcS5v4=;
        b=sRl9osw9u85Uumg9Eb/QKebie8sgo3OjpXfvZgNt2geisfnOylqP4FUMNwlfuYI5+k
         tFhWL++yTMOUm8iL5QXFIJb7u9rC9v1QKRNrVmS4U+oNnJ1V/b3PDmP12iRQ+w+OcWe5
         3X0CznVY7lTU7+gGj2ndM0jlkE11rY/lXyObd04FOu3qQkW2B6esCmFYZ9BTFCpJmTqA
         LM3r9xPOgCwTO3GQlsuk1jtgT8MzQAMxIET6UBwPtGyMHBXBFwa3/IlbGOhO72wT8bhA
         gfGpA6Sx80lythepWxttGIYdLnUXFVeMqLXrzx8YLi3HAbtIjkeM3KePKk3Of0JWkZyN
         Ov8Q==
X-Gm-Message-State: AOJu0YzU20xdcszZ8HzSvXB11QILkBQBeQETHKTcq0iSI7bmgISmTxwz
	OH7WDlnTqmnWxxVWgWRtZJqEj3fGvG92iXzT2tBM8zz3MCeoF5g6BRxZQu32PA==
X-Google-Smtp-Source: AGHT+IE+IQHn+4YqB/lmtgA3p4J8DA8wXFp6+0CzprVWrwhYC9bV9FJqlGyXVmXghPBe/oDy22G7SQ==
X-Received: by 2002:a05:6a20:3943:b0:19b:827d:ee10 with SMTP id r3-20020a056a20394300b0019b827dee10mr553889pzg.92.1705704802463;
        Fri, 19 Jan 2024 14:53:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b0028bdc73edfcsm4660022pjb.12.2024.01.19.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:53:22 -0800 (PST)
Date: Fri, 19 Jan 2024 14:53:21 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
Message-ID: <202401191450.CAF805687A@keescook>
References: <202401191311.B6AA79D@keescook>
 <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>

On Fri, Jan 19, 2024 at 02:00:14PM -0800, Linus Torvalds wrote:
> On Fri, 19 Jan 2024 at 13:14, Kees Cook <keescook@chromium.org> wrote:
> >
> > The kernel is now free of the strlcpy() API!
> 
> .. still mentioned in docs and checkpatch. Maybe remove that too?

Sorry, I should have called that out in the PR, but the commit itself
had my rationale for intentionally leaving those in:

    Leave mentions in Documentation (about its deprecation), and in
    checkpatch.pl (to help migrate host-only tools/ usage).

If you feel like that's not right, I can either respin or send a
follow-up patch?

-Kees

-- 
Kees Cook

