Return-Path: <linux-kernel+bounces-128316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36408895941
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA111C228C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F51411F1;
	Tue,  2 Apr 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/UfhyVN"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E73611A;
	Tue,  2 Apr 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074006; cv=none; b=Kunq7oMwGQd7yn8TrIUXyVFVvwk06SlLtCbwH4bFBBGwvLfy45XXaQypGyiB1dvibLun06kRUDEGdP56SGeeZFtvoOSCsWQB8uOV3xU98sdP2npu/My561i9OEqCYoTpD8IcGgUfBWOy0kr0mD3zABhD8GfYiAECShRHnh3JZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074006; c=relaxed/simple;
	bh=WQivR71oYkoXZ/ejsa6r8Mv28pNMEB0J7+Wo3aeJdhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJBA8eOoiSlUxVGRzizuwlMqob2T3Jx5SIH5KwmSsDdqHW7l53sV502BmggEoIBo0L9lIwcXQsA4pHFrPV99bhYKKHzgkqCdNh4HPoyb1yH8uDGCLhQOEfkwphEgoAZU6RRXUOKlNKMNQmublm3dxQyhbF58HfVLiDGFr8Yp5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/UfhyVN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso75974421fa.2;
        Tue, 02 Apr 2024 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712074003; x=1712678803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1VgFYM84qSzRh//BHYcWN9+jqOqE1vEM5jr1MyGD+Q=;
        b=S/UfhyVNZ1eEIcWJXE3PJpi/IWEaFDn31iTYX5t5VDarvp5yic7Kin5CXI3zDSHl96
         hP2VmsL6hmOA60UqwUQHVG6zHXcOhgczt1dbI4btUTvxHgsMdzEIokU7E+R8seChFlOM
         /HTXJZAZjuJ0tzHIFnca8X3RD3/FXBJ1GRRDEy1m/GC66c8VSvpD+unA6C2kU5Oj/yXz
         th25WS4xMHAIgoW+mL/z/n3ezaZelbMzxG5MepU3gGzs9sMqxIlCGGipWHNyMw/hK2lJ
         5j/TBy1lJ3EJzS6AxPWwbBx/UyrsuciTumwscAbDnYOiweSVncpV/edvhkh9ifMEMUUq
         CZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712074003; x=1712678803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1VgFYM84qSzRh//BHYcWN9+jqOqE1vEM5jr1MyGD+Q=;
        b=QXhFA+PM0gRjhCd5Shld5RnzbpLSFvNnVlHRY2V7krsk/Hc+v8rbUXsRPwArXdiTW9
         x22A96ZyLPB5C10U/bUFHJmiSeNFGcwmcERnWyvVhXU5DaMkQTd0Hvg85kcDVEwmQkQy
         ZRwIX2pRAWWFWtO/Kjg/JyAeTTByd3of8qmufdmTibb+BFxWr+yj5XgBTa7FRhRtRFTH
         NiiDsBPCEQVoGNIgE/Yhw3S76jg3FKJ+VJQgpG1NEogzXw2Mf21S2OlHe9xYfAD6pB/C
         KP2XQ3vANAC1t+samMKC/YiENZ/JWLIb9Z4eVfxPGxjVFhzYtpp0M3uEOQ02Oe+ypgJM
         LteQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYaP5hX9TGe7pw8Tyv96qahz0RujfMdjEpvzS365g9GiMhKEhmH0N+Oq0HWLIMFoiqeKWHeVTf9sJhirfAc3P51VK54GLJjGum/JK3zm/KkhzmLZ2+pPbPS8CtImDBpLnNwIaKmT5mhaoTFN3F
X-Gm-Message-State: AOJu0YzppSHRZq/EROo4VaMdN5TR0CZ8jrV7Ru9jBaeDzAGYjqvfc458
	UACGrRiMZYG6T5q4f4n4CmiIyHU9Xlx6ZoeBbbqTweMWGB+QMXJ5WpwQGyPR03FsKXlluLt4C05
	qvDvwO2or3aVEGbrIcAHmNyShySI3TpHu
X-Google-Smtp-Source: AGHT+IE09E+v4t6+ZN1sfgLdg4tmBCNh36qVCjbxQINWbGL5+8Qjk5tQ0Fk57aTul/mAY9umLPbqHDtj9BMhx1cMmk4=
X-Received: by 2002:a2e:a40f:0:b0:2d8:323f:dc3c with SMTP id
 p15-20020a2ea40f000000b002d8323fdc3cmr954071ljn.5.1712074003009; Tue, 02 Apr
 2024 09:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402155543.36856-1-me@wantyapps.xyz>
