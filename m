Return-Path: <linux-kernel+bounces-152971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A108AC6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589261F21125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219450286;
	Mon, 22 Apr 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEkk1mSz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212994CB2E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774365; cv=none; b=WTkTEw4/Rn6v3cyrw0Xn8ToamibkAOsXFRGPz91wx2dxkTlR/A7UxGBH930aPOCM3cxP+JUVOCso7gLdJNFHwyk0oULBXOOqZ1BUyF7B2H4FCByTxC/f8s6OSsTIrGfbs5wu0mbmHzL5jpr2NCq6qsIAhCirdqSsttYQNaDPpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774365; c=relaxed/simple;
	bh=DbFpvgChbGfxdw8xDIiDIqs8RFoQ4LVzYkB5IMnBeEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFOdZXXbBC4Q3AKZiU9y2H1x6Z/+Uzl/iIb2sfMvGPxbTpyGhbgsNgLd35D7pecHfMPHRonoF74kZEPHHTCcUtTSDDrY/bDOIMFfxfdnPFR0P8UDOBznlc4N7s5GeRg0XkcP/SPmSxDY0izYk9RvjOQ/tTtgGoUYNiUON8lTB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEkk1mSz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so8606a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713774362; x=1714379162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIjSpFzc6wuUUvRoNAvf010gfUriOwpE+vCiO0BYwFY=;
        b=uEkk1mSzSpNVdzXHyFwgbuIMXRE0sy+kjwxRaIwbDUjn16p/VXiXThc+eEPwMO0yM5
         SQyDhBOaLzD/y3R5q25jbXUC59xHCKCY0dLEmVLKIsyPSZ7en9A72kx8JHMXdAfIUam3
         cxbRoAJw2u/x4nH/ReAryNbKIHfI6G5Tg5TzkrPmNAqyK9bgtXxAfYvhlUshhrFSiSS2
         gHaNoDXhBnuMzuSQNHx7YW3FmBC1EHjpIYxQvwGmpeGPgkuTy2RPmgjKPhw7ziM943Fk
         g2prbiWky23Zlv/kcSOlnlLYXh6qMt07oK3YonHGes2DB6X0Q34dEKCrKlNRqfvIgQrm
         wlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774362; x=1714379162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIjSpFzc6wuUUvRoNAvf010gfUriOwpE+vCiO0BYwFY=;
        b=t9EKM6JJt3QaPAd/mdYKTLE+pC6L3c0jVcAtXAsgC9ry5Jx+Ficev7hz0QWoPQjmc5
         PfJVnwhOuw9NeANvAVjUGL2chVP1XPjQd3YG8SiTQ4PKCGNLpS35h0a7fRb9+p8EvfrD
         AX5AmCa467H5IISANO61Sbj84iuIqL/l4Eh+aifH1R5+z5lo0aHDh678e900E6jrBcWW
         cpfhx0Qim1xvNBRCV1QdjcYcaQea1GmHNkOsiJNdXZ671+5C+vfXjmW5O7zMD0bPX0sM
         JPu7sGmVSd6y3mAfm5SIHcFPajOsLRFf3+V85zsxQBEAV+YMg6rJd91hfR20fMmKM6YE
         R/hw==
X-Forwarded-Encrypted: i=1; AJvYcCWTqYzJE8X0SQp+sAPXqlgaLCzkgtAaIVx7zXhEhLkfE3B1GRxmLFonMUdJ4GL7jMcqfw6ibNNsk7rmfdr9aBicXBPJFkBpJom6z+I0
X-Gm-Message-State: AOJu0YwSO6dSc1mmdjanOcuDUqQo1G9qtV5e13O55CMFhwLUPeBads+R
	UICbd9PFeRLb7Jc9MiJjg0nRWA6XgGO9K746KAhDfYe1ahwERwLvMuQUmqJmDDKcyuZSpRkXTUm
	3kteLmQbjd6OtBAX2kGylN9bCQ3wWdaqKEv0P
X-Google-Smtp-Source: AGHT+IE9JeQQLCu7nhMNKaiTfyP6ZF0+xEA3lJHdLbUAa1gOV9ye6P3FZco1GiciGNvgewufb05FgG/qwPJgdjvVuxg=
X-Received: by 2002:a05:6402:430a:b0:572:10ff:50b1 with SMTP id
 m10-20020a056402430a00b0057210ff50b1mr50373edc.2.1713774362161; Mon, 22 Apr
 2024 01:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
 <687c8f6a-d5d6-4918-bfd5-93d4b04da086@molgen.mpg.de>
In-Reply-To: <687c8f6a-d5d6-4918-bfd5-93d4b04da086@molgen.mpg.de>
From: Archie Pusaka <apusaka@google.com>
Date: Mon, 22 Apr 2024 16:25:49 +0800
Message-ID: <CAJQfnxGz9dJCU2YwwKYZLpZ73L5YS6=8yac8K5BUfPBjeeM4rg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Archie Pusaka <apusaka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Abhishek Pandit-Subedi <abhishekpandit@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 22 Apr 2024 at 15:32, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Archie,
>
>
> Thank you for your patch.
>
> Am 22.04.24 um 09:24 schrieb Archie Pusaka:
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > The hardware information surfaced via debugfs might be usable by the
> > userspace to set some configuration knobs. This patch sets the hw_info
> > for Intel and Realtek chipsets.
>
> Could you please add an example paste to the commit message?
>
Sure, I will add those.

> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> >
> > ---
> >
> >   drivers/bluetooth/btintel.c | 9 +++++++++
> >   drivers/bluetooth/btrtl.c   | 7 +++++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index a19ebe47bd951..dc48352166a52 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> >                       err = -EINVAL;
> >               }
> >
> > +             hci_set_hw_info(hdev,
> > +                             "INTEL platform=%u variant=%u revision=%u",
> > +                             ver.hw_platform, ver.hw_variant,
> > +                             ver.hw_revision);
> > +
> >               goto exit_error;
> >       }
> >
> > @@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> >               break;
> >       }
> >
> > +     hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
> > +                     INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
> > +                     INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
> > +
>
> Why does it need to be added at two places?
>
Intel put the HW information into two structs, the "intel_version ver"
and "intel_version_tlv ver_tlv".
I don't know the history of the two structs, but that requires us to
have the hw info set in two places.
At most only one of them is executed though.

> >   exit_error:
> >       kfree_skb(skb);
> >
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index cc50de69e8dc9..4f1e37b4f7802 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> >
> >       btrtl_set_quirks(hdev, btrtl_dev);
> >
> > +     hci_set_hw_info(hdev,
> > +                     "RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
> > +                     btrtl_dev->ic_info->lmp_subver,
> > +                     btrtl_dev->ic_info->hci_rev,
> > +                     btrtl_dev->ic_info->hci_ver,
> > +                     btrtl_dev->ic_info->hci_bus);
> > +
> >       btrtl_free(btrtl_dev);
> >       return ret;
> >   }
>
>
> Kind regards,
>
> Paul

Thanks!

Archie

