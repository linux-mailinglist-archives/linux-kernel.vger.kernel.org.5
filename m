Return-Path: <linux-kernel+bounces-150178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4571A8A9B60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4866B2434B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BA1161916;
	Thu, 18 Apr 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFJfSqvy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E97E56C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447258; cv=none; b=fU6RRGAxczeDJacpm52t2gxnE+w1+WJjxrwx4IDwtGr7AG4q42Rpuu6Plf4HbBcvzxdmyh0gHdUsmCE5sMLoxb/wDsfv9xRTyGT6O+e0uOOS8vONxoWyLfWXFt1ubInyRbiFkpSWi8ZhZHnIXJZveA1/HihTkHJFTsqq3Czr6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447258; c=relaxed/simple;
	bh=0p7Z9PhLHCGbAVcNHG7nPsb7+sUp2srneXXeChzNaCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uANiQXR2I8RTFTbgGQZEreYCK3h5MTo1GwbQfxZm7a8UxzNnmmcWSPnI/5EYnboM7MM4IZbfS6X0i0P5zsoyFi7UocyBecYiKXcMDGKiBBXiwRhHSdeXDMxsO2b8pu5SxJ3va0pr3dXYwOb7/zss9EEdgLKBYT5JkE6yuDsjtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFJfSqvy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713447252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NrgGLfIAAX/pWHt0D9O5DBKVoy6SoLpfNZ14lOkcm7Q=;
	b=PFJfSqvyoprsfoIsnAjEK+G+KYX15O2stGHY3sbyb8L6Ukru2hvyDkey5NH63daaljy7yK
	HldpVej/e+1l30r9UP4i+hPD8v2Lj0z7iKiQlREYD4Wzca+22DOFtVIyAK3iK00UsZwgoh
	VZXq152Wn55UsoHKQYjrvRv9RxEQjSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-e4yOYNWFPrKuN6sGEDSmPw-1; Thu, 18 Apr 2024 09:34:11 -0400
X-MC-Unique: e4yOYNWFPrKuN6sGEDSmPw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416640b7139so1116425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447249; x=1714052049;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrgGLfIAAX/pWHt0D9O5DBKVoy6SoLpfNZ14lOkcm7Q=;
        b=uYb6UCFYs4/8Dz2bikbOjKibvwtlce534SxoQnd9ihiHtnFpeX1rtNf3fy81ACbyAf
         Q4fd4ERZyaYlbtQhDoV6K2CWk4drOa/zWcDjzbWBTeEVpDiCdL1KPD2zoDgeVDeYp6hX
         20MmR5xvIsU7itgbfu3VMUdCMq3rsvrgPWuEYZj5yVmoq4DqglCupYLFWRQtGr7ad1Ab
         Do7mPFuOxqjyBWPTE9OcXv3RE9dZPbJ8OJaDK5FX3CEvx3Q6NfBc4ZTyusUE9jXak3TT
         JHXcavihPbh1+Fag863KIpO9f+KSXHEYZlbjN+ydfjKQtVwCha1DshwuLJBonSOJP0IR
         N3lw==
X-Forwarded-Encrypted: i=1; AJvYcCUHMz1Ia3AlSlffm9SnXhnXRh2PZ0uPdy3yNURrU1SFDdOMr1FG3kWPm5mgUvvo8OLDIa1ZCapQGPIkSRVm9bjsZ+w2jXnLbJytYqYd
X-Gm-Message-State: AOJu0YzkLSMUfb4zVTxGA2v/LISVukxrvasFHW3ojGp3IV4IlY5flkt3
	Hp2eL10woEjcLzxOuwACah1jZ+CHjwJGkWsj4i6JlDKeqDVgGdaYD6QgPmrHS5vDA9IFi2683Jt
	Ewvr1U8u7r1x59jSsMRcefgt6HNEJbf70rdwEgDahBROHicEbY1xehSDEntYbzQ==
X-Received: by 2002:adf:f70d:0:b0:343:39d8:bf3a with SMTP id r13-20020adff70d000000b0034339d8bf3amr1847103wrp.4.1713447249296;
        Thu, 18 Apr 2024 06:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAkUsJsRqDf+ajVDzMwmUTX1P0NXRRRaDGkQ8TCIdYz/pnVcp2EurcEBdMy8mIL3vw/5Lc/A==
X-Received: by 2002:adf:f70d:0:b0:343:39d8:bf3a with SMTP id r13-20020adff70d000000b0034339d8bf3amr1847076wrp.4.1713447248905;
        Thu, 18 Apr 2024 06:34:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id m10-20020a5d4a0a000000b0033e45930f35sm1870497wrq.6.2024.04.18.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:34:08 -0700 (PDT)
Message-ID: <0891a0eeea4d771fd8c9760bfc1fcedf4b2d56db.camel@redhat.com>
Subject: Re: [PATCH 1/2] [v2] net: ethernet: ti-cpsw: fix linking built-in
 code to modules
From: Paolo Abeni <pabeni@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger
 Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>, Tanmay
 Patil <t-patil@ti.com>, Simon Horman <horms@kernel.org>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Grygorii Strashko <grygorii.strashko@ti.com>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, bpf@vger.kernel.org
Date: Thu, 18 Apr 2024 15:34:06 +0200
In-Reply-To: <20240417084400.3034104-1-arnd@kernel.org>
References: <20240417084400.3034104-1-arnd@kernel.org>
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

On Wed, 2024-04-17 at 10:43 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There are six variants of the cpsw driver, sharing various parts of
> the code: davinci-emac, cpsw, cpsw-switchdev, netcp, netcp_ethss and
> am65-cpsw-nuss.
>=20
> I noticed that this means some files can be linked into more than
> one loadable module, or even part of vmlinux but also linked into
> a loadable module, both of which mess up assumptions of the build
> system.
>=20
> Change this back to having separate modules for each portion that
> can be linked standalone, exporting symbols as needed:
>=20
>  - ti-cpsw-common.ko now contains both cpsw-common.o and
>    davinci_cpdma.o as they are always used together
>=20
>  - ti-cpsw-priv.ko contains cpsw_priv.o, cpsw_sl.o and cpsw_ethtool.o,
>    which are the core of the cpsw and cpsw-new drivers.
>=20
>  - ti-cpsw-sl.ko contains the cpsw-sl.o object and is used on
>    ti-am65-cpsw-nuss.ko in addition to the two other cpsw variants.
>=20
>  - ti-cpsw-ale.o is the one standalone module that is used by all
>    except davinci_emac.
>=20
> Each of these will be built-in if any of its users are built-in,
> otherwise it's a loadable module if there is at least one module
> using it. I did not bring back the separate Kconfig symbols for
> this, but just handle it using Makefile logic.
>=20
> Note: ideally this is something that Kbuild complains about, but
> usually we just notice when something using THIS_MODULS misbehaves
> in a way that a user notices.
>=20
> Fixes: 99f6297182729 ("net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA con=
fig option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebase on top of v6.9-rc

Does not apply cleanly to net (nor to net-next FWIW).

You should rebase on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ main

Also, please don't send patches targeting the net and net-next trees in
the same series. If the net-next patch depends on the net one, you have
to wait until the first is applied and the 'net' tree is merged back
into the 'net-next' tree before submitting the latter (usually after
the next thu).

Thanks,

Paolo


