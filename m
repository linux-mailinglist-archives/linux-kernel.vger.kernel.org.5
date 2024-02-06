Return-Path: <linux-kernel+bounces-55658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6184BF9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53ED01C2168C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F2E1BC27;
	Tue,  6 Feb 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zdUcalK"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D801B951
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707256506; cv=none; b=fLM9c0QzHXKmp+BxTdg6p49E4WDKDElP9aKl9+OrtCrsYaM9OO/IIaRqo+KKAa++Qp+bcR19OUrDV75JKcdylp/urPyEXx1d36CFQlO6+2MOPK1WmwmB12f8MdU7fPtwI14+XpJGZHQSW57XMx2Y06OSoxdBbCHG8FQa9Ga2flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707256506; c=relaxed/simple;
	bh=O7ZGfeGKBF9phLlyx19ES6xYPOfUrf5xaU9sp4daNKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hmE4RaurG1NAUoUnUc9OrxTtgP4qzHrCcXesUI2wjEY/h10zwFP/gTTkyslfCSVN1pLQP5S2XWhwLe3HPEVhhy5A0O5F67G0QbQtq7fcOVnbOucPwJYLSBELx0yvR9QmjJx8FdhYCe+HKy66BKYkDj07Z85fpubnWksTuNCohyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zdUcalK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5ce88b51cso66435ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707256504; x=1707861304; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7ZGfeGKBF9phLlyx19ES6xYPOfUrf5xaU9sp4daNKw=;
        b=2zdUcalKnn+YZXPv6AcKXdycEemCfZvBdJ9vPdriiWbyEE/0pRRLzLOnZO5IyCPfnW
         +BEa+wWHb715KWUyu6M7alCUV94+wYXI3Iv3CN3mWIjcOIj8pDg8nHqFt3YNpR8Vm9pW
         /j1I7Eigz26zfjCABeS0c6OxLiTHVqvLkEJRPRCNfums7w3V3KyJGq7MhLSJ7X+dw0CA
         WrJCIQJ/1Box0QKcj8L3jW8riGpYsD42Eg3NQov7bWAbOlG5VNk8BwpoTstuItCs3c7d
         1U+YV3PqR5a+Oq6t4Sk3YZd2OntOVwf1HphsyQWzZkJvjcX1ynN/x4xv2zalt2fBuJ6e
         +Cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707256504; x=1707861304;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ZGfeGKBF9phLlyx19ES6xYPOfUrf5xaU9sp4daNKw=;
        b=ZXO2goSGFeCHO8jtI4j1+UlcXBeJLEiMvdEo5gh0WQahMKdTOwwdb9N8lBnh091on4
         LyOJ9KxCUxgbrQSouamc0VPD+DScf1/R2k4kpcqsqrw3Qzim8TTh2khJo/k1SK22wEbf
         4mQJ67fDpcSNoDQLf15yRjzEHDOH1gQSL6jjVCjzqln3G0kUPDH5sO+xMTN8bCNgdNPk
         VmlFxxxZZIOye1NfIDjXXPfPEFqITrImT8STGdR8MnGXp0oHn2he6M956gGI2MU3J7Wd
         OUQdRgO6AihPiXzK9CbixWZXeMmXq5uPdoWczUjITkqOBMeNAJhi3oEWpWgkpbXqszhO
         sweg==
X-Gm-Message-State: AOJu0Yw4bxH/OjlQ0XHA0t4N3+qZhDLAsVzauDxHSnRF9nN7Pk4ldvBl
	P+TUvWBkCKfQok91+TuoKylh4QNl9ekWcH8EG8jI8lM8RwTIob5rEDPnQtHKQw==
X-Google-Smtp-Source: AGHT+IFYRO9jGoeeIUxY24jk72SGTunKWsLiaTpgQMlzZlT1t2VZ6kxjFAR/8b9FaHAnEJFvEs8kYw==
X-Received: by 2002:a17:902:fa0e:b0:1d8:f3c7:fb84 with SMTP id la14-20020a170902fa0e00b001d8f3c7fb84mr20714plb.9.1707256504332;
        Tue, 06 Feb 2024 13:55:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUObQLc/4P3FBfH/BPqyDhUNeLdxMrYSOG3pecENOwwdNFznpdcBmnjbxnVpFdNRnu0xWaonwksEgwNElqebVAI/GNBsrofreyAqqf6jPv/ITpIEbB8F6opVv9Io8bLouBvV372MZx4xinXIJXzpGOEOWnARXbYq1M5ceb/onieCS4xkUCAyVtZBWwmrDBd4EdbkbgRTmtnHDFIk4MSuzq8xjyEGHGh1pkO5tewBXpoIGuqBeQ9RsOPyjhaBkmNJdZEFBPjxV4niR8HN3HzIjsGqfY7V9jIohC5D+Otv8aLolMMzTiprCpRIVTEnFXNiYvY37JtoWXHSbCLp+ngAvs0Wd6NYIzaMr/VHHBc3JgCTc8ixgVHirsp
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id pl6-20020a17090b268600b00296df9fc8bbsm43356pjb.14.2024.02.06.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:55:03 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  Ingo Molnar <mingo@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Mel
 Gorman <mgorman@suse.de>,  Daniel Bristot de Oliveira
 <bristot@redhat.com>,  Phil Auld <pauld@redhat.com>,  Clark Williams
 <williams@redhat.com>,  Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH v2 0/5] sched/fair: Defer CFS throttle to user entry
In-Reply-To: <20240202080920.3337862-1-vschneid@redhat.com> (Valentin
	Schneider's message of "Fri, 2 Feb 2024 09:09:15 +0100")
References: <20240202080920.3337862-1-vschneid@redhat.com>
Date: Tue, 06 Feb 2024 13:55:02 -0800
Message-ID: <xm26cyt92r7t.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:


> Proposed approach
> =================
>
> Peter mentioned [1] that there have been discussions on changing /when/ the
> throttling happens: rather than have it be done immediately upon updating
> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
> for the task to be about to return to userspace: if it's in userspace, it can't
> hold any in-kernel lock.
>
> I submitted an initial jab at this [2] and Ben Segall added his own version to
> the conversation [3]. This series contains Ben's patch plus my additions. The
> main change here is updating the .h_nr_running counts throughout the cfs_rq
> hierachies to improve the picture given to load_balance().
>
> The main thing that remains doing for this series is making the second cfs_rq
> tree an actual RB tree (it's just a plain list ATM).
>
> This also doesn't touch rq.nr_running yet, I'm not entirely sure whether we want
> to expose this outside of CFS, but it is another field that's used by load balance.

Then there's also all the load values as well; I don't know the load
balance code well, but it looks like the main thing would be
runnable_avg and that it isn't doing anything that would particularly
care about h_nr_running and runnable_avg being out of sync.

Maybe pulling a pending-throttle user task and then not seeing the
update in h_nr_running could be a bit of trouble?

