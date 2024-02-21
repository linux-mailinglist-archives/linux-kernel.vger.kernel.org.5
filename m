Return-Path: <linux-kernel+bounces-74773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DD85D995
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3598286BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B27C094;
	Wed, 21 Feb 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlHB78da"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EC76C70;
	Wed, 21 Feb 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521588; cv=none; b=h0A7v293HaIN/wB+JCEoYFy22iGdO0p6OvQXLleFvMVdA3yFU+bfFLlnCPr8Dey7cy4AWe9vrtFolRwTT/LAwZLurmq2BVfgdsIifRx1/77OxGoUDm0HybanI++2HS1QijgW02qAHvPLbi6YZWA5SVuthFMT9rCxHBrcfShJIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521588; c=relaxed/simple;
	bh=74j0KMRvHouF5ZmtPFEUMnvXFGsbWB29eVIGATcfoos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkapJQuyf6U7fc7skVuXHGK9uPUPiVzNo16LGUkQ31dW03/UksJOFY1GoPlRhPG3a4OWxyAJ9hIk5HNyZKIDA7BQs9uI/95jo4TeU74LZubdzHdmBgdNC3Xz4oOo75dUhNIORknhFpYpyJgWWmUEV91bbnZu4SqAbx+rXNhewZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlHB78da; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e46db0cf82so411734b3a.0;
        Wed, 21 Feb 2024 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708521586; x=1709126386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fVXs0c1xW5R0XcN/TtjeHMhc8Un9kbDR9fRIOqUs0M=;
        b=ZlHB78dad0g3q/vLp1o3OhHKH2KUw1RixCtwHqEGUeJrGPEPxycZV5DwOlXBUX+o2K
         VijvuceBiw7q5OR8O3ULqSek1a/uxt00Gmo3CAVBe+TUtrhA5GxJxcvsZDuSL+GWtM19
         q5sp8ImvdG2jLyRkE78q2RtxiU3crSYsvN7ikp+XEvzAcZdDBr6yhflUw7JAB19xF/oH
         5zRkVAX+BPeRSXqNY+NtT+EckD4TEoI9XAlwXOtaPofFSLhuNvfFsAKgHcnNfm+65O0E
         CAv2yxIBZ6UYH/Nt0pepMcjPZP7flWNj3BJSCDA10VmaoNF/rEoijNq+upSlj4gSX6kp
         8g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521586; x=1709126386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fVXs0c1xW5R0XcN/TtjeHMhc8Un9kbDR9fRIOqUs0M=;
        b=CZQtk8chT6fgXWYINzxY10RBBLTd5cB7N/pMkRkU5gARhd9h7toF9t5s+0Ze5XOCR3
         37lMO/ENYDgxSO6i8Blsp5uu4YOj9oL5IDuGvE8hLQ6Loz8192+v/adrZuyxs/ntQ1zp
         yIFLcCmIiZCm+x4KtNoFtflha9ibykgJIxkQMZSKh9A7nQUGkDmLAiwUNoHCgishvbg/
         oO7NzIeELrauhTOoFfWrC2F2p76bZx4N/N3+kNxEiEKCY299cnw1TTlK9jpY1/0oy1JU
         ubx4Klup2yJwxrNq62TCo2rtsBxKt4/Zy4P+TNeKvO6A5Ro0raGjp4+unno9779lF0tm
         HMUA==
X-Forwarded-Encrypted: i=1; AJvYcCWVj36hIVmccMHPousHUnYkzAZISj+0S+ez6ascTPxjBpA289z/Pv40XEuvKA4AwKkdq7gjgMncwFn8WShMX6EihocMjGtBul6icakNFofSJI0VX/LMBSEw+oPVu8jUANM6hfoF
X-Gm-Message-State: AOJu0YynxC0gmEfK1PCsFcQKSFhJR89V1q9wUccaqUGSzmlmzqxPXAL+
	csP+36g1cUecstaNYB3rYe/ugBnRZgSUa30KXZXPW3RmdDAa/YmxpvGHgpfPigpYRmrEkOp2xde
	UQxeaM7ELn5wY7NVW97DgewqUhTM=
X-Google-Smtp-Source: AGHT+IEGfEmfoVnXCrDbklzytPcDGpRPdPnaTMTA8aDm2ZJkRdv6l8p4vKCpqsgGl73y2nHG6bdhEYWhMtOeXrHXz1U=
X-Received: by 2002:a05:6a21:1014:b0:1a0:cc7a:77fc with SMTP id
 nk20-20020a056a21101400b001a0cc7a77fcmr589163pzb.33.1708521586342; Wed, 21
 Feb 2024 05:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-x86-insn-decoder-line-fix-v1-1-47cd5a1718c6@valentinobst.de>
In-Reply-To: <20240221-x86-insn-decoder-line-fix-v1-1-47cd5a1718c6@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Feb 2024 14:19:33 +0100
Message-ID: <CANiq72=gYWZ24EEqRL71Vh+YjjK9Bu0QfxGEBzee16QAf4Q6XA@mail.gmail.com>
Subject: Re: [PATCH] x86/tools: fix line number reported for malformed lines
To: Valentin Obst <kernel@valentinobst.de>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, John Baublitz <john.m.baublitz@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <mhiramat@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:00=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> While debugging the `X86_DECODER_SELFTEST` failure first reported in [1],
> [In this case the line causing the failure is interpreted as two lines by
> the tool (due to its length, but this is fixed by [1, 2]), and the second
> line is reported. Still the spatial closeness between the reported line a=
nd
> the line causing the failure would have made debugging a lot easier.]

Thanks Valentin, John et al. for digging into this (and the related
issue) -- very much appreciated.

It looks good to me:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

This should probably have a Fixes tag -- from a quick look, the
original test did not seem to have the problem because `insns` was
equivalent to the number of lines since there was no `if ... {
continue; }` for the symbol case. At some point that branch was added,
so that was not true anymore, thus that one should probably be the
Fixes tag, though please double-check:

    Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test failed=
")

It is a minor issue for sure, so perhaps not worth backporting, but
nevertheless the hash is in a very old kernel, and thus the issue
applies to all stable kernels. So it does not hurt flagging it to the
stable team:

    Cc: stable@vger.kernel.org

In addition, John reported the original issue, but this one was found
due to that one, and I am not exactly sure who did what here. Please
consider whether one of the following (or similar) may be fair:

    Reported-by: John Baublitz <john.m.baublitz@gmail.com>
    Debugged-by: John Baublitz <john.m.baublitz@gmail.com>

An extra Link to the discussion in Zulip could be nice too:

    Link: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Help/t=
opic/insn_decoder_test.20failure/near/421075039

Finally, a nit: links are typically written like the following -- you
can still use bracket references at the end:

    Link: https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/ [1]
    Link: https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-se=
rgio.collado@gmail.com/
[2]

Cheers,
Miguel

