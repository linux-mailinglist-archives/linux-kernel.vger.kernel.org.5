Return-Path: <linux-kernel+bounces-36616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CDF83A3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70993B27621
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E771755B;
	Wed, 24 Jan 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YBbty9sG"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4606171DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083960; cv=none; b=HZryLTa9VF7D1vSxpn026P/xxUEQhzwqlRSYMcMuypiROW7mWq31X1xmd2uSPCwUSpa1iRSLTRBvLjMIOCCTGEXqtZJPfm8H8oeXzWWgDBKUULBiIIXr4q4dIuQPpjB9aE0gugRMEIXGwkGAGp1bXzqXfLSn6DKbrNXKGu7ULrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083960; c=relaxed/simple;
	bh=C8kYfDx/P9hnWkyKHcdyWPTZdI2VSXngwIerXp0qFns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhxK+W4lw4BzjHDMPYgma871P5dBudlC40HnhWBgiUVO4vv41IMxvyjVeJWrQY7wRaggSY+fTcHTvc0CEhRR8GRBDYqVXLjfCa4qjFIdere5zIe9GR+dzdLZHFcPzyHHOWLou/O8WTLcYJbMLlWt3Ako+byhHqQ2KaaECwYKoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YBbty9sG; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc22ade26d8so4027682276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706083957; x=1706688757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nlrvezwsoefYOiDE66ptLKogdw8xj1n98YMDFjoN+M=;
        b=YBbty9sG7JivTyRuJzpHonuXmx+JIN1C4fibeYvcSg++Z6PyIykvNZnjzH3m29c5FU
         xBSjAX8Z4Y0cAg/XDe512kDKk6+UO4B1ck2I3hkyD91wRUmfGw0RKM0Pq1XamRPypEo+
         9Lf7/Rvr3obTej/2lwzBzhojd/ijWYCWszSiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706083957; x=1706688757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nlrvezwsoefYOiDE66ptLKogdw8xj1n98YMDFjoN+M=;
        b=RlpykVMtzWOi/7PiB0ScC1/ivaYzAEBsF84pJKMKOlsoOyQz+IHxATwQLkrubNCE7L
         lO3xGrSWV/55BJE0Ex9moy+vY2oK3GKLkQPMMs9UvbnjdohFk57OLN6hO6yzi3RgU5f2
         ClSInWg9hctRhSN/9cQbMPNgzLdLs3LwC7r5+6GgoBHtMmLdb4pVhrVcjN0JfCmDTKhP
         TFr37BaFTAmwzkCfQhpv9EGC+069RcjXZnocSKuDbfNbjGH08/4h8VTy7EaOSNon4gj0
         V5O4p1vd2imZruTAtQx36H7YrRuMIgT93wEWMl0MaBnuLKSPnuBlU40teEAbvjOEixy8
         fy6A==
X-Gm-Message-State: AOJu0YynCzfAWf2bOL5AwL3ab8jsapAjcgN/ywmQgpZ5i+Q6PYCjSOpX
	2L+2KS2f+1SLOQHds7QRofm6hhhw+ngxbWcmrwYHZ1TUV8YolBO7c83NZaaEHWwIx8SJlRCuSoz
	mzPWMlajNznYIRCE/JpZpFlrgZAUVJqSpd3kx
X-Google-Smtp-Source: AGHT+IEXXNpGL3FkHpH7UVTAE98t9kuK82tJy02EY3Po3kf0mUsz/lQ5QYroraVfAgTjUCCe1Q2enF+omVYI5Wnnfpw=
X-Received: by 2002:a5b:345:0:b0:dbe:d3ef:d54b with SMTP id
 q5-20020a5b0345000000b00dbed3efd54bmr291405ybp.93.1706083957672; Wed, 24 Jan
 2024 00:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com> <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
In-Reply-To: <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
From: Prashant Malani <pmalani@chromium.org>
Date: Wed, 24 Jan 2024 00:12:26 -0800
Message-ID: <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] usb: typec: ucsi: Limit read size on v1.2
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On Tue, Jan 23, 2024 at 2:30=E2=80=AFPM Abhishek Pandit-Subedi
<abhishekpandit@google.com> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> increased from 16 to 256. In order to avoid overflowing reads for older
> systems, add a mechanism to use the read UCSI version to truncate read
> sizes on UCSI v1.2.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
I have one nit (mentioned in side-band but reproducing here for consistency=
),
but will defer to the maintainer on that.

The above notwithstanding, FWIW:
Reviewed-by: Prashant Malani<pmalani@chromium.org>

> @@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
>         if (!ucsi->version)
>                 return -ENODEV;
>
> +       /*
> +        * Version format is JJ.M.N (JJ =3D Major version, M =3D Minor ve=
rsion,
> +        * N =3D sub-minor version).
> +        */
> +       dev_info(ucsi->dev, "Registered UCSI interface with version %x.%x=
%x",
> +                UCSI_BCD_GET_MAJOR(ucsi->version),
> +                UCSI_BCD_GET_MINOR(ucsi->version),
> +                UCSI_BCD_GET_SUBMINOR(ucsi->version));

nit: I think this doesn't need to be dev_info() and can be just
dev_dbg(), but will
defer to the maintainer.

Thanks,

-Prashant

