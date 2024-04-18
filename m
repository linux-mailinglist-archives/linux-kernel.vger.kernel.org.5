Return-Path: <linux-kernel+bounces-150484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0848AA00C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181801C21BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127734F1FC;
	Thu, 18 Apr 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5AgEusH"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C817107D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457909; cv=none; b=ujpWljqlJ/h2BGHuaWJ1P6kocjEYN959LB+eY+ELyn4+PdMsIWbE/wcctW0fSWcrVa67ASm++Z+X0sFm0bHeuf6zswqgPLjh9Khms1+JMcTulNsSVFilGp695bInG5ALCtNB+oyCVUC9jPxqon2M0nbbtaOxOS9ELydB7La7gjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457909; c=relaxed/simple;
	bh=bwRIdgpsHW/V76+UX+Cj8GF/pMxY2YesRhoOXmNznx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CI3QI4fpybSucsPv7+7VDBVBk0kuKgqAq6c7XFfkjZYXnLcjwr3zP4Fd2lOQZVlkOgJJcX6Ut0c4NcA5VXMd7yeM2rnQiiGC1rxXHVwlvpN8DXarkvTLf6RpsT74kOvdz677xamJnTLJLt3em9gtLIahKe2DXo4aecykK914MmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5AgEusH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de4645bee83so1732656276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713457907; x=1714062707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p9c64neWTEzUroG7YZesoYglVijCCcHGMdjez+sjDY=;
        b=A5AgEusH6JFBz3k4qb4Jvm1m+2GYPpTnEwGmDc3QC7kwns88CbQ6/GilWnyqw2eF7s
         dm7p8EJix7am1UUmSGjsNF7zX7oV6VaUEchkw3TNfFEX3QL1yQKD8ffAWcZUUMbE0Dxf
         s9G2XdfaAPxVhxg8QKH02Tb4zHYbbJIWeg+5FYS2yuDVSg9hnm2Y/oVaj5dD876aZ6Fa
         yCU5lBeJXo61yjKt+DFlsZEYU04EesDEMXz44i9aPV45cKtA/+AIIRKnN/s7iIpM3CEs
         iYnRw2S1DAb9qyMp9WELNH2TyoH2cqgS2E+JngnjsCQfYcfkYEf1d1JO8aoCcymo1OTJ
         hVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457907; x=1714062707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8p9c64neWTEzUroG7YZesoYglVijCCcHGMdjez+sjDY=;
        b=p83csAaHXesZLVFJ5jZGuP90DmWc+U+Ix3fpp6g1IxIBF9PjfRM2udEm3zmtzFI7km
         b93MMOATW9YiAIuXcU7S6IYGw1UwvQrQ6KSAXxzTNcHz1jjeCHKib6dt752yx0DApn6/
         XmqnmW0IhBwSgCJETgrJ9kWZgpEDdij8C7u5n5yjFn0JhNTFgrEUDJzqjWSo7O1GnXS3
         VDGEvOD25TJZp3TkSGXLZvwKtJ7wvSv2Jo45ENFxCzR1g5agczLs3C4E5BbgF0aD0Wg/
         eHx/AxD4uxbqwBKncBYbwpEySui3Dve1B8sxjXlHf5rniBvnbFrHE0B/yol6Bgl4peG3
         /dJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7RDqYcLb1VrZJHddTtciQpyiJtJYGwDu09pgvX1q7F4vSYTkGQpxdd62S/j2JRHH3ajm1MS7wFz0yM4JJ6yC1rjonfcdoHVZqE7TW
X-Gm-Message-State: AOJu0YyaHpPdMGMqjK87Mz3Q72PQKt25dwss/fK4cMvu1iGYUwRXL9St
	loeVyElCCqAxfCl3oSwolPCbQ4e8V/Yuc86XM+A6Qxo3asnJURU9qkDFwGkupRJih8JIhHqIDve
	J7aj+yhDLmsclIx/vfpVUeaafBA==
X-Google-Smtp-Source: AGHT+IHpX3+77ZV25mCqXIANfzu2cm+jHFm8blOeRGiipeMLfzcogzWLO4ECeP8t8lYr9QlOgIVIHYowhRuQKDsITVs=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b8e:b0:dd9:1b94:edb5 with
 SMTP id fj14-20020a0569022b8e00b00dd91b94edb5mr293032ybb.10.1713457906943;
 Thu, 18 Apr 2024 09:31:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:30:24 +0000
In-Reply-To: <20240418163025.1193763-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418163025.1193763-2-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418163025.1193763-4-sebastianene@google.com>
Subject: [PATCH 2/4] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
and copy the response message back to the host buffers. Save the
returned FF-A version as we will need it later to interpret the response
from the TEE.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 023712e8beeb..d53f50c73acb 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -674,6 +674,49 @@ static void do_ffa_version(struct arm_smccc_res *res,
 	hyp_spin_unlock(&host_buffers.lock);
 }
 
+static void do_ffa_part_get(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, uuid0, ctxt, 1);
+	DECLARE_REG(u32, uuid1, ctxt, 2);
+	DECLARE_REG(u32, uuid2, ctxt, 3);
+	DECLARE_REG(u32, uuid3, ctxt, 4);
+	DECLARE_REG(u32, flags, ctxt, 5);
+	u32 off, count, sz, buf_sz;
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (!host_buffers.rx) {
+		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
+		goto out_unlock;
+	}
+
+	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
+			  uuid2, uuid3, flags, 0, 0,
+			  res);
+
+	if (res->a0 != FFA_SUCCESS)
+		goto out_unlock;
+
+	count = res->a2;
+	if (!count)
+		goto out_unlock;
+
+	if (host_buffers.ffa_version > FFA_VERSION_1_0) {
+		buf_sz = sz = res->a3;
+		if (sz > sizeof(struct ffa_partition_info))
+			buf_sz = sizeof(struct ffa_partition_info);
+	} else {
+		/* FFA_VERSION_1_0 lacks the size in the response */
+		buf_sz = sz = 8;
+	}
+
+	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);
+	for (off = 0; off < count * sz; off += sz)
+		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
@@ -723,6 +766,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_VERSION:
 		do_ffa_version(&res, host_ctxt);
 		goto out_handled;
+	case FFA_PARTITION_INFO_GET:
+		do_ffa_part_get(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (ffa_call_supported(func_id))
-- 
2.44.0.769.g3c40516874-goog


