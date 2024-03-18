Return-Path: <linux-kernel+bounces-106784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA687F3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8C282CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB515B670;
	Mon, 18 Mar 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnvTf2qb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0735B5B2;
	Mon, 18 Mar 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802836; cv=none; b=g6VEpKEAFGWCpAzVPtNr2t1+UpF3ws1z3tnGMYmREmye2bGog7B1D2WXgtSUTKOEc5oTrwcqx815wGFL6mf3fC/idVWR8X9uBwWoG0slmvY/ai/GONIzsQBnkfiXAoeGOCx4dQctJKrfaI3kAS+ZbMrspWNTeKFv71foPPdNwXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802836; c=relaxed/simple;
	bh=2aJSw72TDhJJtJGSi3sZZ5tt6V0h7mkTLli9U+Gg7Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UsBo/Ab/BzkZu4oBFsj4iMAxUDa6L5QcEc6qjigya+RwqtTdZD5Sxo2XMgja7fYNN8bkeisxxFvaZ3yYCcKYjVDGMPNBF65k6omARgNtcyohGhcA+Znbm7mSosbMA/fKVHYYpSiakL3jF6ZZnF2KewgW3qNPxZ83AWHgf6UMrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnvTf2qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3001C433B2;
	Mon, 18 Mar 2024 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710802836;
	bh=2aJSw72TDhJJtJGSi3sZZ5tt6V0h7mkTLli9U+Gg7Xw=;
	h=Date:From:To:Cc:Subject:From;
	b=FnvTf2qbmOzydEu8kJi0fDnXWES0yeHfdDlw1N0PDEUrcA1Nqt4ix6hw7W+N++ahX
	 ZkkJcjzvM90XpxwcE8dKfSlKreG0c46NTd5n4oTvl3jvps310/VEQNFpsRlLq5MffY
	 /5iN0SvaDXu1j9dZ4yfRx8N6VAswzwyaRrx7b5iaxYd9jfls1xBNv/O2z6Hd/0KA8v
	 1Ctz/9cvdl5GsMyLdvQ/A2yr2eT++XNH0lDVq6Z7WdmfguRFE4W60qJHIhykfWp3qv
	 HoJrYVHnUUujRRqZb4C7xDNs1IGUSEZqHgmcqoWYYODpaUb6kVPQ0S61y3BpJ/6DnX
	 cOBznMF0W+cMw==
Date: Mon, 18 Mar 2024 17:00:33 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] stddef: Introduce struct_group_tagged_attr() helper
 macro
Message-ID: <ZfjHkXJWg12rARKU@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We need a new `struct_group()` helper that allows for both having the
struct be tagged, and specifying struct attributes like `__packed`
or `__align(x)`.

This new helper will initially be used to address
-Wflex-array-member-not-at-end warnings, where a tagged struct is used
to separate the flexible-array member from the rest of the members in
the flexible structure [1]. There are some scenarios in which those
members need to be packed, as well.

So, `struct_group_tagged_attr()` is introduced for this.

Link: https://lore.kernel.org/linux-hardening/ZeIgeZ5Sb0IZTOyt@neat/ [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/stddef.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 929d67710cc5..919df9453257 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -80,6 +80,26 @@ enum {
 #define struct_group_tagged(TAG, NAME, MEMBERS...) \
 	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
 
+/**
+ * struct_group_tagged_attr() - Create a struct_group with a reusable
+ * tag and trailing attributes.
+ *
+ * @TAG: The tag name for the named sub-struct
+ * @NAME: The identifier name of the mirrored sub-struct
+ * @ATTRS: Any struct attributes to apply
+ * @MEMBERS: The member declarations for the mirrored structs
+ *
+ * Used to create an anonymous union of two structs with identical
+ * layout and size: one anonymous and one named. The former can be
+ * used normally without sub-struct naming, and the latter can be
+ * used to reason about the start, end, and size of the group of
+ * struct members. Includes struct tag argument for the named copy,
+ * so the specified layout can be reused later. Also includes
+ * structure attributes argument.
+ */
+#define struct_group_tagged_attr(TAG, NAME, ATTRS, MEMBERS...) \
+	__struct_group(TAG, NAME, ATTRS, MEMBERS)
+
 /**
  * DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
  *
-- 
2.34.1


