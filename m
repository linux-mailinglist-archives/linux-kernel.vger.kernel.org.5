Return-Path: <linux-kernel+bounces-112004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82383887403
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206DD28316F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752737EF09;
	Fri, 22 Mar 2024 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhBdMSh+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF517589
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136971; cv=none; b=tnczrkD8ajZ8B8wJKAuxNy63qunPdsDbD9+B2vJxYS/8MTxP41TEUVL4bx71vBTuSZehEDSk5ofRxWZ26ot5pggajxpjfFCo1RdrEbj/TEQTvH4unOGQl3u+Yr4iKnamLYznY8x1/frlHF82L8r4j8SM+zZa9VYVScDBRA5lTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136971; c=relaxed/simple;
	bh=EQ7DBIXYnRLKJLYv8JBf91ZtttnplOpDVAnjNcCqIis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNWXq3UzXpiGKobcww85F8m9zlmhQeGPX/8wtbEsIZ2fP+HIY7Ze5nCAeK+97Xi7CsObehjGJwnA4ymTj9qXIwfEp0/NoBMA40u54ShB7FZZoZ4PT2MbvU6CZIbTo5lYUy6IUpp6VNojo+vgH32UCBvPkLETVkaFkl3JFo05rCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhBdMSh+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568c3888ad7so331a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711136968; x=1711741768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ7DBIXYnRLKJLYv8JBf91ZtttnplOpDVAnjNcCqIis=;
        b=nhBdMSh+OAJyyoEuRllkELIN0317hsrGNkFYv1GBSUyACW2d0zntJFvqRnzwFFhwb0
         9BR9hMZAAlgRAPviVYbXxvxfRDxw+21+85H79HNnlC6LnijKXxDLOefi+SyUt/39h5QL
         ihxFe6svez8VCjFQ9qBVp3s6F/qXSrIIFg12Bk7zOTL1DsfATPtgGgzNAJFz3+8b+KNe
         jIupJRssU1RC1hWP5O+ywRgroAIl17qH29DQaeLEzzPr0027zE9OC1F3tn3XoIcNIK6q
         9Xd1yyLdLXp9KaT/7kppUUzWI9eJIgbWt1OV1iJOYOy/iOAB+Pk6YTbNl0rwAOydtf1C
         1PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711136968; x=1711741768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQ7DBIXYnRLKJLYv8JBf91ZtttnplOpDVAnjNcCqIis=;
        b=Wx4mjTvmFd3BlpjM6FEJy+Qgn8zERdTAEw4sOhtPgSmQEV7/evAM0hAy58ZqxgSisT
         BDdRgosxixj4d6NYBsZFRZ3AKa/Mu4qZ4+PHHBDjcBROn5R7wA37my5zZwpMFR6uxtYD
         8LvfRO6rZVfYoQA873dNBRjR3QnzEur68rx++i1dgnNyj2UqsrrmuswPoK4yhMCtaNMX
         F5ZHremAXx3151fZenWg+qcthaYSmNvKM/eJcUIdoRVC06yNKTSzSwqJ3va/llob3Yh7
         GXJgt3wT3O6hYdc0F30PdKzeJUM12WBSCE+BESRyUt7SMu+XBYuXXB9yYNCoeBsMAjW/
         smaA==
X-Forwarded-Encrypted: i=1; AJvYcCVQFl14A4rI0cNejr19g/fZxbNZdr4dLC2HfiqFXiDBLbak+bxQrlLlLVXfL/pMVefuIzpdYJJgXdcIxrYpQseBP0AoPORs+UfBVqim
X-Gm-Message-State: AOJu0YwVxuGytsI7DUJtEhKZc2jk3Hk42pDKWPw8LONV0XUQdNBuBDzm
	SdnyCOf1LqrinqroDBytMVtf+9XFTe29JHQZhPcsogKWD3waL3wo5ajZCcAktv1eG+Q2plNyFV9
	KEoYCxv1+d+OqmZj7sujcQpcPt3B2+wu1iSY7
X-Google-Smtp-Source: AGHT+IFz5yYEU1ipAp/ZOWOzhs6gnAbSpfTfDGEsEgc5DMOpyj8hhaxftpCv4UaDseItpyDuTpGuvo3OqaeIE6Q3rvU=
X-Received: by 2002:aa7:cd12:0:b0:56b:b464:d529 with SMTP id
 b18-20020aa7cd12000000b0056bb464d529mr479593edw.2.1711136968389; Fri, 22 Mar
 2024 12:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org> <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
 <CAKfTPtDSC25N8TvszDAjseqdLdGy4qiDnwobNThkt8piSL_5Pw@mail.gmail.com>
 <CABk29NuU30DHproFY-i3_baEhXxofCyLQx-Z5LV74y8_6m7uGA@mail.gmail.com> <CAKfTPtCf3US76sLObK=iRNtid2hL8s-6Denha71F6W4J0MyAoA@mail.gmail.com>
In-Reply-To: <CAKfTPtCf3US76sLObK=iRNtid2hL8s-6Denha71F6W4J0MyAoA@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Fri, 22 Mar 2024 12:49:15 -0700
Message-ID: <CABk29NvL=fKwuO=p7iDUOVDd5=F1J-_WTRGivqVnJACVutEGnA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"

> > Another idea then: what about separating the number of tasks we can
> > move from the number of tasks we can search? You effectively want to
> > keep the number of tasks that can be migrated small (nr_migrate), but
> > be able to search deeper in the list for things to pull (a larger
> > search_depth).
>
> That could be a solution indeed

Cool, I'll try spinning up a patch for that then.

Best,
Josh

