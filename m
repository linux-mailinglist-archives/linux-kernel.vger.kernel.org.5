Return-Path: <linux-kernel+bounces-11394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA381E58E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7231C21D32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B74C3D6;
	Tue, 26 Dec 2023 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xvTXLOrh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0AC4C3BD;
	Tue, 26 Dec 2023 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kkgklDeXRuhCQW767gm/kiIxt834TUdRq1zskO/SUKE=; b=xvTXLOrhrpyxzm/nxWY/ILl0N/
	QwKSw3UC8qJkByrAA9kO9T2rX4cbqE/6NLralyTz97Ml89Ly9utPeqW0TdhnS1SqbLO9ixT+ABdfT
	/lg8Jx4Y9nso7eggfKdVEooRpoPf3xkmSiBFDP+szt/Kt2FgiWKM6CMCMIONyfWAGs8+SW4VLVbSj
	FNke/bw0pdMwPbqDiguH2OpmH/1NWITlM9CLM2lS0CcpvG5bFWs6Lj+/VXB6ECF7WZpCXU0fs8mC1
	CrEd66DOVJBWepQ3Ru4q+Rq8tiPwZrGclJtTXuCuL88RwGZ+4+f/GLctXrjsa+vIOD4a62xw1jSQb
	U+oVevPQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI1Ia-00BpNA-0w;
	Tue, 26 Dec 2023 06:52:20 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] kernel-doc: handle a void function without producing a warning
Date: Mon, 25 Dec 2023 22:52:19 -0800
Message-ID: <20231226065219.319-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently a void function can produce a warning:
  main.c:469: warning: contents before sections

This one is from arch/x86/kernel/cpu/sgx/main.c (which is not included
in any produced kernel documentation output).

Handle this by setting $in_doc_sect to 1 whenever any recognized
document section name is processed.

Fixes: f624adef3d0b ("kernel-doc: limit the "section header:" detection to a select few")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 scripts/kernel-doc |    1 +
 1 file changed, 1 insertion(+)

diff -- a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2126,6 +2126,7 @@ sub process_body($$) {
     }
 
     if (/$doc_sect/i) { # case insensitive for supported section names
+	$in_doc_sect = 1;
 	$newsection = $1;
 	$newcontents = $2;
 

