Return-Path: <linux-kernel+bounces-20969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8418287E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDCD1F25187
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7818D39FD0;
	Tue,  9 Jan 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZWgI/5Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8704B38FB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704809784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pc67pwl7wENc1gC3qwSzTrlvrs0jHKvpx7F4yFEiJj0=;
	b=JZWgI/5Q0Znzp1iD4XdYFGkvhfDpliDKFkqqSZQcfYgGNZpelOo2Cw5s1pWmDqeqTdPLs7
	jSbxAWh6i6J8zFaKa93+Sx1o4DQZz38X3ynFjfPMLbuSurvMZVktvastIRmla1xm9aG5FQ
	ZsQSWlroI1NHUeshkSkzRKwmkHIORh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-Chjqz7tbOTeT6Fr81qJYog-1; Tue, 09 Jan 2024 09:16:20 -0500
X-MC-Unique: Chjqz7tbOTeT6Fr81qJYog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8413010259BB;
	Tue,  9 Jan 2024 14:16:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EDA6492BE6;
	Tue,  9 Jan 2024 14:16:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAB9dFdteL97Z8GAry9TwmcOfw0+PQDzL_u14PwwAEq5uUHaUkQ@mail.gmail.com>
References: <CAB9dFdteL97Z8GAry9TwmcOfw0+PQDzL_u14PwwAEq5uUHaUkQ@mail.gmail.com> <1570781.1704797483@warthog.procyon.org.uk>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix use of Don't Fragment flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1577953.1704809777.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jan 2024 14:16:17 +0000
Message-ID: <1577954.1704809777@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Marc Dionne <marc.dionne@auristor.com> wrote:

> > +{
> > +       if (set)
> > +               ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDIS=
C_DONT);
> > +       else
> > +               ip_sock_set_mtu_discover(local->socket->sk, IP_PMTUDIS=
C_DO);
> > +}
> =

> Shouldn't those be reversed - don't fragment should be IP_PMTUDISC_DO?

Meh.  Yes.

> Also, and this is probably already an issue with current code, I don't
> think this is effective if the socket is V6, which it will be in most
> cases.

Hmmm...  I guess I should tweak IPV6_MTU_DISCOVER also.

David


