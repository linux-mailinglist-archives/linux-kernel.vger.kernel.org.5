Return-Path: <linux-kernel+bounces-113939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228AD88877B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81050B223C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80221853B;
	Sun, 24 Mar 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd+8VHDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB812C7E3;
	Sun, 24 Mar 2024 22:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321039; cv=none; b=CktIgRbmeWbDM9YS/LC3x7na9mvMDUdHPcMNgjnj0LSDdWcorbKia34s1/JkkM8uqOUuyF1vKcgpmEACQH6NIlsWy358luXKafPNl9f2b0st+hDLIWOmIaGfP7Qi4pjjcsWsRVJJMXnL8Fn51Q+DCK/nDhVIiQXiPEuJ2AnCeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321039; c=relaxed/simple;
	bh=DfOoZsIT4CceyDNQSJzOMOwj8RU1jaP12MR59o7D7JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2TM3cSKji5MsG69KHgxiiy9vxdnRGIAoZNm8NAZ20yrBRjZGqaWzXx5+30x2PByG4J96JfJh8MreFqoZpr2HlVh9I3xN2ipVwytwyW2053VM6MHABpLq45qj7G90S2iEswbyYaH47s3/tcIjIw8jie/R+8NC2F7PDKdbNfyi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nd+8VHDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9DBC433C7;
	Sun, 24 Mar 2024 22:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321038;
	bh=DfOoZsIT4CceyDNQSJzOMOwj8RU1jaP12MR59o7D7JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nd+8VHDmAduSifzTY6kAheldOChZ/bOT+n4TEuJwSeDC5EUKn78/We7L4EHsPi6TH
	 X/dL/hRvQjrBOg+2t2iaYEL8tci9YudEv0KXbCHVQgvLab4Ir40TI/ZG92F9CfoATF
	 35fTh4kY9YNvUBny9AEOfbi8lB9QGdKj9HG7hauqOOYXrEngM415/ojwPAd1GQj16M
	 Vocp2gfU7wE2kl+YKTUyYqWodNPM+AnMkOnWdnT6zTfayGdSU96x4Cd11W3xjme6de
	 YX8pN/gSgP5zRL9tH75DiiS5KyZEPi00GwIs/xgNJD3KdQu7uWSVczlW6DNSzI/ubf
	 x8NX2vNg0e+eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 601/713] NFSv4.1/pnfs: fix NFS with TLS in pnfs
Date: Sun, 24 Mar 2024 18:45:27 -0400
Message-ID: <20240324224720.1345309-602-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

[ Upstream commit a35518cae4b325632840bc8c3aa9ad9bac430038 ]

Currently, even though xprtsec=tls is specified and used for operations
to MDS, any operations that go to DS travel over unencrypted connection.
Or additionally, if more than 1 DS can serve the data, then trunked
connections are also done unencrypted.

IN GETDEVINCEINFO, we get an entry for the DS which carries a protocol
type (which is TCP), then nfs4_set_ds_client() gets called with TCP
instead of TCP with TLS.

Currently, each trunked connection is created and uses clp->cl_hostname
value which if TLS is used would get passed up in the handshake upcall,
but instead we need to pass in the appropriate trunked address value.

Fixes: c8407f2e560c ("NFS: Add an "xprtsec=" NFS mount option")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs_nfs.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index afd23910f3bff..88e061bd711b7 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -919,6 +919,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 	dprintk("--> %s DS %s\n", __func__, ds->ds_remotestr);
 
 	list_for_each_entry(da, &ds->ds_addrs, da_node) {
+		char servername[48];
+
 		dprintk("%s: DS %s: trying address %s\n",
 			__func__, ds->ds_remotestr, da->da_remotestr);
 
@@ -929,6 +931,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.dstaddr = (struct sockaddr *)&da->da_addr,
 				.addrlen = da->da_addrlen,
 				.servername = clp->cl_hostname,
+				.xprtsec = clp->cl_xprtsec,
 			};
 			struct nfs4_add_xprt_data xprtdata = {
 				.clp = clp,
@@ -938,10 +941,45 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
-			if (da->da_transport != clp->cl_proto)
+			if (da->da_transport != clp->cl_proto &&
+					clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
 				continue;
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+				mds_srv->nfs_client->cl_proto ==
+					XPRT_TRANSPORT_TCP_TLS) {
+				struct sockaddr *addr =
+					(struct sockaddr *)&da->da_addr;
+				struct sockaddr_in *sin =
+					(struct sockaddr_in *)&da->da_addr;
+				struct sockaddr_in6 *sin6 =
+					(struct sockaddr_in6 *)&da->da_addr;
+
+				/* for NFS with TLS we need to supply a correct
+				 * servername of the trunked transport, not the
+				 * servername of the main transport stored in
+				 * clp->cl_hostname. And set the protocol to
+				 * indicate to use TLS
+				 */
+				servername[0] = '\0';
+				switch(addr->sa_family) {
+				case AF_INET:
+					snprintf(servername, sizeof(servername),
+						"%pI4", &sin->sin_addr.s_addr);
+					break;
+				case AF_INET6:
+					snprintf(servername, sizeof(servername),
+						"%pI6", &sin6->sin6_addr);
+					break;
+				default:
+					/* do not consider this address */
+					continue;
+				}
+				xprt_args.ident = XPRT_TRANSPORT_TCP_TLS;
+				xprt_args.servername = servername;
+			}
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
+
 			/**
 			* Test this address for session trunking and
 			* add as an alias
@@ -953,6 +991,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			if (xprtdata.cred)
 				put_cred(xprtdata.cred);
 		} else {
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+				mds_srv->nfs_client->cl_proto ==
+					XPRT_TRANSPORT_TCP_TLS)
+				da->da_transport = XPRT_TRANSPORT_TCP_TLS;
 			clp = nfs4_set_ds_client(mds_srv,
 						&da->da_addr,
 						da->da_addrlen,
-- 
2.43.0


