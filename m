Return-Path: <linux-kernel+bounces-65959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16185546A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE5A1C221D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213513EFE1;
	Wed, 14 Feb 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfJnhvA8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13913B799
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944154; cv=none; b=QbyIEVe6BClSCySm2MXhX7kyvHdcoI/CfIsd4miaOmJsNB9YzysetojFekVhv7uPD/4Oqe0nzYPFDdSf+NurMrc+71c2DRURzwHEC5u59pqfUNQJaHTjMjusTfOytXt7u1z9Gdt4RKCjNF7jAtzMIvmX2jmkXYR8mLVWos875DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944154; c=relaxed/simple;
	bh=/Yf1On6PPx/GIt4Nh8Uwcd47eLJMbzpEgqXi7NBje+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKIiYPwrh6e8er40/Zbaz2NfMbWgny9cCljDHw9NXVsT6Nai2CMeiq0lYB0OzvxL0QTxrTyzmBUs8ADfPhisljgQq6whwybfVk+janSnvSLe70KyFTDEO0C1FFscmjq6CmWqG+SyoKYar57l++lFmA/zG85ddFOuMj5fI0CiEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfJnhvA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707944152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qd2aiPI9hKK8zn318SlhqtdzM62v1ZVBF4dOWFWdohA=;
	b=PfJnhvA85qrbL6krTc/g3CYlcSJugv0D16nJMM6zmVhegeqzwl4dXQGJmWordkTflWwyoI
	I652eFqXzvAX6SQQavtdW/HAHiP1LrnfkgQZek3taDzzZLozYFVp/O8/jMw+NR51UEIKXg
	Eb7goPQaZGrUlJc59KmLRre5pcDV4JI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-INn6TyccOfqSJMkmNjWZmg-1; Wed, 14 Feb 2024 15:55:49 -0500
X-MC-Unique: INn6TyccOfqSJMkmNjWZmg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51151b8de86so133246e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944148; x=1708548948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qd2aiPI9hKK8zn318SlhqtdzM62v1ZVBF4dOWFWdohA=;
        b=vuQvMdMx101YRDj/BLWrb0u8U1LKn06UIVs8yj47nCm3ZQNfalAGZbujRWr5JsGG2L
         rWwAtmP6i6mjuw109UAaWM8fEE4DgjjYLb5XFuAN5fC1elXdZcBfLub6HEqWrYPBMAik
         +X7BbZ6LSomgQG4UQbmrFoWYiQUHm0lI1O+0AuoWIyKHdz6ekDwrnQVWr6u7DARZ1IL0
         lTtdE6TPC4ti3FnncVSw1kEcVJ2oKP6kZc/1cEvoMuEbL/5TkcSxW7Hx5CV3lSZntYXC
         tjHGI3TPLVH1mPv97UNH2MzakqzPsLBQ6eZNuhGp8/G9Xlt9/in83g1TkyH5vvWfsiax
         4kyw==
X-Gm-Message-State: AOJu0YyX+fQZ1EqJWm/YuEbBhg2LTmhViY5tQJnzrBh8JPKSnzFYzpNJ
	UMTL9h3qvsH+XGDU7WQM5ZbPvjlTFaX+NaGJodO9vvAAMR5Bas/b8MiqxpLkNihwnraaMeTsy97
	umCotcATm96DYZ1QVO5zPVm3+g2XxvycDM5G6cNxwnuzIBLeeHKNUG2fuzllzxkHNSngdshMkzb
	HCra4snr3GX75ig3iNi3OP9ySbEKe8Fb2YPyap
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id u7-20020a056512128700b00511acd9c10dmr1759010lfs.40.1707944148508;
        Wed, 14 Feb 2024 12:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAdIviCY+cOciu/DFH2BuB1fIjxeT6eRhZTrKn5UOsY0w+5r+k1jdM88qSbORRZ0fRDTMriyN0YlhWiPoNZks=
X-Received: by 2002:a05:6512:1287:b0:511:acd9:c10d with SMTP id
 u7-20020a056512128700b00511acd9c10dmr1759002lfs.40.1707944148226; Wed, 14 Feb
 2024 12:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207184100.18066-1-djeffery@redhat.com> <20240207184100.18066-2-djeffery@redhat.com>
 <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
In-Reply-To: <CAGETcx91KahXY6ULXDpek3Xf6k4s646Y6+jn_LtfZPDDOpg7hA@mail.gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 14 Feb 2024 15:55:36 -0500
Message-ID: <CA+-xHTG2E3zMmQSKdEJHC=nnf1AX-UQ=tPY0DDHDsozP+-QL_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] minimal async shutdown infrastructure
To: Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Laurence Oberman <loberman@redhat.com>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:43=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Wed, Feb 7, 2024 at 10:40=E2=80=AFAM David Jeffery <djeffery@redhat.co=
m> wrote:
> >
> > + * Wait for all async shutdown operations currently active to complete
> > + */
> > +static void wait_for_active_async_shutdown(void)
> > +{
> > +       struct device *dev, *parent;
> > +
> > +        while (!list_empty(&async_shutdown_list)) {
> > +                dev =3D list_entry(async_shutdown_list.next, struct de=
vice,
> > +                                kobj.entry);
> > +
> > +                parent =3D dev->parent;
>
> I didn't check the code thoroughly, but so there might be other big
> issues. But you definitely need to take device links into account.
> Shutdown all your consumers first similar to how you shutdown the
> children devices first. Look at the async suspend/resume code for some
> guidance.
>

Sure, I'll work on adding that into the order rules.

> > @@ -110,6 +115,8 @@ struct device_driver {
> >         void (*sync_state)(struct device *dev);
> >         int (*remove) (struct device *dev);
> >         void (*shutdown) (struct device *dev);
> > +       void (*async_shutdown_start) (struct device *dev);
> > +       void (*async_shutdown_end) (struct device *dev);
>
> Why not use the existing shutdown and call it from an async thread and
> wait for it to finish? Similar to how async probes are handled. Also,
> adding separate ops for this feels clunky and a very narrow fix. Just
> use a flag to indicate the driver can support async shutdown using the
> existing shutdown() op.
>
It is rather clunky. It was carried from older patches where I
mistakenly thought people wanted this separate interface. And adding
threads seemed like overkill. Others have been working on similar
patches on linux-nvme that I was unaware of. They add an optional
shutdown_wait call instead of this interface. I had planned on
adapting to work with their interface design.

David Jeffery


