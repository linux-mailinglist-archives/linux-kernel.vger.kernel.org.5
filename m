Return-Path: <linux-kernel+bounces-154212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77F8AD95C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2EB24CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2CB45BE6;
	Mon, 22 Apr 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aKV8dekb"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830B4597A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829958; cv=none; b=RHvfSaAe1QBezbumq4T9Ay7us7Pk/T0+FIICqi32xrq0m6NP1nBr+IRIcJH1gGU/XBo3KxmbZq1bkaf5JLgrzKk2eURdEfT/mfhMxZRkJBxQ+QbgMl8dN4FxrN0ug0r60ELjvw5dTy8lKTJyJZFrPsaxY/mXw05KxEMhUfgQbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829958; c=relaxed/simple;
	bh=7VpFWji0npb8y8WcWu7SHDIm3yHlNEnN9NqpcurZ/+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhRTyT2ZOOjD0fQ81m+ffub4q9wqIiXvg7tE4YuspIeNuVGlgje+K4dSdpwLOH4L1wmQ4JgERzjBVIr6ZKvInqTmFh1w6mowAtZwsJtgJ81AsWQ0FZ7wQ7bfCj3u6Vpbk9SkVgXpklDj6jMypVu3EjBLvnslIysJ1OmWTxdHwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aKV8dekb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78ebc7e1586so598812885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829955; x=1714434755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SOhZEZT4NIqKamiAK6hc1pW5omVtcjx/7H0PT95lRc=;
        b=aKV8dekbYsNf5jZXVk4zjactEwNfciW/rHbO026ce6ZOZO6+ymVG77/gcbZ29wt7oj
         Tplaj9jgi9UvaP1eW2uceN2syPNkMM6ZK3coc9NbXLCJhiELjhaeTRZreS+x9+FOY/uY
         4hee6KCerbIVPz71nTfz3P6lc6b5UUwexpydE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829955; x=1714434755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SOhZEZT4NIqKamiAK6hc1pW5omVtcjx/7H0PT95lRc=;
        b=ANWwiVk1K+NFoE8Fy2YUV5hdQkEodKapEHm7MEUH2g53TQh0wVyeqt/MtuAqmePcWH
         8vcwV4kkgvkK9q++e4dEfRDfveaAOueF3pmzGX4E1LOh8KAUoqZEGTE8PV33EPG0NX86
         J4GD1aZQEi14FjBkvp1OH9cQI5NVk7XRqSNsOSC0Za7K/Pou8EibYh+oIfF8iLs10TlG
         j/saifHO2FzrycrQq9aF/OnlhqLOC2i1Zl9Uzrn4lxQYvJHHhfke9naie+D5dckXzmwk
         +OssuVK3oyD9eVZgC2RdpLilu7QZsAWqbCvC4FndyMEWVsv/3yHNf/2tZQ6+nzDO8035
         3cZg==
X-Forwarded-Encrypted: i=1; AJvYcCWaLtqUpdaGKFd9QcyEokMziwMVZN/DDpa4wHGPMUREZivrcxXr5iUq4cQ1qoj0k/JT+GhHDtLOePfQ2BcO8soH24EcYbVAcM66M0Pg
X-Gm-Message-State: AOJu0Yw9rwyLFCsEBguKPEgQsEnBp20VzprLwyq5LL0QtQnP7qQPNDqb
	3Uh4SXUZ/+OhSWZW97WwVZX2/9vQhG4IcEkierCDP59rFO6veFUsJ2LdxFFTk8eVI7DpdFcFRhy
	hVgcH
X-Google-Smtp-Source: AGHT+IEMQgjwVGC+DyU0bewGo/q+kvHtZ3rLY8jkgX1cK+1+uj49nrWBdOBgujbPX7BmDuiADXJAqg==
X-Received: by 2002:a05:620a:2403:b0:790:76ea:b47c with SMTP id d3-20020a05620a240300b0079076eab47cmr2205096qkn.24.1713829954927;
        Mon, 22 Apr 2024 16:52:34 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a022500b0078f13d368f3sm4298706qkm.95.2024.04.22.16.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:28 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-436ed871225so71651cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+xw4llaDY3SCiVu4ZJHc/srGjkJzGrdbM7sHngue0thHHMNBjyA3e540kdtBxxfQANQ8ta4aZ1a1VF4+dE3bQz2dfVOAVb51MkLo7
X-Received: by 2002:a05:622a:8030:b0:437:a0fc:8989 with SMTP id
 jr48-20020a05622a803000b00437a0fc8989mr125978qtb.4.1713829947957; Mon, 22 Apr
 2024 16:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-3-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-3-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7TnwD+K5UiUqVz6E06A82uimDoHfQ28557857QE6P0A@mail.gmail.com>
Message-ID: <CAD=FV=X7TnwD+K5UiUqVz6E06A82uimDoHfQ28557857QE6P0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] kdb: Fix console handling when editing and
 tab-completing commands
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, if the cursor position is not at the end of the command buffer
> and the user uses the Tab-complete functions, then the console does not
> leave the cursor in the correct position.
>
> For example consider the following buffer with the cursor positioned
> at the ^:
>
> md kdb_pro 10
>           ^
>
> Pressing tab should result in:
>
> md kdb_prompt_str 10
>                  ^
>
> However this does not happen. Instead the cursor is placed at the end
> (after then 10) and further cursor movement redraws incorrectly. The
> same problem exists when we double-Tab but in a different part of the
> code.
>
> Fix this by sending a carriage return and then redisplaying the text to
> the left of the cursor.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

