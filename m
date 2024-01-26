Return-Path: <linux-kernel+bounces-39463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF383D18D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0DBB25252
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A0399;
	Fri, 26 Jan 2024 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xEVw8MHC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049B4404
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229440; cv=none; b=jq00nmfSwRWnDrYzJOCAj0yBLuVCDU7mxNbgQWcY5qjd7OM2J5W2jNxEa+u14qf8stEgYISpa6o7XMy6zM75s/kWBxTuFxc7TeWGbQD8IFcy2VbJQaI+AzYLLVvU+YEhOoAD1LpnuMJaJlpoj4giJNexYpVehfsp/wCF/Ivg7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229440; c=relaxed/simple;
	bh=eQjLrBx1jAy1axsMoCop2jRljLStEzLN5lXFvbtz/XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqdQwALEU0DA1CsDtwTwxhOBFAJ63tBkp7uqfCBMQoBx0XDi8mYU/CBkxHTCY8NJ7V3B5tK8Z+RHw3U4ORBQLjDGC2/9UZ9ocH/ta237agKiODIFlbEtfNLEQxEg6ZTvXKWFgGoODK5RNlMCI2Cz+gBUHth3w4tgXh5Zp0TwCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xEVw8MHC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so80421865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706229436; x=1706834236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RB+yYtHCz4/Tsgg+cD2eed0axoHrTFJTTQUoz2vzg5U=;
        b=xEVw8MHCWXpuLhMz4/UuNixSK/5BZAXdGp3EnIYT+RkB2nkHn0FOQv7FM11rDJX+La
         FYfCUDCBnsqyQa2UKCA7xtSA5TwzcrSNNwNxUGiUElucvcUbD5X1dJbQ0E+7w+Xh1sJh
         iPfQLZA18uzbL3agvmwq3ScDXKcTz2dcw6wwZRpFEM2vfyOjcfnztJxluUoKJbv7WN3F
         I/0m8LrpqHAWGASsfNGpFP7x218qyxOyCdNT6VeCxsorUdbAsu/ORXifJ0eH6PINRX82
         AYbE/Qe6w8aZgZ3oMhujM2SQ083rq58LwEpk4IwIPlT7AzZMeqjZwYdXUznvhjBEKUcq
         Zy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706229436; x=1706834236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB+yYtHCz4/Tsgg+cD2eed0axoHrTFJTTQUoz2vzg5U=;
        b=ZaxSX9Us9cNgg6nu/donaaw0fSY8xmHxK3I6GY6oW6CJdpe34fhlAOupyUikUQ8b6H
         Hlwo7Hs0KH3AdMXM+XLylU+MqKyUUiPDsnplGSzVM/zcXaTZO04zpaEW6ZsoiKdl8Vi+
         ST6HWk5TF7L0GB0jGGZyh/ALDE2/aaPRX+gvrssKAz1frwG3p1IY07PgBojBFbWPXHrf
         cXGHVY+oljeU3Mhr8YBBB3EwW2lm/uPMFZCcBOdygXfY5hy8hHLoAFL8snxYyOMsOqXk
         3YuE5uOIYzYWS2K5n2AYP1CRXmPp7pJwbSWvuy5TlR0MKYGzBWptBO0mfAbYEzprWUtr
         qNjA==
X-Gm-Message-State: AOJu0YxGFDJasIg0iMoJlfiK8xGjeiMd3TKUBjy4bWpblA5ZZ+wIO2/a
	tCm3wVxms5g5iVjoMdXVipG/ILrfNlhhFsa7lIiyPnGqjEXhipD1Cno4lfrwg5Y=
X-Google-Smtp-Source: AGHT+IGmaisWSa6ZtSO7sBx7DuRg1h6mVPwAQ2GLQgThex/wnRydIOx+RNZSFocCe8tjJMYhH6RQwg==
X-Received: by 2002:a05:600c:4743:b0:40e:4119:cb4a with SMTP id w3-20020a05600c474300b0040e4119cb4amr327481wmo.15.1706229436175;
        Thu, 25 Jan 2024 16:37:16 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040e703ad630sm4145718wmo.22.2024.01.25.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:37:15 -0800 (PST)
Date: Fri, 26 Jan 2024 00:37:14 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240126003714.tru4tz2pzjg5jnvf@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <CAKfTPtCfYcD_zPr7PqgL5hRYny=n3KW8hr6GY8q7zkoyRN7gQg@mail.gmail.com>
 <20240124224616.wcrexeb2evkugbak@airbuntu>
 <CAKfTPtDnxsOS0je9DgMc5ZCLPXA6QRLz14t6o_ht7rvxbAbc9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDnxsOS0je9DgMc5ZCLPXA6QRLz14t6o_ht7rvxbAbc9A@mail.gmail.com>

On 01/25/24 18:44, Vincent Guittot wrote:
> On Wed, 24 Jan 2024 at 23:46, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 01/23/24 09:32, Vincent Guittot wrote:
> >
> > > > > @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> > > > >   */
> > > > >  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> > > > >  {
> > > > > -     return rq->misfit_task_load &&
> > > > > -             (arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> > > > > -              check_cpu_capacity(rq, sd));
> > > > > +     return rq->misfit_task_load && check_cpu_capacity(rq, sd);
> 
> Coming back to this:
> With your change above, misfit can't kick an idle load balance and
> must wait for the cpu capacity being noticeably reduced by something
> else

Good catch, yes. It's a subtle change. We need to keep this and better add
a comment that we move immediately for all CPUs except the biggest one where we
need to check_cpu_capacity().

