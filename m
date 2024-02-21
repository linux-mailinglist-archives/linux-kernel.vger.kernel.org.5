Return-Path: <linux-kernel+bounces-75056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7174885E23F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3516B25E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38582884;
	Wed, 21 Feb 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mPfWMdlu"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253182869
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531125; cv=none; b=c0cZTJI/3c8d3Mml98M+Yz4emkMMgyTkVXn7HYpnfg60P0YFubWMmxfXpZKkWEC/M28GLRkv2K8eqM5LEYRocX57hbqgakayVEgyuF12TKN7kS1tEXnt6WZJPaG1BdamCDt2s89XIXwdj6q3UywgkNMZUxASj2rqVmQoXHXy1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531125; c=relaxed/simple;
	bh=Nj1mtaX5eAfgwf0WZLLiG/Ms4DFiuQOrm99GPUUsJYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RovgUKSTXz71b0Se0xCVIWp345nZy2xXO/KkbywTuro/kE+x3uFAiH5Rx7zVq1YEKdoV1+9FE+dJn5zC6BntELqA9mTRKKb3yEi5Afyi2suUtpmIx5gfNeACoYSVPDqdFcVkvAS82vmDPtmoHWHmSEPOP02Zq0eF/7Vf/Jhq0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mPfWMdlu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so5546428a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708531123; x=1709135923; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LIWWe2AXJk8XZ9/FCqtCbXVReSA1Du2dj5i3r+vvHk=;
        b=mPfWMdlu4lKgpaWCCwc95Y5nJClBpAoEurNQoSzo4OqlFyu+nAWYfbSjpGPpVp1fJF
         DSnlqL52keBnP1E0UiLWy9ZTr+mTUgGmLsTg5+QXQWHlgN4N8kNDjiPigD3abPi6hoKt
         7ICEk/C2VsnhwefS3zcn5kSk3s6niIjK4eDy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531123; x=1709135923;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LIWWe2AXJk8XZ9/FCqtCbXVReSA1Du2dj5i3r+vvHk=;
        b=P10zFMvd6t6As9wjdP9OS1iru6YaSEgKg4kcuF/ipmiKZYDJhorCK+5SrxPGsdelpq
         l4rpOy10RDnpdtk1CqCCNmoqu38CwRa+ZMDPP5uZ6bREBV4KyILWwI0ZQW6GQWxOZlMi
         wQKXObjWFrF90OeTO5gKYh9fnxoNmtH6oYy0OqccScTv1d3PNO5sBBbxnrG0IUIj6Qdh
         Qc89cMOMYp/cO/MvJzA0Uubc7XAtZQU40Q+NUmatEnmeLxpfsrirS693g//qp5GWUS78
         K6J2ztLSXhlHhIofbTWsa4x0Fg6KxElLnYEJxqYJIAPOUtcK5HnWNVn0qZGqho7teHWb
         WK5A==
X-Forwarded-Encrypted: i=1; AJvYcCXoqEhxuUebMEvlRkP3HmfuJm2SP/gT4/jldF+3ykFJP9Re6jYPm3EkxpE0tubiNS1FsMiNzJj548GjkXtmA2Zqs10qlqDyFBPyk5wh
X-Gm-Message-State: AOJu0YxXM+EWUqcvJ4baKCB64sn9ltkUoFvV3uqNqD2L7RvCyxHqHGJS
	qFlc+ICSL3KRplwrX20OGBfew5vR8Z6Sm0zvZB3jzw6d94FLXAm9GdUZ/gI6iWw=
X-Google-Smtp-Source: AGHT+IEraZJQ0KZ8Ftb1yJdFO06Lcoi5jxU5GoHVGFqg+BCUcYEomQVbUPhFqLtfTnvmTs46iZbhbw==
X-Received: by 2002:a05:6a21:670b:b0:19c:9b7b:66a with SMTP id wh11-20020a056a21670b00b0019c9b7b066amr18671389pzb.49.1708531122923;
        Wed, 21 Feb 2024 07:58:42 -0800 (PST)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm5751327pfb.75.2024.02.21.07.58.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:58:42 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net-next 2/2] netdev-genl: spec: Add ifname to netdev nl YAML spec
Date: Wed, 21 Feb 2024 07:57:30 -0800
Message-Id: <1708531057-67392-3-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add support to netdev netlink spec (netdev.yaml) for the ifname of the net
device.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 tools/include/uapi/linux/netdev.h       |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 3addac9..9a92d04 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -240,6 +240,10 @@ attribute-sets:
              threaded mode. If NAPI is not in threaded mode (i.e. uses normal
              softirq context), the attribute will be absent.
         type: u32
+      -
+        name: ifname
+        doc: name of the netdevice to which NAPI instance belongs.
+        type: string
   -
     name: queue
     attributes:
@@ -264,6 +268,10 @@ attribute-sets:
         name: napi-id
         doc: ID of the NAPI instance which services this queue.
         type: u32
+      -
+        name: ifname
+        doc: name of the netdevice to which the queue belongs.
+        type: string
 
 operations:
   list:
@@ -381,6 +389,7 @@ operations:
             - type
             - napi-id
             - ifindex
+            - ifname
       dump:
         request:
           attributes:
@@ -400,6 +409,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - ifname
       dump:
         request:
           attributes:
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 93cb411..80762bc 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -117,6 +117,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_IFNAME,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
@@ -127,6 +128,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_IFNAME,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
-- 
2.7.4


