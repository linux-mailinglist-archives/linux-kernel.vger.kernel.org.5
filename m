Return-Path: <linux-kernel+bounces-140396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748258A13DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41CCB249DB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2614AD37;
	Thu, 11 Apr 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxdAMtPA"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D114AD26;
	Thu, 11 Apr 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836979; cv=none; b=KegLV6LWNXMW8W8ugL8Z5I9V8lUgNnZXUeKTRPxYEP6jON12YQAtPYfm8GGWXXAym3vYA1fTJ3QaPdr5NZ1KmnP1PRI5ON6s+E4C45UHBenvBN92RmZDTZPLt7gDu7da2EvhhRYKhUtmd192g4fgvHV/HiBzDyhMoppl8rE570k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836979; c=relaxed/simple;
	bh=NUChQD7L1PzpSkBKFayAUtvIDZjjyv5AjRgErLbm498=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aSpgaMb6tdIf0gsEXDpr3YaXvbi6omNmmNgqNp65jOlEuFpHCUyeGfKUFfD+Dg5ccvkM5F81i6ZGlu3itDYk20zgYq6cFJ8OjyunzeaYGqEL7JMAUnhD+qjMPJ1CGEL7qrW7ziN8l0S2bVKjYU85ZJmre/b+dbuJ+DyJki7UTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxdAMtPA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a53b331400so2707351a91.1;
        Thu, 11 Apr 2024 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712836977; x=1713441777; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDIUcsRKzDDRzeuhZx5cMagTLLTJx/wTwjnhBA/vtbg=;
        b=AxdAMtPAlbvfIYgGa8NN1TOwL7/TkjGN5vyinLoCNWPE+jmdK0e2P6B9QJKaA9wHkf
         z54YblURDbkXj2FZTKRhBYn1jM8tj+M3SY92Q1ZkoXhJxINv8MRrvF1Pp9UsQIS26Lbh
         jjpxCzAoeeQj6rznrk1LrGnb0+9FYooflTmzfXu4phKyDPkNr/z5F+KLbAFtdAFPVvuR
         poS7Ym+9/KV53SjxPMdGb20otXokyC/FXfisA5Odx4i121KZLDMJn/wkd1e/rwp8Za5o
         ruDtLYYlyMwdGX86UAWRhJt6M/xG15/UMUwaiMSXuQ052bGwLa9kgg0FVnxlrVZo+880
         H1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712836977; x=1713441777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDIUcsRKzDDRzeuhZx5cMagTLLTJx/wTwjnhBA/vtbg=;
        b=sS32BczSumJkLSRlP9SHYKdj1Hs0zGEz1FLj9EKzLZCL/T/TL2Ym8soKwLB0ZPwusN
         mGBaRnf03gYUU2FBs/jzy8/u7tB+feUUULeeBcF7hm3deerXGrfU8NhCJGNbPQhUDkmo
         Daq3isODE+7OqCbdYuKm28NaNazuz75x2Oq6BrBS/CePuYQPYr/P6NYOl2n9wHc7R6dd
         gVm5UlqvXEJy+ePyVPUJkjhvIT867Gz9wKT2Aoz8W8LseJn/TDEVTzJdI+I6QEgM07Eq
         MAo6fnpr4eaWDjPTO7jPQMOsVQihGUM6SVMTyXKCA4PffHvTFVRzXv3z6+YiKSNV6/xT
         P0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfYES73XG/AT4jvvF+k2yae2gV2OITam0P4iAEebuS1Mxy6UOLnMMP/7umselqSGQhx3bL1zlEP5cGSqH5ejjsZ7M1oaJRGkw+gioBYT5nyscCe94VzRZtjKdL3PVEtYtkCF8o9AgqVJw=
X-Gm-Message-State: AOJu0YygcF1d40QQ8TcCS9hh9eT5wgFt3RzIWUBGuSLCUYtsuIo87b7o
	RKZb4bxja3lpoldFovXYmbQyzyPpBuSVJxhlDtLS1e/ajDase9Z1d7uKU24M3YEMjMQC5tYMvrF
	1uxr4JnxSBjEe9MnHPwm+JyyROOKw5A==
