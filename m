Return-Path: <linux-kernel+bounces-75067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D883385E281
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162D71C24582
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C6839EA;
	Wed, 21 Feb 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsnNB56J"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00082D75
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531362; cv=none; b=PeujPXm7gkWx64SyupwpWR/0+xQro4fVaES76WVB6PLApGR2NeOAIluRQeLvS3cOCupDUOmIbRmiS0KyWVBRzQZpuShqXwalztJggAq8p5VCTT8KBYTu9U33rFX+ONisBoMqhfJa4r9R5sLUl+a4TufDTVPOJGT4Jfq1v/fCyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531362; c=relaxed/simple;
	bh=kR3/fVNZt26AdpqpP3ANsMTDHjenBDak66/1Ny0G4RY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NL7IY4o76FHEUekvsS+26CnfklV59Gt+bX/IxEvHjuhPKa7aySLbaj3TpsFM0MOibBVZjoepdfdPASy7dnry1ZkZ1sgCrakdlKDoXAn/w5L6/435tK7KB2FB/5TY9CVaj07u0HVwkFa/tqVcWVARA77DqVxF21rDkerhKqE64qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsnNB56J; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c7c1cb2e9so39204781cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708531360; x=1709136160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAuU+EdMCZqWdqfPENA6Ha7cgOpM7XDiB8KgwfnnOOE=;
        b=RsnNB56JBXaArBbXhv6FhWbgKY9cGuhVCxLuB0WiWkY+bwitLFokgUUrYpGXmNANRc
         6yiv4wrpT4q0JRFlFUto8RZAtPDghf0hEX3rbMTMve5q7LXBrJaPoDgeaoK7WTUxb5Vg
         DdwEidvMJcwZJJ/AANWmLkL+iXC/Oz9ydVibkKzwB0GWgtINqqots6FNWsU6TLnA9Nny
         tMBKfqNiz8vUDm982WNSHNd7dCu8rEywcCowaGr/K89dv4ybz92marnxRbUFNJOJ/Kcn
         dY0q/qMY9RqlgGN+i4/UWnVPr9qObpzJ6cIrpnBENKXeyh/TZkj83T4msBzfycttT5zZ
         RV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531360; x=1709136160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAuU+EdMCZqWdqfPENA6Ha7cgOpM7XDiB8KgwfnnOOE=;
        b=DkwPgEoPVEp66gZqvfFpOGPf0Om4/4edsSpzM/GVgAZjSQqoUmYhlwToxr0+wliBmJ
         SQ4LK0Q84wXr7TszUkCZowbbJFOxjn5H8wn+3VTQYSKjTjFcVe3RfOHp+IK3yGFl8Gv8
         iZDo7Vkkz+LibapdGH6RULpPNgCdCUDk1BYBWQpM91z1OKpFYvn3BzCook73IO0fJbgq
         ORN/RRBxGnf9AlvDa4Qna3NLIk4zkITdy6NrwRKrsspzcNB+MfFrWQhNM3k4OSWWlD3K
         UIQDbn5HZa3YIEcKBD/Yj0mdlURF5PDzldBBRi6J+esoNlseu//qkcnJopC09PjSI+x/
         d6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVel5c7Ev13VCnZ38EhM5WCjp35w6XLb326+5QbuCNacHp5xuj/fnPcJDlm2pTCbvlxGfpUswMQXnd8L6HWXWSGjzhvhgYt6U1pBQD3
X-Gm-Message-State: AOJu0YzYBIBADzsv2ePehKNP5Y6R2V0IEyjnEJwP16lQy/aaE01DKo7m
	kV3/Neu52NXC5h3+UfMGXF7DY8wUjsyj92C2BBbfY4Gr63RD0aW3EgwTUGud
X-Google-Smtp-Source: AGHT+IHvqIYB4biKtYzJbhHN+Ma/1oviTGRg9JC1eXPc0zNSgNincvvoFuI3kFaT58xPiJ1t8QDiaQ==
X-Received: by 2002:a0c:ab13:0:b0:68f:ac2c:883c with SMTP id h19-20020a0cab13000000b0068fac2c883cmr1140954qvb.52.1708531359798;
        Wed, 21 Feb 2024 08:02:39 -0800 (PST)
Received: from localhost.localdomain (024-171-058-032.res.spectrum.com. [24.171.58.32])
        by smtp.gmail.com with ESMTPSA id pj4-20020a0562144b0400b0068f79a4ce67sm3060611qvb.22.2024.02.21.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:02:39 -0800 (PST)
From: Matthew Cassell <mcassell411@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mcassell411@gmail.com
Subject: [PATCH] mm/util.c: Added page count to __vm_enough_memory failure warning
Date: Wed, 21 Feb 2024 16:02:35 +0000
Message-Id: <20240221160235.1771-1-mcassell411@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 44b414c8715c5dcf53288 ("mm/util.c: add warning if __vm_enough_memory
fails") adds debug information which gives the process id and executable name
should __vm_enough_memory() fail. Adding the number of pages to the failure
message would benefit application developers and system administrators in
debugging overambitious memory requests by providing a point of reference to
the amount of memory causing __vm_enough_memory() to fail.

1. Set appropriate kernel tunable to reach code path for failure
   message:

	# echo 2 > /proc/sys/vm/overcommit_memory

2. Test program to generate failure - requests 1 gibibyte per iteration:

	#include <stdlib.h>
	#include <stdio.h>

	int main(int argc, char **argv) {
		for(;;) {
			if(malloc(1<<30) == NULL)
				break;

			printf("allocated 1 GiB\n");
		}

		return 0;
	}

3. Output:

	Before:

	__vm_enough_memory: pid: 1218, comm: a.out, not enough
memory for the allocation

	After:

	__vm_enough_memory: pid: 1141, comm: a.out, pages: 262145, not
enough memory for the allocation

Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
---
 mm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..c0afb56f16ea 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -976,8 +976,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 	if (percpu_counter_read_positive(&vm_committed_as) < allowed)
 		return 0;
 error:
-	pr_warn_ratelimited("%s: pid: %d, comm: %s, not enough memory for the allocation\n",
-			    __func__, current->pid, current->comm);
+	pr_warn_ratelimited("%s: pid: %d, comm: %s, pages: %ld, not enough memory for the allocation\n",
+			    __func__, current->pid, current->comm, pages);
 	vm_unacct_memory(pages);
 
 	return -ENOMEM;
-- 
2.43.2


