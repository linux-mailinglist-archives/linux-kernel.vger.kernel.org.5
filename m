Return-Path: <linux-kernel+bounces-92451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E56872055
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC1B24D53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FA85C7D;
	Tue,  5 Mar 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AyWl/pU1"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0965915D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645814; cv=none; b=A50pLKpWiq1wiXQX914BZnbZye+GWbaX0/IwIMqiot7pjwwiewQOjgsi89+ojZn95mnz5rEzx7ct3FaJR6QNtsif4TDRsQDsTOFlxMnft7rmNvKon0rcGL8kbIXY+VBuh25qpgCmZ124MmzsjZOJYB7o66w7kMoa+JVevT0GlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645814; c=relaxed/simple;
	bh=nQfK6V2xWgqSLI9E0BBwgQAFWw3SBgmC1BgXmzftNdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7kBsHCAkM2UrwhQV+3Wzhqfqgx53bAdtGIFsTu8howMXiCYwdqEF8656KE0/R7zwSMLQ7bj4iP0/n9Dkl/SJUCnlCf2fqxHTJcDeyEAmb24b1w2F+avGnhi0N+jlSFBFErq1hPLFoMWPbcgfHtOgXFKcHCMdsAIUHzbPaU3lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AyWl/pU1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A82141194
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709645809;
	bh=0402VVh+GEeRN2UVZuJPSy+RAbWSxhwA40pSMz4rtJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AyWl/pU1w2FgKtAJXHaV3E39wJu3X/crmMsukfFa76BVcFurwG78B+ItnZWnjGUUJ
	 Rg9fEnYC0PokG9mP8IXXVD6ghJ5EfgUC6bcC33ZJvTkCC6A1eb2oHcVtDfkY/o1KGj
	 OWXjZB+1yawCu2KhWF6CkKDZ7GocNLT6c3r2H2rxUoiLsr9/2wlN8aFJWFLWhrMtNW
	 LAYb93N3yF0iqkPg8L6oOJf6mrxL5lhl0h5t3LXH1/MKYDmjSP22T8iqPGQWLNAjbI
	 YR/PS5FCYGjGPNXbvPzTPGpu3Y/Xuk3EC5UR7kut3tsJy8dvZeVqKmgD/86e4a8X9/
	 w8aCy/lVXtHHg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce632b2adfso4843429a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645808; x=1710250608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0402VVh+GEeRN2UVZuJPSy+RAbWSxhwA40pSMz4rtJQ=;
        b=A2lk9VzuGhTXddVoFQ/jVWyd3MZe64sGU4b+fqHuorxpsOGDxVkruv+jbCgWBX/VRW
         ak+FckxVn/rx3UvZA84xfnc7N8rdPh75DchBQ6sLHdNhOn5JzkSTtJGdcTmciuha/hwe
         CMfg66jOr+OS5n8GHQ2+glzuSJqdbmhwP92OY88Ua1TmRE9V8PXK+1sTCm0ujiWU4h7s
         0wBzKbbT+WIydvxqPlHeaA2HlJNs7X5qUgbV71Rkh7c+VHMT6Dkhovy0PrN6+ID5sMwC
         1czZIdwr47DMTRa8R46yVVFXfJQ1PhVsdn0RhjfyqrZbXpyEQybG84rrzqhcDvJ/nTWc
         Y61Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuUscrcmAHXuwdWoVrbIByOZyNNZqOMoNf0uJdBMN2sJ5TmnCy16yNyXJfk9zR8PDF6n1dMp26QtfKFtTwwZxJ6DVLYJsWxE14Q4ou
X-Gm-Message-State: AOJu0YyhbGi3F9GIQbVORsrC8yVRs+Luxt6Zp7111hRbq+6Rh+Tk2ApM
	bWRGKjQe729k+rg1PAFlKdqa3dS9YOhttCzePiB/YwCY3fUjjQnQ60e0dY/2RNuthOENmuuaNx5
	QBwPzC9jzISaTe77Nemt2zJM5QwtytoUhAWqXDvvj+wtld/hGthvjS/nf1SKMjwJ9bDuDOrkpYe
	t0d3IgajLPaC/UDTF35R3Y+d925dklI7qWGs2eHpl1d/9zu51Z8Pzk
