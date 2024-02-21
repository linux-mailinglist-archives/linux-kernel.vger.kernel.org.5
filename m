Return-Path: <linux-kernel+bounces-75357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A6885E72E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EB528345E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2357285C6C;
	Wed, 21 Feb 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GEFO73QZ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEB83A06
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543422; cv=none; b=lbITN5sZosf1vqKB/mYcv++1SCQHbLtEnQP/kSRHZkRj2l6BbxtXWlRNRzIsksYEtxfXkvdkoeLmTRThru/W5jm1Vw65boo8qlWzTxQOtrpKKis1PId6G4TGSEKuq/3q8273rc0gpLZ5psXvbEjMlKWZ9AT6S+vlc5W9B0V+J3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543422; c=relaxed/simple;
	bh=1ceNKUywwCEoAqCs1ASSbIdgfL2B77nkwU+nLKa9FBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E53qlmtKhnhlluTZDBxqCrfaCzUMY5Ovy8ociVWiGG+c0VIw8TqLRTc/5hwmsOi9lUGy+HL3E3zG5pZrTRqpG4LHClNlB547lj60d5AVmSoKAtiP4ehCl2cf639qdEyGvo6lDHINlzc+ru6rI61W6QDDRG19uvyVkjvkdZg3WSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GEFO73QZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e32a92e0fdso1767293b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543420; x=1709148220; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eWG5ZMRmXnPGWZYW1R10w1wWwVcifrPihQ/oY2ui5Q=;
        b=GEFO73QZY6UwyX4Gcf9+dOe5T0maPpXWfdFCZITqpupCtbIewdi5CI9jfcQBm7RORA
         2dkFSwiosa+Gn55u3s9fj26HnMMO1OQjq7brhF4psUejeFRDS+fZOeVWlulJ4TSbcdLL
         6AW/MTu9Tl0XAHkf3zdI4vqRu89m2rKFGdQZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543420; x=1709148220;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eWG5ZMRmXnPGWZYW1R10w1wWwVcifrPihQ/oY2ui5Q=;
        b=FAFE9wZqVvIszHx0B022tgboWla5WW+sySjYj2Lqfs25DQbTlLJmKssyLfAGN0yPh8
         3s8Bb4EGxejUnuQ2yIY93xw9bmR8y6c+TZMQt/v1hKj3QVdFFblTuUWTETVhbou2iqaN
         iPTh33pHqbdiWVZ/TxhxQdFOHevnvHKYObKSzKzlH3lAvA+jlMj/mKBzMAdBO8QkMUYK
         kpiGqhNl7/wBtano4GepYRQQaQ76+uuLYeTIpUZ9A+09ekBHZd/dVqz1WM4go9UO//JJ
         xfK8Xbqm67HykxXftcM0JFL0E+w7y9e2TGk1/PDBH0lcaYbORs3Qe7oHy37B+L6nsAX+
         2JaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2gzkq7qZOL9yxsBEomG09zRfYq+k5emEcOy7Z4/euDUkuWd24PHhiGbWV4ctDKflwJtWDjpWipGr7PHpIs9N1XKe42JB0ziTeTmf5
X-Gm-Message-State: AOJu0YxRku0HgNob6zxl+hj0w7MUvsY4EeamqIccXUJLYzlK26g7w6A1
	ru5x5fbuZ2MuauzoEzSXMBrwfWPFJAvzLdd5ABFnS0EvzeFfFnC3hJMD99WwX8o=
X-Google-Smtp-Source: AGHT+IFRBTBr2Nf5+Nb9OU1XMkahZmLQrWTBmw/aLdiyeOF/4U4aisnbQYV7zcbzrKpLjaYDswP/CA==
X-Received: by 2002:a17:90a:2c07:b0:29a:7a6:40fd with SMTP id m7-20020a17090a2c0700b0029a07a640fdmr3334391pjd.49.1708543420235;
        Wed, 21 Feb 2024 11:23:40 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id ns13-20020a17090b250d00b0029a3da37123sm225751pjb.23.2024.02.21.11.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:23:39 -0800 (PST)
Date: Wed, 21 Feb 2024 11:23:37 -0800
From: Joe Damato <jdamato@fastly.com>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <20240221192336.GC68788@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <1708531057-67392-2-git-send-email-jdamato@fastly.com>
 <8d34d621-421b-40bd-98ab-c93783408d74@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d34d621-421b-40bd-98ab-c93783408d74@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:12:47AM -0800, Nambiar, Amritha wrote:
> On 2/21/2024 7:57 AM, Joe Damato wrote:
> >Expose the netdevice name when queue and NAPI netdev-genl APIs are used
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> >---
> >  include/uapi/linux/netdev.h |  2 ++
> >  net/core/netdev-genl.c      | 22 +++++++++++++++++-----
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> >
> >diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> >index 93cb411..80762bc 100644
> >--- a/include/uapi/linux/netdev.h
> >+++ b/include/uapi/linux/netdev.h
> >@@ -117,6 +117,7 @@ enum {
> >  	NETDEV_A_NAPI_ID,
> >  	NETDEV_A_NAPI_IRQ,
> >  	NETDEV_A_NAPI_PID,
> >+	NETDEV_A_NAPI_IFNAME,
> >  	__NETDEV_A_NAPI_MAX,
> >  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> >@@ -127,6 +128,7 @@ enum {
> >  	NETDEV_A_QUEUE_IFINDEX,
> >  	NETDEV_A_QUEUE_TYPE,
> >  	NETDEV_A_QUEUE_NAPI_ID,
> >+	NETDEV_A_QUEUE_IFNAME,
> >  	__NETDEV_A_QUEUE_MAX,
> >  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> >diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> >index fd98936..a886e6a 100644
> >--- a/net/core/netdev-genl.c
> >+++ b/net/core/netdev-genl.c
> >@@ -181,6 +181,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
> >  	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
> >  		goto nla_put_failure;
> >+	if (nla_put_string(rsp, NETDEV_A_NAPI_IFNAME, napi->dev->name))
> >+		goto nla_put_failure;
> >+
> >  	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
> >  		goto nla_put_failure;
> >@@ -307,7 +310,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> >  	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
> >  	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
> >-	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
> >+	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex) ||
> >+	    nla_put_string(rsp, NETDEV_A_QUEUE_IFNAME, netdev->name))
> >  		goto nla_put_failure;
> >  	switch (q_type) {
> >@@ -369,16 +373,19 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
> >  	u32 q_id, q_type, ifindex;
> >  	struct net_device *netdev;
> >  	struct sk_buff *rsp;
> >+	char *ifname;
> >  	int err;
> >  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
> >  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> >-	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> >+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> >+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
> >  		return -EINVAL;
> >  	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
> >  	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
> >  	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> >+	nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
> >  	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> >  	if (!rsp)
> >@@ -387,10 +394,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
> >  	rtnl_lock();
> >  	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> >-	if (netdev)
> >-		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> >-	else
> >+
> >+	if (strcmp(netdev->name, ifname)) {
> >  		err = -ENODEV;
> >+	} else {
> >+		if (netdev)
> >+			err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> >+		else
> >+			err = -ENODEV;
> >+	}
> 
> This looks bit incorrect to me that the netdev is checked after netdev->name
> is accessed. Shouldn't this be something like:
> 
> if (netdev && !strcmp(netdev->name, ifname))
> 	err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> else
> 	err = -ENODEV;

Yes, you are right. Thanks.

Based on Jakub's comment re exposing names, though, it seems that perhaps
this change is not desirable overall.

