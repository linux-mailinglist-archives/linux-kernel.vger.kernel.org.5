Return-Path: <linux-kernel+bounces-12877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C764681FBFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F17DB23BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABA10A11;
	Thu, 28 Dec 2023 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Pmq+0f+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42710A02;
	Thu, 28 Dec 2023 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DV0TUwiNGkqdrGdcaqnkKo+qqCO+RzCFO3exVU5U+ic=; b=2Pmq+0f+xVFdYSMYlYHPZHwI0E
	lL3sG+ESe9zKAjnNAQkrNMkV5+BNLsrIVtbzXKyimgF5zp3ylO4417sKaa/UBmaOhKyLQ4HwBqHHx
	M0Eym9GT9UA7bb9CzF29OaIb4PpbI42xLfm1n0N/45aIPVC2yOcwa6dGe+GOoyoyFJe2r50K1AJYG
	9Aq5RbdocUcfCzxxCMX/hbbPKW6TtN9/lllDWyKmv65P9nQhq4aGZXe4xWpc3SSCkEOKgCjuXPXkf
	ULvLaFkFw4wgz8XoD3Hj8k6DPktPK23Xkkv8XFxredHuslN+yYM1ASsWzCAjYh3e6d4205iuG401E
	3QTjFkQw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIzqM-00HXJZ-1f;
	Thu, 28 Dec 2023 23:31:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] scripts/get_abi.pl: ignore some temp files
Date: Thu, 28 Dec 2023 15:31:13 -0800
Message-ID: <20231228233113.5218-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are filenames of the form ".orig" or ".rej" in
the Documenatation/ABI/ subdirectories, there can be confusing or
erroneous output generated. Example: the file
Documenation/ABI/testing/sysfs-bus-papr-pmem.orig causes this
warning message:

Documentation/ABI/testing/sysfs-bus-papr-pmem:2: WARNING: unknown document: '/powerpc/papr_hcalls'

Prevent this by skipping over filenames that may be created by
patch/diff tools etc.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 scripts/get_abi.pl |    1 +
 1 file changed, 1 insertion(+)

diff -- a/scripts/get_abi.pl b/scripts/get_abi.pl
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -93,6 +93,7 @@ sub parse_abi {
 	return if ($mode & S_IFDIR);
 	return if ($file =~ m,/README,);
 	return if ($file =~ m,/\.,);
+	return if ($file =~ m,\.(rej|org|orig|bak)$,);
 
 	my $name = $file;
 	$name =~ s,.*/,,;

