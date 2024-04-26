Return-Path: <linux-kernel+bounces-160338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F98B3C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C3D1C21513
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF014A4EB;
	Fri, 26 Apr 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAIJPUmm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A113D2B7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147073; cv=none; b=P442NQ5tXIqCfTPmA5fXv+G/elfP4wq59u4IbX0g3ajUxNiaBhtCkfhSJOdDc2qpD5M9IhHhfaGiPGiNM921hS7cnI3QqKK2+8ErWnWcCM2PSgCNc/3cEEqE97msasAEAl7emoov5FLYGSZklhZx/Q0XDSrbij9x5My/V+gvcrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147073; c=relaxed/simple;
	bh=tVZm1NOaOpfDBvnM6Oow6dJig4w3fLjQoaLBHwmyJD8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FbVOJ6nK7I1drhfnmGZVlMjz6kl5XMsk3pi15s4TnItUQBU/XYuFQ2uBkvpVOnxX7XJ/MMpWRDzfNZNFoGvCRBJq6oNIdVC4G71cGp2f9D/NVcXy5/eCOqWm7zsKPn/NTluUCB8+17INcgTvXdArHditNj8oVXrSSt3KjrB4zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAIJPUmm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714147071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5unUVLjNo+qjBW1OspxyrCDGLZZ03wMYpF4fiHvTxL0=;
	b=OAIJPUmmaYC2Y9WMiSBycVK1RkAT5y91u2mreq95Ce9QXhssNsBY6ELW05LdU+kCMNsQyW
	pw4men4cfee+EN2+KwIgOKmNFABkibizE4qC/vLdQU9lWQ+kWvGerz3mUWZUgkI6yPIGI6
	Yhd7UCU0AjhaAMLY+kAsr5opmM6uw0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-Z51XDStMMs6IW8dDyTwKbw-1; Fri,
 26 Apr 2024 11:57:49 -0400
X-MC-Unique: Z51XDStMMs6IW8dDyTwKbw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 143C93C000A1;
	Fri, 26 Apr 2024 15:57:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B94C3492BC7;
	Fri, 26 Apr 2024 15:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240422115541.38548-1-linyunsheng@huawei.com>
References: <20240422115541.38548-1-linyunsheng@huawei.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: dhowells@redhat.com, davem@davemloft.net, kuba@kernel.org,
    pabeni@redhat.com, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, linux-afs@lists.infradead.org
Subject: Re: [PATCH net] rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2650222.1714147067.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2024 16:57:47 +0100
Message-ID: <2650223.1714147067@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Yunsheng Lin <linyunsheng@huawei.com> wrote:

> rxrpc_alloc_data_txbuf() may be called with data_align being
> zero in none_alloc_txbuf() and rxkad_alloc_txbuf(), data_align
> is supposed to be an order-based alignment value, but zero is
> not a valid order-based alignment value

Ummm... 0 *would be* a valid order-based[*] alignment (pow(2,0) is 1).  It
might actually make more sense to do that than to pass in the number of by=
tes,
then 0 is the default, but either way works.

[*] Other places that take an order-based parameter include things like
    alloc_pages().  The number of pages being requested is pow(2,order).

> +	return rxrpc_alloc_data_txbuf(call, min_t(size_t, remain, RXRPC_JUMBO_=
DATALEN), 1U, gfp);
> +		return rxrpc_alloc_data_txbuf(call, space, 1U, gfp);

The 'U' should be unnecessary.

> +	data_align =3D max_t(size_t, data_align, L1_CACHE_BYTES);

data_align =3D umax(data_align, L1_CACHE_BYTES);

would be better, I think.

Anyway, with the umax change above:

Acked-by: David Howells <dhowells@redhat.com>


