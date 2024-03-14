Return-Path: <linux-kernel+bounces-103860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC41587C5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4828AB20D28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E864FC15;
	Thu, 14 Mar 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NBfkzSNJ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BEFC05
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458238; cv=none; b=phBrlBiF0VPb8MlF6JRo/CaY4XPSsyeG23nI9CO8ypHhfzF6ZHtLi/kSZh/KYC8D6xnoVqgtNff9Y4FV2WaZ192nPnu9FxlDSP1Cjg4vPCgq0LxaB3MuzZIYyctchPfZ2DGukmln3xhvgRyIRRZAfHhT/cNZqegqhHe3N4iZiiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458238; c=relaxed/simple;
	bh=PSPZw+wHimajiosB/jFZPzF7tlBsNhUEtnL0t2l2UTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW9beCZFZmlftctO5ZpK6fePkMkSgeh9CirP/OKA7AUmm+Cx/wUERkbYBptifyxo8ABeO2Emh9o8ddkFjbQgF8CKn5qcKB08VlSIdStm6ZtlByCGzMl8XEgH/2t0NvS+w+IFWPpviyJi8ZADXTh0uoIv72H/TTzP42PGMMRi+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NBfkzSNJ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1480892276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710458235; x=1711063035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FJHO5YC8w5/nCa0SdcrtkcjPivtz4GqNfWWtZkV020=;
        b=NBfkzSNJwus7mZn2lQW/cXxce/p1NLtle+EdknzUaRrW6Q+a/GA8NSd3UFJqo69iHs
         8wu4+Sx0LXtkzaSCWjFAsKAvJUCQ6zrNUi4Zu+1ICoUD/lJZjnvakuYBOu/lhz0yU38Z
         QdrCW3zu05PZyUZSJtGxuBqm0tZPslIWZt1yzMw1Yy7iuDpM5gbzabqaIVjnlY9idaiU
         G6wVelT5CqqCyygw3rG/p26WZ57WkeJfEbDUnhZtCaUuogTWW8aggij63mlcv1+Pfwmb
         4QDfKcNjQE6TI2guMH5k+rh/1KJPu0/zdZ+mJI8D58v/V+fbLWeutgOyRXgd9feTwwdu
         9VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458235; x=1711063035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FJHO5YC8w5/nCa0SdcrtkcjPivtz4GqNfWWtZkV020=;
        b=aNguUcteNOzdYy2fWUU+2DCBpVl75TY2DzXpKeYY3/I15Wo4YvBmAafhtWRmrOzNUr
         2d0pp5qpRb7NPUEH4nvLVx/Ngp6hfxSK+oGJRtoIoQFGmB0dlP3ceGSjvssQ2n2dQe0W
         WQ92TCR7QVt8NN+znQyfTX484CUOBl3+lS1JuVAqhOGbDOpOF8dpKLtYM2fbKn7J2De8
         dI7pgiTozpLBY+gNTUzyrMlFEKuuOdpwJJSGZ1vndW9KaEb4yhNsfnfhz7av/CZqPg4M
         4lAiHknguwyFGZf8EKZfDPlieCXr+NbKDobMSaYXqgQTDRBRJzrX9eMkCLzsetUfNvRb
         tX3g==
X-Forwarded-Encrypted: i=1; AJvYcCVcwHF1hANMPbjO7GNPNnt74WTsP+PXzVlQhkTT0m0nnouY8dYJTseM+IkN9yr0MeigYU616APZ6bEAEkg84Di93o1FujAi7+1EnB0V
X-Gm-Message-State: AOJu0YwHV5dGGXwWqEgnwviQrjFbxoKWSWIpJaWt4eamrI/DVzzBCbOc
	u8WoGinYjymh0KzAPaCxhhwksZElbI6r6I3Iqkvd5lEOZpXs7QK4G8JrNsnIoDU1Jf81hc+v684
	U/hg6+2PX0m61iWjkTIR81Ga4FmuRNvS7TlwY
X-Google-Smtp-Source: AGHT+IFonUub0kn+4pEzuRAJ9n1AIEmnrW4hZeaxsDQsnO7+hwiraDkkWgcWmSKNTcDZiKzY/gn6Akg9rQWnFLXuyJs=
X-Received: by 2002:a05:6902:564:b0:dcc:2f94:591a with SMTP id
 a4-20020a056902056400b00dcc2f94591amr657211ybt.12.1710458235012; Thu, 14 Mar
 2024 16:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com> <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
In-Reply-To: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 Mar 2024 19:17:04 -0400
Message-ID: <CAHC9VhRJW4k+tpkQSFYp6jeD9fRokGBRhsrNbTxScZ3Y0jJKbQ@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240314
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:05=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 14 Mar 2024 at 13:31, Paul Moore <paul@paul-moore.com> wrote:
> >
> > I would like if you could merge these patches, I believe fixing the
> > syscall signature problem now poses very little risk and will help us
> > avoid the management overhead of compat syscall variants in the future.
> > However, I'll understand if you're opposed, just let me know and I'll
> > get you a compat version of this pull request as soon as we can get
> > something written/tested/verfified.
>
> No, attempting to just fix it after-the-fact in the hopes that nobody
> actually uses the new system call yet sounds like the right thing to
> do.
>
> 6.8 has been out for just days, and I see it's marked for stable, so
> hopefully nobody ever even sees the mistake. I can't imagine that the
> new system call is that eagerly used.

Thanks, that was our thought too.

> Famous last wods.
>
>                Linus

--=20
paul-moore.com

