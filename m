Return-Path: <linux-kernel+bounces-85665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889086B8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9694B27B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865E7443D;
	Wed, 28 Feb 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W5O7VKgi"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450634CDE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151291; cv=none; b=h7fFVrie6cUU/1/vSQEvLnTEs9bI1Hwk53nm5ZNQBhaN38ErFeUMvHkuN9OjLr6AFt5FwLJvWzTTUOZBZ95FPs/dsw+0Hjg5DV/acT2A8HbuGrBFPjs1Cw1ejo/ZsUdga6MIJmZaooWdoAUvOz7WgOv3opMGRehZwdUfMopGDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151291; c=relaxed/simple;
	bh=0nrml+WBxBMSjB6gKdozgb5uGnndn0Y89KcuAcb5ymw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn0S6jVNaoflmIw5dkNXcqKxCuiJ9pL5+D1cV1NN9T+MSYbYu4OrGo4cfu0pW3D1ymNWDfi/Hl8IKOWs99ANsZ94nTbsUhPkecPNWnNk9Fe51XmhIxlRAJH36++9K6LreoHaSFU0ARteItBah0nVQ8Cr68eUdz0gMu+E4+x0xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=W5O7VKgi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28051376eso1800991fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709151288; x=1709756088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ADqDxZgPwlPHrnolYYX16DFA+qGQXF/8Cktxf1H8u4=;
        b=W5O7VKgi0RbREj9bK4Jj5Fb/FthztsNedxht03WloYlKep64hw9KOTCl1792qGxaBQ
         xcQKzawXUgJcl+IXmoQ9/1Yp1GVfNaxOvmPklwosEmZ2Jj1obRlTpB0GXJDQ9tktvLW5
         2P/lviMm1/25OJAZNOdBD2hxALxvlydcFp5Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151288; x=1709756088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ADqDxZgPwlPHrnolYYX16DFA+qGQXF/8Cktxf1H8u4=;
        b=nWdyNH11AFa/L5PNL0MktLMGWAWrtNFGiuZ3a91U+DszuwtAxrgpYr31Vgic94AITJ
         ojx2RA/czC9MeUP7LcqGk0algeErJ5CXgf6McCa3TAzI8mJgEQf5yINy51AX9O7ArFtS
         LGeL/fpZB0mS3xIuhx6HYCFETSxymN8pbe6mEjnGMsBP5Gy9bQaNsA5zSiXC7If2oJlf
         hEW4yzqdYVutkXMmIiPTm2/B3DKhdRPPQi+NywwCy+hiSY6zu7B3hGRMnyIGEYnuQGT0
         QOLNBaewHDty7n+mrL6NkyDZyxcXma4aT/8SiERIWEz6iI1nZBCdvvyTkmHA20Zcjkzq
         biPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sSJdzDHqiBuFacnpcvRf8DamtZpTsg0Ghjn4b3K/Y9ZxHGbrymt+XXpX4nhdSZTJLrrYgJ5NOKJmhwEdPMnftpg1H7TLtqfZ8hyn
X-Gm-Message-State: AOJu0YwamHJGTGEHq4+atz4lWgs4U0wnQ3ZISiTv53bDp/aAvocSeafb
	HsXIQTHMWCcdInRWrNekT47U3upDnQ/VTU4qBwEwAsUJL/3123+a6VM4N/MzGRxE+nAh1w0X2Vl
	rcIIZp8DoS0D1IBTMHV2iM+DY3wtIjOfUrp2U4g==
X-Google-Smtp-Source: AGHT+IG7XxH4AwZOInEocXRNgWrMaGpJwprc/M5hmyKfGaWgosyEiwVI681eukxW0okBE54/dKecrCUQtR2maiJPvrI=
X-Received: by 2002:a2e:be28:0:b0:2d2:64c8:49a6 with SMTP id
 z40-20020a2ebe28000000b002d264c849a6mr11611642ljq.21.1709151287525; Wed, 28
 Feb 2024 12:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
 <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com> <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
In-Reply-To: <e592faa3-db99-4074-9492-3f9021b4350c@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 28 Feb 2024 15:14:34 -0500
Message-ID: <CAEXW_YRfjhBjsMpBEdCoLd2S+=5YdFSs2AS07xwN72bgtW4sDQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: paulmck@kernel.org
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, rostedt@goodmis.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:18=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
> > On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > > Also optionally, I wonder if calling rcu_tasks_qs() directly is bette=
r
> > > (for documentation if anything) since the issue is Tasks RCU specific=
 Also
> > > code comment above the rcu_softirq_qs() call about cond_resched() not=
 taking
> > > care of Tasks RCU would be great!
> > >
> > Yes it's quite surprising to me that cond_resched does not help here,
>
> In theory, it would be possible to make cond_resched() take care of
> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
> of cond_resched().  But if for some reason cond_resched() needs to stay
> around, doing that work might make sense.

In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
(to me), because cond_resched() is to inform the scheduler to run
something else possibly of higher priority while the current task is
still runnable. On the other hand, what's not permitted in a Tasks RCU
reader is a voluntary sleep. So IMO even though cond_resched() is a
voluntary call, it is still not a sleep but rather a preemption point.

So a Tasks RCU reader should perfectly be able to be scheduled out in
the middle of a read-side critical section (in current code) by
calling cond_resched(). It is just like involuntary preemption in the
middle of a RCU reader, in disguise, Right?

thanks,

 - Joel

