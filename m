Return-Path: <linux-kernel+bounces-138603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843C89F44D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416E8281FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C51A15ECDF;
	Wed, 10 Apr 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5q2o3oi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F415B153
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755802; cv=none; b=D3/4DX46DGr/I+hM8rFMFvOzOSMGoAiC1PyqsWb4JMiHcgnBD2CBiZRZ5eCflKvcrhniXTPOk6JmLDu8wPgHlgydeulrCnkvPX4SlQ+854PsQK9VLdal7hqYEOGIb9fSNLlEefntG4Wc4r24aN2zA5mBSbcaRhdgBrB49FpJn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755802; c=relaxed/simple;
	bh=8zjJ6ZBa1WPpcfT5AqTQ2kfZwxMK33wI+BmE18967eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV/seVG7SrJjAufl13ooQur/vK44dlO1ysG6gFFEmk/ra/lgo8c/nIwX4u+wcVs3MewnABlUEqoOtxv29E1TwjiOIxLSXcqIJ6KEbbapEEE9vFjofmHc/oEkpG4xegZi3DNyQLt5MAnV0kFSzeb3+sp1zbsQ0lrnjHHUNELneoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W5q2o3oi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecec796323so6296166b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712755800; x=1713360600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+ZKdreMATSwQqMGT62EKEHEgtqgyDRXS0nrvXJUw5Q=;
        b=W5q2o3oiVaMt5b0BdkNgqIY6lWwesK7W1BG48miUOeO+UTgt1ApPjGq6IlPhyL6zUK
         tFj/KnDBIM4aSjIdeaGi3bPZl3CqeTCf8xz5DIGb+bgvgqWYwVGlByGK74KPkcrQ6JUV
         2XcDnmpN8aTHilMz3MeBMyirnFe732diHSJGpjn7PX4fNyFEVn/KEhPm54ovxCJiUhBI
         axaGd7aBbbEoei6Rm4rd9MJOa+KdAvTMAGhW8eH2BxhMvq/HW1/FL0cuXpRR9WKSGRf/
         9Q7frzsFXXe/2zJ6POPfJnxfi36fruNQajhv4lcOM6gvH/WYR4fjlSyHEU3SUvZMPOWJ
         skTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712755800; x=1713360600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+ZKdreMATSwQqMGT62EKEHEgtqgyDRXS0nrvXJUw5Q=;
        b=kgdwPVK5lT3txJgHIcgsrbzHxZ+RyGKZHY9Xh0GfTkiTeznSLAXIuLXBDu7Odj4Gue
         SJ84jUm8QVQx7oGcc2R8JIhgv05z50l2vo5Qvjh87FZP4o44XGFrDxaqqEgLSL5ERQhq
         vd3H+gMCV46jnCO1Y20xhWKSGoBPB3PPbCnXXX8ts6Xk692W0sUNPv3j/QpaFWIgT6xZ
         br42JquIwDQ35xM1qrp3971eZuzSkK4t340IBZSQFgjPkDotjqRd/TzQJymf77xEpuEe
         I/NvO28OemdwLVOrhCuopTACjiaeI2zqs8v6wNC09CviA+5YbyfBv+VKvEcEZAasIH//
         21pw==
X-Forwarded-Encrypted: i=1; AJvYcCWDnTXBLmDXlVQ9Yw47YJUCQdG2mjbMLI+YGmWiHtryCoz09UcgT55UMQGVknPBi980T4QgdLTxn0NwjFV9slj4f/uPFlGl926hxlNE
X-Gm-Message-State: AOJu0YweZLTNO22Kuw2oi1Ji27hba+n24g4Yl/GiHT8bu0mxaedINYhF
	dNfyCHEZq0gEJCIiuQk4AyIXv+B0cCO9WjaQu++QXS0vNLOCHqRUfTfkHYtNq6XBhpnzdKMpB7+
	qQiG3LEK5O5AYHiNVo5sgaAHEFoTh4Scf3ibZUQ==
X-Google-Smtp-Source: AGHT+IFkpir98n+iHWgeoq34noWYibeJrXfqpQ5TomXGbZcGlk3Jq5i5QFghljhQQlx6S174fWjHkA+6Y8JCP1KmxLQ=
X-Received: by 2002:a05:6a20:3c88:b0:1a7:58ca:cdf3 with SMTP id
 b8-20020a056a203c8800b001a758cacdf3mr3482363pzj.8.1712755800460; Wed, 10 Apr
 2024 06:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net> <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
 <20240410114609.GA40213@noisy.programming.kicks-ass.net> <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
In-Reply-To: <88144494-33f1-4f43-88c0-885ea6b87e07@redhat.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Apr 2024 15:29:48 +0200
Message-ID: <CAKfTPtDbXZbCR9u8+Fm1d05Z+rAnxn4sx5WXbA_aKyRD5GDzfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Atul Kumar Pant <quic_atulpant@quicinc.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, kernel@quicinc.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 14:24, Daniel Bristot de Oliveira
<bristot@redhat.com> wrote:
>
> On 4/10/24 13:46, Peter Zijlstra wrote:
> > Also, we'll be replacing the throttling code with DL servers 'soonish'
> > at which point all this will stop working anyway, since DL will preempt
> > anything FIFO, including your idle injection crud.

The DL server could make things better for idle injection as it will
let the idle RT threads running on the CPU as long as there is no cfs
thread enqueued whereas the current rt throttling force throttling RT
even if there is no enqueued cfs task. So as long as you have been
able to move things on other cpus, your idle rt thread should keep
running.

>
> +1
>
> also, given that the code spins with preempt disabled, with dl server it could
> even become a non-rt thread...
>
> FIFO RUNNING
>         DL_SERVER activates
>                 their loop
>                         disables preemption()
>                         run()
>                         enable preemption()
>         DL_SERVE throttled
> FIFO BACK
>
> So, there will be no need for this busy loop to be RT.
>
> Anyways, it breaks RT and DL if it keeps running for too long... It can
> also cause complaints like RCU stalls and loong wait on locks, e.g., on
> kworkers...
>
> -- Daniel
>
>
>
>
>

