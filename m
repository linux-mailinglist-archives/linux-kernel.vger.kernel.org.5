Return-Path: <linux-kernel+bounces-103206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06987BC63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73FA28393D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AB6F08A;
	Thu, 14 Mar 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMys2HMY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE75CDD3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417447; cv=none; b=SWkIlqnnOn439tSGtRH4k5XH6Aiw52LNtiShOt7G/ek/PMXftcctJAP2X2NY1dXhSp27hHl6x7WdsiyG1qLs5yvwYyQCYCBCNpa37IGdD7p+6s+RH3H7qUyOIdnCPiIrea4eS/HajAyV0a/Sz+H0/jbXgR9ZLN1mO12Rfmjrh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417447; c=relaxed/simple;
	bh=AdMsm2idLYumEp0ZXOMFAz1fRELSXatQYvEc+3tGX+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoOgEGYeyuSOR5An723NCIryya9eTtGOxN7pTdeWrU7ICsDl0lkbfvw6+Re8GP0oNM9g7PbCn0ENsR1uj0XrJWJDxB7TGaWzMtaRhHDjBZq377sErdADYNG4uysZJS5eVWRH6e0YHWkOhtXrz9kBLZ52kWkwudVZUudNHQLMJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMys2HMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710417444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yj68QAc/GDKe4pAWzzjDhY33mBI0iwde75NIqen9o=;
	b=jMys2HMY/MvXLzTQhxJ+915FM5DBMAQlf9xMznLkJrBRX3LNfuIqdLM6BK0r2FL3UgjTzA
	DHb+kmh+BvT2BhzomLvJ8aHXVCbwRkQMzu1PYCdxMrnu0IibqrTrDouEn1wDe5wLlWPL8y
	2bkG63iT6L/ffE3f42V+9G5mWSbbWg4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-oWFeemsEM6eckFfgX47SZg-1; Thu, 14 Mar 2024 07:57:20 -0400
X-MC-Unique: oWFeemsEM6eckFfgX47SZg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4531df8727so25396966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417439; x=1711022239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Yj68QAc/GDKe4pAWzzjDhY33mBI0iwde75NIqen9o=;
        b=QVKDbUsogj0e9YNh9mbKNBIcvGleuO/+BpnliUTyXkznyBljSqZt3EaCxRK92IS1g5
         sdFNIavyxhtaP451xgISFu7ZLv6a64nzb5iLPsUwMXOHukRgGrNyHPy038pUFDot6G5A
         fFr4Fg4vOzSZwMrO7eq0hWg4eJA1iOJKm4hX8AiBkOsC1sseKWVqy66U1R4Xi3sDb2ci
         Jy9886Gz5VKWirX8KJSRNibp/Duobfhk7osiwpBjzyfYx6rahTPhIIwLf89P1tZ/riYX
         iHKex9ZFHEkW+l2S8QYkC3nsIUTH5WxXnK2ReG999xihgYtcQ4Nfm/sy1azJKcIS2Huw
         rX3A==
X-Forwarded-Encrypted: i=1; AJvYcCV9ITuJO5uVO2F9sYqPMichelnhXHvfuB4e2L5bvq7cI7C382bHa1MoMbBWQw47q/rSqjOT186fJAjODWlsxIwkslM4JiaThHKWCtPA
X-Gm-Message-State: AOJu0YzCVtFJuCnqBJyh/06TvFCorGC2cJQ9E3il5St2qjKIzhQo884v
	C58BXwnz5ZdX0fl2nEDFi7mDrXhowt9hMawgbiLQA/yhithxXr+OxDeY8RYZxMHBOxxY4de4str
	Vs+oYBQGYErR+PVwDhhJ5sYSCDnpn9Tc2jw6urvCp7VR+mwhx/nQsSOkZPM4aNRDWpHF/NqRZKQ
	bHsU1UpTjKfrFHo6+qXkZpxHSnXhJJWOyVa4yT
X-Received: by 2002:a17:906:1194:b0:a45:c1a0:5c07 with SMTP id n20-20020a170906119400b00a45c1a05c07mr908085eja.17.1710417439451;
        Thu, 14 Mar 2024 04:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDd2Jv4Umtbk8PWZFo/vG9CwetRXLttChfYOuW/Phrx3fnFIjOrGAyZYjYrVlq16O3RjQTW7e3G7Su6kU5hIw=
X-Received: by 2002:a17:906:1194:b0:a45:c1a0:5c07 with SMTP id
 n20-20020a170906119400b00a45c1a05c07mr908069eja.17.1710417439108; Thu, 14 Mar
 2024 04:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313135618.20930-1-ivecera@redhat.com>
In-Reply-To: <20240313135618.20930-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 14 Mar 2024 12:57:07 +0100
Message-ID: <CADEbmW1vis35ACawye9d2S11NHA-Zpemv1m_+6eurkroLCtqqQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: Fix VF MAC filter removal
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, aleksandr.loktionov@intel.com, horms@kernel.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:56=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
> administratively set MAC") fixed an issue where untrusted VF was
> allowed to remove its own MAC address although this was assigned
> administratively from PF. Unfortunately the introduced check
> is wrong because it causes that MAC filters for other MAC addresses
> including multi-cast ones are not removed.
>
> <snip>
>         if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
>             i40e_can_vf_change_mac(vf))
>                 was_unimac_deleted =3D true;
>         else
>                 continue;
>
>         if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
>         ...
> </snip>
>
> The else path with `continue` effectively skips any MAC filter
> removal except one for primary MAC addr when VF is allowed to do so.
> Fix the check condition so the `continue` is only done for primary
> MAC address.
>
> Fixes: 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove administr=
atively set MAC")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index b34c71770887..10267a300770 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3143,11 +3143,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_v=
f *vf, u8 *msg)
>                 /* Allow to delete VF primary MAC only if it was not set
>                  * administratively by PF or if VF is trusted.
>                  */
> -               if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
> -                   i40e_can_vf_change_mac(vf))
> -                       was_unimac_deleted =3D true;
> -               else
> -                       continue;
> +               if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
> +                       if (i40e_can_vf_change_mac(vf))
> +                               was_unimac_deleted =3D true;
> +                       else
> +                               continue;
> +               }
>
>                 if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
>                         ret =3D -EINVAL;
> --
> 2.43.0

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


