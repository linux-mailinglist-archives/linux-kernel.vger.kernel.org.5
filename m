Return-Path: <linux-kernel+bounces-123957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C7891049
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D361F23988
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB617576;
	Fri, 29 Mar 2024 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0YWHh//"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E9182A1;
	Fri, 29 Mar 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675033; cv=none; b=o3MMisr/ySLX4dquHPvWy/wT+GZ0oXRlLSPd47N4hsC7hpA/1z8PkXVLNIuHOxeT05Yf5mz7bcxaDHfeMQ5FKgy2lrwQlHgMs5XwJV20YGZf3jOqVARRanj2nGAuvPF/ko/MDU/DbzXn03M820dSnfgOw9qLk/IYPmweVG3CfsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675033; c=relaxed/simple;
	bh=FQOJmc3RP5qo7PvSrDXdOr1t0lGnOQ2RBwsLYcYqg0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SgNySf0ToJ5J+w5JfJ+wEU6PzMcrWqK24sRORDP4heGb6dH8jUjwlbSCtkFPUtxh/beRscNLp2sb/P/WLAFBqqw8mR6oK0jgcvERRbfa3wJPMr+HAQLT63wO1PIRSvNPQAZ04XgaayloJYi4akwdcw/QrwFah0EeUiXSpTZD0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0YWHh//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D286C433C7;
	Fri, 29 Mar 2024 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711675033;
	bh=FQOJmc3RP5qo7PvSrDXdOr1t0lGnOQ2RBwsLYcYqg0Y=;
	h=Date:From:To:Cc:Subject:From;
	b=q0YWHh//0/72nkgadlyiqYPLVgH5OM8r6mEfFSrhhir7OM+B3mHpRaCGtxzcoqEyw
	 uwUHKH7lXZ0iQrbr538QPbWCAB6NISIJwvYr1TjJ3JDoOPZnDuCQMWpvNukAIUfNyS
	 y9OvwhpgDVgrkvx0Y47mmKCooR0C5zrzYY68oOS71XU96OWMcCClzJ0ci+Eaqy9NGg
	 KCy3KDFQ4kRoJESMOdl3Q0Du2z4G5tJPj5ulrBXsnoV1NPt9tMedVwJOw8Z88bFyJs
	 h4uk17bgVXAuWa9mGezjANAQscXUVFoqjQ+2AcZ9xxoPCUZ+f6NYC+QFiAH42bel95
	 NEcDRsKFnOGsQ==
Date: Thu, 28 Mar 2024 19:17:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] nfp: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <ZgYWlkxdrrieDYIu@neat>
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

There is currently an object (`tl`), at the beginning of multiple
structures, that contains a flexible structure (`struct nfp_dump_tl`),
for example:

struct nfp_dumpspec_csr {
        struct nfp_dump_tl tl;

        ...

        __be32 register_width;  /* in bits */
};

So, in order to avoid ending up with flexible-array members in the
middle of multiple other structs, we use the `struct_group_tagged()`
helper to separate the flexible array from the rest of the members
in the flexible structure:

struct nfp_dump_tl {
	struct_group_tagged(nfp_dump_tl_hdr, hdr,

	... the rest of members

	);
        char data[];
};

With the change described above, we now declare objects of the type of
the tagged struct, in this case `struct nfp_dump_tl_hdr`, without
embedding flexible arrays in the middle of another struct:

struct nfp_dumpspec_csr {
        struct nfp_dump_tl_hdr tl;

	...

        __be32 register_width;  /* in bits */
};

Also, use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible
array if needed.

