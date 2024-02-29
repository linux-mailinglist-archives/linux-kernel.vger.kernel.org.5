Return-Path: <linux-kernel+bounces-86161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001D686C099
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14D9B211DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83B3FBBE;
	Thu, 29 Feb 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qBl/iyO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D363FB81
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187565; cv=none; b=NMd55eKfmConBltgCWGD5X/mhcRGjYpSbkWqIPAk78unPPXHMMtCk71TfuOqI2RZ1NCF+jf80NVRgxEcoqsoquth4LIEgzFtxfM17ZVssqRzkfNFvSbKaw0HslUw04HXT3Mehu2RYO+L0aDRhF0cU/6SpthwFb9w2JCoCqwN02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187565; c=relaxed/simple;
	bh=iPnDh2eSwYyolQXIzSqo4or2l70TWsuBZOxHkv+0ofY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmjFNlN5liiBO6RV8SToGay8m6tGnnD4pMyTSDziqe9davlZhroFVPXM6eCzVL9LZ+Ma3Br3KEAE20/LMa0LWfgTuaJrm30WQUb+Zs+fXZVum3/XauHzm8VCvs0HXRxxIeSoU08Q+YMw1tmZXy1GCLXIRu/fcjJY8vb78R05b3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qBl/iyO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4129a748420so49745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709187562; x=1709792362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az6XEAS8FztXooX3dZ/R7i89Xfel1TOOflgq0AVQzMY=;
        b=4qBl/iyO/T0H0UoDHiRqsl2W/kUkjVUai8LhWHRNUPx007rSVBL4j8gESuOpUnUwuG
         vAwPj2HOY6AqoMsYERPYx/fbWe7Y/4QOjZJ8jBRrJaCW7FvMqRUfSdB7CkrpkQ882CLm
         uuFTmHtpo7J8iI+tyIE+i6FIXenVO/mW+PxM8qv7PJ6WPEX3wf+T4aXLYNYPAvkCbgm1
         9v5AnIQE7i/NHAqSCHXGJ24xFblHQXPKmVWGH5Mqwkgw3M7SG0NkJchTtEfg0jnJIMYb
         85CwXN2zTarvY4krWPnomTRjL4H2gCYKV4WdM2emv+PkSDOIuWjhtj1GFCVLrTxJ/tqs
         agqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709187562; x=1709792362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az6XEAS8FztXooX3dZ/R7i89Xfel1TOOflgq0AVQzMY=;
        b=iH+/6KEMDXBFAfPUKGTI4kqSEi88jf1cJHW7WSZJZ/LTvRlIirLzafvb/56zQV2/zr
         2fRGlF3tBBwORXpAW/zpj4n2R/CtS/aMNcLi/L9vMVifVPzmJ0+QscmaW5a86ACS7qyV
         qHl62IWPLAi9z77KoPw37OQK0N+yWnFArtp6dGCLpfE48UVbOWjgod6HtJ86zY9lKlse
         dXUEPqfI/dUnG3MpVtlMrqz940KhnkQvW7AprNNweo2kt3yVNKFejJK9/2+qKtmC31p0
         O7dkmynj04p3T7SVOPgh9w5Z/H4UzISH5/Jtpy68qHT1IC41fMYIj7HtGj07KlAFm3ds
         qmFw==
X-Gm-Message-State: AOJu0YzrbN/vCmex6YfwmzBH1pFgp91mL0xAOhXuNtPsBuydX093xgIm
	HJEpds5E9QEOWa2drWHri4w6mP7WAqy1ooxihPXkaJJMlNw6EQlIRKBrHDQxo0WbFzgNMXs2wkt
	rkeop1hgm9/oB0NQvo0pnYeJVYOmiYUCRyZk=
X-Google-Smtp-Source: AGHT+IHxU3lNVb+KEbbHtRkZi/Su2QeRX8s4v9UQD/UYWqCApILHWYh04nN5xkJ4dG3es+WCbokG/7BqZHJGjsu+B3s=
X-Received: by 2002:a05:600c:3d18:b0:412:a37b:4171 with SMTP id
 bh24-20020a05600c3d1800b00412a37b4171mr74567wmb.4.1709187561622; Wed, 28 Feb
 2024 22:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com> <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
 <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
 <0c606d04-6765-d55d-61ec-c3625daea423@amd.com> <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
 <c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com>
In-Reply-To: <c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 28 Feb 2024 22:19:10 -0800
Message-ID: <CANDhNCrkXF0R1Otu_EKY6OHxnAOYUQ+UjaQsJ_mW4Ys4ELPcYA@mail.gmail.com>
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

On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM 'K Prateek Nayak' via kernel-team
<kernel-team@android.com> wrote:
> I got a chance to test the whole of v8 patches on the same dual socket
> 3rd Generation EPYC system:
>
> tl;dr
>
> - There is a slight regression in hackbench but instead of the 10x
>   blowup seen previously, it is only around 5% with overloaded case
>   not regressing at all.
>
> - A small but consistent (~2-3%) regression is seen in tbench and
>   netperf.

Once again, thank you so much for your testing and reporting of the
data! I really appreciate it!

Do you mind sharing exactly how you're running the benchmarks? (I'd
like to try to reproduce these locally (though my machine is much
smaller).

I'm guessing the hackbench one is the same command you shared earlier with =
v6?

thanks
-john

