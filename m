Return-Path: <linux-kernel+bounces-136817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FEE89D89E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655B81F241E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7612A144;
	Tue,  9 Apr 2024 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfDD2nLd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57585636
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663947; cv=none; b=l2KGgrC4mHY0FE+EApWh1AfnJyozITP6XdhQYqaCr9sgq8xtd7C+6vx2KTCmacBLSq+NanIzXfL5M0eYJXuIh4t6RB5KIcHnWUwf8o3lL5ABa5QXd3I6+JZrszyskhzV76PyjdEWqI+dIMz/dXXHOh0n6vAyGkP/lELRO7hafM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663947; c=relaxed/simple;
	bh=xJmkWDFZRpfiovpWUIpX2q0pD8EQi7uOSkrwm+axFQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XfD48jyo3Fh6KFqBmmHIsBXDl8mljQvjj13NEx+STGkirGAUDgM8jMV9WYpLRITjIHHvsMsvm3vl0qONIH4aKDaEFjrCnS6vq1r2roO7cslHzLC2vv9L9040s/uEVBCbPL5m6XzarEQab2jVP+ja5q1Ad0AOwFcie/g6FT5npO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfDD2nLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712663944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AVnEvaxqsd9dCkI2giCqtV+/ipEyruMB7htKp3/+osk=;
	b=AfDD2nLdqZZ4UZcAkYnHi5zqGlKm2Rob4Y18ksQZ4nGw+xsN4qesMKrDEFeZs2ksZz+tAf
	qoyirrukGWY9mAV97AoR7DFZD0vzaYD1LWJ78mFWHN0Rm9nu/v8EUJuUpdjeU9H5oJH4NQ
	5r8fFYtgkNdY2NGPmKvlagpQcbJ1So8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-qrlLiDh3OW-bWuAANOeOCw-1; Tue, 09 Apr 2024 07:59:03 -0400
X-MC-Unique: qrlLiDh3OW-bWuAANOeOCw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6993921ae18so7017636d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712663942; x=1713268742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVnEvaxqsd9dCkI2giCqtV+/ipEyruMB7htKp3/+osk=;
        b=bYin8DN5hmWEJDhM4k2ApUVb0O3WnkCfRsjal7rnHnDo9n5kLMKaW7QezarNtxJWbh
         t+hGb02KOtWRQK4n8zR1IAkyx2XLMLpU13ck8DBPxLzFAXtVSCU5g9ETyhwVvKBY8V9q
         LwMV3DAjczeygiaH/xP9wE4g9vFjiFtSFY2tNBF4YBUDUDtDKw63lxLbHQax9AIjfSKy
         z6zuZOC1f/KumNadZBs+lklNqMhfBHd6shZEHtitxlQExU2Ml3I4fb2aob5r0F6p1NSs
         8sXUZwTxjH9JfeiDnd86IMLHgUm9n4TP3BdDFXKpC+OQ48W1V71KXz6Qv234sRdO242f
         k1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNPIGZBDkp00lftqgM3CjLgrLv4pFBZh1FiVU2euZDRltPYH5yLNzCKTSqs+bvruO3uDSBtBlE4tyKn/WHO55tdNRhJbd5i2FSYrf2
X-Gm-Message-State: AOJu0Yzhy8P/iXQQ5bpD1VarNc6e0gIoOz9lYJlmw/EdJYCGha/gSzt9
	+Q0SchDHwa7s1ZqwR8F2KZg/KCODtBVFjqoPhuWEMfK7ONnryZUiqAal8FObuGZrbQQjzI8VjhD
	3sE3xn55vL4CvoW1Maxoyiw8+cIc/1f2NtIj+H5FuRqWj/2E3ylRQF0lbhP2NPQ==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr12560481qvb.4.1712663942485;
        Tue, 09 Apr 2024 04:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKcKqg6OiKy05WliAywffygt+wTBvOwmYCPaEUR8+Z7dbH4Z0DauesnEKqhKw8Fu2D+h1LNg==
