Return-Path: <linux-kernel+bounces-41985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0983FA55
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24262814BE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919D3C492;
	Sun, 28 Jan 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GHaTaez0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081EB3C6A3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706480768; cv=none; b=rwuklJl2VPbPrHISgPrO2gAoP9g/CpL/UUs1OWVcr2B/4Q7+owljSzmSbdKffI0tuAXi0vrTRkOor90rQcbqVMDLXrpVg2Pem80iRFLcBS9EwgQkDnwdJp99AIqunxu5ejUnlVE2yJCylvo9i5++aNIykBVA7eLIpkKdR8dklZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706480768; c=relaxed/simple;
	bh=j+se+h8m73lMZ5bO5OVB41iLFrTcnxKO4rHbaHCahqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMnauhq6x0M9Y35B+tSg0U77HnH6ad8+oSfVYSgWUx+q8dBZIG7NxYRtrAHrHP6yDY/YqA+KFld9Wne8TVGYjeK09M5ze1qYj/wq9JF1kTRlgu2dWHactP5GPGU7cHzl/GX7bydXCkwdyBlUlYJglEk6HIA2o3C/Xvyppf6b9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GHaTaez0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so2293541a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706480765; x=1707085565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HN/bf1OB33r34YH/RajJRYZVQ8GWrEHQI2/Udp84+Ew=;
        b=GHaTaez0gRC31ErIJiPbZY6QG1zasJww0Raz+NWnRW+ygokr7hKUGDbE0y9uwfepm0
         8bj62gY9Y+c/IFNim4JtAtpdgGsDB6u17ODsroQ3TUOxp5SzBpM+xjsrB9K+pez4tesz
         Uj0ig7CXRW0UKC/998cWRYaMFamNDBURL2rlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706480765; x=1707085565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN/bf1OB33r34YH/RajJRYZVQ8GWrEHQI2/Udp84+Ew=;
        b=IzoMy2HNG7id146z/aEP7b0wQulvFT6RQJGbIn9YMcol4EZAeKVeIW5sYRKrLoo1/N
         1G5cBr+daD7hIslcFvILDEFpMSYmBxhevrcf6nZ8Rfgaxz/J0ZilrwAsSyKi2z46RTqw
         w4JVyPteZaV+mudncRd20rUK72j9u9dd71ynjcLgvC07o73L2PwMyUWOaeV+BP0hOvE6
         X50X8YDOhKEUy2rYySznfGkynHKt6xkk7/gAYpVLJQl2Tz1Iz9EMhz6ZkGin3TOSBTwC
         HtmLgccXPoWAW19Cnae9s7lVu3mIlUaI+KWEh+UEAMJfoaGtzUQqOK9Q+T0Kze9P9uoy
         6zAQ==
X-Gm-Message-State: AOJu0YwqURvzzoyWqtnfLfP5sn4bUfAg6iGs7sBpzw2qH34SXUZ2sk+e
	cAkaLnoOBILuFPPl8mHR+CmVEpdz4WWcw2d3XXu752XkfuSgcmq033JfcNTjM09husE8AYJBKJd
	eCRpdfQ==
X-Google-Smtp-Source: AGHT+IFmYsYxC7gVbBtYD3Im8sNf5BvT0JEC69cWPgPvLfuuPSAnmMNmU5B1XOS9Sg5tlHjTpTa5jw==
X-Received: by 2002:a05:6402:504:b0:55e:f164:7765 with SMTP id m4-20020a056402050400b0055ef1647765mr1022369edv.32.1706480764668;
        Sun, 28 Jan 2024 14:26:04 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id n11-20020a05640204cb00b0055ef6a5ff0dsm659528edw.88.2024.01.28.14.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:26:03 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so2293524a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 14:26:02 -0800 (PST)
X-Received: by 2002:a05:6402:3137:b0:55e:b30c:e0db with SMTP id
 dd23-20020a056402313700b0055eb30ce0dbmr2586779edb.35.1706480762366; Sun, 28
 Jan 2024 14:26:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <CAHk-=wj+DsZZ=2iTUkJ-Nojs9fjYMvPs1NuoM3yK7aTDtJfPYQ@mail.gmail.com>
 <20240128151542.6efa2118@rorschach.local.home> <CAHk-=whKJ6dzQJX27gvL4Xug5bFRKW7_Cx4XpngMKmWxOtb+Qg@mail.gmail.com>
 <20240128161935.417d36b3@rorschach.local.home> <CAHk-=whYOKXjrv_zMZ10=JjrPewwc81Y3AXg+uA5g1GXFBHabg@mail.gmail.com>
 <CAHk-=whJ56_YdH-hqgAuV5WkS0r3Tq2CFX+AQGJXGxrihOLb_Q@mail.gmail.com> <20240128171733.2ba41226@rorschach.local.home>
In-Reply-To: <20240128171733.2ba41226@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:25:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc4ieo09KxdUBNXHPB5+LD8XeqhmRVnqf2k8EAx3ZCaw@mail.gmail.com>
Message-ID: <CAHk-=wjc4ieo09KxdUBNXHPB5+LD8XeqhmRVnqf2k8EAx3ZCaw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The original code just used the mutex, but then we were hitting
> deadlocks because we used the mutex in the iput() logic. But this could
> have been due to the readdir logic causing the deadlocks.

I agree that it's likely that the readdir logic caused the deadlocks
on the eventfs_mutex, but at the same time it really does tend to be a
good idea to drop any locks when dealing with readdir().

The issue with the readdir iterator is that it needs to access user
space memory for every dirent it fills in, and any time you hold a
lock across a user space access, you are now opening yourself up to
having the lock have really long hold times. It's basically a great
way to cauise a mini-DoS.

And even if you now can do without the mutex in the release paths etc
by just using refcounts, and even if you thus get rid of the deadlock
itself, it's typically a very good idea to have the 'iterate_shared()'
function drop all locks before writing to user space.

The same is obviously true of 'read()' etc that also writes to user
space, but you tend to see the issue much more with the readdir code,
because it iterates over all these small things, and readdir()
typically wants the lock more too (because there's all that directory
metadata).

So dropping the lock might not be something you *have* to do in
iterate_shared, but it's often a good idea.

But dropping the lock also doesn't tend to be a big problem, if you
just have refcounted data structures. Sure, the data might change
(because you dropped the lock), but at least the data structure itself
is still there when you get the lock, so at most it might be a "I will
need to re-check that the entry hasn't been removed" kind of thing.

                 Linus

