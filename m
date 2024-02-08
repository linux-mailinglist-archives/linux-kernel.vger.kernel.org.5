Return-Path: <linux-kernel+bounces-58163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7029584E219
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3346B23A37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E09F76419;
	Thu,  8 Feb 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPJnLIs6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC67318C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399559; cv=none; b=f8yG87bmrvuakQACBEje32ZIOkcisTk3CDh8GlA//qb6te+UcKhNtMV05walXz/wbzBfnZE6lOWAaYoBKEeZr7KpAaph2VFHf3kxM2SwNZSHfs4ATw+na911muEAUTw5oK/kapStCSOB4vAnHeRCnB9xSrGSkz3Yrjt9fkUkfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399559; c=relaxed/simple;
	bh=SBhV77nizQ8APQmEssjZYbIeubtS8uMS5FsbXrHmzjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE6WrUQ27utXvGnXMcTYWoZ6T8ejiDSuUYsF6zfiEfyav/p+MMmgEgEQg/J8PTbMSe/91CMKKVnQMgCilotPMi4QD9QOAYUo/k6qcpuGHnS/eX+i3voxqpldEPWokyQsM1ydjirrH21fN4vX1TbVTs02Kvf+LzZOk4QJPO6s6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPJnLIs6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707399557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXrfhhpcInwvwI4FrjbsTHUOux7lst37uiaeU7LGWF0=;
	b=dPJnLIs6EdjMKibP3nBTxBybGXwqHFJesvTukMBcJ5uf7AUFl7u7bJbS4XTITZxt4ztuHg
	/fhpInlVf7l8NJxNn5K8Zt3pNK53AN9amw2YF0dBUJ9ClB58wqmVInNgb/dMMtUpcm5w82
	vN4FwDLx2PZwuCvA8ue9tqKdxGQRwtY=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-yLLZExtWPy6K3Gvnt_O6sw-1; Thu, 08 Feb 2024 08:39:15 -0500
X-MC-Unique: yLLZExtWPy6K3Gvnt_O6sw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d2dfa4c63dso1006492241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399555; x=1708004355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXrfhhpcInwvwI4FrjbsTHUOux7lst37uiaeU7LGWF0=;
        b=XfvCpyU2GIWiGkzCML+xNbW2f1L8VE0ECkKvB/yAfOyRNNH7lkzw1nix0wQ/ZNCneT
         z5+VxjNvpSidkPKaBxbyFUQ7rGcFOqGIiyjroHqj+VWxwzLr2Im/uRzGcal/ciEgB4o0
         eMLmmuU+b/mnqSP86RtlzTGyyqXXYipXjOdA1g1uNHoHB0CfWesLG/56XwWFNqMuhcX6
         06rfItGuevaquaFpBY94m7AgCGOQU6C1vYS11RRROZDSresvg8tBxiYsO8omAF6Ymuu6
         QGQCqx4w+J8Ms1lf1GseD7StTQ2GOK72ei+8ak58j6Kuwdb+IpmxPg0DP2CbZGDb0dsd
         bN2g==
X-Gm-Message-State: AOJu0YzdMTbSAtAzmYfb1MuLOfTkFSOWK6pw/CWyTb8SLBpJM/X2Yo2R
	/nFOj+1vjwnIORXunPAKnUs5eroSPt/TNJwpowTHfLx0QXqY5jhvzZxGA6x82DVq+THB5mRBmSO
	kc6uW/gNEboU789rlTPkA1nLO5/7u5cdKqQnLRghB+iSJdpS2vLWEThIQLLxQBJXujYZ9PJs9NF
	w12Re737PiVhKZVcadZ76cAXWi1q7J4fqkeZzH
X-Received: by 2002:a05:6102:55a0:b0:46d:3b56:efe4 with SMTP id dc32-20020a05610255a000b0046d3b56efe4mr6384871vsb.32.1707399555207;
        Thu, 08 Feb 2024 05:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgRzHqQS39WbRm1wyA7DiuERX8kT576hNccxzT2Z21q2BolwCPEcvWjxv44tJRSxLvO1ePXU4CyIYtI7cA5cU=
X-Received: by 2002:a05:6102:55a0:b0:46d:3b56:efe4 with SMTP id
 dc32-20020a05610255a000b0046d3b56efe4mr6384848vsb.32.1707399554687; Thu, 08
 Feb 2024 05:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131233056.10845-1-pbonzini@redhat.com> <ZcOWwYRUxZmpH304@google.com>
In-Reply-To: <ZcOWwYRUxZmpH304@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 14:39:03 +0100
Message-ID: <CABgObfa1SmH0HDq5B5OQxpueej=bdivMTkVrO=cXNfOi09HhUw@mail.gmail.com>
Subject: Re: [PATCH 0/8] KVM: cleanup linux/kvm.h
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:43=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Jan 31, 2024, Paolo Bonzini wrote:
> > More cleanups of KVM's main header:
> >
> > * remove thoroughly obsolete APIs
> >
> > * move architecture-dependent stuff to uapi/asm/kvm.h
> >
> > * small cleanups to __KVM_HAVE_* symbols
>
> Do you have any thoughts on how/when you're going to apply this?  The kvm=
h code
> movement is likely going to generate conflicts for any new uAPI, e.g. I k=
now Paul's
> Xen series at least conflicts.

It also conflicts (and was partly motivated by) the SEV API cleanups
that I am going to post soon.

> A topic branch is probably overkill.  Maybe getting this into kvm/next so=
oner
> than later so that kvm/next can be used as a base will suffice?

I can do both, a topic branch is free. But if you think this is in the
"if it compiles, apply it", then I can take that as Acked-by and apply
it today or tomorrow.

Paolo


