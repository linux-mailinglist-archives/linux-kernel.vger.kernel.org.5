Return-Path: <linux-kernel+bounces-130409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34158977B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005291C2088B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69F152DF5;
	Wed,  3 Apr 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjKQ/kq3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E31C33
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167286; cv=none; b=nA7K0Ujz455Gv6Z4Y3g3+ea4thpsesHE+rgSz/uMNdcgKbwzWtTI9xsVolsbZCK/qLTpb0w6Y0XpAhyR5a+w+F666dS+nG3/pcFMV8+TYcoosn0+h2FMQnbX96arfyguqDZ7gnGfACwHyOt9p/jNpBYC5Oii2+nsGciSbJi/jRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167286; c=relaxed/simple;
	bh=SANhDgqHDAmAg+STmMcMR5V3bx656M+lNtf++ydYf8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx94t9mTJUfYsotJFWqC41HVD8E1R3R2W2qz7XYGaPx8QvFqM3lh0huXywIPBYKMmv4cZisP0soyAQeo1nOT3bMmjaGFFmks0YMt+pAzR7D1ap3MR3cNzBkPElvvGYhY8Jr16C/OwL2yvPiHy+d9ZXIJQvByQUgFojXkc7Uu8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjKQ/kq3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712167283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SANhDgqHDAmAg+STmMcMR5V3bx656M+lNtf++ydYf8k=;
	b=gjKQ/kq3rAeNM24cB3+2cEcHfcgSx7mfDHt3UXYEDmdeMmnyzMqmscY7pwPLy+3MivB6Ys
	/nzvDA/L1VVjSO+xQLLsnn0TAPZtQc+CJ8+2zEMkae4jN2GXFK5VU5OWmjAU89ozCbhXFd
	PcwCnKSSQePlu2C8NFSfA65IXpZltKc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-GCC8z89QPbyL-YLPG3hwdA-1; Wed, 03 Apr 2024 14:01:21 -0400
X-MC-Unique: GCC8z89QPbyL-YLPG3hwdA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-515bb20923dso107265e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167280; x=1712772080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SANhDgqHDAmAg+STmMcMR5V3bx656M+lNtf++ydYf8k=;
        b=eJKejAUeimMVRyp3qULMrMY8VMVi8GNyvQW3Ry3q5htH5QaALtJ9ov8dIeit83t/Fy
         5IouSF9aFc/xryHjzFJhI5RhSuyodUeMQG+MpTk70W75M8aHZIjZ550xFGLlAVInigVx
         R3AnZGgIBHU6q8SIplEz1t7OtFq8qG9TyEg2ePi3mKWrDDvxDqArZrYQJ1fgqd7+ief9
         dBAuwMFiDvRPxflGjpWnuE+qylCnWiu8aA1bdwbiEFG6DXkQBj8K0ZzMAZl7xx6rf6yu
         975LODo36Wq+7ZMGVv4eMbjdDIUSuLOREQFU6DO8Etu1KTg00YY6L0SEiuB6roe4mITh
         dnyA==
X-Forwarded-Encrypted: i=1; AJvYcCVhNVqI/CS7iETTJrUXC3y0f03lGKINat0mXVxb0zD1N/+SiIMGCtm6TP8ETOyes+DBPl9zxZiJ6uS1VzA2/wi7ikUyYT/JcU5IOPht
X-Gm-Message-State: AOJu0YwE8E2fQxymAeq817XHDT18Ox+V0NOWYYYTEd6JNhnYaKxuPwEB
	ZkMcPorRnvjwqT8Op8f/cdSeE0DtxPyExzRgloEyRot1Neezt394xlK/Tm1vvpvK+cLC8HYjdVS
	ZPrhj2BV0Gz5LWcXm0UNfIaCuhEm8ZeIlKu5/AqhDLBakXFKNIO8Uy81WVthyBgcbATbSnO3uNu
	B0alhqR54KJoGh6fVIFTRfzz6Z3Fl23iQRcslH
X-Received: by 2002:a19:750c:0:b0:516:b408:29d8 with SMTP id y12-20020a19750c000000b00516b40829d8mr185365lfe.25.1712167280371;
        Wed, 03 Apr 2024 11:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsHCLnGkM1BpiHZbXiNMydwILg0Dx9b9ONcEics16kkAN2UkOcuc+DuKnfvjgQIyARBLC+FCCMIb/KLJ061/k=
X-Received: by 2002:a19:750c:0:b0:516:b408:29d8 with SMTP id
 y12-20020a19750c000000b00516b40829d8mr185354lfe.25.1712167280055; Wed, 03 Apr
 2024 11:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb894653-6e20-4759-8dd1-7b03ae8614cf@gmx.com> <9d84481e-6a21-41fa-ae7c-1a9c52fc48ad@infradead.org>
 <5dbb3ccc-ea7c-4f60-800e-33df10dae8a9@gmx.com>
In-Reply-To: <5dbb3ccc-ea7c-4f60-800e-33df10dae8a9@gmx.com>
From: Audra Mitchell <audra@redhat.com>
Date: Wed, 3 Apr 2024 14:01:08 -0400
Message-ID: <CA+bDH-uTBoPjb+=XQKvb+euo=1swaiZUXOWJbL=zP4i0k8JtPQ@mail.gmail.com>
Subject: Re: workqueue: name exceeds WQ_NAME_LEN. Truncating to: events_freezable_power_efficien
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just pushed a doc patch to fix the references to the old name.
Please let me know if you see something I missed. Thanks in advance!

On Sat, Mar 30, 2024 at 7:31=E2=80=AFAM Artem S. Tashkinov <aros@gmx.com> w=
rote:
>
> Commit 8318d6a6362f5903edb4c904a8dd447e59be4ad1 is not yet in 6.8.x stabl=
e.
>
> Please push.
>
> On 3/29/24 18:53, Randy Dunlap wrote:
> > Hi,
> >
> > On 3/27/24 03:37, Artem S. Tashkinov wrote:
> >> Hello,
> >>
> >> There's a new warning message in kernel 6.8 which I guess shouldn't be
> >> there. Linux 6.7 did not have it.
> >>
> >> No idea where it comes from:
> >>
> >> workqueue: name exceeds WQ_NAME_LEN. Truncating to:
> >> events_freezable_power_efficien
> >>
> >> A relevant bug report: https://bugzilla.kernel.org/show_bug.cgi?id=3D2=
18649
> >>
> >> Please fix.
> >
> >
> > Tejun, should 8318d6a6362f5 be backported to 6.8? or maybe it has been =
already?
> >
> > Also, it look like Documentation/core-api/workqueue.rst needs to be upd=
ated
> > with the new workqueue name. Audra?
> >
> > thanks.
>