X-Received: by 2002:a05:6a20:af87:b0:1a1:4487:ee25 with SMTP id ds7-20020a056a20af8700b001a14487ee25mr1501419pzb.49.1709645808125;
        Tue, 05 Mar 2024 05:36:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOP//ufniFPMkZx0twz+0xxIGTYOpse5o4+VGR1RjmYtquYB3hCwcIfz/sDtZDINGIz76nhkwZK3Ux85NQF40=
X-Received: by 2002:a05:6a20:af87:b0:1a1:4487:ee25 with SMTP id
 ds7-20020a056a20af8700b001a14487ee25mr1501407pzb.49.1709645807855; Tue, 05
 Mar 2024 05:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5761426.DvuYhMxLoT@kreacher>
In-Reply-To: <5761426.DvuYhMxLoT@kreacher>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 5 Mar 2024 21:36:36 +0800
Message-ID: <CAAd53p774TjJkdtRxxUo8b--LvznTBMgGPdpA=yjGxu8eBgmKw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: PCI: Drain runtime-idle callbacks before
 driver removal
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 6:45=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A race condition between the .runtime_idle() callback and the .remove()
> callback in the rtsx_pcr PCI driver leads to a kernel crash due to an
> unhandled page fault [1].
>
> The problem is that rtsx_pci_runtime_idle() is not expected to be
> running after pm_runtime_get_sync() has been called, but the latter
> doesn't really guarantee that.  It only guarantees that the suspend
> and resume callbacks will not be running when it returns.
>
> However, if a .runtime_idle() callback is already running when
> pm_runtime_get_sync() is called, the latter will notice that the
> runtime PM status of the device is RPM_ACTIVE and it will return right
> away without waiting for the former to complete.  In fact, it cannot
> wait for .runtime_idle() to complete because it may be called from that
> callback (it arguably does not make much sense to do that, but it is not
> strictly prohibited).
>
> Thus in general, whoever is providing a .runtime_idle() callback, they
> need to protect it from running in parallel with whatever code runs
> after pm_runtime_get_sync().  [Note that .runtime_idle() will not start
> after pm_runtime_get_sync() has returned, but it may continue running
> then if it has started earlier already.]
>
> One way to address that race condition is to call pm_runtime_barrier()
> after pm_runtime_get_sync() (not before it, because a nonzero value of
> the runtime PM usage counter is necessary to prevent runtime PM
> callbacks from being invoked) to wait for the runtime-idle callback to
> complete should it be running at that point.  A suitable place for
> doing that is in pci_device_remove() which calls pm_runtime_get_sync()
> before removing the driver, so it may as well call pm_runtime_barrier()
> subsequently, which will prevent the race in question from occurring,
> not just in the rtsx_pcr driver, but in any PCI drivers providing
> runtime-idle callbacks.
>
> Link: https://lore.kernel.org/lkml/20240229062201.49500-1-kai.heng.feng@c=
anonical.com/ # [1]
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Ricky Wu <ricky_wu@realtek.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the debugging and patch.
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/pci/pci-driver.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> Index: linux-pm/drivers/pci/pci-driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -473,6 +473,13 @@ static void pci_device_remove(struct dev
>
>         if (drv->remove) {
>                 pm_runtime_get_sync(dev);
> +               /*
> +                * If the driver provides a .runtime_idle() callback and =
it has
> +                * started to run already, it may continue to run in para=
llel
> +                * with the code below, so wait until all of the runtime =
PM
> +                * activity has completed.
> +                */
> +               pm_runtime_barrier(dev);
>                 drv->remove(pci_dev);
>                 pm_runtime_put_noidle(dev);
>         }
>
>
>

