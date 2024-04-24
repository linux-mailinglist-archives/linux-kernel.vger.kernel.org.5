Return-Path: <linux-kernel+bounces-157016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498248B0B94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A4128506F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7B15E5B0;
	Wed, 24 Apr 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtFH6AJ/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419415E1F3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966878; cv=none; b=Ue8vPUspBCUH9ViE1XD62JJm7+v3dWMQ9aH3iR6iLo+WrbvSRSMfuGN288MGa/otjegtaRbE6C6vde5JthRNck1DZXtd6jWZoRKHsgVer+RZUjAWORsNWMCxVgrXdBKxRgZ++f2D6SDeh/exhbkZAELkfZYLkpra7lel3NYrukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966878; c=relaxed/simple;
	bh=aaAS8vV4wb9QvjU6bclPinSt2ufTufAeAaQH7gzZLTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2vGnqXRKM1A60QnrunAZ4cyQ+DWHc0mYw/d56fRSbqKT5ES2bSGRLVeP75ZxYzbcPt5d8s7VoSChDV5k0e8rV7q65yqcSCBCX5VS9a8XvQ3M42lbCzOxo/hxioZ907j/RHembHur7VAQemxd1R9d9g0Ka3ebbySksYzyJZVcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtFH6AJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmUaRXIMcsJ+dXovFl57XFZEcsYZXt5cyjvVIml/sc4=;
	b=PtFH6AJ/f6c6RSnBZ0ZxWLh2y+ElHbYC9CeKwROKX5qo532060+gxEnpWOuyFl4sLb0zD3
	0/DXPgYctlWzyeo/Jx77MrjZrZv/ZSQpcuBeupdxTbt33oh3jqka7QnZAStSgZenPSdQgX
	x84sciqXq9ffgfYWGD/HygCwqnojBoU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-HJzfv7WJMfWcK7JLXcIesg-1; Wed,
 24 Apr 2024 09:54:33 -0400
X-MC-Unique: HJzfv7WJMfWcK7JLXcIesg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4DDD299E740;
	Wed, 24 Apr 2024 13:54:32 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 218A91C0654B;
	Wed, 24 Apr 2024 13:54:29 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/8] net: netlink: export genl private pointer getters
Date: Wed, 24 Apr 2024 15:50:48 +0200
Message-ID: <20240424135109.3524355-2-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-1-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Both "__genl_sk_priv_get" and "genl_sk_priv_get" are useful functions to
handle private pointers attached to genetlink sockets.
Export them so they can be used in modules.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/netlink/genetlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a116..beafa415a9f5 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -726,6 +726,7 @@ void *__genl_sk_priv_get(struct genl_family *family, struct sock *sk)
 		return ERR_PTR(-EINVAL);
 	return xa_load(family->sock_privs, (unsigned long) sk);
 }
+EXPORT_SYMBOL(__genl_sk_priv_get);
 
 /**
  * genl_sk_priv_get - Get family private pointer for socket
@@ -764,6 +765,7 @@ void *genl_sk_priv_get(struct genl_family *family, struct sock *sk)
 	}
 	return priv;
 }
+EXPORT_SYMBOL(genl_sk_priv_get);
 
 /**
  * genl_register_family - register a generic netlink family
-- 
2.44.0


