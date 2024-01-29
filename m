Return-Path: <linux-kernel+bounces-43147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD1840C66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8A289D45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9007157026;
	Mon, 29 Jan 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaK0e83O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA25155A5F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547168; cv=none; b=RDKpoQT/hFOX0ItP6htoe4NHKL+WmM6noEFDN3h0xD/f28d4ZMrqR2DuumE9R2IUffCnXyBhlmNF6KUjz8GqyzWCD6sLA1tJ5rxZNysGZh68VpDC4c4+ViFwQUCrDYMgXQISIGs8qaTswBlD0kKLN1s76HReRfYMdiU+RYxILFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547168; c=relaxed/simple;
	bh=+2vYmMu+8lO2Fuf970O8rtomflacmswxjDEKbtSt7Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZcn9Gy4OC6QG18/qrMH9rMAd3vVwryRsIldECozktv4PGaz80Fd9qfQVhOhU9CwUXOBdCzbgVCf6wUm27/AgLUHw/Fik/O+D10VqV4jLryaLhJfh3RYXfNJSbsMhPJhd+DcGgKjj6eJsXKPN2DaCKldBkgl45E7FrzHs+h8qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaK0e83O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706547165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joV8o3HwnUOaBbQesaf1wAX+mFWokC/5Mf+L6dXpBsc=;
	b=eaK0e83OlVWfLkIWyuYj+B+dFY7mynUXnAm3bg9lEKm1jZ+t6lIMe2sL+GuzR35hZInmSl
	sduexRoww7o84Th00bUUSfyHhF6EwviuOjlUoDTPxtzydnnoZ9oBU+24QhdwQiATJAIcV3
	JK6zx0ixPkzXbBwzzZJk2xUH85p15so=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-sYseXnQ0PN2DetQoIlmBlg-1; Mon, 29 Jan 2024 11:52:42 -0500
X-MC-Unique: sYseXnQ0PN2DetQoIlmBlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31B4F10AFD6A;
	Mon, 29 Jan 2024 16:52:41 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 43ED92166B31;
	Mon, 29 Jan 2024 16:52:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Anna Schumaker <Anna.Schumaker@Netapp.com>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Date: Mon, 29 Jan 2024 11:52:36 -0500
Message-ID: <7E6930D1-14BC-4CBC-9833-531BF6F5D874@redhat.com>
In-Reply-To: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
References: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 29 Jan 2024, at 11:43, Jeff Layton wrote:

> Alex reported seeing this:
>
>     [   18.238266] ------------[ cut here ]------------
> ...

This one got fixed already, just waiting for a maintainer to send it alon=
g:

https://lore.kernel.org/linux-nfs/20240123053509.3592653-1-samasth.norway=
=2Eananda@oracle.com/

Ben


