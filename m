Return-Path: <linux-kernel+bounces-100807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C5879D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E8928426A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CCE143747;
	Tue, 12 Mar 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXUUJAl0"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D9142911
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278925; cv=none; b=BPy64EGJ0FUNM7V/KAB5L5CUJ+EpfVDKPfsDDfH+SqR9vHwyCImKFpnzI9dTkLOvVp4gm0nKs2+XDg6tlsBZ3RWSIZymGL6O/26hoDSTXBP+h3IMqOQcb9TGTvNEBdi+IYYp1Qvbha2gzXRTa6ehcGuZJZVo5R7WqzUWqVOLyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278925; c=relaxed/simple;
	bh=TlN/KcWgKTqrLf9K7Wxdb6jjRGDSlbdWWWnaAZ4pxKc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=F0MpTKjr6CDv6YOGAnr7TV0vBVoBXnyHPZFmVq1EpKYnT9ZTQc5UNu+QnEFFA3I9Muc+nXpalge361VDvUmsH3bY/DkknviVhahabkftxyXJiYaeMXmvwTj9jlR1zuwUP/x5s6wGr22gu4XxZYstmedi8EUkLN6TZ1TfgsqHDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXUUJAl0; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3662fb60a79so33133405ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710278923; x=1710883723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TlN/KcWgKTqrLf9K7Wxdb6jjRGDSlbdWWWnaAZ4pxKc=;
        b=ZXUUJAl0xjCa6eHZFjZS0FAwnURFfXJYfKg1ppNY/l1ca5AuaM+62rdmWyq9WZ7zJ4
         3tycJoCu3CFwMdKS/RSrhrOT/nUsyxRjlz7J02FQ4uyV+N8L2AY6uhynuxjN61b3134P
         o/paacNhWKxqWLzU7U8hcYUU/9PfTWoUZL3xIzQBwzx7v9LCzb0YuCxcZ084QSY++Q5N
         9RbL9RFIIFIee/+Pw/xhqAQKDZl6dSH0FdfkltrkhS+FO9ipsF/64vZxdz4+fXj1leVA
         IzVGn6qRpPpLlpQy/CjZSErsFzWG68uKROSP5ZCvfZKvVbZSTYH9/56dHy2xWPKEtOst
         ebeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278923; x=1710883723;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlN/KcWgKTqrLf9K7Wxdb6jjRGDSlbdWWWnaAZ4pxKc=;
        b=kDp25yJ5x5tZs9Lyc81lXjiIkzvy+PRcGepwcCqBtlxJN7BcEHrHyAqTQgq10NCNJN
         GI3mZXx/fM7ipHasIkx3prixvuVzQ3hLXFrYr37aclqhG9aqHnRTM9Q0XeWl1AYtfxwA
         cl6XGPybf+WxVNaZ7tEhBZGCgZAx+D9fKhKEZ7nh1doNayVqPWNwld77E63TjFXwj4ix
         Qt4qVpW2MxHkJ5zQn++yeDtZW2C8SCelheVj5ILYu/mZCQplGy0IQYSxOK8mmZv9Eu4H
         MxZJCukrGx3UvRHFmA6tgQnvb15c4m4yF9Opvx5/iiJ4EnyTEFiPd2lPqf3jIaFR0MmT
         hoow==
X-Forwarded-Encrypted: i=1; AJvYcCUQqhaDRpXgFYnp4nZVdWR2FG1jdNQaiVC/Kft1YfaZgubo4w9mG4PspCmL4moEhBoN1R4ANVb7o+4ws3MjVL2mJlKrVZh1nlPRZLfp
X-Gm-Message-State: AOJu0YwlqshivU2nQuYkCJyNLG/9q5lP2vsIUU1tRpNuo5VH25+ta5pE
	NhXYMPsamCZ38k50Ut36GQ5OSMhDzheXtiQGpZy6fR8gW2Vsa/biwWMbkcqCzIAB7tVjtaWMjUw
	zzcZUjJ47+5jymf2KEcB6jQ==
X-Google-Smtp-Source: AGHT+IEoVsGuGGGld+ryeqksDKkbTQO1fBRWYgfgCt3ANgMLC+suKNaZec5VszPIVCIIPKCZ9y/dRjlt4XfPMVM4Tg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a92:cd84:0:b0:366:1f71:1f6d with SMTP
 id r4-20020a92cd84000000b003661f711f6dmr438743ilb.2.1710278923231; Tue, 12
 Mar 2024 14:28:43 -0700 (PDT)
Date: Tue, 12 Mar 2024 21:28:42 +0000
In-Reply-To: <Zbgx8hZgWCmtzMjH@linux.dev> (message from Oliver Upton on Mon,
 29 Jan 2024 23:17:06 +0000)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv85rrvg5.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH] KVM: arm64: Add capability for unconditional WFx passthrough
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, maz@kernel.org, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Oliver Upton <oliver.upton@linux.dev> writes:

> Hi Colton,

> On Mon, Jan 29, 2024 at 09:39:17PM +0000, Colton Lewis wrote:
>> Add KVM_CAP_ARM_WFX_PASSTHROUGH capability to always allow WFE/WFI
>> instructions to run without trapping. Current behavior is to only
>> allow this if the vcpu is the only task running. This commit keeps the
>> old behavior when the capability is not set.

>> This allows userspace to set deterministic behavior and increase
>> efficiency for platforms with direct interrupt injection support.

> Marc and I actually had an offlist conversation (shame on us!) about
> this very topic since there are users asking for the _opposite_ of this
> patch (unconditionally trap) [*].

> I had originally wanted something like this, but Marc made the very good
> point that (1) the behavior of WFx traps is in no way user-visible and
> (2) it is entirely an IMP DEF behavior. The architecture only requires
> the traps be effective if the instruction does not complete in finite
> time.

> We need to think of an interface that doesn't depend on
> implementation-specific behavior, such as a control based on runqueue
> depth.

Here's the first thing I came up with after returning to this problem:

We have an ioctl to get/set a threshold value,
wfx_traps_runqueue_depth. If the depth is less than or equal to the
threshold, disable WFx traps. If greater than, enable WFx traps.

Current behavior occurs with a setting of 1. Always trap occurs with a
setting of 0. Never trap occurs with any large enough number.

Of course, having an integer may be more flexible than needed. I can't
imagine a practical use for a number between 1 and UINT_MAX, in which
case it would be better as an enum for different behaviors than a
integer threshold.

What do you think?

Also, do you mean runqueue depth for the current CPU or globally?

