Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820417B6571
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjJCJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJCJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:26:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908C90;
        Tue,  3 Oct 2023 02:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 545BF1F38C;
        Tue,  3 Oct 2023 09:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696325204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oR2Cus9Dqvx9U5F+1mIeftFSocmSFSSuTB1SHePx4x0=;
        b=XKjk5OQpgS6y31Rualy43b3vdr/EHVUqIrKbL4elqUv70tJEjP7JsQVDzPq24ICQWuYYiu
        9DnlLOSj2Ffi+3GjHtrcv7nZa387azcLIxauv+XGGkb/WRY+sgDC8c/P7TEEkonosMIcaL
        AgtARRb7T3Mg/tDn3SnQUmXsl1tvTN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696325204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oR2Cus9Dqvx9U5F+1mIeftFSocmSFSSuTB1SHePx4x0=;
        b=YR+ytWIKBOG8TlecSHsiVbP9OBvtoIomsorHVeOytFtHS2WrL+crqP6Fl9fFmZv4bs0Zb+
        ARQdgJxnPWWCgxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40A84139F9;
        Tue,  3 Oct 2023 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yS7ED1TeG2UVTAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 09:26:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A3DFAA0830; Tue,  3 Oct 2023 11:26:43 +0200 (CEST)
Date:   Tue, 3 Oct 2023 11:26:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix undefined behavior bug in struct
 udf_fileident_iter
Message-ID: <20231003092643.yw5zrzthbylgy5vr@quack3>
References: <ZRrsYkKIQe8K6F/t@work>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5qervm7vaqjfditc"
Content-Disposition: inline
In-Reply-To: <ZRrsYkKIQe8K6F/t@work>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5qervm7vaqjfditc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 02-10-23 18:14:26, Gustavo A. R. Silva wrote:
> `struct fileIdentDesc` is a flexible structure, which means that it
> contains a flexible-array member at the bottom. This could potentially
> lead to an overwrite of the objects following `fi` in `struct
> udf_fileident_iter` at run-time.
> 
> Fix this by placing the declaration of object `fi` at the end of
> `struct udf_fileident_iter`.
> 
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Fixes: d16076d9b684 ("udf: New directory iteration code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks for the patch! This is in fact harmless since we never use the
impUse field. But I agree it is confusing so I'll merge attached fix
instead.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--5qervm7vaqjfditc
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-udf-Avoid-unneeded-variable-length-array-in-struct-f.patch"

From 7b530e7ad261dc6111874f2225c2f38f63d12ebf Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 3 Oct 2023 11:19:02 +0200
Subject: [PATCH] udf: Avoid unneeded variable length array in struct
 fileIdentDesc

impUse variable length array in struct fileIdentDesc is never used.
It serves only for documentation purposes of the on-disk format. Remove
it from the struct so that it doesn't confuse the compiler and
reviewers.

Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/ecma_167.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index de17a97e8667..415b050b977d 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -471,7 +471,7 @@ struct fileIdentDesc {
 	uint8_t		lengthFileIdent;
 	struct long_ad	icb;
 	__le16		lengthOfImpUse;
-	uint8_t		impUse[];
+	/* uint8_t	impUse[]; */
 	/* uint8_t	fileIdent[]; */
 	/* uint8_t	padding[]; */
 } __packed;
-- 
2.35.3


--5qervm7vaqjfditc--
