Return-Path: <linux-kernel+bounces-47950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D284551B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF411F2D1CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62B15B990;
	Thu,  1 Feb 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFzJNb/y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6224DA06
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782805; cv=none; b=rPzUrdxvDl5OH8DUPnh1hq9IFb7tysblqSmPIbkuyvhLGun4zpweKP+BnVtlXmBW5zyhj9G0WuqjE923j3Co0Zaj/+Gb0jDebepux3XSqsj0YeKRWQMEWGb8aOOxBfVb8gY64nj4wtRXNDCHwyWGm1/RdyQDP8BTe41/Pbuhb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782805; c=relaxed/simple;
	bh=fOv7oevZuvvZsJf1C1St13HEDSFkJW2lWu0qBEAsTwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVZWuvcLjQrBIDIxo3z58/8Zx9/Sd1Rk7qK5T1ytyy9JGzpjHm9Hex06LHwUtaOF88lDTdyibbc/21BXkvprG4Npc9mN50jZopE1PX10xc4VGbj6S5hL4solkVXOBm9JKUuhM8sn8bpk/Qh59C3CFIysc8uiQ9apJDkuFJKc/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFzJNb/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706782802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/4dNiv7Gixt65uHC5aCs29qHOR+DNKVZDoHEZy6bqM=;
	b=QFzJNb/yFHqj0lECgOOaCuSB9d4LWnsxzi/suNWvkH7K1qbS31mriop01P0U4guOvtokwH
	JMP9ffhzUucmRBhjoALz0BZo9GnIbFerEYjNX3kcAsfzU/NiApmTlbRR7oHzntqkbd6bou
	4/mWQQ4B5LzHYTP8WSRlG5jGXVlZlow=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-EJFGnSf7MlyxvkMOYtyFOQ-1; Thu, 01 Feb 2024 05:20:00 -0500
X-MC-Unique: EJFGnSf7MlyxvkMOYtyFOQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a357c92f241so43402866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706782799; x=1707387599;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/4dNiv7Gixt65uHC5aCs29qHOR+DNKVZDoHEZy6bqM=;
        b=a3g6p90Fvbmre4Ml3dZvO1Yqf5cUls7rCtLZa6FrYzDFVOEJY/4xLVAoXXmi4Pwn+P
         BRv5+VMPX+1Bjn2FD8vujKtcZGxIPMECOyJ1HCoV99A609gMGGCfAFmoKmAbsF2SNaNZ
         e4cOxqqxldl59S818kY+S8iOgVoJNCFRimPVFuXPWofBls6IbukWzYQ1foaZ61scbJPj
         w74xqTzu/Uwc3uxVAFl7KCHJfwivsAVN7doKn737jMP4pWJUYwW1RHHZvhfMB5w/9/qP
         RMBJHKl9qn9xUwoJgnGKAm2mb53QeNMxrb5SPFZX7vCianTIURkt/06QAON0UdfaKSDh
         mfiA==
X-Gm-Message-State: AOJu0Yy4c5jIAcPGML++VJT+8NVAd9WhJ/AOgKdpD8iEu9MA8kud70Yu
	ldsum0/drxFDOIYRNLRiSDdbHEb5bohwlilRyhuv3231VrsrMc9IeUJIQDjPEjFHePDnVRSx0C0
	QMDHA6N7JBAUmIQJ5I9baW2KP+k4dnRweL7eE+8331NkiOeYhqQPYqkn1uBMDvg==
X-Received: by 2002:a17:906:d10e:b0:a31:61ad:6554 with SMTP id b14-20020a170906d10e00b00a3161ad6554mr1429949ejz.69.1706782799670;
        Thu, 01 Feb 2024 02:19:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/GkhU57dioOHC7xr2O/jFX4EwaPurr5DMMYY1FG8VzQcAwtDPgonJDhdsMsmkqsVkOvrUSw==
