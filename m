Return-Path: <linux-kernel+bounces-109376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E8881839
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BE31C2309A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9D85925;
	Wed, 20 Mar 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEKXPt5y"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BFD69DF4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965000; cv=none; b=Rxa1r+Pf3E8U3zWgTEdm3MrI7e3VVbAaWKRbp6wl9bYHjUJP3dvZm/yGppk3x4+/H+5uHSFoXfWYlMP/jerwivyL/XtqgjZBfojI/964cCl3WrBjPTFxg3YeQDnm5LieiUg+OUSOErzjNBst+k7hpbvIzSrxEMbl5ALJhgxdeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965000; c=relaxed/simple;
	bh=c0xHZ8Y4FPgBIkVXIkrNxwkz634ZUlMWexejH5eBKK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P626DLTPWYwTr/erPDoBDV0iuHycRU9AaNH0cORiNadeF3EIMOWj3pdsDFFEqkUkSo0kMCNwth9ePWRJU8RUpylUqHjdNaevK0CGgR1ue6HOmyFHkBgvDZLnyEi6oAD6m+0SENs3hYVKuXr65bTwHrdxTAr9uB/XM6eaoanvKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEKXPt5y; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690d054fff2so1721156d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710964997; x=1711569797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkjIh7R8ArNWNqbrZmcumDc49q8HuLT8tVgxi9MGtH4=;
        b=KEKXPt5ydZzr7nUZh3KI5BlLFcqoFCXZpQTWffeNihY1sNYjUx29vjVNjGXcmjVs53
         zA3vDEjFXTZy3an0gx3zCuVG+hAkkhk6MYiQrMynOOjXAaM7s/RV0ENgqeMmSs0YYBRx
         YJB+C3w0tsBCc1BUt2mAQq6s44R1iRKttZhwlCCAQb+Ogwgkfe6M7qWNLVAOmP9RvZWk
         n0YayFTaFDLaTEDcNA4vUh5d8qn3HSvIB10HhI6XwwyQQ9n1pvsFU+quxPJ1AGFBAKyD
         aa7c5EGCaQRzlQLJZWExLHCTQrwnAW3gR0DGQ4gpP8cF1RogD0opdjbxjB1AZNLvJVM7
         ktEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710964997; x=1711569797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkjIh7R8ArNWNqbrZmcumDc49q8HuLT8tVgxi9MGtH4=;
        b=XsQyEmddBhAxoursPGMbpnf/mi/KOhabXB8J8k2t7VNYUqf4lDO1rZrhz1zYRYkeKA
         nvziNwzBZC5VjwENa/Yl9J+IzaB8dtSSnSg5mM6KHD9bt+5HhK50wLx0E0JmkvaT8v+H
         +uKwVT/OjmYN/7XjW4gHmbXerxL+HbKw9I83Xtc4HqeSMbXiIRvuaf2ENXgx8N+cWaGt
         tKRQN8V5/5KJm0t6joju06SJrzJ5UQrDFQuKW7ll0ka/ZCVw3nhIZxZOfMwu9LM9WYFE
         KTAh+xsVqWf1eShnYpG5EsuemP2KlNcjqg+vPSMk8TIjU9PCk5KG0QsN7bXcNyzVX/Rk
         7efw==
X-Forwarded-Encrypted: i=1; AJvYcCXVAsQxhUpovyb2Vz5mLnX9LALSWn9B5njmIFWyBvHnHyEBMYGZQqLoDBk2LbsqB/w1cfMqehfpLr+HsTdO1xcAMYo0GQ73PRST17z8
X-Gm-Message-State: AOJu0Ywp6unSPUw+ARd13dQtulQq514WdFMzkRkPccaM93n/A/1Ic/Si
	ETidWidGp7JmvabNhQnzdsPr3vVIxxLPjLmYIdgJ8rgsxsAF0k2mq7dDObYcCUvgsu6OdcECUCE
	GGNp9tWGdHbn5Y1fFLLX4Mb+Q6WaxejLU/6LQ
X-Google-Smtp-Source: AGHT+IGHIY3oXxKfOKQCSODvFElR7gQd+/3RfIiJPlCUuUL9oQ757/8YvQo2eQIqyOVfZQUOcpizGDV6OUql4Bx2FOI=
X-Received: by 2002:ad4:444d:0:b0:68e:fb17:e14b with SMTP id
 l13-20020ad4444d000000b0068efb17e14bmr7409618qvt.1.1710964997369; Wed, 20 Mar
 2024 13:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101851.2589698-1-glider@google.com> <CAHk-=whepBP2i6KrkSMdV98vs2PSpRcWS+zg0e8cNZKq0WUDnw@mail.gmail.com>
In-Reply-To: <CAHk-=whepBP2i6KrkSMdV98vs2PSpRcWS+zg0e8cNZKq0WUDnw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Mar 2024 21:02:35 +0100
Message-ID: <CAG_fn=WfZxp6Xm-8PN2nQfdeyRscLCvhp=0WU1dQC0Gvy2yMkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: kmsan: implement kmsan_memmove()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 5:05=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 20 Mar 2024 at 03:18, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > Provide a hook that can be used by custom memcpy implementations to tel=
l
> > KMSAN that the metadata needs to be copied. Without that, false positiv=
e
> > reports are possible in the cases where KMSAN fails to intercept memory
> > initialization.
>
> Thanks, the series looks fine to me now with the updated 3/3.
>
> I assume it will go through Andrew's -mm tree?
>
>                Linus

Yes, I think this makes the most sense.

