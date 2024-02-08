Return-Path: <linux-kernel+bounces-57556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C5E84DAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0E71C2190A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55C69317;
	Thu,  8 Feb 2024 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X071AJi6"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3D692EB;
	Thu,  8 Feb 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707377245; cv=none; b=buKvon12U9lz9RzXmuxvKj1Cg86OgpyVEQCeiEYCsDx9cS83TijBqIIhXI4+rzpshZyT1RcQPmJFVwLzELVaF94h1cNfzrhiiankXzO0ahyKgqXPhDRxI0jvwiNREGs5NFjtBRXMQkUgvgYDW7Yb1RQtfcabhx3P13yjodLhMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707377245; c=relaxed/simple;
	bh=u31cVU7vA1tnHuIzBIyG6VOgMkY/co8xvbVMDp2qiCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9/VHNAGx1wiAX4yru6TAiGgbLujQ3bXpuhbWUsA3Nm5mwWdBknG8nlCPY9vHtxBdGG3hMSmrdn1lszcjS/lrw86uwkZ/vYfjGoyHN/p9oDDrgKkgNkIlp/vxSbWFKEeeBBMqn2AAu4nmIxPq8+htY1uDSKMvtiOjA4jp090Kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X071AJi6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so14177937b3.2;
        Wed, 07 Feb 2024 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707377243; x=1707982043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/dz85B0nMFX0Scf/g5jiTejJQE4PEr9XcCOai7UJic=;
        b=X071AJi6/WzIH9kpP5kt3yFTnSkE3IXtXe0Wmbr4rb4rkpjopAhn98lmNxgoHWdcM4
         Sw+jzk3dLnEU28UAFTTCT5GtavUO1nWgKbzAX7qHSCbAQGIYRf3aweEhJQ8Yaz4GtH3Z
         GZUK+cUm3SwEQR1kXZoEJwPPk47Eg/vYh46k92DPGaH8lTCko1HP2Ieji3w8L5DERRf+
         cv/yH5Hu+utigpsTzEMNjifDq/cctnbKbqJ8E0jiwiiDS1AVaIYJECkyGwcP2k4hO/9a
         nYKiwssE4FXzIJ7EeYmsHzs6Xx4KgLMZIMwr0EXVGb77O6h0ZjEGpnZUQZ40ANVIPR1X
         PaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707377243; x=1707982043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/dz85B0nMFX0Scf/g5jiTejJQE4PEr9XcCOai7UJic=;
        b=MQqwl1epkjja4I6l7qkhy1ezIfPdKhAkuBYhzlGW73XAeOONiwBDZCRkk8WuKoSwyT
         8PryeiE8NWhhIUfxqu9PanfkrY4AY24LDmb9MB+GOZIhZJw85Wd6/nTEx6/N2ONZqTvS
         HPZrcjwUkyOgB7Cd98wDrSIKeQS4p/6M2KtaoqEFke9xepA2QdtHIT6Hz1U3S3THok1B
         2IPoHsTGzs/mZ6WLFEkqdlvbhT2YqtoCQEHKojBn8U+1ZR6gQ6AFxh1VLtICkhWFdbw2
         UuTbGlZWT6CWY0CtWIic2aHeWbg1mH8cmImAMLb0gvDRg+U+Wn39I9oZaL/S9K6B3p7r
         aYQA==
X-Forwarded-Encrypted: i=1; AJvYcCWwrWwXPdOusfKawCiBz4WCE4BWlfx946xDZkljqb12BLoaGQMIwB4OEO1m3HKpeEXA7iVEVkdqazTHAAF2F84O+9/gnijhpSUKIy2A
X-Gm-Message-State: AOJu0Yyz+W/6GtXa+etN3OY/7CEaGyi0JzIRpzHSOqWQod5FFhNnnFSH
	9HkqbAYPoTJDY0srt5dj0tWT6BtqGUym8fOgR2Mrw3+ROCCUr0RuPHjqxBSqbhnHdhfMX3tzJD+
	52/vWEoernFi8WlckhvmFOX4E2t4=
X-Google-Smtp-Source: AGHT+IFtcTE1bYpwq0zBYgaJE5AvknbVaYvnzfBR9OzRJNSRdDQiwDWo9Qh4UEg1b8Lmdoz8WIAk8f59RZwy7eS74FU=
X-Received: by 2002:a81:ef04:0:b0:602:d01a:ea9a with SMTP id
 o4-20020a81ef04000000b00602d01aea9amr7603581ywm.15.1707377242715; Wed, 07 Feb
 2024 23:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj> <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
In-Reply-To: <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
From: Andrey Melnikov <temnota.am@gmail.com>
Date: Thu, 8 Feb 2024 10:27:11 +0300
Message-ID: <CA+PODjpOE=LGPi1G1ebvEwGeXAfpuZ+s_k4uMUwu3i6st9y--g@mail.gmail.com>
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlemoal@kernel.org, hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"

> On 2/7/24 12:58 PM, Andrey Jr. Melnikov wrote:
>
> > The ASM1064 SATA host controller always reports wrongly,
> > that it has 24 ports. But in reality, it only has four ports.
> >
> > before:
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> >
> > after:
> > ahci 0000:04:00.0: ASM1064 has only four ports
> > ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> > ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> > ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> > ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst
> >
> >
> > Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index da2e74fce2d9..ec30d8330d16 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
> >  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
> >                                        struct ahci_host_priv *hpriv)
> >  {
> > -     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> > -             dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> > -             hpriv->saved_port_map = 0x3f;
> > +     if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> > +             if (pdev->device == 0x1166) {
>
>    Maybe *switch* instead?

Ok.
Can someone explain to me - which method I should use here - override
portmap via hpriv->saved_port_map or mask it via hpriv->mask_port_map
?

> > +                     dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> > +                     hpriv->saved_port_map = 0x3f;
> > +             } else if (pdev->device == 0x1064) {
> > +                     dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> > +                     hpriv->saved_port_map = 0xf;
> > +             }
> >       }
> >
> >       if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {

