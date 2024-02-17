Return-Path: <linux-kernel+bounces-69780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C9B858E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F86A282CD2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CE1EB48;
	Sat, 17 Feb 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEB/13Sm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE01E884
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708163548; cv=none; b=kn9zxLJOSLrW82wzSG4sXDY6XYzJVEQ8SLmYAIC6VBNCES8r476dpnQK47Eg+X3Xjgy3J1ZTmfsOdlZ4Y8Dn/PdGo180bFaCIX4EtBmthVO/1jWH/2IeO4tiPBM2Q27eTKL3TlOKsdg1WiE4/wYpMpsbwaXwO2rsdjh8YiLCoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708163548; c=relaxed/simple;
	bh=CEpjrVkbt/D7eyxsGXNC7Cbq+WSkmsxFGkAuvlaUy7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDwukiJNBEr56TQWEM+BNUMszumDpGxcCZeUVhVRRlziRWs8sgCEjYyJKgAvoZCHK2DWnGTZQ7ETQCQU5g0c75jjPK6cLb47LPSOw8MtnysT6NVoLlZ3APLd33pIKYe/IqXmTJc76EHun6I5zI7yTpgJe1UX6Gs5RWVf4hpXPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEB/13Sm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708163541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEpjrVkbt/D7eyxsGXNC7Cbq+WSkmsxFGkAuvlaUy7g=;
	b=TEB/13SmgVhT+Gp8SZN0IVIhQIUBU8cucNADbTyQfvt3HwcexTcPUtZHAP0eMpsW6sE8Z2
	77OTjqPxvEMxj8aZgZD0XuKngX6P2tbvcBehXnefGbltXoj8t0GjjdjVKNhcSdh6DOppRO
	Woh4KIEnrskWm5fjoC/+qM7pJIgPcIs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-F-xPwVJaOsCjjXY39eL22Q-1; Sat, 17 Feb 2024 04:52:19 -0500
X-MC-Unique: F-xPwVJaOsCjjXY39eL22Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-298c59f0109so2678956a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708163538; x=1708768338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEpjrVkbt/D7eyxsGXNC7Cbq+WSkmsxFGkAuvlaUy7g=;
        b=LdAA75wix1EIPcVt7mHU0EUyraNg+QXnRaPt/9Ax/BFeUCJDkSZV2gHJpqvOKOVDCj
         UlP90ZxxdWVlWMzkIEwEP7dySefEvjoXnKUuVif0bAKD0cxOcec7CjyakxottjLT9jY6
         CcaFLbwwS74omDF0Yj4lpuXGJJ9LxODe7dUqhOQqjpcXX111nRUKiv+WRIT9CTywarut
         yYZAhNHxXI1HSxr8jK1h2H/QUYxzm5zDiFVELOWMCM1wY6nac6PI+af0oxIAJJaJ9Ifs
         AORDYcvNFn2vXDk0f6wegENpuuNa/irDF4WdDHzTrFPbgrJ++DsZkaF05JTv0hrgC/K+
         vW8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/uX9cu+330ZRSwLuM7XVqDLXp+h7w7OgqQ/uBhCvD6Ygvnax7XHzC9JU/Aeb/zVWgUx7dKNa9xNHctbqFdVpiPEruGkRTuoBjqlpP
X-Gm-Message-State: AOJu0YwpUHj1XBJuNn/QbEzG8ibKgAAvoBqS/eLEyPA8BY4NPB2l2C5x
	ZurKj1lRS5WhIG638Ia593aznjkBm/dnCaek8lKiyGFJwkzn3MtUC9VBOprLRNTatPnZStnROhD
	Iwa0ZJ4OsLvBTApy+3L/y0b9D4iGg74sXxZ+F9Ve7AqNK5xObzXXqa+hB02FQ7rg1eEjaSnidI5
	DaiI8xSqa7iB2c+0O4kpskRoiwb/oHXDHMwTZc
X-Received: by 2002:a17:90a:d482:b0:299:4ae4:7a17 with SMTP id s2-20020a17090ad48200b002994ae47a17mr2981678pju.15.1708163538618;
        Sat, 17 Feb 2024 01:52:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYkfz1b4/wlthb+gBdlWaX30BfmMMKBTPc6rBpHGZjk3hiviXIU+8PW8obFj37j37I04puPccUKO3Yj+QIxP0=
X-Received: by 2002:a17:90a:d482:b0:299:4ae4:7a17 with SMTP id
 s2-20020a17090ad48200b002994ae47a17mr2981665pju.15.1708163538304; Sat, 17 Feb
 2024 01:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215133631.136538-1-max.kellermann@ionos.com>
 <Zc5sMmT20kQmjYiq@google.com> <a61b113c-613c-41df-80a5-b061889edfdf@zytor.com>
 <5a332064-0a26-4bb9-8a3e-c99604d2d919@redhat.com> <87ttm8axrq.ffs@tglx>
In-Reply-To: <87ttm8axrq.ffs@tglx>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 17 Feb 2024 10:52:05 +0100
Message-ID: <CABgObfY1GPbOhpvnds7tOD5xLOPO6SAmJULDWpT_Z2OGGR80aw@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/entry_fred: don't set up KVM IRQs if KVM is disabled
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Xin Li <xin@zytor.com>, Sean Christopherson <seanjc@google.com>, 
	Max Kellermann <max.kellermann@ionos.com>, hpa@zytor.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:45=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Fri, Feb 16 2024 at 07:31, Paolo Bonzini wrote:
> > On 2/16/24 03:10, Xin Li wrote:
> >
> > It is intentional that KVM-related things are compiled out completely
> > if !IS_ENABLED(CONFIG_KVM), because then it's also not necessary to
> > have
>
> That's a matter of taste. In both cases _ALL_ KVM related things are
> compiled out.
>
> #ifdeffing out the vector numbers is silly to begin with because these
> vector numbers stay assigned to KVM whether KVM is enabled or not.

No problem---it seems that I misunderstood or read too much into the
usage of CONFIG_HAVE_KVM up to 6.8, so I'm happy to follow whatever
FRED support did for thermal vector and the like, and remove the
#ifdef for the vector numbers.

Paolo


