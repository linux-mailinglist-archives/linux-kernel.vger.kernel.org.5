Return-Path: <linux-kernel+bounces-39995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27CF83D8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEBDB3F619
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7616712B74;
	Fri, 26 Jan 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+eRMMBX"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D610A30
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264442; cv=none; b=LJwUfrf61SVhKWDOgVVxcyjWaDLbV4VAq0wL8/LmDvVOeG9UsK4ZNsaywXMNV77vMsi66yxSt5ouWu5YhGsyz6iS3qiCeQqlu79kej4FDWPgnwwdqSl+Aevqp3xCs4S5FxXo4GE0x3gQSVhWV6R+hE9I/1By+CeeujMKmoaWvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264442; c=relaxed/simple;
	bh=rBGeSyPNqjhuzAEmekJshtonzu2haLkY5wb3EOsf3xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZkkCP3ZKL9jhL6r2BQ3vbkmLmnwPjK+36/wRyVkFOgMWTfORRt4/nIgTyIzwilFmiVbRUczUutzUIE1xF8hrX/wo3O5j+JuOIHK5rBiLgDJDT2nNYW2yWr2SkMMkALE4Ocf62DUXZjIO22BylKx81Mv/miPLM/NlT9bASbSaaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+eRMMBX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2144ce7ff41so104722fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706264439; x=1706869239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLfeKzwR+Z8RiGM+i4K1CjO8rfuzmqOpJM35c/+oae0=;
        b=U+eRMMBX3ao4Wh15pTZjscrNgBMdWMJ/7EZHopnFr4Lehasvb6qyhOls1apU3HMoKF
         JWeLCsykXGb1h4nye6C5y0qDm3FKOExEuxKdq1WHNbVqRddjBe9CcHwY0D0Dif48l7Kr
         Nbyx4vTVGL4VkrpqOqItUki6vDOVcA2BfsHAzrukXPLKLr98lu3n3nGH+hOIxdRL6+FX
         GtjQ7B9fVx40ACCfX1ZF/d8RIbouyF9cdpYUN6IhxpXZiHOR3bKT3/zm6HRWA8K5ZoGf
         QpeawGQ6LRvEvQ9u6zTayMuf2B4wDUvP+yPOdbsiuYVbwALe2M3S9rXt+5MkmkSylisj
         2fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706264439; x=1706869239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLfeKzwR+Z8RiGM+i4K1CjO8rfuzmqOpJM35c/+oae0=;
        b=V2fZkf0LQvhn5bgk2qdrs9LJTScNSactP+j4KEXvU92raNNGJnCvdYZRhZTQT70JOj
         U3lcR488mfXL5sLDcjyrtPaEMw1+U/duU7xob2J5H6fvT7ZP4QRiHeDhz5P6n9fFf3ke
         M4uiM0j/BfCPRqTcwdAjzkrRdSV8u4XX06Yw7raUv1K5rRroftRwWIWgHDK3E4dsYLVa
         QPgkThxCXV+ORZpK6kO1ShmPVp2fKx86l102T8fjTNnaMzxFiELUKjFCv9R5iE+7qgBX
         +sM5gVhoyQWyalrKstrX07I1lTlYGmObskP+/8oo06gGpG18aqzrf26Qx0aztCl1CVhQ
         lNPA==
X-Gm-Message-State: AOJu0YxcxbNFtfFGLisxaMoKgwGF8zPS0axuwRN56zHRWhEThJlJDoDj
	SXTIoNSBdmn1yZjm0+ziFEh4BpPzhZwhmB/DqZAnQyBNo+de7sgnEwr0kfwgZXG4PSFq2duEZsk
	1V+pNRpo3EFY8JDP7czRBghCBMR/dcmiN1W1c
X-Google-Smtp-Source: AGHT+IHvbfvU3z3obD92Fj0vi9wydfzuO6UhJiuwiqh10HZe5oaVqolyaLk9ub0kUBcctwQE1vUI0HtDYfsMFMjTRD4=
X-Received: by 2002:a05:6870:b6aa:b0:210:9bc2:a9cc with SMTP id
 cy42-20020a056870b6aa00b002109bc2a9ccmr934687oab.83.1706264439163; Fri, 26
 Jan 2024 02:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000fd588e060de27ef4@google.com> <tencent_613652973C377A4AEC7507777B66C63C8309@qq.com>
In-Reply-To: <tencent_613652973C377A4AEC7507777B66C63C8309@qq.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 26 Jan 2024 11:19:58 +0100
Message-ID: <CAG_fn=WpdcrDjxSzPxhRzEGp3jFtp==1DkfkovoF39kUgkjB6w@mail.gmail.com>
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:36=E2=80=AFAM 'Edward Adam Davis' via syzkaller-b=
ugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> please test uninit-value in virtqueue_add (4)

Hi Edward,

KMSAN is currently broken at trunk, see
https://lore.kernel.org/linux-mm/20240115184430.2710652-1-glider@google.com=
/
Therefore syzbot is unable to test patches before a couple of changes
reach upstream.

I checked your patch, and it is still triggering the same bug, which
is expected, because there are whole uninitialized pages, and the
patch below only initializes two instances of struct scatterlist that
are unlikely to be cloned to fill those pages.
There must be some non-instrumented code that fills those pages with
data, e.g. a DMA write, an assembly routine or some VM-to-kernel
interaction that KMSAN fails to handle.

>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git fbafc3e621c3
>
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 9d1bdcdc1331..4ca6627a7459 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -427,7 +427,7 @@ static int __virtscsi_add_cmd(struct virtqueue *vq,
>                             size_t req_size, size_t resp_size)
>  {
>         struct scsi_cmnd *sc =3D cmd->sc;
> -       struct scatterlist *sgs[6], req, resp;
> +       struct scatterlist *sgs[6], req =3D {}, resp =3D {};
>         struct sg_table *out, *in;
>         unsigned out_num =3D 0, in_num =3D 0;

