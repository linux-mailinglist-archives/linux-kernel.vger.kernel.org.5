Return-Path: <linux-kernel+bounces-71510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8085A66B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267071C22010
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C12381BD;
	Mon, 19 Feb 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFYqwIHE"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71848381B0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354303; cv=none; b=Aa1+Ap7OxMxBsWaBPMWxv7+EreBWN9tsD0vOMwEm/vnbZUVxAXEj3jGvu/LoEfYh4M63RLGsJffdr2/VyDpNiilkfMsHjc8cFRNsuIhzFAIqlhSXliPcUuqejBi7/xuGocJtKqAA/ztBrYm7Q2OSaCodAvpD9PgwNY6vWyVmBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354303; c=relaxed/simple;
	bh=6F/djHZgXfBfzDSGWN9x5OiEihGxjyv6a0kYnS8kE/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uszBlFMv40GLgoydpa96MwF4fqZJIgt7cqfGHinmXW2bX+RspqtsFZqv+1jiBwuo/FZ1yJW49+qaDvWlse4CA4Us/zHu79QrrsLYDWvARjFNNV6yyYTgWtVF01MsyuHFZCL3mbD3vCZZADVx9Ii1wt+j76SkC74kVfVijPgAZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFYqwIHE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-428405a0205so596431cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708354300; x=1708959100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hiB/AxVaOWtkvuxqBUitfjyPDq0yhH3V/uKmBa9nfwg=;
        b=IFYqwIHEV+CjSFaIUzV/94dkTARPmREIWllDCwevsiGP6l3LSnT9oad3wptHdAIdU9
         PU2Z2YCAOcHlZ8flhgWVdyF4z1hoDmQUURihjH8+JvTu2J7Jf88ZZJqiswoJM+zGOsQU
         0oXKP+cLSmxLqztPVAfOQAbFWJ4O3sUt5BJ+xkt+A7tni2C2Zke9YMmUa9ku/sGc90Gx
         bwSPDk0t8Hdp0doQFxrUy2G/xZ2VhploN+rtAFKRykuutiElUULfiCRM+2rkzVjXKk4t
         q4doUGKKFG7X9TFcUkJC9L4HuhQwVJXCL0Gj89Z/KLIC8DtfsqIv3JHk1qwwTZ/z8AWU
         TyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354300; x=1708959100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiB/AxVaOWtkvuxqBUitfjyPDq0yhH3V/uKmBa9nfwg=;
        b=LqoxRfDw7bPT5o58X1Y2BXDue+LtpHTtuMjSYTuXFIrW23lBYAMZPZHpGxjFxZrCac
         1WIXk4WfRhKehaHDld70WUmXZN+FWpi7rzSu2ixVwYgrWBJCsnV2IjOcBR4czuSA2RcP
         reGMreUO03P84mZhm2Qo8mAmLyRxtwhIoFTn9Pkld/mwu56d/leFuSelqIFOLAT3PhSA
         7Ut7qRdFGfIrzo9KlYtKEL9pocYiA7EfYz8PBPR0Gu5c8GVx0CWJeKzCO9ymY1g4wk9d
         Ak/3D/RH9bZtdeYzPFdOlqQB+jh0MiE1c8s46V6v1ph8MqJhpw5TMYG5JayWyXyBZCyc
         cFIA==
X-Gm-Message-State: AOJu0Yy7Uui+cG7hWsqf+8TO6xa3aqhjxV5eYab/4EG+AKdeNSFzOh0W
	HIcT5ptEvHtXoCMnU3sqnworlF2LgMsQ2XDl5ouH1uQdg9WFLOd+QdzHDsF1euTWZdeKuX2snzJ
	bXTB0GT5wZY2dnPbkDEw7cxoIxMEYYoOz1qp8
X-Google-Smtp-Source: AGHT+IG14BgRPlqHoWRK2frVMGTfyNiK7ZSClvVhXrHpa01jdr28eJjhqg93Yp47bABgxcPNtzW3mo96DWANEpBmlUQ=
X-Received: by 2002:a05:622a:14cd:b0:42d:fe28:38e5 with SMTP id
 u13-20020a05622a14cd00b0042dfe2838e5mr329279qtx.20.1708354300330; Mon, 19 Feb
 2024 06:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108113950.360438-1-jackmanb@google.com> <170612139384.398.13715690088153668463.tip-bot2@tip-bot2>
 <CA+i-1C1OpZQTS3EQa8fEc5BTzcLNMcgrwt0b9mR_jqiY0-zV3A@mail.gmail.com> <20240219144210.GDZdNowiz8Tr9j8acY@fat_crate.local>
In-Reply-To: <20240219144210.GDZdNowiz8Tr9j8acY@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 19 Feb 2024 15:51:27 +0100
Message-ID: <CA+i-1C10TjwEKEYoV636PPXJZpQDvbLqETVzA=rjgsU-Dvucmw@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Avoid redundant CR3 write on paranoid returns
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Lai Jiangshan <laijs@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Kevin Cheng <chengkev@google.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Ah yep, it's there. Checked my history, I was looking in the wrong
branch. Thanks for the correction.

On Mon, 19 Feb 2024 at 15:42, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 19, 2024 at 11:49:46AM +0100, Brendan Jackman wrote:
> > [Apologies if you see this as a duplicate, accidentally sent the
> > original in HTML, please disregard the other one]
> >
> > Hi Thomas,
> >
> > I have just noticed that the commit has disappeared from
> > tip/x86/entry. Is that deliberate?
>
> $ git fetch tip
> $ git log -1 --oneline tip/x86/entry
> bb998361999e (refs/remotes/tip/x86/entry) x86/entry: Avoid redundant CR3 write on paranoid returns
>
> Looks there to me. :)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

