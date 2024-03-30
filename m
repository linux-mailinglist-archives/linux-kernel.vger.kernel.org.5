Return-Path: <linux-kernel+bounces-125654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4A892A37
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702881F2237E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF329CE4;
	Sat, 30 Mar 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIKPjrCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C4200BA;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=JaaBhaOp7veI9BZzPZd6OWUk4p4+zz/wflDXIYYOmx8B+JtFXUuGFTIb/GCba1RpVQ9SuRge8tICYp3X99oZoENVEme3sevVie274SfPcF0sUY3QIJ8UaTf1SjM9EqPSjchSsRxfV9lP+yjzyfEb78J48u4YIih8p2qTelUROp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=2Q6VY0DGMACrjNS3qT1yPJApGJKAhjr7VSLFZ///1Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIWhVhAbazdKochdO0wPupxKNgs2V13Tf+i7h6jiPVhAm8VgObHrNRI5mqJwWrV6zlF2xy+sl5OxKGXEBBAQ4qcOPojIyNGNFeinR11xNjiLGwZwJ4f1EpFWWIG0hrG+oCi0zrXUg2IJaY/RHFAjxP4mt8xcXMc+++CUTXGRBDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIKPjrCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D85C43399;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=2Q6VY0DGMACrjNS3qT1yPJApGJKAhjr7VSLFZ///1Y8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BIKPjrCmuop+w7k+pVQ/5GQFzv/kREJ+oNMmkgs00gVX+LKr1itZO/AQn8KxMd/02
	 LbY8k7BsgHrYZSdGsq6OmDswW0zTlFVm0wpq1HfYDqSRLm4VvHsle6oUuBkj0Q290l
	 7GlyVG4MGAmPPhJQLR62zGs2dRxiUd1ovBphkjrFEzbmZbTaKbw7bnT3skeaIf8pzG
	 g/GbJCjFeGqA3oEyixr+X7xiEJwEMaDj19wcaxq3cR6aknv8pbmeJsc0hQFkHzBNmC
	 Z24U7Ouq3TgBabu+kd1eF5f7q/+L4kcdXpmBOxqFcgegX/tZSDW7FCaMx+ZAu0fZh6
	 hX3PI6ZheN7qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF2BCD1290;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:39 +0100
Subject: [PATCH 03/10] sparc64: Fix prototype warning for vmemmap_free
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-3-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=1023;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=+iIEu1z65nIiaVFud5jDAU2EF2qjq+E//QvstvA1vGg=;
 b=5VSMXsJDe14dfB5oOTmmYLuyPXBP0AEI7kkhlo+yFPQJH9hBDtSPFVLukEaLXfZBrY9t+daDfF0L
 L8uXsXFQCPOI5uioh9DGaOBI8cOkimdx9zSDJ9alHiqMpCCrM+VV
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warning:
arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for ‘vmemmap_free’

The function vmemmap_free() is only used for systems with
CONFIG_MEMORY_HOTPLUG defined - and sparc64 do not support this.
Drop the empty function as it has no users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/mm/init_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f83017992eaa..5444b515815a 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2640,11 +2640,6 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 
 	return 0;
 }
-
-void vmemmap_free(unsigned long start, unsigned long end,
-		struct vmem_altmap *altmap)
-{
-}
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 /* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */

-- 
2.34.1



