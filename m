Return-Path: <linux-kernel+bounces-121322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B088E7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42210B2AD62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2013790D;
	Wed, 27 Mar 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYNiOBy1"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2A1311A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543952; cv=none; b=GixHpQQeOnTEhOtMEuozZs4MXLPA9IRhrtWp7xLDKh6fMSivLZKmf3jqzrK91dZxaJdH7w57bN4MCRzPT2RyAHqwd616Unt4D1d/PfCFjn52gW+rCWU3NgY6eWKEey/igYUVW1RwXqG/+thQLV7Dg7Q0P/T8Ua/1fqwZXY86/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543952; c=relaxed/simple;
	bh=lAvrRvDli3MU1wwHmO9KGxOUp2wwO3ANxnE7ASg3pIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqz5VL97I0LyHOP/zYS3ssSj22InxN4U2RdwYmsuQxVFIIMAiTPk4IxrtsSQj7Eg9r7i/mGxZQEDLFeDFms0JwE0Vr/J6zyjFPCFg5foEsSyB+kOD87+nvnzA7WQMQWUURfSLqaiF+eBGTfx3ad+uPcMm1J5Q58ZCGSMUEYOFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zYNiOBy1; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29df3333d30so4752887a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543950; x=1712148750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAvrRvDli3MU1wwHmO9KGxOUp2wwO3ANxnE7ASg3pIU=;
        b=zYNiOBy1U8yTFEr9EUAtn8KnN6iB3fEOgSq4ifTzGbdg/TEW198VOKREJvWXALH8V8
         e/OOqqu5oZhb6DZoyZGrovfkPxtWuKnEHXE0JyL5BOu6UbnBaQsw9HNgvijrxoeF1skZ
         yxAMkVf6fTDvEHdoZfppNLMhaDrY+acfOkTvIceGOozqrsDB3Aa4x8MqEAmV5778Aki6
         03sFC/nGWf7VbHjifgUOxTSRXWGpgymMqYOup9lX8Qgr+MH/Y4H9v4rVc+duCbLttFN6
         LF1MZwMcG7C24wdbe6wc5LMmVSn+VemjfjFr+2N3EHo26aPm/79UhBJOyLhfVo/2hH7u
         SIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543950; x=1712148750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAvrRvDli3MU1wwHmO9KGxOUp2wwO3ANxnE7ASg3pIU=;
        b=dazTU/Nvcni/mvECsPLOF4T6A36bjvouKMeUoOhbgjbv+uFHvhFs/O5xouoymCQCn7
         K2ooCyK3MTfZw0xbQ48qvdmq2rcZosz/rmkZB0QQd7ONBV2GQlgnq2Kk7Jq3doWkTL6r
         ZP9RvWuPREOcSxWPOxHjLRupVhNbq9iznHJPAIsxx+H7VdcoUz6uF2NwEus7ZJhGoVpQ
         gq1k8tiBrXUHFXeTyBjUbwY+dvkEoOmz8MrRLohoo5zh57xLWeHF3YuYgdnUdsj7LrD6
         ++N7INf4Y9weCNuZaUuAe5sB/5p4ibTFyKH+fTA8sYJWpyiYgkT8NtoayvLqlj3abfMt
         GGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5QrHpp6FWoVE7zuVc97alNvSp6UJsBiYn1RY2Zk3bX8LX9INJa6TOwsWo2qaKswelXZxvnUvngjdFxEJii5TldOarLtMLfkHTYp0w
X-Gm-Message-State: AOJu0YwzWIGCIwoit+5HOpURxQqNla3yv1MEFOaV3Dmy1ZAk/kZ2twHY
	MRFwrQA0Ot/WSmbh8OOZSgKUIUbDcXiqArEFjsRFnyaypkMjlk5mXepalgI1eQbaEvH2DzwJJs7
	fT/iwzk9qf5X4tYCwB7c+kpbGJw+EL/LcQxV6+Q==
X-Google-Smtp-Source: AGHT+IHY+2UAj74FKEtjbyT+87XUc6G/DqM4kccngP/A2LCLGbbPHvI0e9mfhKo5kTUGX5ZVCnsxWpIe0ZbpiTPyVfw=
X-Received: by 2002:a17:90a:e605:b0:2a0:1ff8:1560 with SMTP id
 j5-20020a17090ae60500b002a01ff81560mr2847472pjy.31.1711543949752; Wed, 27 Mar
 2024 05:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326153712.1839482-2-samitolvanen@google.com>
 <a083fe56-19ba-4c12-8364-944d8bbcc043@ghiti.fr> <CABCJKudxjhbLo_2zHBcsPh42vuLUGFj9wUxk+jf5USf2mvUZGg@mail.gmail.com>
 <485d2bc5-37f5-42a7-a3f8-bd53641c0d83@ghiti.fr>
In-Reply-To: <485d2bc5-37f5-42a7-a3f8-bd53641c0d83@ghiti.fr>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Wed, 27 Mar 2024 06:52:18 -0600
Message-ID: <CAEUSe79Fb0Knk850QtqQp12_7Rrb0Hp6rNoDwtjpCmdTELyVFg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Sami Tolvanen <samitolvanen@google.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Tue, 26 Mar 2024 at 13:56, Alexandre Ghiti <alex@ghiti.fr> wrote:
> On 26/03/2024 19:55, Sami Tolvanen wrote:
> > On Tue, Mar 26, 2024 at 6:43=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >> Do you have the link of the report? So we can add a Closes tag.
> > Sure, this was reported here:
> >
> > https://lore.kernel.org/lkml/56d3285a-ed22-44bd-8c22-ce51ad159a81@linar=
o.org/
>
> For b4:
>
> Closes:
> https://lore.kernel.org/lkml/56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.=
org/
>
> I was expecting the "direct" lkft link though, @Daniel do you have any?

No, that's the extent of that report.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

