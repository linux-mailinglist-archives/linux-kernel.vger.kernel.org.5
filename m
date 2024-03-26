Return-Path: <linux-kernel+bounces-118610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F5988BD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7832BB240AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131E67A01;
	Tue, 26 Mar 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyLAXvgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACF62802
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443789; cv=none; b=idN6cXsb4+kvb3e+VMXxyfa1AbthpKfD6AvZ/UIvm0ClFtYiHTZlC7zP/on1ViqSKKa2J/tgmP2duH3uah3i2gdd/5Bq1KFtwOudjHkVwWKd0753L0M4StkfaH4RBehPDiyshxUOOQA1Yf7Hdin978sKdKhkj6kYdpXvZVR06aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443789; c=relaxed/simple;
	bh=NqGFRjWR0QURm2aye+7abkeZFK6Er7JYJSWYgUQlFGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6cm8YOWarLoz9mHhj7trz2xRGOjlyhLXdG2CRr5fYTMAPcXfqTyR3NfF8Q9zb4wspuIYj9jpiyiwRDO6vXJ6vPOQrJGlO6EZT4d4W180pnEyS88tNlG4XIEb24MMF8ISU7sAWQI1H68FBknt87k9SwEXf32j/Z9W28M5bYm0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyLAXvgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711443786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NqGFRjWR0QURm2aye+7abkeZFK6Er7JYJSWYgUQlFGU=;
	b=MyLAXvgwgbp9ne7TZGw6JR13vdezgLmtkdOOm+3HkdH18p9LwsBXo6F40df68jpqmoQB/C
	LHXMNi9/skqSxFHVywWFfS7cFpKE+UEi57hL0sznQNTP5VJi7Dnb0UwgN7zbHIPQBaK7Mt
	7FzWx9NYgB2rFBZ27rPLTNJTb7iCJf0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-9gJx31dvOpWaBZxxpK24Fw-1; Tue, 26 Mar 2024 05:02:58 -0400
X-MC-Unique: 9gJx31dvOpWaBZxxpK24Fw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4147e735180so8456105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443777; x=1712048577;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqGFRjWR0QURm2aye+7abkeZFK6Er7JYJSWYgUQlFGU=;
        b=rXuXVPwTDFyoCSIeUrWRswdiNXcepi1xFru3pHUYAQX42likbH7nZQbrZomGzNx4WN
         w1TeO1zjyM5gumJVXpfP3sTpp15Gh3LlOSVUMKyCsyCWkG9ulPYoczNpHkf+jxUFsDyW
         GjjnLmz1jIn5jK116JbaO3VTb48xftDnReHNoCo5A3JB0DCskXXLA/oyfCjvKe7wOZeF
         hIp7mzlSrwiSjq/sh8X+5X7zKtUuEoCnKDgGKU0GUVuICft+xqMBHkE4c5zUuWrK6i5C
         n0omlKFhy5aZaQ3reFFAsExiucSoB7inHhWeBI8v0kjajLmwqFzWB3AqeatugOFHb4jm
         hGCg==
X-Forwarded-Encrypted: i=1; AJvYcCV/csBrDW85LMp4hwRMrh+2qQWOX4GssXofSRL2sVJL3lB/uEW0kVAbzTDSyeKvy/RbNHnhQMWLFoq5uLQQa3Snr/cfS62NavySmYYP
X-Gm-Message-State: AOJu0Yz+Lt0PRvY1yUpK3HRQ17llmLQ3ZVT+YgOHwSrzFK9BKm+PrFYH
	qtpbHFOkQagUsgHpkA94f52lSIE9dY3TqDrcj0ChsfRq4GjMhlAaeDGfXHw5O5sXSUDHoSUG9M1
	2RSeHDua2BRudXBWurcz/MJ25O3a8VwAGxvK912Z6n9HJLnRDS5n4OGY5EXHK8w==
X-Received: by 2002:a05:600c:1ca9:b0:414:8032:72e4 with SMTP id k41-20020a05600c1ca900b00414803272e4mr6953188wms.4.1711443777380;
        Tue, 26 Mar 2024 02:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5kYu/lKbTy+ljHRULd1J1Vm3guqKNgel59V6fCBvRom3sy3zu18H2PmJMjpuSGKjpQM2y0A==
X-Received: by 2002:a05:600c:1ca9:b0:414:8032:72e4 with SMTP id k41-20020a05600c1ca900b00414803272e4mr6953155wms.4.1711443776947;
        Tue, 26 Mar 2024 02:02:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b00414903d20aesm474225wmq.11.2024.03.26.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:02:56 -0700 (PDT)
Message-ID: <799572b672ea8b4756236b14068aef7c8fa726a6.camel@redhat.com>
Subject: Re: [PATCH net v2 2/2] net: dsa: mt7530: fix disabling EEE on
 failure on MT7531 and MT7988
From: Paolo Abeni <pabeni@redhat.com>
To: arinc.unal@arinc9.com, Daniel Golle <daniel@makrotopia.org>, DENG
 Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, =?ISO-8859-1?Q?Ren=E9?= van
 Dorst <opensource@vdorst.com>, Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com,  erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Tue, 26 Mar 2024 10:02:54 +0100
In-Reply-To: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
References: 
	<20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
	 <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-2-9af9d5041bfe@arinc9.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-21 at 19:29 +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Relay w=
rote:
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>=20
> The MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 bits let the
> PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits determine the 1G/100 EEE
> abilities of the MAC. If MT7531_FORCE_EEE1G and MT7531_FORCE_EEE100 are
> unset, the abilities are left to be determined by PHY auto polling.
>=20
> The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features"=
)
> made it so that the PMCR_FORCE_EEE1G and PMCR_FORCE_EEE100 bits are set o=
n
> mt753x_phylink_mac_link_up(). But it did not set the MT7531_FORCE_EEE1G a=
nd
> MT7531_FORCE_EEE100 bits. Because of this, EEE will be enabled on the
> switch MACs by polling the PHY, regardless of the result of phy_init_eee(=
).
>=20
> Define these bits and add them to MT7531_FORCE_MODE which is being used b=
y
> the subdriver. With this, EEE will be prevented from being enabled on the
> switch MACs when phy_init_eee() fails.
>=20
> Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

If I read the past discussion correctly, this is a potential issue
found by code inspection and never producing problem in practice, am I
correct?

If so I think it will deserve a 3rd party tested-by tag or similar to
go in.

If nobody could provide such feedback in a little time, I suggest to
drop this patch and apply only 1/2.

Cheers,

Paolo