In-Reply-To: <20240402155543.36856-1-me@wantyapps.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 12:06:30 -0400
Message-ID: <CABBYNZJ5y9DDgKwZjsCrpn6fn0KgR5NOnQ9YuZ1bGS=mbseMGA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl
To: me@wantyapps.xyz
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uri,

On Tue, Apr 2, 2024 at 11:56=E2=80=AFAM <me@wantyapps.xyz> wrote:
>
> From: Uri Arev <me@wantyapps.xyz>
>
> This fixes the following CHECKs, WARNINGs, and ERRORs reported in
> hci_intel.c
>
> Reported by checkpatch.pl:
> -----------
> hci_intel.c
> -----------
> WARNING: Prefer using '"%s...", __func__' to using 'intel_setup', this fu=
nction's name, in a string
> +       bt_dev_dbg(hdev, "start intel_setup");
>
> ERROR: code indent should use tabs where possible
> +        /* Check for supported iBT hardware variants of this firmware$
>
> ERROR: code indent should use tabs where possible
> +         * loading method.$
>
> ERROR: code indent should use tabs where possible
> +         *$
>
> ERROR: code indent should use tabs where possible
> +         * This check has been put in place to ensure correct forward$
>
> ERROR: code indent should use tabs where possible
> +         * compatibility options when newer hardware variants come along=
$
>
> ERROR: code indent should use tabs where possible
> +         */$
>
> CHECK: No space is necessary after a cast
> +       duration =3D (unsigned long long) ktime_to_ns(delta) >> 10;
>
> CHECK: No space is necessary after a cast
> +       duration =3D (unsigned long long) ktime_to_ns(delta) >> 10;
>
> WARNING: Missing a blank line after declarations
> +               int err =3D PTR_ERR(intel->rx_skb);
> +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err)=
;
>
> Signed-off-by: Uri Arev <me@wantyapps.xyz>
> ---
>  drivers/bluetooth/hci_intel.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.=
c
> index 78afb9a348e7..44731de1a2d6 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -537,7 +537,7 @@ static int intel_setup(struct hci_uart *hu)
>         int speed_change =3D 0;
>         int err;
>
> -       bt_dev_dbg(hdev, "start intel_setup");
> +       bt_dev_dbg(hdev, "start %s", __func__);

We probably don't need __func__ either since this is normally calls
pr_debug which already has support for printing function names if the
user wants to, so I just leave as bt_dev_dbg(hdev, "");

>
>         hu->hdev->set_diag =3D btintel_set_diag;
>         hu->hdev->set_bdaddr =3D btintel_set_bdaddr;
> @@ -591,12 +591,12 @@ static int intel_setup(struct hci_uart *hu)
>                 return -EINVAL;
>         }
>
> -        /* Check for supported iBT hardware variants of this firmware
> -         * loading method.
> -         *
> -         * This check has been put in place to ensure correct forward
> -         * compatibility options when newer hardware variants come along=
.
> -         */
> +       /* Check for supported iBT hardware variants of this firmware
> +        * loading method.
> +        *
> +        * This check has been put in place to ensure correct forward
> +        * compatibility options when newer hardware variants come along.
> +        */
>         switch (ver.hw_variant) {
>         case 0x0b:      /* LnP */
>         case 0x0c:      /* WsP */
> @@ -777,7 +777,7 @@ static int intel_setup(struct hci_uart *hu)
>
>         rettime =3D ktime_get();
>         delta =3D ktime_sub(rettime, calltime);
> -       duration =3D (unsigned long long) ktime_to_ns(delta) >> 10;
> +       duration =3D (unsigned long long)ktime_to_ns(delta) >> 10;
>
>         bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
>
> @@ -822,7 +822,7 @@ static int intel_setup(struct hci_uart *hu)
>
>         rettime =3D ktime_get();
>         delta =3D ktime_sub(rettime, calltime);
> -       duration =3D (unsigned long long) ktime_to_ns(delta) >> 10;
> +       duration =3D (unsigned long long)ktime_to_ns(delta) >> 10;
>
>         bt_dev_info(hdev, "Device booted in %llu usecs", duration);
>
> @@ -977,6 +977,7 @@ static int intel_recv(struct hci_uart *hu, const void=
 *data, int count)
>                                     ARRAY_SIZE(intel_recv_pkts));
>         if (IS_ERR(intel->rx_skb)) {
>                 int err =3D PTR_ERR(intel->rx_skb);
> +
>                 bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err)=
;
>                 intel->rx_skb =3D NULL;
>                 return err;
> --
> 2.44.0
>


--=20
Luiz Augusto von Dentz

