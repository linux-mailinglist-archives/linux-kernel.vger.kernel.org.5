Return-Path: <linux-kernel+bounces-78138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4152F860F64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D011C22165
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7076C83;
	Fri, 23 Feb 2024 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyQDy89I"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EF76029;
	Fri, 23 Feb 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684340; cv=none; b=ZSUPMZ93Zaj51vJ+C3Ll8FAi4ZH04q6rHgqXuSYz3YFH3OPLDjTrJO6CGfyY6iSEGoRqnqlgP4ppn5EN9gYIPWIX9ecYFLNZJ0IjgCUhuVsCDTQuR362NMonwCybA4pnO3cg8wHHjdV6KUh8O4NRTRmFgteRbG9ywYcip+mXANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684340; c=relaxed/simple;
	bh=qEI1IPPY45I44MWrA2eQdelfQfewfwy4o3CwSMwNZRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TaeHzy84I0A9rGHAchIvd9l3/W1Nh+SpmNXQksR+qZyysndoG+BWfhD4ndNqgzlbMq1ZmWkLXrT+mDNHsq26PN+tJ1cXTMUKLJRIFfTYg3YCSRG1uImuT2kw1rgMu2pCTk35RvX2xrkylEZ1zRc6HeWFL+F7aM8cAqjyrhi7PbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyQDy89I; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e72ec566aso86798966b.2;
        Fri, 23 Feb 2024 02:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708684337; x=1709289137; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEI1IPPY45I44MWrA2eQdelfQfewfwy4o3CwSMwNZRc=;
        b=XyQDy89Ix2n+1Y7qHm1NeOtdzDQZhQ3Sd4ooY7qe5HozhYYnEcsfrplGDC+XG1dtuc
         scgxWGf10DKsB1seUQ2yAvMJwLxWFqGKOlx1JY9BVrmfjTiEFoelrLu+VEz1XXC61aEb
         928jm6ba/BwHYL4N3bG8crBRRn1r8P8CH2gBPAszCef96xPRg0l+i0F8s0uHceDteo43
         fy4E78CrxM0QaUbhcbvbMz0qI3Bhq5Ix/UbGWscy7lSsdPOqqMlDLHxgZedQlOvhx+Jp
         OsuMOZD9eHBMdnfuWENPcoBrKw3BIYDHhNADdlMyuhwl/Tg+nYhAzqah0v6MP+wY/zpJ
         e4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684337; x=1709289137;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEI1IPPY45I44MWrA2eQdelfQfewfwy4o3CwSMwNZRc=;
        b=YB/tjyDRqkXrtMwRM5fT77aFB63C74euNg/0Fu4UqAfJlCBHwNFvFqL7swuDEb1AUX
         UZo+Vx/13SSXcUpTHfVIfl7dbomd0VskW+9P2XsHkXjVwuqKAkmSoFL3yarFmIuyyXV2
         1R8E/8HKh+tng9BN3yBbnfPh6g8Ac/6HyiBGLtdr/LKHkKLmfnhk30k9YyRbDT2bTjDl
         6dFNg0Qu41s5qY9AVqpF7FRWmp3i2qkJA8jseplLKG2IoZXr7dfpJwWqImHip7YKtzRU
         JK4BI87J77KFDhjf4Md6F2Cnl8sqsXiOvMBOYc6n4/QEuWg5taNC9f1Op4ZIqLIsQLqC
         mh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVucJjKG5F5cLR+yxzRTh1f6LkSx8FJXuURrcU0SNSaGMybWKcIk355nlKAuSgw1ciKNECM2tDrjF5K7o5KVA5/KH6aD1lqtH36lp/MqSPry+qwJteE2i67ZIpg4GRtw9MSQ40blersNg==
X-Gm-Message-State: AOJu0YzVHBklDrBrtgpIOD78/kJy27ZpQ5RR21Dd9HKhi4zUHxpYTiq3
	oqj+YenlEGjxHalOxirIfpJV4nW4waC2uEHGJ4jIHenFDkBCS9TH
X-Google-Smtp-Source: AGHT+IHxdZXGV8Be6XpyrCYxPJM4LoRjOCsKLfrTE03uuhRSifhKWE7vbJfQRvpqoydjAQJMNW4irA==
X-Received: by 2002:a17:906:7192:b0:a3e:a951:4087 with SMTP id h18-20020a170906719200b00a3ea9514087mr937414ejk.76.1708684336474;
        Fri, 23 Feb 2024 02:32:16 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906145200b00a3d2d81daafsm6909238ejc.172.2024.02.23.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:32:16 -0800 (PST)
Message-ID: <23ccb927c4a8b9f86cf7832fb1d2b0326fbae3a1.camel@gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Saravana Kannan
	 <saravanak@google.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Android Kernel Team <kernel-team@android.com>
Date: Fri, 23 Feb 2024 11:35:37 +0100
In-Reply-To: <20240223104550.234ecdcb@bootlin.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	 <20231130174126.688486-3-herve.codina@bootlin.com>
	 <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
	 <20240223104550.234ecdcb@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 10:45 +0100, Herve Codina wrote:
> Hi Saravana, Nuno,=20
>=20
> On Tue, 20 Feb 2024 16:37:05 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>=20
> ...
> > > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait for any ongoing de=
vice link removals before removing some
> > > of
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nodes
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_link_wait_removal();
> > > +=C2=A0=20
> >=20
> > Nuno in his patch[1] had this "wait" happen inside
> > __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> > the issue that Luca reported[2] in this patch series. Is there any
> > problem with doing that?
>=20
> Is it the right place to wait ?
>=20
> __of_changeset_entry_destroy() can do some of_node_put() and I am not sur=
e
> that of_node_put() can call device_put() when the of_node refcount reachs
> zero.
>=20

I don't think of_node_put() can call device_put(). At least by looking at:

https://elixir.bootlin.com/linux/v6.8-rc5/source/drivers/of/dynamic.c#L326

> If of_node_put() cannot call device_put(), I think we can wait in the
> of_changeset_destroy(). I.e. the __of_changeset_entry_destroy() caller.
> =C2=A0 https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/dynami=
c.c#L670
>=20
> What do you think about this ?
> Does it make sense ?

I think it makes sense from a logical point of view. Like, let's flush the =
queue
right before checking our assumptions...

In my tests, I did not saw any issue (Hopefully I was not missing any subtl=
ety).

- Nuno S=C3=A1


