Return-Path: <linux-kernel+bounces-79904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9C862881
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F348A1F218AF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617E4EB2C;
	Sat, 24 Feb 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P1n2qbfR"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5D4E1CA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818244; cv=none; b=fiERDjeQeheCJ91rIvfrFv268OfT2gbBM9/5r3RFKeOYZoiA8Vz22oziSWKX+AJMInf9gdlhqWmrAT7zSqmbywiIKFQu0aacZQQGMo1zh1NC4nkYSSOzbP5SS+FBCKXeyVbIvud8l9BcCB6rLcjX4MT90w67I/u7MI6yB3Cw1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818244; c=relaxed/simple;
	bh=0ndlmRNxvgqmudYDAQDRY+8XWH+i1OJkw4ZkBFWvYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b30pN3p2Hov0baKPESs8B0peHQKYQFLA5h3BQ4HAS8jTuQkvQ8bqibvGsInb9AGkbnNqMJB7gb/Rhh7Mr1TduQN+6MoR8s9wpoFQIFMffwgO3AErcr+aE2YLI5tS6dR14rYTvCHpWlcJBWjVV+zpgkejVGr5uFVpJ1G9skJ/hbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P1n2qbfR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso2385353a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708818240; x=1709423040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqv7MLKTQYTKAbyJaXLJ3NjnKr158GpyjOGnut0vOtM=;
        b=P1n2qbfRPOAoXDIL93Z1Z2Cr/McC+kkfO1mhGiCIoV9IvzZxV0/SYKk6gTXzWU8jql
         7F2GA+u+ap3nY3gouplc2TfoATHLlu8cv/83lPU/cqSxYWOYUWeeoLwT8GTl2DELSY2L
         CqmEOIIJrsmhEzthp6DHUFSSlcXer73fNMG+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708818240; x=1709423040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kqv7MLKTQYTKAbyJaXLJ3NjnKr158GpyjOGnut0vOtM=;
        b=vssgkWRL+6b2feILLajmX5b5BsUbds7kHyvKAHOmctV+ZvWgf0wMFatMKiKKGJmbH1
         URM1PzyKytBPMjpmLUjRHQ5FrMpJkT4PJPTf6kcuMTmhrbHpblzYcfRIeyeSJpAYrkoM
         NAepawe7aTIDCwbDuTz1DPsZwFvno4nsDQivVREt9PIDzQlJtsufJ8SVYKHAqBBqyZBq
         0nYM4Nf7C5zmMHeXDavHYu6L4nlY0Ld1T5xKJVB5XmKh+9PxAX/0kCzeoC1oP5tnfWjH
         EV3idMkHTr/am6p95aqKdfuSk4ywIgL238qyKDj17ODqyLgDVcpQk/QWmZMCfw1WNU93
         RKZw==
X-Forwarded-Encrypted: i=1; AJvYcCVGROsWHA/jSZrohKwbdJGrGvLJ7oCA4B6VRIj4HOJNm+wPxYOSQx3s3f2fl/y9jW5tTJxg2ofBVPmDYPATW15Cop3Epkmqaul+es4w
X-Gm-Message-State: AOJu0YwsNnNJ9GiApIsvyhUKcjKFWbFt0qju126JP4f8PU7SxEhzL42e
	HW0OE311DQoJ87tXVKf5nP98qxnz2hLNAjRU8hEEJx4vksLNp/0jIB7QbB2pAQwHkrBEBbuTU/m
	K174=
X-Google-Smtp-Source: AGHT+IEo5InecJ10XscxKcKRdMoG6clnufqW/w3t8R/VOVrnKlxj67VfgrJovCFFl409uhpeJyx0/w==
X-Received: by 2002:a17:906:6da:b0:a42:f6f5:d10d with SMTP id v26-20020a17090606da00b00a42f6f5d10dmr1315567ejb.12.1708818240704;
        Sat, 24 Feb 2024 15:44:00 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id cu4-20020a170906ba8400b00a42ebdfda56sm940290ejd.100.2024.02.24.15.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 15:43:59 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so2569491a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0NBigo0FatD73mwQriTSPtp0atgVhJJy6N9HblkqeDZwQ4OPSIYDlFRrPi/nVnbk7LJQtEVdOyMf2EYbepHTd21xbML59zmeRJIH1
X-Received: by 2002:a17:906:c7d4:b0:a43:20ae:9123 with SMTP id
 dc20-20020a170906c7d400b00a4320ae9123mr202316ejb.50.1708818239390; Sat, 24
 Feb 2024 15:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a150ddd-3267-4f89-81bd-6807700c57c1@redhat.com>
 <652928aa-0fb8-425e-87b0-d65176dd2cfa@redhat.com> <9b92706b-14c2-4761-95fb-7dbbaede57f4@leemhuis.info>
 <e733c14e-0bdd-41b2-82aa-90c0449aff25@redhat.com> <f15ee051-2cfe-461f-991d-d09fd53bad4f@leemhuis.info>
 <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
In-Reply-To: <c0cbf518-c6d4-4792-ad04-f8b535d41f4e@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 15:43:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
Message-ID: <CAHk-=wg9nqLqxr7bPFt4CUzb+w4TqENb+0G1-yJfZbwvRhi29A@mail.gmail.com>
Subject: Re: [REGRESSION] 6.8-rc process is unable to exit and consumes a lot
 of cpu
To: Linux regressions mailing list <regressions@lists.linux.dev>, Al Viro <viro@kernel.org>
Cc: "Christian Brauner (Microsoft)" <brauner@kernel.org>, Matt Heon <mheon@redhat.com>, 
	Ed Santiago <santiago@redhat.com>, Linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Paul Holzinger <pholzing@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 23:00, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> TWIMC, the quoted mail apparently did not get delivered to Al (I got a
> "48 hours on the queue" warning from my hoster's MTA ~10 hours ago).

Al's email has been broken for the last almost two weeks - the machine
went belly-up in a major way.

I bounced the email to his kernel.org email that seems to work, but I
also think Al ends up being busy trying to get through everything else
he missed, in addition to trying to get the machine working again...

             Linus

