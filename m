Return-Path: <linux-kernel+bounces-150486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB28AA00E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47C9285F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7116F91F;
	Thu, 18 Apr 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c33FeuoV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC204172BAA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457914; cv=none; b=AZ/9snKI9sLZFn7NCFvBkpMRGxCGS00cVpmnOsafO4G6kMduBsOf2m6C/saCY2/HTHl66ePxVH9e6fwsa9I/qkn0uqmRR75FBJTApLYFmTHQE3aV5h6WnaHudJ4HeWLqXfKjOuZZSQ8obtgE3cHuMsek7CoFXsyPgi3uB6wKeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457914; c=relaxed/simple;
	bh=c2CK72lGJDZxhkE+vu1jRDsSGgFezzCof9rwe6Qg764=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKL0NwINNOMzSgO8TbKabIs3gpOcMUaUB/OivocxaQSOrvmo0T61oRcKT23L0EZaBur8Si1GDYmX8ABScHq5AC8JFEpHnPfVsO3OrSqDtJ/YZHiR5YCcfdfqLROcHSgSHQzitwJ6t/Nj2U6WmCqcc3To+8bWYpleqZIqBpyjocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c33FeuoV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so2014126276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713457912; x=1714062712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o/WdHir/Mi2mSDEW62XszsH6Iho8VZ+3enjU3uPIcDs=;
        b=c33FeuoVmUcQ0l0C4pwHQaC3m8gGLZAI3AId2TelkMcM8A3JPeBr3ZIsjrioymToj4
         Xa0eyWUvWzwJmXR8P54KgR7lERWLP2x17qhZe7TdW/dKgnaRodgKgd+Mb/GbpRBV509p
         mvoxHfTcmSoHcJCdxnfbDKtCBP9KjFy+VZH4FufagmUzcfzA6fch2CkmHpsMAD95stMM
         jN6MmrWoTnwjt1SIqsDg2WEMCBKzmm5Lv45mu7WFd9GmdlHLigHUKWV6AVRSHOckCsWQ
         kthOx/RvFLO81kLzyLApEiRKjncxblJjGkrsSYRMeS3o5+YZyPptIITxeXgRymSh1HD8
         8puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457912; x=1714062712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/WdHir/Mi2mSDEW62XszsH6Iho8VZ+3enjU3uPIcDs=;
        b=DHjbiLh6ES6ipVxt9j20Ir4aKcjb2df+VF82XmyMl9BZLDiZ0p+aRNlCj9AyBy/ljA
         YbYj5aEVfjcjQswnGPFymRPtG6EOF4ibNvAkkW3V0d3FW2DKgzoxGTh+Z37fcTSQHDBA
         ZCm3EA4RnoB4a4gdLgEmG1SynwHFUGddjpiYAjZ0pX5aGEwA6M4LZvblUfv89/HcUaLS
         7srtWNwvNTq0eb4NsmKzdESIy3U1C4dNCktrq7GMrIZSRCojybVPC4Ei3omKOskNsqa4
         tvkCN5JEZbiWQFiWu6f+yVMMQLXp5cPMX1jdRAtQVcjj+OPtuF7kWmClPulf66sp7NJc
         cPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVsq8vAddY+qZo7PTk9P3xGe47nQFO+n6DFVm2/Dlg1NtrWEM5H2rS+ulddXaEAi16ozqJEumMtD6J9G8QJqmmZafIZ2Y7W35E1ills
X-Gm-Message-State: AOJu0YygnvOWDuhwPknBBm3QQh3f3loiSiZfItiuzHWl7urkv5Ncy2zo
	gENdN6+x/P53nxBRyDgDHnUEvIb5W+tRMU7UxsgmcQ4cpjnWTwGfxLcHiK8n9rz95LuzDBvwh0u
	WPqCg0J08tkoOMtmx3j5mRVNqtw==
X-Google-Smtp-Source: AGHT+IFU3gG7mhRXP799oGDxBlPxLgFLfF8KRo1VK5xtAu+Ns8G5jem0y2bESQeN8vefdLLSBSCfbA/Pv4M4UuLpEoo=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b8e:b0:dc6:cd85:bcd7 with
 SMTP id fj14-20020a0569022b8e00b00dc6cd85bcd7mr831056ybb.3.1713457911701;
 Thu, 18 Apr 2024 09:31:51 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:30:26 +0000
In-Reply-To: <20240418163025.1193763-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418163025.1193763-2-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418163025.1193763-6-sebastianene@google.com>
Subject: [PATCH 4/4] KVM: arm64: Use FF-A 1.1 with pKVM
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

Now that the layout of the structures is compatible with 1.1 it is time
to probe the 1.1 version of the FF-A protocol inside the hypervisor. If
the TEE doesn't support it, it should return the minimum supported
version.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index d53f50c73acb..8633c8e0b09b 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -455,7 +455,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	memcpy(buf, host_buffers.tx, fraglen);
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, host_buffers.ffa_version);
 	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -534,7 +534,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	fraglen = res->a2;
 
 	ep_mem_access = (void *)buf +
-			ffa_mem_desc_offset(buf, 0, FFA_VERSION_1_0);
+			ffa_mem_desc_offset(buf, 0, host_buffers.ffa_version);
 	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
@@ -789,7 +789,7 @@ int hyp_ffa_init(void *pages)
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_1_smc(FFA_VERSION, FFA_VERSION_1_1, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 == FFA_RET_NOT_SUPPORTED)
 		return 0;
 
-- 
2.44.0.769.g3c40516874-goog


