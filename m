Return-Path: <linux-kernel+bounces-63311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3E852D85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC73285EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A197225CB;
	Tue, 13 Feb 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zY1m6ZK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7622611
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819000; cv=none; b=q+7KRlYn7/0XP0nRqRXBxYe8FAQbY774jnxHL+aPykNSx2RgsHgdW+z6J+qZc5CpCIz2/hsg9HUaGfbynstGFac80TWhQjfJnvYgfN9S5G5gsipF9ma9J62ZOXa6W9gupWQTBD22Vk1iB7jjjGPOgUDxYMsanLJE6/xn3o8Q54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819000; c=relaxed/simple;
	bh=iV0LNlu09L+usvqCOo1VRBf+A61/7Q4YqPsN6h9xJrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0v9dJgVmZApReYzvj5WYej/IM4UezYTSFH0qcdVRb01nh0tQeXRDp/Ox5P5i1Xw90jYPQsQqA6A/UmGvcGcOVU+Zq0UmvDec0rkjPgkrTUHz3mrEdTHL3bAR484VN35HjDIFnC4DT7Qnr+h3vxyqBQHvhYgTb/ttru3xhKisMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zY1m6ZK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e08c16715fso1712108b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707818998; x=1708423798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gCHmuatdsgry8k30N4puCgoRyQDLlrHu4bpm0vi5/U=;
        b=3zY1m6ZK3msONF5aOHtyxp5yhMulnBt5mBsbsG/eVhufWc/WRZAxc9jIFcu7kDqoyh
         F/HYC+kgqYFtAtCP4FNkvZYjkhPCVaHTlbAayY3Uh5BubB65usdfJ8tua1S3wz+rQj+D
         f5cCVhvjCtc7zpBQDS4s/ossAtWhfONdxnfM02VSxiUgVYSMvimR/OrtEmrZESDiWOI6
         IIHe1PJ6NUaiE7rNlhTTXF1FjD+PrfFGVcuWu3/3XQIXVXuQufgXkYHdw1AvDmnNhbly
         UscxeZ8ol6BYcCkEwYaerisBAZH7Pf3kPvqsgZbgelSTWfZU3TmSpGN2m6b9jmZIdngi
         PUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818998; x=1708423798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gCHmuatdsgry8k30N4puCgoRyQDLlrHu4bpm0vi5/U=;
        b=TPQkIC1wM9WJ5EPlP+ca6l65YhIShI1w0CgWOyjEgtM7D8t//FxvHUuyNH0juXNxjv
         O+Ua386zy4pNOPXUZpjHKJYiuZjYVOFJXT6F5vC/lccT9PjCNIWH+JmFI05GJGTKB9bR
         YCWNDSEEOm3dQFZbH9QMWaPKt+PhbIq68EJ6fih1gtavyEvHt/8dX3DE43wpmo7/QEOe
         VVMyroh5lQQgFAWZvMI2IHbq8h4ToM4q4vYbc9EXZbU/weZ5mFmnUdBFYEWn74YwGKtF
         1v+jUTqbEZP4A6BWoqEPmkFME6oRIvsrwkVVk67nfbEsAyikqroJoAegD+h/G3Qnzp1n
         QgzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAD38WMzekf/Lb8C7SY0F236l5RF+ikvs8gx27mieOiCjole2fbsVkDIKrXcIuahI11c44vaabRSt/T5UzVj9BQDzEMwlb9E0/i7gc
X-Gm-Message-State: AOJu0YyXbys+fG/73gopyisR9+cG3Oinb8OZVMZmFR//HCEHGjmMGqOZ
	1HSjTMooBdJJxqBvu1g7dxl0I6MkmE01f1hlcfMUBiRWcqG8D+hZWlwrdemCOTG13bL9mqMW0qy
	q6yeEuyNxTEMrGwwDw+AmLySoXNLnX5O7n0yE
X-Google-Smtp-Source: AGHT+IFbcgWLigGId4RU9uYlUZvt9W4RnnU69Uv78HX3R5mO1+ACmJmHNus7LLTVSoHLMIVgHNTJiSKijjkUYLw42n8=
X-Received: by 2002:a05:6a20:94cb:b0:19e:3a94:6272 with SMTP id
 ht11-20020a056a2094cb00b0019e3a946272mr8092548pzb.44.1707818998063; Tue, 13
 Feb 2024 02:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>
In-Reply-To: <20240212-usb-fix-renegade-v1-1-22c43c88d635@kernel.org>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Tue, 13 Feb 2024 02:09:16 -0800
Message-ID: <CAPTae5LOresaK3Epd4R_ifpx2kw21tubQDENg4OMrhJWsar-oA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tpcm: Fix issues with power being removed
 during reset
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>, 
	rdbabiera@google.com, amitsd@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

While HI-Zing CC pins disrupts power for batteryless devices, not
Hi-Zing CC pins would prevent clean error recovery for self powered
devices which is why "usb: typec: tcpm: fix cc role at port reset" was reve=
rted.
Please note that the breakage in error recovery behavior is a
regression as well.
Hi-Zing CC pins would make the port partner recognize it as disconnect
and will result in bringup the connection back cleanly.

How about leveraging "self-powered" device tree property and Hi-Zing
CC pins only when using "self-powered" ?
This should help devices which don't have batteries while NOT regressing
the error recovery behavior for the self powered devices.

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4897,7 +4897,11 @@ static void run_state_machine(struct tcpm_port *port=
)
                break;
        case PORT_RESET:
                tcpm_reset_port(port);
-               tcpm_set_cc(port, TYPEC_CC_OPEN);
+               if (port->self_powered)
+                       tcpm_set_cc(port, TYPEC_CC_OPEN);
+               else
+                       tcpm_set_cc(port, tcpm_default_state(port) =3D=3D
SNK_UNATTACHED ?
+                               TYPEC_CC_RD : tcpm_rp_cc(port));
                tcpm_set_state(port, PORT_RESET_WAIT_OFF,
                               PD_T_ERROR_RECOVERY);

Thanks,
Badhri


On Mon, Feb 12, 2024 at 10:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> Since the merge of b717dfbf73e8 ("Revert "usb: typec: tcpm: fix
> cc role at port reset"") into mainline the LibreTech Renegade
> Elite/Firefly has died during boot, the main symptom observed in testing
> is a sudden stop in console output.  G=C3=A1bor Stefanik identified in re=
view
> that the patch would cause power to be removed from devices without
> batteries (like this board), observing that while the patch is correct
> according to the spec this appears to be an oversight in the spec.
>
> Given that the change makes previously working systems unusable let's
> revert it, there was some discussion of identifying systems that have
> alternative power and implementing the standards conforming behaviour in
> only that case.
>
> Fixes: b717dfbf73e8 ("Revert "usb: typec: tcpm: fix cc role at port reset=
"")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index f7d7daa60c8d..a0978ed1a257 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,7 +4876,8 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                 break;
>         case PORT_RESET:
>                 tcpm_reset_port(port);
> -               tcpm_set_cc(port, TYPEC_CC_OPEN);
> +               tcpm_set_cc(port, tcpm_default_state(port) =3D=3D SNK_UNA=
TTACHED ?
> +                           TYPEC_CC_RD : tcpm_rp_cc(port));
>                 tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>                                PD_T_ERROR_RECOVERY);
>                 break;
>
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240212-usb-fix-renegade-837d35cfc0c2
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
>

