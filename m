Return-Path: <linux-kernel+bounces-125656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C001C892A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6ED1C2148D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C6405C6;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO4lNsou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC98208A2;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=Ii9BXZPClftik0kkF0whExwHiW0cistUOd2wJG/CCuxYn1beKAc6aHe8Oq15eQNNFwlp8PdMRdGwvEjOuWIYlPxk215MRvRIkQx8b1+rhz6TLdbOPJQFnUY570asBJJVB0wCQ7nL9cMj/Zayds0MXSO8VdjSqotK5Ckw7NEKNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=RV9r2ML9o3E1SdglYl1CXcwBgIOMSUNtjyseYqlJ2XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zz9IhkwPYKOemu+w4qCziNefRSdzz9p/tnMhsFme+D6h+14cry6XhltaKv8hjp+BAQz5BQAbL9zS/rceHk8RVqX8PsEwT6AEYGovv3klCs8UX5kAOkrRjjfrWKsKed3e3auh00oh+GLkCuxi7WVtU3q19QQ/E+EBy4DaGdBSouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO4lNsou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EFEEC433A6;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=RV9r2ML9o3E1SdglYl1CXcwBgIOMSUNtjyseYqlJ2XA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oO4lNsouDlCi7x3tGy4jRlm5bfoPpeFNXFCXYmonSDQLapIcaGBbX0/CMX4ScUZvr
	 2tpBJ4vEWQK2c7gFhTvDUxQvn154gwgjPrFWvg/bm8s0hGAq48ryGIo/7v+h+WsKrW
	 khx8Q26y7F4p4bnD/o0qajzSbxHm+vWdyL8Gwl0HNbXPmwf0qy7+ByIeEnIhqYTFKx
	 CPxgdB+tJegILuc64So3AmfzTDlo6QbUtCYCzf8xoR+Givx9Dw+44qQHNyelUa21Fk
	 8pl0yaM7qllFkT6KGdl92SsbX2cSQXIFHqf0BGJeb/HprHvOOYmpgasE62E8zAGb0x
	 bFQfiZeiyalhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16568CD128D;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:42 +0100
Subject: [PATCH 06/10] sparc64: Fix prototype warning for dma_4v_iotsb_bind
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-6-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1078;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=ZJnDEoYRR+6aaZk7EEvtgtfnCnQfrvRZPpKL04kGYG8=;
 b=+P73wCmF6fdM+Yl/OL7n1h00X5/H9eGLRS8OkyaFLZ3lCyNQIMamva8JjdBzuzJz3RamkdNu+XXX
 HCDuKRN7BKCvLiNrDhVb2cA849WRpYW22u+gqscHluUdZ1SPyBf2
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototype for ‘dma_4v_iotsb_bind’

The function dma_4v_iotsb_bind is not used outside the file, so declare
it static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/pci_sun4v.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 083e5f05a7f0..b720b21ccfbd 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -256,9 +256,9 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 	return NULL;
 }
 
-unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
-				unsigned long iotsb_num,
-				struct pci_bus *bus_dev)
+static unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
+				       unsigned long iotsb_num,
+				       struct pci_bus *bus_dev)
 {
 	struct pci_dev *pdev;
 	unsigned long err;

-- 
2.34.1



