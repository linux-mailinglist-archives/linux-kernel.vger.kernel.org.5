Return-Path: <linux-kernel+bounces-48341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7D845AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AB51C231B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97B5D473;
	Thu,  1 Feb 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHfxsPij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387825F478
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799135; cv=none; b=KnxzH3ze7u9yAalThJewC/CCOeSMa2LhXRvF7rOgPVqgngRfUZkhsYRfYLcxvuWrhZT/qXtRERUBx6ttOeqdkvzPQaSMK5Sz1XEMuhVS69FGdB/q/LEgMC3rZ4Lkdyo/KYVkccbp6g23Jvc69FaVfFgldJSmRxWuX5kJmjWvyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799135; c=relaxed/simple;
	bh=Lg5VIBYr8DqIlMVbpFN9wv1FRS8XCVJijcYPWV8KwI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6K7EFp9rWYBaYcDS+4tsq1dFC03BrRwxXEg/L3Xbv2iL3U0SZ5cxmr5vhBuEth5GmLRNG+ssuQcRyRNi+WWFeq1Da+yTYfbQcct6SiTX20LRnPGOe0IdHQqCieCXYeJvFs51WAKpJJpM47pxoTBHneXtEbWYrUWCiLaN822XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHfxsPij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706799133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cHF+k/1JIhnU4snfXunW2cj8+4H8nr48/ynY9KZYcg8=;
	b=ZHfxsPijdwma2DESDahBT/giGO2Npb4uLlqQSBoejLM8dCX0Ow5Fp0SRV79yCn4JJHYkcK
	hwwkx0AjdgKXDhJpTk8KELHw53K3HaW+YJpfsLtejxyEs8O8OfboHO+TsYPmMHZa7uEJUS
	mNl43ijp2KaeGDWVaOC66bTXu9Ymwb8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-wZ6cK2lTMfqBUMeay_7ztQ-1; Thu, 01 Feb 2024 09:52:10 -0500
X-MC-Unique: wZ6cK2lTMfqBUMeay_7ztQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33afc7484f7so110131f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799129; x=1707403929;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHF+k/1JIhnU4snfXunW2cj8+4H8nr48/ynY9KZYcg8=;
        b=V8XBZKjgzfFiRy1eQiJTYxGYZxypqG8Gwv7u4/l4ooOlkM9ha5S9WKFzblzC6gwSv0
         2rgUE7mypMJ9oFWcvxKZetRGucWaa5hZyMaer1ABgwGFIXRL9ysDXopTHy+z3Fpm3hTZ
         PJLjcYI/dBayopuWPRS2T8Hq5AOJS+VlixEZvZOTvcQB1yWmV2XSaTDSLbYevnO8RzZ7
         vIovCzEclY4Dy4D3e0LYjR3buVQ89aW40BpaVWO8AJXlUCJ+SmQ7gqmanhMtD8Xsrppp
         Q8pn3V1yEKK5Jci4CNMR0kP7+25p0Rtw7vv5FImncXb1BoJNcZ1L/3fDRkLk3LN3CJkZ
         /5tw==
X-Forwarded-Encrypted: i=0; AJvYcCXFrorX0Mm4kk9SBkgNpaPDzBAau/z+8QcWFNooIAJ/JJC/mqu18tpX71+WZq3iCJwpus7NVrs9WfehRYjuVuQ0ANo7isrOE7Gpuf7e
X-Gm-Message-State: AOJu0Yy+akjnSbIp6yViVTF12PBV8FyG5ehaAwdf21Dg1oUh1RulHDit
	4e9vNgnKv+2/p8voTtBMe18JTkBYf0duhcbO96Y1x6vsYARxCnj3d0NyaSg1Z6pFR+ZYXyq1yPl
	WazEwBSjIk7vhMb1EPT1D3Al4OEZ+MIV65gHw6K1Kbk6MQnUEOsIiS8DM656YZw==
