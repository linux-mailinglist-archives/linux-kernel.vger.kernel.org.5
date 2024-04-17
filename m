Return-Path: <linux-kernel+bounces-148484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 957438A8344
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F6284FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F140813CFB7;
	Wed, 17 Apr 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr8Xk/+L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234C84E0F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357650; cv=none; b=KXooH+pavFRVhsS2YP098Oon9YkjBZ4MV98fzZVPgwXfF4HmBRUHDlD7C7kECihXVtq7UUOfQgSEIIQoFTfSbWQgeMHx4TVvvFZ+yFuX70ep4aNuKX4Ly+x2OacPx7bLDgCiRO+8n3m7/x/xz+rxpwWFgFabC+XDOFtw70Mzf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357650; c=relaxed/simple;
	bh=SZYDg+na6K7h9Vv14AyPAuxyrO/oZVej32R+fzs88QI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENeUmXp2PRC4SeT01YqHASaLSn+a9cHCs5ujytEeeKZBJyK/I5fFc5UodxNOyJq4UP5T4I9Kb//d9/ipNkoj4K4h1kc0jfnI06t7T1VLnMqoeX1uCQQORKULU3cPhWdHWC2qCken781uNcD91X+Xf2Ki0zkR6GzgB86XTrYy0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pr8Xk/+L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713357647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulYmovQ6En9zaNpE5vdtcIPlGVLx641GykIGt/6K9EU=;
	b=Pr8Xk/+LKjYAqr5MLaQKg7fWlLH95QYeZkWEQrQ3CHLqXPBKyKKDi/3GGjrYBCDPoHa3AZ
	lbnbrPJhINICKtvEG8ylh6EACyb5VDkQUN5Z1xSVJHTLAm5tNuDjWefLdqwwVYBCOzQARR
	+Qo5u95Eyj6EkbzmjPcUjR7GsHGRfzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-f4tiW1LZMji8l19ZEVkdCA-1; Wed, 17 Apr 2024 08:40:45 -0400
X-MC-Unique: f4tiW1LZMji8l19ZEVkdCA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4155db7b58cso27359735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357644; x=1713962444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulYmovQ6En9zaNpE5vdtcIPlGVLx641GykIGt/6K9EU=;
        b=OoZFUlrvS/Svn9JpESMNnXXMhwC3gQ0IPWfyCjO7WG+C8GV6J5WQqAEtj4ColD7xCv
         VSs8qKhFqgwkVDbcT3Yka2i573nawzbn+r15zb2H5kSFGS4S3K8PQ4+m/5BxytOvcRKX
         UD+DfVihIgQLeTiZZZUYNqUjeTZMs9HVaCAUagFxBdZH+ROByfImmieqvFer2BgAH81Y
         RE5/29r4FcWkq9738GDWzhwRkJzJlHJoCo6FOOfQr1GmDN9zSTfBvA13iMiOIDl/jNwJ
         Y/Vthf6xA+s5bX0KhTW0mar/sYfZopUtJnwUXjW897aYjmXj4aFFQVzWlDl81Hps20GE
         7lMA==
X-Forwarded-Encrypted: i=1; AJvYcCWXZLoIfmemjYidkoAUjJhoTit3idwhObKoGCkglWYPNKiRESYkSBVo8F5l+bXbSRBIj5QFHhFzjUb0RES2xXIJ3D4VBIn1wYavBG9W
X-Gm-Message-State: AOJu0YzgqtCJNYl9juQ3rAehcNMrCIJT1gfPxx+nSiRQRx9l2YKdQcus
	DH3kGR184SyM2qOb04Yz3Rd15OJhZLKXnVtzqeyFZeEUmTK0Qd8S+kxcwPAFOlhx1yJPmY2GX1l
	KQ4PceghmTFfRO9PDuFMwiYA/tysHiGyiSgxr/6JeUqdqSmjnGkT2XFVhyGWJkg==
X-Received: by 2002:a05:600c:458d:b0:415:6afd:9ba6 with SMTP id r13-20020a05600c458d00b004156afd9ba6mr11929149wmo.1.1713357644479;
        Wed, 17 Apr 2024 05:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZddkAPUVOhLfH/xj00D/4yUL+6KFlvHsvjkAsfKlo9fYB/W1eyd9kVzfOpyrtN4Nts5uYKQ==
X-Received: by 2002:a05:600c:458d:b0:415:6afd:9ba6 with SMTP id r13-20020a05600c458d00b004156afd9ba6mr11929135wmo.1.1713357644075;
        Wed, 17 Apr 2024 05:40:44 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id jp26-20020a05600c559a00b00418010d25fdsm3384399wmb.1.2024.04.17.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:40:43 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:40:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: boris.ostrovsky@oracle.com
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM/x86: Do not clear SIPI while in SMM
Message-ID: <20240417144041.1a493235@imammedo.users.ipa.redhat.com>
In-Reply-To: <77f30c15-9cae-46c2-ba2c-121712479b1c@oracle.com>
References: <20240416204729.2541743-1-boris.ostrovsky@oracle.com>
	<c7091688-8af5-4e70-b2d7-6d0a7134dbbe@redhat.com>
	<66cc2113-3417-42d0-bf47-d707816cbb53@oracle.com>
	<CABgObfZ-dFnWK46pyvuaO8TKEKC5pntqa1nXm-7Cwr0rpg5a3w@mail.gmail.com>
	<77fe7722-cbe9-4880-8096-e2c197c5b757@oracle.com>
	<Zh8G-AKzu0lvW2xb@google.com>
	<77f30c15-9cae-46c2-ba2c-121712479b1c@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Apr 2024 19:37:09 -0400
