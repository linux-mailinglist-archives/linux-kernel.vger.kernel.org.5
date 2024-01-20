Return-Path: <linux-kernel+bounces-31689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92C833284
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F2F1C213BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB655D534;
	Sat, 20 Jan 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlRAuSV5"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA09454
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719067; cv=none; b=JG3+l96/7AoPIMHJZ+hD/e925uRFC1zKwhUNOrst8MLZ4wMxpw/RaRqHN/UItQxQM2UKXkcLmDmqB8k9fMzJ3482gvWej6YCWu05nHzgDRqiJpjDTMHjk1gW4XQs/+trUDGz/xJzRF7YSqE2IQjrEv+hSnmiQ3QyHyuKBuy7C2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719067; c=relaxed/simple;
	bh=J6OI4DVuVVTHIf5gTG9FN0R1OtqlAKVnLkI7p2AZ4ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnwwCNIJt0pzqEMuZYiBUy7euYVmwl8ss+UDh+FoGn7Py4c3DIJnQOovBuYleQ5D6s5UJuAnweCJyaUZ3iS3HJaWVSh+OjveLpAtm8HJKxx2GqPSiwrEsQ+IiQ0pPtrWXqGegwNBslPrUai0wI5GeJdMqLD8rHS3iCZ52Z/IByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlRAuSV5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc21d7a7042so1257591276.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719064; x=1706323864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeRpHv3Rhilh+EuNYr3bORiW/nxnS2Awjr3v2Rkry9o=;
        b=nlRAuSV5VCjXe4RQ3W1PRPchWoq3SzReL8nQdKnQkHNPHToC3opmAwGMhreMG37DaE
         mfnvFP2zdYDgsL+eBIBMeS56UBuCCU3Ts3KYPMRdclFmSk0bY8oMJN8blNsSNRcDo4he
         ajMH1CgBvYyFb5UGptzIJbWhV6q4hwTuu2nb5Mcl0JfUhTyBSoDPRKa5jO9ziPgtqD0d
         1fp1uXf3Lms6g2ojI0ettynt4LV3zgJukWars1aWFZy9eT9k8f/a5S+o6EfJN1ycQaMc
         lStdfi1Le9VbLZwPCe68KxpI/MY47atnZuWOxaGvliGE705yrlcOjbz6qM4hl7zLb/Vp
         oenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719064; x=1706323864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeRpHv3Rhilh+EuNYr3bORiW/nxnS2Awjr3v2Rkry9o=;
        b=AYg8lvvw9x4MW+odNdAwiEUMGp71xcVyAw359OEDf4eJWuk/uoHFlTPVWmh4UknnEc
         dYyCsVElf8fAK6R8P1dr2b5/emTBKC69tNby3cIV9pGp0WCzFYZh40FofGcH1G+AGFWt
         uqzG9p2kBxDLhFlZjWu1fDzoonVWjDvrMMPYsD3Ejg2ej8WCKf7gGcRPCTLiKb5l6I5V
         8WqQ12KcsPL76U8TY94lhznEUGzbZR+i86522LBc2LkacVJS1Jt7832nv6Y8CuTotCig
         mdIE7VUv9Hl+5/ORMyBhX6BL2s0rIKfuSgkBIeeZyUG3nk7ztoghsrLRZ4Ch6sorBcJf
         izPw==
X-Gm-Message-State: AOJu0YwY7/ffFeSUGPXoTkPqgVIojQnUS0WNas42UaY/U/F5OB2Wf0+x
	LH07Apgc94RF42n15wVGxazrlnbLSyWpX16Z4LNIL61/X1NaAbdWGlv+hP9/ReU=
X-Google-Smtp-Source: AGHT+IEZWJeH36MIa/roOQ2t550jbQiJuOFbYxzCNAUvV1BHsnoWz3/Bqm2gWiDaY+11OqyCSXmrzA==
X-Received: by 2002:a25:e015:0:b0:dbe:ab5b:c659 with SMTP id x21-20020a25e015000000b00dbeab5bc659mr758735ybg.37.1705719064630;
        Fri, 19 Jan 2024 18:51:04 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id u16-20020a25ab10000000b00dc26a4ee68asm177391ybi.47.2024.01.19.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:03 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 6/9] lib/group_cpus: drop unneeded cpumask_empty() call in __group_cpus_evenly()
Date: Fri, 19 Jan 2024 18:50:50 -0800
Message-Id: <20240120025053.684838-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is called twice. First time it's called with
cpumask_present as a parameter, which can't be empty. Second time it's
called with a mask created with cpumask_andnot(), which returns false if
the result is an empty mask.

We can safely drop redundant cpumask_empty() call from the
__group_cpus_evenly() and save few cycles.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 72c308f8c322..b8c0c3ae2bbd 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -259,9 +259,6 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_groups *node_groups;
 
-	if (cpumask_empty(cpu_mask))
-		return 0;
-
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
@@ -401,9 +398,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+
+	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
+		/* If npresmsk is not empty */
+		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+					  npresmsk, nmsk, masks);
+	else
+		ret = 0;
+
 	if (ret >= 0)
 		nr_others = ret;
 
-- 
2.40.1


