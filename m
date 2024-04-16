Return-Path: <linux-kernel+bounces-146621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51958A6850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4831FB215C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE47127E2E;
	Tue, 16 Apr 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUFkCVwg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD288127E23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263262; cv=none; b=XeY/JCGAer1gVZYrLmpmp8CzuHX/O4Mql7xDjYYequcuDRq60qQpJdcsqQyFPtRAOkYhIU1J/NZkcOaD3U1z7HrWLu1uU2lgV3E8Ji8Hz8lIplZBdwMN12zuZrKKWjLcjEKvqwjU/WvQIkwYv0Qdw9W+/CJiAJTGdKpm2RVRvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263262; c=relaxed/simple;
	bh=jMpD+iqIk7sAa1/rHFlDW/A5fWkcr8iBWlFV+lTM674=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8za62Z3wqfqjjJmHICPtYTxzRXXACAFobdfq7sl2qQkj6RuIZfxKwiEsfAnpUOFALxQLqQeEcdXzsWMtvEvouwGsPd7lLXSYkEVHpZpQyZs7rD8r0945WUBxxU1gmRUZC7kKariwIOHDoBxA69+xD3NVQN8Vl0Spk7x6blgLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUFkCVwg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713263259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jMpD+iqIk7sAa1/rHFlDW/A5fWkcr8iBWlFV+lTM674=;
	b=iUFkCVwgmH+curvN/qYhgYWhrf9aF2xmG6sSGXIyq4D7mCLh4v75Iq8LmN2lC5p1en8eLF
	A82zEzmiFTNXkp8DmABDQ3QoWJGaLlvki20vPVvPK2dz8b/9pl8psfwZUX4U5x+xUr5vng
	QzWWufs6MbFV4Uybe/kXI4Eo74GgsZE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-I05zHnnOMDukKEOlSiBC5g-1; Tue, 16 Apr 2024 06:27:33 -0400
X-MC-Unique: I05zHnnOMDukKEOlSiBC5g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343b9425ed1so927759f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263252; x=1713868052;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMpD+iqIk7sAa1/rHFlDW/A5fWkcr8iBWlFV+lTM674=;
        b=vHDhdoW3zooCRHKTrQ/FVUMnQNOzO+Mt+w+i36Ma2yk4A4hLi4l7jQ6T0ZKyDmQI8L
         RcedjmupKjAZ6SouSFp5d424aAb1ymuThHEL6fUl2RKv+HrlMt+9gQ2euAh1s6o5u9Gs
         tLasoG4XvQ5HS899xI2DE2vd3rRrYW07bPL3UZUAr9IoLkjgvHy/UBYVwcA8Oeoj8z8m
         vKHC4usjOdlVZ6r2r/lCiojZqS4RKJgHGkNGx95D/AB4NcpRZ8Z+9Ww/sNTNFzFaT17R
         rdT495U33h1M4C+thw3lnnhtAUIMuEjCCJYJwVXGsNeWYkHkYb8auZO2tpkvP+ht4/So
         /j0w==
X-Forwarded-Encrypted: i=1; AJvYcCWJqsOtScg3oMyl5jgSv3o5+VV6jtNWoti1CSbnXWrB/EwClRHmf8j9zLJBFNIk7VsKg4lyKA5DuegfC2p4S7ZZbzN102mCNaF6pelV
X-Gm-Message-State: AOJu0Yy5hbbG8d2N0y+hyJAEmFLb94lNnEALkp3FCymSgp6muvF7bL4I
	sM0yfbUGecB2LkoIm5wiOgnuwr7siqQeA+yNiNx3P5Nmr/jWz/PmclXzFQsuaav3apLzGAis50k
	dM1Pd4xd/WJeh9fLxod6HPBj8sfPaAW48ueqixOyF06SabOgNTENTTLZ/N4dzdQ==
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr5227094wmq.3.1713263252098;
        Tue, 16 Apr 2024 03:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFmIW53wsJsfJZC/vP6rHZszIiJj2G/P1JWmKG8lyXcE3DKFIYdVt+Ue4BVg0M23mZHLeZ3g==
X-Received: by 2002:a05:600c:3556:b0:418:3cf7:7f7b with SMTP id i22-20020a05600c355600b004183cf77f7bmr5227078wmq.3.1713263251734;
        Tue, 16 Apr 2024 03:27:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b00416e2c8b290sm22581975wmo.1.2024.04.16.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:27:31 -0700 (PDT)
Message-ID: <9644a96d17152014c8e7f91e9786dde26f67d7a5.camel@redhat.com>
Subject: Re: [PATCH net-next 4/4] net: stmmac: Move MAC caps init to phylink
 MAC caps getter
From: Paolo Abeni <pabeni@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Russell King <linux@armlinux.org.uk>, Yanteng
 Si <siyanteng@loongson.cn>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Tue, 16 Apr 2024 12:27:29 +0200
In-Reply-To: <20240412180340.7965-5-fancer.lancer@gmail.com>
References: <20240412180340.7965-1-fancer.lancer@gmail.com>
	 <20240412180340.7965-5-fancer.lancer@gmail.com>
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

On Fri, 2024-04-12 at 21:03 +0300, Serge Semin wrote:
> After a set of fixes the stmmac_phy_setup() and stmmac_reinit_queues()
> method have turned to having some duplicated code. Let's get rid from the
> duplication by moving the MAC-capabilities initialization to the PHYLINK
> MAC-capabilities getter. The getter is called during each network device
> interface open/close cycle. So the MAC-capabilities will be initialized i=
n
> normal device functioning and in case of the Tx/Rx queues
> re-initialization as the original code semantics implies.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

This is a net-next follow-up for the previous 3 patches
targeting=C2=A0'net', right?=20

If so, you should have posted this one separately after the other would
have been merged back into net-next.

We can apply the first 3 to 'net', but you will have to repost 4/4
after ~Thu.

Thanks,

Paolo


