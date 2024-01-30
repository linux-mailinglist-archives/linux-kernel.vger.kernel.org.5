Return-Path: <linux-kernel+bounces-43656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BC84173A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF93285630
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7329833CD0;
	Tue, 30 Jan 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nd6sOV0o"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4ECD266
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572907; cv=none; b=Zk+KYvmAnD1FahxKRM27mPzyqKzaVYfRABFvzE1utUx//1vBN7/4ft9NpMq0PXDTiV9RokPTkKC5lzqa+6sqTfbnEcd5sr2fuCkS3rriPOgY6BWhDdyG2wPvxhTagVoChywzbfq6zAtV8vDQUv9gJ1ceZO8v+gT7sANtjLjOSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572907; c=relaxed/simple;
	bh=mP547cxSLBLqbgPFiU7KdWOYk0hFrjdJ8bs+VrkDQz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYyTbGfsrvEbU8wRRzWplY0IMWZ/s06fbvQQJNmp66bqfxvKH7lCFbsmgenybyxcpYwwlNpyQIhsF0wNdjKR0yFFX4A43rB23rNHeKtWGLvhuVMYkxoGXwBKqxGWQefCrdPgyBnreFwJSNne73G5RaKuQixmH59ojnfU6sEeSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nd6sOV0o; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5111afd0dbdso102459e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706572904; x=1707177704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCN62biQQqn1jm8DGkvLeUSFirrT4FwO2mAzGrxaTQ=;
        b=Nd6sOV0opppeLnDP7fGPn+CL/anUKw+fc4t5dEm2Qvoa0fqt/xBKiJHE7n1YPudZ9y
         Q4v9USVJNTMzHAhBX8d2GMzQH87sBN3SNPeTrwzpQGgPCJE2e/r35HAF2CWT1N31z5gz
         s1YF5g30uLSorPbqIC9/GuOwdUQfo5+2QYTWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572904; x=1707177704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnCN62biQQqn1jm8DGkvLeUSFirrT4FwO2mAzGrxaTQ=;
        b=MpSBTHMHm4+D3/N9ANH73awr6lRsODSqA9wtFKcJ6P+iFMo7VPMosbN12f4BNPPOwe
         4W0e/+2cgHXg7v0L1iKeJWfpA8Dz3t+CqsTHi/SJj7/SaB2AkiCJlmVaLu3RxS/R0voR
         U63ovPcG4Xuymf+2B4sioq6kETyfTKWkKcPp97JsIuMJLQiNfS6RBCwrzR3oEgb4iFyQ
         esYm/LxoLH7MmS8GOJr8K6TP4P0Gks3SiCCQyZiqbEz4lbaQuXaG+fqBZuyAlxORl2ep
         VSxOetdeEduerbD8mR+HKA7hFJnIFzrS+XPBHv/rJsnrOBCBfJXkzy6lZdBgU4ClaasB
         qbSg==
X-Gm-Message-State: AOJu0YxIKlCDRr+j81W+o3gMjcmM59SZXNVuwznl6x/xCk69OtOLzVvc
	4DYWzrwgEYupgjtyZL8VJAAizYKUubjVXt/xYJQloJrppn67svFsR8TN4eryQ9Uy8fScjnHIV0F
	jDqY=
X-Google-Smtp-Source: AGHT+IFhbweq8VZ6Grz97W5fVhiGLDBZaub4qstp9nsbL1HYuKH8VH1HpY9gUug9yWnpQFEWn5dQ5w==
X-Received: by 2002:a05:6512:3e19:b0:510:cfa:31f6 with SMTP id i25-20020a0565123e1900b005100cfa31f6mr5169252lfv.35.1706572903690;
        Mon, 29 Jan 2024 16:01:43 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id r6-20020a19ac46000000b005111b00c428sm21321lfc.192.2024.01.29.16.01.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 16:01:42 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so13585561fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:01:42 -0800 (PST)
X-Received: by 2002:a2e:80c2:0:b0:2d0:4c65:f09f with SMTP id
 r2-20020a2e80c2000000b002d04c65f09fmr2384103ljg.7.1706572901982; Mon, 29 Jan
 2024 16:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com> <20240129174950.5a17a86c@gandalf.local.home>
In-Reply-To: <20240129174950.5a17a86c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 16:01:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
Message-ID: <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 14:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Now I didn't change this last d_instantiate, because this is not called
> through the lookup code. This is the root events directory and acts more
> like debugfs. It's not "dynamically" added.

Ahh, yes, I see, the dentry was created (as a negative one) with
tracefs_start_creating() -> lookup_one_len().

So  yes, there d_instantiate() is correct, as it's exactly that "turn
negative dentry into a positive one" case.

I'll go see what's up with the "create it again" case - I don't
immediately see what's wrong.

              Linus

