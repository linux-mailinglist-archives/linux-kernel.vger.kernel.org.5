Return-Path: <linux-kernel+bounces-45537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1262843225
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112BB1C22F18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95FC653;
	Wed, 31 Jan 2024 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YqnxiY/i"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90781847
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661583; cv=none; b=VXL36BaFPBC4gpkR1RSK3dw0LNKXlzia+Yw82SuQr8RAj4qbUi5EuTjCj6pGqi/UqlryVS9TgzgCZ4mCeSxLZU+CJST3M/K1Q9bQfHbR0OCsIW5ubL+gmAAJ7oXstSjmvUn+8f5um5LxpkhB2akLZ9xEf92J0COuJHf5bX8Khew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661583; c=relaxed/simple;
	bh=J/Af+q/+G5EdzpIALeJ0Em187C5NEmRJQVgUzDKulro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAAEdiuQ/r2zHkXmmxJDMdsXRJqPGfNVF8wgF48vVX4kjujniP26QcQUd9chul4WB1h6eyUqt3i3080ed7ox35iNihc3iE7YA86eoq3RJKvdZex3+zD3ZIrpyEcjX39FaQ/Apoa8cwrEIEjfwDvy2vO0SIG5Aiuu07uwRmgmvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YqnxiY/i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2a17f3217aso626612366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706661579; x=1707266379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9FCNsq83M/0UbPD7GFdEOcSc23GjT8FA+ckKBKN0U0=;
        b=YqnxiY/iXiWnxZnNUQAm6KxVTn9VAe8Yc8YdYTVW9zaptHcrFQZp84/MIsNfiYELqd
         /IGGDHmpDlrECLV+ZNvOOYNW6idRD0NVRRCgrGio2VhaurSK2m0ftM5MuVfhBJITCdX9
         /0OkkjKJ1TCKGO8wQfDyQsRvA09xt+s/nCJuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706661579; x=1707266379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9FCNsq83M/0UbPD7GFdEOcSc23GjT8FA+ckKBKN0U0=;
        b=Ple44X+aq+3WaGMafTFRQFOW58TbGGVD20k0ISTwzlqw3RpUgiPjxm1ffSX4Zibm3Q
         /2fPwPmsnaOQXIF/wNM0J3bshC+NQR9kZMrDRYTmxFALu+dR8UwgzO+0PzVzv2fcLDPR
         2TngzE+lFcXh/VW/CgUEeqiX7ygDsJI0WMUfb2qw7A4tJhfUqcI1I5XwAsib/YadFveW
         uBJT8fx+4tJI5GCtqlLVyELW8aK2VEPcFetZA08Q2N4i3iig4IVA22YiYhKj5/VfnNuV
         8RoOhboYeMGGQ5z3PLugupq9EFQ5FxczBXFdDtXKr3zcEuDxXrV0tz76a9SpTFid5V3p
         5NIA==
X-Gm-Message-State: AOJu0YyUsm6hCsvEAV8f7B2/gLJYsrno+5Qky9oomXGYbMSyUnCkCjs/
	al7biL7HDpYx57zuKjlVovs5/YhJektrUgVPapqkqTbEcrdQUluRzOIkuB2JZ6pMxQtXHBjPJMc
	OqKRWXQ==
X-Google-Smtp-Source: AGHT+IHQacZtGReaQ5uA3uDhPcqUTcDYzcb0+9VziNDL/w9mVjIOlUjAJAlt7/idbviTMxgbvrUMTA==
X-Received: by 2002:a17:906:3e57:b0:a35:f446:d9bf with SMTP id t23-20020a1709063e5700b00a35f446d9bfmr25795eji.35.1706661578741;
        Tue, 30 Jan 2024 16:39:38 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3611f17180sm1444963ejd.55.2024.01.30.16.39.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 16:39:38 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso3984668a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:39:38 -0800 (PST)
X-Received: by 2002:a05:6402:3126:b0:55f:3fc1:a8b7 with SMTP id
 dd6-20020a056402312600b0055f3fc1a8b7mr1454edb.7.1706661577815; Tue, 30 Jan
 2024 16:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-3-torvalds@linux-foundation.org> <20240131002346.GN2087318@ZenIV>
In-Reply-To: <20240131002346.GN2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 16:39:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLUwY=eW6_fEuxH+M-Y+1udkZ9yMqdsRwhAYPv78TjkA@mail.gmail.com>
Message-ID: <CAHk-=wiLUwY=eW6_fEuxH+M-Y+1udkZ9yMqdsRwhAYPv78TjkA@mail.gmail.com>
Subject: Re: [PATCH 3/6] tracefs: dentry lookup crapectomy
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 16:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 30, 2024 at 11:03:52AM -0800, Linus Torvalds wrote:
> >  {
> >       struct eventfs_inode *ei;
> >
> > -     mutex_lock(&eventfs_mutex);
> >       do {
> >               // The parent is stable because we do not do renames
> >               dentry = dentry->d_parent;
> > @@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
> >               }
> >               // Walk upwards until you find the events inode
> >       } while (!ei->is_events);
> > -     mutex_unlock(&eventfs_mutex);
>
> Unless I'm missing something, you've just lost exclusion with
> removals (not that the original hadn't been suspicious in that
> respect - what's to protect ei past that mutex_unlock?

No, the mutex is actually taken up the call chain, and removing it
here is fixing a deadlock.

Ie we have the mutex taken in eventfs_root_lookup(), and then that
goes either through lookup_dir_entry() or lookup_file_dentry(), before
it gets to update_inode_attr().

That series is not very clean, I'm afraid.

          Linus

