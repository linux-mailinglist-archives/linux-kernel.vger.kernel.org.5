Return-Path: <linux-kernel+bounces-148439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E518A8292
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234081C21179
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1813CFB7;
	Wed, 17 Apr 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5QjFLRw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B87FBD2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354997; cv=none; b=CxdumTEugQioVHreK5S5sTmipGFng7Rng5TzE3FXAK7uliPPWinG+cdhpllQNeDhgp51LkapdJwXfS+Hqg+Gx3Pxdu+Ca2XvMQkW3D3kDgTCH6VQJXYJhY4kgOwivoOKZxNfvi5erWCcuSr0irAbAuyrZyQ6Ob5ygCdCkyBSilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354997; c=relaxed/simple;
	bh=OkqjIGY0dO0EYUs+k4N0h8mt+HxxKfsKtT7B7+RNshw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAYK5aGyBNNDwyfpNiAeBF5tvMeZofqSP6ARsIDL0qb/d+ydWdraRqjv7sr0Lf67nXKZmY1tBrYdz+ttfXzBVBqqas0xZH/cXHPbChqhNbf4vAbw+Wf1hssC/b0Lx7q1pKvdwSk3xQhf/ZkLJjYZmBeIwyQOhM99dJIK/D8dNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5QjFLRw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713354995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OPfDBVjHLokYt/bIhiqITH6wcGeIkV1QodUY9C1btU=;
	b=R5QjFLRw2qs5nPGQele/iYbpGR7IKs6cO556J5cb+H0qcNM6QQQT8qDKv1GyhKXl2kzUsi
	+tlApfVCN9BfWzuSIyzdEHjo+l+me//MYTnJjBP/ULz+qbDo22bOvwl6ZkiSZ6ZlOLhcxY
	PQUZGnsII7V0iHpO/vCJXSiB3qax/1k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-4_rgtwfHNY-EK0DOpR-HVg-1; Wed, 17 Apr 2024 07:56:33 -0400
X-MC-Unique: 4_rgtwfHNY-EK0DOpR-HVg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343f8b51910so3063571f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713354992; x=1713959792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OPfDBVjHLokYt/bIhiqITH6wcGeIkV1QodUY9C1btU=;
        b=bCJNapURQFpiSNoJVPPX/SXEPgWxjyPQOTiYhF5LUtdvnsIdV5CehBZ1Cwzkaj/D0o
         6ckJaEX7L2h6R/o5/VBYn+I3H8VlSmh85z5QR//nHzch7uAPTz9t0Fjv2Q4++liutgsk
         b0k9x4EqVhXYmo78ZmvSuZOaZMbTKW+MkZwdUwartMP6ZxXC9yVrUfxXKRK929+PLaTP
         ExjLWDuOUFVocAEcSY2T7vJf0H15jALFtz+MF3DVyt+yOz7JrP8iCu3bkPRzYmwAcXyO
         ToRtA3wrTd4rJjSqjBe0USkuMjyQnuYsW244Y8aKduej6B02xvy+cgblXtXdkXDAPR62
         QAYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNPiRzDarJP6pOGN5NkRx00Pljb69m+OEeIwdFx0fXrtuvShLQ2QUedjWMDDGBmmLDdQ7uXmOaeOoElggqB0pvu8a09L/MEWqO5Qt
X-Gm-Message-State: AOJu0YyZQ4oUfT+cUI3r8K6l3Mhpk1ZRc253Jg9cpATTI12oWvGPAw/F
	713YYB8lld7JNVeIPiEqMpgDT9aj5LNLB1R+buUktxnCNqStJTXuhG2jogU+fG7npJHcsu6zSNT
	ASmwT4rcjdee5YQ7a/bH1ofkgHuFXsnYR8iecwSdoF/58ak2XILJiVyCvM9ZWA5reihF4k2+Fnn
	6dWexTwnrEExTwDA77+7A0mF4KDP9bct2FxKJ6
X-Received: by 2002:a05:6000:1cc8:b0:343:7896:209d with SMTP id bf8-20020a0560001cc800b003437896209dmr10602698wrb.22.1713354992449;
        Wed, 17 Apr 2024 04:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERvfF/bKS/2HiwjNDxweQ5tBr2Z0Jepgoy54xCm9Hd7GipLWBKy0gFYF095j1ekWZGQV+5dpBjqTkTdghQefc=
X-Received: by 2002:a05:6000:1cc8:b0:343:7896:209d with SMTP id
 bf8-20020a0560001cc800b003437896209dmr10602687wrb.22.1713354992135; Wed, 17
 Apr 2024 04:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712785629.git.isaku.yamahata@intel.com>
 <9a060293c9ad9a78f1d8994cfe1311e818e99257.1712785629.git.isaku.yamahata@intel.com>
 <28923ef142d588836201a1533b73fe4d89ce4696.camel@intel.com>
In-Reply-To: <28923ef142d588836201a1533b73fe4d89ce4696.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 13:56:20 +0200
Message-ID: <CABgObfaOkP+ECAxFz6AUBo-HTiZng3HOZDQ9kxeewpxc1yNNJg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] KVM: Document KVM_MAP_MEMORY ioctl
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"federico.parola@polito.it" <federico.parola@polito.it>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:27=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> > +  EAGAIN     The region is only processed partially.  The caller shoul=
d
> > +             issue the ioctl with the updated parameters when `size` >=
 0.
> > +  EINTR      An unmasked signal is pending.  The region may be process=
ed
> > +             partially.

The common convention is to only return errno if no page was processed.

> > +KVM_MAP_MEMORY populates guest memory with the range, `base_address` i=
n (L1)
> > +guest physical address(GPA) and `size` in bytes.  `flags` must be zero=
  It's
> > +reserved for future use.  When the ioctl returns, the input values are
> > updated
> > +to point to the remaining range.  If `size` > 0 on return, the caller =
should
> > +issue the ioctl with the updated parameters.
> > +
> > +Multiple vcpus are allowed to call this ioctl simultaneously.  It's no=
t
> > +mandatory for all vcpus to issue this ioctl.  A single vcpu can suffic=
e.
> > +Multiple vcpus invocations are utilized for scalability to process the
> > +population in parallel.  If multiple vcpus call this ioctl in parallel=
, it
> > may
> > +result in the error of EAGAIN due to race conditions.
> > +
> > +This population is restricted to the "pure" population without trigger=
ing
> > +underlying technology-specific initialization.  For example, CoCo-rela=
ted
> > +operations won't perform.  In the case of TDX, this API won't invoke
> > +TDH.MEM.PAGE.ADD() or TDH.MR.EXTEND().  Vendor-specific uAPIs are requ=
ired
> > for
> > +such operations.
>
> Probably don't want to have TDX bits in here yet. Since it's talking abou=
t what
> KVM_MAP_MEMORY is *not* doing, it can just be dropped.

Let's rewrite everything to be more generic:

+KVM_MAP_MEMORY populates guest memory in the page tables of a vCPU.
+When the ioctl returns, the input values are updated to point to the
+remaining range.  If `size` > 0 on return, the caller should
+issue the ioctl again with updated parameters.
+
+In some cases, multiple vCPUs might share the page tables.  In this
+case, if this ioctl is called in parallel for multiple vCPUs the
+ioctl might return with `size > 0`.
+
+The ioctl may not be supported for all VMs.  You may use
+`KVM_CHECK_EXTENSION` on the VM file descriptor to check if it is
+supported.
+
+`flags` must currently be zero.


Paolo


