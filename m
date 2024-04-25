Return-Path: <linux-kernel+bounces-158906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44E88B2685
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64D21C21DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6614D6EF;
	Thu, 25 Apr 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDJ537ID"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B21DFEF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062664; cv=none; b=nNFcWYh+Es2EpIZZamtE8mQlfhjgIDaHp8Ng8rBN1fFATPcUJnzmntJ+TLAfiOpLpwx45ew6l6erjiqHM6vgQVA/kIdUNNkMqaaRdYTkf4Wc7Dvm9s6u/IOlY+hLeMGzKoiYNAoFioArdtBcl/Xs+jBXsxKtuVqyTIAUu7XqSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062664; c=relaxed/simple;
	bh=8QT4wCkiEvoE5CtKsOvw2EHV/0k7lOv71PaUreO/D44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mr0XMzZPr32rYOybtk6p8abYuHelQJiVXgI6PJSvN2Dc7E17OxDLnBV7nOm9AX//aAlkjKHtqmF3cAi/I3xJo9du4xJQjBxIAziS3s0DlXw63mSwzUH7cCNQ4GbDt8wYcNn51U0DqH2pkugzjP5nDV7m8uuho5eJxhEb+oxaTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDJ537ID; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61891efba06so20613747b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714062661; x=1714667461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuEvZw0xsxqnkJCMkgLTL9fi/8XUYBdqC5QY5sOCErc=;
        b=oDJ537IDZtrd4cxe/XN9mbLvdn2CvO/sGQQOt/JZMAMXRh/sXUQRfA3hJbHyXd1fgR
         tQri3Pzvf2C1JJ/h/xziUwC8RyoV61f8F9R9RKo6SmuePNy77Wmq0iK/ln6xJ8gYeH2b
         eCAzty7Kbq4INSaYuZbKM4dJdcsMJrTQIMoJsJCEMPFPYhblKZJl6fcvlFXWfF44Lay7
         Z3uOd8fAN+zzoW0hbCOHhvbGNni42Ed99RQGAyIOqjqe0q7Tq+hnJCZTN9VGGfslPINm
         DGfKIxGkF809kvd5DGsHdtutKVRvab+TXsICwjb7MOmAFlP7q/HVIH7721MVUcICxPru
         qpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062661; x=1714667461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wuEvZw0xsxqnkJCMkgLTL9fi/8XUYBdqC5QY5sOCErc=;
        b=fcS0Hpil+sJfhxU+rbPKXYHaWyA5+dxNdyyb8tq2jDJz4yaYK/3ObQ6AhcVhsQ1+Di
         adMucTA53WgJ9bTfPl04kC84QUKh6lewiuOwGmgoSm9/8ZN5PUMhpTuXdC5N4ICH7Eg9
         AskoG+hKWhmsBJMWDft77jckRLkCclCm9cWnMe8w013MIKZVwOGfNbnA5mkQ1wxFKGTn
         DrtBZY8BuH3a0lNeWvhPpj9ZTduF2cvNOusUsvsSyLGcEqdnmYWCzO5J28iw0RXQLsPH
         sLeRSrC2hbwqdMhZlQJt0S/iQwcRtU++xv6wN4Oos/m/XZ2HJyDVQ1oTucyw6pOViJ6Q
         r0bw==
X-Forwarded-Encrypted: i=1; AJvYcCUoYVBwYFLx4UYbg6P76hczUWuvjQLq7lATbrTL75ufSfhLWVH580SYKrWyGjEVUQNFQAsG4hw/r1KFwLMeYsB7PBt0LQDQNo478prm
X-Gm-Message-State: AOJu0YyHMRWKS87nIcs+Ww5DSyW/0LqN2zSnJkapxXLGqmkEbuV8kgWk
	1NCfPa2fMz3tVEtzaChodXJfc0uAc3n0OJ9TEW4N8lZFrYKCtG2CnAQ5/Lanoryxa0iYUFMQ1pp
	Ong==
X-Google-Smtp-Source: AGHT+IF7ewIFf4asaLVdd36tPhS/2ZhvyuhQ5JaF/1Gy7paYiH3nJdGJyIbHKj5e9VA3LCVIDmZCPxJhvX4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e386:0:b0:61a:b2d4:a3fb with SMTP id
 m128-20020a0de386000000b0061ab2d4a3fbmr1243077ywe.8.1714062661606; Thu, 25
 Apr 2024 09:31:01 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:30:59 -0700
In-Reply-To: <9c6119dacac30750defb2b799f1a192c516ac79c.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZiKoqMk-wZKdiar9@google.com> <deb9ccacc4da04703086d7412b669806133be047.camel@intel.com>
 <ZiaWMpNm30DD1A-0@google.com> <3771fee103b2d279c415e950be10757726a7bd3b.camel@intel.com>
 <Zib76LqLfWg3QkwB@google.com> <6e83e89f145aee496c6421fc5a7248aae2d6f933.camel@intel.com>
 <d0563f077a7f86f90e72183cf3406337423f41fe.camel@intel.com>
 <ZifQiCBPVeld-p8Y@google.com> <61ec08765f0cd79f2d5ea1e2acf285ea9470b239.camel@intel.com>
 <9c6119dacac30750defb2b799f1a192c516ac79c.camel@intel.com>
Message-ID: <ZiqFQ1OSFM4OER3g@google.com>
Subject: Re: [PATCH v19 023/130] KVM: TDX: Initialize the TDX module when
 loading the KVM intel kernel module
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Hang Yuan <hang.yuan@intel.com>, 
	Bo2 Chen <chen.bo@intel.com>, "sagis@google.com" <sagis@google.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024, Kai Huang wrote:
> On Tue, 2024-04-23 at 22:59 +0000, Huang, Kai wrote:
> > > Right, but that doesn't say why the #UD occurred.=C2=A0 The macro dre=
sses it up in
> > > TDX_SW_ERROR so that KVM only needs a single parser, but at the end o=
f the day
> > > KVM is still only going to see that SEAMCALL hit a #UD.
> >=20
> > Right.=C2=A0 But is there any problem here?=C2=A0 I thought the point w=
as we can
> > just use the error code to tell what went wrong.
>=20
> Oh, I guess I was replying too quickly.  From the spec, #UD happens when
>=20
> 	IF not in VMX operation or inSMM or inSEAM or=C2=A0
> 			((IA32_EFER.LMA & CS.L) =3D=3D 0)
>  		THEN #UD;
>=20
> Are you worried about #UD was caused by other cases rather than "not in
> VMX operation"?

Yes.
=20
> But it's quite obvious the other 3 cases are not possible, correct?

The spec I'm looking at also has:

	If IA32_VMX_PROCBASED_CTLS3[5] is 0.

And anecdotally, I know of at least one crash in our production environment=
 where
a VMX instruction hit a seemingly spurious #UD, i.e. it's not impossible fo=
r a
ucode bug or hardware defect to cause problems.  That's obviously _extremel=
y_
unlikely, but that's why I emphasized that sanity checking CR4.VMXE is chea=
p.
Practically speaking it costs nothing, so IMO it's worth adding even if the=
 odds
of it ever being helpful are one-in-and-million.

