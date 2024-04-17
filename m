Return-Path: <linux-kernel+bounces-149241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A898F8A8D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CF32825E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320E4CB36;
	Wed, 17 Apr 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdFb+zMy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A637163
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388441; cv=none; b=jpcMz5RYolQKUpBszBjlWrAhyR2kLyYkOeWRtPJxVf/I3guOSlot35Zgm7++nccF1QNH6xQIPBWYRXjMe7RQgv1+V14AGjWqmFxLgC1vSFgcAeMBwHXsK1AqdngjflIEMuYUmTkZ6bS1dqiIN+TnpFk6hOrLfa3tasqoT7QgyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388441; c=relaxed/simple;
	bh=XA6YYQNkYOQfc0ccxU6fvBGiv4lH8yOBrPdb7vPQJoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEq11CFyiXAEOOul5M4vcgDmdDNHWKMsRk9QNpU+Nhn1/I1L02xixJviA67BY3AmetEK6veI3FWv8bWsCcmpgy5OUpGu4ikfPM/+V8sDApIDFuDCXjKgJ+OQLdW9MFBBqEH9oFb6GxWxcgDLnHA7vhMpWwayKKcT9OCgZdtBIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdFb+zMy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2C9akPJAJwJZjxxljCty6JRoxRpyti3F4JswiGBS/o=;
	b=UdFb+zMyc3Vo+Z9ZbQsboxHXbmeLq0Yhp+R6de0N4iM+GA8jcXhg3OEYXnIUWvSL3jn0yt
	HQEI9UjP/gSPeGlTImMz9GGojjIkF90ummTidKsj4xsx/ENwDEbUle4hPfaTTXiN4z05/N
	nXEcRWHnfXYbXZtGzGVWZO1UhryrO00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-2J8yU0OTMjeDKoya6gSvEQ-1; Wed, 17 Apr 2024 17:13:57 -0400
X-MC-Unique: 2J8yU0OTMjeDKoya6gSvEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343c8e87a74so108272f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388436; x=1713993236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2C9akPJAJwJZjxxljCty6JRoxRpyti3F4JswiGBS/o=;
        b=hfh2KX132F588Hg8J6XAcjmMWx5RPGnDT9xuNLRWTE1lZ0RsbfnzdRZhkAbpRaqA5E
         TkT3p0l+Unc7AGQnuHJMupWk1kUCoWIBdAigHWAE3GetfdLJ1+zuKjgBNyOcL3iIcyJm
         aIRE6SKIjpGhdY6DGxA1/1Yh7rW7sH6ufhsKA8dn4zwJG4vbKtN7EDj4Zh8ybp3h7mnn
         EHikFejYB2HQZOX205+ZU8PvAqXAuuRZcMw/H9P3EMZgdQ+dfJdOpUJJe2loSx1xzeze
         ZzY+F+8UHIqFFq5+Gc0lKn0q3KECIJwlBPxTzDGjv6A7qNcxtlj3GnZVdPgi+CmcOERH
         SJng==
X-Forwarded-Encrypted: i=1; AJvYcCWDlr9IuFPG+XfKaE59d9dKKnb+ClcgdTbFr5pysCk7cG0m+RYYdDulH1I94aNFiYowYrzMoyRDHZjGGYaAhy/6yAQRUCYx4/iEtE4Y
X-Gm-Message-State: AOJu0YyRfq+iKE0aofdA0n3YwbEjkyehlLNTCrnI3QFjgHsGdVhZRqLs
	DjblFigywIXFmV0XBDMC0sAZ6UC0szRoq4bhTz0fHomPpv2ifiOa9HLeOPnguSDJy2S4+J2ErWp
	mzxdA/ZGITT320eOVuTugYytZ24ssio+vteVWCN1+uKmrpRu5SVGM9xFThQxqrDI0YtadRMiNHx
	CSVZ2elw9PPaMZK9+YekFsNFQe0ULPaMNSIjtc
X-Received: by 2002:a05:6000:1289:b0:343:ba58:97c2 with SMTP id f9-20020a056000128900b00343ba5897c2mr407284wrx.2.1713388436479;
        Wed, 17 Apr 2024 14:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGRugtsyJBzGMIe/V5ASLaTzpSHHpUaE76zkcW3p6ReO5WyJinae3xB1F2OEby8SIAw5N/b+PLo013PGBiEFA=
X-Received: by 2002:a05:6000:1289:b0:343:ba58:97c2 with SMTP id
 f9-20020a056000128900b00343ba5897c2mr407264wrx.2.1713388436104; Wed, 17 Apr
 2024 14:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417153450.3608097-1-pbonzini@redhat.com> <20240417153450.3608097-3-pbonzini@redhat.com>
 <20240417193625.GJ3039520@ls.amr.corp.intel.com> <ZiA6H9-0fknDPdFp@google.com>
In-Reply-To: <ZiA6H9-0fknDPdFp@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2024 23:13:34 +0200
Message-ID: <CABgObfYvfxkkcXNUpe1oCcc1mtUwv+henfm5ghHM2pG1aFNtiQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] KVM: Add KVM_MAP_MEMORY vcpu ioctl to pre-populate
 guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, xiaoyao.li@intel.com, binbin.wu@linux.intel.com, 
	rick.p.edgecombe@intel.com, isaku.yamahata@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:07=E2=80=AFPM Sean Christopherson <seanjc@google=
com> wrote:
>
> On Wed, Apr 17, 2024, Isaku Yamahata wrote:
> > > +   vcpu_load(vcpu);
> > > +   idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> > > +
> > > +   r =3D 0;
> > > +   full_size =3D mapping->size;
> > > +   while (mapping->size) {
>
> Maybe pre-check !mapping->size?  E.g. there's no reason to load the vCPU =
and
> acquire SRCU just to do nothing.  Then this can be a do-while loop and do=
esn't
> need to explicitly initialize 'r'.

It's unlikely to make any difference but okay---easy enough.

> > > +           if (signal_pending(current)) {
> > > +                   r =3D -EINTR;
> > > +                   break;
> > > +           }
> > > +
> > > +           r =3D kvm_arch_vcpu_map_memory(vcpu, mapping);
>
> Requiring arch code to address @mapping is cumbersone.  If the arch call =
returns
> a long, then can't we do?
>
>                 if (r < 0)
>                         break;
>
>                 mapping->size -=3D r;
>                 mapping->gpa +=3D r;

Ok, I thought the same for the return value. I didn't expand the
arguments to arch code in case in the future we have flags or other
expansions of the struct.

> > > +           if (r)
> > > +                   break;
> > > +
> > > +           cond_resched();
> > > +   }
> > > +
> > > +   srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > > +   vcpu_put(vcpu);
> > > +
> > > +   /* Return success if at least one page was mapped successfully.  =
*/
> > > +   return full_size =3D=3D mapping->size ? r : 0;
>
> I just saw Paolo's update that this is intentional, but this strikes me a=
s odd,
> as it requires userspace to redo the ioctl() to figure out why the last o=
ne failed.

Yeah, the same is true of read() but I don't think it's a problem. If
we get an EINTR, then (unlike KVM_RUN which can change the signal
mask) the signal will be delivered right after the ioctl() returns and
you can just proceed. For EAGAIN you can just proceed in general.

And of course, if RET_PF_RETRY is handled in the kernel then EAGAIN
goes away and the only cause of premature exit can be EINTR.

Paolo

> Not a sticking point, just odd to my eyes.
>


