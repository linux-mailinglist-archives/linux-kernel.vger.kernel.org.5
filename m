Return-Path: <linux-kernel+bounces-84395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A986A649
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794C6B2543E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F94400;
	Wed, 28 Feb 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOxkSdMQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78A1FC4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085446; cv=none; b=gmaQhOMJ6pgfRUEMSYygt66hY1DoTPzl5veey7FeXTXYHU3Mql/rxBgE+JH8HmRps4cMKeuEBu6rwQ2X73r1b4fs9jRs7epaCjjbj/IMXh5tx98MA46r8iYNyKpvCjJNIPt1jUX9kiatiytMev1YzX7gKUOxMmD/Eqp+lWmG7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085446; c=relaxed/simple;
	bh=+a9dNNgdkq4vK4Wl6n5aQaTSAax770T0aGqBksUGGuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqFMgCdLIQobBgc+9arln/t3tyYZ7/6A53aEXHfyIk9GFBTsyCeXEKhOIrCThg8hE2G00W2CBhBeVSO3AR0vTpqMjGw2ibyyscB8K+akaWalc7O1iAXhixAVHFIrVaSMgj7GODpUWM8ME+KpzSRzF6OaQeWMfeJF93LFL+XeUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JOxkSdMQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3485711a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709085445; x=1709690245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWTK2qAsJXuaA7ZAbG2xofrLPhR+ku3/fIq0eyNkJ60=;
        b=JOxkSdMQPwcgNGlS8KlGGL8xhYO/oJYAKi+zzgPwd+gdUBMb7iVyYkFjBO3r6siOaM
         UCXiBQBsueaO8I/LevG/vpbXl9vRgH6sydC6NxycTp7fczAJadn5Fx6nfsfLn41u8XKT
         Q8mgMrIr7p6hyPBjMoy/I3Bfm1YiLxuPBgXC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709085445; x=1709690245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWTK2qAsJXuaA7ZAbG2xofrLPhR+ku3/fIq0eyNkJ60=;
        b=q4tv5bF2LRLbLr0firKTRvHc8UzyMJY35qe1RUKPWkKtcchcIb0Fy7n9aynO2w3UZf
         Q+sQH7ckaJ0t6gr278BrNN1sMtftaWZkws/YlP3QDL67uFS54iqY/Mhyys23hqA4A0Wl
         PnkMJ59XGu1H2QBPGgOl3W3C/KyfgP+IIe4/v+Uvs0SlCV3bf+vHupPFjhAIxWJMBJ1G
         JQ51JgAaOrdsQvlqD6Dt5RjOWOQSoBQn1+OtSTPjJ7SlzK70Aaz2WBHRsPh91cUtPdyJ
         9XFBLv8uFFnhRKQJAbPJcasw5dvuf2nIoNW301hbRavyzblW035+Ny4C3x1ADpHxrqkX
         Y+8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyAsFvz2fZXpGFo1mSrlphE2yjKnAAcktmOqipdOkdBzttp5hE9Xo1Dp2dve4DfgWZ3wACuwkXS1RY5dVM3Rtv/Hg5rO9Iy+tvSUxO
X-Gm-Message-State: AOJu0YzMGnRbaQNtb3fSpm7tS9pnoVW5FL2aYd42MkhzIyVmdGAYpU3L
	rANc5lsMe8oFRhSOGa8SzjeHeJYEqCRIafltNg9Nb759PLmdHrIq7+QJw/qz4A==
X-Google-Smtp-Source: AGHT+IHfFiYBIycGpL/RjI1++fzCYL9TL/Zl0bOOYTg2mXk9ChqxW2RziV3sNl6US29OC7iBMUUEDQ==
X-Received: by 2002:a17:90a:9913:b0:29a:11b6:a333 with SMTP id b19-20020a17090a991300b0029a11b6a333mr9696318pjp.15.1709085444714;
        Tue, 27 Feb 2024 17:57:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f4f0:fb4d:aa01:9068])
        by smtp.gmail.com with ESMTPSA id sv8-20020a17090b538800b0029658c7bd53sm239765pjb.5.2024.02.27.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:57:24 -0800 (PST)
Date: Wed, 28 Feb 2024 10:57:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
	hannes@cmpxchg.org, nphamcs@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm/zsmalloc: simplify synchronization between
 zs_page_migrate() and free_zspage()
Message-ID: <20240228015720.GC11972@google.com>
References: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-zsmalloc-zspage-rcu-v1-0-456b0ef1a89d@bytedance.com>

On (24/02/27 03:02), Chengming Zhou wrote:
> Hello,
> 
> free_zspage() has to hold locks of all pages, since zs_page_migrate()
> path rely on this page lock to protect the race between zs_free() and
> it, so it can safely get zspage from page->private.
> 
> But this way is not good and simple enough:
> 
> 1. Since zs_free() couldn't be sleepable, it can only trylock pages,
>    or has to kick_deferred_free() to defer that to a work.
> 
> 2. Even in the worker context, async_free_zspage() can't simply
>    lock all pages in lock_zspage(), it's still trylock because of
>    the race between zs_free() and zs_page_migrate(). Please see
>    the commit 2505a981114d ("zsmalloc: fix races between asynchronous
>    zspage free and page migration") for details.
> 
> Actually, all free_zspage() needs is to get zspage from page safely,
> we can use RCU to achieve it easily. Then free_zspage() don't need to
> hold locks of all pages, so don't need the deferred free mechanism
> at all. This patchset implements it and remove all of deferred free
> related code.
> 
> Thanks for review and comments!
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

JFI, recovered from the SPAM folder
"The sender hasn't authenticated this message"

