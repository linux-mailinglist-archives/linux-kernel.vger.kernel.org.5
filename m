Return-Path: <linux-kernel+bounces-113484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3858884C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A91B23986
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C81B6771;
	Sun, 24 Mar 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7C9QsC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F91B6750;
	Sun, 24 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320285; cv=none; b=WWj7h0/bAnXqGnrF5s6deEVw1+stWWArlbHLqtfXVaW/EqbTggUnOfztfcm3M8GyB3Lzxs9P7GP1dp1BI8mEZyBPZqEd+Yvzc7Rdr7Tyc5a3aJF9AIDL7XIQGO1JHvdKsy38xfq+iIoU+Hncb8hrqhgoOp5PvFiQPoSjUzGFOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320285; c=relaxed/simple;
	bh=DfOoZsIT4CceyDNQSJzOMOwj8RU1jaP12MR59o7D7JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz0KMzo6VbmNhY9D5DN/tPx6m5/mHLsTgQfSiol4i1nE94jNIkk6hJsfy1dPL/bBSmhsvqquQWrZBMRGyVIARk/X4SflBXuiPngmK3ykhGGWzNRJwHlpT6kcc90hYnw75/RiAZSSgwI+s37l3jJ+y/CG6XjXlhNOYAIGyX9wa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7C9QsC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80552C433F1;
	Sun, 24 Mar 2024 22:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320285;
	bh=DfOoZsIT4CceyDNQSJzOMOwj8RU1jaP12MR59o7D7JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7C9QsC6Wl0EVJeMJe9Ay8zKbLZYWvvTgt6TS+1uj1Suu33bEsmiTE1fC7QcmbmqB
	 aJOnWljpPoOmqLJyqC83bAW/mTuI6s4V7n5aLbuLYWHa0+NVYUY9ClE3go/kMekyx8
	 hVCLETsh3WZss+vAzCgVEq0283jqRhziY7NknmZpR1T9AbwXAVCJmgL4W6qVovY9j5
	 uieuQPwVFp2ZEvk7aYBa6rAnIScpQQjnRD5JsAKGckPdVW68D7qbtFayH0CalFgmET
	 Na1fgQloxbBnlO3I1LjiJEobZG8k/15ACqLIkh8v21LLEMarlSAx0MODBHD3qkKixP
	 Gjz8wh7jGQWDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <kolga@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 593/715] NFSv4.1/pnfs: fix NFS with TLS in pnfs
Date: Sun, 24 Mar 2024 18:32:52 -0400
Message-ID: <20240324223455.1342824-594-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


