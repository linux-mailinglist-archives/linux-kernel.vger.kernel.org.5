Return-Path: <linux-kernel+bounces-37415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A18683B005
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84207B2E876
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE582D98;
	Wed, 24 Jan 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KloGb6hc"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3981AD7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116877; cv=none; b=VxApK8ptXyVwa3wfjEZiPj/Kx+0vWKDyCMLokT5yX0t3d7V/9F7fno6YBErAVcLDWs6sSD8k5f4eS2nva64mrWApBWCmY5Mn3ZFxfVAbDH89Y/ov3RVE1kM+GdwIyN4a8tYb+cdjFKn5U2pIo2po7ewCA0BDyr2/qWJwvVnJn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116877; c=relaxed/simple;
	bh=i0fh2fvqUB6h0Bq9w6eV538kz5PYIbRga3q0Tr+/O4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpboCd/l7NaY9QcVzUPaqDBO2tTUXFmGAkFYlxpODgt1+r9PiDBZcqUkYeRLCxsRf4yQWHiQkp0LzCwMOQuNCcJS7e9ylTvXtI9YkKQF50F3Ym2fX+NmgR22XWLlVYTHV6WeRl3dYubiWWyxvP9ODflU5/McIFRsPwwOrt/GU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KloGb6hc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1517494a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706116875; x=1706721675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=KloGb6hcbTufAwdkYqlBSsWZOgn0F6LTXmIJSgH9nORprcQx8B2lRFJwhTiC2pO2+4
         fLHqqbiXPDUjPxlVt+kyLdHcTMULTYXLTqLdPOT55mTc8/XIaUU9S4krI65CVfTFFBuL
         WzleLev4QZD/VY7xznAXEGiD/XokWkniDoLr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116875; x=1706721675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=nFxbYHiL8C+K47QbFUBBOlBpoe5oBgsQkmI12U8kjsqKefuxxrdn24sgBev43rzAmy
         ZpTJM+dpzD9YeB1k5X7Kt83VW+GS0P3rJiEX5ilocHOISsrbGhwSA3FLx3YaYwIk8tbs
         axxx87AVsJD3eceXw+qAy/Gd1N1vyHaIEqLBuScCcSXoqV0oneoNhqUcR1xZafCEzzKu
         dfS1cQ/LJCKHWUpQWYttHWBL8D51dbSRXY+UYCDUx/kVpghimoIvGbomSMIbd+/pvQxs
         FJGYI1kOJy53gX6wkBR9MBrHtl4oTu2LyQ1ceGS47f96g8vV6jTCu4FIvqup6UbbceSb
         6row==
X-Gm-Message-State: AOJu0Yx46iN4Pe1wf7hLJc3PoJnhKarBrIizxA3gbHKKur+lCmSFQ8SN
	kf33D675CwxN7LwH4IJ13WByyiOCQLqNhI+wknq4N9ETuWkS5nhPkOEFO3hkGg==
X-Google-Smtp-Source: AGHT+IF8mYZHsXtIZHYmarYRM5N7qbVfGOw6LSL+xSG6379FubnYGny6wPevlrY8z5lhGqrKJ4N0fA==
X-Received: by 2002:a17:90a:cf87:b0:28d:c7bf:3a12 with SMTP id i7-20020a17090acf8700b0028dc7bf3a12mr4364083pju.8.1706116875365;
        Wed, 24 Jan 2024 09:21:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id st13-20020a17090b1fcd00b0028cf59fea33sm13880703pjb.42.2024.01.24.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:21:14 -0800 (PST)
Date: Wed, 24 Jan 2024 09:21:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240916.044E6A6A7A@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. That whole thing is disgusting. I think it should have checked
> > FMODE_EXEC, and I have no idea why it doesn't.
> 
> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
> think it would be even better if we had the 'intent' flags from
> 'struct open_flags' available, but they aren't there in the
> file_open() security chain.

I think there were other problems that I might have already fixed when I
reorganized things in commit 0fd338b2d2cd ("exec: move path_noexec() check
earlier") to more correctly map to LSM checks.

> Anyway, moving current->in_execve earlier looks fairly trivial, but I
> worry about the randomness. I'd be *so*( much happier if this crazy
> flag went away, and it got changed to look at the open intent instead.
> 
> Attached patch is ENTIRELY UNTESTED. And disgusting.

I opted to tie "current->in_execve" lifetime to bprm lifetime just to
have a clean boundary (i.e. strictly in alloc/free_bprm()).

-Kees

-- 
Kees Cook

