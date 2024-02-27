Return-Path: <linux-kernel+bounces-82735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09D88688D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A3E286712
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1E535AD;
	Tue, 27 Feb 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGr12HtJ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A4535A0;
	Tue, 27 Feb 2024 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014093; cv=none; b=FCMywgxmozF8ODVjLbBGL2+YAAQnJ0RlpIrBH7uYjPTXhYvQ5XIWYkJu0vZJ2e6/iYahycun4EYcAmULhUdJ2JlFvDSCPOqvVtQn/NtdzoC6XCvdEsIST6ermFPoLWxDtJM+Pr5a7lkZLPq9d5+xr8M5LpjPNwSP+GIZ4so7jMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014093; c=relaxed/simple;
	bh=9qCOs1IBx6ELRDSNmZ3P9R6G4riYikUgqkqb3BP9i5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB900NWiFaNPZmFwkFNRDogFg2BIp5MAiCv10OlY6nYkHTAtVLOkx2ZfuxWQ9SsqrJlgivE+Vo66t3Y+QnVX9nmeHcTa3xJkPTc12HgWrSKE9J2I5rBh4BkIREPiW29iK7KKKV9Es2pbzdcheyxVHtF0JvCVK52ZKXLSOHb8Ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGr12HtJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3342561a12.1;
        Mon, 26 Feb 2024 22:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709014091; x=1709618891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G7jNaNu3KQ3lMgFqItSxvaLHpUG6FQQfqYbQAo7X+vY=;
        b=nGr12HtJuDKz5WH0ShCMwqrirUFEChiRQKO6gOpoLjnidHIZDUlpW/wZqyIWbHBpDA
         ssMD3A1JsrvmVl+EY2pyOjbYa5mZG9hnUu9brD0XxDC75bNP50TtnMlHPqqrkMcLMk16
         +VW4j8jd5q/E3i3iFcVGT7Ew7FkzpM4ie9JkZvlS7q15HmqTHVUnGfp9S6TH0jH1WJA0
         /hjNYQyTjNh9g7WD1aNvj7Kz3IGd7DSS7N7DP2JS7vZ8kQFNNhXCqU7BB+CTYRk14Qpj
         UUo8CQC6J0XDtn9vfdERdDAEf+/PGHZ6hfLK27bcsxDDuHPltDGgvUZ4+XHU1g9qFzcL
         dqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709014091; x=1709618891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7jNaNu3KQ3lMgFqItSxvaLHpUG6FQQfqYbQAo7X+vY=;
        b=UfrPmnAthiLucS9VstKrXdYDWtU64FGrklANFZvE6Ag02sIFR6oCxDajhk34IoNxi5
         Bz10WlBmZwyNifRV5CYQ9WCdEwZGoPvxlz7eO/iCbjHmYkf86/jGqlI268ZDYGs5FVCQ
         BTfZwu0bd2G11gCb3dKXHDkWVbY+Z3TVDauN3PQW4HE05IvkBhknSap8ErJgc6du0jwI
         jbUOjl/Dk38uuYbNAySpPeX1f2BVskoBWeFRLssZE9ozFN5q/pKwzS4UC66fCCcQKASc
         tJH+7dnnxenMlnNgzQemUjBXMd8hU+C9QTuN+DeK2KN2AvY/TsdrWPUa5BWteD7xEo7p
         dQQw==
X-Forwarded-Encrypted: i=1; AJvYcCU8HYvaSFjej1cfF59c06swtrLHJNtyLKIM7c3FENTH6X+G2CVr9IxxBJlUpdRxbiGK+i19hyOCsQkh8GchvM/kJGvjYur4WvBZBWwV+/HOjvWQIbJW047la3FK7F6QDIqd
X-Gm-Message-State: AOJu0YwqsV/X4RCaJUDOPLY04HDLn1yhg4DnDWuqPJ0+7xHSbgxFVIsL
	I3ovb4w1AHTwE8cvBd0RqpvvClp9qioZl0nzN2VO2WSwqxs8dY5gYoekxd/pGBnPiuIS2dlhKJ+
	Ue08fkrNuW37Z1VgL0BLA9eWKW/JRJlGfw70=
X-Google-Smtp-Source: AGHT+IEGiqSye3NJtw1Bu20ESldnefsEoqZj3JgyLBM3O+Uw8pB7V55KDHTM1T3Lcd3dfblvaB63NFAE+xzK/Duz9IM=
X-Received: by 2002:a05:6a20:d805:b0:19e:9adc:b274 with SMTP id
 iv5-20020a056a20d80500b0019e9adcb274mr1418017pzb.41.1709014091592; Mon, 26
 Feb 2024 22:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226032439.26359-1-qiang.zhang1211@gmail.com>
 <CALm+0cXvWG2cP2sECzF9JGyUvvp0bBgSXA8NbGf896iMQEcCuA@mail.gmail.com> <ec57f86d-936c-4709-aeda-d9f57a8fd7aa@paulmck-laptop>
In-Reply-To: <ec57f86d-936c-4709-aeda-d9f57a8fd7aa@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 27 Feb 2024 14:08:00 +0800
Message-ID: <CALm+0cWESKy4xCg9Eg4-6OoxPcQ102F4TY5C80jgugrmM3ptFA@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: Fix the comments for tasks_rcu_exit_srcu_stall_timer
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Feb 26, 2024 at 11:28:57AM +0800, Z qiang wrote:
> > >
> > > The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
> > > deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
> > > This commit therefore fix the comments of tasks_rcu_exit_srcu_stall_timer.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tasks.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 78d74c81cc24..d5319bbe8c98 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =                                                   \
> > >
> > >  #ifdef CONFIG_TASKS_RCU
> > >
> > > -/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
> > > +/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
> > >  static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
> > >  static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
> >
> > Is this timer not necessary? any thoughts?
>
> We have preemption points in the list traversals, and things like mutex
> contention on the do_exit() path could result in extremely long lists,
> so I believe we do need the timer.
>
> But what did you have in mind?

Thanks for the explanation,  I ignored the scenario where the
lists might be very long :)

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > >  #endif
> > > --
> > > 2.17.1
> > >

