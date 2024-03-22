Return-Path: <linux-kernel+bounces-112016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4E2887432
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6061C2171B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08C7FBBE;
	Fri, 22 Mar 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YpRUHmKK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115687EF0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711139687; cv=none; b=TjdIV18tmIjhLTeBgxvwFIr16rAyFch+QWw4kw5iYEjSut54AVye4rzppGQL5B9SRNmuKFKbf+XF4u0rPb1xdo0ejsB+6VJ+3nMaPd7kmc/9mFhUx31Bb/Rozooq3rrasFtJ+ZYeJE6vR5jgVlH8gWz0nnVxhQdwvwhky16Bbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711139687; c=relaxed/simple;
	bh=XjWgDhwAnyLOFEQHOgQQXXRRn46n/ix293GOySxitgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkgW5CAtf5d36sQ4IJ91ax3QDpkhHv4TSVdnH2pO0NCb3RO2l3QASHNWvkcbNORSj6kNbrbPdWLOAEgvLuReamcS00tHeDE6iah36Nn4XqzRG3hjId0U5y9YICUyTvn9h8geuit5WV5JFR8DA1I8kEHpyJKTcS/KFzjaijHhOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YpRUHmKK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5148ea935b8so2896183e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711139683; x=1711744483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60APz7zYnkhGexsbPEuUDopr5dRjcEm9AN80VhOLeZA=;
        b=YpRUHmKKuyOyhiCupZcwV71CoxyNmIMw+YxGhRATeg8BcNO7/iRz9HJ3U44S+ODVfx
         X4UHnPJqtrRMJq7hSk52CU+vQ7R3VSS2hjaFnVM4NoRHh+cTA1PGd2zXjAxMIgmRf+tE
         15JXESM+kXfdDe+Xmt2rwsaaOUq9nRVHozfII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711139683; x=1711744483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60APz7zYnkhGexsbPEuUDopr5dRjcEm9AN80VhOLeZA=;
        b=pfgzHg0EiInYZhu139KXf4cJVnzw7HXTPvBUSdU8OP0MPOevvBAXylReZXil7+6a8E
         SHfLBGb7jHK4rKkrq4nc0bd9ai6TEgCc5yUWYwmlAijc3GAo8rpiOVwDKT/B0Iz5xlUO
         FOTCGOV+ItgQaoaK9eDoZ7y2lKPxXZhtF7n/LlwyrW3nZEt3KMf1Jcrp+/bvnNE3IZ31
         n4jYYS6l6gHHOOKrLmSdKhPjQRsNsJ2W+5JOE60y7OukE9IBtEiSu/cSx45xvEaNIVbr
         +6c6pXn1p/lPuImujFQ752sw+vGyjK2qABuRXxybABq/PgIl0F7Q4gy+ZXdXSCxlxfxq
         0oVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDNgSiDbOe6jwy3Ow0MU+xS0gARPXgwttSy7aD12cQ9z0RP/umIbNcuGdznQkPCTlMuNOLndpBCnA6yAYdCbGG8ToDYN/cOWksGWql
X-Gm-Message-State: AOJu0Yz9QpUlWi/YY0PG/fZeWilBJVcQvptReoLdmA/s7A5/TlIQQUOb
	+5LtUae4A9nIkxs6x62uK/dIk7f/A8+3k8FmRSGFN5wEJHVJf6/2D9AwWa25kk1ezaM7MGrQ7x4
	f5yU=
X-Google-Smtp-Source: AGHT+IGp4RXO+3bdiog4x6jDNPBK19j8KoMAmLQWuNd93v67BJlN10l3ZRb8dmc5/cS0oK52VeMxHQ==
X-Received: by 2002:a19:5f11:0:b0:515:99f6:2ca4 with SMTP id t17-20020a195f11000000b0051599f62ca4mr396273lfb.36.1711139680748;
        Fri, 22 Mar 2024 13:34:40 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id i25-20020a1709064ed900b00a46d9ff8a58sm179593ejv.158.2024.03.22.13.34.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 13:34:40 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a47062136c0so319335566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:34:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGgLpF3GtZLX7Jm5XwHYjizTRb8z7D61FVbDv0Cydcw77A+/e+hAlEvW8GfzZ5+2BK6IUTcE3gfl1me7U5oEt+Ykew9Yxy9ljpJsEn
X-Received: by 2002:a17:906:5288:b0:a46:13d5:46fe with SMTP id
 c8-20020a170906528800b00a4613d546femr621763ejm.11.1711139679859; Fri, 22 Mar
 2024 13:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
 <CAHk-=wg9pvT5YEo_kGo2QGjbC-eRaaQNOZuJYCsM1zaxj+rnug@mail.gmail.com> <3b5f3404bc63d59f4093e02c2cbb426a88d0bc70.camel@HansenPartnership.com>
In-Reply-To: <3b5f3404bc63d59f4093e02c2cbb426a88d0bc70.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 13:34:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-d9pPn00m0v3K3rHD+O=oZV-JvX-Y4aZ9jKMdEq2Rtg@mail.gmail.com>
Message-ID: <CAHk-=wj-d9pPn00m0v3K3rHD+O=oZV-JvX-Y4aZ9jKMdEq2Rtg@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI postmerge updates for the 6.8+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 13:24, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> OK, try this (I've updated the scsi-misc tag with it as well)

Well there we go. I really had no idea what the pull was supposed to do.

And while I end up looking at individual commits for random smaller
subsystems when it's unclear (sometimes just for language barrier
issues), for long-time maintainers of bigger stuff I kind of expect
better.

           Linus

