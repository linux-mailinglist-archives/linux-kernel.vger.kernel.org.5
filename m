Return-Path: <linux-kernel+bounces-155597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241908AF4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A071F250BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7013D638;
	Tue, 23 Apr 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpPhimtb"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DD13D537
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891086; cv=none; b=Oh42k7f7OmcKUcFzLPkh61tidIiRPta6RX+igA1ehV6tRWcpeSXete0K9mw5PqM055lokaU1R53lpKaR3oUskVeSoICbOsPNdhP9xypBA2a8FSnu4MqOiieYbHPE3wnzJIEV4yeMzw+daRO++EnBTWAztDepKqEcBek9cBpOB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891086; c=relaxed/simple;
	bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah68MZduEdqMEsgM2LraT1r97wwqxDvi1gAfqmpATK48GCi+oWdW3sf7o8qI18nr84Vt1LIjZOGCl9XhL3xxbaOEYVwWxZ4XQnWA/oY1lSivdmwcpLzQttTpy/2QKM2AY6sNJqXnVZOEYmg6sS11Y3bGjMLSshA7cXkrDFjIQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpPhimtb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso7453453a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713891083; x=1714495883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
        b=FpPhimtbwTbG8zHDLO7JzciMv2Nwo2AywCncPzBYhjcRP//m55sLeIZQhJFW2AhZgc
         nXZdl2xoAbKSOgNO8Eqc3hiHMT9D+YFkvFx43YNLrGiC3cXP84LszpQisEETTLBAp8cl
         TZpXXvalNbMT8hSXXhXV3NjYUl15tHE3nhTBcLdbJ4CK09nkeU6Hy8i+PCXvcMmRKrzm
         Wwv2qPk7//H2lOmm/M5dq665zAAqEp2POy3S2nwzg6HBKT6OO8r7yDqehHSmFYTQ4pre
         eagIovl1F4WXt12lSuMJaighnAKAvbfHTHdq3TmWySkYkf/fKA7RBpcVf88owckqXt+k
         mCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891083; x=1714495883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l+5UdzN7ZbavXU6zUsRnpsRb/FYFC3ss2jaeR0uYUU=;
        b=MVYzcuWu3cVl6mG3eWCDJ4wQxVS6xyHhyJzmpcJgbTEdPqF62mL3K1GiwZhMO4w4jg
         n0ZUuoUn/C7pZ5stAOTA+LmY/rqT2Aa9/nJomzqwSFfZcwpm/KHXmM2e9zKLL4G89QiK
         3TIvrCIhQ4V/57uQpt59j/3A3bCwjzldnVznNWL2bOp+NhuQnE2XhRB9hDUX5hiFVNdc
         /A1+B/3GdmJ0MoxVPhwWvhF086LfxZi2HRLvj0GNVaSJmA7Wn7ywqD5HyuvWADys6tZw
         BJTCRNrZjADDYTW/avFj5CSfC5SmOX+9FJLR/eB8WkQTD036+S5kh8m0OPTscTxQH6Ow
         SBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUheeAwZxC801zky9wvmZ7SNdvVXLOJ6fzDu9aRhyw7z4PIN5w1m+4XF1YfeyTTgMt4uT6c0NQnq+DGAqQL+KGtTAK0JyPLpFJFek+o
X-Gm-Message-State: AOJu0Yz/kZ36l61szPPbV/ozl82ayMmJ8RdeuPVxIr5WDhXX+mCl1Xnf
	bsrGoUGpMDN5xneaSjLe8/4mVTDBiql9N39mFd0qfqioQb8gb33myv4VqZcIe912gUelLsZ7EwV
	+HqJ6j5MtgDmjL/zV/j5YOiz4xIC1mPrh5AgI
X-Google-Smtp-Source: AGHT+IEUYXbroPWIegwIe9uOSMKwRDxhQ+zZsIaEyJugWTF5WG0C5K8peKi60BHk1tv+7Q4IawZ95Nmnfs8+lJ+y+Pc=
X-Received: by 2002:a17:906:615:b0:a52:3623:f498 with SMTP id
 s21-20020a170906061500b00a523623f498mr10162882ejb.31.1713891083421; Tue, 23
 Apr 2024 09:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18b19dd4-6d76-4ed8-b784-32436ab93d06@linux.intel.com>
 <CAL715WJXWQgfzgh8KqL+pAzeqL+dkF6imfRM37nQ6PkZd09mhQ@mail.gmail.com>
 <737f0c66-2237-4ed3-8999-19fe9cca9ecc@linux.intel.com> <CAL715W+RKCLsByfM3-0uKBWdbYgyk_hou9oC+mC9H61yR_9tyw@mail.gmail.com>
 <Zh1mKoHJcj22rKy8@google.com> <CAL715WJf6RdM3DQt995y4skw8LzTMk36Q2hDE34n3tVkkdtMMw@mail.gmail.com>
 <Zh2uFkfH8BA23lm0@google.com> <4d60384a-11e0-2f2b-a568-517b40c91b25@loongson.cn>
 <ZiaX3H3YfrVh50cs@google.com> <d8f3497b-9f63-e30e-0c63-253908d40ac2@loongson.cn>
 <d980dd10-e4c4-4774-b107-77b320cec9f9@linux.intel.com> <b5e97aa1-7683-4eff-e1e3-58ac98a8d719@loongson.cn>
 <1ec7a21c-71d0-4f3e-9fa3-3de8ca0f7315@linux.intel.com> <5279eabc-ca46-ee1b-b80d-9a511ba90a36@loongson.cn>
 <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <86d1f6d1-197a-ecd9-3349-a64da9ea9789@loongson.cn> <729c4b30-163c-4115-a380-14ece533a8b9@linux.intel.com>
 <CAL715W+BpyX3EeKr=3ipMH8W30wmhMkxg2Fx2OET9cvQ480cgg@mail.gmail.com> <46a889c4-b104-487e-be3e-7f4b57c0b339@linux.intel.com>
In-Reply-To: <46a889c4-b104-487e-be3e-7f4b57c0b339@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 23 Apr 2024 09:50:47 -0700
Message-ID: <CAL715WK60PeB5kmStfKq9pFb4CMf6DL5hjM5kMXEe+5yE_e_gw@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: maobibo <maobibo@loongson.cn>, Sean Christopherson <seanjc@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, peterz@infradead.org, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, jmattson@google.com, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"

> > Is there any event in the host still having PERF_EVENT_STATE_ACTIVE?
> > If so, hmm, it will reach perf_pmu_disable(event->pmu), which will
> > access the global ctrl MSR.
>
> I don't think there is any event with PERF_EVENT_STATE_ACTIVE state on
> host when guest owns the PMU HW resource.
>
> In current solution, VM would fail to create if there is any system-wide
> event without exclude_guest attribute. If VM is created successfully and
> when vm-entry happens, the helper perf_guest_enter() would put all host
> events with exclude_guest attribute into PERF_EVENT_STATE_INACTIVE state
> and block host to create system-wide events without exclude_guest attribute.
>

Yeah, that's perfect.

Thanks.
-Mingwei

