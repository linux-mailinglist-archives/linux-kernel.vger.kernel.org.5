Return-Path: <linux-kernel+bounces-147488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751DA8A7520
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F031C217E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64105139588;
	Tue, 16 Apr 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJ+dvupa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF901386BF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297218; cv=none; b=iBRcOu5ShYu7faavrB/hWaGJcRzR4HMoWU0+pXFdDPAgXEu/eVdNW2H6GcMApv7HLLwDLFMhdnEQPMzSg5iWa5HinA9Hmz3KDmZ6HK+Td3a7NeSi0v5TTHo8j8RrtXIbD9cGEWgbGnvZsL/cp27nT+Ove1/9bxUb4AP9ScaI5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297218; c=relaxed/simple;
	bh=9gUD5M/iXssTO5Xh8NSAH7//1Cb8mDtB2KtSbMHD000=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krWx5PSsUNlYgkjkr7m1q2yT28NptQo8O/4jtbhe+eUAtdiIl1oGID0fH1L+fc97aN8oyT2GVzBZXPQdmUTZpnxoUyCuoMdUFKAj3/7+B0f36HnaISkZ13gxXATjTj0xe9szDDLbNCqmgpkbnLamkdyTmBtuqp5NcrIuJ16isjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJ+dvupa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713297216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lw/7y0/GFS1bW+8o2hjWhoijSh0n+IXQOkuIPY73oXI=;
	b=gJ+dvupaeGNqG3CbNfNZQst4VgGxwoZJVPauMT2mKlTpmdsi+mhEab8Gr9MOEkT0Q2EHY/
	kqMyqZi5iFlpGu6JHvGSBG77NIjEX2fVEbuSyqaYdtIyiXExBSdEEaZiRIPAopLZX7CsWE
	/Ba1LMBqnrAeHB6N9XzCgvgSOEGVZks=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-ALzNTlPaOE6DQRa9-L1nVA-1; Tue, 16 Apr 2024 15:53:34 -0400
X-MC-Unique: ALzNTlPaOE6DQRa9-L1nVA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343bc1e4ef3so3661081f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713297213; x=1713902013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lw/7y0/GFS1bW+8o2hjWhoijSh0n+IXQOkuIPY73oXI=;
        b=kqp+jK+VY9t1vVPduYlsWsDQLQ97DdbtqTyiy0YK4yf9teHEJ1syhcTJMRb4e6WQWT
         OB0rYrsEuUEGZDiwtPxBosiKFyWJIdkGh4ryTZhJt4ZTgOBBT/Had1eA1VbUNvDcB8kG
         XFyBgw+j09TmL07NtO+cKUdvMNAWdjOb4f5tQ+LtGDqqDHkv3q1ZApQ17R4r6x6F955B
         8JwS3P8PEeyWB+6Nr0SA/0kcUn/jnAyPxWF3gOboi5/JeJyamUA1Nqs/DWpBSw54Wbz4
         hS1FoQKerZz6F9SmhCyA2IXRN4GelWb1d0AfWf934Sfzs649J6+DqOHKMjs2P6VPFxAn
         Z8pg==
X-Forwarded-Encrypted: i=1; AJvYcCVl7NmvbEAHPt3JpSbgKr82Nj+URjSQrmQMp2/JDOOkKuDC5yGsJaQsczB5413tYK0Tu0sYNwec4u50Hhhqqr284oK1gqT/7Bff6EPe
X-Gm-Message-State: AOJu0Yxcf9B8J3EOQMQfl+IybpfXdItv/yeRabjeMaIuVyhzrtMYwMbP
	PliVmct/TiQPKySRd4uXhnjfMvGERyFdB9k1CMEtg1VCcTlbleZTe5pE0Vh6RQDJQD645p4aDVt
	HdIyc0t/10kjcmBtwOaf7UVcBwbvnUPKlrzW12kCa1EzlFplJPu55oBknZfGKM0EqurOf+GM4pH
	m5iSlLKvrPOiUYPxoyN7mLqIbcd0AS1D93DnxO
X-Received: by 2002:a5d:614d:0:b0:341:865b:65c9 with SMTP id y13-20020a5d614d000000b00341865b65c9mr11372507wrt.22.1713297213488;
        Tue, 16 Apr 2024 12:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsM9yRS/5L8y+d9XdCzLHbdP+imRkztXX3qhOnE5sUeovqvYfaKrjqA6bcmlyakZyurXtSoMzmWaWzV7L3s/M=
X-Received: by 2002:a5d:614d:0:b0:341:865b:65c9 with SMTP id
 y13-20020a5d614d000000b00341865b65c9mr11372494wrt.22.1713297213153; Tue, 16
 Apr 2024 12:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com>
 <20240215160136.1256084-2-alejandro.j.jimenez@oracle.com> <Zh7BOkOf0i_KZVNO@google.com>
In-Reply-To: <Zh7BOkOf0i_KZVNO@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 21:53:21 +0200
Message-ID: <CABgObfZ6Q0t+J7=-BfZz4y9fDUtmJzt_RSyQ43LCg0KMpYC3+g@mail.gmail.com>
Subject: Re: [RFC 1/3] x86: KVM: stats: Add a stat to report status of APICv inhibition
To: Sean Christopherson <seanjc@google.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:19=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> > +     u64 apicv_inhibited;
>
> Tracking the negative is odd, i.e. if we add a stat, KVM should probably =
track
> if APICv is fully enabled, not if it's inhibited.
>
> This also should be a boolean, not a u64.  Precisely enumerating _why_ AP=
ICv is
> inhibited is firmly in debug territory, i.e. not in scope for "official" =
stats.

It is a boolean, but stats are all u64 in the file and the contents of
the file map the stats struct directly. See for example the existing
'u64 guest_mode".

Paolo


