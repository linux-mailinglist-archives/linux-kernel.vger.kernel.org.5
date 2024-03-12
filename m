Return-Path: <linux-kernel+bounces-100138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B98879262
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D40B283D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4072778683;
	Tue, 12 Mar 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jo34XOAc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814A35F18
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240376; cv=none; b=ivXr8eywwyw2bhsK7sFFDbOkGudAawv55hQDZBhvXSE+utmXoNvseCZLafVMk6VdhCVcUGJ1MfVoRsz0PKqJWJxSuJlDcgAsDtHHQgY/ZvyHgop8dtA9Uzh9TfV3EkBz774v+16/nhJEcJZVX4E0AI54kwo6iMNFvSveIn4yQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240376; c=relaxed/simple;
	bh=Xpwrgr9GW2J+jNUYlxLZzGIj0Dl2XuTEJLp84Og9yjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLrIkvmEk69SXEB8wSFQRVY1Mm9MGopWzpFg8qGojOME41gL8LN5tPH4IzExOg5Cx5ifTis1mQ/OQTvCzw9yzCkzFR9zSQk/0K9zBXHtOi15LToLeQKMBgt/k8qbI/ZewWMEUkWE5hmsY/OTZ9/Q+X7vejEvlmrrRo5kqr5QgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jo34XOAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710240373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k3PfTUxQRHcPOy8oisyz3vH+D0b3vJFd+pPa6e4uHoo=;
	b=Jo34XOAc2ldN3+3Sgnf8ICzH1gPDcyUtNl0obviqOS3jEaLM2XCo2BVxOpR8WTHiHksXT6
	cCqDn7kO6SJYckE/OwYCLitEcjcVdxXH5PPiGEPHH2ECFktJzLk49K/wYjo114lQtMnttW
	ZKdkoq6M9gU/E4JVU2nA8uJGe5Bthtw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-mH1vL_uePmmWtgWtB3zX_Q-1; Tue, 12 Mar 2024 06:46:12 -0400
X-MC-Unique: mH1vL_uePmmWtgWtB3zX_Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-567eb0397e3so1576054a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710240371; x=1710845171;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3PfTUxQRHcPOy8oisyz3vH+D0b3vJFd+pPa6e4uHoo=;
        b=czlzXxBe3fkEV64bRkBTl6sdFLVZkEJmQWWLdQAHNntaYKo2ZC/Ocj1f1qbKA+nk/j
         dvd662+Env5+iLytl6xlMNbIbQWByHLSNKouQnrZbza25rw83l6zJbQ9w3DBI3WbvflI
         9Y7+4LeTFt+EeL+sz97MIpMmV5b8zUcdo5kVUByzphWCTyN16GjZImqjlQDV8YZBolh2
         wGJlek72NmRHIQf2GIEcu2bbylPi99mZ/NG9/J1mj6JSbLMsCQ79HRFTnG2pmJxa+M/v
         gw0cF58atzOaK2VT0pqgKoZwBZwYOyozoGrHIbxRMbRO2u2RHj2k5Z/OXzeCFTX9TtDt
         SAog==
X-Forwarded-Encrypted: i=1; AJvYcCURSJ2Rv/vTr9SzKyIftT2O8B5t20vVGeZj2K2PQpC1+cmTgf3dqYsSvqxjPBnMMcMPoI0y9rooVynHO+Oi0tpaZEkhYAQ/L0EaFhpZ
X-Gm-Message-State: AOJu0Yy3fpvtqGLxiey9lkWDEDS7kxfA5rFliTj/wYUDxRt8MTPwfkWz
	GSQtuzS6kmceij6rsXp9aMfQAVQ1mCljWbXsM7Y/oLhLvWk121IBdbYP+Mk4VL5UJiU3IKdrF44
	UHH4aDyrqclCqcYrhI+Z/HyMQONUtUGHx05QZavBtG9tEwBdXavsez7NtJdQK5g==
X-Received: by 2002:a05:6402:528c:b0:568:64a7:cd6e with SMTP id en12-20020a056402528c00b0056864a7cd6emr2916500edb.1.1710240371090;
        Tue, 12 Mar 2024 03:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzxpusWqRQdRwYLsojBIQEpvtx6NteLZ6W1tH+3hI9/xyqXjVO3ZsnArBGhpF9KyNlrzcIVg==
X-Received: by 2002:a05:6402:528c:b0:568:64a7:cd6e with SMTP id en12-20020a056402528c00b0056864a7cd6emr2916488edb.1.1710240370691;
        Tue, 12 Mar 2024 03:46:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402400200b00568781ebac8sm349583eda.11.2024.03.12.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:46:10 -0700 (PDT)
Message-ID: <4fb0b96fe4049578718befc41f2121ce18c30fbe.camel@redhat.com>
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
	patchwork-bot+netdevbpf@kernel.org, Justin Swartz
	 <justin.swartz@risingedge.co.za>
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com, 
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 matthias.bgg@gmail.com,  angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-mediatek@lists.infradead.org
Date: Tue, 12 Mar 2024 11:46:08 +0100
In-Reply-To: <7780460c-abc3-4009-9f95-28d123a9a23d@arinc9.com>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
	 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
	 <7780460c-abc3-4009-9f95-28d123a9a23d@arinc9.com>
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

On Tue, 2024-03-12 at 11:38 +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 12.03.2024 00:10, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> >=20
> > This patch was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >=20
> > On Tue,  5 Mar 2024 06:39:51 +0200 you wrote:
> > > Disable LEDs just before resetting the MT7530 to avoid
> > > situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
> > > states may cause an unintended external crystal frequency
> > > to be selected.
> > >=20
> > > The HT_XTAL_FSEL (External Crystal Frequency Selection)
> > > field of HWTRAP (the Hardware Trap register) stores a
> > > 2-bit value that represents the state of the ESW_P4_LED_0
> > > and ESW_P4_LED_0 pins (seemingly) sampled just after the
> > > MT7530 has been reset, as:
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >    - net: dsa: mt7530: disable LEDs before reset
> >      https://git.kernel.org/netdev/net-next/c/2920dd92b980
> >=20
> > You are awesome, thank you!
>=20
> I am once again calling for this patch to be reverted on the net-next tre=
e
> on the basis of:
>=20
> - This patch did not go through a proper reviewing process. There are
>    proposed changes on the code it changes regarding the scope and the
>    method of the patch, and improvements to be made on the patch log.
>=20
> - This patch should be backported to stable releases, therefore it
>    shouldn't be on the net-next tree and should be submitted to the net t=
ree
>    instead.

The net-next pull request is out:

https://lore.kernel.org/netdev/20240312042504.1835743-1-kuba@kernel.org/

at this point I believe we can't retract it unless there is a very
serious regression affecting most/all users. This does not look such
case.

I think the better option is follow-up on net with follow-up fixes if
any.

All the relevant patches could be sent to the stable tree later:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable=
-kernel-rules.rst#L47

To try to reduce the possibilities of this kind of situation in the
future, may I kindly ask you to invest some more little time to help
the reviewers and the maintainers? e.g. trimming the replies explicitly
cutting all the unneeded parts in the quoted code/text would make the
whole conversation much easier to follow (at least to me). The netdev
volume is insane, it's very easy to get lost in a given thread and miss
relevant part of it.

Cheers,

Paolo


