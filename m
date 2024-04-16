Return-Path: <linux-kernel+bounces-146416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4268A64F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9A1C2128F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22D577F30;
	Tue, 16 Apr 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJeTp0sU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFC6EB75
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252157; cv=none; b=tudMYcEZn+uRBnQXPL963iecIzvp3FEa01sXshqHjYGpTkEvmR0Sjgo36Yc3a1jEyOAghbFC71G31s0Md1tULqGJsD3DVyBTinwoPKl0IYHkivICYt4oPbRPiZUoLZAuI7FXL1hBIMNxmObJdvBUtflw4Fxn85OxfnLpBlGg4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252157; c=relaxed/simple;
	bh=ldhPdHnQri1NIU1BzeydenqBXGRsyMGWIV6zIFrekog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhKhj3pQKtGdg3GLWhMvoBgF9zM2EWiknKED6YcPU6mU1kjgPIJy3aWCZHFCFw8r1gKL9Bq+tp7evTM0ujEN/vw+BVrsshe7q+NGIlP8T+cbXUZbmayvce02SlVsexucBMPnQAhRAS8OOhAAcFK6Pt3imMea4qTLy6ki+EN4z10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJeTp0sU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713252154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmk7fIoAJf7GEF8X9MBAgB1EYb3WS+UQejNBC99ARNc=;
	b=GJeTp0sUYxrLnmQGnjA0OtGZUH6//BbABH870pNrshsfMdkTk/UYzMN7v/HZ4jcPSu+DZE
	neqxKmpo298R61JFCmDKjcU8xy3yW/P/NFlI+3ne/ibFPsPnpvwQ0r7puqHr4dZVV2Pij4
	hVmG6k5UR2eX4ZOQA5oRAlqFcZyU408=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-DTBF9ALBOEyXzcm-xrvFNw-1; Tue, 16 Apr 2024 03:22:33 -0400
X-MC-Unique: DTBF9ALBOEyXzcm-xrvFNw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a482a2360aso3704278a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252152; x=1713856952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmk7fIoAJf7GEF8X9MBAgB1EYb3WS+UQejNBC99ARNc=;
        b=TNFZokzQcGT6pe81wCkKZXbJeaJja9Szgwuvy6idKr8J7SEXG1OkeOySsizfY1ktYO
         kbbJzxkqc4E0Ns4e2rkSjN/tP+Kho2FULnuVmzECENIjwOblLlxm7tzne+sb7jtpCYJO
         FcIMRHMaUbbm1X1z7GWheSR+mbH/pO7B0jvAEyvx9PdYKLInpyQXaNRt8n1x1YeEvSxG
         EoLD6UfmznUfWRPHu7lsDSdNhWvUpVmstPzy5X9QnKzW//onM/Tfg0TUEDoHxVO0+PuB
         bXW3MkcJgnjnIcDXB6R5qCb7p2+yuelGxvUMpiu8WKsKnVwFiaZ7ZEqHbA2/hPA8frLI
         tZrA==
X-Forwarded-Encrypted: i=1; AJvYcCWH4m1FbgCA455L3V3Ott9nRrMEJ0kQvQ/pmjHIljunTFD91FAyvHgfMPq6+HJUs8UPiEe/6db7G303OBDHYihPvWlN6aQvV2K42bE8
X-Gm-Message-State: AOJu0YzmU9Oe9M4T23McOng4CUZ7sNFGp2xwqnnHLogCOOAhSQWHWaab
	hyV7imC0K+m+N1VKvcQk1UKzin3LRoWg0YUxVWYEv4xBD5AUoO80erx8l+ApQgO4ihdgndWNosM
	Rynzul0q6um+Bpb99Wv0es5Yau+fcpFe6s2YJivUHIfrv+NVEL68k28pb7KHR1UYqj5flsOM+o3
	jsmcUbrUXlYjUpZEtD5j9f+sovWipG873QGEhV
X-Received: by 2002:a17:90a:67ce:b0:2a2:d9f5:a335 with SMTP id g14-20020a17090a67ce00b002a2d9f5a335mr1738936pjm.21.1713252151760;
        Tue, 16 Apr 2024 00:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0nSUCySSraeo+VZj4qa38zef4B/ipzaDETOkrOV1DftcrQdIN+IeLBQxhGycZQajrqDuCtB4wEjmiaZLxDQU=
X-Received: by 2002:a17:90a:67ce:b0:2a2:d9f5:a335 with SMTP id
 g14-20020a17090a67ce00b002a2d9f5a335mr1738923pjm.21.1713252151443; Tue, 16
 Apr 2024 00:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163707.517820-1-kovalev@altlinux.org> <CACGkMEuvLmomcK7L7wQ-mGxAxof52xBAu8G4sB83gw4MkqeFHg@mail.gmail.com>
In-Reply-To: <CACGkMEuvLmomcK7L7wQ-mGxAxof52xBAu8G4sB83gw4MkqeFHg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 15:22:20 +0800
Message-ID: <CACGkMEth+QErT8dh_Oh+fz+wO6scLbRDUTkx86XDK7kX1uNCGg@mail.gmail.com>
Subject: Re: [PATCH] vDPA: fix incorrect VDPA_ATTR_MAX value
To: kovalev@altlinux.org
Cc: mst@redhat.com, parav@nvidia.com, edumazet@google.com, elic@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:18=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 16, 2024 at 12:39=E2=80=AFAM <kovalev@altlinux.org> wrote:
> >
> > From: Vasiliy Kovalev <kovalev@altlinux.org>
> >
> > The VDPA_ATTR_MAX value should correspond to the index of the last
> > available member of the structure, not their total number.
>
> I think it's too late to change. More below.
>
> >
> > Otherwise, it can lead to interpretation errors in other functions
> > when the structure (.maxattr =3D VDPA_ATTR_MAX) member is actually
> > incremented by one and refers to invalid data.
> >
> > Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink =
interface")
> > Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > ---
> >  include/uapi/linux/vdpa.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > index 43c51698195ceb..ab132a09565232 100644
> > --- a/include/uapi/linux/vdpa.h
> > +++ b/include/uapi/linux/vdpa.h
> > @@ -74,7 +74,8 @@ enum vdpa_attr {
> >         VDPA_ATTR_DEV_BLK_CFG_FLUSH,            /* u8 */
> >
> >         /* new attributes must be added above here */
> > -       VDPA_ATTR_MAX,
> > +       __VDPA_ATTR_MAX,
> > +       VDPA_ATTR_MAX   =3D __VDPA_ATTR_MAX - 1,
>
> Having a MAX in uapi is problematic as it may confuse the userspace. I
> think the correct way is to drop it from uAPI.

Too late to drop as well probably ...

Thanks

>
> Thanks
>
> >  };
> >
> >  #endif
> > --
> > 2.33.8
> >
> >


