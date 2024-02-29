Return-Path: <linux-kernel+bounces-86199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533886C171
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C54E1F24444
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B63E46B;
	Thu, 29 Feb 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfSPhWw0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3F446A4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189737; cv=none; b=YEUyLb35qR5kL9V8lEnOfmHg9E+I0Gu/+ppS55s367gSl5ZAyt7ul/xqtdInHx5/Qy4WYxJWD5cvx/9pPBsymcreeDwpFC/KU3D5MMZ86611EZsdw0tWryAETgAGNqBtmeX4S2uBUQ5WxQxHgWm9uQcGhYuW8hNIYdj20wBMmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189737; c=relaxed/simple;
	bh=nQRcuRmOckX+8AS08+AMvOdUHslM9abo/jE0Y4hUEuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdBl5NJk9TT3SlLOcESIw8wxbVBzNCNV9roBbdOaoCiBr+uhlyQ2C7wqUZpVojZOfj59I1pVgfpGYrV770FQCI1BkdTDHhyjK4wIqjDxEti600BpR3R/SX9pt5eITiVPTrH998ROSwY6r+/2szCNeLuQ59gvVA6iZ/X2FWujSOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfSPhWw0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4129a748420so51105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709189734; x=1709794534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQRcuRmOckX+8AS08+AMvOdUHslM9abo/jE0Y4hUEuA=;
        b=NfSPhWw0G1oEunV1gHNjncxG98NDj1D+ks99cuhqRCWTQQBEh20DYELjoh61ikM5jq
         /krgzIcEDASUq8kzyQoqlihAKuTHtinKG6ooRUvqiyeOIqpKNeFlCdioxsZ++bghSsZm
         fuf99IA4fMzLHFt7QCa7vVuKO5GuwGF3TEfw/y9sFGPFs3yG5/pvwyhtXE7avZabXPVO
         ylyx61PvXuCHrchAtjFhisjYl8l0kYlSe/cKHHMUtsx8I9DPd9eNWKHbabKNOA3wrtYH
         5M+1f4fXFH1VWkRwWaDQzNrfKb6BVknr8QQAdJMH15Wee9Hh/57s7xGybXGnZe5tkxxp
         MFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189734; x=1709794534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQRcuRmOckX+8AS08+AMvOdUHslM9abo/jE0Y4hUEuA=;
        b=D9uHCB/e/FwYzq9J53rgm0ak3pURAxUsnGfZb1pY+Cw2lwNIsuVLl66f2kYckbyOd6
         bILC/dyMH9xZlgtOrFlv75KiFLfU8qSBgd3WMQswsdxGUZoSPC0u71oVhLlwNKZMLdjt
         QmJrKxkB71x1UZ1VJMQLXysod0YpTBDqJGVdd460Qd46n294Jquh1v5FOBihXs570A7S
         BFE+TPsTeuP1yFRhPVWbT5CxDV5REuzWmcIocYkTwN9r1jpxYY8frqVlxLozUID5lol5
         Yh9NVkt0MSFvzFEmPxr/4trpfthgPxwKFxNG8Lrlq94rJ5kjqqNhK/mMqvV8Rz4gT4/X
         i7oA==
X-Gm-Message-State: AOJu0Yy/a74rL5CPt13iDLrryqtADDOaUisalfsjqAnpAtK2xJug58Yo
	WHBiLxfionxTLZZ7kRq8z5CeStGEFcypXMD5xOpz/6j3dMuyAJcuzUmyR3P90Hcmd5U8froH98c
	J8tbkv+6FZkpieVeOXo/QacDzlq8CiNAVwz4=
X-Google-Smtp-Source: AGHT+IHZCmqKwLkxRY2MOI8m1c2RJifqPkzwTPnf6O+G59InSmSHGR+kJnraGSuiRpaBbqZ2S1tn4yMESDhbF+cv3sE=
X-Received: by 2002:a05:600c:a386:b0:412:aa80:bdd9 with SMTP id
 hn6-20020a05600ca38600b00412aa80bdd9mr80238wmb.2.1709189734006; Wed, 28 Feb
 2024 22:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com> <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
 <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
 <0c606d04-6765-d55d-61ec-c3625daea423@amd.com> <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
 <c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com> <CANDhNCrkXF0R1Otu_EKY6OHxnAOYUQ+UjaQsJ_mW4Ys4ELPcYA@mail.gmail.com>
 <7daee7bc-bf4c-ab24-dbf2-467371ee72e1@amd.com>
In-Reply-To: <7daee7bc-bf4c-ab24-dbf2-467371ee72e1@amd.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 28 Feb 2024 22:55:21 -0800
Message-ID: <CANDhNCpJJaQn2MJmsyVQjVfWu8-jaUWKJ6ujG=4DjN1ALhbicA@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:44=E2=80=AFPM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> On 2/29/2024 11:49 AM, John Stultz wrote:
> > Do you mind sharing exactly how you're running the benchmarks? (I'd
> > like to try to reproduce these locally (though my machine is much
> > smaller).
> >
> > I'm guessing the hackbench one is the same command you shared earlier w=
ith v6?
>
> Yup it is same as earlier. I'll list all the commands down below:

Great! I'll try to take a swing at reproducing these locally before I
send out v9.

[snip]
> If you have any other question, please do let me know :)

Thank you so much for the details! Your efforts here are very appreciated!
-john

