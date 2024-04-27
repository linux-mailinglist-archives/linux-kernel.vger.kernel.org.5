Return-Path: <linux-kernel+bounces-161166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC08B47E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97313B21588
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5550145359;
	Sat, 27 Apr 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4n6669J"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A203F9C6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714249973; cv=none; b=WqLasT2GUqh0bgTbKsrgzDOef7BzUrYAvgq4JhUB9u4Lzm7bHQ5ebNIZ2eWgqjWDFUCjW1/ZkH7nIJHwBMaQZdvYU1LtI0+lIoMyt47lRbVYLtkiwJa2zpslfmZI/8grAW8sgHs7O6D2zfXO/0esgAzHyKJDn+RO3wB2xRNdpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714249973; c=relaxed/simple;
	bh=KGgqkmnD2wjWyjCm//R47uVR9FNYf7gectdDDsGPGEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgMFut+WESmY87U0JE3Qv9Lr5z+473W6q7csTIxNhNcxq5aixG6rMRhXTalxgANuEn2zGK7UNoliB+N2Z8mj1Gpe0HZSAYqhIXBCUjWcjfpD82/iVJsAlUwcvWW5w+qauy03S8AMgPHNSNSWuVfIYoM52Jjf6aZoyilOrwn8I6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4n6669J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so30225545ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714249971; x=1714854771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DvKgeDrDwAqJ4wtw0FIZw4vVsv/4dvMfq+61b4reGQ=;
        b=y4n6669Jpr3UN508cnWHtedC9KWJeiQhSMbJgtQc2NHxA4FRzafI1u2nV/1LIdrLzL
         ubOrDdA53J28RGIoEgba2lPAlEzTI/9+vFR6ja4NMpQHhMNfGCOqJR3WwSdO0sse66Vs
         MtbDAJtvmbeGA3nPNn/jos8qvZLpDUiOz/IbYqtIXYKr9QdxWj03WSlw4R/k2EAJ+jVj
         2ehGGZQdxdGMXO8fJ3QvCTdQY5/xWqeSRAobGV88jHJOPRYYWp9PZp2O3G9+g1SfAl3D
         8PjxYElVtjmh5LTu1QPgMK9E6AIaQAcjpiBV4Xo5f4igrWCs2GXd8aJPLJqQsm3w8VEC
         Svlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714249971; x=1714854771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DvKgeDrDwAqJ4wtw0FIZw4vVsv/4dvMfq+61b4reGQ=;
        b=f+NOiqEfzgZ8JdE2k7o28j38zOWzR4JZaxAGcZGPpbInFlYiaGAR6uYilV4ts1dUMh
         Q68P64bIv/lGMGLg4GFh668OfTn5lzUgImlO4lkPf2jb//fGLBVg0S8lh8+Q4F9c2FGt
         vHTUGqJ3V1R7TLF+FPLunaBEpnaDSq2o2tYk1cUaGpaz0B30BXvaE181yX/jo8yeYCkL
         nIDNDFfucNHyuYhyNAV9Phj8wp5XiXea0fpOB8k79XU7xOM5T8Jx3olwho4QF+YiQn8h
         9QmN/3mbjfKzxkOg4LgMgdW22TXV6NqL4RzxlaAknPf1IuQ0n9xEvhYVbKHr0hk3MRr1
         DRXg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Ps5LIT+Jx26nvqa0yR5mfoMSxheli2rX+ofTKwuS7uE6gstidoi9o3REPb8m5JwVRrlHt9r+mqN2s9fZmobgE95WTcILvq9b22W9
X-Gm-Message-State: AOJu0Ywd/Ky8yLNyTmwLMZhyUxfu+cDvGc/iW5G9WpWrAHZZkn+HLopJ
	zErog9N3ZnkgBPb+hCg0WUxX97ih+OVAleDeUodvEO1jk5VMgZoogcahB1yPxeQZYiM8+CEuGld
	Ed5J4CbPNcYfnqJHDdWDT3sz4j4ltIBEGGJdl
X-Google-Smtp-Source: AGHT+IGyneE40eEQiVLgA9cPbKtqXTPLWQlrZZHZkiN7TKnv2aAh1MBYjo9WhrOabZ89pSe/i2/4u/9rjDz7bZ0WIZM=
X-Received: by 2002:a17:903:41ca:b0:1eb:1240:1aea with SMTP id
 u10-20020a17090341ca00b001eb12401aeamr7794687ple.20.1714249970767; Sat, 27
 Apr 2024 13:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427201828.3432713-1-badhri@google.com>
In-Reply-To: <20240427201828.3432713-1-badhri@google.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Sat, 27 Apr 2024 13:32:13 -0700
Message-ID: <CAPTae5+gh20n1Em90o970cTobFUnFqmpE6aHs6+DNOyoav=MXQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Check for port partner validity
 before consuming it
