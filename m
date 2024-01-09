Return-Path: <linux-kernel+bounces-21025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58D8288B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89968282E4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177D39AF1;
	Tue,  9 Jan 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/k1jWqt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444839AE3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704812818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbXPl0foJ8pZ9LmM10Gvp60O6UdohP4YzMh1SzUToow=;
	b=U/k1jWqtgqMSBoV+gX1QBsKgpQiPYqleYp+t7R1L2H9UDoTCR6R83hv3AB1BdSR9IlyUVf
	PS0pajMl1WpGR1pu2Dd7VV8XToaExhDFJisf/g0PTp/AEmL3EU+YFNud9Jdgq3DLyihUw3
	jGOFN5iImH4FOuyQs4UTf/qaQE57Sdg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-0Qlj9OIRP46D746-dHJvzQ-1; Tue,
 09 Jan 2024 10:06:54 -0500
X-MC-Unique: 0Qlj9OIRP46D746-dHJvzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE556280640F;
	Tue,  9 Jan 2024 15:06:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8BC91C060AF;
	Tue,  9 Jan 2024 15:06:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1580269.1704810719@warthog.procyon.org.uk>
References: <1580269.1704810719@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rxrpc: Fix use of Don't Fragment flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1581608.1704812812.1@warthog.procyon.org.uk>
Date: Tue, 09 Jan 2024 15:06:52 +0000
Message-ID: <1581609.1704812812@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> +void rxrpc_local_dont_fragment(const struct rxrpc_local *local, bool set)
> +{
> +	if (set)
> +		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DONT);
> +	else
> +		ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDISC_DO);
> +}

Oops... I forgot to commit the change.

David


