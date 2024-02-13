Return-Path: <linux-kernel+bounces-63604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9585321A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6991F23280
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C25645E;
	Tue, 13 Feb 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YR6qnwhC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6632633989
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831671; cv=none; b=Xzw3765erNEiuDNm/mkpPbRBPkiDYo/fJNw6S5LJeoN5kE9hShSS3lwUPu2IfOPoKMkCII5FAHJYziFg/IMNKjdyjC0IFy2xGQiuR9g+9q1/MI95VrR/Q8pbr/US7flu99sf1fYv8p53QbYk5ZAiMt3mmvRuHSMT2uaXO1eV4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831671; c=relaxed/simple;
	bh=vKmLuetPiqwNK/NvBA+xm8qgL06cnvFOrzu8BOu3TPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZDahAMLLLXbN5MqLaiYEvjwfBT5MxgXJzCkQK1lLsIk6kFsaKeL532bAvp+MfD7L75K2tUB+DbzYbzhwtbU/v85vJNUZb+1u4acOtMyqUyeHUmWPPjxbvYCyCmOmCrwY3NUIDUTQe9YUw29w1W4DZ9szm0ni7Sr65rzfmjDe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YR6qnwhC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707831669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sM9EeqHVbPE97OjydZplmGb04tZWIE1q6qjGihVxaso=;
	b=YR6qnwhCGfhpOsjVrPDDpFl3C+W3cgFFkgA/OR1XuoKGhcK2NHd2oIOtFpJ1FTnBae+QI+
	OOiJH1VjEJZzvQh0Xv+iJQ+kTqzfXGqhaP+DnEgzuKVLWgYy3WcSfbm7YjFVwTZXCY8U6I
	gl5SNiYJD8RcOIrUFl1qtLt2MigiYAc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-hNx1xmGJOOaE7aWHnwhkNA-1; Tue, 13 Feb 2024 08:41:07 -0500
X-MC-Unique: hNx1xmGJOOaE7aWHnwhkNA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e04e1ac036so5776355b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831666; x=1708436466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM9EeqHVbPE97OjydZplmGb04tZWIE1q6qjGihVxaso=;
        b=LZowseIsxd80aB/mrZ8rw/8e7sHBLvpcAE+nd5S6Y+I1qNvdVCdujnAoW5abAGUyyJ
         NUFm7PRDUNstHIFoCerrUXhkWR4KyQ21yEe5sQTpEjILWWpWi8lTMxTmHy7abTbFeDmN
         rGVI8x/5bO/1B4dlW2rIwevVzO5DHMAb6s3V89LPci6lOYO7K8JyZs7h48pY8xJob9Y4
         woUAq6L7bpQ46B6M08IwsWGQ3LcQTpTn7MPluNExxcVLz6XVJSt/iqdNVsIxHPK2GhAE
         AaPxQnxalDK05zjHobfXcTz1pC8PjRBquXWzDAgFEwMDYpOfPLjy9UWxw/Ter+g0Z/8J
         B6gw==
X-Forwarded-Encrypted: i=1; AJvYcCXJFbQFgjtMPMGTqnaz6vaYHENDKS5NiEdE1tInYXtkhz9cByNrwx8Vzhd47iIYJUijyNT6cGTCqGuF+14ag4Nz1uuyvc16+zw5kw5Q
X-Gm-Message-State: AOJu0Yz/okAqR7G72IvUidkJBlmsipPQ3gU4YlpHESS4omeCb84wF/56
	x3REojvutmztyANVgIrvSks2KNN7aetZ/tLyxbSigr8gnuJma5cQ6bTUQLmbYKppRJ+FLMRrFpm
	8NiaGY2ysarXEFE3WAUWte8iKE/GefFD4gquuLyvketKOOsl1veohfqgVyBX0Dg==
X-Received: by 2002:a05:6a20:c707:b0:19c:a4d3:2041 with SMTP id hi7-20020a056a20c70700b0019ca4d32041mr15569188pzb.42.1707831666686;
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcyeBaNRft6IVSe6YFMBp5QkjLKlFRhM30jbFV2dNHxXXjhh0TOmx3zAxp+5APBQ1oR9mU/A==
X-Received: by 2002:a05:6a20:c707:b0:19c:a4d3:2041 with SMTP id hi7-20020a056a20c70700b0019ca4d32041mr15569171pzb.42.1707831666433;
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPTpsWr88UqwU41Z/VTHCIQBM+G9Y3MSqC3XMWud5NWsOT2+3tszlERKJZO40rLdaH+zJf58/ZX30Bj/62Zv3cA7vVUzL6cLbiOUpTZtrqKq8GMYiP2ETfbtEIh44xzUAQob+BBd4EkxlLNm8U0YpDs1sLrry3sBtUiwReJmph18iVFoQDrF6RAywt4drK+lu1t3kDIWlYmjh9e9oMtQLgwDLIH5+aXXhLk0hugAdcIdBNssLXSgE8HABS0E+dXQXgX3alJfWcmjJo6IXDF0AXXI8tZxEmax4FwAfgaPNGJzMVd7k1dKHYyjVQqzis
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id p39-20020a056a0026e700b006e0f3f544fcsm1932208pfw.67.2024.02.13.05.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:41:06 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Cleanup tipc_nl_bearer_add() error paths
Date: Tue, 13 Feb 2024 22:40:58 +0900
Message-ID: <20240213134058.386123-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the error paths of tipc_nl_bearer_add() under the common label
if the function holds rtnl_lock.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/bearer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 878415c43527..5a526ebafeb4 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1079,30 +1079,27 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 	b = tipc_bearer_find(net, name);
 	if (!b) {
-		rtnl_unlock();
 		NL_SET_ERR_MSG(info->extack, "Bearer not found");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
 		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
-			rtnl_unlock();
 			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
-		if (err) {
-			rtnl_unlock();
-			return err;
-		}
 	}
 #endif
+out:
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 int __tipc_nl_bearer_set(struct sk_buff *skb, struct genl_info *info)
-- 
2.43.0


