Return-Path: <linux-kernel+bounces-150353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA68A9DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A81C2178C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB8716C438;
	Thu, 18 Apr 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="eiHbFnr6"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4016ABD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452287; cv=none; b=q5nXirEOacJHJyD9dC+V2brheqtG16KY7VmRtnLYijslOQNHkClDkXMeX7HFdv0QWfdyFKQ85rwhktKpLZLq8kcrvuVZLWyjIh+Uf82HSCFUtdo5DUoji9GuGnxrF15eyfZsyu5YOMOcR+icG8oX4TVbFszhbtEVBE/yIP2gOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452287; c=relaxed/simple;
	bh=j1OY0T879lcbTo/Rtg5u2e8BORsJdDS072NnPHn0yIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXAA9KwhyZIsne5a23068jaMVOaWmAH5eNhvR/M6GHXfC9cho1rOLAXPR5xFJxFlArsxr/unQwAsnYx81VG1/vC0TY9Sh5V+OzWahIu/Z9GFBB4oO+LDdY5nUHUOgNzc2aL1BW8XqHtJn2uwMyhBVisdXtm/CzRg5ZaR0FMuU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=eiHbFnr6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 55B403F36F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713452274;
	bh=P9cfzGdFw85QMaHvElbpMa0bAXpO82OWeZGP3EPPeSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=eiHbFnr6E+UTkKsoX/mMlubXphA0Q4Q7sMlLl6oEgNrFGtfpjBrFstxgbVk5BUOxf
	 H6+Ix+hAOIMmuA4Roitvw5u0sbeRmmmeL/2iz6Ej/Txy26R5MD/jStbtC/YIb9LbKV
	 fqz+IJ7ZlyN0HXR7PmOtZaV/CE2sVqZVaQ5VqVdHwkrhgn9NiS6K2sPcbiR5JR6jjc
	 9hHBjfc01gB81LChZtYn4kqlsh73MC6AXWkeRMNZtwjxTYF1PAcpoyW/3kJI2oKe2Q
	 tbp9xlJmqWG/R7it4DIewUKSyzclsoE5pcsTBA7vAVe2+tMF9a6l7BBozm+KyTltna
	 YVeU+TKrMk4SA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5193fab7e5so51355466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452274; x=1714057074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9cfzGdFw85QMaHvElbpMa0bAXpO82OWeZGP3EPPeSc=;
        b=XlDTjAyD9hAjjhIBmQ2IoCR+ILcu8Jo7vDtDSzRu+y/+2L7nuluPKpAg9RVpCrc/iR
         REorpAGSk5W7TBbt13dsNcT4JlJYieFlU5wvBUO9en5RdPObP9839npqUxL6WHa5eA1c
         cIJDFo5iDoO07HIEt5ZVNDvWy+lxR6rjuRmlsl15bWLxr9l0IBnk3tYtt6SoJTBIpaxZ
         mhsxM+B6fGpjxdjm5UjYkG3HV/Xg8seEu7Mj1cNMPO1sa+NnXpMJRx+B6heCepwhfAai
         p3waCyB41x6HpYLXrXNqTNSY+8fz/X9nSgZ2nJrdLHzO70ddHfsN7CeT3lyIySoXZy/i
         7N/w==
X-Forwarded-Encrypted: i=1; AJvYcCUTLoi7fymlf2LCApXW++6ITYo+nvWue3zfKxQzokBJ9wM7NDJWMqKTd8OGYpMUPcnTcMuKS6AArzTQoFpFI0o4uHzP07dB11G5Yyik
X-Gm-Message-State: AOJu0YzvOTkzqJ7FNBMbEKd5WiIt2eqAmds6QdD6RU5yG3vGwD9sO00k
	FdVy+xGfex9JWoxCLM5xKj26VZ57l3SS04WmV88+byQtEt3kAdvJnHkSPbgoTIFj2TefDI2sLcR
	66Q+rm6N68i+giNjWTYZ0KNWUruxanGizbqzkVzCJQqFtv0EH+5bUm44i9+nuPbf64IOCsYdf1q
	H+nA==
X-Received: by 2002:a17:906:abc5:b0:a51:ae39:d385 with SMTP id kq5-20020a170906abc500b00a51ae39d385mr2031037ejb.1.1713452274015;
        Thu, 18 Apr 2024 07:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRD732CssEKFMVZ1ag7deR/XTNnVYkFjxEketr3SQgrrRHiOAgZRldqOSxuaIowUAoOABZOQ==
X-Received: by 2002:a17:906:abc5:b0:a51:ae39:d385 with SMTP id kq5-20020a170906abc500b00a51ae39d385mr2031015ejb.1.1713452273632;
        Thu, 18 Apr 2024 07:57:53 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:320c:9c91:fb97:fbfc])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170907985100b00a522a073a64sm993665ejc.187.2024.04.18.07.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:57:53 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Christian Brauner <brauner@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v3 2/2] ipvs: allow some sysctls in non-init user namespaces
Date: Thu, 18 Apr 2024 16:57:43 +0200
Message-Id: <20240418145743.248109-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's make all IPVS sysctls writtable even when
network namespace is owned by non-initial user namespace.

Let's make a few sysctls to be read-only for non-privileged users:
- sync_qlen_max
- sync_sock_size
- run_estimation
- est_cpulist
- est_nice

I'm trying to be conservative with this to prevent
introducing any security issues in there. Maybe,
we can allow more sysctls to be writable, but let's
do this on-demand and when we see real use-case.

This patch is motivated by user request in the LXC
project [1]. Having this can help with running some
Kubernetes [2] or Docker Swarm [3] workloads inside the system
containers.

Link: https://github.com/lxc/lxc/issues/4278 [1]
Link: https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103 [2]
Link: https://github.com/moby/libnetwork/blob/3797618f9a38372e8107d8c06f6ae199e1133ae8/osl/namespace_linux.go#L682 [3]

Cc: Stéphane Graber <stgraber@stgraber.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 32be24f0d4e4..c3ba71aa2654 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4270,6 +4270,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	struct ctl_table *tbl;
 	int idx, ret;
 	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
+	bool unpriv = net->user_ns != &init_user_ns;
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4284,12 +4285,6 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
 		if (tbl == NULL)
 			return -ENOMEM;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns) {
-			tbl[0].procname = NULL;
-			ctl_table_size = 0;
-		}
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
@@ -4315,10 +4310,17 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	ipvs->sysctl_sync_ports = 1;
 	tbl[idx++].data = &ipvs->sysctl_sync_ports;
 	tbl[idx++].data = &ipvs->sysctl_sync_persist_mode;
+
 	ipvs->sysctl_sync_qlen_max = nr_free_buffer_pages() / 32;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx++].data = &ipvs->sysctl_sync_qlen_max;
+
 	ipvs->sysctl_sync_sock_size = 0;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx++].data = &ipvs->sysctl_sync_sock_size;
+
 	tbl[idx++].data = &ipvs->sysctl_cache_bypass;
 	tbl[idx++].data = &ipvs->sysctl_expire_nodest_conn;
 	tbl[idx++].data = &ipvs->sysctl_sloppy_tcp;
@@ -4341,15 +4343,22 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
 	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
 	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
+
 	ipvs->sysctl_run_estimation = 1;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_run_estimation;
 
 	ipvs->est_cpulist_valid = 0;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_cpulist;
 
 	ipvs->sysctl_est_nice = IPVS_EST_NICE;
+	if (unpriv)
+		tbl[idx].mode = 0444;
 	tbl[idx].extra2 = ipvs;
 	tbl[idx++].data = &ipvs->sysctl_est_nice;
 
-- 
2.34.1


