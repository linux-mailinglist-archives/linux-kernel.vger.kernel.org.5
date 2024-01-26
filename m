Return-Path: <linux-kernel+bounces-40464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98EC83E0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965D9282C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFC208AF;
	Fri, 26 Jan 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2E8Sr4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91245AD53;
	Fri, 26 Jan 2024 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291598; cv=none; b=D7G+qjsx31KWLppPmq/RAJUJuo8SnnMYH9JzBJ/Uoq9s87CwJX7h8NoCcuDou3Ql6qMKqlhqjTC6H+6np0jmqU4hWcaxx0wm/YB1FMGXdD3O0dfq5v74T/dyogNVmrvrPzsgO6JmOLPdHXS2rZuqpm8qZLJRxG9cOp2e9LHHtQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291598; c=relaxed/simple;
	bh=rybFb7jJvZjmLIxFKOxsfVGRM5tubzkm9Lxt0UHSsCc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y3nec40/C9X4cPmrijlqf4mjZGC1m6A6m7SD1rga9tSOivANBqHaCv4clJvv8NWsVv90CW/0CMRu7BCt/FarHpFBStbSffcIl6OV6WV9hzintdAQNaHrpIj7XNLj6btFcto9ELW5JWK9OG/D4LHt82onEYSAWhUr+Ch3OQ6fnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2E8Sr4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43B0C433C7;
	Fri, 26 Jan 2024 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291598;
	bh=rybFb7jJvZjmLIxFKOxsfVGRM5tubzkm9Lxt0UHSsCc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c2E8Sr4xjNFOBy84ft5jRhhz4dDGDQza7qOywfJt/CVZWvGrNHdlsoxwTSotIfGYa
	 MBMLVJODPloE59IKXN4681b65dzSzOUO8jGUYlqsiXDH6d5sA7O2Kp0VVcXJ5tccwO
	 SvL8Puk/huFvEHG3LppdrBCDC1z5hOqS9MsiHTWZL+kDT6z0ZE5Qok9tvD3rs1bGr9
	 xTIBg9BEbg7WpSCPwj2RdAmOHjFXR0feZaEqWLFoH9a5759baRNax9/vuELFJeX6Wy
	 6fk1oH19sRkhsMmKL90V0PlYzOvAf2Xcfxl+Y3m4E02yXtVZSYpH8PAA1Ou6WpePaP
	 96m5foIunw7cQ==
Date: Fri, 26 Jan 2024 18:53:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Doug Anderson <dianders@chromium.org>
cc: Johan Hovold <johan+linaro@kernel.org>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid-of: fix NULL-deref on failed power up
In-Reply-To: <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2401261852360.29548@cbobk.fhfr.pm>
References: <20240126170901.893-1-johan+linaro@kernel.org> <CAD=FV=UzGcneoL1d-DDXVugAeq2+YLCKrq8-5B7TfVAAKgF=SQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Jan 2024, Doug Anderson wrote:

> > A while back the I2C HID implementation was split in an ACPI and OF
> > part, but the new OF driver never initialises the client pointer which
> > is dereferenced on power-up failures.
> >
> > Fixes: b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are separate modules")
> > Cc: stable@vger.kernel.org      # 5.12
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-of.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
> > index c4e1fa0273c8..8be4d576da77 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-of.c
> > @@ -87,6 +87,7 @@ static int i2c_hid_of_probe(struct i2c_client *client)
> >         if (!ihid_of)
> >                 return -ENOMEM;
> >
> > +       ihid_of->client = client;
> 
> Good catch and thanks for the fix. FWIW, I'd be OK w/
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've now queued this as a fix for 6.8 ....

> That being said, I'd be even happier if you simply removed the "client" 
> from the structure and removed the error printout. 
> regulator_bulk_enable() already prints error messages when a failure 
> happens and thus the error printout is redundant and wastes space.

.. and this can be done for 6.9.

Thanks,

-- 
Jiri Kosina
SUSE Labs