To: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com
Cc: kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, 
	stable@vger.kernel.org, frank.wang@rock-chips.com, broonie@kernel.org, 
	dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 1:18=E2=80=AFPM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> typec_register_partner() does not guarantee partner registration
> to always succeed. In the event of failure, port->partner is set
> to the error value or NULL. Given that port->partner validity is
> not checked, this results in the following crash:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000000003c0
>  pc : run_state_machine+0x1bc8/0x1c08
>  lr : run_state_machine+0x1b90/0x1c08
> ..
>  Call trace:
>    run_state_machine+0x1bc8/0x1c08
>    tcpm_state_machine_work+0x94/0xe4
>    kthread_worker_fn+0x118/0x328
>    kthread+0x1d0/0x23c
>    ret_from_fork+0x10/0x20
>
> To prevent the crash, check for port->partner validity before
> derefencing it in all the call sites.
>
> Cc: stable@vger.kernel.org
> Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on=
 pd revision")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index ab6ed6111ed0..454165776797 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4,7 +4,6 @@
>   *
>   * USB Power Delivery protocol stack.
>   */
> -
Unintentionally removed a blank line. Please ignore this version - v2.
Sent v3. Apologies !

>  #include <linux/completion.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -1580,7 +1579,8 @@ static void svdm_consume_identity(struct tcpm_port =
*port, const u32 *p, int cnt)
>         port->partner_ident.cert_stat =3D p[VDO_INDEX_CSTAT];
>         port->partner_ident.product =3D product;
>
> -       typec_partner_set_identity(port->partner);
> +       if (port->partner)
> +               typec_partner_set_identity(port->partner);
>
>         tcpm_log(port, "Identity: %04x:%04x.%04x",
>                  PD_IDH_VID(vdo),
> @@ -1742,6 +1742,9 @@ static void tcpm_register_partner_altmodes(struct t=
cpm_port *port)
>         struct typec_altmode *altmode;
>         int i;
>
> +       if (!port->partner)
> +               return;
> +
>         for (i =3D 0; i < modep->altmodes; i++) {
>                 altmode =3D typec_partner_register_altmode(port->partner,
>                                                 &modep->altmode_desc[i]);
> @@ -4231,7 +4234,10 @@ static int tcpm_init_vconn(struct tcpm_port *port)
>
>  static void tcpm_typec_connect(struct tcpm_port *port)
>  {
> +       struct typec_partner *partner;
> +
>         if (!port->connected) {
> +               port->connected =3D true;
>                 /* Make sure we don't report stale identity information *=
/
>                 memset(&port->partner_ident, 0, sizeof(port->partner_iden=
t));
>                 port->partner_desc.usb_pd =3D port->pd_capable;
> @@ -4241,9 +4247,13 @@ static void tcpm_typec_connect(struct tcpm_port *p=
ort)
>                         port->partner_desc.accessory =3D TYPEC_ACCESSORY_=
AUDIO;
>                 else
>                         port->partner_desc.accessory =3D TYPEC_ACCESSORY_=
NONE;
> -               port->partner =3D typec_register_partner(port->typec_port=
,
> -                                                      &port->partner_des=
c);
> -               port->connected =3D true;
> +               partner =3D typec_register_partner(port->typec_port, &por=
t->partner_desc);
> +               if (IS_ERR(partner)) {
> +                       dev_err(port->dev, "Failed to register partner (%=
ld)\n", PTR_ERR(partner));
> +                       return;
> +               }
> +
> +               port->partner =3D partner;
>                 typec_partner_set_usb_power_delivery(port->partner, port-=
>partner_pd);
>         }
>  }
> @@ -4323,9 +4333,11 @@ static void tcpm_typec_disconnect(struct tcpm_port=
 *port)
>         port->plug_prime =3D NULL;
>         port->cable =3D NULL;
>         if (port->connected) {
> -               typec_partner_set_usb_power_delivery(port->partner, NULL)=
;
> -               typec_unregister_partner(port->partner);
> -               port->partner =3D NULL;
> +               if (port->partner) {
> +                       typec_partner_set_usb_power_delivery(port->partne=
r, NULL);
> +                       typec_unregister_partner(port->partner);
> +                       port->partner =3D NULL;
> +               }
>                 port->connected =3D false;
>         }
>  }
> @@ -4549,6 +4561,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(e=
num typec_pwr_opmode opmode)
>
>  static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
>  {
> +       if (!port->partner)
> +               return;
> +
>         switch (port->negotiated_rev) {
>         case PD_REV30:
>                 break;
>
> base-commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd
> --
> 2.44.0.769.g3c40516874-goog
>

