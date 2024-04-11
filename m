Return-Path: <linux-kernel+bounces-139615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFE88A0562
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A3C1F24036
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007860EF9;
	Thu, 11 Apr 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCHcIdd2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A1F9C3;
	Thu, 11 Apr 2024 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798283; cv=none; b=EBhAz/7jFlrZZ7unQfoU9WeF3SeiEiQ2WzJ5ZDzw3LGxyyyMX4KfKdbQ0eohFVraHoOwSIqA07Y614FfnGCh0FjDSVCcACnZoQCNPAE+6WLV9CiXD9MCaJxjndhMg/VBls2xvKzXxKdkH0KOGLYPOmZpSg38Du9qwILnz92ryYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798283; c=relaxed/simple;
	bh=IdNO/D8xCAne2eE4Ei5IJ6ZuRNSULbSmSxqEk1i36xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C70VgkH+DbTX96qJfn+PAjJuqrXDAwGM/hEew8/N1Xi9nR430PKkoOhaFFiDlZnvzRxgT7iKdEO2wkRy6aWh3rulny3rcdL8kaLOsdj6XQ/Y3OR7KlHUOpwZJJ1lDR8L2JVspU4dQyduIHQlay8IbNRJwY+8gw+3eNhFcFyZBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCHcIdd2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5213f0f85dso129853066b.3;
        Wed, 10 Apr 2024 18:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712798280; x=1713403080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdNO/D8xCAne2eE4Ei5IJ6ZuRNSULbSmSxqEk1i36xg=;
        b=QCHcIdd2+sWA5RxIc1sk4QNuaKkvXlFzAvEmq1lWY7Zw8FFDgbSm14BCScS4jtKmSl
         rspKlddqF7dMx8G1A9ADkaCmw7Mq5f8e9Mp/CRwv8GVTPjBiNgF9bJ4G+oS3GgvSsTDI
         NW1kuIdl9C6W5QOr6KWT4dV+vK1Dp+LI0JyHF0ipqWr+j3dZBYTanhpCwBGhOGoG3uek
         QBqOO7JLdKJO+R6rcxH9m9KZLTDQsVgKI2rY7bWsx/4wi2s2ea8o0CEzpruk1w8l7Vc7
         mJZas04jC5INde3Pf6NRrso/Yh6th8SjS83Ilq2rARpaCN0pLq4ve3d9cs2VzzFINhDM
         0Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712798280; x=1713403080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdNO/D8xCAne2eE4Ei5IJ6ZuRNSULbSmSxqEk1i36xg=;
        b=xDvPNtnWgS4x/Muy5IyWYhceTTm/DAtds/52UyHxXXfRHPPeB8ip/fpnvR9oRDeu4q
         xaqVRd56rWfQwz6ZrceAcJxGw5mjMbQCbEdCoyE62ma364I2dTQmoYE12FnuS09EbBIE
         Q+yR1CItdMKrnaFa798IRglFqdqPIX75PrGcz0t797tSjdX6J4c4l4HCA3zvWXn1Ygeb
         RxrH9LoS38njSTZzcxut9mifQPEInu13wwFa8wFgrzktNdFxABgFelpPkAK397kqOnu9
         brDsUCumbF3Ymj9Vv8UVVqGhnZrYeCaM9I24575Iv7p1IdYze3T/OxfJCKuG9nj/tzjP
         g5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQSEmfjONypy+6yg3rWZE6Cyms9ax8Gp/KQBiGyZGeWfpJ9AdAUyz1LoiPopeFNK00G6zk49zaEa68rVyZ8BdLtfUNESlY3jHQg==
X-Gm-Message-State: AOJu0YzLXeTgp7hPS9RqVtXuHou4xoZs6acxaumkgioZG4dBio20OKhs
	vpq4cHvzSfPC72WpEbNw3Uqo6Is9HrDWN+KsJaPwZHTBzs9WezyVb17JOcoVP7DVpqe0/t8gwZD
	INLM9MEMqYPwUn34Qg0j7uNlbcqM=
X-Google-Smtp-Source: AGHT+IGznegtYWrOTSeB/hsLXCP7bBxdABTfr3ekOz4Guuzj4H4gYHx/vhBUmH8Pyy6vS2W4xXdv5eVBxVplZT7YGOY=
X-Received: by 2002:a17:906:7308:b0:a51:885a:c0a with SMTP id
 di8-20020a170906730800b00a51885a0c0amr2807595ejc.61.1712798279840; Wed, 10
 Apr 2024 18:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
 <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com> <2d5e3b6c-3a66-4f74-8367-51fa55bf0a1a@acm.org>
In-Reply-To: <2d5e3b6c-3a66-4f74-8367-51fa55bf0a1a@acm.org>
From: Sam Sun <samsun1006219@gmail.com>
Date: Thu, 11 Apr 2024 09:17:48 +0800
Message-ID: <CAEkJfYMcLycLfaRzhn=DmQjAuLHn29wSXN0b0Zf0oJr=sDVBTg@mail.gmail.com>
Subject: Re: [Bug] UBSAN: shift-out-of-bounds in sg_build_indirect
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, jejb@linux.ibm.com, dgilbert@interlog.com, 
	syzkaller@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 12:59=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 4/9/24 05:51, Sam Sun wrote:
> > We further analyzed the root cause of this bug. In function
> > sg_build_indirect of drivers/scsi/sg.c, variable order of line 1900 is
> > calculated out using get_order(num), and num comes from
> > scatter_elem_sz. If scatter_elem_sz is equal or below zero, the order
> > returned will be 52, so that PAGE_SHIFT + order is 64, which is larger
> > than 32 bits int range, causing shift-out-of bound. This bug is tested
> > and still remains in the latest upstream linux (6.9-rc3).
> > If you have any questions, please contact us.
>
> Thank you for having root-caused this issue and also for having shared
> your root-cause analysis. Do you perhaps plan to post a patch that fixes
> this issue?
>
> Thanks,
>
> Bart.
>

Sure, I am glad to help! But it is my first time submitting a patch, I
need to find some instructions. I would appreciate if you could help
me out. Also, I need to double check the patch to avoid introducing a
new one. It might take some time.

Best,
Yue

