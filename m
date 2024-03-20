Return-Path: <linux-kernel+bounces-108973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA58812B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C106C1F2511F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0541C93;
	Wed, 20 Mar 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxNM03C6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F194594B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942674; cv=none; b=KKE6cuojdnP/GJDfxckRzw481ClhBtZjvAg57CfMK8U16tQ/FCxkutDtRCIWQY1knZ1vHbWGoU1VzFISSrAY2d9M/J0wcUjzw2nHpdxnVxzJ0wrbMHoFaWx7mn0JNXCEl6x/4GzpxJu7mGSW74WK/Y+YiUbVw4mu5TkCqe67oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942674; c=relaxed/simple;
	bh=Y8e4BaWXclywnzI3Jk7S4TKlOxYeGBb8JSlPzQCJxxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDlPoE6qC2ZM5WFQ/5p3LiPYj55wR3W++2sASv1eyHNZaF2O5YXsk3mEqkRkrRqMob6Aaw2b3PzaBBtuqDmo76XAEOLTH5xihd9XmNnA+vbiOqE+YavNEe/fdqC0BcKZHXPT7ZQ2oa6xrbxC1wWgz9RGnI4traVP/eMdHkZOrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxNM03C6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e152c757a5so4102136a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710942671; x=1711547471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8e4BaWXclywnzI3Jk7S4TKlOxYeGBb8JSlPzQCJxxg=;
        b=MxNM03C6oKbyoBAX6jnlDNhHiMDmQDd2yFOQcRyVjaf1WelqgAvbHnWwV6Q9WBoZUw
         5q8+IoruP8Fb51rQCFLDX68QEGT3S5hSm1xqUoh94NRcNNCB4HuDHvwN1fWEW039K011
         xXfe4kzZcqG7OWLXRrO/xTLNIcIurXml7JJbNtAC9f7yDj8eHwq6UYU3U3YE5dZ39vOx
         nCqg6Fffg9WQzUA/AZme1mEIxg7E4EJYxNnBhWnEAEK4ztmBbAjqLIyO4v7jZMs1tp4V
         8byh0vIA+DYu/+dk+iPYyG/NAZz8XbJE03CqSvfWG9dTd+w88JMwttZOWzF/f/7fRPRv
         FJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942671; x=1711547471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8e4BaWXclywnzI3Jk7S4TKlOxYeGBb8JSlPzQCJxxg=;
        b=ckZYie0plWWm6WxrWHbJGQtmt0/6j/5EIFrILRF9swb9yiOWFkykGt4iR6v4SHXvbW
         xKXXSnuM+Fs0hcYKohl47Z32a0OHukDrnIVkL+RxGzhhDlW6Uuc/UPJFjLILTFAsWLo+
         r+/VXVVHpX+Bbslf5+DXTG607BzjI2gDFF/Sxx0rJyKobNkW8kAbAczeard7bbU5rHXk
         CP+gXrBgLsxsGfH57oYGb9flfc/bNn6mZlqeeABRgaaTy2sGPOkK2Kym4cDEQFxMdv1a
         qGHK1SE9wqSmF5QCEb9bCpO2PfQut6iU1SwhnDsh/heW6bbU7n+B7oc27il1qGCK/3LN
         bqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyc/FrOM1ovd6dy+z0RI9q0tD804coC8EgQ3vRb0ha+MmsRkQmjpXHsKM3CY1n+ihNHKeU/2mB4OpvEzB+TBKNmlfzMwZnMX8GARvC
X-Gm-Message-State: AOJu0YxtvGR5GgNHnFsBP9qioGbNJhBykZ4J2rG7ypIpVpbYIj9q+yKN
	fYLW3q8e4xWYIdBpPqwdRCew0RjpHuG7HQd4AOUE0vUIqVqsmg5uDglUAJA/tMGoINOYXRQFYFB
	otK8QSVFBaL2o/ow0886NDpBl5a1xYHaKl2lhEw==
X-Google-Smtp-Source: AGHT+IFsUIwk02qC8x3xR6wX6hTw++PqVrYDzZneUQhrgnsJwX1DHRCbykwe+cTEelP+DZO8ncZNxbGnxie1HjumVQU=
X-Received: by 2002:a17:90a:77cc:b0:29f:ea48:375c with SMTP id
 e12-20020a17090a77cc00b0029fea48375cmr3411136pjs.42.1710942671518; Wed, 20
 Mar 2024 06:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228161018.14253-1-huschle@linux.ibm.com> <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.> <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com> <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
 <65fa8a7c.050a0220.c8ec5.0278SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <65fa8a7c.050a0220.c8ec5.0278SMTPIN_ADDED_BROKEN@mx.google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 20 Mar 2024 14:51:00 +0100
Message-ID: <CAKfTPtBA7ECeYJYdzL9ybeXLbpEudLfB6V9s+DZiJUmpnPf_kQ@mail.gmail.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 08:04, Tobias Huschle <huschle@linux.ibm.com> wrote:
>
> On Tue, Mar 19, 2024 at 02:41:14PM +0100, Vincent Guittot wrote:
> > On Tue, 19 Mar 2024 at 10:08, Tobias Huschle <huschle@linux.ibm.com> wrote:
> > >
..
> > >
> > > Haven't seen that one yet. Unfortunately, it does not help to ignore the
> > > eligibility.
> > >
> > > I'm inclined to rather propose propose a documentation change, which
> > > describes that tasks should not rely on woken up tasks being scheduled
> > > immediately.
> >
> > Where do you see such an assumption ? Even before eevdf, there were
> > nothing that ensures such behavior. When using CFS (legacy or eevdf)
> > tasks, you can't know if the newly wakeup task will run 1st or not
> >
>
> There was no guarantee of course. place_entity was reducing the vruntime of
> woken up tasks though, giving it a slight boost, right?. For the scenario

It was rather the opposite, It was ensuring that long sleeping tasks
will not get too much bonus because of vruntime too far in the past.
This is similar although not exactly the same intent as the lag. The
bonus was up to 24ms previously whereas it's not more than a slice now

> that I observed, that boost was enough to make sure, that the woken up tasks
> gets scheduled consistently. This might still not be true for all scenarios,
> but in general EEVDF seems to be stricter with woken up tasks.
>
> Dismissing the lag on wakeup also does obviously not guarantee getting
> scheduled, as other tasks might still be involved.
>
> The question would be if it should be explicitly mentioned somewhere that,
> at this point, woken up tasks are not getting any special treatment and
> noone should rely on that boost for woken up tasks.
>
> > >
> > > Changing things in the code to address for the specific scenario I'm
> > > seeing seems to mostly create unwanted side effects and/or would require
> > > the definition of some magic cut-off values.
> > >
> > >

