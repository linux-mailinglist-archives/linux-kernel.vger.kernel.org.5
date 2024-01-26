Return-Path: <linux-kernel+bounces-39513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27FE83D235
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD628A0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF237491;
	Fri, 26 Jan 2024 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIKfNCa4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7B6FB9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233553; cv=none; b=A2RYxemz3LdNOqlF76QhM4huBrqMhGMlkYfgpNygVNEWZnj4gKeiRj/CprfJRk0swq23auIUSqAe03wiiYOwfjTNvaJrpFY3jvKvUq9ChCu+upU3CvIs+R/JfkNH5WyDwwEEjKengH3TyfkaavvygB3oGVYL3dRWgSec5xtgcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233553; c=relaxed/simple;
	bh=mGndTaMbzKrye6eY5n+umXIma64hlLmLq8ZTlgknYcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E112KhiO93CB88+8x+Dqs5bSfMWPFFXWFd2V96lKlugw0Y1p84FryHxm08VwgOEiNYNtVepyOEMOHPqoY8honFwJcYIpyvOg1z2qZGgna4eHudwqsoRhamwwKct1uThMunoPztNyyEjdbMTvrjPqgszP/2ef+rKPO8JgeosHf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIKfNCa4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffa694d8e5so12268697b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706233551; x=1706838351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGndTaMbzKrye6eY5n+umXIma64hlLmLq8ZTlgknYcw=;
        b=BIKfNCa4hZeWawsD1Y8bXH0VLuuLigkkwQ7RIwr47Lc5Y2VUKKwm/BQbfNpuObDyp8
         T6qIbVKJr0AABYbnVSPEK6fLpWeDZSun6QXKivMxRV/ZmuabiGFdGKU8Nu+mao3qhJGs
         O8i2V6nJ1JNMqipwd5HaBgV+4kIV4dKMvu9T8V2xmurp75zVhL0WKvJDkYpPvcpgnE6T
         kLZCNi0Ohp45gcKeqMq2gtCU723QaG3OMb/4eguGaK7gAyQJhypyhAM5WfagecVOCTi8
         KSrkuXqpNnzyDoSG1OWALRRcmvSAd09IpBvaZjkd4C0y25f3ErdPh+BKTLRI1Xxr7LXv
         cpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706233551; x=1706838351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGndTaMbzKrye6eY5n+umXIma64hlLmLq8ZTlgknYcw=;
        b=UPfhLqmI26aS5jTIQ1YYrd7TvQZXN5f49uiK9UW1kDYtWWPxr0W5BWbmKjsG0snJgM
         FV2zIwWEKQwMZyC+ro3TwgAzBurxs/v3IhuI40lX3TjP75DEMlT5GhBCHXz9l81IcylF
         mAE5W1KHkJt4233fGQ2DO3Uk58dqNFE6uiqW85gryhd9Voi7TKlKgrae3thmKHtg7uLk
         M/jMRe+NfiaAPhpwm7V/nHIqIhaO0V3JzxajC69UqqM0GSK24ixxo4VWw4yMefPL9KUj
         Kl8tidwlNXnc6O4UyZVqOfXzdW++9HGpDJPigD3X6FdO/GZ0GuVois9aeZOGdtCOTkx4
         CM+Q==
X-Gm-Message-State: AOJu0Yy3AWTO/3Nrv+vBEZ0uoVcTUXS1axzniYBYk8Ot65khhKF1Chkq
	OWP+LVZiC/vhgvhzepmAf4c3ejuqOp1OIUM/fg5e1qQ3QSxBGQM/+ACStNWZcJuF/90DHXndVfb
	gz1+JDPC78+1dk5cg/YfpJRmaZ+o=
X-Google-Smtp-Source: AGHT+IGyhCo/WzXci0GxrAbp1tFg9LjNLv1tWLlLPkdgUnrt42MEnSLORmzk5t6dqXFXkY3mvCtO9hYswh/sSWLmolM=
X-Received: by 2002:a25:aa54:0:b0:dc2:22a0:9ab4 with SMTP id
 s78-20020a25aa54000000b00dc222a09ab4mr110613ybi.15.1706233550646; Thu, 25 Jan
 2024 17:45:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220413083824.247136-1-gch981213@gmail.com> <20220413145843.46a3d9b5@xps13>
 <CAJsYDV+3J0ipbR+N-xE=DH-WXsjierdHe_pJtKf1Xbt7fdaiWw@mail.gmail.com>
 <CAM1KZS=tvEi6fed=BoynpkjfzZqKGb-wv+CVbVmAPYz5tNaNkQ@mail.gmail.com> <20240124180848.3647d5c9@xps-13>
In-Reply-To: <20240124180848.3647d5c9@xps-13>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Fri, 26 Jan 2024 09:45:39 +0800
Message-ID: <CAJsYDVLGjXXNrTicQpOd+rnAKpLpFttkeOSH15_qs5ymm+HaBQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for ESMT F50x1G41LB
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Ezra Buehler <ezra@easyb.ch>, linux-mtd@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, Mark Brown <broonie@kernel.org>, 
	Daniel Palmer <daniel@0x0f.com>, open list <linux-kernel@vger.kernel.org>, quic_sridsn@quicinc.com, 
	quic_mdalam@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel!

On Thu, Jan 25, 2024 at 1:08=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > According to the datasheets, the ESMT chips actually have a 5 byte ID,
> > the last 3 bytes being 0x7F (JEDEC Maker Code Continuation Code). Why
> > can't we simply extend the ID in esmt.c (as you had it in your original
> > patch) and increase SPINAND_MAX_ID_LEN to 5? Or, alternatively, only
> > extend the ID to 4 bytes?
> >
> > If that is the way to go, I would be happy to provide the patches.
>
> Please send the patches. Chuanhong can you test them?

I think it should be fine to set MAX_ID_LEN to 5 and add more
0x7f to the ID definition. Unfortunately I don't have access to an
ESMT flash for a test.

--=20
Regards,
Chuanhong Guo

