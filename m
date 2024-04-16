Return-Path: <linux-kernel+bounces-147649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F528A76DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08F4B249FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30413B591;
	Tue, 16 Apr 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Seg7e16T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D796BFA5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303415; cv=none; b=T5nFtGrI9Nz0W7w77sMcBwV75hdTNYtJCZUNdJQxSiLsyTQbQVoiCfJOWZ+sej0HY+kdmMEfwcSRK5PmUMBgNcvNsX4AoPheyRn1XXh+811z4U7K2LCpTbbnBxy4W+EBmSnccenl7OzWQBORDwJ6ZaGZ2o0Vami0GKe2q1saYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303415; c=relaxed/simple;
	bh=c3EoyWM19DUSeIavFgvY6oD+s9pl5dwzlLm7a+SK04M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJD7OmJjrKWYb4cBO0J2c2ThTt+tdKE1VZuklKgkyV3zaH+XCYMf9wiD6gb7tG1BT6ZxbjXYHdmNJUJX/MyiuDiee7O6JpN2yBcEdPdWT0qCgB4d6OQLYnHVtvH33CUagR7icwwbaZqVaLIfR7+BpDikw7JNtGVTuBCZNvX4TZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Seg7e16T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713303412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0qLih9CVo//sQPGcjSldQT1UvSQG7AJG7QoYxruR5c=;
	b=Seg7e16TpVke0Gcaqk/zJPh4owaUzGAAXCBvshGsfspolDASV2ADvJkyUANn9WOHBaixOJ
	4SxIdsslvF6joSWOSRMDhI1KCHVd6/2NjmAe/ANYZu1XlruW6bFRumaBmiz1JrTa49m4zO
	AXfwpandIxkLeIxGJsN8qwLPJ/u31Ko=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-BxU1UEkLOcOJYepWLeOx0Q-1; Tue, 16 Apr 2024 17:36:50 -0400
X-MC-Unique: BxU1UEkLOcOJYepWLeOx0Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343da0a889dso3691289f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303409; x=1713908209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0qLih9CVo//sQPGcjSldQT1UvSQG7AJG7QoYxruR5c=;
        b=qVYqfzgHISmsCn/Qw5KkyaGKcJ15x4UyGMgansJMpDt3ZOKs+pahXalbpvZsA1zAHX
         UiVA+9dYWg5bQqrcc6zL2+uHJUsr/nwpjByVyvioVl/ed9NeAWkd337w4cASU+b+DlUt
         l1StslsN84G+piMBTd+b9NWbHkCoDx8v0QsL88U61U/QY8Gz6+4MNHGjPxi1a5TNdBiw
         X4vnARx3A74me8AS5oPY4/hYAvP+Sz1MqqooV8uTNWNTMjVsEqnPg2Uvdz+w5WympUNq
         RXo5lmslTBaRB/kuCD7bn3kIFkvTeBwPitjI8Tu9pJZabxq0t58ablBctFCcwUlkLN6e
         k8yg==
X-Forwarded-Encrypted: i=1; AJvYcCWt9+snhJx1R8kPuvGfpOhNsCyuKfIeCzqqgUIIjutdScOoqt/zVHaodA28Kqksmwv1Rb50qOA3A69xcWmuDJEhRvxS5GBbtWqRF/w7
X-Gm-Message-State: AOJu0YxsDt8wdLm+CHYhjoF0UAAI+RndIk7bW149HAzxOiPsJjCuExRI
	0t19JkRA5ENtCmXckR4gcbBWGPlAgjklyzSGWclvrlFa3/bEhIRTa5z8g2j9vgL/xBzjUEs/0s/
	q1baKa9/e0IBUYd47QhuYIhLakLS2jKRHjFS99sKKIIQb/PYQD9Yg45mrLYeFew90eXpwNdjfKJ
	APuvxSMGA0rF3LDK8j/Oj31B0MoO/xiJoiXiMI
X-Received: by 2002:a5d:4d03:0:b0:346:c6e6:b7a3 with SMTP id z3-20020a5d4d03000000b00346c6e6b7a3mr10055945wrt.27.1713303409637;
        Tue, 16 Apr 2024 14:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH2aalsqR17NVaw3iwl23TCGdtUkDF3Z86K6sf3k8FdRa0FuECZeJaDo/mZHzWA4PU75JXSod12XE1eLB57eI=
X-Received: by 2002:a5d:4d03:0:b0:346:c6e6:b7a3 with SMTP id
 z3-20020a5d4d03000000b00346c6e6b7a3mr10055930wrt.27.1713303409298; Tue, 16
 Apr 2024 14:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
 <Zh6-h0lBCpYBahw7@google.com> <CABgObfZ4kqaXLaOAOj4aGB5GAe9GxOmJmOP+7kdke6OqA35HzA@mail.gmail.com>
 <4cdf71ca-c4e4-49a5-a64d-d0549ad2cf7b@oracle.com>
