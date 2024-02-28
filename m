Return-Path: <linux-kernel+bounces-84615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11386A909
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620801C24E95
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C925611;
	Wed, 28 Feb 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjT4dlO1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51625601
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105697; cv=none; b=izGgIF66ezYnVKxX0+2j8AD0OFUNT6CDjSoFzfpyvOojlN1gvgtDE+/ac99w2/YO+I+igOyslsydzlLgnF45gQ2+GXxtrsJ5Q5gViv6VzmNdnz8xM1aeHfwgDVHgYtIGGp0kI3J89dE2teJg41suIhnvCMLBsIiMMSdafUMLcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105697; c=relaxed/simple;
	bh=mw9EtmhvUkRrnHcT5CV9FOjIX6HotnKYpHlnylx2y+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9zcdobkyxd1TQE4pBZWFffZ40zjKa1EIL6caoWILC1LXX3QyWVLmSL0MHupFoJVzSKlRYt1LqZQ92uuIpN2EDF9ki0wubWW1CjEm8P8s0JlCXInflepbiQbR+bwtYhK2NLFUD90ylra0FFDpB1t6k2dDUHPciDg5KPvxju1zDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjT4dlO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709105694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mw9EtmhvUkRrnHcT5CV9FOjIX6HotnKYpHlnylx2y+g=;
	b=YjT4dlO1cqR3Gpp0CA62nlQTgJ3bUXhm3AY8WsYKwcvKFjHacbF+TTu5cFvZ4qKN3fGn2q
	MhYKuV6sBpyLiWXgvurecSWtbGB3bEixZRfIShQeJx5jf8ldFGCX/lgrhJXDCTcH3n2cvt
	ladYP+QKGTbr0QGUH6L8iUzYrMdfQyc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-fiQKRPXSPXeJbFITRQiPSg-1; Wed, 28 Feb 2024 02:34:53 -0500
X-MC-Unique: fiQKRPXSPXeJbFITRQiPSg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412960d90b8so3755655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709105691; x=1709710491;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mw9EtmhvUkRrnHcT5CV9FOjIX6HotnKYpHlnylx2y+g=;
        b=ahIWLNOS4iNLZVEmDFcWLMylSsbvmPZUVcMShiLM0OOsiQwC8ZZqlcdIUi5uRo13eq
         E3hV4YGnwmsJkQ3u01SvdQLrAt3iyadpjFtk/uklXvyOJjDVRQkcuK1Gbu0R8+4kLrD9
         JKWnaviyN5obvxbiaMSJk7Rpf5S+6eqVI0Q5a3urI544GyfINdG1hMsE7pKlegSLOXfr
         NBpWXw+fElTSWu80aA6yH3osZLbC6W6cEFj9JVOoR+rkFYhibqouMcqHwfIWxcV/Xmf0
         rELhA1V4dEc7APtdBnAeAgaXHk8nj/xjoOoh8Ij4G+QQU6mrWufHB3aAdtQ0PHQpPd6B
         XL+A==
X-Gm-Message-State: AOJu0YyFq3FggVQEsRc1sZo+qI/V/dO1XvNM37Ah4/D/Q4lZXKF84oVY
	0GcwymeNoPd3zOqyjRxtIaw4aVyv+36JrsIPdOHo7bx262INlsmZmS1mW6oNf1jaspb8/3yLfvf
	XZmFz9SSp1L5THvfFu3dTdpPJYGkacGrk7WlQNj90dGHYL+baRamszAeDwUSY0QsXPEtdKA==
X-Received: by 2002:a05:6000:1d99:b0:33d:d932:45d1 with SMTP id bk25-20020a0560001d9900b0033dd93245d1mr5474235wrb.2.1709105691683;
        Tue, 27 Feb 2024 23:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPWlWO7Xo+YOMSWjk5a2ehVE74h++qecoF3o4F4zf3Qk4FLDIOpn/IHHEKYgkLEJ1xczMJ1w==
X-Received: by 2002:a05:6000:1d99:b0:33d:d932:45d1 with SMTP id bk25-20020a0560001d9900b0033dd93245d1mr5474224wrb.2.1709105691281;
        Tue, 27 Feb 2024 23:34:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-156.dyn.eolo.it. [146.241.246.156])
        by smtp.gmail.com with ESMTPSA id cl5-20020a5d5f05000000b0033dc7e50488sm11492951wrb.96.2024.02.27.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:34:50 -0800 (PST)
Message-ID: <34a1ca43d2f21428367237b4b693df6804bf716d.camel@redhat.com>
Subject: Re: [PATCH] Net:cache didn't flush when ipv6 rule changed
From: Paolo Abeni <pabeni@redhat.com>
To: Lena Wang =?UTF-8?Q?=28=E7=8E=8B=E5=A8=9C=29?= <Lena.Wang@mediatek.com>,
  "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>,  "dsahern@kernel.org" <dsahern@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shiming
	Cheng =?UTF-8?Q?=28=E6=88=90=E8=AF=97=E6=98=8E=29?=
	 <Shiming.Cheng@mediatek.com>
Date: Wed, 28 Feb 2024 08:34:49 +0100
In-Reply-To: <3fd5e055b5f56c596416f0cf37c6b47e77af0379.camel@mediatek.com>
References: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
	 <655ba4a1-4f73-4ef4-aff3-0b439e65a9c9@kernel.org>
	 <3fd5e055b5f56c596416f0cf37c6b47e77af0379.camel@mediatek.com>
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

Hi,

On Wed, 2024-02-28 at 07:28 +0000, Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> Dear David,
> Update the patch as below, thanks.
>=20
>=20
> From db01a40e45f51d00cb19e45a41507c97363d6ed8 Mon Sep 17 00:00:00 2001
> From: shiming cheng <shiming.cheng@mediatek.com>
> Date: Mon, 26 Feb 2024 20:17:58 +0800
> Subject: [PATCH] Net:cache didn't flush when ipv6 rule changed
>=20
> When changed from old rule&route configure to new one as below,
> ipv6 cache dst_entry did not change to new route table as no
> cache flush callback function, then forward to wrong out interface.
> When fib6_check dst_entry, the fib6_node version[fn_sernm] is
> always the same with socket dst_cookie, old cache dst_entry is
> always used and no chance to update.
>=20
> So we need to update fib6_node version when rule changed and
> flush cache to avoid dispatching a wrong interface.
>=20
> Signed-off-by: shiming cheng <shiming.cheng@mediatek.com>

You need to cc the netdev mailing list to allow up processing the
patch.

Please also include the target tree in the subject prefix ('net' in
this case), a suitable fixes tag and avoid sending patches in reply to
existing threads as it confuses our bot.

@David (out of sheer ignorace) could this the root cause for the fib6
self-tests sporadic failures?

Thanks,

Paolo


