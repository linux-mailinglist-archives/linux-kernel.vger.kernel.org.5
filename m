Return-Path: <linux-kernel+bounces-59125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A267E84F199
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549541F21D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0B6664AF;
	Fri,  9 Feb 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7ZBFdK/"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F87664A0;
	Fri,  9 Feb 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468488; cv=none; b=eV9bkHLolXdsnk1jR1LI+6Ow+xNi3QgpXNr9T6mt+tA1R35io3kMfygSPVOQvG7SrUFjLBS6IuytS3ATl3b360dHpMoS5WaMXQJkIkH47Yk1PUFaWQB86ZmCzmPtRIkb0NI1+RfWNq24v3t/JA7lkMa90mp8aGpXQgwG0eeK/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468488; c=relaxed/simple;
	bh=haLUN7R+uEbCYSEcvemWJ6LTlCsNN/ozcuoqJs+zR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYBDpL0ZH/014tNZs2CcMAu16ZJ8UfhF+x6p7FuWBf0p0AAztq2dm0/wPE33An7SvXRwH6Q1NL2KvlWpBLgGyaoPZwREL/2TP9DkB93nTn1Fdgbn9nHwm+Mag2A05gnIjPFWT6Nru43GpxncEBbTxcPo9uS9nbWGyx29rh57kVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7ZBFdK/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604b4eed8fbso8945247b3.3;
        Fri, 09 Feb 2024 00:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707468486; x=1708073286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4X+ngU9QoX7tppy+JrDNluZ2QbKqQksWlcB4S88moY=;
        b=c7ZBFdK/H1QYGBa/NKIXy7VjiV6SEF/Lh8MWPubZA9Dua5azqiLSrtfQRy3ckyLNx6
         dBNJUWwJOxnGmekAbuHKe7GjoZAJF8ybEdgeZU9nzwNdoXiki+3bVXj3lVUM0oVwEHJt
         Ne29pxVTxQsh+hl61COSU2wx5Gw5bMRO5ZjiZSdLmZZySGDsOCgXmG3FIoU8ydJMWMnl
         9dMqH1NwzeUovaXGmy8z46TF43Tioqrsu3KLS8UZEdhAFQzohtXpddsdvdrcwQJ3l1Bu
         me61hESbiRd3MwjdKHudyfIA9yOPzgmTFnZoS+OGdPg+P/Cjo4dUNHmZ3pQJXdpeJOhw
         VRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468486; x=1708073286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4X+ngU9QoX7tppy+JrDNluZ2QbKqQksWlcB4S88moY=;
        b=eGYmpWl8kmehBVMLY3RD1aWyT1hHaOIx/Srk1xRcaC25qmuDaZ3xwEO7DCcwzZ6cJf
         MaGy4wWdr1urBE1AHx1W5fds6dSknk2KplIV3l/tWwwDmFssZTAGzQHC+6EbNTl05WvE
         f8bfS0Vmydmwn2SJrQWtRS5jwZiOoDScMXsAsG6KHePz9epCr7Fu7iwy7CwUqfbEEu8Y
         iyU17Lk97HSOWpWYfvck+M/FQ8REywTMcfIx5MV0bf/i19Iq7GKsXtFGvn68JqaVsu3c
         kObKvq5BqmjI4Ja1hq0WS68vsYHNUaPV5jy0jsxYTSySTd8LwVxIr6y826qdSlYGv7JO
         vL3g==
X-Gm-Message-State: AOJu0Yyw9lRw8WvbwKqtsnjEzkLzcYWVyXUdavwLgbTsGpRv46AcOrzS
	F9twqwU0q9Gzdis0RIg2IdbypHkj/TS6M3uUx5HDdzvtK8zjWMQf6KGc37A4GEZ6eJio2YYKxIu
	m4TqFEt+B2YFGvBqyzlSsynf2Upk=
X-Google-Smtp-Source: AGHT+IHacsUoykyK/Xzhew8S9DH/qcqe56uRZ7Ki/ZjriyE579jFB3oBz+11XErtNjUUlvzDVce5727bOy0mYS2qjZk=
X-Received: by 2002:a0d:e401:0:b0:604:7932:b9d3 with SMTP id
 n1-20020a0de401000000b006047932b9d3mr804775ywe.47.1707468485728; Fri, 09 Feb
 2024 00:48:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208162748.111120-1-vincenzo.mezzela@gmail.com> <87r0hmfuhq.fsf@meer.lwn.net>
In-Reply-To: <87r0hmfuhq.fsf@meer.lwn.net>
From: vincenzo mezzela <vincenzo.mezzela@gmail.com>
Date: Fri, 9 Feb 2024 09:47:54 +0100
Message-ID: <CAF2+nmZMOkti71ZZ6P1RB=4XYO5SHW2fA5hWscK0krqoP7Cyqw@mail.gmail.com>
Subject: Re: [PATCH] docs: staging: fix typo in docs
To: Jonathan Corbet <corbet@lwn.net>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 8 feb 2024 alle ore 23:42 Jonathan Corbet
<corbet@lwn.net> ha scritto:

Hi Jon,

>
> Vincenzo Mezzela <vincenzo.mezzela@gmail.com> writes:
>
> So your fix is fine, but I need to point out a couple of things with the
> changelog.
>
> > This patch resolves a spelling error in the documentation found
> > with codespell.
>
> If you look at Documentation/process/submitting-patches.rst, you'll see
> that changelog text should be phrased in the imperative mode; no "this
> patch".  I tend not to be too fussy about that, but some maintainers
> will reject a patch out of hand for that, so it's a good thing to learn
> to avoid.
>
> > It is submitted as part of my application to the "Linux Kernel Bug
> > Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
> > Foundation.
>
> This is interesting (I'd never heard of the Linux Kernel Foundation),

My mistake, I should have written LInux Foundation.

> but it's not really relevant for the kernel development history.  If you
> want to put this kind of information in a submission, put it after the
> "---" line so that it doesn't end up being committed with the patch.

Thank you very much for the corrections, I'm still in the process of
learning. I will pay more attention next time :)

>
> > Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>
> I have gone ahead and fixed up these things and applied your two
> patches, thanks.

Thank you,
Vincenzo

