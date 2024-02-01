Return-Path: <linux-kernel+bounces-48567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788D845E02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06F91F2D78B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8C5B67E;
	Thu,  1 Feb 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWI8er/J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A107E106
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806899; cv=none; b=RqDIJoZcJUnidZZDVa2WFSG05DPG36viUV/O8YYSo+XbFxQPslVMFGjO+vKlaADtRf2qCoDzX6fKEfRzXSCTf0mpHqZTtpbPDsYU/d/WFz9hRwWC1+KjhlWMlPpooM+xruWVmQnJ25iSLv9Vhpi6FgbMo8CBx8vzhED+X3MpR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806899; c=relaxed/simple;
	bh=404+oMX5DYoQ8uCTQtK/PDwUpYsIJ9z/UK9iHiXZ+Uc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6003aeQOPfpF+r2UiWYDg45zJXWVvXMqoeU2uRxqqEQzEZKR/6St8Ra8EFE7/bdVSl4kzG6EIerS1cypbDJAFRRwp6S/CclPiYsTXRlWYnRlEN4CgXFxBrQDzz8JI72yCA58Mu/Twq94xaKillrg//Q5eYEYApFD4Zb1bZbQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWI8er/J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040597d005so22617887b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706806896; x=1707411696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bt+l8LQwp/+KP1L4+VoJP1PtxEUI5oG7XATKE+2Azog=;
        b=EWI8er/JBe7rioihydfyqna4vpQ7FBJYw/TVMft6Dml47NY0+WyYFV1aJpNu8kUcuZ
         2+Ire465LK1OluzILwWwT7GXvU5SN0xMw/xnMCYsBS4ZpRZkGeb/FJhY8mYYOVJga4Al
         ZV1rGY5xpzU7Per3zdpCiTbShfDm3M3vjRrfuI9Yrwbvg8M410o2o2O6Df2SoxLJTn/1
         z8VAPJU3gx6HWsTxqrFAqpwdOI+I8kwPXJpf0nDeEvZxnwhAs3mT67VAOXx5i/GRluTB
         X9wBMWqTdokMH6BQcbHgDDZDmC3lSkIeMa1tX5/Kt8eaNr7cZ8fwU52lqleqyXut3qJn
         8p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806896; x=1707411696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bt+l8LQwp/+KP1L4+VoJP1PtxEUI5oG7XATKE+2Azog=;
        b=B9UvEHlIeuok4JFCw/IILlRGUgMsXvlvv1+I7SKYOfrIDvBXapJsJKH8y6JYNtuozg
         00ipdXkFJT82sJ31KfDEFh5SAcRZu9D9kBqfDM0YeJ74V0UWUwHxi44f5WFbqBa4eRZE
         7m2XrnF3u2mVsIvQTa9kvlFEbPJG9CdgXWsCBtDObWQRXuLygyG65JYu+P2MYwfSLM4G
         HjnCSPvaHhb4iW3G6PnPnb7mMy1fZY6RukxV5HLw4WUuddhM+VWT0vi1SmAEcxuE7zUK
         mKoOjS+4qhAj7vAAAALZJ5Te9CqMCIADVnaqxZeK1YzCEu72WnlgZsgFP5MON6hXYiuW
         ByLQ==
X-Gm-Message-State: AOJu0YzEvFSylUa7r3SuMwaZWVI/H7ga2OOdRyEQiTUlty3enKEJuoA4
	ZyYWAGZwh5LtaU5IWhlrAt5ewyMSMgryNlyfyqYKSMLnSZm8PWX+s7ykOAX2tDLS4KdRbQXEzKm
	qcQ==
X-Google-Smtp-Source: AGHT+IHn1/T64LldLBtNyUreN5Tq5xOAFLu/0q2+MM560sHJ2yM3qHilJxeJHjNw4vn+JjyLZFoNsJkfZcE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4c0d:0:b0:5fb:7e5b:b87f with SMTP id
 z13-20020a814c0d000000b005fb7e5bb87fmr1199825ywa.1.1706806895945; Thu, 01 Feb
 2024 09:01:35 -0800 (PST)
Date: Thu, 1 Feb 2024 09:01:34 -0800
In-Reply-To: <170666266419.3861766.8799090958259831473.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111135901.1785096-1-vkuznets@redhat.com> <170666266419.3861766.8799090958259831473.b4-ty@google.com>
Message-ID: <ZbvObrzoyZlay-Xg@google.com>
Subject: Re: [PATCH] KVM: selftests: Compare wall time from xen shinfo against KVM_GET_CLOCK
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, Jan Richter <jarichte@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 30, 2024, Sean Christopherson wrote:
> On Thu, 11 Jan 2024 14:59:01 +0100, Vitaly Kuznetsov wrote:
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
> > [...]
> 
> Applied to kvm-x86 selftests.  David, please holler if you disagree with
> any of the changes.  They look sane to me, but clock stuff ain't my forte.
> 
> Thanks!
> 
> [1/1] KVM: selftests: Compare wall time from xen shinfo against KVM_GET_CLOCK
>       https://github.com/kvm-x86/linux/commit/a0868e7c5575

FYI, I've dropped this as it looks like there will be a new version.