X-Received: by 2002:a05:6214:2408:b0:699:2d88:744f with SMTP id fv8-20020a056214240800b006992d88744fmr12560454qvb.4.1712663942159;
        Tue, 09 Apr 2024 04:59:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-144.dyn.eolo.it. [146.241.244.144])
        by smtp.gmail.com with ESMTPSA id a8-20020ad441c8000000b0069b1f86f754sm1411709qvq.28.2024.04.09.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:59:01 -0700 (PDT)
Message-ID: <1f2bc5416a0a73756cc1f45f3300619eb201b0a4.camel@redhat.com>
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix enabling EEE on MT7531
 switch on all boards
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
 linux-mediatek@lists.infradead.org,  Florian Fainelli
 <florian.fainelli@broadcom.com>
Date: Tue, 09 Apr 2024 13:58:56 +0200
In-Reply-To: <20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
References: 
	<20240408-for-net-mt7530-fix-eee-for-mt7531-mt7988-v3-1-84fdef1f008b@arinc9.com>
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

On Mon, 2024-04-08 at 10:08 +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Relay w=
rote:
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>=20
> The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features"=
)
> brought EEE support but did not enable EEE on MT7531  MACs. EEE is
> enabled on MT7531 switch MACs by pulling the LAN2LED0 pin low on the boar=
d
> (bootstrapping), unsetting the EEE_DIS bit on the trap register, or setti=
ng
> the internal EEE switch bit on the CORE_PLL_GROUP4 register. Thanks to
> SkyLake Huang (=E9=BB=83=E5=95=9F=E6=BE=A4) from MediaTek for providing i=
nformation on the
> internal EEE switch bit.
>=20
> There are existing boards that were not designed to pull the pin low.
> Because of that, the EEE status currently depends on the board design.
>=20
> The EEE_DIS bit on the trap pertains to the LAN2LED0 pin which is usually
> used to control an LED. Once the bit is unset, the pin will be low. That
> will make the active low LED turn on. The pin is controlled by the switch
> PHY. It seems that the PHY controls the pin in the way that it inverts th=
e
> pin state. That means depending on the wiring of the LED connected to
> LAN2LED0 on the board, the LED may be on without an active link.
>=20
> To not cause this unwanted behaviour whilst enabling EEE on all boards, s=
et
> the internal EEE switch bit on the CORE_PLL_GROUP4 register.
>=20
> My testing on MT7531 shows a certain amount of traffic loss when EEE is
> enabled. That said, I haven't come across a board that enables EEE. So
> enable EEE on the switch MACs but disable EEE advertisement on the switch
> PHYs. This way, we don't change the behaviour of the majority of the boar=
ds
> that have this switch. The mediatek-ge PHY driver already disables EEE
> advertisement on the switch PHYs but my testing shows that it is somehow
> enabled afterwards. Disabling EEE advertisement before the PHY driver
> initialises keeps it off.
>=20
> With this change, EEE can now be enabled using ethtool.
>=20
> Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
> Here's some information for the record. EEE could not be enabled on MT753=
1
> on most boards using ethtool before this. On MT7988 SoC switch, EEE is
> disabled by default but can be turned on normally using ethtool. EEE is
> enabled by default on MT7530 and there's no need to make changes on the D=
SA
> subdriver for it.
> ---
> Changes in v3:
> - Remove patch 2, it was revealed that it doesn't fix a bug.
> - Patch 1
>   - Use the internal EEE switch bit provided by SkyLake Huang (=E9=BB=83=
=E5=95=9F=E6=BE=A4). It
>     is a better method compared to unsetting the EEE_DIS bit of the trap =
as
>     the latter method causes unwanted behaviour on the LED connected to t=
he
>     pin that pertains to the EEE_DIS bit.

Since this leverages something relatively obscure, it would be great if
someone in the CC list could independently test it. Let's wait a bit
more.

Cheers,

Paolo