X-Google-Smtp-Source: AGHT+IGWZd7rv0JGb7jCs5pNNkhIYDQrDsSg0XecCaVkqEcQCQ8f+wHHYTqrccy/fyzSUnkl06LofEZv2NF1B+rIQX8=
X-Received: by 2002:a17:90b:4f83:b0:2a2:7693:399e with SMTP id
 qe3-20020a17090b4f8300b002a27693399emr5050228pjb.4.1712836977114; Thu, 11 Apr
 2024 05:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308121338.1983-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20240308121338.1983-1-yongsuyoo0215@gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Thu, 11 Apr 2024 21:02:45 +0900
Message-ID: <CANXPkT6Bcj0Xbn308jNGp-vqTEcB9LKtUjZ1_zS-tc7KuBEMwA@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic into CA_RESET
To: mchehab@kernel.org, yongsuyoo0215@gmail.com, v4bel@theori.io, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Can you review this patch ?
Can you share how this modification is going ?

2024=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:13, <y=
ongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yongsu yoo <yongsuyoo0215@gmail.com>
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET ioctl
> is called, in a normal case, the state of the thread of the
> dvb_ca_en50221_thread_state_machine will transit like below order.
> DVB_CA_SLOTSTATE_NONE -> DVB_CA_SLOTSTATE_UNINITIALISED ->
> DVB_CA_SLOTSTATE_WAITREADY -> DVB_CA_SLOTSTATE_VALIDATE ->
> DVB_CA_SLOTSTATE_WAITFR -> DVB_CA_SLOTSTATE_LINKINIT ->
> DVB_CA_SLOTSTATE_RUNNING
> But in some problem cases, the state will become DVB_CA_SLOTSTATE_INVALID=
.
> Among the above mentioned states, the DVB_CA_SLOTSTATE_NONE and
> the DVB_CA_SLOTSTATE_INVALID are "already stablized" states,
> whereas other states are "transiting" states.
> The "already stablized" states mean no matter how long time we wait,
> the state will not be changed.
> The "transiting" states mean the states whose final state is not yet
> determined. The state keeps to be changed. Only after some time passes,
> we get to know whether the final state will be DVB_CA_SLOTSTATE_RUNNING
> or DVB_CA_SLOTSTATE_INVALID.
> During the "transiting" states, we do not yet know whether the
> CA_RESET operation, which triggered the "transiting" states, will
> succeed or fail. For this reason, during the "transiting" states, if
> another CA_RESET ioctl is called and if this new CA_RESET ioctl
> operation begins again, it will be meaningless and waste time.
> For preventing this problem from happening, we make CA_RESET ioctl do
> nothing and only return EBUSY if the ioctl is called during the
> "transiting" states.
> ---
>  drivers/media/dvb-core/dvb_ca_en50221.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-=
core/dvb_ca_en50221.c
> index baf64540dc00..2e8aec354b7c 100644
> --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> @@ -1362,13 +1362,19 @@ static int dvb_ca_en50221_io_do_ioctl(struct file=
 *file,
>                         struct dvb_ca_slot *sl =3D &ca->slot_info[slot];
>
>                         mutex_lock(&sl->slot_lock);
> -                       if (sl->slot_state !=3D DVB_CA_SLOTSTATE_NONE) {
> +                       if ((sl->slot_state =3D=3D DVB_CA_SLOTSTATE_RUNNI=
NG) ||
> +                           (sl->slot_state =3D=3D DVB_CA_SLOTSTATE_INVAL=
ID)) {
>                                 dvb_ca_en50221_slot_shutdown(ca, slot);
>                                 if (ca->flags & DVB_CA_EN50221_FLAG_IRQ_C=
AMCHANGE)
>                                         dvb_ca_en50221_camchange_irq(ca->=
pub,
>                                                                      slot=
,
>                                                                      DVB_=
CA_EN50221_CAMCHANGE_INSERTED);
>                         }
> +                       else {
> +                               if (sl->slot_state !=3D DVB_CA_SLOTSTATE_=
NONE) {
> +                                       err =3D -EBUSY;
> +                               }
> +                       }
>                         mutex_unlock(&sl->slot_lock);
>                 }
>                 ca->next_read_slot =3D 0;
> --
> 2.17.1
>