So, with these changes, fix 33 of the following warnings:
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:58:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:64:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:70:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:78:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:87:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:92:28: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Link: https://github.com/KSPP/linux/issues/202
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../netronome/nfp/nfp_net_debugdump.c         | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
index a614df095b08..2dd37557185e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c
@@ -34,8 +34,11 @@ enum nfp_dumpspec_type {
 
 /* generic type plus length */
 struct nfp_dump_tl {
-	__be32 type;
-	__be32 length;	/* chunk length to follow, aligned to 8 bytes */
+	/* New members must be added within the struct_group() macro below. */
+	struct_group_tagged(nfp_dump_tl_hdr, hdr,
+		__be32 type;
+		__be32 length;	/* chunk length to follow, aligned to 8 bytes */
+	);
 	char data[];
 };
 
@@ -55,19 +58,19 @@ struct nfp_dump_common_cpp {
 
 /* CSR dumpables */
 struct nfp_dumpspec_csr {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	struct nfp_dump_common_cpp cpp;
 	__be32 register_width;	/* in bits */
 };
 
 struct nfp_dumpspec_rtsym {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	char rtsym[];
 };
 
 /* header for register dumpable */
 struct nfp_dump_csr {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	struct nfp_dump_common_cpp cpp;
 	__be32 register_width;	/* in bits */
 	__be32 error;		/* error code encountered while reading */
@@ -75,7 +78,7 @@ struct nfp_dump_csr {
 };
 
 struct nfp_dump_rtsym {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	struct nfp_dump_common_cpp cpp;
 	__be32 error;		/* error code encountered while reading */
 	u8 padded_name_length;	/* pad so data starts at 8 byte boundary */
@@ -84,12 +87,12 @@ struct nfp_dump_rtsym {
 };
 
 struct nfp_dump_prolog {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	__be32 dump_level;
 };
 
 struct nfp_dump_error {
-	struct nfp_dump_tl tl;
+	struct nfp_dump_tl_hdr tl;
 	__be32 error;
 	char padding[4];
 	char spec[];
@@ -449,6 +452,8 @@ static int
 nfp_dump_csr_range(struct nfp_pf *pf, struct nfp_dumpspec_csr *spec_csr,
 		   struct nfp_dump_state *dump)
 {
+	struct nfp_dump_tl *spec_csr_tl =
+			container_of(&spec_csr->tl, struct nfp_dump_tl, hdr);
 	struct nfp_dump_csr *dump_header = dump->p;
 	u32 reg_sz, header_size, total_size;
 	u32 cpp_rd_addr, max_rd_addr;
@@ -458,7 +463,7 @@ nfp_dump_csr_range(struct nfp_pf *pf, struct nfp_dumpspec_csr *spec_csr,
 	int err;
 
 	if (!nfp_csr_spec_valid(spec_csr))
-		return nfp_dump_error_tlv(&spec_csr->tl, -EINVAL, dump);
+		return nfp_dump_error_tlv(spec_csr_tl, -EINVAL, dump);
 
 	reg_sz = be32_to_cpu(spec_csr->register_width) / BITS_PER_BYTE;
 	header_size = ALIGN8(sizeof(*dump_header));
@@ -466,7 +471,7 @@ nfp_dump_csr_range(struct nfp_pf *pf, struct nfp_dumpspec_csr *spec_csr,
 		     ALIGN8(be32_to_cpu(spec_csr->cpp.dump_length));
 	dest = dump->p + header_size;
 
-	err = nfp_add_tlv(be32_to_cpu(spec_csr->tl.type), total_size, dump);
+	err = nfp_add_tlv(be32_to_cpu(spec_csr_tl->type), total_size, dump);
 	if (err)
 		return err;
 
@@ -552,6 +557,8 @@ nfp_dump_indirect_csr_range(struct nfp_pf *pf,
 			    struct nfp_dumpspec_csr *spec_csr,
 			    struct nfp_dump_state *dump)
 {
+	struct nfp_dump_tl *spec_csr_tl =
+			container_of(&spec_csr->tl, struct nfp_dump_tl, hdr);
 	struct nfp_dump_csr *dump_header = dump->p;
 	u32 reg_sz, header_size, total_size;
 	u32 cpp_rd_addr, max_rd_addr;
@@ -560,7 +567,7 @@ nfp_dump_indirect_csr_range(struct nfp_pf *pf,
 	int err;
 
 	if (!nfp_csr_spec_valid(spec_csr))
-		return nfp_dump_error_tlv(&spec_csr->tl, -EINVAL, dump);
+		return nfp_dump_error_tlv(spec_csr_tl, -EINVAL, dump);
 
 	reg_sz = be32_to_cpu(spec_csr->register_width) / BITS_PER_BYTE;
 	header_size = ALIGN8(sizeof(*dump_header));
@@ -569,7 +576,7 @@ nfp_dump_indirect_csr_range(struct nfp_pf *pf,
 	total_size = header_size + ALIGN8(reg_data_length);
 	dest = dump->p + header_size;
 
-	err = nfp_add_tlv(be32_to_cpu(spec_csr->tl.type), total_size, dump);
+	err = nfp_add_tlv(be32_to_cpu(spec_csr_tl->type), total_size, dump);
 	if (err)
 		return err;
 
@@ -597,6 +604,8 @@ static int
 nfp_dump_single_rtsym(struct nfp_pf *pf, struct nfp_dumpspec_rtsym *spec,
 		      struct nfp_dump_state *dump)
 {
+	struct nfp_dump_tl *spec_tl =
+			container_of(&spec->tl, struct nfp_dump_tl, hdr);
 	struct nfp_dump_rtsym *dump_header = dump->p;
 	struct nfp_dumpspec_cpp_isl_id cpp_params;
 	struct nfp_rtsym_table *rtbl = pf->rtbl;
@@ -607,14 +616,14 @@ nfp_dump_single_rtsym(struct nfp_pf *pf, struct nfp_dumpspec_rtsym *spec,
 	void *dest;
 	int err;
 
-	tl_len = be32_to_cpu(spec->tl.length);
+	tl_len = be32_to_cpu(spec_tl->length);
 	key_len = strnlen(spec->rtsym, tl_len);
 	if (key_len == tl_len)
-		return nfp_dump_error_tlv(&spec->tl, -EINVAL, dump);
+		return nfp_dump_error_tlv(spec_tl, -EINVAL, dump);
 
 	sym = nfp_rtsym_lookup(rtbl, spec->rtsym);
 	if (!sym)
-		return nfp_dump_error_tlv(&spec->tl, -ENOENT, dump);
+		return nfp_dump_error_tlv(spec_tl, -ENOENT, dump);
 
 	sym_size = nfp_rtsym_size(sym);
 	header_size =
@@ -622,7 +631,7 @@ nfp_dump_single_rtsym(struct nfp_pf *pf, struct nfp_dumpspec_rtsym *spec,
 	total_size = header_size + ALIGN8(sym_size);
 	dest = dump->p + header_size;
 
-	err = nfp_add_tlv(be32_to_cpu(spec->tl.type), total_size, dump);
+	err = nfp_add_tlv(be32_to_cpu(spec_tl->type), total_size, dump);
 	if (err)
 		return err;
 
-- 
2.34.1


