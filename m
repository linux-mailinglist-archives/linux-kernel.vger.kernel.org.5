Return-Path: <linux-kernel+bounces-71550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4585A6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826A8285F04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332C41C85;
	Mon, 19 Feb 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCzLdHA7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2741C78
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355208; cv=none; b=UHaQkCPwe86UDQz8LKIGmS5sQ/b+rbkuOy26kvpQS3aAPQFKgXHHuHANLp5lNW728VP1u2xB8IRON2co/rzlgVwD7ULE3cJ7jHh0+YeZns0JN53WAj0sNIOcuQlEbS7rnenVB13HEFncJr2cyvUNSnIe9gS6PP1bWkV8RZWx+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355208; c=relaxed/simple;
	bh=wugezZjVe6UgAzwGzvshOR+TV29UxTPSM7V6CCpV2WY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=t5IrzyIRhcH38QtvaqPFnQu/GuNkgrVhQrpowGMFlOG9N4gu0lBfnQ+du0QMXZryoQOOx79cKsW/uwF8GWy6mB28gxDqfLtAeD6LQ6EkqGb1dMVopH4RlOkKAT65eRcHPyU/iJAD/gUz/ELEddpM/jfg+uL3Kvn7WJlLKnFbaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCzLdHA7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708355205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vFCiJ6818JOoFEUYfbT4Q/AOpM96O17V3Tb55o233+4=;
	b=PCzLdHA7nPr3RQfY/ecMk56B6/+AL77OoCaw8b3pDz/cx6+FRG6d/08QAs9htnpwVFEaxw
	4+RW/asXjKWamnJs6fGuHj1VkYpL1UyAIkpNWcoHGr1r8eN2DGRbyl4j/GvSbG0NmoX++Z
	4xulmkZQ7074WUPs0wkhYW79vspN2vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-eNmBTw3xMj6jNyDE7RWv_g-1; Mon, 19 Feb 2024 10:06:41 -0500
X-MC-Unique: eNmBTw3xMj6jNyDE7RWv_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D214886460;
	Mon, 19 Feb 2024 15:06:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 319C0492BE2;
	Mon, 19 Feb 2024 15:06:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240209105251.GE1516992@kernel.org>
References: <20240209105251.GE1516992@kernel.org> <20240205225726.3104808-1-dhowells@redhat.com> <20240205225726.3104808-10-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <140404.1708355197.1@warthog.procyon.org.uk>
Date: Mon, 19 Feb 2024 15:06:37 +0000
Message-ID: <140405.1708355197@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Simon Horman <horms@kernel.org> wrote:

> However, the code below this hunk, other than being guarded by
> smb3_use_rdma_offload(io_parms), uses rdata unconditionally.

Yeah - it does that even without my patches.  SMB2_read() can call the
function with rdata == NULL, but I'm unsure as to whether the RDMA branch will
ever be used except for actual reads - in which case rdata will not be NULL at
the "rdata->mr" point.

David