X-Received: by 2002:a17:906:d10e:b0:a31:61ad:6554 with SMTP id b14-20020a170906d10e00b00a3161ad6554mr1429938ejz.69.1706782799369;
        Thu, 01 Feb 2024 02:19:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJSx1+Gy7uGkCto8Zt1KBxcUnD2ZLhWxsVkpmKm5U5+OL9zn33sGzRU7E78tS+Hy/5FlzM9yhmk9DWGTItzzIjvVv8ZeC1z+wfdQXpJcn1hHtAHafdNx0aowOBmkVezCnXw2pjZ0YHGRIJ9+v1aW9ap6nZCdmf+07dLJE/mb05zBj53vU7//jjyQ==
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ps10-20020a170906bf4a00b00a368718314dsm1232216ejb.7.2024.02.01.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:19:58 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jan Richter <jarichte@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: selftests: Compare wall time from xen shinfo
 against KVM_GET_CLOCK
In-Reply-To: <596b2d7ce6941e5dd6bd7b2da6d3ea7d74f6c95a.camel@infradead.org>
References: <20240111135901.1785096-1-vkuznets@redhat.com>
 <596b2d7ce6941e5dd6bd7b2da6d3ea7d74f6c95a.camel@infradead.org>
Date: Thu, 01 Feb 2024 11:19:57 +0100
Message-ID: <87h6is7agi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse <dwmw2@infradead.org> writes:

> Sorry for delayed response.
>
> On Thu, 2024-01-11 at 14:59 +0100, Vitaly Kuznetsov wrote:
>>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_ioctl(vm, KVM_GET_CLOCK, &kcdat=
a);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delta =3D (wc->sec * NSEC_PER_SEC =
+ wc->nsec) - (kcdata.realtime - kcdata.clock);
>
> I think you need to check for KVM_CLOCK_REALTIME in the flags here,
> don't you? It might not always be set.

Good suggestion; while this shouldn't be a common use-case on x86_64, it
is possible when TSC is *not* the clocksource used on the host. I guess
we can just skip the sub-test with a message in this case.

>
> And also, nobody should ever be using KVM_CLOCK_REALTIME as it stands
> at the moment. It's fundamentally broken because it should always have
> used CLOCK_TAI not CLOCK_REALTIME.
>
> I'm in the process of fixing that up as an incremental ABI change,
> putting the TAI offset into one of the spare pad fields in the
> kvm_clock_data and adding a new KVM_CLOCK_TAI_OFFSET flag.
>
>> +       TEST_ASSERT(llabs(delta) < 100,
>> +                   "Guest's epoch from shinfo %d.%09d differs from KVM_=
GET_CLOCK %lld.%lld",
>> +                   wc->sec, wc->nsec, (kcdata.realtime - kcdata.clock) =
/ NSEC_PER_SEC,
>> +                   (kcdata.realtime - kcdata.clock) % NSEC_PER_SEC);
>>=20
>
>> Replace the check with comparing wall clock data from shinfo to
>> KVM_GET_CLOCK. The later gives both realtime and kvmclock so guest's epo=
ch
>> can be calculated by subtraction. Note, the computed epoch may still dif=
fer
>> a few nanoseconds from shinfo as different TSC is used and there are
>> rounding errors but 100 nanoseconds margin should be enough to cover
>> it (famous last words).
>
> Aren't those just bugs? Surely this *should* be cycle-perfect, if the
> host has a stable TSC?
>
> But I suppose this isn't the test case for that. This is just testing
> that the Xen shinfo is doing basically the right thing.
>
> And we're going to need a few more fixes like this WIP before we get
> get to cycle perfection from the horrid mess that is our kvmclock code:
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff;h=3Db=
c557e5ee4

(Some time ago I was considering suggesting we switch to Hypet-V TSC page
clocksource for Linux guests to avoid fixing the mess :-) It's becoming
less and less relevant as with modern hardware which supports TSC
scaling (and which doesn't support famous TSC bugs like TSC divergence
across sockets :-) passing through raw TSC to guests is becoming more
and more popular.)

Regarding this fix, what's your decree? My intention here is to
basically get rid on xen_shinfo flakyness without reducing test
coverage. I.e. we still want to test that shinfo data is somewhat
sane. Later, when you get your 'cycle perfection' and 'TAI' patches in,
we can always adjust the test accordingly. In case you agree, I can
re-send this with KVM_CLOCK_REALTIME check added.

--=20
Vitaly


