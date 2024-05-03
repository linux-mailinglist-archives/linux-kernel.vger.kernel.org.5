Return-Path: <linux-kernel+bounces-167409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C08BA922
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69A1C2087D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83714A0AC;
	Fri,  3 May 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w87LAoIR"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D55914A0A2
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725875; cv=none; b=fOfx3HJQ5x9+Hui3M5OP3UcbGScXtF9h2kk50G7TueyHrBD9nPlsdONrtQxk6C++s+2lLJYJibYwuOVFA/vlxOxF6nBITcJoAEOVLVlbV4XY2DhnuvZAUdSLsCUqNw+inIIVZIj03BH/gIFAlKTOHyTm5Fa67/YnQEeTaVnvtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725875; c=relaxed/simple;
	bh=Hf+CieslUsObgt+CsnG2v8xKLDb8RAdDAkn4XK1B5ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3sU+HiMGzbejAN4meT6qIA88fVPKd6zA9hxLVyv4LGeN3DYWgN3RR+etqLlFJluVpEYByGMAeZ3JA1BtxCIrLhtP/VmSwgjgVySuSo5kORRQ2eBuW8vkvkwj2e2H/xIdNJF7yXehI9cdGi7aOKuxaf6iTEleyLFil1IqsLwN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w87LAoIR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ab6faf179so87452187b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725873; x=1715330673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf+CieslUsObgt+CsnG2v8xKLDb8RAdDAkn4XK1B5ZQ=;
        b=w87LAoIRYfTkcWm7xIH0he9lZ2rpok4L84Lr5//A92VRW9vo/+DpFBKvna7YyPcZhI
         fQ4thT8DmymXW3ZMu2AZO0+nkO+aKyz6G5QrEvXyGliq5OMLtaoMHcgRG4NHP4KtMBEg
         nllojQ/s1aMmxgn5ihHeHv+BrcMAGI1V1F/eEt68+4dEJW502At/2zx6DAQ5D/KM2s2l
         zhgSIJvz38i5pmUP3OPbcMP+WJgPyl81fCvvagxqcGziaFxhUvlBhqLpqQeVt1/bRtHl
         /2eXI7wcR/CMbBjM3f/oGebijdUfR5AnAYdh5SG2YMGCpIcr5zBnbj2GoAchaj6J7fYx
         FYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725873; x=1715330673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf+CieslUsObgt+CsnG2v8xKLDb8RAdDAkn4XK1B5ZQ=;
        b=Ck5RSRNf6p2rfDEMq4vC0TL4kOQCnBExe3ywnxPmj2EUtuWsokSoNW0G539hsMaOTv
         EH78+gxitgiu7xO3gEfesGdu6bCOy3UmRAW/UMEQ9sbBRwYo4mQzgC4NllgsmsNxXV5n
         8W8Ny2EFM6+dshN2LWnstPkDXI7V7ghTBTvWbSFtjEZqf+nNBAiL19QJCT++b1nVVe8X
         QP+5OZeart1rJjFPbLW2LdAJTMFWf9DrkgPV49IPjwf2o7PTh64LEeCw1z5qWt3Zt4dp
         IQW210fTlkNlXAGksd2kkjppRHwt/QgPOPonr0qj7Gdl8+5EydyHaXpWy1kOQ6H4yITS
         B3wA==
X-Forwarded-Encrypted: i=1; AJvYcCVpy7ouke+mmJrsbIw0OEj5YEuZbSlz4JS5P7gvWrys0kYmwKIfO2I2w1fDHl5VqGbRrjIOGw9yE4GYfKfljhcW+yqK8ifrJ/RDHley
X-Gm-Message-State: AOJu0YwRKnzLvPI8EeRCCwXGJ4b5imWBkKTYu6t09VP+v+RdefavE5bw
	MJTkRhE7mzmvheIvaln74cg8x7tc7N8MLx4ujhzQwXzCAX5Wli60Ks7oryI7MfJ5FXvUVFMb2et
	6kPP2CLKWPvzTq9MPqIt63eZdBexN1lzKPE5NYQ==
X-Google-Smtp-Source: AGHT+IFGYTpNwu9TZMXaJSiBK88u1EeOSsKzD6MeNR3gt+k+WNvbBgRYUXF8L7/juthvlyCGLR4E4/DZYS+Ms+4380k=
X-Received: by 2002:a0d:f944:0:b0:61a:ca09:dae3 with SMTP id
 j65-20020a0df944000000b0061aca09dae3mr1925466ywf.26.1714725873347; Fri, 03
 May 2024 01:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429104633.11060-11-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240429104633.11060-11-ilpo.jarvinen@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:44:22 +0200
Message-ID: <CACRpkdbPhrszp9sXaZibm0P1p4cXPLsYE8o6g3YnZ1Grxr1-NQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] PCI: v3: Use generic PCI Conf Type 0/1 helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 12:48=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:

> Convert v3 to use pci_conf{0,1}_addr() from PCI core to calculate PCI
> Configuration Space address for Type 0/1 access.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

