Return-Path: <linux-kernel+bounces-37260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC97683AD64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAE51F2244A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00C17C0B2;
	Wed, 24 Jan 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9vKg5rf"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67B7C096
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110286; cv=none; b=o+q5EQcOrmnb+pwNsF3Qxkk2Iysc6BUIjnLo/Qg79Y5KJh5WB/oLFfxyI9Vewzr5Uo/6Upja3KtXU9/Gv1WhX083evYhzWLURg0J76hoDgS3zzXl9jEl9AL9ENSNL83VmHDf6zNgHO1li1AbPGhvlyaBS5A6n64oWOLL22GNZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110286; c=relaxed/simple;
	bh=GpDYrGFUEKKunXNg/UYXj4fE8ADfmJRlUhj5IzkEgCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRhvwc3fjHv8zkajBsE0ouOFAHht13COCDrLJiEVXrvWGiiggr7EgT+ek90nBOhHDui4iZEjtDyjTRfRYY9cYNhgzBBq1enVFEEkSr2v2wZ8dH+AMmH2PmuY17ooUNqsTl6BJr+S3aZXfHWBdfMROUoZxjpFUF8XuTzP3VmzB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9vKg5rf; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bee874fcc2so292293339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110283; x=1706715083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpDYrGFUEKKunXNg/UYXj4fE8ADfmJRlUhj5IzkEgCY=;
        b=M9vKg5rf4SBo5sNMRsUeUZKluzVst/gpTn+19jdKPl1BeVlhZn5PohZPqVo286Kv2i
         804eTumACZOaKUWZgqQFCejIelieT7WfkuP+qzlZkYc+TWOHGh2G8ejjbDV5zHYipx0a
         RJ4SrT9dx90CI9n9rH30DAo82p1kDTAN1/9fCzJeiMbhJjXcn1fVtDiwYEHGBOQTRj/b
         R8/gLzh1O3bEgZ/AtOFwFjNE+YS40HxWZcJKOzRSo0JgCYCkFFH1SKxoArxaMoHHGY/B
         PFnWs1W5yEMcNE4UKIoMgrrTukIJsf7MCNsIBEEVzdWeZOxGJkWCk0KHexiFZwEt4FJW
         YwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110283; x=1706715083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpDYrGFUEKKunXNg/UYXj4fE8ADfmJRlUhj5IzkEgCY=;
        b=fVyFVSe8uUX626nFXNHTC8uWRh5yQyIBBcx2GPLUxn55uPZulk81bP4V/1GVLORIqD
         Edv2ZRkRR9te77mI39aKcmt18MdSLcsZHuYddWTTr8WS0NlmIX2jgYK+wH8a5RoSZXSK
         c9Ms5fja8oWikMRwe1kNxb9JGHF18gQ2XlgkKZsTA+ZIlvmSux4xhb+L+A+J25G6JpkP
         c0ddFe9tmu8jACpWENOoPo2dLcT352368F67idemVQCIzzbPrYlfkNJmBkIl1iiaJ+fZ
         a0MIEkhi/emLJVoiGBT5PL0FsDcaVtGHw6Pp30g8J+WP0LJA5g34NLWxeVwHv04ruDaf
         IQ2Q==
X-Gm-Message-State: AOJu0YwqTteyiPp8wU3ucC6WuXuh4RBe1TIwDnFp+9vA0Zz72j5ydXcZ
	Eaat1L5+agfV7D99ZQpSRq0CFLnVYizVLIo8snv6BDloL/TWncablVtSpoAJmk3rg/0Ewp92e6d
	UMFo+T3qtxhRoyJrvB7T3RLjNZRA=
X-Google-Smtp-Source: AGHT+IFmbG26lQ7rCOD6Ezf4LEillA3aq/WsGuNbM4NSyvksQSzDbi+OEeFCinMox0HyF9tz6wiv6wOw2C1N29vgjBc=
X-Received: by 2002:a92:c268:0:b0:35f:eb24:bb54 with SMTP id
 h8-20020a92c268000000b0035feb24bb54mr2260604ild.99.1706110282995; Wed, 24 Jan
 2024 07:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
 <2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz>
In-Reply-To: <2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz>
From: Donald Carr <sirspudd@gmail.com>
Date: Wed, 24 Jan 2024 07:31:10 -0800
Message-ID: <CAOVeLGRxXfs4wxSmB2ULZS72NvJkWQvZyPRz0rAmQyFtL39ekw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.8
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:06=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> When testing the rc1 on my openSUSE Tumbleweed desktop, I've started
> experiencing "frozen desktop" (KDE/Wayland) issues. The symptoms are that
> everything freezes including mouse cursor. After a while it either resolv=
es,
> or e.g. firefox crashes (if it was actively used when it froze) or it's
> frozen for too long and I reboot with alt-sysrq-b. When it's frozen I can
> still ssh to the machine, and there's nothing happening in dmesg.
> The machine is based on Amd Ryzen 7 2700 and Radeon RX7600.
>
> I've bisected the merge commits so far and now will try to dig into this
> one. I've noticed there was also a drm fixes PR later in the merge window=
 but
> since it was also merged into rc1 and thus didn't prevent the issue for m=
e,
> I guess it's not relevant here?
>
> Because the reproduction wasn't very deterministic I considered a commit =
bad
> even if it didn't lead to completely frozen desktop and a forced reboot.
> Even the multi-second hangs that resolved were a regression compared to 6=
7
> anyway.
>
> If there are known issues and perhaps candidate fixes already, please do =
tell.

I am experiencing the exact same symptoms; sddm (on weston) starts
perfectly, launching a KDE wayland session freezes at various points
(leading to plenty of premature celebration), but normally on the
handoff from sddm to kde (replete with terminal cursor on screen)

Working perfectly as of the end of 6.7 final release, broken as of 6.8 rc1.
Sometimes sddm can be successfully restarted via ssh, other times
restarting sddm is slow and fails to complete.

Yours sincerely,
Donald

