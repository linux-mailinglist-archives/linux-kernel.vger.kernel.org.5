Return-Path: <linux-kernel+bounces-166766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E698B9F39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799D21C21EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832B16F919;
	Thu,  2 May 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fSeAHJLd"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6916DEB2
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669578; cv=none; b=L2qmBwRAmtiGv8i7YVanOF36ww1A+4rsuy2ZsU4K/FbAxpiv70aGPCE3ScuzjBsIp+/F5KI+TTmC/gqmQmzDHKxTKihEpIdGJDjOn15t84MwCy73hJCaqlO9yIoViAJdP0z8k7dHLidiC8DrwfSQpWeYxn/ELJYx1ZUnWJjNGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669578; c=relaxed/simple;
	bh=+iVetYd/2zRhT+FX8wdqPSI6yp+jo8e8xJ7vdZSCxFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYDiLrOsmvL0/n2DrxEm5hmb1EWLAJDgB7K3dq5U0ykO8pEb34bjhOk+GFYl/i2HTYTXzzq1Hsv1fFVC0gXO+NsyRmMLgHs/35YgTuJTI4kCoKiUpCIlDNYDBF0i8K0Cmk28gDdPi41pLUpVdmXqlYNbwis6ZHY+0VNFVzaU4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fSeAHJLd; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b346712919so1217857a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714669576; x=1715274376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTVB3YWm08VDi4zAi+I/ynH4gkycQ84Sr8pfNgobm6U=;
        b=fSeAHJLdPHMJzBMSgFvIKWCPkzkENRhkrQjXH5Ucioo3Rzi34FJwVoqQ2TKPKayhZ4
         ojjDP8iDir1ET+HjQQNqV4IInqC2xj0paw9nwELxjRgoeG7VYCgT6eFi26rlTmbGqrG5
         ZR8dKj+UaMFzZye/dVA8JhH+ThQK/35cdJI4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714669576; x=1715274376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTVB3YWm08VDi4zAi+I/ynH4gkycQ84Sr8pfNgobm6U=;
        b=lrnHUumpBPvW6hvyQuzlCxyL/7hV5zxwsrURW+qGUx8b3mp/Dbs4W2AwQV1yZ6VhiP
         eJMbDQZ3GApf6B3BJG4ffHWgvaUm1u/hV4bYIxI/o4q6yzeNerRNOwRmLkWSvzwru1/e
         wMCYMMXFcYiXQeOGb8c+Wszed+YJuC82a+i6DK5+902WosVU9K63x/W/Bp58KVTSr/Zl
         kVM0gl+pEtqvo7bz2xn4KqCcxWC84vcmESo/yWf2/arJsaBuMu/Zh7cf4Cnchdk5I7Bd
         vGfAMRlgbgON2V135ShZAwodwN3YlXdNw/jvQdAvACRLebwHiAQ0WOreURa0QrXstRPq
         2mjg==
X-Forwarded-Encrypted: i=1; AJvYcCUu5LyoTF11dMIYGzN11oeanPhNrlCZGqo+IH3bAw7Dig2RAUfuTtXEDkzCieYcc4M9UPORQpw9xdwNlQoRV/lbHz8jBGBgoWa+Pf6h
X-Gm-Message-State: AOJu0YwZaYndsuC+HMc8f/DmcLf13pH7Q1vVRKvsWsfPFqU56P7U0CYU
	c8vdg42WQTotz3SlbD71sLqb5D3m9+5JcuvjF7Vswk8zjUuNWkOkS5BApJQKudS6wx9TlP06/S3
	N+vK7swJj3qbK+2Q5rIWOJMISLX+9H/4ff+c=
X-Google-Smtp-Source: AGHT+IGYzqiVLsXYmxGN52mFmMxhMBAFi2I2muhtrRrrMpPjR8MkaiTBo2URxKMFsBJ7iC4B5NxK6zh6ECvOHTyOM+8=
X-Received: by 2002:a17:90a:ee90:b0:2b2:65a5:4c5d with SMTP id
 i16-20020a17090aee9000b002b265a54c5dmr323121pjz.49.1714669575593; Thu, 02 May
 2024 10:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a35bbc3876ae1da70e49dafde4435750e1477be3.1713961553.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a35bbc3876ae1da70e49dafde4435750e1477be3.1713961553.git.christophe.jaillet@wanadoo.fr>
From: Vishnu Dasa <vishnu.dasa@broadcom.com>
Date: Thu, 2 May 2024 10:06:04 -0700
Message-ID: <CAF+opq26i9XmN36sxSn52rmvkaagjYVh5_+jOHh0ZQOE=_erFw@mail.gmail.com>
Subject: Re: [PATCH] VMCI: Fix an error handling path in vmci_guest_probe_device()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jorgen Hansen <jhansen@vmware.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:27=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> After a successful pci_iomap_range() call, pci_iounmap() should be called
> in the error handling path, as already done in the remove function.
>
> Add the missing call.
>
> The corresponding call was added in the remove function in commit
> 5ee109828e73 ("VMCI: dma dg: allocate send and receive buffers for DMA
> datagrams")
>
> Fixes: e283a0e8b7ea ("VMCI: dma dg: add MMIO access to registers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Vishnu Dasa <vishnu.dasa@broadcom.com>

> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/v=
mci_guest.c
> index c61e8953511d..476af89e751b 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -625,7 +625,8 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
>         if (!vmci_dev) {
>                 dev_err(&pdev->dev,
>                         "Can't allocate memory for VMCI device\n");
> -               return -ENOMEM;
> +               error =3D -ENOMEM;
> +               goto err_unmap_mmio_base;
>         }
>
>         vmci_dev->dev =3D &pdev->dev;
> @@ -642,7 +643,8 @@ static int vmci_guest_probe_device(struct pci_dev *pd=
ev,
>                 if (!vmci_dev->tx_buffer) {
>                         dev_err(&pdev->dev,
>                                 "Can't allocate memory for datagram tx bu=
ffer\n");
> -                       return -ENOMEM;
> +                       error =3D -ENOMEM;
> +                       goto err_unmap_mmio_base;
>                 }
>
>                 vmci_dev->data_buffer =3D dma_alloc_coherent(&pdev->dev, =
VMCI_DMA_DG_BUFFER_SIZE,
> @@ -892,6 +894,10 @@ static int vmci_guest_probe_device(struct pci_dev *p=
dev,
>  err_free_data_buffers:
>         vmci_free_dg_buffers(vmci_dev);
>
> +err_unmap_mmio_base:
> +       if (mmio_base !=3D NULL)
> +               pci_iounmap(pdev, mmio_base);
> +
>         /* The rest are managed resources and will be freed by PCI core *=
/
>         return error;
>  }
> --
> 2.44.0
>

