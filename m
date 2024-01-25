Return-Path: <linux-kernel+bounces-38366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9783BE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520AA29506C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718C1CA86;
	Thu, 25 Jan 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv9pxrp+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391A1CA8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177356; cv=none; b=u0hr7OvYnnqpOhIVm74T9+SzEOklmXCXGOMY4E7f27NowUdxdxQy/q0ak49W01O+hs7VKVvpJcud8Ha/w8IqgH/i8DmVCxwrC/UpxjrJOJ+Qj+Ums4sYsBmvIpG/urC6eAb11froAgxyrIW+6qqy4H2uo9Ozgb7hKB1AU89WpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177356; c=relaxed/simple;
	bh=yWoYzQpHqgg6p1rlk03GKE1EaJ8e4bAmbUSX9Jtw5II=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PrCrDyQGzHEYygSwkYXClOA930dsD6WKdl5cutJVFiR48RwhEWJSlUJzGTJzw1OSJLbw3agnU+9jwpzLLbq4+fGeiedHY47kKluHV7ASRcz6/84Fu94Pavpl1AcCuUkS1NnkKNpbFLvRhRyvI11MlkVznyKz0QWKLzwOtRL3Sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv9pxrp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706177353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yWoYzQpHqgg6p1rlk03GKE1EaJ8e4bAmbUSX9Jtw5II=;
	b=dv9pxrp+nmtyOxz+wcJ0QFr62LqfEyp/bcdGjLRfZZcuWxm2VCNCARISHTE7SK/MpIPIpz
	NXCRacrNx/N9OxOuiGXPfzDcTK7Sc6JhkxH1UUdOx80jZslTnzvUFBzeLa3VMLPD7NK3ut
	UUjzC9k/wVOGWyI2cLtC1YyvrN9dS2E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-qVlZA_rZN3Wn7gFSVvhcmg-1; Thu, 25 Jan 2024 05:09:10 -0500
X-MC-Unique: qVlZA_rZN3Wn7gFSVvhcmg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e93545a26so1291048e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177349; x=1706782149;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWoYzQpHqgg6p1rlk03GKE1EaJ8e4bAmbUSX9Jtw5II=;
        b=GOpwK5lW4nI5x/8vS+0+ae1QTptvR1HeHM1TwHeTdSqWMi0DnwvGz2kb8nGauU6G5v
         JlybDLy7zJvwcClF5tnAwZCogOixeiYu9IrTnLsgE5htM6f8R5PtyMTiL+52e6zDHcs/
         wXjIJeY8axAlTWJ9UWvREMeekU5ib7g5XZ45pflkNgjNJmMoBRLIFYRaByjWzPnLkOL0
         aK3qAYbGwL0AL77g4PR7IVJ8nlum9zmpxk2Rifog4BQ2ok8+mhAV+gBcxdIZFk1d01Yp
         mxqiI5ZsorNPycNbgLpxI6yqSCkAQj6hcugtQT5NkWQaHHrA1W0+WPXayAnLMaT2oStd
         8+9w==
X-Gm-Message-State: AOJu0YxmG7wf/nT7WklmY6GDkBuTbRVM8Jg2wTi8yxFGXkiGk869A1Ht
	GzRx5aBhtNa0UcL3AYS4Yef2ntNwScmsd7BKQJc0RDg81KOa256bmlyw98po46CbJtIX3uCSAyl
	BqaKLTlV6Konb5H0NigrWTfS0yWTsa23Towdi3vmaF6JIp5d0t8kx2+pbEsDenQ==
X-Received: by 2002:ac2:4d9b:0:b0:510:1566:31ce with SMTP id g27-20020ac24d9b000000b00510156631cemr794330lfe.3.1706177349261;
        Thu, 25 Jan 2024 02:09:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe3B8xKCMAJ4wJGZwfJsCX0GVsfC5KHo76YW2BpN7eKcJrIqIpXpnzx3Vg8kFxSI2HVPfSsw==
X-Received: by 2002:ac2:4d9b:0:b0:510:1566:31ce with SMTP id g27-20020ac24d9b000000b00510156631cemr794308lfe.3.1706177348841;
        Thu, 25 Jan 2024 02:09:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05600c3d9800b0040ec8118b61sm2000025wmb.17.2024.01.25.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:09:08 -0800 (PST)
Message-ID: <c37feb621fa3f7867af8d97ffe36f577966ba3ec.camel@redhat.com>
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
From: Paolo Abeni <pabeni@redhat.com>
To: Furong Xu <0x1207@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com
Date: Thu, 25 Jan 2024 11:09:06 +0100
In-Reply-To: <20240125103454.0000312a@gmail.com>
References: <20240123085037.939471-1-0x1207@gmail.com>
	 <ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
	 <20240125103454.0000312a@gmail.com>
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

On Thu, 2024-01-25 at 10:34 +0800, Furong Xu wrote:
> On Wed, 24 Jan 2024 17:25:27 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
>=20
> > On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > XGMAC core") prints safety error descriptions when safety error asser=
t,
> > > but missed some special errors, and mixed correctable errors and
> > > uncorrectable errors together.
> > > This patch complete the error code list and print the type of errors.=
 =20
> >=20
> > The XGMAC ECC Safety code has likely been just copied from the DW GMAC
> > v5 (DW QoS Eth) part. So this change is partly relevant to that code to=
o. I
> > can't confirm that the special errors support is relevant to the DW
> > QoS Eth too (it likely is though), so what about splitting this patch
> > up into two:
> > 1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
> > 2. Add new ECC safety errors support.
> > ?
> >=20
> > On the other hand if we were sure that both DW QoS Eth and XGMAC
> > safety features implementation match the ideal solution would be to
> > refactor out the common code into a dedicated module.
> >=20
> > -Serge(y)
> >=20
>=20
> Checked XGMAC Version 3.20a and DW QoS Eth Version 5.20a, the safety erro=
r
> code definitions are not identical at all, they do have some differences,
> about more than 20 bits of status register are different.
> I think we should just leave them in individual implementations.

@Serge: given the above, would you still advice for splitting this
patch into 2?

Thanks,

Paolo


