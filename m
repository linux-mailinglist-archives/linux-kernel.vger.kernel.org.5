Return-Path: <linux-kernel+bounces-37567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC383B1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61E61C244DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F489131E4C;
	Wed, 24 Jan 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbbjrVm8"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754013175F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122957; cv=none; b=jHpzLki46BUMVC/myZwtm4183DnfmJg4IeKKDYLRc/LsP7Ldhzhd19v3FFhvE832gywzMAiJsZucnmnqBekqJ+XWXOY8i8rhQJm2vAbQXP/Rhpf0Y5vsGJE8kv9FpnpkJzymEvNAsgYV4Zn/RIoz9xuWNURsmEnYk2Xvh2nKW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122957; c=relaxed/simple;
	bh=qTbx+gTr8wbfiYmgxu2Wovo4tQGBvHswbR+Ga9b2FLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iawRI+0xE4rgFObNI5weiBfgZJEzZR/usX6hcmCVA4sfLT42/smRKOa7QNEilNac5dGXPVYDvnNScPCm5Mj3+LOrGcuIbcbmXH7Lj6xrd8TgqpTgNQ5jmuhl4XtlSmuZXzub8PNDR6c7xPtBrns4+9Ohf1kj3dGa8fbPDZQe/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HbbjrVm8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so1584437b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706122956; x=1706727756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ4JyM8v1WEvN+KjSOc1OYxcBvKHWZsPYaE3NMgfXqI=;
        b=HbbjrVm8y62FJzKNaWCG0Q7iq8XLDVij10apVD7PHPncwOFwrDEyCmS/ReoTUrjqXX
         KFIqP9h4RsPw6m1+trQW9EaM9cv9gZHr26GS8ZbfwQ8P80SB4CGDiHzUDmLqi/F3oagN
         t5LaUH0sJLRKjYrT855WDVKy1+insuqGjQ1qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122956; x=1706727756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ4JyM8v1WEvN+KjSOc1OYxcBvKHWZsPYaE3NMgfXqI=;
        b=QKdbOxw030PAzpdK8bY11uxC95UqWFW2VBhpkddAJE2psvpRIaOcKREUqHfZAEctt0
         rvjSWCHHEH+i8PhnDld522pt/BnHUzlkijFGVorQVJ9Ezb3I0uj+DZyJAsk9WZ6iqLKr
         i4DTYFS2tIpuU0VZZmPYMBHsQKnux/8/FIv6/EN4mSsow/l2MfPWT7oZWYO9rH+lYEaW
         4dlM4w6cx6tZw5OmhDtRYJN04FOZex8pvAuOEpSILPgIIC758aWhUXB01dEEu8JzaSCe
         OLTm2my9wXl+ToWEiuMS8fhxwk2eEIvhRW0/WN33kRGk+5pskcQCP3rxN5rKKMBzp09T
         9vmw==
X-Gm-Message-State: AOJu0YzJWxTJku2e3cV0Cly9Mr8cbo0Z5G9KbAKolVkGCi2ZJTDXhzXG
	DCxXVzBRM6Ji6cHJNyYXM8i4J5gArgtypySbNWQNcUcjkYSnW+H0kgqXGPJS4w==
X-Google-Smtp-Source: AGHT+IFAS/F4RXOGks5GiDY+E8mYR9mPjx5xv7lBQNebt2fpfiOBryRrsDiTLmDYO/08ULmx8oSQ6A==
X-Received: by 2002:a05:6a00:390f:b0:6dd:8709:d133 with SMTP id fh15-20020a056a00390f00b006dd8709d133mr8609pfb.19.1706122955829;
        Wed, 24 Jan 2024 11:02:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a65518a000000b0059d6f5196fasm10694461pgq.78.2024.01.24.11.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:02:35 -0800 (PST)
Date: Wed, 24 Jan 2024 11:02:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	Kevin Locke <kevin@kevinlocke.name>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401241058.16E3140@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook>
 <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>

On Wed, Jan 24, 2024 at 10:27:03AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 09:27, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > IOW, I think the goal here should be "minimal fix" followed by "remove
> > that horrendous thing".
> 
> Ugh. The tomoyo use is even *more* disgusting, in how it uses it for
> "tomoyo_domain()" entirely independently of even the ->file_open()
> callback.

Yeah, I just sent a similar email.

> So for tomoyo, it's not about the file open, it's about
> tomoyo_cred_prepare() and friends.

Yeah, it looks like it should happily follow cred lifetime, but I
haven't fully convinced myself.

> So the patch I posted probably fixes apparmor, but only breaks tomoyo
> instead, because tomoyo really does seem to use it around the whole
> security_bprm_creds_for_exec() thing.
> 
> Now, tomoyo *also* uses it for the file_open() callback, just to confuse things.
> 
> IOW, I think the right thing to do is to split this in two:
> 
>  - leave the existing ->in_execve for the bprm_creds dance in
> boprm_execve(). Horrendous and disgusing.

Agreed.

>  - the ->file_open() thing is changed to check file->f_flags

Agreed. (And I've tested this for AppArmor now. I can confirm the
failure case -- it's only for profile transitions, which is why I didn't
see it originally in testing.

> IOW, I think the patch I posted earlier - and Kees' version of the
> same thing - is just broken. This attached patch might work.

Yup. Should I post a formal patch, or do you want to commit what you've
got (with the "file" -> "f" fix)?

-Kees

-- 
Kees Cook

