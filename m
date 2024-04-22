Return-Path: <linux-kernel+bounces-153741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C248AD293
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821CA1C20A38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BEF156960;
	Mon, 22 Apr 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Q6llUcb"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56608153833
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804186; cv=none; b=Cc+eBn1WEE5P6v5xZfBY63sYYhiTkIIlp2qMj96SScu6GGpwmcskYf6LG4+OvyMqbQ6SLGAyI9aECtrltviM4IvoZoA5S0zUO8cZJx4ui3mlM5J0ntRKt3/XUOxqsjZJFf4bUkJOF3XVgLkMACV++i3GGlcmHDvxhsk3zOkTk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804186; c=relaxed/simple;
	bh=W0yzfhfuOWRG48vfO2uc2QhFbbA7xV4C71B5Bgu9HaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5X8KT//cuEiXhig0/fttwOSsWN3Fz8ycb4amRODYK8Tw1/psPGdHfiPSXeQg4HKjS3NgbR9657Xp5MreR6Nz+oid9r+YOjtDde4wrn0ou2Qyc9vo5EQ72g2HJe1ODeLLHXFBOAI521Lf9I4h9c6tzXn4oyG6UJagoJ85DcawQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Q6llUcb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f80a9e67easo2523942a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713804184; x=1714408984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0yzfhfuOWRG48vfO2uc2QhFbbA7xV4C71B5Bgu9HaM=;
        b=4Q6llUcb8/uOzEzXKUtQlobRkCcCvsk6ayNmr2zbVDc2KPRua6+L2tfA8vHLN76GF/
         +WjQnYp1pQeAhfEbERWrFqQjXXltgcxw79t/H849brVSmdhFfBc/7oUpMd7mVmS4giT7
         61ujjKKbrB5lYI7wsdU4A1WOQvbFVPN+khGoPFYH288yOnGOIoFIEiJFQkn0xIm+pl0W
         xN4Dxo2ehUt618UMnA6wQuuoKYfqi5wD8Iah9Fo0xk/3JXUyNmiG/ElN7Scbp9gi7A2a
         WfoFGvDuI+UYOq7XW0ygKOeLldFehRitoidjfKG2eYLpW49eL81Z/Lw9R91uAAHSt8Lb
         AmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713804184; x=1714408984;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W0yzfhfuOWRG48vfO2uc2QhFbbA7xV4C71B5Bgu9HaM=;
        b=K0irCx2QW1/0EazoG4vUns/PiidrKFdbUWDoyrdbr/zZFDtocHwg5Zglh1+INLBts+
         mod9B6pVGg+F9js8zldLr81TtZ1rf41fg/qviu8l2mFO7U5mjxObW9C3lMP3C5mBNzql
         jJJyOQSq86ONv6E5NeWsNynhocAo1KvrsLOihwQD4j82M1h0oN2MgvBc1wnp+WrTuquZ
         hLN3ZxR76poFikfs/5uLUfSg1AlnxbReuUvTuqjdj1RFJVqTVCsc9eWlk1n/aIeWeUHW
         9AHQDTj0IX12khCVAQiRC0nEtzr4LjjfwVY/IRMPdqPUjLrRoWXl/vZQ+NDcyNXmg98D
         CzfA==
X-Forwarded-Encrypted: i=1; AJvYcCWTJ3EpseWu6oWODZXAGlY57zDXh7iTJlI45tbMvg+0czmqSWrtoUy8VigN2yPRs36VXnzb3//4KjwOBrgMqfABAOh2ouO1bHbeECGw
X-Gm-Message-State: AOJu0Yw6zpVqbFtiwX6lzxpqt5PejJyhh5sNCQn3YQJz04Vg/TRYde5S
	ZsIwVBt+LkcdhgzrOnqCzx6Koz2Mxu3B9HBHpTMcCgwkBHxtV0AobjMPu6H4EESXuF4/l49mfEb
	CPQ==
X-Google-Smtp-Source: AGHT+IEFcksLzHH5JKr/NUVsr1fzHoMgdfGGB/GsRlHPV2YtBF1HsGG88PhYVKBgJemUvdMBqI+HBqcpDqY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7018:0:b0:5f8:610:84f with SMTP id
 l24-20020a637018000000b005f80610084fmr24359pgc.6.1713804184480; Mon, 22 Apr
 2024 09:43:04 -0700 (PDT)
Date: Mon, 22 Apr 2024 09:43:02 -0700
In-Reply-To: <CABgObfaaec5JmLtZ+OJ7NuX1zGh6_dSQ_n7-8K=LtEY-ON-dJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419112952.15598-1-wei.w.wang@intel.com> <20240419112952.15598-3-wei.w.wang@intel.com>
 <CABgObfaaec5JmLtZ+OJ7NuX1zGh6_dSQ_n7-8K=LtEY-ON-dJQ@mail.gmail.com>
Message-ID: <ZiaTloh1_a2LtUEg@google.com>
Subject: Re: [PATCH v2 2/5] KVM: x86: Introduce KVM_X86_CALL() to simplify
 static calls of kvm_x86_ops
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024, Paolo Bonzini wrote:
> On Fri, Apr 19, 2024 at 1:30=E2=80=AFPM Wei Wang <wei.w.wang@intel.com> w=
rote:
> > +#define KVM_X86_CALL(func, ...) static_call(kvm_x86_##func)(__VA_ARGS_=
_)
>=20
> Just
>=20
> #define KVM_X86_CALL(func) static_call(kvm_x86_##func)
>=20
> please, because having the parentheses around the arguments is a lot
> more readable

+1, the more these look like function calls, the better.

