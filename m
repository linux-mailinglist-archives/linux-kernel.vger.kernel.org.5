Return-Path: <linux-kernel+bounces-146897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21188A6C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B101F22A04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805612C7FB;
	Tue, 16 Apr 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2Shp47M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15012C496
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274526; cv=none; b=Co3/ghZ78KwEZMTF5SUoGh91v8J0DRulJTpsIqvnm8rjqCwfgnREWiTC5tYKV+C00eC0vtAgh4ZUbLvaIN2PtfgTb0E77XihLhCG68n+qEBLPsf8wEgaaUZf0PRZiGumCdTLSxYGbNb1DlMgVaXbn73u8wkvuIPXjc5eR3YHV3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274526; c=relaxed/simple;
	bh=kuhIpVXVGg/SQoKnZErK4YO0Cn9um5VvQ/AGL3/eViw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTl6O2vJZQ2VSL4M/CRZOD3GzDzgBU5vXpYuk6WJaSkfjb9xpLXhOyGPBEo8rCg+2naPyOdFH51dNMPDLMKbzwSc+E6VJPfNXc85qhZVaY0DHNKIvuYs/TyBaoezy7wd0yK+GR0mi+bGaL7SaPVbW4yo+/TBLv3WyRUspnkpFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2Shp47M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713274521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3qmfNVBGwiyqqASq+9r4BIagagwY9FG/1Twd/IJSv68=;
	b=B2Shp47M5nbP0FufSd01fIwNaMgaAvmlvW74OUYTbm5lVJG7sQ7v7GNVxTy0d5BlNNlDZj
	UqJxSHrd3KWXKD/PdeHAlhTrQctvaX9csyspr6I9294STAcmxZSfXJoDtWkp81/hNjuU5u
	aDcy+Gb3lXgG8uNUFt7nl+4hfch4n3c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-wAAs6DqkMFqEVOlnP2ezXw-1; Tue, 16 Apr 2024 09:35:19 -0400
X-MC-Unique: wAAs6DqkMFqEVOlnP2ezXw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3450bcc1482so1140829f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274517; x=1713879317;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qmfNVBGwiyqqASq+9r4BIagagwY9FG/1Twd/IJSv68=;
        b=MnaOfiZspbpWeQbtfkYqxRPyyq88T2BSPnZtBVhMgEVTHDQXTUSVAJG42jRHI7z9eP
         w3C+3IHBgek9VvEumWJej2i+OoA8oy28mk3Yd83lJOSCsa63VNkjWlo6Zt3QzHt9F28o
         B8lPkgo6XAtKAzJtDZ5h8prs6M+wgNG4r1VNGqS16ZvvDb/s/i3/WO7vOq+FWpwjdHQ0
         /ZukPsaZmJfxQpfvZWdtGP9qt1MgfIe2oMVXWDFgxpnYWmwG3KzRt8lKcZ4mYg/VXXCc
         hvuU8ydFW4OxBzX/fAKUs27j+xZQDxJsc67UZN+0u3xbULIM2D/fUmcF7/GeSHqwIEvu
         dnFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGq3VIm+ngimaLRGxtq0DayzwD8zv3W6PgiDbUPZGwUwQemw6kwzaGZY0ZV//nor0mys+F55W+WbjuqzGHmXTUUa7a2EbHrWjxG0At
X-Gm-Message-State: AOJu0YwJhG7/vl+Gq9bkv3MPwOvCB9r35uDrNJCjS/M6qwesrEjg+ZCv
	1jFaLhaev6cjUHUU1eLksVzyDUN6uYBMJQN3XlJlEEu/dLj8bWqPy8bsg7QDjLycvhdXSeIA5Pr
	IiPt+kxr+GLrDjJ6Lo22mVexJ/VHU73HivnMfQxIv3cVJU9gvOXn4jHYLLUwJ2w==
X-Received: by 2002:a05:6000:232:b0:346:c599:8ef3 with SMTP id l18-20020a056000023200b00346c5998ef3mr7748041wrz.2.1713274516999;
        Tue, 16 Apr 2024 06:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPjrpjFOpUkDG7F5YyEV9Wuqtfwb404xFkRhv2uzRGUQ2skaahJ9M5mrnx0FbTR5Tcr+1zKg==
X-Received: by 2002:a05:6000:232:b0:346:c599:8ef3 with SMTP id l18-20020a056000023200b00346c5998ef3mr7748029wrz.2.1713274516617;
        Tue, 16 Apr 2024 06:35:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b003499f9b4b6dsm165078wrw.101.2024.04.16.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:35:16 -0700 (PDT)
Message-ID: <d40134692cb204d014427a1c6bf2ea86451c3462.camel@redhat.com>
Subject: Re: [PATCH] net: openvswitch: Check vport name
From: Paolo Abeni <pabeni@redhat.com>
To: "jun.gu" <jun.gu@easystack.cn>, pshelar@ovn.org
Cc: netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
Date: Tue, 16 Apr 2024 15:35:14 +0200
In-Reply-To: <20240413084826.52417-1-jun.gu@easystack.cn>
References: <20240413084826.52417-1-jun.gu@easystack.cn>
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

On Sat, 2024-04-13 at 16:48 +0800, jun.gu wrote:
> Check vport name from dev_get_by_name, this can avoid to add and remove
> NIC repeatedly when NIC rename failed at system startup.
>=20
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> ---
>  net/openvswitch/vport-netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netde=
v.c
> index 903537a5da22..de8977d7f329 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -78,7 +78,7 @@ struct vport *ovs_netdev_link(struct vport *vport, cons=
t char *name)
>  	int err;
> =20
>  	vport->dev =3D dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> -	if (!vport->dev) {
> +	if (!vport->dev) || strcmp(name, ovs_vport_name(vport)) {

	  ^^
Missing open bracket here, and close bracket towards the end. Please
build and test your patch before submitting the next revision.

Please also include the target tree ('net-next') in the subj prefix
when you will submit it.

And update the commit message as per Eelco's request.

Thanks,

Paolo


