Return-Path: <linux-kernel+bounces-141928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E28028A252D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8777F1F2215E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B479FD;
	Fri, 12 Apr 2024 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FA1v+h7P"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3179ECF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896436; cv=none; b=dEM9AZ4sACHvKIJF3eIdqXh2CUTFhuG6ohF7itJfTqC6GERD0LDt1Y/mLc6iMXHIGml+tnkOEj4JVQBwnI3qGte2iBuX52gXFsSt6koI5Q9UibF5nJtwZjAnMRc8jS+27VQS+kiqnDQ480RcJQMutUZDxZc4xQzZND3dl7sZ1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896436; c=relaxed/simple;
	bh=SJuUOTk+tPDs17txQdrtU8laczHkgPN5aFVZ1F1rw/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5ExbTzgPYjBHhf9ZHQPXN8LHU4BQqBgvS7CMmIC4Ias3uaB8oStI684uwkXACYdT6uINVESHHH9mLMUm7uv4rWIpif7v/foj8falNurOW2mo5NMe11Ed56JqNs0IMXkOZSJJ5Czso9TfVvNhIejBVLEGKUlobefdmBWvZRhgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FA1v+h7P; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-434ffc2b520so105451cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712896433; x=1713501233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVRSfRvmBRbYw1q/vaK/nM/qS2bMxaTpEW8dnav8EoM=;
        b=FA1v+h7PEzzFV2nE6nY45TA00iddzXIDkYujxApXK1fVRxs7PH94ZuTFCaUHJpfYz8
         uMgx9ESDzZlu+GRifX6t2nMZLIVjK1QQmADtSqx7sTNAaaUjIfZb1k7/lxqJB9S0t1SD
         Y+GwYbKyfLCjZgRRkcxMCyjGyH3tl2KG/P/4k3TMOxX9FK1Jm2YDisF3hU3Au3VXfNVW
         XU/C/vwiVb583J7gbosQbpmgjRW7EXdkfq6Qt2yY+fsDuDqJc4rBST1Fj+oYvW1Lept0
         IC35415IdEWi51AldPB1NnKbgpYFJXZnukQAOoXz189+qKgppU4fo8YbDJ7PQOsoDeWC
         PIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712896433; x=1713501233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVRSfRvmBRbYw1q/vaK/nM/qS2bMxaTpEW8dnav8EoM=;
        b=V7KIu5rOQeOh1DBZjIRLAYqDhNFhueRIEJdNCxUSXJAqDEti3XojY3HJDZ4mlWmgZA
         ZO490kBkEQv+o737aMEYsItn0nm+SZKSDUG5uHL0RXRbUBeMA9zpeejiny52ystAR3+Q
         Q/vY9m+rMUqX1FzsUpBsdQgj0EOGVIj1lLhJ84Btc73cjdgpVtrrfyPwHpRgUGyyf7kJ
         Ed+b1P2d7ZLxA/1PY+L6FjhzOEfnPeGwYX9CFvnylQoFo4e8ta+8bes1uj7ygK9Qo5RA
         mGoO4SYQdyblClzVN3Y5QMSZYipDesRIIy1jtukj6Op1SV9GEqwsbd4iPWV3w115w1U1
         sh0A==
X-Forwarded-Encrypted: i=1; AJvYcCW8K75R5uI7snohMcq/TGtC5y6CIz8ti+htdavEXdT1HDFos2yu190CheOWWYA2B1l6YhEPdUi3A1MIc7sKPE7Lz41Jx48n7PcOwV/y
X-Gm-Message-State: AOJu0Ywh8Ws8BxRQ5nrNirBx/80hn3WgXFsSFSgYAxYRwVTNMPA9H3xg
	l2I35EPk0AfZrLT6LcZm7dVBDX1UUWJT+LyFRkR8+385B6wSefsLmPjt5fwuT4UWnqIkNKitr87
	ZGKjT9Pm9VMWEG7hT3mhChNSTE7AofIC8Xu/L
X-Google-Smtp-Source: AGHT+IETP2n//L+kxBDDp8gcDnZCE5kU7b73rpf8Dn1Q/fiMFtcf2Jqd5JysQcbhoF7R3IYgW5oLE+44lL+65Vn1Cng=
X-Received: by 2002:a05:622a:4898:b0:434:bdee:935b with SMTP id
 fc24-20020a05622a489800b00434bdee935bmr106821qtb.27.1712896433572; Thu, 11
 Apr 2024 21:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051539.3001988-3-saravanak@google.com>
In-Reply-To: <20240222051539.3001988-3-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 11 Apr 2024 21:33:16 -0700
Message-ID: <CAGETcx_zC_HKoFr=m_erAM+tWPQLe8TuLtJpZ6+dtac8UEYCWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpatch: Don't check for 75 chars per line for
 create/delete mode lines
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:15=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Cover letters have a "create/delete mode <mode> <filename>" line for file=
s
> added/deleted in the patch series. Ignore these lines when checking for t=
he
> maximum 75 chars per line limit.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

I know patch 2/2 is not going to be picked up. But can we pick up this
one please?

-Saravana

> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..f306634a938c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3271,6 +3271,8 @@ sub process {
>                                         # filename then :
>                       $line =3D~ /^\s*(?:Fixes:|$link_tags_search|$signat=
ure_tags)/i ||
>                                         # A Fixes:, link or signature tag=
 line
> +                     $line =3D~ /^\s*(?:delete|create) mode\s+[0-8]+\s+\=
S+\s*$/i ||
> +                                       # A "create/delete mode <mode> <f=
ilename>" line found in cover letters
>                       $commit_log_possible_stack_dump)) {
>                         WARN("COMMIT_LOG_LONG_LINE",
>                              "Prefer a maximum 75 chars per line (possibl=
e unwrapped commit description?)\n" . $herecurr);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

