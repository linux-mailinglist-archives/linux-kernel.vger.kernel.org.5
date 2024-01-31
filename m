Return-Path: <linux-kernel+bounces-46086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D73843A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A5A28FC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C669D1C;
	Wed, 31 Jan 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="IgJxrBM+"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B769D16
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691425; cv=none; b=iXSKObMxbO33CeK9oOex3MqzU8aMsE/7LSuINyR38UBxXVRqVl7S6KBiRD1xF2JoXA22DtavDMG9NHSfH1oPWXvPjRmAvQvdNCqKyn217b1QkK1lCRpwUXY5Z1DMtEDnSH+ilAa8tssffhvT/fkgb9+4XoF2KGMf++1VYGiguW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691425; c=relaxed/simple;
	bh=PKv1oho1laKgagdEbM4KbckuWDsfrLBNKB+tjbPNi3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BM6pLS2vNOLH2XPghXgwGZ5yqwiDU0uQi7V7wlVm3307n9Rt9RtPZbfFEP67lGvwz90M0Yeg3bZgAbBT9dJcE8qWKUUMcTapy97azNXomk7/Xvok8Sfd0PdtZENMJUUi/QmC6ZrvX8SeUsOpJwxQ0Kl/ZvQm8ItB7bMnaeS+gr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=IgJxrBM+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-602c714bdbeso5600017b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706691423; x=1707296223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKv1oho1laKgagdEbM4KbckuWDsfrLBNKB+tjbPNi3M=;
        b=IgJxrBM+2Ws/5QsIxdv95oTwl5UAoPG5XIJPXncZ47xfU7k/N2oqOAZw5ChVg0llDX
         4qrlGRHrUo9EI9CqIEAX2QB8vx4abLHe4mLWpEL77WOiEsWyLZOUwPw/jJZKVfWDNYgg
         6EZTO/61DcUg404oh90qSt5srbSjSqZNsjdy3XTadQcxihze0nPYQ+gC8Bvt2p9my69+
         uGYNNLLL5QoW9M1Ck2jDiS5mEoLtp8Fuz6reSEzZ5ktLinP1W/a4qBRcKah2KutuDyr5
         0SKcamLORZyUYYp1L7+qHkOnjv3QjolOt+gy2RyfWVJ5KNfxlV+Ic3R2OtdD+xg+eZ5T
         EAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691423; x=1707296223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKv1oho1laKgagdEbM4KbckuWDsfrLBNKB+tjbPNi3M=;
        b=YZEogJTwpcjKXH/ifQ+Zx32FYWjOQxMJLfuatWxeoYWyzl7gJVyfRMrLiuxLkfgVbe
         Z94HCFhj04kunM8ybGLZIml1wJ/AYqM+QEvMraIrchcK0tr1zOO8NqxOrE99vU6Bj7w+
         Ei5wDATeD3bG9pk16tg7/PoR6/CMMVnd+djnbO1YJFcBzFNW5ZQCatcALnFhbKNwSo1E
         GDyvBUEY/5YOeM4qNlNyulgOsjubt+znjXfI8wL5Sda6qCjfb4HBKidmdczfXkeKe7ku
         ggA0ay2dF0LwesFiK1wX6F5LRMCuuv9WqYlB+eLAr29Lqw6SLP3gSe0Cxxj78xngL0kf
         e6ig==
X-Gm-Message-State: AOJu0Yx5bgNlqCUImi2m/IzSBelNDOZ2UWZUIPcB8UNnSqbrWPSMPmp4
	drnHCKjPsTuKQX+HybRxLA9mh9tzuTaHJLCQLjSS72jmRQe8npTMu7GigKNo3xF+WHpnoUgi0Fr
	Dqt5DLSuLjHzfHb9RHjsq7Ujj1L6lDIWoH36Ksg==
X-Google-Smtp-Source: AGHT+IEurEtJTDYK3AVBhc4LATERu/lu8Wto+rGGt4fDZxRZeeNTLdsLZXKV6YQFlqOMO/7asswXfe4jQzkS04JOTfs=
X-Received: by 2002:a0d:eb48:0:b0:604:3ef:a729 with SMTP id
 u69-20020a0deb48000000b0060403efa729mr1442117ywe.15.1706691422846; Wed, 31
 Jan 2024 00:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
In-Reply-To: <20240130101335.GU2543524@black.fi.intel.com>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 31 Jan 2024 16:56:27 +0800
Message-ID: <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: David Box <david.e.box@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mika Westerberg <mika.westerberg@linux.intel.com> =E6=96=BC 2024=E5=B9=B41=
=E6=9C=8830=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:13=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, Jan 30, 2024 at 05:59:33PM +0800, Jian-Hong Pan wrote:
> > Some systems, like ASUS B1400CEAE equipped with the SATA controller
> > [8086:a0d3] can use LPM policy to save power, especially for s2idle.
> >
> > However, the same controller may be failed on other platforms. So,
> > commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
> > controller") drops LPM policy for [8086:a0d3]. But, this blocks going
> > to deeper CPU Package C-state when s2idle with enabled Intel VMD.
>
> Tiger Lake really should support this with no issues (as are the
> generations after it). I suggest trying to figure out what was the root
> cause of the original problem that triggered the revert, if possible at
> all, perhaps it is is something not related to LPM and that would allow
> us to enable this unconditionally on all Tiger Lake.
>
> I'm pretty sure the platform where this was reported suffers the same
> s2idle issue you are seeing without this patch.

Simply applying LPM policy to [8086:a0d3] sounds like a good idea!

I installed an SATA storage into ASUS B1400CEAE and tested with
enabled & disabled VMD again. Both the NVMe and SATA storage work with
applying LPM policy to [8086:a0d3], which means that it does not hit
the issue mentioned in the commit (ata: ahci: Revert "ata: ahci: Add
Tiger Lake UP{3,4} AHCI controller").

Jian-Hong Pan