boris.ostrovsky@oracle.com wrote:

> On 4/16/24 7:17 PM, Sean Christopherson wrote:
> > On Tue, Apr 16, 2024, boris.ostrovsky@oracle.com wrote: =20
> >> (Sorry, need to resend)
> >>
> >> On 4/16/24 6:03 PM, Paolo Bonzini wrote: =20
> >>> On Tue, Apr 16, 2024 at 10:57=E2=80=AFPM <boris.ostrovsky@oracle.com>=
 wrote: =20
> >>>> On 4/16/24 4:53 PM, Paolo Bonzini wrote: =20
> >>>>> On 4/16/24 22:47, Boris Ostrovsky wrote: =20
> >>>>>> Keeping the SIPI pending avoids this scenario. =20
> >>>>>
> >>>>> This is incorrect - it's yet another ugly legacy facet of x86, but =
we
> >>>>> have to live with it.  SIPI is discarded because the code is suppos=
ed
> >>>>> to retry it if needed ("INIT-SIPI-SIPI"). =20
> >>>>
> >>>> I couldn't find in the SDM/APM a definitive statement about whether =
SIPI
> >>>> is supposed to be dropped. =20
> >>>
> >>> I think the manual is pretty consistent that SIPIs are never latched,
> >>> they're only ever used in wait-for-SIPI state.
> >>> =20
> >>>>> The sender should set a flag as early as possible in the SIPI code =
so
> >>>>> that it's clear that it was not received; and an extra SIPI is not a
> >>>>> problem, it will be ignored anyway and will not cause trouble if
> >>>>> there's a race.
> >>>>>
> >>>>> What is the reproducer for this? =20
> >>>>
> >>>> Hotplugging/unplugging cpus in a loop, especially if you oversubscri=
be
> >>>> the guest, will get you there in 10-15 minutes.
> >>>>
> >>>> Typically (although I think not always) this is happening when OVMF =
if
> >>>> trying to rendezvous and a processor is missing and is sent an extra=
 SMI. =20
> >>>
> >>> Can you go into more detail? I wasn't even aware that OVMF's SMM
> >>> supported hotplug - on real hardware I think there's extra work from
> >>> the BMC to coordinate all SMIs across both existing and hotplugged
> >>> packages(*) =20
> >>
> >>
> >> It's been supported by OVMF for a couple of years (in fact, IIRC you w=
ere
> >> part of at least initial conversations about this, at least for the un=
plug
> >> part).
> >>
> >> During hotplug QEMU gathers all cpus in OVMF from (I think)
> >> ich9_apm_ctrl_changed() and they are all waited for in
> >> SmmCpuRendezvous()->SmmWaitForApArrival(). Occasionally it may so happ=
en
> >> that the SMI from QEMU is not delivered to a processor that was *just*
> >> successfully hotplugged and so it is pinged again (https://github.com/=
tianocore/edk2/blob/fcfdbe29874320e9f876baa7afebc3fca8f4a7df/UefiCpuPkg/PiS=
mmCpuDxeSmm/MpService.c#L304).
> >>
> >>
> >> At the same time this processor is now being brought up by kernel and =
is
> >> being sent INIT-SIPI-SIPI. If these (or at least the SIPIs) arrive aft=
er the
> >> SMI reaches the processor then that processor is not going to have a g=
ood
> >> day.=20

Do you use qemu/firmware combo that negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_B=
IT/
ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT features?

> >=20
> > It's specifically SIPI that's problematic.  INIT is blocked by SMM, but=
 latched,
> > and SMIs are blocked by WFS, but latched.  And AFAICT, KVM emulates all=
 of those
> > combinations correctly.
> >=20
> > Why is the SMI from QEMU not delivered?  That seems like the smoking gu=
n. =20
>=20
> I haven't actually traced this but it seems that what happens is that cv
> the newly-added processor is about to leave SMM and the count of in-SMM=20
> processors is decremented. At the same time, since the processor is=20
> still in SMM the QEMU's SMM is not taken.
>=20
> And so when the count is looked at again in SmmWaitForApArrival() one=20
> processor is missing.

Current QEMU CPU hotplug workflow with SMM enabled, should be following:

  1. OSPM gets list(N) of hotplugged cpus=20
  2. OSPM hands over control to firmware (SMM callback leading to SMI broad=
cast)
  3. Firmware at this point shall initialize all new CPUs (incl. relocating=
 SMBASE for new ones)
     it shall pull in all CPUs that are present at the moment
  4. Firmware returns control to OSPM
  5. OSPM sends Notify to the list(N) CPUs triggering INIT-SIPI-SIPI _only_=
 on
     those CPUs that it collected in step 1

above steps will repeat until all hotplugged CPUs are handled.

In nutshell INIT-SIPI-SIPI shall not be sent to a freshly hotplugged CPU
that OSPM haven't seen (1) yet _and_ firmware should have initialized (3).

CPUs enumerated at (3) at least shall include CPUs present at (1)
and may include newer CPU arrived in between (1-3).

CPUs collected at (1) shall all get SMM, if it doesn't happen
then hotplug workflow won't work as expected.
In which case we need to figure out why SMM is not delivered
or why firmware isn't waiting for hotplugged CPU.

>=20
> -boris
>=20


