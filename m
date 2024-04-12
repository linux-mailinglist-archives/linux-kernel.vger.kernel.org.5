Return-Path: <linux-kernel+bounces-142115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813C8A27B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E90B22130
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0554654E;
	Fri, 12 Apr 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbNeCtcg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107322606
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905906; cv=none; b=AyCmX9B4UlzLknapGcwZO1C4Mq06KWfd4loA/gR+qlp6w1Ng7gQ8Fr8ec5rw0u5rjXVxNLzLsSawUhoMonsrSLSpmCSee1UK9/EafrWuDcYukotFKh6FrFjS8UIJVW8/MalgapncNmVMRTwr3htz+8jjyhXnXhbd4SreI5KFZUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905906; c=relaxed/simple;
	bh=V9ySPHFHra331Yt/URq8+X+I4ysMrTRGrhBFu5T7R4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IYXKN+/nP6iwxE2xhh0sKXocbNFWKrRNEdjzmUlYSE5fYmaIg5v5QSUsFpT75kaBNRF3wKMn08ILJongASyqvLZqnxzOYjO287ktxw1ykT5l8lFdH6WSP6y3kwuVMlXMWFMambgtUcCih7msLKQxqhxiQv0LVZC9M9YCqqD+UI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbNeCtcg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712905904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V9ySPHFHra331Yt/URq8+X+I4ysMrTRGrhBFu5T7R4g=;
	b=ZbNeCtcgRoqqqEI4rVTBuTixUyNpqJv0qRW29tUgcZCF6DqNJ39BRMPLU1Nzb5kzQKW67k
	hVLBP/eEOb9xmXY2YcNX5EO34q8H4/pz2WJ/ACIa/raFu3hsWT9LJXL0vO5sPkMysKnawI
	3ake40yzNdQwXqhM6usP9Eq2mN689No=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-h7QdyvgwN4CXDOpB98DDVA-1; Fri, 12 Apr 2024 03:11:31 -0400
X-MC-Unique: h7QdyvgwN4CXDOpB98DDVA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a48f935627so572900a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712905891; x=1713510691;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9ySPHFHra331Yt/URq8+X+I4ysMrTRGrhBFu5T7R4g=;
        b=fRy02I0l6s7FX4lFXTjxW6m0XR2zfnPT4bZJ8gVJ3g2oPB8AQfmKokBy/QkyHb0Da0
         mTidI815TyT9cNcGL+2fx6M+svdQAJCAT/E73YUMOyeZZYZH1LAfFFVwRX7gz02HW6Za
         X967nuuWwfnj7gHus4outN8l8g+yQAUaDgKLJrqDKePvRW5+KDrLSJC+okrJd2XL2vXJ
         t1eveRubzmXGo3/Egeef96gFn+hvuv+4ZE4QqBw6OVaReiu33zXgA19c95sd1CvKNYj9
         hk6PgUGZATXA67sVrCEdC6ZPrXWYCfLnawqFQetfFKY63JnzxrxTUC37nOv7yhcF9UAZ
         X5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUPbGKZfB47NqfWuP+D/DD5+Z3giB5MI4t8C2tzf/vJW91L+Zis90N9E8b+pLJ8acgI1VBamKIjXCfY6x2YxgTT7s/joCDyH3TBm/Ot
X-Gm-Message-State: AOJu0YxzSQmo4qdoCd3+TMMOTqGslvwCoPLbi6h+9vubbjMVBQ2QZwuf
	N9tVO7+tb3rBxM6x2umETnZuWv52tknBspHnFsR4+TiIQvSHvb7O3fMNNoRtYVlaNjtyC7iMpq8
	wFjf+ZMmYba44SG12E2tmV3hMeRCmpoP7fKWq+jYOSHCrc9UXXGysJQlrFE1ABf5TPwCDMJp7Kx
	qSp1y4N34eqatMVg2CeSX+Sb3nS1IR3kSvoiJ+
X-Received: by 2002:a17:90b:19d0:b0:2a2:2b53:892e with SMTP id nm16-20020a17090b19d000b002a22b53892emr1531772pjb.32.1712905890787;
        Fri, 12 Apr 2024 00:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhB8Fe6/Taq6ZeJsX79391aj4U5l0Wu4b9n+gMtxFfFf7avWd+jelzxqFd1vgXfo/L+4G6ZPyVKQslNCiOcoU=
X-Received: by 2002:a17:90b:19d0:b0:2a2:2b53:892e with SMTP id
 nm16-20020a17090b19d000b002a22b53892emr1531760pjb.32.1712905890476; Fri, 12
 Apr 2024 00:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411050257.42943-1-lukas.bulwahn@redhat.com>
 <whpjtk2nmbft4dqndhealztzxh5du4uemqmmizguwvhmfa2htm@qcklwqf7j4d4> <xn4dyzwe4quhrpiqrvdikx4f46eucw25kmwfevcyt3s2mvggjl@enzbluravbt6>
In-Reply-To: <xn4dyzwe4quhrpiqrvdikx4f46eucw25kmwfevcyt3s2mvggjl@enzbluravbt6>
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Fri, 12 Apr 2024 09:11:19 +0200
Message-ID: <CAOc5a3Mi1_oAOrA9t-2=0TVbs9Xr_HPBr_O+L7FgyAiRdf8sPg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ARM/LPC32XX SOC SUPPORT
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Lukas Bulwahn <lbulwahn@redhat.com>, Animesh Agarwal <animeshagarwal28@gmail.com>, 
	linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:45=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > -F: Documentation/devicetree/bindings/i2c/i2c-pnx.txt
> > > +F: Documentation/devicetree/bindings/i2c/nxp,pnx-i2c.yaml
> >
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> >
> > I guess this should go through the arm folks?
>
> Could be argued, but I guess it is easier if you take it (because the
> conversion patch also went through your tree). Just 2 cents...
>

.. and I am creating my patches against some recent linux-next tag.
So, the commit could really only be in your tree and the arm folks
would not apply it because the referred commit is not in their tree
yet (until the next merge window closes and they reopen a new branch).
So, as Wolfram suggested: please take my patch in your tree on top of
the referred commit.

Lukas


