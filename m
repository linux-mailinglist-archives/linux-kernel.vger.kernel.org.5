Return-Path: <linux-kernel+bounces-43052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D787840ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867B41C21259
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B1155314;
	Mon, 29 Jan 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajW5/ZI7"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CB1552FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544374; cv=none; b=DTpgRXS/3/GoYht7iCGUIJLqpyBp/R/ZE9wsP9qa591vooF4LcI5DETs1fXPq1jrOzwNjC7M8yMw8+8GY8y/ha7LTQLBeugUpSS5zHG7OVgLjHNV158iA6zShLKK3ivedA14eKNMT7GgBBQYzWJvDrdRbHlP1WGQun0x209L1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544374; c=relaxed/simple;
	bh=spdhQtlVqwZGxE4WLvNyqmE4pPTaQvGGfD0owlqyrn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKiCJB15kIc7/J+TY8JS1D+l0yD+X+XthK88LSB8JTU5aIZBuukQS2lsbnkwPbSpol3iMwNvshn9679swDUT/TaIbOEe/kn7oFYJBqLFxECkbQyIgIf6OKaAVBtAxPWfw54v5GMrPiyJJwfPxJwip2dZv+EorO9UTNpSTNm3LEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajW5/ZI7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so74926a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706544372; x=1707149172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QJhPN9B0DFyt0uGBm0tTKyr6mAm9uyszmwYK+ey7JU=;
        b=ajW5/ZI73utd0MqqP3WWh+4f7jf4psLeRjJ/BN2v2Z03F7RcwqaYKoGtszeSesseNZ
         GyQoFb1Sw3JoEiBEjsASZoNRvtvTypf8rG97Yeqsa/47NVOPEVztYucB9WU0suZJWD9y
         Oii1eTT7/DanBMoFiSKJIKkajxmJC4MaYpidDGxD60DmphA5g0RArG0g3xRGQGLV/css
         iaWXuPxnUS87cif0QPMGXry1AOOixYKLnSeiCVPAr+SFSGynH1UuBqlYyw0h6UrPAABH
         nPydt/w7CEWZU8LEVZOpHeozovbHA0U1YE3QUk8s0izBjgWeyN4q7b6kR5HOh/SfBd13
         iJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544372; x=1707149172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QJhPN9B0DFyt0uGBm0tTKyr6mAm9uyszmwYK+ey7JU=;
        b=vlN5Wbn75WnLyczUJQnPXxelc7fSrd8usvEwQlJQ4zk+vWvR8f5zlsanpf5k57S5OT
         I4Lq4zN+Fes83Xbs6T4AenbUwiorQXsSYPECW7BtqFyUp5VHtUuH5zqWm8e52u3NhU+w
         IfHVsy6WAsVf9OnxlOBv2lwpuZaLx1TtUXi/jvCZCTt0FT8gQxS4Nsj9O9/qtuzfS1tN
         ijVXnUycf0pBvRQVHYZKBcJBY0Ab5jYnHYCjc7qfzlLvlo4dsbXKq6G32ot6Ix0yY1q5
         M+0SX8I2e3FCuhFOfiyFeKkdBkTZBfurVRN+WsIchW7yqYTtWE+HiDVFFBW3s85boOqw
         A0og==
X-Gm-Message-State: AOJu0YyymDE4SYWXDccIvLOIOGiMwKkXqYwUfmBUB+QyEF+4Jf04sh+S
	Wf8pbN+UlnOsGLRQUDMEfYUMjmgCFqwvkytxCkoPucJlENEwIjRhYQj4fKgGiRCF7n8lMvb0HJm
	gcA==
X-Google-Smtp-Source: AGHT+IGeJuMzinOv4G1LhBN1dQPrLZMNZOW8qaacXubx8vE2kR3dJwXXjPyvetrZj6mvs5PmsYPxMJiYqs4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6803:0:b0:5d8:c0fa:c982 with SMTP id
 l3-20020a656803000000b005d8c0fac982mr19571pgt.10.1706544372349; Mon, 29 Jan
 2024 08:06:12 -0800 (PST)
Date: Mon, 29 Jan 2024 08:06:10 -0800
In-Reply-To: <877cjs8q8d.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111135901.1785096-1-vkuznets@redhat.com> <877cjs8q8d.fsf@redhat.com>
Message-ID: <ZbfM8peFYU-jY9-o@google.com>
Subject: Re: [PATCH] KVM: selftests: Compare wall time from xen shinfo against KVM_GET_CLOCK
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Jan Richter <jarichte@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > xen_shinfo_test is observed to be flaky failing sporadically with
> > "VM time too old". With min_ts/max_ts debug print added:
> >
> > Wall clock (v 3269818) 1704906491.986255664
> > Time info 1: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> > Time info 2: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
> > min_ts: 1704906491.986312153
> > max_ts: 1704906506.001006963
> > ==== Test Assertion Failure ====
> >   x86_64/xen_shinfo_test.c:1003: cmp_timespec(&min_ts, &vm_ts) <= 0
> >   pid=32724 tid=32724 errno=4 - Interrupted system call
> >      1	0x00000000004030ad: main at xen_shinfo_test.c:1003
> >      2	0x00007fca6b23feaf: ?? ??:0
> >      3	0x00007fca6b23ff5f: ?? ??:0
> >      4	0x0000000000405e04: _start at ??:?
> >   VM time too old
> >
> > The test compares wall clock data from shinfo (which is the output of
> > kvm_get_wall_clock_epoch()) against clock_gettime(CLOCK_REALTIME) in the
> > host system before the VM is created. In the example above, it compares
> >
> >  shinfo: 1704906491.986255664 vs min_ts: 1704906491.986312153
> >
> > and fails as the later is greater than the former.  While this sounds like
> > a sane test, it doesn't pass reality check: kvm_get_wall_clock_epoch()
> > calculates guest's epoch (realtime when the guest was created) by
> > subtracting kvmclock from the current realtime and the calculation happens
> > when shinfo is setup. The problem is that kvmclock is a raw clock and
> > realtime clock is affected by NTP. This means that if realtime ticks with a
> > slightly reduced frequency, "guest's epoch" calculated by
> > kvm_get_wall_clock_epoch() will actually tick backwards! This is not a big
> > issue from guest's perspective as the guest can't really observe this but
> > this epoch can't be compared with a fixed clock_gettime() on the host.
> >
> > Replace the check with comparing wall clock data from shinfo to
> > KVM_GET_CLOCK. The later gives both realtime and kvmclock so guest's epoch
> > can be calculated by subtraction. Note, the computed epoch may still differ
> > a few nanoseconds from shinfo as different TSC is used and there are
> > rounding errors but 100 nanoseconds margin should be enough to cover
> > it (famous last words).
> >
> > Reported-by: Jan Richter <jarichte@redhat.com>
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---

David, any objection?

