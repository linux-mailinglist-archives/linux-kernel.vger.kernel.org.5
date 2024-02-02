Return-Path: <linux-kernel+bounces-50561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9A847AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443D91C22CA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87531664C3;
	Fri,  2 Feb 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KACTs63E"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D78175A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907436; cv=none; b=i496Q8rRWw3lF5pKCOg+CPsKzGtH7l0ns4OfeRVoYQ+hpf0STMik3eBmREvcV7R93uM3NmSF5Yk+vGQGXoVY/86anSovRkTbHRybNFj0uo2WVACsoCRa7gZ2j98NxZpLunsUjVfxzSwk/dZS4eSG4avIFxGFeVoO9rk3mcfysck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907436; c=relaxed/simple;
	bh=8ocUjGK2oy01qiBgCNBpq+20kZmTzsOI10qpJvgvgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN4JS7UkMw77wXNl0jy/RutikrmUMaRebnvNqVN0ufYxFDdMtSTuyIlh9zFHjJsMPVOL7wK+R/TbJwAYis65djBtaF1zh31bs6CYBeQeBoaYrVtTR4wLCCv16ve9j4UVORpnyup1wP2hG8qj2Zo9PfQzVK0BtZa8Fte3ZObRZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KACTs63E; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dc8b280155so1540598a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706907432; x=1707512232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd5iB2GW7u96qhDXLTaDLBHJW+CgTFsPG8xtoncLIv8=;
        b=KACTs63EtR/6LViJcdoyk8Wa0iQcMmiJlpSXahnHWJ8YGTWGJba7CB/Xa/BxDJgQqd
         ALMG2GCJR6HO3JhzBS3s9F6AiEOVher3pftcZXRr+paWn3veTNXcpEWkr0FXh8L6vLrl
         rNVPU5z+IbxFSEdq9sQsqEKAcE6aRJNfV8LrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907432; x=1707512232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jd5iB2GW7u96qhDXLTaDLBHJW+CgTFsPG8xtoncLIv8=;
        b=A+sbWyBbZcoUViRYL0mTVldYqZQskbsfeKlWTVu4gp34t2qScR5+B9jqLpNEehhjLy
         +wXDPRuvpbSi+xhkLzOYUFZigtCqOuw51STOUvmIawlETfeTL43iwiIo0kdsSLprrIAQ
         4MNJmGAy/PQfbvf6P5UIJvBpVk6pX6Joxu5tUKmOlL1L+J1+1omNngDifuHIcsmLAdbr
         tx930bRnMhG9Hh3KK8rNS2aiYGe1zQIyA1nDZHN310g0VcQ1wVaEbkYOn119MZcWRHaK
         pgnGQNx+HIovIeuu6UWZN3ZN62Jzgirh7BeW3AMa7Ep1NxL0n2CepXMQqJV60U6U29GU
         DRNw==
X-Gm-Message-State: AOJu0Yzqi1kvpIPs/FNCPowoBFiyJTE1aFZhZLi/UtmLhrzSui1/OO90
	izDv+qodidPWUxTTi3h3yDWFdoQgGa8eTVpLaL/IL1IJDfnO2lOAWExF+BlI3PvqDU4NXAIndvT
	lH9C11AMuWB5sMNFdlkWkA4GHixMszXdMtyfN
X-Google-Smtp-Source: AGHT+IHD+GETF8yRafyaSp/X/xP7FsjAotm5fR7M2Zw0jtBAVo9XvmOEOv+rES1WAYdj2NtLbAOCDZfOEWCOvlbcyl4=
X-Received: by 2002:a05:6870:96a1:b0:218:d1d4:78a9 with SMTP id
 o33-20020a05687096a100b00218d1d478a9mr871537oaq.24.1706907432643; Fri, 02 Feb
 2024 12:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org> <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
In-Reply-To: <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 12:57:00 -0800
Message-ID: <CABi2SkXiRKBXQ76uygV1bEegH0UrCJJZqQLNgN=raxNSd_MdPg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:37=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 2 Feb 2024 at 11:32, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > Unix system calls must be atomic.
> >
> > They either return an error, and that is a promise they made no changes=
.
>
> That's actually not true, and never has been.
>
> It's a good thing to aim for, but several errors means "some or all
> may have been done".
>
> EFAULT (for various system calls), ENOMEM and other errors are all
> things that can happen after some of the system call has already been
> done, and the rest failed.
>
> There are lots of examples, but to pick one obvious VM example,
> something like mlock() may well return an error after the area has
> been successfully locked, but then the population of said pages failed
> for some reason.
>
> Of course, implementations can differ, and POSIX sometimes has insane
> language that is actively incorrect.
>
> Furthermore, the definition of "atomic" is unclear. For example, POSIX
> claims that a "write()" system call is one atomic thing for regular
> files, and some people think that means that you see all or nothing.
> That's simply not true, and you'll see the write progress in various
> indirect ways (look at intermediate file size with 'stat', look at
> intermediate contents with 'mmap' etc etc).
>
> So I agree that atomicity is something that people should always
> *strive* for, but it's not some kind of final truth or absolute
> requirement.
>
> In the specific case of mseal(), I suspect there are very few reasons
> ever *not* to be atomic, so in this particular context atomicity is
> likely always something that should be guaranteed. But I just wanted
> to point out that it's most definitely not a black-and-white issue in
> the general case.
>
Thanks.
At least I got this part done right for mseal() :-)

-Jeff


>              Linus
>

