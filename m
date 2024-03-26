Return-Path: <linux-kernel+bounces-118744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348288BEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F707B2219C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC26CDCC;
	Tue, 26 Mar 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScqLdAF1"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0867C53
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447613; cv=none; b=Y/eB53DcCgAcLK5ENzwROnPiiMvbG4BpdJxyZDwO+mfowvMGbqkvUvn0Amn/gkenjcO3F9plvvj0Q3isimzT5X8B2kzzGJ9dtYQhw6TjMj7SpwDScXlOr433LiC0vzWoVA2moenA8PySW7aw/qMSDd34NS8Yq+7CeV1R8KPSbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447613; c=relaxed/simple;
	bh=GxmzQZ+iXFCICcVBTe8C5yEiXMFe0+1sortxqlulsbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjisgF55PGT/4wU0/tcUKmL9DebUaVy2uPb3ed+V+t8yl6qvGAOAqHWRgdxyhL27SXPgb1bIGEH2SgUzY6M2P8EDrYsQ+rMVLssc4k6C/lAItk2zwEGSBxWV7gb62bCuKdB8UH7+dv243jSzIfij3NaHD7l/23tqMSGJJqd7iZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScqLdAF1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3147334a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711447611; x=1712052411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=204vu/M5oh04X0pmvVV6HqCYUaLzHjxreWPTSk3PyFA=;
        b=ScqLdAF1yBF5jIaIVA0pHKDIichucx5u+h3xkP5ssXqGK5d4sBNrjJOhswtTK3Gbtr
         nTP3Yte9RDPLQ0EcWZ6jfpQ2X59D2vUlqio+GaHiyGJHMKFUmwgv6PlXpDz8AKh9ltD6
         ev79+e3g0l5UJQgQHtbDEC0RWyoFqF+H7ViHs21lJ4E9rFB+KooQDzn4DxEKdrnyBEDx
         HVINSrL/C1TqV6KMD8F50XOSvzCCbPQYz+ViOyS35CKF+8shYCgz4Dbibu3xhT1NkNTL
         t+fbp3v118t+B6DnjPFWA8E/0nOu92dLrcQiKuxEvxtRJCIWSzOQRfbcMf+ic7kQ+nce
         uWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447611; x=1712052411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=204vu/M5oh04X0pmvVV6HqCYUaLzHjxreWPTSk3PyFA=;
        b=a7F79Z8agcTe8B4gkhwLvWTe26wpHeEjKqkiX+yTJA9DW95zRslcaH/U914xH1Wsku
         VpZubKsSiRbjEJVYJlKK8zwz/XM9g0JSKmJmtHAeRCHs562/g4sSpQpMBmDbb5G3aD/2
         q9+W2d1R2mlV22sWc1Wks7EEpK1gZU5Z8DKVTYq0sBiNOff+Jqu7P//177zMTAxvYnvL
         l7xFtQ9EdZlr9Ewgtwe1LeSCeyPzE25xcy0a+ZXROdHpaQnn7XFvt6V0RcGgcI1G1uvN
         DF/SUBgiX7sPthpiK5kYC8qskV8t7uvZVvpLa01kR3v/JkipdWaefObWEI/Jb0x3sI+l
         w3tg==
X-Forwarded-Encrypted: i=1; AJvYcCULdzKSIVPlZARON3bc+7hG3TmKtLWRbnX2z+6WTulNUskgMunXm4dxfYtfyWZUb7NSyXO7LIZqpG6UXtDJ4c82sjp4z2fx0K2dCXfS
X-Gm-Message-State: AOJu0YypizmniemqeUGDw80w4ncAw9jRWO8WoVcpnOKIZvzWUMLwAA4H
	xd5WYQyh/jo2kAk/mQ7FpOo8Xn8AElr/FuQ+L9BDY47RizEs9qyn/65FFtez18kcnTMOh+ku7S2
	fgsJWHJYhF/dtEZeHZAWAuXpuGsZWwa/FXyw=
X-Google-Smtp-Source: AGHT+IFW5gYacn89VMrKYuKxqzen1ILNsrP5HSh0oE5rx87Y168xlcJnykaZnE9g5gcGEeKfsFeqCr36OAXLSRwwfKo=
X-Received: by 2002:a05:6a21:3a83:b0:19f:f059:c190 with SMTP id
 zv3-20020a056a213a8300b0019ff059c190mr683938pzb.24.1711447611079; Tue, 26 Mar
 2024 03:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com> <20240325211915.GA1449994@bhelgaas>
In-Reply-To: <20240325211915.GA1449994@bhelgaas>
From: Mateusz K <mateusz.kaduk@gmail.com>
Date: Tue, 26 Mar 2024 11:06:38 +0100
Message-ID: <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
and it seems I get some other error now

[    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
[    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
[    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
failed with error -2147483648
[    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
[    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
[    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
[    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
failed with error -2147483648
[    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
[    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
[    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
[    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
failed with error -2147483648
[    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
[    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
[    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
[    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
failed with error -2147483648
[    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
[    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
[    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
[    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
failed with error -2147483648
[    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
[    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
[    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
[    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
failed with error -2147483648

Mateusz

On Mon, Mar 25, 2024 at 10:19=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+bcc Mateusz]
>
> On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:
> > Some devices support MSI interrupts. Let's at least try to use them in
> > platforms that provide MSI capability.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/intel-lpss-pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.=
c
> > index 8c00e0c695c5..c36a101df7be 100644
> > --- a/drivers/mfd/intel-lpss-pci.c
> > +++ b/drivers/mfd/intel-lpss-pci.c
> > @@ -54,7 +54,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > +     ret =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> >       if (ret < 0)
> >               return ret;
>
> I guess at least some of these devices do support INTx, since we
> always used INTx previously, right?
>
> There are a bunch of bug reports complaining about a lack of _PRT
> entries for them, e.g., these from
> https://bugzilla.kernel.org/show_bug.cgi?id=3D212261#c24:
>
>   intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
>   intel-lpss 0000:00:15.0: PCI INT A: not connected
>   intel-lpss: probe of 0000:00:15.0 failed with error -22
>   intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
>   intel-lpss 0000:00:15.2: PCI INT C: not connected
>   intel-lpss: probe of 0000:00:15.2 failed with error -22
>   intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
>   intel-lpss 0000:00:19.0: PCI INT A: not connected
>   intel-lpss: probe of 0000:00:19.0 failed with error -22
>   intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
>   intel-lpss 0000:00:19.1: PCI INT B: not connected
>   intel-lpss: probe of 0000:00:19.1 failed with error -22
>   intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
>   intel-lpss 0000:00:1e.0: PCI INT A: not connected
>   intel-lpss: probe of 0000:00:1e.0 failed with error -22
>   intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
>   intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
>   intel-lpss 0000:00:1e.3: PCI INT D: not connected
>   intel-lpss: probe of 0000:00:1e.3 failed with error -22
>
> I don't know if these are a _PRT bug (I think if a device advertises a
> non-zero Interrupt Pin, the _PRT should tell us how it is routed), or
> possibly a device bug (advertises Interrupt Pin =3D=3D INTA when it shoul=
d
> advertise "no INTx used"), or something else.
>
> Bjorn

