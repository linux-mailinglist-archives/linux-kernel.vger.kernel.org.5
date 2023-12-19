Return-Path: <linux-kernel+bounces-4516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2515A817EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1E61C22D24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86AF636;
	Tue, 19 Dec 2023 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aiw8NLPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55810E3;
	Tue, 19 Dec 2023 00:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 687F32E5;
	Tue, 19 Dec 2023 00:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 687F32E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702945246; bh=QBT2MHBx+y5abq1sXonRsiucdEtIv/n+gKwOtgqZBuo=;
	h=From:To:Cc:Subject:Date:From;
	b=aiw8NLPgeOujllSLA3waUlFDJ101gJ/kWdM5r/H2WIeQZPfmc0RE6lj9xZ52nm94C
	 06Db9JgfNR0m34PZfjXwhJez12hj0KMnjxtvY5v6GRCoH9ZKhLGCN5E/y6Mlv3hLEB
	 js8W4OXhoioGHkSjFULBM3vCId9q+hAl7262N6LFoL6EEHatUUGkE93um3fSNjeNe5
	 Cj3BN5LWak1i+MPJX8CO7h19Tn/aLXoiioWlc9VqELpp/Gi5aM2ZISq00dNDvp1AJs
	 KUg4DsqMj9IVIATn2/mJpP6951jjE9UY4C0UIdrz8Ofock1wTiEpbnTOSwrpLF8cPg
	 nzCLPQIOOU+Zg==
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ignore __counted_by attribute in structure definitions
Date: Mon, 18 Dec 2023 17:20:45 -0700
Message-ID: <87le9rjb4y.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel-doc appeared to ignore __counted_by, but appearances can be
deceiving; it caused member names to not be recognized, which manifested as
a number of spurious "Excess struct member" warnings.  Filter that
attribute out and reduce the warning onslaught slightly.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index df158c3a9abc..6acc39c56ac3 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1143,6 +1143,7 @@ sub dump_struct($$) {
 	# strip attributes
 	$members =~ s/\s*$attribute/ /gi;
 	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
+	$members =~ s/\s*__counted_by\s*\([^;]*\)/ /gos;
 	$members =~ s/\s*__packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
 	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
-- 
2.43.0


