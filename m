Return-Path: <linux-kernel+bounces-153808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B517E8AD381
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F0285F54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6E153BFB;
	Mon, 22 Apr 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFpzyBya"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2745152197
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808275; cv=none; b=SQyQGTuprLHbPDx+wO1fehjEimm9mMuqy8afnCPm+KJwY6iiyeyGk+ImHodhOCTeD5ll3kZ5HWcejpB1VrLaON7X7bpdAp++2tAFM6KWsvjq3taVE5+hyqF72+I54EKNCbeAUM7TjV1gzoFNQJCw5+VuJZ9SQ+SpKnO15e0l5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808275; c=relaxed/simple;
	bh=PedKjQ4IchNk0puiU4eLptdz+f6auezzylZJfV3vp0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ze/y3BPiuC7V3MIUIkU4iEfVgLeZnbM/+v3DtpaFJRxddfchX/27xfc2tV40GxVsxYyhA2pyNwKtlydduR/hYtR3PTsoVHCE3+EAAp7LPJ3xMdPy9jM2HW2qx4+1wq9NqF/yfCfLnxV/0T2KN5BfOXvfFl9tp9En5rPnz6OBlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CFpzyBya; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb7ee5a776so2745849a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713808272; x=1714413072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=CFpzyByaQ4enHWZ7mNQ5SoSnz/2p9dVNMFhefPawWcrYhKeS3+6aS87/5X7jSsf2VZ
         mYXxmtroFrFtjwj9CqqVujUQHGeP18OGcWoXh6McoYt0m07Wt1lXvmPfMtX5PbBIWNb4
         A+IcghMhOMPjwfJkBcsAhZR2266sovTMJ7jFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808272; x=1714413072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=rA4FAbfjJWokz7Gchk8o/HFpwYVgUti/ztSiEb++VmiyF7rGEMee6qRucxZUtIkkbn
         ArjHjU2kFyhu/GQBoRSgdHHMk3Fb/JMHPiIdJhPmJlRTkykbLoHOIb3xjkAJNvwdpgad
         IOcqxpCFb7khpU2+F8insWR0dpE9h92vOWRci+LGkoFpS7y1AFpFjx6Uub0oOc5Gbi1M
         D3Y3/2xD+qaeDVaj36rX6uvrnapmof9My/BVrJtgsxYnl0SrxVG31NcGhERFaVJTXh+A
         IfO8yTFCyyR+TFq8RM9Rz4lZOHD0UfbbTre5oFlzAp/bmCJdkZbhnkmEUG5mAJPvtvDR
         FxSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0KTZVw0k0NEO70LTsFPj5/0QhXkqLm7gg4oGW9SVqGZ1XswyCBCjl2VRn1sEMr+KPbffYgU8rH9n4obCNPPd9+rGzgOPpR1C2faUn
X-Gm-Message-State: AOJu0YwtEnToZvWlWyU9E5zlMgLm03zCJ9qQaZwGAkv+7ceYXIBIrB5l
	+clZzDzP87Jb9gj4WgLH9X8FqzbnBRgmz7pl3yZdJ2a2fkXo7vSosa3ItkHPGs+Nwrem0YRi50c
	=
X-Google-Smtp-Source: AGHT+IHeCW5lrsUK45iesEqzr6ZDGPRcWZSUwVIG9viocmtNccQBAqY81JuXNXqO4cekzAm+OfxBlg==
X-Received: by 2002:a05:6830:6b87:b0:6eb:7d54:3584 with SMTP id dd7-20020a0568306b8700b006eb7d543584mr12999904otb.18.1713808272194;
        Mon, 22 Apr 2024 10:51:12 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id m2-20020ae9f202000000b0078d5d9cdc9esm4507427qkg.21.2024.04.22.10.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:50:51 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so43141cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2B+nEZYSNHqEtVKUOrfIzgK7g2lhTcf+ARsbI+8pSe//xSdRp/XnPe2osOu3vmzFJpz7qNjlmp0EHXXr7Nk6j68ztew+HSJcr24hQ
X-Received: by 2002:a05:622a:a097:b0:437:75be:9111 with SMTP id
 jv23-20020a05622aa09700b0043775be9111mr9752qtb.1.1713808250395; Mon, 22 Apr
 2024 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
In-Reply-To: <20240416091509.19995-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 10:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 2:17=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
>
> This was previously believed to be due to lack of persistent storage for
> the address but it may also be due to integrators opting to not use the
> on-chip OTP memory and instead store the address elsewhere (e.g. in
> storage managed by secure world firmware).
>
> According to Qualcomm, at least WCN6750, WCN6855 and WCN7850 have
> on-chip OTP storage for the address.
>
> As the device type alone cannot be used to determine when the address is
> valid, instead read back the address during setup() and only set the
> HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.
>
> This specifically makes sure that controllers that have been provisioned
> with an address do not start as unconfigured.
>
> Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quic=
inc.com/
> Fixes: 5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPER=
TY for wcn3990")
> Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD addres=
s missing in dts")
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c   | 38 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_qca.c |  2 --
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
>
> Matthias and Doug,
>
> As Chromium is the only known user of the 'local-bd-address' property,
> could you please confirm that your controllers use the 00:00:00:00:5a:ad
> address by default so that the quirk continues to be set as intended?

I was at EOSS last week so didn't get a chance to test this, but I
just tested it now and I can confirm that it breaks trogdor. It
appears that trogdor devices seem to have a variant of your "default"
address. Instead of:

00:00:00:00:5a:ad

We seem to have a default of this:

39:98:00:00:5a:ad

..so almost the same, but not enough the same to make it work with
your code. I checked 3 different trogdor boards and they were all the
same, though I can't 100% commit to saying that every trogdor device
out there has that same default address...

Given that this breaks devices and also that it's already landed and
tagged for stable, what's the plan here? Do we revert? Do we add the
second address in and hope that there aren't trogdor devices out in
the wild that somehow have a different default?


-Doug

