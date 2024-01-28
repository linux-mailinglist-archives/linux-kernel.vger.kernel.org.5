Return-Path: <linux-kernel+bounces-41886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F68F83F932
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5231F21D79
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1E2EB14;
	Sun, 28 Jan 2024 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FTY4TId7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544A288DD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706467598; cv=none; b=qXKqWr+RkbUSspkS4ML1nU3SkhSG4mC5Bi0NvBy2ZdTszv0guXElRNNMsNFClCBkPDPcfR1xs9ULBbzuFHWIKo2lcasyHKr8P/42xJa/QLg1gzVSWkkuiPPpgh3qTY6y62QJZNOA9bYWK5WHxy2rEI+J45cO87whDuRfCo2t5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706467598; c=relaxed/simple;
	bh=GNEn6DsFmA9yQRnivIGZcDahF1C8Q20kKbDBiKYeojY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yx1dewB8GnYxQYiBhsF+pIunVs1rYP/5+WI4ZhUTrt/YY1fD4zw30z6OwuR9FVz8JPhk6Fq/7eWVXMW7fkF8kaWx4HeXMkicXj1cb6rGB0Hh/ZK+VNz1h1lA+ybmVLP4vJCsttn5HuYrjVKOU24a6LbmlTPMIM/YcTI30ez7CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FTY4TId7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso22150311fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706467594; x=1707072394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+QqLJ/uh3osnonCwTOn62hFQ+mw5FZR0sqAuG3yuiQ=;
        b=FTY4TId79uHee0wizFb5ozWUM7XRI8EAdrdBApLmGjgImq1cwMv351o1jxyq2YMCLg
         mWAeVQO9/uKvtND+bglJZOU1jWuy658A+lK/sHrqbYVHoW5RJQCgMhF6uiwHHOKdT8Ko
         v9Mvn40VULJ/U02K7xnk/DMNfTshU7dGb16iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706467594; x=1707072394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+QqLJ/uh3osnonCwTOn62hFQ+mw5FZR0sqAuG3yuiQ=;
        b=A9p0HmefgD5bve/8OuZIqVUi/BGQ6odLpNVbEuxRkXEaIhgfDzQs6+yZ7NldRHWtTr
         mp3sLZRPBjBlgqjickfh+nXK3LOiyP4oH6PZqzbUN3TCD0v5qIRF4eUtCFLUdweFs7Fp
         AumuULh2GfNnVlbfhpYI8XkPc7Oa8y+Mvf9m0etk7rV6iPneTl74YLFyNn1atPwnaNvv
         tdJRSU9XfKB4ho9uQrLypa2FfNPljpszGW2rzr3hPoaEEne8xgNHWrCh0kXi/QZ2+Cxz
         w2GkmwHK0Vfc3+HSMAlyEzkvJb3siQGb620nq7bfuK8yEWQBevRrHKAUMrF3UZeKmHwJ
         5oRQ==
X-Gm-Message-State: AOJu0YwAXeOX27dq5Ex+3/IfNJRuJSyiYd1yjnPy27qPgY3/Gs1TO3ts
	wuLzhvjZBHjpdtrM679c1Jf5v6ZQ490fTK4JCJKhTWtTLYB/0cuD5eb+Joo9sWVic/SswXX/oGE
	oUjg=
X-Google-Smtp-Source: AGHT+IHnEwGASFTJZ3ixp2iwenkWXikmwKyE/Lb2ZBbBkbkCLG8HwZiRxkKFImptLf8itqzgN2fhsQ==
X-Received: by 2002:a2e:8482:0:b0:2cf:1aa1:beaf with SMTP id b2-20020a2e8482000000b002cf1aa1beafmr2566529ljh.42.1706467593936;
        Sun, 28 Jan 2024 10:46:33 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u20-20020a2e9f14000000b002cc31b0d27csm868419ljk.101.2024.01.28.10.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 10:46:33 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso22150111fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:46:33 -0800 (PST)
X-Received: by 2002:a2e:be21:0:b0:2cc:65dd:3320 with SMTP id
 z33-20020a2ebe21000000b002cc65dd3320mr3029609ljq.27.1706467592944; Sun, 28
 Jan 2024 10:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
In-Reply-To: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 10:46:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYLgJMUJ4ZkWY7hsLVmABRCEMycv5RiZ0vV44UPc2OoA@mail.gmail.com>
Message-ID: <CAHk-=wgYLgJMUJ4ZkWY7hsLVmABRCEMycv5RiZ0vV44UPc2OoA@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS fixes for v6.8
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 05:28, Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> - fix missing prototypes issues

This pull request could definitely have mentioned this part of the commit:

 "Also drop ip27-hubio.c as it's not used for a long time"

because I saw this in the diffstat:

>  arch/mips/sgi-ip27/ip27-hubio.c            | 185 -----------------------------

and had to go look at what was going on.

            Linus

