Return-Path: <linux-kernel+bounces-50710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7159847D24
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4CF1F29A32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2812D744;
	Fri,  2 Feb 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaYpeGTA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D512D756
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916476; cv=none; b=Wx28mc2fLFzqwmXYzLDMy1+xFI6gpkdznd+kWDoJY362gXVqNL0Eg2NnFFA27z3SliD2mrklbyOi677DFzHCuR8H5GmLpwVccgI6q8INU32BpFW4Hl00RgCi6FtUQCN2CzvG1lqifTDQgQ2i+aY39Lk53yN381zR4qB7xkLyePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916476; c=relaxed/simple;
	bh=7NIN4ZEb96Qel/+QFx0vI4wiSTw5vhLynJDGiTiLb00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RlVBY+AmFhMqHE+O378GzW61ZpPmkTQ4QLHTDuSHzmlpQcZk56MiCMhcoH94HmVYY+J/MFo04kiyfc6WO189SOr+VCr1T2Bs7ea/I9NnCBkqlo4AcxZUVFOkIFN/w9Y+atqWOlKo1rSlN5h3BXeNK6Iv+JI3vka06P3hiyUGZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaYpeGTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706916470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvjpBPRVZdRvT0Gc0YqMz3apz4VjDzsss9R8ZCfiJ+k=;
	b=iaYpeGTAbJFIulHH7p2eEXivjloZKHD9CKH/DuXvz6T1ijb78yTnMQk3Wp0QD7aJgNGF2W
	o2daciRvg/ibq3sKynMdrYpUL3uSTS1tFVjf006caugXpBUMcwQMF9Xume36diKDEN41dT
	J7NsehMh481UQoNncUxSG1jxGVOzuss=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-SvvyMvCrOtmTI0ltluEE7g-1; Fri, 02 Feb 2024 18:27:49 -0500
X-MC-Unique: SvvyMvCrOtmTI0ltluEE7g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51032b2fb9fso1982923e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706916468; x=1707521268;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvjpBPRVZdRvT0Gc0YqMz3apz4VjDzsss9R8ZCfiJ+k=;
        b=MrAr6LL4KZfzSyn7noV46T0S6yHboapP3vM+Qka6fm7v5dv20A46ebPd9GDDni9LJr
         0BYyLgRabksh2QYQrK+5bEf3QHgw3r8PltsSKJqxHCgGhVZSxjRJonieU94Ls1dAy25Q
         EYOd3UjddTfIztn7FN2OtKJlQJLIBxBaNXwkrmPQGfRP2/Gjr7uFE2nj2Kjh+KuoQCpN
         OOGnOFkMiqWHXfN3pyRFwn9G8wi8eDuvAKaqb4LTxxusiQKcTgpQ4KD6af0CL+vksNoT
         6RdBKIMCJrBf/Je9lVvOcQdeTykLnSUY6C3UMCOJR1VqCNVB/7hD2snepp5PXrPgCfo0
         veXQ==
X-Gm-Message-State: AOJu0YxL2Id1NeUMpprmLPHfrwJgmRbR89mIWdOVwRFwBMHtLmH29RCZ
	k9uhredkcyFuAtU7xK+ZXQkxgI/mvTVjUALdAgQHTthuyON42fFbI/okEb9aVjY546wYEOSHXwd
	SvHKmfSA47J0PK+dP2vQgsoCn9F4q4IJAaTN+CRlOlk0F4njlV4vuinQOQ+tjqRDpB4Gbou/BEM
	7wiGkLGDNvaiskYaK3Sjhg9Y88gAglJlgdEzGNioLf3jUg5Z9+7rA=
X-Received: by 2002:a05:6512:479:b0:511:30fd:9221 with SMTP id x25-20020a056512047900b0051130fd9221mr3740498lfd.11.1706916467914;
        Fri, 02 Feb 2024 15:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5lbwDd6MdmX009dN5LGoq3MxNFKAFez89tbI4oMACdYaL71jrSpqchTqBEaZRG7J74TvyCA==
X-Received: by 2002:a05:6512:479:b0:511:30fd:9221 with SMTP id x25-20020a056512047900b0051130fd9221mr3740485lfd.11.1706916467489;
        Fri, 02 Feb 2024 15:27:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0n+O9eBt502zZ5eh2PAvjMTN680xCbZyBUbGom3WsOj0/4Anunzt1NpcfQ3JWZYr44PM2oraGHlja53MPgmA/dgnRz5nX4z554qU9gvJh1aYCP7TfHcNGEpJW8lNaCx23bRvoE6X0Yo4YQoS/NRpLfIkDY5voxPTavy9SbEZZerBl9VoXZCmyN5h/
Received: from fedora ([188.93.81.205])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040e88d1422esm1179685wms.31.2024.02.02.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:27:46 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, Paolo
 Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, Jan Richter <jarichte@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Compare wall time from xen shinfo
 against KVM_GET_CLOCK
In-Reply-To: <ZbvObrzoyZlay-Xg@google.com>
References: <20240111135901.1785096-1-vkuznets@redhat.com>
 <170666266419.3861766.8799090958259831473.b4-ty@google.com>
 <ZbvObrzoyZlay-Xg@google.com>
Date: Sat, 03 Feb 2024 00:27:45 +0100
Message-ID: <87r0huh2fi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jan 30, 2024, Sean Christopherson wrote:
>> On Thu, 11 Jan 2024 14:59:01 +0100, Vitaly Kuznetsov wrote:
>> > xen_shinfo_test is observed to be flaky failing sporadically with
>> > "VM time too old". With min_ts/max_ts debug print added:
>> > 
>> > Wall clock (v 3269818) 1704906491.986255664
>> > Time info 1: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
>> > Time info 2: v 1282712 tsc 33530585736 time 14014430025 mul 3587552223 shift 4294967295 flags 1
>> > min_ts: 1704906491.986312153
>> > max_ts: 1704906506.001006963
>> > ==== Test Assertion Failure ====
>> >   x86_64/xen_shinfo_test.c:1003: cmp_timespec(&min_ts, &vm_ts) <= 0
>> >   pid=32724 tid=32724 errno=4 - Interrupted system call
>> >      1	0x00000000004030ad: main at xen_shinfo_test.c:1003
>> >      2	0x00007fca6b23feaf: ?? ??:0
>> >      3	0x00007fca6b23ff5f: ?? ??:0
>> >      4	0x0000000000405e04: _start at ??:?
>> >   VM time too old
>> > 
>> > [...]
>> 
>> Applied to kvm-x86 selftests.  David, please holler if you disagree with
>> any of the changes.  They look sane to me, but clock stuff ain't my forte.
>> 
>> Thanks!
>> 
>> [1/1] KVM: selftests: Compare wall time from xen shinfo against KVM_GET_CLOCK
>>       https://github.com/kvm-x86/linux/commit/a0868e7c5575
>
> FYI, I've dropped this as it looks like there will be a new version.

Thanks, indeed, I'll do do changes suggested by David in v2 but as I'm
traveling this weekend (FOSDEM calls!) please expect my posting Tuesday+
next week.

-- 
Vitaly


