Return-Path: <linux-kernel+bounces-103146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B987BB94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37863B21833
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C04D9F8;
	Thu, 14 Mar 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHLBZJ7G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DD5DF26
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413744; cv=none; b=ePjE7L7Qd63zTEHc0n5Lc7LmONzCXls/M/eZKdjlfkg0kYMJE4rC9rwCq6KB3N7Dq7p+TqcMTUFu9yzTdda65VjyDYT9l/JWwpeRJR0UKxYdvkGY4SWRm4Nb7GvJRMSGVKutfw0agK1dgmSx4RCgDerrp9D9iIYTwH72NJ7ZbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413744; c=relaxed/simple;
	bh=ww+Q4Z3TN7Zkf8AUEmHnJJZgYQfS+2qGhI9YQcA66HU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UXmvVX6VTOT2a0Z45lRFTPdiF7AF9f7EBJcA3BsmoZY9DN7MTfOQ9Bq7UF4VDnKUBErioZBOfCFbInaycxtBuGIyBXjhVsBhfoRJQKMHR2xydOWf7MJebYtuWID50wmb38HgaU4Si7S1J79qClrcmql9sGSvZ7oRMNkVWQQFZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHLBZJ7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710413742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gzZJrL9co+94ItPuR1/5KXAlp4bS/UQfJI3lmQi3hg=;
	b=EHLBZJ7G6YEgS5Qdc4B9uKQ5o9xChWUQn5CiFL0OKd1EQKbI9+2VrNRufxnnN3W7lz4bQn
	T7hJdjKtXiXJAsak29CsibZHQfZ1lKVj8W5CxhWq/6k/kRM2qrK1JMuJAIr8wTdk7xbkyu
	2fRcqOXwH8MQ1DtpIP8EUkxkNw/zhhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-mMtlPRr8PrWZv3wqqdl8xw-1; Thu, 14 Mar 2024 06:55:40 -0400
X-MC-Unique: mMtlPRr8PrWZv3wqqdl8xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB07E101A588;
	Thu, 14 Mar 2024 10:55:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95F5E111E3F3;
	Thu, 14 Mar 2024 10:55:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org>
References: <544d7b9d-ef15-463f-a11c-9a3cca3a49ea@infradead.org> <3085695.1710328121@warthog.procyon.org.uk>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Markus Suvanto <markus.suvanto@gmail.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3341491.1710413737.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Mar 2024 10:55:37 +0000
Message-ID: <3341492.1710413737@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Randy Dunlap <rdunlap@infradead.org> wrote:

> > Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/00=
8102html
> =

> Not Found
> =

> The requested URL was not found on this server.

Erm.  Not sure how you came by that.  You lost a dot somehow.  It's in the
original submission:

https://lore.kernel.org/linux-fsdevel/3085695.1710328121@warthog.procyon.o=
rg.uk/

David