X-Received: by 2002:a05:6000:136d:b0:33b:18c7:5e64 with SMTP id q13-20020a056000136d00b0033b18c75e64mr840813wrz.3.1706799129624;
        Thu, 01 Feb 2024 06:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsMZoS71b++CRZTcqEHd97NbSgX31VjHQe6ci1y7vg8BsogCDpbauXfU1WACfnI5wSd7Nk1Q==
X-Received: by 2002:a05:6000:136d:b0:33b:18c7:5e64 with SMTP id q13-20020a056000136d00b0033b18c75e64mr840794wrz.3.1706799129260;
        Thu, 01 Feb 2024 06:52:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtX6Iu8Lr4CIK0CeqpjFCnY3ogykInZuMNEG92iBFjz9VvTGRwUb9YMWso3O7g+qZnvbktQjbacWLHea0jhDDgmvgcym/IgV8sDNhS0laYF/3vbsBBI/Hlw7iVZPYUIumnoqeuDib3WZCJVJRWgFH2bw/ObjFcVGlkMKQqini+Mz8DaNTdHaNxfcXwiVGi+w9gKg7HJHZttKAHn+oFJV9e4OSkDfp8D/CSLLgIfx5z4rG4/ZElUnyxGuvZGxMNSt11uVL9Id7z5TypewwuP1LreOv17z8Pth43z8u8bDK4r51jO7AkdolkVPzqr7ANTFfw0cT4PLfSqmavvW7CLaHRJJeQs8m2U2zFRmx5x5a3y6aA1WlFjnoUmOPMGqTEGfcTdyhRMy1uM+YELtfjRscCp2i53P/uJ/82p2+d
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d6c6d000000b0033b1a40120esm1102955wrz.2.2024.02.01.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:52:08 -0800 (PST)
Message-ID: <92cbf512c4a1b80c577eeb25ad0d69985608e14b.camel@redhat.com>
Subject: Re: [PATCH net-next v6] bonding: Add independent control state
 machine
From: Paolo Abeni <pabeni@redhat.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Aahil Awatramani <aahila@google.com>, David Dillow
 <dave@thedillows.org>,  Mahesh Bandewar <maheshb@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,  "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 15:52:07 +0100
In-Reply-To: <32424.1706798605@famine>
References: <20240129202741.3424902-1-aahila@google.com>
	 <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
	 <32424.1706798605@famine>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 06:43 -0800, Jay Vosburgh wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > On Mon, 2024-01-29 at 20:27 +0000, Aahil Awatramani wrote:
> > > Add support for the independent control state machine per IEEE
> > > 802.1AX-2008 5.4.15 in addition to the existing implementation of the
> > > coupled control state machine.
> > >=20
> > > Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING =
in
> > > the LACP MUX state machine for separated handling of an initial
> > > Collecting state before the Collecting and Distributing state. This
> > > enables a port to be in a state where it can receive incoming packets
> > > while not still distributing. This is useful for reducing packet loss=
 when
> > > a port begins distributing before its partner is able to collect.
> >=20
> > If I read the code correctly, the transition
> > AD_MUX_COLLECTING_DISTRIBUTING -> AD_MUX_DISTRIBUTING is not possible,
> > am I correct?
>=20
> 	That's correct.  There are two completely separate state
> machines in the 2008 standard, one for coupled control and one for
> independent control.  The state machines utilize the same states other
> than COLLECTING_DISTRIBUTING in the coupled control mode, and COLLECTING
> and DISTRIBUTING in the independent control mode.
>=20
> 	Essentially, the two machines differ in the transition out from
> ATTACHED state; coupled control moves to COLLECTING_DISTRIBUTING,
> whereas independent control moves to COLLECTING then DISTRIBUTING. =20
>=20
> 	The 2020 edition of the standard combines the two state machines
> into one, and changes the set of states.  Bonding does not implement
> this version of the standard.

Thanks for the clarification, given that the patch LGTM!

Acked-by: Paolo Abeni <pabeni@redhat.com>


