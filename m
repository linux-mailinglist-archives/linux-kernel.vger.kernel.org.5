Return-Path: <linux-kernel+bounces-142502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D919A8A2C62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952562846D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AA3F9D5;
	Fri, 12 Apr 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+4yd2yx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000D3A8D8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918045; cv=none; b=sihUGb/XvdbLoS/BOant+cJrXR406OJKQmOgpHVw3lQMjh/TSd3vPy5WXywcXc/wphzuuZkVxrWJlbnlpw37XibVX7uugDNhyhURiBcRffEVfNs21OskzUV37Ng7ySlJvYWHaymnrhmcj4jk1vr/0KD60YXWnkL9l2jS2aX3pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918045; c=relaxed/simple;
	bh=aQ+0dgYl5PSPxKi0XkUYJ1LBvfFy3GUwsB3keBtJ+HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8VYAjqTEwqFrUQ1OPk/IBVZ+F/xyufmSxi17/LLucUvuOeIzgdebRSbJW2tiI2QCtRLmFfdifdYzDgZ68l06nFN1v/REdsBOSM+Rf9c7XR9t31YWp7Mgx+smxgbskV/yjexDgpsd9Hs4bv/k10N5QSwceZmMGTQv+tG/rgljwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+4yd2yx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712918043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQ+0dgYl5PSPxKi0XkUYJ1LBvfFy3GUwsB3keBtJ+HE=;
	b=h+4yd2yxoOsX8RkY0lvJGwHsQk7p1U+nNR5vGv4Jp+/JdR9MD53w6+aO2OiCCeDDJqsFA9
	qa4LDtEhCneuYDiGOXqgmMmUdCJreFazm3QmOeCZyWachdIqOx8T/7h467EXvTswrNim45
	l6iP8dMddSLRLt4x/IKL8wOW70wYnFo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-uBydvwhcM5W0Zw4IgWBHMg-1; Fri, 12 Apr 2024 06:34:01 -0400
X-MC-Unique: uBydvwhcM5W0Zw4IgWBHMg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a090878480so663621a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918040; x=1713522840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ+0dgYl5PSPxKi0XkUYJ1LBvfFy3GUwsB3keBtJ+HE=;
        b=FSy8LhKW3Dg1GafNjb48YkCRoetWqWF1zNO6gkdfhpCDG0EfquSZ8oDjOQL6maUqXn
         Ao0CgGMt2m0+4NtFIKI0f41i//SlfqYs040YkC91Xn2zD/VNlqJD4l4gfr0q2H/XEhvH
         rNNlWIlMl92WwfqhWf9CVGKc0407WGIm9hJX5nCbhsCOLqtK1x64wbxuUhUCfLGM3EJX
         ayB4aKA4Xyybgijn2j6pOXb9OnUYcWhEECliwnoH2wkpmvuqdGcmJeSm5gwhWkfwuH0Y
         yZWURyI8lN5psEh495w/iajHaAAOi7H3W+u4czbV/arOPQkNb+SSE3UCUKwCnIfaM/Cs
         BdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtUeFtUvD440euc3xkW5qOefc0NQfpJpFU682m/hYMMnNYhpPwJ65uO1nhrFBeiAVYDWSej9ygNe3yoIFcjrBTAapZTOsXGcsPIjMg
X-Gm-Message-State: AOJu0Yw0KH25WDWYUqwhJdT3wfD7uQAARlKCridalCm5Gc4d1R4jmxDV
	oePKe6F2z1shmHfYjoeEDuJdicCZWscR5WGpIBp4LzqS5La4Ox+aY+tYuSj8G3o6Z2fMa3oi2wo
	bWdxQhLpvFhYhuRcpABdo6SwD5POEGFYC2JOa0dHc3d2+Cl83htN99awNJGMlzjvyIm6hV+D4ZW
	jOzwd/TCKS0WvxaJjcJRz1l1/XMZkwRlZ0+rsMD1N0wP93weo=
X-Received: by 2002:a17:90a:7146:b0:2a5:be1a:6831 with SMTP id g6-20020a17090a714600b002a5be1a6831mr7419617pjs.19.1712918040023;
        Fri, 12 Apr 2024 03:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmKBGYsHbd2vrqtRgYlvMbYZxsQ0Q3qtnhsNOclN1VHDo60nE7x6ha1MFRXl0o4DhGGAkDEArkejLpWG7wisk=
X-Received: by 2002:a17:90a:7146:b0:2a5:be1a:6831 with SMTP id
 g6-20020a17090a714600b002a5be1a6831mr7419601pjs.19.1712918039715; Fri, 12 Apr
 2024 03:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411050257.42943-1-lukas.bulwahn@redhat.com> <bfjccttmurk7aajps2m7gcyl532rg7rnlutfhbvupsphxjk2pa@fx5onnkr7625>
In-Reply-To: <bfjccttmurk7aajps2m7gcyl532rg7rnlutfhbvupsphxjk2pa@fx5onnkr7625>
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Fri, 12 Apr 2024 12:33:48 +0200
Message-ID: <CAOc5a3P-LX0dkhLFxF-ggOxqkLqM0DJcXqccMJJqtF9U5rbEsQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ARM/LPC32XX SOC SUPPORT
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, linux-i2c@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:34=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org>=
 wrote:
>
> Hi Lukas,
>
> On Thu, Apr 11, 2024 at 07:02:57AM +0200, Lukas Bulwahn wrote:
> > Commit 20c9819ccd9e ("dt-bindings: i2c: nxp,pnx-i2c: Convert to dtschem=
a")
> > converts i2c-pnx.txt to nxp,pnx-i2c.yaml, but misses to adjust the file
> > entry in ARM/LPC32XX SOC SUPPORT.
> >
> > Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains abo=
ut a
> > broken reference.
> >
> > Adjust the file entry in ARM/LPC32XX SOC SUPPORT after this conversion.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> before taking this I just want to make sure the e-mail in the SoB
> is correct as checkpatch is warning me about 'lbulwahn' and
> 'lukas.bulwahn'.
>
> It's not about the warning, just double checking the e-mail
> address as often to mix my addresses up and looks also your first
> patch with the redhat e-mail.
>

Thanks for the hint. And yes, that is a stupid setup mistake from my
side or at least from the email server's side.

I joined Red Hat at the beginning of April and hence, it was my first
email with the redhat address.

lbulwahn is my 'official email address', lukas.bulwahn is an email
alias to the same mailbox. I actually want to have the commits in the
kernel carry 'lukas.bulwahn@redhat.com' and not 'lbulwahn'.

I have sent them out with 'From: Lukas Bulwahn
<lukas.bulwahn@redhat.com>' in my patch file; so, checkpatch did not
complain locally.

The gmail server however turns this into:

From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

I will see what I can do and send out a v2.

Thanks again for the hint!

Lukas


