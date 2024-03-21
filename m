Return-Path: <linux-kernel+bounces-110612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97029886147
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3A81C21E84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83294134424;
	Thu, 21 Mar 2024 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MywJxB2E"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527B12BF16
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050664; cv=none; b=f5vkeYTIK/TP5WdVIjaC+4VlAAzPafzKYydCG3uJlOdvwfUnDSly7B7FIFJtcC/lH5BdWB2a9p3KexXOpfdcCLbKYQrlYsfFolIRtK2zR//TnNyngbfkCDFFttMbtqKLDPzemlEo5BdbCqxEo+r00dRXvla5wyFnQZxFv4npyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050664; c=relaxed/simple;
	bh=iixGjUfXCfJMUnrcexrZ0eyfEWhjuM3K/uWarfVEAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZ9HpnjrXAD8NzQcdwqnD4xiWUuG04Dd5EEZOChN/98a40zz9PzCFotJq0WveD5bNInDJCJ5p7RraNKw0gVwqv3tDqsDTQx55lokiNw8jIuHRlgWp/tbDMB6iWI31M1NpyQkfPKnSvVMf7EOT/8/zh/eJ9+dw57cWdDxpxQgb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MywJxB2E; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so19706139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711050662; x=1711655462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iixGjUfXCfJMUnrcexrZ0eyfEWhjuM3K/uWarfVEAVk=;
        b=MywJxB2Ev/EvIGUXTp6CDZKJBaV1dTAPU/uYJ7z6rh+gGTet72+HrZ3UfP2hIUeh2c
         eyCUcyzj7g25EkXl2p7dMtf5YWfQk6oi3ls9GS68vybOO6htWUjgXTey/z9pZ6HxSCie
         T1pPbmVH7KzE6IbthrC3vrkyaORnRLdtaPmmYv5ThOEs6+x8ypRmtRKAe2DfZZvrO/ux
         KFJrZitNhzCWl41+lw+4gT+lufzmEVFzn8B37wQZ5MFegdtzp34gykcMzWohbJdwbP1e
         BwEcS5sO+nrf5W2aRZJ6rxd0E53rP5VzvBxgDk43WVMyQnVzIZKnCtvQpN6XoFbeTQXL
         e6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711050662; x=1711655462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iixGjUfXCfJMUnrcexrZ0eyfEWhjuM3K/uWarfVEAVk=;
        b=J/7Das4EbIlGx8YRaKWDubu4IUcrqcvDWZ3k42qMsW140odJdH+zEcMJPM0ZeXwBqR
         g+ssmlKKdHHo4KQUQ0+3v0xZ65g11gX/2P+HXB8tIcBo4EMfwyBrlBjvEpHCIHccjpyQ
         YfX44CpoXXYS1AN60/cq4vbplKBwO0ECiQCU0W2Yyd/H9bDFWH3GKT7Kq8U9bcS5zlk0
         xZpQBLuMxOyBXAs7n3ZmEUSek/wOB6bHBqyyvPfUAfgrvUgnhCn66e7ZabfONgGlA7rr
         cCugML32kK+ThrBAtNeLo3E4yBIgNVmU2BpQAFuaDDV/3nBjEeEhm+vvxi/2I7V/2rzQ
         6xzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO8s6D8EnFg9t+1PiyIpKef/MmAkIqhHOo7E3BTbnOm+M0TSILUuRpuylSz+tTJrCQtiS8F8wkOYypgR6I3qx3Is2vRYTYwJ438ZAM
X-Gm-Message-State: AOJu0YxF8Movg2Tk6B9EYqm0LbwB5+A1ZPjkDgza4psZh3FscqDGYrTe
	mVU9yiEqx6mgy9dTCp0fYBZvBH5Mg/UvaKS//avdhahRu65ykYSDtDLbMfLXMARE49VuM4Noo8G
	vsQqLtWgYZjFl/j8vt8kkfu+LZAQ=
X-Google-Smtp-Source: AGHT+IHC04Mxu4uYGYqSg1xnE6M0Y538u9f25FwsU4ZoeEecU70fYnSo3hpS+8ZP7mILcujhKphNK14BU0LOGThs+x0=
X-Received: by 2002:a92:d450:0:b0:366:b0bd:3a1a with SMTP id
 r16-20020a92d450000000b00366b0bd3a1amr555954ilm.1.1711050662557; Thu, 21 Mar
 2024 12:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
 <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com>
 <CANXV_XwaPOOYuAsveVbfNU4tFbw30rkX3AKrBdKzrNNsUxer+Q@mail.gmail.com> <CACGdZYLn5pokOQN-uqeaVPSOtVUHy+CGmuBduhgtV+Vft8WxbQ@mail.gmail.com>
In-Reply-To: <CACGdZYLn5pokOQN-uqeaVPSOtVUHy+CGmuBduhgtV+Vft8WxbQ@mail.gmail.com>
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date: Thu, 21 Mar 2024 22:50:51 +0300
Message-ID: <CANXV_XzktootzRkRSWVCgBTUOdS5eOxKZyGV3w+uMYO1uAavKg@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Include linux/types.h
To: Khazhy Kumykov <khazhy@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:56=E2=80=AFPM Khazhy Kumykov <khazhy@chromium.org=
> wrote:
> I'm also seeing this, on clang.

I think the error is more related to the libc version. I updated the
libc6 to 2.35 and noticed that the <linux/types.h> header is included
indirectly through <sys/stat.h>. The relevant sample of the include
hierarchy for <sys/stat.h> with libc6 v2.35 looks as follows:

 /usr/include/x86_64-linux-gnu/sys/stat.h
. /usr/include/x86_64-linux-gnu/bits/stat.h
.. /usr/include/x86_64-linux-gnu/bits/struct_stat.h
. /usr/include/x86_64-linux-gnu/bits/statx.h
.. /linux/tools/include/uapi/linux/stat.h
... /linux/tools/include/linux/types.h

The <linux/types.h> is included on the latest line of the sample.
Starting the version 2.28 there's an inclusion of <bits/statx.h> which
was not presented in 2.27.

When building the resolve_btfids with the libc6 version 2.27
<linux/types.h> is not included through <sys/stat.h>. The include
hierarchy for <sys/stat.h> with libc6 v2.27 looks as follows:

 /usr/include/x86_64-linux-gnu/sys/stat.h
. /usr/include/x86_64-linux-gnu/bits/stat.h
 /usr/include/fcntl.h

To avoid being dependent on the inclusion of <linux/types.h> at some
other place it looks reasonable to include it explicitly to bring all
the necessary declarations before their usage.

What do you think?

