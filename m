Return-Path: <linux-kernel+bounces-93775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61074873493
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8962CB29B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF58E60BA8;
	Wed,  6 Mar 2024 10:35:30 +0000 (UTC)
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7E60B8E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721330; cv=none; b=bhe+ZwSKCtlGGckr5tfJP1w5U5KhyMqE0GfMRohp88E+28Acp7DZyK5PcMjTT1xGvBaUMyx9yJYPzudkStJUuJs98OuTMPWZGUU9KAPxJLOUvM1lUBWNllEz5vD+0pMJpsVb1Gdh+doPo81TgE8ZdZeGFXHMezVkh6q9Adku9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721330; c=relaxed/simple;
	bh=O0NWohxWLhuPCPdgUtUvYLL8yZ/Ty6sMX82olIEuy3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XooFPYSEydGyokgl6XKEOJiO8UzWccurg42inWoMq925dxQJTElTxhGu1325lm5ZR92IrzZHaTvdJgMifwxo1MyP0rmEKSam1frKIay9HWiofh7wXwzLut3O7mJJynIHoyylK7fbnsa870ryATrli3mQqYKElr+/QdMeHdKyJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=47.90.187.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-K1_1709720384;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-K1_1709720384)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 8/9] um: Fix -Wmissing-prototypes warnings for text_poke*
Date: Wed, 06 Mar 2024 18:19:24 +0800
Message-Id: <20240306101925.1088870-9-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The prototypes for text_poke* are declared in asm/text-patching.h
under arch/x86/include/. It's safe to include this header, as it's
UML-aware (by checking CONFIG_UML_X86).

This will address below -Wmissing-prototypes warnings:

arch/um/kernel/um_arch.c:461:7: warning: no previous prototype for ‘text_poke’ [-Wmissing-prototypes]
arch/um/kernel/um_arch.c:473:6: warning: no previous prototype for ‘text_poke_sync’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/um_arch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 7a9820797eae..e95f805e5004 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -23,6 +23,7 @@
 #include <asm/cpufeature.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/text-patching.h>
 #include <as-layout.h>
 #include <arch.h>
 #include <init.h>
-- 
2.34.1


