Return-Path: <linux-kernel+bounces-86811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC886CB26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7931F24E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11011350C9;
	Thu, 29 Feb 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS894wRG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1A132C3F;
	Thu, 29 Feb 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216079; cv=none; b=J2M8UfBAdHju/Pb5p3o9NadJRADcwPMUnwPvqFFTrETNHyPVboU0FlmrNxoKOcodNe8nFncK4YYav+17Wlnc3br+okAS3YHScHr5EVATuPYGQNkSrcIGiin06HOvt+XeiwQ6Lxc/eiY3ayhZL8Aabvvj9qzij74S2GZW9YBb/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216079; c=relaxed/simple;
	bh=HdUriU/o7p+TJVKp8jcHMkb9o6rennDGOO4M29rZTSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozxSrOwn0BhrCtQrT3enq61dcapV02p/XZ7eDGhSefhzMer2Er+zs2+OvPo6ORjXBiVDnwelH88j3U5anP4izssst8NVKwf2csh6QrsVcVFJ6fSk1fa2BN26BhZD2rEnA0n409o9CrOSVnjS51VhfMci9YNwGyr03GCPL4Vhpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS894wRG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2991e8c12so9186041fa.0;
        Thu, 29 Feb 2024 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216075; x=1709820875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I0GaXs/KS6jibEXSxJRCbQvwNXXO9EOyEcwveEjwi0=;
        b=BS894wRGapjEsz5jgIz4RF2FSPX1yBENOkjFo58aqpTjAfVuKu85A2ZXij6N0nb4QZ
         ZNJagSIv6WdFBZCpg1ion2Wml2oU1bZwls0ZePN9Yw4fz1R8bSfFkB1drf7nPe5yR7t7
         iUjJjbOHegjAPXmmCh+G5e/jzm0Qmj6EkYqs/FLVdQGWvR310culAfQujMZU3oOhF8o/
         9WVnTJmYFG/5ycD3j/PoHvN56qv93CxSkZHbqHnJ1fB2+kH+GLS6XfTVmF1BVXVgNv7a
         ZyjoQW9xLe9JvYzY4uOXuoPJ/LeEe6bbDU9WPz8OvUwcRvUt76wS9a/9HzpBRrWuK9B5
         o5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216075; x=1709820875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I0GaXs/KS6jibEXSxJRCbQvwNXXO9EOyEcwveEjwi0=;
        b=Wxve8vhR2pnYoGK5A1kEITxKcxjsqUSVo9ufyxz0sT+cFOaaTYaLPPB9KJDyYbJoHQ
         RE2TKSxZ59vJ6my1/KurKIZ0XT51Ako8fBO5U6bSlDvq5TnxLZPbzgdOcFlAnR/ZHQJq
         tHlOMwByS2sDZNAY0b9n39ojTdKj+qROHgFl689n5ufi4zsaE37ovXjntLoRa8RKBiUX
         HQgW5WANJlNLEZ65Tlm4h6aUW9ef+kGIKGF+AjX74oTLg2Vph3wW1ikzujaCnp+eczWM
         8b5acK8aM0EJcnrG1Aw8eZHeT2ZtJ1Lz8X7VJiPD/NRd6wUFg8eMUmzVElm5NKqlLtF9
         CbZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1aw/qjz+FDG6qRnqWnvvWfWwFXCFnehxGBbWCLr3rJRkVreL5zSrYSMPsyxDwEofc9FBWsdHcy16+QTWcs3jL2iF1BCrbqiYdfse59wptZy8nh8rURXWG0G6hSDg+Sigzw/yEBhnhLGlFfo8q
X-Gm-Message-State: AOJu0Yw26kKhuhJIp8zRRI79lvPngxti058/5ZdXSaWPHlis7qcDHts6
	gVe1D9oAC4w4fqKom58P1ZmjocOl4zpUWn3/axxUj0npYzJ4z7QDBqnANa17TZBOIgn962USbbz
	bAhUr57nZoKKjsjELLafRP/VkzDs=
X-Google-Smtp-Source: AGHT+IH47H4VrZBfL3nn48A0xQ0CzrIPVjgxKRdoau4yTwKhEfikNZselEugxrGFNMKuNecB8+aLznB9KlJ/vFN1Dw4=
X-Received: by 2002:a2e:a7c9:0:b0:2d2:795f:4a8 with SMTP id
 x9-20020a2ea7c9000000b002d2795f04a8mr1099489ljp.18.1709216075266; Thu, 29 Feb
 2024 06:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229084059.895730-1-clancy_shang@163.com>
In-Reply-To: <20240229084059.895730-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Feb 2024 09:14:22 -0500
Message-ID: <CABBYNZK1eqfS8Ro8xZXpt-VhfzxxYepkqZamXkipKPGscg6Y8Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: mgmt: Fix wrong param be used
To: clancy_shang@163.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 3:41=E2=80=AFAM <clancy_shang@163.com> wrote:
>
> From: Clancy Shang <clancy.shang@quectel.com>
>
> if the BlueZ library calls the API interface "adapter_set_device_flags",
> which sends the "MGMT_OP_SET_DEVICE_FLAGS" opcode to the kernel, but
> does not receive the callback message "MGMT_EV_DEVICE_FLAGS_CHANGED"
> from the kernel. it fixs this bug.

Please stop sending this change, the client who sent
MGMT_OP_SET_DEVICE_FLAGS is not supposed to get
MGMT_EV_DEVICE_FLAGS_CHANGED back:

https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L4975

If there is a problem with that then perhaps it is in userspace not
setting the flag on command complete.

> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 9dd815b6603f..c74abdf3618f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5177,7 +5177,7 @@ static int set_device_flags(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>
>  done:
>         if (status =3D=3D MGMT_STATUS_SUCCESS)
> -               device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr=
type,
> +               device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->ad=
dr.type,
>                                      supported_flags, current_flags);
>
>         return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, =
status,
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz

