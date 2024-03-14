Return-Path: <linux-kernel+bounces-103679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAD87C2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532B5287E31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281E74E0C;
	Thu, 14 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsdmCkqp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DB73161
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441647; cv=none; b=keaBrr/Cde8xeEcX3jX1CR8593pdD8sgVh3bjGFVWASitxSKTqFY8RaufbqYkYNP0hMf8ZDUzkiqrcMDPzgX8UbOtR+7qApgcS0SaQUZWG4OzS9CJREwOrELseo/HSHQXY5xOMZxvgBQlN3rrshPvD4/NyYhFIIORIcycqf5DhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441647; c=relaxed/simple;
	bh=Q3DRaUnkNmoBKi0eg0HQnH8IEFyzesJnvrMrZUVvx3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKD0q6fxT1kkOGB3o3HorturgyKAxHywB8lH47dRzfEdrNyesWm6+B+pBC+wz1OW+5fhu2QgMiORM0G6u/ZDiE9OBwGtYkIJM65cd0XeKkb8zpwKoA7Rk7OVd4tcfnk8/G9OdRcFl+MkGNGwZCz41O8YkcKlXKNAMY13ObkdFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsdmCkqp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0694df25so17603607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710441645; x=1711046445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpMprx7x9B9yx+3CvoKRnmXKr2JamMth4mY2dj456Ww=;
        b=GsdmCkqp4SkqoM9GJwLNYccyFe7kcqJ80Dyz/b4pa7J5LcklecOW7vqbOYMhapFUfb
         HNat1q1OKM4akyKewDVyGcCDwDpPM7KY1l1F8EhnRjyIaBizj2ww3R8+/D2LP09ljLHB
         DXRJ60KhfoCIZs30c+e/UuKUUWvORQ6pMyp+KBuzxXfE2FFLSe+4eyra4jKePFJlqSv+
         i6zko3LrUAl1C2R1GX6tEu0awo+MnScWOIFMFGHiie9Yw8SoOFSZ7AeYakUG5AITqFer
         rXF4taCLNuneBmr2DgZ+NV1QAywU/AMpLw6sph9190/Emhcd5V1NrrgPvOPejrJ6/v/3
         TCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441645; x=1711046445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpMprx7x9B9yx+3CvoKRnmXKr2JamMth4mY2dj456Ww=;
        b=loCDqON88Vrd7sD6l+p1ChjsP8HbtFWd8tspYwOoKYhMAjf2YEYEan544LyxRjt3W0
         ZXMe4xPw//r/gQA1ejqz7IaBG1ZV9uraysSefk9BdMOdQiujQpZMwjonG9GK6pPwp2Zt
         ZXAaPAXyG4iKcHwVg3uAhEwzWmeY5vcPs0yG8iqn0V2Q7SSJi0+fehBXCnVoqMhYr2an
         KOzyd4q8es6gv3iFCPIeK0iBUqi0BM1WkkMhop96zUrrHw7XIycDl4ISKbbLxvZ4az3p
         E14BpLgocXvvnYDF46d8DlELaDaYPUWDJiCVb8WFI+5JXVm4PSQHLjyvL/KEw8HbBgv9
         k0aA==
X-Forwarded-Encrypted: i=1; AJvYcCUV9xNGSpcokgwM2wV2djPP1GeZpi4AKkTEpMJqh/rV/Z6ijNgByIk78f6TIp75xq2zLr7SuA/pWThZkBe4avRClMoCcAY/d39WoQN8
X-Gm-Message-State: AOJu0YzlDRpGQ+VWHr6LI4QnyB1jp6aCQ4rwAh2PVRdu3ybhR1uRYPQs
	Q5RW6WxKrK+7QKxY5Kr5evHKRV50RhJMfI8G11yLI/IrECCGfsyxLKBqUBa2G+637swnXSBxP3K
	wnw==
X-Google-Smtp-Source: AGHT+IF+keQ0tZZQPsb0LZJ18aMfHcX5w1D4YRYdDX1MabHJOIATypkQkaJqlJR+t8uIKHgg/p6W4uz5JDk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4ece:0:b0:60a:6a62:a34b with SMTP id
 c197-20020a814ece000000b0060a6a62a34bmr409797ywb.6.1710441645389; Thu, 14 Mar
 2024 11:40:45 -0700 (PDT)
Date: Thu, 14 Mar 2024 11:40:44 -0700
In-Reply-To: <ZfDeohmtLXERhyzC@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308223702.1350851-1-seanjc@google.com> <20240308223702.1350851-7-seanjc@google.com>
 <5e302bfa-19a8-4849-82d0-0adada3e8041@redhat.com> <ZfDeohmtLXERhyzC@google.com>
Message-ID: <ZfNErIqnETakZxli@google.com>
Subject: Re: [GIT PULL] KVM: x86: Selftests changes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 12, 2024, Sean Christopherson wrote:
> On Mon, Mar 11, 2024, Paolo Bonzini wrote:
> > On 3/8/24 23:36, Sean Christopherson wrote:
> > > Add SEV(-ES) smoke tests, and start building out infrastructure to utilize the
> > > "core" selftests harness and TAP.  In addition to provide TAP output, using the
> > > infrastructure reduces boilerplate code and allows running all testscases in a
> > > test, even if a previous testcase fails (compared with today, where a testcase
> > > failure is terminal for the entire test).
> > 
> > Hmm, now I remember why I would have liked to include the AMD SEV changes in
> > 6.9 --- because they get rid of the "subtype" case in selftests.
> > 
> > It's not a huge deal, it's just a nicer API, and anyway I'm not going to ask
> > you to rebase on top of my changes; and you couldn't have known that when we
> > talked about it last Wednesday, since the patches are for the moment closely
> > guarded on my hard drive.
> 
> Heh, though it is obvious in hindsight.
>  
> > But it may still be a good reason to sneak those as well in the second week
> > of the 6.9 merge window, though I'm not going to make a fuss if you disagree.
> 
> My preference is still to wait.  I would be very surprised if the subtype code
> gains any users in the next few weeks, i.e. I doubt it'll be any harder to rip
> out the subtype code in 6.9 versus 6.10.
> 
> On the other hand, waiting until 6.10 for the SEV changes will give us a bit more
> time to see how they interact with the SNP and TDX series, e.g. in the off chance
> there's something in the uAPI that could be done better for SNP and/or TDX.

Though I'll add the belated disclaimer that performance testing is not my strong
suit...

