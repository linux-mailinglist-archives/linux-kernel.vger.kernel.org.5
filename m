Return-Path: <linux-kernel+bounces-141597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBF8A207D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD392827D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877902BCE8;
	Thu, 11 Apr 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TY8ZXoB7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6362941F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868883; cv=none; b=QIl6pbnQRDPUjFvKs1VXj12YgLAzoG+ZrGjHf7V5ypZVLW3aoBB5ylAEGEJg9RxVnwc7FUAXjcfeiZ20I4dBRm8+zOZhTRxTLdgtb2HVXh5J9B5mQp/TC0JZFBQWDUZSjTUNcbG8FJZnfSp64rbpa9DVx2Jh5RwmXkkeU76XYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868883; c=relaxed/simple;
	bh=JbJc9VH1XYlYqPYhzkvludIa59RiQ4mtT6cP44sILfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRPIUxeuKOtmQU2aGetP2E8ckylVEqTgEmeXkRLtNwT5hPTlK2ZTL8PUc1gDtVyipP3Z6zoUb0jxlxHMdXHuA2oC/KscUtwuyRwOf6zAB+nvWC0KES6vzhcSJIwhDADUunDXaihmABFWjPjcZ4OvpxVYzy6YuZ+qGYgR4cjOjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TY8ZXoB7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61807bac417so3356557b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712868881; x=1713473681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWFlaNq/9xtFUk/XAtkp7IqcVqI76yT0LdFHfnH2DTU=;
        b=TY8ZXoB7UDPLSpRj0U9jgPIoZEP8aEUCiaZrLA5NQ4N3mvg+XZx9x7dlIb3QBhtCDu
         MwN8/0s+MOXXstK9M/luRxlbWw822BGVECCVEkghqNfsKs3QcOFfbRCPHGnjD+IrZmQV
         6kmWRivkQiesOYw2/4SOCfF8M+TIJ76Y90OyRRYw3RkgIOGiXJvpKF4I6W9O03NgaoMI
         POLO19sDz0pKYBklK3+ZV7H540JM98d4kc3zwzkEiCeH+eLM4dMnLZ7RtX6wFYS9zIGt
         xMOHquxlLD1Pmni0KielNscDQHEc/rReakRyIq9wTBOvYzNoDxlzn+3Bu7OkHAdO0xFe
         Lmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868881; x=1713473681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWFlaNq/9xtFUk/XAtkp7IqcVqI76yT0LdFHfnH2DTU=;
        b=nZ06VPZc5UpgUCMYVkHUjmd10ZnXoTCcAhRx960L9uY9zI5nWE4HVJuQiNBVORyv7+
         V2El4pyT14cPr85XiZxxDUaWVduNFsMlVo+lz6Utld/3cFv4MCLSFm6E8RRbBkXHoh/g
         KFjslq6C+gcCo+oq4JFHPMHA8QBVA5Xcl2z97SUI0P6IDJXB0WvK02LBTY10B608oSOd
         8vPvsAilLGApxQTU8w49Ilu4UNjIN2FzzgB88PXPEnrrFWpLG1fbjUbW3qgW4fowT3Yt
         6d5VpxOTW8g0v0EKRPjymtY/W2aqz5IELDkwbPBO/4PKInn/IbxIDKXwnRH2JaoZUF8s
         T6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU++j9tTHNEh694mkW6h9pdffn0sWPB92i6AaJUgwppBbtxlCCACyYJ/iK+DtCsGoljznNrNkuHoU7Zp/dvLzhwWnNwIRqFr+yf8YT+
X-Gm-Message-State: AOJu0YxoMov38RtZPzbwH8jN9wPPYrh8OTchEg5JABcjLE6xwY8BpwoK
	hE+xmplJ8rC3shPxxLJeq3x8OxKti2SuBwTINK9FNdKjNTNpQeJO7AFjsrJgRBWaFMwn/s/cxJW
	Mog==
X-Google-Smtp-Source: AGHT+IG1z2bEzQy/U6i5K1RFHB6KQPvvtHyO8vGFX+thv3pSwymv/fnCDFqZ1oiTbGlRzVj5Jj0n+Oa+oPY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c01:b0:dc6:cd85:bcd7 with SMTP id
 fs1-20020a0569020c0100b00dc6cd85bcd7mr199706ybb.3.1712868881704; Thu, 11 Apr
 2024 13:54:41 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:54:40 -0700
In-Reply-To: <20240126085444.324918-12-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-12-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhOEDAl6k-NzOkM@google.com>
Subject: Re: [RFC PATCH 11/41] KVM: x86/pmu: Introduce enable_passthrough_pmu
 module parameter and propage to KVM instance
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
> Finally, always propagate enable_passthrough_pmu and perf_capabilities into
> kvm->arch for each KVM instance.

Why?

arch.enable_passthrough_pmu is simply "arch.enable_pmu && enable_passthrough_pmu",
I don't see any reason to cache that information on a per-VM basis.  Blech, it's
also cached in vcpu->pmu.passthrough, which is even more compexity that doesn't
add any value.

E.g. code that is reachable iff the VM/vCPU has a PMU can simply check the module
param.  And if we commit to that model (all or nothing), then we can probably
end up with cleaner code overall because we bifurcate everything at a module
level, e.g. even use static_call() if we had reason to.

