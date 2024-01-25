Return-Path: <linux-kernel+bounces-39060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1CA83CA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6C11F24FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7BD133426;
	Thu, 25 Jan 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AKcQG18R"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636612FF9F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205430; cv=none; b=L115f40ZuZrKBjGtiGyUzjGieB/EAvODHvuc4w91ppfZKTrcWSk3y1cVtkPHYIbaHRiab3bSFhPN0DrZyu6r0LJVXWDVfdgGJFbsbeAQ6lfpxksksISn1/qO0C56hMqbvr5m4HRT11DCeC3rq8X70Vrs7ThmucZeoD6638f8LC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205430; c=relaxed/simple;
	bh=x+h0NA5KQ56CuKCqcdtm3IG2B55TnTudmen4P3ZAVqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmJeYPKl9Wk6S9bszshyMQRr3D0TW6589r0Pt5f2ztkWjsqrGf42NH96Mwv+v8/weo2Sry2E65aGrEEn3fhiPICDQry7nk84oSjkQFwj8j+umnrRfIMubqxGkzAKjn7McYHnkXR4YU2hjGAMsLIwZckPV4z1sDnm22wn7fl+Yes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AKcQG18R; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf328885b4so13584171fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706205426; x=1706810226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4MukQAgLIZe1lZaeonltfVtZCZSFGzNFrTBHeprDAs=;
        b=AKcQG18Ral8icAIng4Ahr+YagRQRtCJE5FiZimEVIM1WIYWjTqPH7Em6tJJDmqYj1Y
         /MD6j5uZ6S4GXNntMOR6UMXQxftVmD7KGlvcRRY5X3mC5vtNTta0jEo2Jvl1u5XbvvvB
         mjUKbfHi3p5hEd7fTUtz/kDL/jj8foFHQg4dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205426; x=1706810226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4MukQAgLIZe1lZaeonltfVtZCZSFGzNFrTBHeprDAs=;
        b=gSZvCj/ggEb+02RiUwUf0BE+DlDjxZi4c8Hpu5Yz9UE0pkEvSrzefQnv8hvLeA4s9E
         DWeRH2tERn1fm68VnFS8fknJszRhSqCPfgHvn+H2zRqiwUMnSWa68VjV7qpjx7VaBHYe
         0AC++N80VP/uIut9dFlpCLiI+bHkDLDItwhlNnTZU58eHbtmyG69k8yRbf7u8I+lVkkR
         DC9Vc7OOTwAwf6YmMFErJ3dSiwpFNKCRBS0xRwB3+ilj5GF8yf2HS+FK4gaVzcWfGjwP
         c3kTa/r3dRMvP+694SvxSm6LKxc+afoWBZIAOCnt78dhVoIWUQ2JJRaZ3k0wcdIDMUCf
         B4KA==
X-Gm-Message-State: AOJu0YzeXWKvB73ZlostaKW3+bbZbAbGNsGAfBuoNL7lkoV5s/KAEZej
	FwkRUwcAOhndONwwR1VQwh9Rq/8R0k6aie6wkE4Wccp1N9a+YhEJCsYBwLrR+PHbRwCtY4CVCxP
	1+hM06A==
X-Google-Smtp-Source: AGHT+IGYYnjuEn+9ndXG+pBJPC2E6dS34uI/vLvKq4pjoek0hdqtKOMO1tFEQKHfvtzRZ7LBoRIHNg==
X-Received: by 2002:ac2:599d:0:b0:50f:9e2:53de with SMTP id w29-20020ac2599d000000b0050f09e253demr79664lfn.93.1706205426482;
        Thu, 25 Jan 2024 09:57:06 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g1-20020ac24d81000000b0051020d855easm123154lfe.158.2024.01.25.09.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:57:06 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5101f2dfd97so1035769e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:57:05 -0800 (PST)
X-Received: by 2002:ac2:491d:0:b0:510:58:5954 with SMTP id n29-20020ac2491d000000b0051000585954mr91552lfi.80.1706205425541;
 Thu, 25 Jan 2024 09:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
 <20240121063038.GA1452899@mit.edu> <CAHk-=whhvPKxpRrZPOnjiKPVqWYC3OVKdGy5Z3joEk4vjbTh6Q@mail.gmail.com>
 <20240124053634.GD1452899@mit.edu>
In-Reply-To: <20240124053634.GD1452899@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 09:56:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3tK4ync2S2eBQagOYv06wU+e7jgmnWHk5ZQBbk0E2WA@mail.gmail.com>
Message-ID: <CAHk-=wj3tK4ync2S2eBQagOYv06wU+e7jgmnWHk5ZQBbk0E2WA@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, G@mit.edu, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 21:36, Theodore Ts'o <tytso@mit.edu> wrote:
>
> If we told those people who wantg to pursue key rotation to just
> always upload keys to the Kernel keyring [..]

As long as the keys exist in the kernel.org keyring, it's all good.

That said, I still claim that nobody has *ever* had a valid and
meaningful reason to have expiry dates, so I want to stop you right
there when you talk about "people who want to pursue key rotation".

The absolute *first* thing you should tell those people is "Why? Don't
bother, it's just added pain for no gain".

It's like revocation keys. To a very close approximation, never in the
history of the universe have they been useful and meaningful.

The fact that the keyservers don't even work any more have made them
even less so, since now the revocations will never really spread
anyway.

So no. Let's not encourage people to do this silly thing.

If you ABSOLUTELY HAVE TO have expiration dates and other silly games,
yes, I will complain if I can't then easily get your key from the
single reliably working remaining setup.

But if you cannot explain exactly why you absolutely need to do it and
have some external entity that forces you to do silly things ("Your
daughter has been kidnapped, and you're not Liam Neeson"), the answer
should not be "remember to update the key at kernel.org", but simply a
plain "DON'T".

               Linus