In-Reply-To: <4cdf71ca-c4e4-49a5-a64d-d0549ad2cf7b@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 23:36:36 +0200
Message-ID: <CABgObfZugCVm7xysXBB=OZhQumga1bvit8oXbfhyjk7ncCa4NA@mail.gmail.com>
Subject: Re: [RFC 0/3] Export APICv-related state via binary stats interface
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:29=E2=80=AFPM Alejandro Jimenez
<alejandro.j.jimenez@oracle.com> wrote:
>
>
>
> On 4/16/24 15:51, Paolo Bonzini wrote:
> > On Tue, Apr 16, 2024 at 8:08=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >>
> >> On Thu, Feb 15, 2024, Alejandro Jimenez wrote:
> >>> The goal of this RFC is to agree on a mechanism for querying the stat=
e (and
> >>> related stats) of APICv/AVIC. I clearly have an AVIC bias when approa=
ching this
> >>> topic since that is the side that I have mostly looked at, and has th=
e greater
> >>> number of possible inhibits, but I believe the argument applies for b=
oth
> >>> vendor's technologies.
> >>>
> >>> Currently, a user or monitoring app trying to determine if APICv is a=
ctually
> >>> being used needs implementation-specific knowlegde in order to look f=
or specific
> >>> types of #VMEXIT (i.e. AVIC_INCOMPLETE_IPI/AVIC_NOACCEL), checking GA=
Log events
> >>> by watching /proc/interrupts for AMD-Vi*-GA, etc. There are existing =
tracepoints
> >>> (e.g. kvm_apicv_accept_irq, kvm_avic_ga_log) that make this task easi=
er, but
> >>> tracefs is not viable in some scenarios. Adding kvm debugfs entries h=
as similar
> >>> downsides. Suravee has previously proposed a new IOCTL interface[0] t=
o expose
> >>> this information, but there has not been any development in that dire=
ction.
> >>> Sean has mentioned a preference for using BPF to extract info from th=
e current
> >>> tracepoints, which would require reworking existing structs to access=
 some
> >>> desired data, but as far as I know there isn't any work done on that =
approach
> >>> yet.
> >>>
> >>> Recently Joao mentioned another alternative: the binary stats framewo=
rk that is
> >>> already supported by kernel[1] and QEMU[2].
> >>
> >> The hiccup with stats are that they are ABI, e.g. we can't (easily) di=
tch stats
> >> once they're added, and KVM needs to maintain the exact behavior.
> >
> > Stats are not ABI---why would they be? They have an established
> > meaning and it's not a good idea to change it, but it's not an
> > absolute no-no(*); and removing them is not a problem at all.
> >
> > For example, if stats were ABI, there would be no need for the
> > introspection mechanism, you could just use a struct like ethtool
> > stats (which *are* ABO).
> >
> > Not everything makes a good stat but, if in doubt and it's cheap
> > enough to collect it, go ahead and add it. Cheap collection is the
> > important point, because tracepoints in a hot path can be so expensive
> > as to slow down the guest substantially, at least in microbenchmarks.
> >
> > In this case I'm not sure _all_ inhibits makes sense and I certainly
> > wouldn't want a bitmask,
>
> I wanted to be able to query enough info via stats (i.e. is APICv active,=
 and if
> not, why is it inhibited?) that is exposed via the other interfaces which=
 are not
> always available. That unfortunately requires a bit of "overloading" of
> the stat as I mentioned earlier, but it remains cheap to collect and expo=
se.
>
> What would be your preferred interface to provide the (complete) APICv st=
ate?
>
>   but a generic APICv-enabled stat certainly
> > makes sense, and perhaps another for a weirdly-configured local APIC.
>
> Can you expand on what you mean by "weirdly-configured"? Do you mean some=
thing
> like virtual wire mode?

I mean any of

    APICV_INHIBIT_REASON_HYPERV,
    APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED,
    APICV_INHIBIT_REASON_APIC_ID_MODIFIED,
    APICV_INHIBIT_REASON_APIC_BASE_MODIFIED,
    APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,

which in practice are always going to be APICV_INHIBIT_REASON_HYPERV
on 99.99% of the gues

ExtINT is visible via irq_window_exits; if you are not running nested,
do not have the problematic configurations above. don't have debugging
(BLOCKIRQ) or in-kernel PIT with reinjection, that's basically the
only one that's left.

Paolo

> Alejandro
>
> >
> > Paolo
> >
> > (*) you have to draw a line somewhere. New processor models may
> > virtualize parts of the CPU in such a way that some stats become
> > meaningless or just stay at zero. Should KVM not support those
> > features because it is not possible anymore to introspect the guest
> > through stat?
> >
> >> Tracepoints are explicitly not ABI, and so we can be much more permiss=
ive when it
> >> comes to adding/expanding tracepoints, specifically because there are =
no guarantees
> >> provided to userspace.
> >>
> >
> >
>


