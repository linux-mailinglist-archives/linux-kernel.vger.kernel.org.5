Return-Path: <linux-kernel+bounces-157290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB328B0F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183E6289924
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2763161322;
	Wed, 24 Apr 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duWThx/f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377615FCED
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974775; cv=none; b=FGIZJtRo8ECYK6PhkWV2Oimfh1iEiBo1XKk1VsSV+E3Sjoni6RAamKLaknekqsjHmqz0vdtNeIHbQm7SevO/urwIuSEi9NZoCXJzfqgDV4t3pLW0vx8OrpOZIHnWs6dcEa2KuG+aY8GJYjOByBMTh9FvnMFR/XAy6OE3FZr4h/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974775; c=relaxed/simple;
	bh=yVhTaSI0IN9x1hSEq/c6WtpXjjzz5sgC1B4mc1Aq4Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwqBfp2pNcMZlSF6//i9yWpdVuyGTxLzOIW6sGMfSX84b3dJ7WbirySSsVbjcubqHHJ+5d8F/xrk4ugXxxsJ+LKk6Iq/dn7/BgeoEY4zLxmrT4aj0xK5Viuxcic2OpF5VJ/nhHrOL2doI+9QO9eAoByvUunB9srThhby1tEjRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duWThx/f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713974772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oA2yVR/0LIk/2yMOm6WFAwy5uxXi3mXUTspZx4CPJrQ=;
	b=duWThx/ff9nuV//ECvl1lR7SzON4mQZqTxJU04ahMQjCiKsg2tD22BaQ5r6tuslzwhUjdc
	M15kaSFc0ZUfIS/fMJJPAkRxHQ8VZ8PaAp66gLgjb3/6XVpHp2qgaIHVr0kgraK1ryQ+p1
	xDJzA+eNX7NPcS8reqJqaFmqinHBi+o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-8KGxRxCFNc6gYk8dTL5mCQ-1; Wed, 24 Apr 2024 12:06:11 -0400
X-MC-Unique: 8KGxRxCFNc6gYk8dTL5mCQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346c08df987so46037f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974769; x=1714579569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA2yVR/0LIk/2yMOm6WFAwy5uxXi3mXUTspZx4CPJrQ=;
        b=e7eFd/LxPUfd6uCq4cYL8wwibjYkHa3dNUUNi+1TPjpn+48QNm/DWpk03cTd52G6eW
         bINlu2k0TgKQ7fRSS6NBKV5nFDmz3DWpVD1UFeyhp45O93NKjCWB/+hHLxDGXDtWjPhw
         le4TvzEqcGgqGevplKSplDKNn5RdAeMXVPOJL+tj8khux/wVxPxiZuZDPmqfPFiJzo+p
         zmetFdmxlk1eewkf7TCOcnKXYhQ83mSHAaAZsj6NfdJBiXWxyl9n1r3g6M7jcY5mGjf0
         nuIdx4CFWOE590uGPpxLCVblSAx9c4Cd3ZMYfA6+m7hjOi5Pg9kIxp90yX/AXSCdLVSx
         Fc4A==
X-Gm-Message-State: AOJu0YyR/01ZLAGIwNxCOzliqG0oVGepDTMbdnBW1fSiBvMfTmlZgw+I
	r3261Agns3atFzvhPcN5SHQ4AKWDwCwsfKPDdD3+9b7vQuOK95hujoFPbmuv4jiz+pAr81YL/jt
	7SoMLDKrysRHR1ljWFIVokcE46tQUi+tO9JV4DzrYzwE/hAACzzKjC84iy1Q17ZqwHdTVr1DITt
	OlCjvGfXku+RGctZ5RqQFwmyXJApiSldi8qnWSbkgRF8Xy
X-Received: by 2002:adf:f451:0:b0:348:7e75:4d75 with SMTP id f17-20020adff451000000b003487e754d75mr80670wrp.22.1713974769368;
        Wed, 24 Apr 2024 09:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFetSybQAphKK1G77Kg0f223/o7zJ35zY1t5heqCwOVkh5YZgj4h8hG3maYM68P0r0G2V3JT9rVm9GqhLJehWo=
X-Received: by 2002:adf:f451:0:b0:348:7e75:4d75 with SMTP id
 f17-20020adff451000000b003487e754d75mr80653wrp.22.1713974769028; Wed, 24 Apr
 2024 09:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419085927.3648704-1-pbonzini@redhat.com> <20240419085927.3648704-3-pbonzini@redhat.com>
 <eb7c7982-2445-4968-892c-c36f5b38fabe@linux.intel.com>
In-Reply-To: <eb7c7982-2445-4968-892c-c36f5b38fabe@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Apr 2024 18:05:57 +0200
Message-ID: <CABgObfYrxwdy-LqcWiCSfHhOihi9qJT2a3PzhSRHzkFgiJurNQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to
 pre-populate guest memory
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 7:39=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
> range->size equals 0 can be covered by "range->gpa + range->size <=3D
> range->gpa"
>
> If we want to return success when size is 0 (, though I am not sure it's
> needed),
> we need to use "range->gpa + range->size < range->gpa" instead.

I think it's not needed because it could cause an infinite loop in
(buggy) userspace. Better return -EINVAL.

Paolo

>
> > +
> > +     vcpu_load(vcpu);
> > +     idx =3D srcu_read_lock(&vcpu->kvm->srcu);
> > +
> > +     full_size =3D range->size;
> > +     do {
> > +             if (signal_pending(current)) {
> > +                     r =3D -EINTR;
> > +                     break;
> > +             }
> > +
> > +             r =3D kvm_arch_vcpu_pre_fault_memory(vcpu, range);
> > +             if (r < 0)
> > +                     break;
> > +
> > +             if (WARN_ON_ONCE(r =3D=3D 0))
> > +                     break;
> > +
> > +             range->size -=3D r;
> > +             range->gpa +=3D r;
> > +             cond_resched();
> > +     } while (range->size);
> > +
> > +     srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > +     vcpu_put(vcpu);
> > +
> > +     /* Return success if at least one page was mapped successfully.  =
*/
> > +     return full_size =3D=3D range->size ? r : 0;
> > +}
> > +#endif
> > +
> >   static long kvm_vcpu_ioctl(struct file *filp,
> >                          unsigned int ioctl, unsigned long arg)
> >   {
> > @@ -4580,6 +4629,20 @@ static long kvm_vcpu_ioctl(struct file *filp,
> >               r =3D kvm_vcpu_ioctl_get_stats_fd(vcpu);
> >               break;
> >       }
> > +#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
> > +     case KVM_PRE_FAULT_MEMORY: {
> > +             struct kvm_pre_fault_memory range;
> > +
> > +             r =3D -EFAULT;
> > +             if (copy_from_user(&range, argp, sizeof(range)))
> > +                     break;
> > +             r =3D kvm_vcpu_pre_fault_memory(vcpu, &range);
> > +             /* Pass back leftover range. */
> > +             if (copy_to_user(argp, &range, sizeof(range)))
> > +                     r =3D -EFAULT;
> > +             break;
> > +     }
> > +#endif
> >       default:
> >               r =3D kvm_arch_vcpu_ioctl(filp, ioctl, arg);
> >       }
>


