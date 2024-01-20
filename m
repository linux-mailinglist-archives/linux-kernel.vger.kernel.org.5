Return-Path: <linux-kernel+bounces-31889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A333F8335F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F3B282E64
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF111C94;
	Sat, 20 Jan 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NSEnFWvh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EEEEC6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705779340; cv=none; b=XmjhPRNKMeTMOMnJs1Kj73Oa+4v41GEk5X5n1V8iCp/J9RO8g91HoVybG5uDzRhlZR/V3iqH6fbl1NhaR4EQuOYU9KXkTHmQ3miePYMrKlaLAsN3Bf4PkBcsMgLjb40Xt+qPE0wWJrZNxLCnLopfrgyZqXYZ1wZhtD0cn0XWRno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705779340; c=relaxed/simple;
	bh=NLWKB3iyr61ar4WQVIOUCJqflDtAeQTUkI8JnXa1jLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQuHnoQWCZGkqDDUk/ZvOyDHYBjy9KhV5MtmIBGIbqGIxuk9iEmueYr/EO1oUYNg8frS33rPJutj/izGcp2FDtGPhpK9Mz1B/omiMyg4Ikuo162rdOBumWLAfVSKN9e6eACpWvBebkHATTmTagXf0lcsdfHgxD+cHxFPdHGMEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NSEnFWvh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a43f9a6c1so1915669a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705779336; x=1706384136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M/rp5vrGtS2RGHM4ILDxh2i+YzejulCBn4t1151pwRs=;
        b=NSEnFWvhkbvZRo0au5bHIfCEao9hsDsYxC6VuNXN7fXHaKY2opOC4WizU1oI6ujfsP
         JGgz2OPNPbJfD8VLokhheQ9Y0x+BGvHZaWQanHIyNTnLGjnTbEWFGRwJwApYAFGqUCns
         Dn/7JQTePCZxBuMQNggxqp6UG7pKiu1R+hNLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705779336; x=1706384136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/rp5vrGtS2RGHM4ILDxh2i+YzejulCBn4t1151pwRs=;
        b=EJyG7wWd6dvD+h8f2Yuw6PQ+JuWyOgHJOGXH/6oCq0R/nx5sQfb5PMZjoUaWWsGqmH
         ORxhrdg42dZE+lCyFmM9jBdCVAVZB6iV5jG0tDkUKXBPae6k6tt48RZv80YfW3HbOx89
         wZEugP9ZMWphZZymV3Y8GyL0Vnhf4my46Ye6YuQV5e2Fji42hU681Bs8pqDhtnEeEjCq
         ZlXyAOngijBE2Dgz9c3Mp3747m13n/kv8Yjm9PDPyu3EJFbJahLyRfms/JfS4bQtSLsj
         EDwhIncWQoS86TeyfhUgxsy0aiUy11fTAzzuzql7jt+FP4q7jd528hNCaaZ3FY4H2erO
         VvrA==
X-Gm-Message-State: AOJu0Yw1ZEk1D/xBncd/alVvNd1pbb+MpFREZ1UxgIkRtSiMl313Mk3O
	sS7fvJFreCokZQfTlux3+00r361GlnumjNETQUzGw1RY2kPuoX3hZx+U2SYTu1AHBbKFkvjphyq
	QRAp5Rw==
X-Google-Smtp-Source: AGHT+IFeGJNHT6grKaX3080bcZAFUkT8ZiLt/yAz4pMg69WoDOTV3wA25L8/kZ3LQHr0uXaBe12E1w==
X-Received: by 2002:a17:906:2dcd:b0:a2e:a4f0:6816 with SMTP id h13-20020a1709062dcd00b00a2ea4f06816mr1015151eji.67.1705779336332;
        Sat, 20 Jan 2024 11:35:36 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906455700b00a2c70ec1533sm11436627ejq.66.2024.01.20.11.35.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 11:35:35 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337d58942c9so1973217f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 11:35:35 -0800 (PST)
X-Received: by 2002:a05:600c:3581:b0:40e:a3aa:a458 with SMTP id
 p1-20020a05600c358100b0040ea3aaa458mr716415wmq.27.1705779335473; Sat, 20 Jan
 2024 11:35:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com> <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
In-Reply-To: <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 11:35:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
Message-ID: <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 11:09, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> It also seems that this magic option combination works better (just
> tried it on an old laptop that had my expired keys)
>
> gpg --auto-key-locate clear,dane --locate-external-key james.bottomley@hansenpartnership.com

So now I have a new subkey.

However, I note that you really do not seem to have gotten the message:

  sub   nistp256 2018-01-23 [S] [expires: 2026-01-16]
        E76040DB76CA3D176708F9AAE742C94CEE98AC85

WTF? What happened to "stop doing these idiotic short expirations"?

What's the advantage of all this stupid and pointless pain? Why didn't
you extend it by AT LEAST five years?

Has the expiration date *EVER* had a single good reason for it?

From a quick git lookup, in the last year I have pulled from 160
people. Imagine if they all set two-year expiration dates. Do the
math: I'd see pointlessly expired keys probably on average once or
twice a week.

Guess why I don't? BECAUSE NOBODY ELSE DOES THAT POINTLESS EXPIRY DANCE.

Why do you insist on being the problem?

Stop it. Really. I'm tired of the pointless extra work. PGP keys are a
disaster, and you keep on making things worse than they need to be.

               Linus

