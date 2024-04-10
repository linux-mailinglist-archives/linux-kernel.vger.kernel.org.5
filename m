Return-Path: <linux-kernel+bounces-139324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6F8A016F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1020283E30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20782181337;
	Wed, 10 Apr 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="heQAV+oy"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3B17F37A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781937; cv=none; b=Bvd6bjdNllLVreg1t5ZCr6BDfdoA7epyP8Pq9H62wUdP2eTJ+bjLxgtsAtJLeStfdxMwXOwOcLVwNSfIHQIRBLXgQ1QpNpHKZHJ9IFixoRfzCYBKAEBtoSlsrxRJ0SiaYe4WIlK3VsHMsjw0s3PSG/HSz95RnLPY8g1tbliCfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781937; c=relaxed/simple;
	bh=Sy/3n97bkylo2eylcSw3DIwMa8fASnqo3q+J98wrEpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJIYOMC4q5w/fUK7+DNFXj7lGIw8O/CgmlVsfmdH6ZcadezoxGoESufflKAipWs5uJRzblDtzMPa2+DMdromCrlfkW3dVvxibpquwbi3KqvaITCwCH3ygFQ0ijCxMa4w9CE6TNvbBHgvRmoEHtDUtqnTMWqrsXIQoIxv5tiOBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=heQAV+oy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so8039686a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712781934; x=1713386734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FpPTUKrctxgqUBZXGaV/dKz7xcwvMQQhwEMsCpGXfs=;
        b=heQAV+oyQseVhgH63oyWgmp0WZhI+e8PaKUSNqhS2gq5orPDuuvVGIy5rsZYMOMMW7
         CqluC5pAB76gyqN3zfWm+YKGvB2VMz0PV4uf02PHGcdoRDnP+b2aA0IjqVmBUEghLZ2D
         /CNIH1jqAnKC4j1aUtB9bN82JwWtTC/Fd9++2AuvL6i6UJlDnZh9Y64NElDkXFJmo5j0
         gfB5VXvQjCFUKjwp3tIIHAIIlKCZ3Xzfap7RS1ZrrksDRPdLuY9Yw0UjZjUn3dWl1Yos
         /4ud1qASFPdeTEvSklsck7SbvaYeKFzchNNraKXpNZ01nMfUd2uBj57q80EekeFfC19A
         ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781934; x=1713386734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FpPTUKrctxgqUBZXGaV/dKz7xcwvMQQhwEMsCpGXfs=;
        b=bN5zCCmRFPMUshcZb1XU5NokfofEX0fMFrhzkNw341T7QKnsd5WDVWbzEGUW1gOfwK
         N8ajfg8nmQq60HLLx9SUtDsEbqTLd/RfxWP8swjYzMJEvfzAH700TC20vnU/W/6ubBt1
         BGXkU7FPEa3YZj+5Qnr8ABITqxab6v+dPlD0pk9DclXGvF6UOng4bntHNmBR0dKYW32A
         /YmkwNw9HOn1TZ+FAjQxxhcMA4pmRmZkuAiZp8l0EzLtswo615UyrkprZTr30Rn5LQUc
         O3wx415D6ax5eMUyMTX7ERFnxdSxki/j/DQkAZEgrACaQL8P/zXGqgEjjhBW2PrOx9iT
         kNIg==
X-Forwarded-Encrypted: i=1; AJvYcCVjRJDMwL/qNhThsX7EiTvGDjkipBtx1AOUjZcCRpv8hboYRDrokEqTcQasGgU/xvXNmnSrEMmZCfneRWXnZToyUTyY+7HTceLxNmsJ
X-Gm-Message-State: AOJu0YxVK8p5ussk1cjqUf9DCngSl3aj3b4pkTLPxTB6mlHsyJWbE7ou
	VU0Ci6kPUy05fXW+2bWN7M4Bjwj/Sr8w349TkxLCsk4cCDdRMUTk+yQTTKEgoDhSSGksu2X8+VI
	sfCD2fbIuovn+VG+20UfoHqNaaiLF4lraa01dUkusZQkECSpJGBNdJXs=
X-Google-Smtp-Source: AGHT+IGfm5SKHc8x1Z8MOzxbf2eCje55T11TlY72Op320UlYL+PXjp/rDhREz7tGSwdmUtZx2sXVhYyqBWZ86FXOxZ4=
X-Received: by 2002:a50:d603:0:b0:56b:b6a2:2048 with SMTP id
 x3-20020a50d603000000b0056bb6a22048mr2808188edi.24.1712781934025; Wed, 10 Apr
 2024 13:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com> <202404090921.A203626A@keescook>
In-Reply-To: <202404090921.A203626A@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 10 Apr 2024 13:45:21 -0700
Message-ID: <CAFhGd8pr5XycTH1iCUgBodCOV8_WY_da=aH+WZGPXfuOY5_Zgg@mail.gmail.com>
Subject: Re: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
To: Kees Cook <keescook@chromium.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:22=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
> >
> > -     /* 1 larger than sb_fname, so this ensures a trailing NUL char */
> > -     memset(label, 0, sizeof(label));
> >       spin_lock(&mp->m_sb_lock);
> > -     strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
> > +     strscpy_pad(label, sbp->sb_fname);
>
> Is sbp->sb_fname itself NUL-terminated? This looks like another case of
> needing the memtostr() helper?
>

I sent a patch [1].

Obviously it depends on your implementation patch landing first; what
tree should it go to?

> Kees Cook

[1]: https://lore.kernel.org/r/20240410-strncpy-xfs-split1-v2-1-7c651502bcb=
0@google.com

