Return-Path: <linux-kernel+bounces-141651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D18A2130
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388801C23E20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAD3C699;
	Thu, 11 Apr 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffomuWUC"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA539AC3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872602; cv=none; b=ubIy+qWR0pLTtYm2FsdumdUd9+gK5n6R+IbIRiPfUa8Lvy5e/i990dfu+9c8G2a0sJqJ51SoASW/oiu5bhXLn57f2YVfeHEjuFW1/Bn5qHtVC/X7sZYJrTKaXDxfzqYjKIGpkIHN2C5jqQz3Lv5atWn28LOtFlifIx6vArT5aCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872602; c=relaxed/simple;
	bh=5IskHx1Alp47+xsPcKeN3SCTGFddMnlcEHREVJpqLRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxHzFsHmJ+epsxG6F40DJesBJIldX/EoO+NH/ezKLUr0ld+5PFXoBBv8jV9pZt2ilUoIhZ80toCdw6RjQHNSfs8HyrWfGHiapDRRxB5Qfas22D/O2kDoaNNzaKk2o5J2k5JqBr3GRZxfwaYMuVuY2qQFau+xQ/ZFTAsWmJLNULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffomuWUC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cec090b2bdso221669a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872600; x=1713477400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7nkr1/AkcgDi+i114FYV92kBj0GcgXVLsLHaB4i3Q=;
        b=ffomuWUC57kRC245jJ56gKBxolzmpFuvunAO9TsWS0ivrYTLgWPk+GCsXGuJfxqJDJ
         uXpkH4vGXaRZ1ZPH4IxtKHgZHb3Hilll9pR+mDnV6TcU+vlS0DSZpZy1V4Dymb6fIHG2
         trpgoZBy3YnHSOqVnEqkKwrKTf8SfheH6x2v1Hxp72m+ctRYAxy9VFXJwjlo6N7fLfgE
         Dkoys1PDB4CU5CHfq/6iGUipLWCw1CoNa+SMEub2PQ7XU6pK+KBlO1Bxxnr1OFs4XHeQ
         wwoT9xXlZWq6YzsCIDT11Z1lOUHI23TWIEz6hlazTsx8zddu7uuOagTYlyLqNcGBrgRa
         38mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872600; x=1713477400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l7nkr1/AkcgDi+i114FYV92kBj0GcgXVLsLHaB4i3Q=;
        b=q/lymTegSjUwpZAhhWYsoyR3ECgdXarxm/7+qO9Yxblms06Sh+oyEjpqIuiK3J38k7
         674t8Zs06bVXShPDCXEj8x7EZgeAcdWOmnvgUVFZU+kcGz3ggnK3m4FUiXGs5kMcd9YQ
         gRhAt+xyoHxu+fnOpTi8VZFQGw4HqamogLlXwah6pojPav0vTy+kZea5HpvycZj3uLFc
         a5esonDuAxFqpNA/KX5NilPgMQ2H1zqVOG1ti4JGCLkvxDZ+45V3KYkc/FWNn4cmS8Sd
         RLixHFz3oXE8ppR93OgdDAyXCpl96RchB1nJ+aEg+BrPI+RRCtkZoczHJ81ksLmAXzAA
         0nKw==
X-Forwarded-Encrypted: i=1; AJvYcCVI9dW9IAc5dhy7y/xgARBBpRQ+AlQYCmKUdfH6U9wVE3+QdI8pC9Ksyp8ankRAx2BLN9UpOCKgtXCGihU3ZpndIfImrPG+g+Qj4JO9
X-Gm-Message-State: AOJu0YzfUpLqMuyUeGoYgMg3Nr5oMOUppgVFCMAzHZwObzQC6/mJyWuN
	FIBlVn7vNgdP6I+EvMLniKFwbCljuiHMz7hzCYZwtX/GArkNVxG7DNTsrTE/Ki8UbMvOBh/R2WS
	qJw==
X-Google-Smtp-Source: AGHT+IGkE+X2zxbr1hHNUpWg21uobjE0x+B1Mp3y6MyplpSZTK7tHQrQsbMRcsPEdX3tPdwzxY1iWabyoHQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7157:0:b0:5f0:5034:1c21 with SMTP id
 b23-20020a637157000000b005f050341c21mr2010pgn.12.1712872599915; Thu, 11 Apr
 2024 14:56:39 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:56:38 -0700
In-Reply-To: <20240126085444.324918-37-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-37-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhhclu4VP3DDiPJM@google.com>
Subject: Re: [RFC PATCH 36/41] KVM: x86/pmu: Intercept FIXED_CTR_CTRL MSR
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Xiong Zhang <xiong.y.zhang@intel.com>
> 
> Fixed counters control MSR are still intercepted for the purpose of
> security, i.e., preventing guest from using unallowed Fixed Counter
> to steal information or take advantages of any CPU errata.

Same comments as earlier patches.  Don't introduce bugs and then immediately fix
said bugs.

