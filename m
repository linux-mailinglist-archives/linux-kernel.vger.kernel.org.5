Return-Path: <linux-kernel+bounces-50880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC1847FBB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A3F2822BA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DD1F9F5;
	Sat,  3 Feb 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RIekuo4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474FA10782
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706928558; cv=none; b=Cy6Bwg7cM0f6DHgH1Pp/ZB1BLKsDf+OoPBFcq4VngNhi0dKASQPiGSwEcnqFFmzjJwiQj1YF5Wuyds1K50Ihz4jYUT8RAlj0/UOp8liAnY+OVil5fNafMEEucfrxtnIj3IULnndX7hs04K/HT7FT/98+044JtuTJ0YVfIMUtAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706928558; c=relaxed/simple;
	bh=vqfqX4Je0gQB6B1gJWda0z25IwH75ROT1dwdQ8kgeXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u482+Ec/OU2z2R4DXUbGAxJhR1qCFz9LrSuxfxAShxLPj0c/A09RMucPq3WiGkJZqj0kuIbVWjCn4RVkBOG29wjUl4mqSlv4OIXFs+MTze2UnfUqKTYJOolcoIqgIfjp3cSLN32HOnFUoIjW8Aqe/9mrsT0wTMx2umXbdLlQaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RIekuo4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso106125ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 18:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706928556; x=1707533356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvsVXnyQc0YO6IUrb/2xe3r1pTADCgJR6S4V3R6UYko=;
        b=4RIekuo40Rg57kSf25/JWvydGr2P1zivUJjYFjm9RsQqB3X0rGPOrwid4G8rPUNiUl
         hEdZ/DBdNxy0Sz8zLLhsJFPp4/FsXWynIQsO3EmvyfxSZTT4o8DwkRaFH4dQM+XydZLO
         m79MTl0/e/C3hg52AsV2QoGthtN8HmF51q+4NODgqxe9XFGS7alselxlSOEsaOqTMDLh
         Mi8Sn3r7exigj2hDzlJsPLQkTurLCT4VjuM/fZZKvQW5vxP4uPaSJmUTamkbN5A1FDUt
         tp25jKC5Sii/7xvGXRP8I2K2dvZu4BUp1Tn5dEqj5VEVESshk+eeyHGMp7vHNKkUivOH
         F6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706928556; x=1707533356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvsVXnyQc0YO6IUrb/2xe3r1pTADCgJR6S4V3R6UYko=;
        b=f37cFMxh3ueLtWycBBKe3oAqOH5clpD2mI4lWj8fiItkz9YZ5MMvhBH/3wsM/luq3L
         GnhFAqLIuJcqqX50xf6P5FqrQgXXfPsoj6tHUHzKU+0s28r46e3vUjS4yrJnyrRDlsL2
         zLX8/SoBKwkd4ZpEBq+AflK7dMRYK2suQDzkb/50Sy/R17knQBcgTEyiJSVVu4nA8xgD
         jaYXXSzVhJfXz44eMroxi6P5HGW6xmuGDYDISjVMCnCnHB4W/Rsn2PmQNXuyivWlOj4M
         QeahXiHB3wKcvV6opSGaUqe4KPFxPwQHBOtyfIw5f9ZbujUdl/43eGj6wFYIjsI2/skU
         B3vA==
X-Gm-Message-State: AOJu0YwSYoJgC5eu6MX1uB5/UqzOVKhMacdGPliczkd+iDJXmhkFwurE
	+E6FA90HXMIbgwDGzpOE9fyIDoaICmCrcBa5G8C0KHAMNF63H2uPdihFGj38V2xMs35WmUxpGad
	B/c0RULGyMaPS9zx1TUWyCI+YWUniSXwwOsW1
X-Google-Smtp-Source: AGHT+IGbbgicdBm1h0d/v8sD2+ltNW742yQoOOvo5ZM08cWHQPOb2pTD1eq4PqCARehNRUriI+IzHbLkEW37lJN3X0k=
X-Received: by 2002:a17:903:2284:b0:1d9:310c:73be with SMTP id
 b4-20020a170903228400b001d9310c73bemr66262plh.13.1706928556166; Fri, 02 Feb
 2024 18:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-8-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-8-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 18:49:05 -0800
Message-ID: <CAP-5=fUWbe-owCHsjQfOuTyt8kEzM_M_4GqS_rqKwL9VY3tJOQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] perf annotate-data: Add update_insn_state()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The update_insn_state() function is to update the type state table after
> processing each instruction.  For now, it handles MOV (on x86) insn
> to transfer type info from the source location to the target.
>
> The location can be a register or a stack slot.  Check carefully when
> memory reference happens and fetch the type correctly.  It basically
> ignores write to a memory since it doesn't change the type info.  One
> exception is writes to (new) stack slots for register spilling.

Just an aside, it seems a shame objdump can't do this tracking for us.
objdump already augments its output with symbol and relocation data.

Thanks,
Ian

