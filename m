Return-Path: <linux-kernel+bounces-109853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB30885687
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2E7282B91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786054F9D;
	Thu, 21 Mar 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKAk1Jgr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118A4C629
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013408; cv=none; b=AbKCOcIr02Q21RpQft8rktGzvMoxBduFrup3HeNhaHEk3CAt7GDe5Nv5rACuJefuWxz27pPMdNvr9HJCJhoRWtj9eswHMfT5oMSdLPTPB5s2MGJ5y4fRThah8JTtUy1X0Ht4j0d+MJR9sKsfE+AmPGBmVV7IFf1K0rXIemA+Jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013408; c=relaxed/simple;
	bh=japXyDrgoxK2sEHIfmb7U37Fp1/eWTziAQmL49rcESs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fem1AeNvcXYyea6rJCyZg6zN70NmS87GZ1B6Frr7uhAviWyOpRHQ3O+SAoBb3lTQFkAM1hH3IHpPSiU1NMOSd1WllcsWYtkYEmwLQrGCKSS0ZTVO4SFufVPHOZ/U+Jmp0vFzkDmXHq+qKzyoYKQhvTtiSxcic2sJT1s+RV1oT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKAk1Jgr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711013405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gEOWOzX6IKoL6c6ii5LxOxTGEF/+O/+tJriUbFX64KY=;
	b=HKAk1Jgr8Ryzsx5kWCh845SLNYe/TneOrmax3oggnhXcLmpErHlBvHUj5cJhMFqJz5vLp8
	eCMukx3PxXLk3fW/gaUN7wbhJk1kk3K0HYlk0lF5Sd/62CTb16IsP3dkrWKewfWdy+EpRw
	LbVWEaPKPYCMJfNSa8QZCgW/nIYjfMs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-bWi-yNm-PIahPXf3s_E-bw-1; Thu, 21 Mar 2024 05:30:02 -0400
X-MC-Unique: bWi-yNm-PIahPXf3s_E-bw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso151341f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711013401; x=1711618201;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEOWOzX6IKoL6c6ii5LxOxTGEF/+O/+tJriUbFX64KY=;
        b=n5H5pulKqVaiySZZO8S0J7f3gszqT+ACoWuOVIAg4+oiWE5U9dgPQaTYWaOdGnpAte
         aOuAyfMQjWdt33ZFSiQ5AJUiMXiEux5Uuw38OkXf66aLbmJZOP9fqsNtvBirb9hD0jee
         Po/my/uhtCN2sdTuFlXTWH/57IAeSSvUk6c3a7/CiyWhNzFK3am4Yt78JRoPLFFRelFw
         dpt7koYDyWaJyVtMG42jFOnzVRCloU4m2ANhDhLVmaazsCkK2QdIOtbnHH7j3U3SorE+
         l/AWjvrU87Dv94cBZBRepB7df2eExl6+c2PW0BLv0QSzuzrxeztiCo1WE1Nj4AZdb43+
         GT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/PT0Nm3mxB7fVF8H7unlca/CdmXCWHH9cgsLDB/Pv3Ow+JEYpaKjBZNdgSVNgQZw6ECHOgFo8cxziGJLyqoPaZ5m8eg9YXVfDlMJ5
X-Gm-Message-State: AOJu0YyUMJ7tFp+Vuwc+U8EG1J3Pz9+TxAX9fFrY8ZgRKWKT1tcnA8cy
	2ZH0QYC/TKF4DpEPxx+VOeKHEqnkxSWSp/s2rzltae8BbW+dKys4E4smUVcCpwVPGmJ5gdVLMeO
	h0HynqAJZINZutqaCoBmkfMjN9P1trhbwYJ5Cu8JGaC32BQfdOw7Q7dge0L/Wzw==
X-Received: by 2002:a5d:420d:0:b0:33e:cf64:3cae with SMTP id n13-20020a5d420d000000b0033ecf643caemr2795186wrq.6.1711013401714;
        Thu, 21 Mar 2024 02:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZKL38fQ0kBB0YPNBOPou+NBPXAESCQCgqsVcrPya+gVQ9qcjAyLxm+5+FxxlReXioFo/UjA==
X-Received: by 2002:a5d:420d:0:b0:33e:cf64:3cae with SMTP id n13-20020a5d420d000000b0033ecf643caemr2795161wrq.6.1711013401310;
        Thu, 21 Mar 2024 02:30:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-130.dyn.eolo.it. [146.241.249.130])
        by smtp.gmail.com with ESMTPSA id i18-20020adffc12000000b0033e786abf84sm16745438wrr.54.2024.03.21.02.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:30:00 -0700 (PDT)
Message-ID: <9762d71f1b3858c6b362696277702409e885fa1d.camel@redhat.com>
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, Daniel
 Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, Bartel Eerdekens
 <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Thu, 21 Mar 2024 10:29:59 +0100
In-Reply-To: <f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
References: 
	<20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
	 <f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
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

On Wed, 2024-03-20 at 19:41 +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 14.03.2024 12:33, Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Relay wrote:
> > Hi.
> >=20
> > This patch series fixes the VLAN tag egress procedure for link-local
> > frames, and fixes handling of all link-local frames.
> >=20
> > Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > ---
> > Changes in v2:
> > - Add Fixes: tag to both patches.
> > - Link to v1: https://lore.kernel.org/r/20240311-b4-for-net-mt7530-fix-=
link-local-vlan-v1-0-d67e6cc31af2@arinc9.com
> >=20
> > ---
> > Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
> >        net: dsa: mt7530: fix link-local frames that ingress vlan filter=
ing ports
> >        net: dsa: mt7530: fix handling of all link-local frames
> >=20
> >   drivers/net/dsa/mt7530.c | 52 +++++++++++++++++++++++++++++++++++++++=
+--------
> >   drivers/net/dsa/mt7530.h | 22 +++++++++++++++++++-
> >   2 files changed, 65 insertions(+), 9 deletions(-)
> > ---
> > base-commit: d7d75124965aee23e5e4421d78376545cf070b0a
> > change-id: 20240208-b4-for-net-mt7530-fix-link-local-vlan-af6e9928ad8d
> >=20
> > Best regards,
>=20
> Reminder this patch series is waiting to be applied.

I hoped to get some feedback from the DSA crew, so it waited a bit in
patchwork. Anyway it looks like it staged long enough and I'll go
through it soon.

Cheers,

Paolo


