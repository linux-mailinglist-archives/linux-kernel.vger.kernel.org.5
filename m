Return-Path: <linux-kernel+bounces-77236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA8860268
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF93A1C21E04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2414B832;
	Thu, 22 Feb 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTVePZSd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9314B837
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629248; cv=none; b=DpMTMVvfcasi+H8+6tbTUyx3/ZeBbK4vcsDQZ5vyn9lNJiL/Ejf3liVOjFREbunEavP8PG5AU9NzAmbZFFV8+0Ftk6mDkFIHUPHz2UweQD9OJ+LkBYHVoVkksiRNIONU887dq07z1abLhZ3p2FyHp0bqvNu9aBSpIDyxHWwtodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629248; c=relaxed/simple;
	bh=oW1gFNVKJodwdwSEaE47Yse3wtffu8EGgYCEElN6ibk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amb+pH7utEy47/YaTI09lB5X+T2ClroBzM6pEwwbG2GhhGeMYYBdZmOwe5RuaWlmBZHqAjWe9pja33Mqvo2Ecvl43L2gVBGcm48k+qaODFKcgKL/Uw9iP+YD8qcve9VHB6TWCGQ1vfRUC8OZGtsD8rmYEP7R3tiAydb0kQ6OYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTVePZSd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708629245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EcVr/iXDKl2dFQaTrHjb1w8gC2gsUfhhAy+IlCxU7Q=;
	b=CTVePZSdbst6lT9rLbXLyegFWeEOSK1+brRrAs8IIF/BsDIw7h6zFK/OKuf6AjRX6oJgUm
	wc87waFtPmYJyhi8Extw6TfjxfkpOubMcJ08Cm7yl7C8TmeQ/KAQj2wjjpCX2miW2vNLzG
	wv45tfyw5VQsMaLqFBUFjoWCn6CycqI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-pdaNQZmgNI6BR_G1CGGIpg-1; Thu, 22 Feb 2024 14:14:03 -0500
X-MC-Unique: pdaNQZmgNI6BR_G1CGGIpg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d256ca4c8so23495f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629242; x=1709234042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EcVr/iXDKl2dFQaTrHjb1w8gC2gsUfhhAy+IlCxU7Q=;
        b=E1bhZVF+DRG/F9R404hYc0XhdMgLB6i3TGOXmNt29b8UjAN9PgySxvod46VukIs9Mm
         qlWZk3UxG0lp2Xuf4wm27afNXAgu+xooxlsMS3QlQ5ItDdCGU7tFj56GxMp9GKq33+W8
         d9Lfct5VryejwXNlQgDGYphGxpWrJ7gDGWgT3igmez4yqnV4AZVOXrEkUWDIdrDQa11l
         BFkvWXKTbNBJ5C2Lo6lbMKwWFBumq8daNSLwYJtrmPJLQtyXBZU8zDEmD4FCrqIu/3Gz
         sJvpgcRkJ/5O2FqGomptHKWfofzbzA72HduiijggJyF8rgIxGsgdMLJK41EAQRZxIxi7
         8+dw==
X-Gm-Message-State: AOJu0Yx7NLfldAX52OGoaxYV0GGx1VjmG6Zd0jE1hOcFldQw/8hrcgya
	CLoB4nwA1VxmyV/lcnk2iNZjWgu92zUr3Sf+gR8NqlQDkLhGvxTcRuWz8Z5AWfy/zbAdxEtVtXB
	jbe/KbwuJUukfHxNMeLYA77pITKPGnuSEplxQKYUT7J3AYEJInNWeKgpA5LaKjRGO3KaUgz1l
X-Received: by 2002:a5d:4688:0:b0:33d:2120:1016 with SMTP id u8-20020a5d4688000000b0033d21201016mr48615wrq.52.1708629241838;
        Thu, 22 Feb 2024 11:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGOdbI1tAnkcf0Z7MVzUgYDiaNDKtZW8M+iyfNr7KmoAdkj5DXpMhLNPxfmu3vVrZJNmerWg==
X-Received: by 2002:a5d:4688:0:b0:33d:2120:1016 with SMTP id u8-20020a5d4688000000b0033d21201016mr48601wrq.52.1708629241544;
        Thu, 22 Feb 2024 11:14:01 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id k5-20020adfe3c5000000b0033b66c2d61esm21027161wrm.48.2024.02.22.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:14:00 -0800 (PST)
Date: Thu, 22 Feb 2024 14:13:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Olivia Mackall <olivia@selenic.com>,
	Petre Eftime <petre.eftime@gmail.com>,
	Erdem Meydanlli <meydanli@amazon.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7] misc: Add Nitro Secure Module driver
Message-ID: <20240222141319-mutt-send-email-mst@kernel.org>
References: <20231011213522.51781-1-graf@amazon.com>
 <20231225090044-mutt-send-email-mst@kernel.org>
 <363ca575-f01a-4d09-ae9d-b6249b3aedb3@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363ca575-f01a-4d09-ae9d-b6249b3aedb3@amazon.com>

On Mon, Dec 25, 2023 at 05:07:29PM +0100, Alexander Graf wrote:
> This patch here is already applied in Greg's misc tree which I'm happy to
> have it trickle to Linus through.
> 
> 
> Alex

Kernel test bot was unhappy with this patch btw. Know why?

-- 
MST


