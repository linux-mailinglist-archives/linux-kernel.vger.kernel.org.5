Return-Path: <linux-kernel+bounces-26390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AF82DFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83661F22DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD60B18AE1;
	Mon, 15 Jan 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BnsxUfbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A984182A0;
	Mon, 15 Jan 2024 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E45C433F1;
	Mon, 15 Jan 2024 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705343433;
	bh=i5aXjENm8OS07Sno/Jr/EWzHGI19BtBU22v84a1QT2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnsxUfbABTF+609BZ/UmxGGxFqIQsnuEL1jRwznEzhpNRoD19h51s/NDkVJoL7JrD
	 vwZ9Yc/lRqKbL7JvLP4emvFdJHAATvEvF21yujaSbUmQJXFmQamCOQ+pRaZBSs2W+h
	 wmZKEXZHjPDQRGqqcLTRnRVRsX/sVNmI5I6UlbQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.12
Date: Mon, 15 Jan 2024 19:30:22 +0100
Message-ID: <2024011522-kilogram-dry-a219@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024011521-herbicide-shun-187e@gregkh>
References: <2024011521-herbicide-shun-187e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 43edafa7f262..a05c69afc045 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 98854dd3c150..a13e81e45071 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -692,6 +692,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	char *mesg = buf;
 	int fd, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	err = get_int(&mesg, &fd);
 	if (err != 0 || fd < 0)
@@ -702,15 +703,15 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	if (err != 0)
 		return err;
 
-	err = svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
+	serv = nn->nfsd_serv;
+	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (err < 0 && !serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
-	else if (err >= 0 &&
-		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	else if (err >= 0 && !serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
@@ -724,6 +725,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	struct svc_xprt *xprt;
 	int port, err;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	if (sscanf(buf, "%15s %5u", transport, &port) != 2)
 		return -EINVAL;
@@ -736,32 +738,33 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 	if (err != 0)
 		return err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	serv = nn->nfsd_serv;
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0)
 		goto out_err;
 
-	err = svc_xprt_create(nn->nfsd_serv, transport, net,
+	err = svc_xprt_create(serv, transport, net,
 			      PF_INET6, port, SVC_SOCK_ANONYMOUS, cred);
 	if (err < 0 && err != -EAFNOSUPPORT)
 		goto out_close;
 
-	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
-		svc_get(nn->nfsd_serv);
+	if (!serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
+		svc_get(serv);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return 0;
 out_close:
-	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
+	xprt = svc_find_xprt(serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
 		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
+	if (!serv->sv_nrthreads && !nn->keep_active)
 		nfsd_last_thread(net);
 
-	nfsd_put(net);
+	svc_put(serv);
 	return err;
 }
 
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 63deed27a905..fe846a360ae1 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -96,13 +96,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-static inline void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	svc_put(nn->nfsd_serv);
-}
-
 bool		i_am_nfsd(void);
 
 struct nfsdfs_client {

