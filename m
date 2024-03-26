Return-Path: <linux-kernel+bounces-118273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C435E88B723
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A291C38476
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A048CDC;
	Tue, 26 Mar 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNLTQWJF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDED18AF4;
	Tue, 26 Mar 2024 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418174; cv=none; b=S7PMdFh2lSsXRo7b69xWM1rSJgoVYnBYdJkR4ublDnP/4QDStB/L5A+9/OteaDGlzJrkc5fXQICyiFr1eilrHD6ki2qEuGisLSkyOo0zU58FyKMdJHLmxJ/BIUVwnGMSTBy8knvN+iCJwnlF17YnV0AfYFacU+EFI69Thh/pdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418174; c=relaxed/simple;
	bh=iGZ1sN109f31IxTk+YNzxIwHJqGr0BjZR34QePejfYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M3/W1col7fKsBzfJ0ZVxmwV7PYPDgFkaIeYPZXAQ7s0rYAzqDLb6nseAoPggV7nwy+ohhydSM5sZ7WPOHnxtqoVU+3FGVS7lh2p40Wty89tanffGNUGn1wv2dBgAPWeo3JhE4NGKcCvvUsh4Hooub4N9XQTy0ikyXXZO6FjBd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNLTQWJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02612C433F1;
	Tue, 26 Mar 2024 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418173;
	bh=iGZ1sN109f31IxTk+YNzxIwHJqGr0BjZR34QePejfYI=;
	h=Date:From:To:Cc:Subject:From;
	b=PNLTQWJFFiL35/jUE6Mm1/bDwDU6OR7LrVQE2t/Hi7I92DvPikyN+iJsGsy4E1Mhd
	 c/hX7mfu0Mh3EBfrZwyXzrq/lgLdJNeZTOL1sxG9Rxf9oK8RiQi/6OkOeTdjMN3CB+
	 6Gk+osvGd2hPffDRh4LiLccPhNLFBvcpQLbZuTldKBruYwqkoPDiBuLP0Wq/SUAw2m
	 1uiOIzT5p8akhHOCMUH82Xcmt2DvjadGZ/DzZnQ8Z47eoef3JWrD/J+nGw9UAcsNzn
	 BdGUuBbDQnGetxNCMQBRhh1oApOoVUPw6OcJHZIlEJt+Gy66A50Fk0oxeHxN7NnJIB
	 lor67tPc7FREg==
Date: Mon, 25 Mar 2024 19:56:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] firewire: Annotate struct fw_iso_packet with
 __counted_by()
Message-ID: <ZgIrOuR3JI/jzqoH@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/firewire.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index dd9f2d765e68..00abe0e5d602 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -463,7 +463,8 @@ struct fw_iso_packet {
 	u32 tag:2;		/* tx: Tag in packet header		*/
 	u32 sy:4;		/* tx: Sy in packet header		*/
 	u32 header_length:8;	/* Length of immediate header		*/
-	u32 header[];		/* tx: Top of 1394 isoch. data_block	*/
+				/* tx: Top of 1394 isoch. data_block    */
+	u32 header[] __counted_by(header_length);
 };
 
 #define FW_ISO_CONTEXT_TRANSMIT			0
-- 
2.34.1


