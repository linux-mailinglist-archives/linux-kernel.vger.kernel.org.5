Return-Path: <linux-kernel+bounces-88932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B986E89B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1411C22989
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3503A26E;
	Fri,  1 Mar 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2Q7QuqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472013A1B8;
	Fri,  1 Mar 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318461; cv=none; b=K8mz0Oi3O1J86hdtT0evJ6kq8Yda+UMJkAs/ZUg4jrnnjk2hqc1e0RX6RkQCHElLCNuy2rzAT7h/ydz0/ZzNBkSlsnNR4mqmcSNmoSLaEjwyoDfQIv+uEd0w3hlk3D25EZ+Yr8Uq+512w0kLB7Mxv6T7a2gkBLgwiHSUXA/Pqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318461; c=relaxed/simple;
	bh=Ikr2dasxWHE+lNItweXLpqVfoJa5a0SH5QW2mOtObok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jh9XS/DYOMrEhFsbR5flfTktrim36iJJbDuQDrn7K1WlFJ7lzf5xjVt/YbNufEf1nATc4RBMlMXBMl+RmMVm1hy/NQoMpoopriqG8tyNW3LxjaxgrqzRX6Or7YQdPe7yfJzgEi30HXvX7Yz9TPJD47+4X26EqFELaF7/k956WKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2Q7QuqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AF6C433C7;
	Fri,  1 Mar 2024 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709318460;
	bh=Ikr2dasxWHE+lNItweXLpqVfoJa5a0SH5QW2mOtObok=;
	h=Date:From:To:Cc:Subject:From;
	b=r2Q7QuqWR02YX4BwJB96aQVS8C1pgLZiSKZF52iPU96KkxawAS/eKf60dMe8iqlpp
	 lP9HwlYIXAV7fWehnNcLTi9cfxjGuCNxXRtBQg7Sj00O74QryCsKDTyo3Cemna8cn8
	 7VDDvZuAV5pSUH7h3AUAW9UwrxnwS5uQ98PScqKFmqDUddsW6c4BE77RE1a01qlUO9
	 dh801ZgPnZFzcZqmn+GTGogZvPty6zapDZ2h9FtkLPKyWreeZBVdiN73HQSxxEwprO
	 nUz6817YY4RHzPLDdoDn5JLxVzOp7JePcQ/c95z1MhJrmpY5/2s8YclcCD4iPJ3kTu
	 HTHaFQbnIGYhA==
Date: Fri, 1 Mar 2024 12:40:57 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <ZeIhOT44ON5rjPiP@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

There are currently a couple of objects in `struct smc_clc_msg_proposal_area`
that contain a couple of flexible structures:

struct smc_clc_msg_proposal_area {
	...
	struct smc_clc_v2_extension             pclc_v2_ext;
	...
	struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
	...
};

So, in order to avoid ending up with a couple of flexible-array members
in the middle of a struct, we use the `struct_group_tagged()` helper to
separate the flexible array from the rest of the members in the flexible
structure:

struct smc_clc_smcd_v2_extension {
        struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
                            u8 system_eid[SMC_MAX_EID_LEN];
                            u8 reserved[16];
        );
        struct smc_clc_smcd_gid_chid gidchid[];
};

With the change described above, we now declare objects of the type of
the tagged struct without embedding flexible arrays in the middle of
another struct:

struct smc_clc_msg_proposal_area {
        ...
        struct smc_clc_v2_extension_hdr		pclc_v2_ext;
        ...
        struct smc_clc_smcd_v2_extension_hdr	pclc_smcd_v2_ext;
        ...
};

We also use `container_of()` when we need to retrieve a pointer to the
flexible structures.

So, with these changes, fix the following warnings:

In file included from net/smc/af_smc.c:42:
net/smc/smc_clc.h:186:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  186 |         struct smc_clc_v2_extension             pclc_v2_ext;
      |                                                 ^~~~~~~~~~~
net/smc/smc_clc.h:188:49: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
  188 |         struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
      |                                                 ^~~~~~~~~~~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/smc/smc_clc.c |  5 +++--
 net/smc/smc_clc.h | 24 ++++++++++++++----------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index e55026c7529c..3094cfa1c458 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	pclc_smcd = &pclc->pclc_smcd;
 	pclc_prfx = &pclc->pclc_prfx;
 	ipv6_prfx = pclc->pclc_prfx_ipv6;
-	v2_ext = &pclc->pclc_v2_ext;
-	smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
+	v2_ext = container_of(&pclc->pclc_v2_ext, struct smc_clc_v2_extension, _hdr);
+	smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
+				   struct smc_clc_smcd_v2_extension, hdr);
 	gidchids = pclc->pclc_gidchids;
 	trl = &pclc->pclc_trl;
 
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 7cc7070b9772..5b91a1947078 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
 			 */
 
 struct smc_clc_v2_extension {
-	struct smc_clnt_opts_area_hdr hdr;
-	u8 roce[16];		/* RoCEv2 GID */
-	u8 max_conns;
-	u8 max_links;
-	__be16 feature_mask;
-	u8 reserved[12];
+	struct_group_tagged(smc_clc_v2_extension_hdr, _hdr,
+		struct smc_clnt_opts_area_hdr hdr;
+		u8 roce[16];		/* RoCEv2 GID */
+		u8 max_conns;
+		u8 max_links;
+		__be16 feature_mask;
+		u8 reserved[12];
+	);
 	u8 user_eids[][SMC_MAX_EID_LEN];
 };
 
@@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {	/* SMC-D GID information */
 };
 
 struct smc_clc_smcd_v2_extension {
-	u8 system_eid[SMC_MAX_EID_LEN];
-	u8 reserved[16];
+	struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
+		u8 system_eid[SMC_MAX_EID_LEN];
+		u8 reserved[16];
+	);
 	struct smc_clc_smcd_gid_chid gidchid[];
 };
 
@@ -183,9 +187,9 @@ struct smc_clc_msg_proposal_area {
 	struct smc_clc_msg_smcd			pclc_smcd;
 	struct smc_clc_msg_proposal_prefix	pclc_prfx;
 	struct smc_clc_ipv6_prefix	pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
-	struct smc_clc_v2_extension		pclc_v2_ext;
+	struct smc_clc_v2_extension_hdr		pclc_v2_ext;
 	u8			user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
-	struct smc_clc_smcd_v2_extension	pclc_smcd_v2_ext;
+	struct smc_clc_smcd_v2_extension_hdr	pclc_smcd_v2_ext;
 	struct smc_clc_smcd_gid_chid
 				pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
 	struct smc_clc_msg_trail		pclc_trl;
-- 
2.34.1


