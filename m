Return-Path: <linux-kernel+bounces-102696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8A87B616
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A18C1F23882
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2458C07;
	Thu, 14 Mar 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rb27KzXV"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D968BEA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710378941; cv=none; b=CsbL+DGt9tlaFO/+qR5rhIlm2nuGKnuxH+/bEz027e9gcWietiGdVQzQukMVgO8qxBDeF9PkCaPdaRiKanPY+MZNGU1ex5A8ln5uLDcSdZOh3+XOdgAHt+6BXYrjHZSDAxwCX+HlTSCB6GpPO9TJjxyq15SW7UE+nbDGkANU1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710378941; c=relaxed/simple;
	bh=KrPxTNGdpWETrK+T9KbNRK7Qi4h2PE7esLmJ2xH0loE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haZk3JZAjoJGfD5FumkM3XeirMnhiqbNHCwP0jt3rmltcAamZif6YKcsxlQYPTYmvCYpB/3wIdHU2n11vOMYeXUH+O6OuW7vzfHbnBV4R38DAVCSp+7gJ3wz6OO6o7FvMOYdToKvvK4qEx1M7XlGyvCpzyJmoNAyxVygZYYI8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rb27KzXV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5685d46b199so627220a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710378937; x=1710983737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi5Og+CbxdS4GgMBXpSqcHe7hFHRWvxTE989cCTSHJI=;
        b=Rb27KzXV3LQyWuhUdj2kLxFgWUVUxqFmRRZYH3nz/kf7ucNjSSgcfYpo7M1Bh+tPtF
         9XYogXiNgGmr1XuNViQqlcZCU0bILxgCWi6Yyzns3FwI/J/LPwNPFn4azh7TRmdMDsDG
         kdnkcN+ae2QC1tNyHKdQTDUL4nFSRvSjebXa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710378937; x=1710983737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi5Og+CbxdS4GgMBXpSqcHe7hFHRWvxTE989cCTSHJI=;
        b=q5xXb4qzxgraNGL9iWycHZul3OEtkqHsybAahvwqVcSZMvC83NjjYftDXBapFwiQKX
         /9Dox5e0RK7GNs+OOWaJU4dqORFJg8ZkXHs/MRZ8mkXLkyvydpY0tYVGIAbY7aieYB3W
         FZupYCK9YpvzucSO/UX2QQv5MNkprlyBYo2J1+ssq3JvrJ3IokrDjNhHKkshoVIm/2cy
         oZ+lFR2GJNT+fZ/CA6IyhcBshVbuSh+3+adR1D+PBGLJq3nTdOR0O9LJxWrHMKnlEpPH
         6aiUeb6ZzXbhBn6gABZUPoa8SC83pfbAzhr9K+mNtD058JRXVGqDUNqEoU1f6IVwz/Yl
         /sgA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9jSDTgHXQmrALlxyZg/rQsCC/PXL/z3ysVBJyF/vbp6Rqjm4ySfBGwyLPGx4MOphn80RQ11EYIYvFX3BV57CW4HMFEvC6pcsW2Xx
X-Gm-Message-State: AOJu0YxBgpyFCJSgg2nipGpBdPo7DOC36H1mtF3UD+uO0+vCOXIspYGg
	pnkQ5i5AFJ1tLcifKgsr1w5swPCppDj7Slk9ptdVh1S2E2+mpfTiOCNtYQbdVM8JzQeFtHeuAZL
	yvbVfew==
X-Google-Smtp-Source: AGHT+IFKZ634s4u+yM4bAqaqWG/ffIQ8q1TeAswWbxpdVYyrLSlKQK97HGBJUAxaG10EDgojiPRMTg==
X-Received: by 2002:a17:907:c313:b0:a46:58b4:a34a with SMTP id tl19-20020a170907c31300b00a4658b4a34amr152809ejc.47.1710378937613;
        Wed, 13 Mar 2024 18:15:37 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id l23-20020a1709065a9700b00a460040a102sm162274ejq.124.2024.03.13.18.15.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 18:15:35 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so38964266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:15:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXV231IUO3+4fjk7QO6jwfDUqc50cINEhT6gLu83REE1axw0XV4wFJ3WN9QnjHWjf3gqn80cGT5bVIW/xvnYBEvDi0dXtyA+a0bVS2
X-Received: by 2002:a17:906:48d2:b0:a3f:1cb6:fb00 with SMTP id
 d18-20020a17090648d200b00a3f1cb6fb00mr107160ejt.69.1710378935472; Wed, 13 Mar
 2024 18:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZetHwrCb0KXE0xFI@tardis> <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux> <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux> <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com> <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com> <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
 <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
In-Reply-To: <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 18:15:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
Message-ID: <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for v6.9]
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Joel Fernandes <joel@joelfernandes.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	frederic@kernel.org, bigeasy@linutronix.de, chenzhongjin@huawei.com, 
	yangjihong1@huawei.com, rostedt@goodmis.org, 
	Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 16:29, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On this specific commit 7ee988770326fca440472200c3eb58935fe712f6, there
> is a 100% failure for at least 3 devices out of the 16 that are running
> the test.

Hmm.  I have no idea what is going on, and the unimac-mdio probe
function (one of the things that seem to take forever on your setup)
looks fairly simple.

There doesn't even seem to be any timers involved.

That said - one of the things it does is

  unimac_mdio_probe ->
    unimac_mdio_clk_set ->
      clk_prepare_enable

and maybe that's a pattern, because you report that
brcm_pcie_resume_noirq is another problem spot (on resume).

And guess what brcm_pcie_resume_noirq() does?

Yup. clk_prepare_enable().

So I'm wondering if there's some interaction with some clock driver?
That might explain why it shows up on some arm platforms but not
elsewhere.

I may be barking *entirely* up the wrong tree, though. I was just
looking at that unimac probe and going "there's absolutely _nothing_
timer-related here" and that clk thing looked like it might at least
have _some_ relevance.

            Linus

