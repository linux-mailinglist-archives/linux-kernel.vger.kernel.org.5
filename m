Return-Path: <linux-kernel+bounces-162827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D851E8B611B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168971C21697
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1912A14E;
	Mon, 29 Apr 2024 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5T46d4r"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D931EA7D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415431; cv=none; b=Y1OsJFvkiE9dhgT1OP9JbL7o6I7+e7HgaTD/41y3l99XbyFcXnVdxDmS92ryBKJp7CtNGa1zdXpg1Io7XxucUDxYMshUw7VMHINAnW6mKYaz6otGKgNlDN72puYckhah2hePbNZWzEbrh++v1v3fEFSMi+goLmK09/jVZ9I4dfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415431; c=relaxed/simple;
	bh=owUnCLYoRPgs0mrdKX/Pm+hC5u4zNv8hMMak4UZoZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJSI0cEc1mtlXAQsSLZHEU3m1CUQZEDtgJVQRs2nYVvjVlImv2YFUqTRigp4wwsvfkeG9ihX6awKJLkzyNBymPJ+6Uegfm6oDinxBvFoAycc8OeK9CE7+yXQVZ3EkVlfrFXGB9mj5uOlmECnxVBdiZyqqn8ZP1TaEC92tqFOo2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L5T46d4r; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed112c64beso4555568b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714415428; x=1715020228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkpFuoY5aQyyw+nrgLES9BJOsJzkqq/5/Ik8pmOE86s=;
        b=L5T46d4rZ22Ep/ShI9b3mC+yVO3/GqJSPuvSTC+PqjKPi4nyqt6uy589JBFIshTcTf
         rHAj+zTHGphhM9DcOjt18v0c8Dno5csFvRvnC6L34cM9UWXPwVSyIbTY3mmiRNdJN4eN
         DUiKYdhG4+3OCYXDq1HsQqbtFgKIhphGvhn3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415428; x=1715020228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkpFuoY5aQyyw+nrgLES9BJOsJzkqq/5/Ik8pmOE86s=;
        b=e0LawQaBc8nx8aa3bgsHBieSAc6VQvezCkR8xk+lN17l7KUgNQn5Ndeco8s+ArqhqO
         +XyVNrK9osK1jNGVs+2E0rSizdpPv0ELQmDyOs91SdHGYqPURDsLIa4Ktt0f8xHiSofe
         rKP41cdUhrdwZhInSB6fSYFYuWtIPk36lkz74/oOQtxYiZhjlLVK2UcyyD8G1BDX8K75
         FTzzcPABau22GvyrOmcfMngP+VUtu00GlUVpIwvpoKRTQBQtz4rmXdmz9yHk/tp0Oe3V
         xokIQJbVqDFs6K6MXoC9PdtA8CHNW6r6L99jmjmXxkYSyyZrIs3ehhwz2hA2vfT8BG6y
         txww==
X-Forwarded-Encrypted: i=1; AJvYcCXX5F2TrAyw+MidWdM9Sz3NiHmzAcCk7veLLY7/M0eGIF3j+qhHL6rzYyDLn6Amxkv40JHa8f91T/6t27bqoJ3ZyFRcUBi30Mn1gPpA
X-Gm-Message-State: AOJu0Yz/CcEzAIGJjhnMcJsEHqSc7rvWGKto+mbqT7uDS+d+2FfDqwML
	XH0ZiPATyABrvIKcNIjzVZbuKZZRHH9t4JqMy8MUTuRt+abdJxaw8qZbyYfhyg==
X-Google-Smtp-Source: AGHT+IFm/F0nByuRkm7UdHH7GTHif1EcCEbCwry9uts5YLa+VEPBdJBvu/5Z6ZOh3u/DAHGVzCektg==
X-Received: by 2002:a05:6a00:4b4a:b0:6eb:40:6bff with SMTP id kr10-20020a056a004b4a00b006eb00406bffmr8812728pfb.14.1714415428214;
        Mon, 29 Apr 2024 11:30:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fu16-20020a056a00611000b006ecca2f2a32sm19545034pfb.168.2024.04.29.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:30:26 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:30:26 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202404291129.F261DEA21F@keescook>
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
 <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>

On Wed, Mar 06, 2024 at 10:18:59AM -0600, Gustavo A. R. Silva wrote:
> 
> > Thanks for the improvements, however we are mostly at the end of
> > development period for v6.8 kernel. Let me postpone applying the patches
> > until closing the next merge window (for v6.9), since we need the term to
> > evaluate the change. I mean that it goes to v6.10 kernel.
> 
> Sure, no problem.
> 
> Actually, I'll send a v2 with DEFINE_FLEX(), instead.

I was just going through the patch tracker to make sure stuff got
handled -- did a v2 of these ever get posted? I don't see anything in
the tracker nor changes here in -next.

Thanks!

-Kees

-- 
Kees Cook

