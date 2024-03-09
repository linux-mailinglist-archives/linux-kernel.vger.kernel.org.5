Return-Path: <linux-kernel+bounces-97956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F3877249
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C39B20F27
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197F185B;
	Sat,  9 Mar 2024 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSRYrzKz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2EEBF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001845; cv=none; b=mr3vShBCVpxG/VIMYSukUlHvm0PqnaRuqR6+Devc9n3aRW2FVNeNmp6CXkJdDxGg3QA7CZNVhobSQTSR0fkzj8RY8Vm1tIYv9aASEnf3hjHQ7/+N9Kglc/f8VdANX9pxPKI01xOhNgFrPAaGlxJQbxnDs73u85v2ctpGbiCNOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001845; c=relaxed/simple;
	bh=Z48F++PaLJh6UFMIPA/i4w6z072wcmAlRmjqHdN1Vis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAsuxyLRPQagaAz8rhoxxNtHsabiYbT66qmZwT9pabXG6ePMszGwohAINsbwUwNyplVldrk1i7xMvDL48QEPIrUDC5/x3ovjjqBG26I1Ah1f0ojxS3yq2j17VT9N23dJq6HIzqXPr4CvVkHTHQ2aeQ3t8Czh/rQdBNiDwDeBkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSRYrzKz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710001842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRDzPfq8rjOgj9kG+t47uY/1Gv5y4mO3jGlGm7JE9GU=;
	b=DSRYrzKza1DEdzc8afbu3JnNeACUmX/fRJC93k4PN2pvZgyJJYQhq3zrLp+sBgGXcPYeXl
	ViQQODUZpJRIfh/pCD0+thaeqinV1rkOaSN4m7bP10Tl+uuaWSs268R697r796k8KN8dk9
	sQmIy0CxIF4k4OGWBUIZbJ0pxJGFRxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-mOM5wM82NbaeuDDfYc4B3g-1; Sat, 09 Mar 2024 11:30:41 -0500
X-MC-Unique: mOM5wM82NbaeuDDfYc4B3g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e67c6b7bdso1189572f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 08:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001840; x=1710606640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRDzPfq8rjOgj9kG+t47uY/1Gv5y4mO3jGlGm7JE9GU=;
        b=ooFR2IwAc7aqW66600Rh1bqdm+g8dXZNY2DU/63RRR2Eb2d197fXG68vTacmA+ZXfa
         eEk40xIEvT02Jt2sRxKU156U0iUqetAFaExTGvOhueX6hDoI2QbNIEQaCQ7tQqk1E8+v
         4FpL0/Np95to8jq98H5Th7qvLpcQXaneQl01B0oIAb17f2v5tF5pIMUweNRh40xzAeFV
         +L2TGLDbuqcUHDMOUlTId6/WWymyxc+g7dbOkLWB00UqU+w2sE4Vyly0CP3+550kcoJk
         VF5oVpAOB+sCkRgs/laeohWSgOJvQ0oSh1SYzZp1WmcaiV2DtfWAU/lCXdwXGcG0InI5
         EtxA==
X-Forwarded-Encrypted: i=1; AJvYcCWYFXgsD77Nt77IqZAmVoANZ0p1vERA0SUmY9HSl4XzalLb4KNgKk04mcLv1UBtUz2CfL1+ZkV2pUfUfYiQMx1+bXKN45P/sUm0JKtG
X-Gm-Message-State: AOJu0YypVFTfwQd86U86JyVBWh5BfBd0UMik4C9qaAqU5dMar8IHeR+H
	nWIz+6lIvQ3laGzIis0Pf7TyDgO3Tpg1J3iNcsSYfXp5OSZIvx1HrQN1Bfq8dbyJjo8LI4uDDud
	kGXS9tZPL3umOPPleeD3yTnlfiRPdkwkozD+Yqro2nPe1fEjpgsmZxeHXa9Y8KPTMtjl99UbqM8
	TdUaUK4/gcJqZrKALnmjZUD1lXNW1eu/LZWeaz
X-Received: by 2002:adf:eac2:0:b0:33e:7896:a9d7 with SMTP id o2-20020adfeac2000000b0033e7896a9d7mr1848970wrn.67.1710001839917;
        Sat, 09 Mar 2024 08:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENv8VK1KmDOmnTYmjyGxo5gsygAIU0tJFmweqBPdN9+cQc2nAzToFcPq9MthddkrTjlYyEHrU7JHcwK3BL/Wk=
X-Received: by 2002:adf:eac2:0:b0:33e:7896:a9d7 with SMTP id
 o2-20020adfeac2000000b0033e7896a9d7mr1848960wrn.67.1710001839526; Sat, 09 Mar
 2024 08:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223211547.3348606-1-seanjc@google.com> <ZdkO0bgL40l10YnU@google.com>
In-Reply-To: <ZdkO0bgL40l10YnU@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 9 Mar 2024 17:30:26 +0100
Message-ID: <CABgObfbvJ=9hc0sxzgW4fXebn66wy4LoKdKg7HWc9t1mihBjAg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: GUEST_MEMFD fixes for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 10:32=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Fri, Feb 23, 2024, Sean Christopherson wrote:
> > Minor fixes related GUEST_MEMFD.  I _just_ posted these, and they've on=
ly
> > been in -next for one night, but I am sending this now to ensure you se=
e it
> > asap, as patch 1 in particular affects KVM's ABI, i.e. really should la=
nd
> > in 6.8 before GUEST_MEMFD support is officially released.
> >
> > The following changes since commit c48617fbbe831d4c80fe84056033f17b70a3=
1136:
> >
> >   Merge tag 'kvmarm-fixes-6.8-3' of git://git.kernel.org/pub/scm/linux/=
kernel/git/kvmarm/kvmarm into HEAD (2024-02-21 05:18:56 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/kvm-x86/linux.git tags/kvm-x86-guest_memfd_fixes-6=
8
> >
> > for you to fetch changes up to 2dfd2383034421101300a3b7325cf339a182d218=
:
> >
> >   KVM: selftests: Add a testcase to verify GUEST_MEMFD and READONLY are=
 exclusive (2024-02-22 17:07:06 -0800)
> >
> > ----------------------------------------------------------------
> > KVM GUEST_MEMFD fixes for 6.8:
> >
> >  - Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY to
> >    avoid creating ABI that KVM can't sanely support.
> >
> >  - Update documentation for KVM_SW_PROTECTED_VM to make it abundantly
> >    clear that such VMs are purely a development and testing vehicle, an=
d
> >    come with zero guarantees.
> >
> >  - Limit KVM_SW_PROTECTED_VM guests to the TDP MMU, as the long term pl=
an
> >    is to support confidential VMs with deterministic private memory (SN=
P
> >    and TDX) only in the TDP MMU.
> >
> >  - Fix a bug in a GUEST_MEMFD negative test that resulted in false pass=
es
> >    when verifying that KVM_MEM_GUEST_MEMFD memslots can't be dirty logg=
ed.
> >
> > ----------------------------------------------------------------
> > Sean Christopherson (5):
> >       KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_REA=
DONLY
>
> Almost forgot, just as an FYI, this has a minor conflict with your kvm/kv=
m-uapi
> branch.  I've been fixing it up in kvm-x86/next, and IIUC you don't feed =
kvm/master
> into -next, so I don't think Stephen will see a conflict?

I do feed it in linux-next, so he would, but it's not a big deal. I'll
pull it into kvm-next as well.

Paolo


