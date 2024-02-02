Return-Path: <linux-kernel+bounces-49523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F112846B6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C64295BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50569D01;
	Fri,  2 Feb 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e61iWgMU"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2F69975
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864446; cv=none; b=LY8rn1MIzD3hIrQeV+7Nch5KgahNkwJ5ZJm2MDz37Ag7GVGVzdtNYISdn9W9ECx2U59BacB2zC1lWuTXORKTx/XZgXDLcYCyw3m9kiRNaE++ZiZqnycPQ7ZGyWW6Xnxb5u1U/SUVrFOzeLLezt/iU7XtZW/+8Dd/tfnsISenefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864446; c=relaxed/simple;
	bh=fUbtS7AlQNO3rXfSPLzoZ0x8HSq0pOklxREwmRXlnEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIVrypQkeE8Q7R9cF9odtXwPFmRicViK3Bd4nzO6TLc6vSCLfnGTf/jDfKNPQ177yAq25Hnoi3eMD+T7sZvJihp3tZfvfg4JwglClTKEpMVPWea0lzWUpDd5oQ5vLj1MGKCnEoGevV9p3yaDijDTYz9XgtMXuUcV1eyzHzCltUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e61iWgMU; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e007751eso1005172241.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706864443; x=1707469243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUbtS7AlQNO3rXfSPLzoZ0x8HSq0pOklxREwmRXlnEE=;
        b=e61iWgMUAYHNTcFwgGnZFHgij4BK7MeNlEGiuXGYRx38rOffj8REQSoQ+fNjFczVCz
         Ln1KlgnIN3IEiBXWp9x8a5f5++IUktiQMwYOIDt6dsAP16LA4VJHTbvVlFtCjcAt0vly
         3iTN2l4hh5S/9K8b01uuttIha/ckdG0Bow9wehoyDkGUEIDljhE+S7PCWFCLWgCRuVo+
         5yfUaExm1E/6mH1zULOmX2GfNL0ImhdlW2a4RkMfmc2MtliLtL7JsnYH9OzXRBUGMSoV
         ZhcdPhdj1fnEElNEjIbmnw1EUqCuCVBCyWPWNOFH7G7xp7wVVjorAKWIXNb5WDld0nL8
         bMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864443; x=1707469243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUbtS7AlQNO3rXfSPLzoZ0x8HSq0pOklxREwmRXlnEE=;
        b=v2EGEzetGkN61/+mWEDFNbKTiU6C5soeqajDt+XwRYiXjO4NthooEmyS0NtZMmCFbp
         4dZZbSEYfr0zph9AmYPgnr87QlKHUFzVfk/eXIqdFLneiRjiZwkcFTbI5RI67r3mAeKT
         CAUPZxlML+iFaxXI/gri9SV9AJY/wHYMtns1NZvLcMcixEgeBvjIHYRanESp2vQVGkFF
         e9rT9DB6rd7NJSGUYdVTiDxWNL4ja907Btl9bMFSDH8Ub0X3BVjfE2JBWc4R4i8iD+ZY
         rnvgDtNjJQEskWoYnsLQf2Y1JNqub+ko37hWfAS0RDyzztmnF56UNwHpREHS6jcK9tBY
         DgWw==
X-Gm-Message-State: AOJu0YzAsiDIUvKu4NG0pB49QsLyAwS4gs9QpkNFuYVxzHI2BNurPiH6
	6SuKDNrRmc7emDyZ+bjz5MwFbk9KmTxLYbe4mK/987JecNDRxwN7U97shetzV5vNwhkB/YtlMGG
	GwkJSrC3biHwFhCOp2+hmXoLeMhXX8q87Xj8S
X-Google-Smtp-Source: AGHT+IG7SiMdL9gUo2xl2ZG4MU0H1TvymNc2kxS+OO0fT6OUON6b6UMCIosMZlRr8qyVga5+bqJLuQppuWmz4u8wVMI=
X-Received: by 2002:a05:6122:3a05:b0:4bd:728b:c108 with SMTP id
 fp5-20020a0561223a0500b004bd728bc108mr8052890vkb.8.1706864443194; Fri, 02 Feb
 2024 01:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com> <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
In-Reply-To: <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 10:00:05 +0100
Message-ID: <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com, dvyukov@google.com, 
	eugenis@google.com, Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Feb 2024 at 23:08, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Jan 30, 2024 at 4:14=E2=80=AFAM Andrey Konovalov <andreyknvl@gmai=
l.com> wrote:
> > Hi Mikhail,
> >
> > Please try to apply these two patches on top:
> > https://lore.kernel.org/linux-mm/20240129100708.39460-1-elver@google.co=
m/
[1]
> >
> > They effectively revert the change you mentioned.
> >
>
> I tried applying these patches on top of 6.8-rc2 and
> 6.8-git6764c317b6bb but performance unfortunately has not changed and
> is still on regression level.
> Maybe we can try something else?

That's strange - the patches at [1] definitely revert the change you
bisected to. It's possible there is some other strange side-effect. (I
assume that you are still running all this with a KASAN kernel.)

Just so I understand it right:
You say before commit cc478e0b6bdffd20561e1a07941a65f6c8962cab the
game's FPS were good. But that is strange, because at that point we're
already doing stackdepot refcounting, i.e. after commit
773688a6cb24b0b3c2ba40354d883348a2befa38 which you reported as the
initial performance regression. The patches at [2] fixed that problem.

So now it's unclear to me how the simple change in
cc478e0b6bdffd20561e1a07941a65f6c8962cab causes the performance
problem, when in fact this is already with KASAN stackdepot
refcounting enabled but without the performance fixes from [1] and
[2].

[2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/

My questions now would be:
- What was the game's FPS in the last stable kernel (v6.7)?
- Can you collect another set of performance profiles between good and
bad? Maybe it would show where the time in the kernel is spent.
- Could it be an inconclusive bisection?

Thanks,
-- Marco

