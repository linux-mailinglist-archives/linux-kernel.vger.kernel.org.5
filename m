Return-Path: <linux-kernel+bounces-100753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF332879CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2611C219FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E7142914;
	Tue, 12 Mar 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U7QWMctl"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698878062A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274647; cv=none; b=eyjD52LR+x2GUjCBtnJ0KN5Crjg/chw+Ez+vbxiM7btMzYXUbcMAZG3W66uLyJlpXGQZi+WZdJOMLDEKjpnTpGRV/1612L0dTMO+ASZZFGfyzjk1rIfgUmDM9XEpgy+UBqgh4lEqkwPaO8GES0DIkj1zy9jDcxeLc7epTXvvPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274647; c=relaxed/simple;
	bh=QfiI841UMd+b4M6uGOAl6Tti6206LQPlspjZ1aGj+vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVf5EbSj3C4BogBW6SINPjF5Tw9rTLK6OlJOvAILHVmvTH88o+osHIhdAMOI6YXqFeq7qcjNNFbAOPc3N6VetQaQ4+4bLmGYZzavt+Dhbjix2siMrM/650K2GZTUBwPhHELhzJxeuv5vxXIjhmG2yp+xRStHvMfjyTw8X7avjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U7QWMctl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4627a7233aso35078266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710274643; x=1710879443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=U7QWMctl/G45JotggaKN/dnbq4z7uMEANnSMQSWr8GgMCMq8NX4Vu+jhYssskbwA1V
         wc7293ZskkTB/97luDvU/tXjNdI2uVhGlvN13HVt8VpmCpV+uNewwkhM30iP2C2xn9Qp
         IPJwg3n8bk/FIVjJEeP1IuPK2eI8R122Ann5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710274643; x=1710879443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIGv442Bb3GoyJ4GTJ4MmhCFvAXMUZvcBMa8Hexcis0=;
        b=neJm+T5X+kBukJH/p94od2yYjU+Bh3/GIE9+VqGZ6Bu07Y4jzZMi1Ltu+4jg1zQ+1l
         en0J4NE3PTo1fJu8ePeYKHYOhDACxcEFbZBsvr5YSYL8pfAprY18LB554qvOvVqtqHFJ
         nPF5r1Bbz4ygC+PZ5zQwsgFRW8hkiMh6vpKKT+7UDDyRcvGxADeo4VQYLIBk1KRJnWYe
         TQblp/sSIHXcxQH3LRvm0nuq+E1s+mOo3i9ObpLikRswi/mSxezuprUaBzZqlktvpR+O
         pFdnIAPwZouem8xWm4rERifauSuYWLvoww9eL3d0rPoPFaA97HGH7ZX7lTIiG+G+WODf
         OWfw==
X-Forwarded-Encrypted: i=1; AJvYcCVIKHxsbQ5BRMjalPI16rsmvQDdEj0Ca8kINHEu3fIA9PRqgMc1IbjrLuqsF7M05ZovOObZ7rdtn8CrM2hIRWrCdiTkKqqz8eMmOZFq
X-Gm-Message-State: AOJu0YyAVZ6jnU0hRYkHU4otk539dT/NHo6+6bN4wj4UjZ6emG9hz/CG
	l5M3wKtaRt1BqOGhvZtVGSurBdIHHN1ECPb3cn2ddZhmPgzfX2F+Ud28iKebKa2qH4iNQKHnibG
	dzcCkNA==
X-Google-Smtp-Source: AGHT+IEBgB9XsFbNAyleoj/ta/dY+gTDJLTMv2Lb7zCKEX2UvXk8b8phUfp5ovNphWERLZ767QuIGA==
X-Received: by 2002:a17:907:d049:b0:a45:5fe8:26b4 with SMTP id vb9-20020a170907d04900b00a455fe826b4mr602473ejc.24.1710274643519;
        Tue, 12 Mar 2024 13:17:23 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906a10d00b00a4605a343ffsm3748325ejy.21.2024.03.12.13.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5686677bda1so388152a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 13:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq4tZnKnTtpkQ3uzHUxbdgSnAy7rFPsQUGcWJ/Kip7uvyf4W6huxUUtkWY+KrFGdHJNVx7u3Zz2toP9uMKLOStZuAycq7NtZbI7qug
X-Received: by 2002:a17:906:6c8e:b0:a46:479c:1c1 with SMTP id
 s14-20020a1709066c8e00b00a46479c01c1mr521289ejr.19.1710274642338; Tue, 12 Mar
 2024 13:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 13:17:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Message-ID: <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
> I get what looks like blk-iocost deadlock when I try to run
> your current tree on real Meta servers :(

Hmm. This "it breaks on real hardware, but works in virtual boxes"
sounds like it might be the DM queue limit issue.

Did the tree you tested with perhaps have commit 8e0ef4128694 (which
came in yesterday through the block merge (merge commit 1ddeeb2a058d
just after 11am Monday), but not the revert (commit bff4b74625fe, six
hours later).

IOW, just how current was that "current"? Your email was sent multiple
hours after the revert happened and was pushed out, but I would not be
surprised if your testing was done with something that was in that
broken window.

So if you merged some *other* tree than one from that six-hour window,
please holler - because there's something else going on and we need to
get the block people on it.

               Linus

