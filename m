Return-Path: <linux-kernel+bounces-101425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A287A6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3AA287833
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659E3F9CE;
	Wed, 13 Mar 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gwl5dDsx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59763F9C2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328452; cv=none; b=IP68Z57SaXOXTJEOaWcwzZ3FbPjzgQAxp2NDNS8A3RI731M6Mh4xouzLgJkq+fAVId5lVVdfk8CAGge3hmDOmz1T2AP4hqLa4eVjU0YTMqRg17Gt1hiZp0O2RndsV7SN9niEhUO6+vK10KQ1MlgjId0ObDOp6v+tQjXsJveRSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328452; c=relaxed/simple;
	bh=O2khxfHdkj4ZQ1U0sRtZjb5+p0cWYFEGv5IoGvbXspg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Sn96x2bHxRfG7BtoWm7ewPW3n1dNjnKzfLk2DVSaMtJEzDsWA9q93oQbuBZY8CgfgU/9xQrdJx9JT+BwwIdSN62x8IashWewpvkvv/l0tU4+1Qul74ncBM7dXPB4hhlCLh+wHRaiBIQ+xROfC5Xj6KB8aGMtfCw2bJfqjA+SMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gwl5dDsx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710328449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2khxfHdkj4ZQ1U0sRtZjb5+p0cWYFEGv5IoGvbXspg=;
	b=Gwl5dDsxUPPJSyz2tcN4OK29wOczx4MgV1Uih6QUkXOfE9RDl5/5+vCUf3OAZdj+nrqWyP
	gee80833/6+AWFtp2l1sCArv/Y2O7sulsf0VW2v2WgkiwrlKWDv0QDGAMwByVZgig7O15n
	cbYEKtLMXTlmMVxFqT9slgxp6MBxI7Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-HKb6oDvhMDSFbuQsiL4lFw-1; Wed,
 13 Mar 2024 07:14:04 -0400
X-MC-Unique: HKb6oDvhMDSFbuQsiL4lFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 110723C0DF79;
	Wed, 13 Mar 2024 11:14:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D875C3C23;
	Wed, 13 Mar 2024 11:14:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-2-dhowells@redhat.com>
References: <20240312233723.2984928-2-dhowells@redhat.com> <20240312233723.2984928-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/2] rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3086025.1710328441.1@warthog.procyon.org.uk>
Date: Wed, 13 Mar 2024 11:14:01 +0000
Message-ID: <3086026.1710328441@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Reported-and-tested-by: syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com


