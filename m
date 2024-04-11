Return-Path: <linux-kernel+bounces-140509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06678A1591
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAF31F233D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C914F132;
	Thu, 11 Apr 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyxcqhAz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1F14EC58
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842384; cv=none; b=ffuWY1JRGjoEXsxCr25y0qulzQb6ZUtO8voDpdqwx17HkQz3LfCGkMDjp1lMcdogyedUcqk/igohTXukzlJsimy9vYyyNU9knt0hVI+ximhEMQ77ZvDrjTtNbA7pH2cFDhJrGCkqavvKbyxJ/MSGCa8ZEbCBAzkhXOHH/oYa9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842384; c=relaxed/simple;
	bh=teK/eqWCTvzCc35yaa/euuldPp2NUAcqVNLGmqtWPgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qUFRb/ihimursIrZNZU/8kVGBTv+cRdlCvgHjAnU2MWepsX+mXlh0LCL2yMJuy1TP/KRt6faMGGRuEdFYmoXgszUq+jmL9kxQJauqw7xPWU7CheIo2ghSOM2jOG1H98Alig6Y9da2w4PznFunpJnDCXjLsYJUKGNhvaM5j3EjQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyxcqhAz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41663c713b7so4687225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712842381; x=1713447181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jLbdCZtEB493P/s/ORJxcOLOX4Rib20uKwmrnMJ0nuE=;
        b=YyxcqhAz5oygn7KV2KMsSGZXtDNv2C2oXuTLqyVyxSZtT3/nVLfG3geCteuaMbiXKq
         0PRyMxK3cukZFZcQBZYTY5kX14eIo89ulMJaia/ZO1TMPX0MGtilcrW+rbcMmYHfegwi
         Xg2irPFc7m9ksSVkk6LMwUUiaePV2AaWk6F97FhQmLReC8tRCi9c3XqrEXkhFacsq0Fu
         Q9rhY9W8BTExVNRtny4Jt986pXBcK2p6safrHJDncZnBN1al29BQ7kWSN5bIveFqwPTR
         1pWSAd/6254bfBkfThZboD0oKLb04AgPMM8kVB7ad6mhanrRoD3aXdL17kylsDNIzA4k
         K+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842381; x=1713447181;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLbdCZtEB493P/s/ORJxcOLOX4Rib20uKwmrnMJ0nuE=;
        b=k3ig4G2C4jFi+T8HtDqe+lmyMd7/w0kq6uT3WgvluVt95qmrnl9f3GHUyE+tnKxPT3
         dtOiknK7A+EkHY8qE0rzlY/DAb+thGriZ6CqneR4On+telpsdms5g0SPCOAnBlPJ3dN5
         Hr2BNA9ZrvkMhlEVBuwkG/b9musKxNDaAujYo983+jvj8Hcfmc7ZKMlTX+F82xXGOL7i
         R8R1pytpVti4Yu0JkZiW0wvSvkhdzm2nk+cShLuMFF7LI+PLdzHAq6GQ/ktYgONuitNu
         3tHAjbtfsdX5Mjk3rRReMzg6ajabLGuOj2zSSTcjAxR5yhsobjJHZ7bJbj9FgIc1YIW2
         RvFw==
X-Forwarded-Encrypted: i=1; AJvYcCXmFQXIJY7vRTjGDdxXYXlpZ98yeB6S5mvhj7x63w811pKcPnt10QCOJCaIvTm+UTDC38chb4TKqWL6/EYLLv5/B5YuKKu+ccPaVvDI
X-Gm-Message-State: AOJu0Yx21tVu9R7dNuXHU2tPtLoo5OskTX/Ww+RoubV8Hr3eWhgLuNN2
	eWTv4re/76SlDTJ3WwpkURU+YuvCYsLGMxTdmDUdOVcareCfgt8NT+RZso5g7AV7n+g2869iQwu
	+lf/iJpiB6fUYiYXlx2HUYR3DIg==
X-Google-Smtp-Source: AGHT+IEBtyO1OCnSzcg3FPObYJAZ6zsaFmfxsv4pfdATs2M1m7kwFkbGnhcitqth2TnArhHYAdgWS+f4LvVTF396FzQ=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:511d:b0:416:98c7:9b96 with
 SMTP id o29-20020a05600c511d00b0041698c79b96mr42890wms.2.1712842380871; Thu,
 11 Apr 2024 06:33:00 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240411133249.2134696-1-sebastianene@google.com>
Subject: [PATCH v2] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, qperret@google.com, qwandor@google.com, 
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org, 
	yuzenghui@huawei.com, vdonnefort@google.com, lpieralisi@kernel.org
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
 arch/arm64/kvm/hyp/nvhe/ffa.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 320f2eaa14a9..31ad740137fd 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -67,6 +67,7 @@ struct kvm_ffa_buffers {
  */
 static struct kvm_ffa_buffers hyp_buffers;
 static struct kvm_ffa_buffers host_buffers;
+static u32 ffa_version;
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -640,6 +641,45 @@ static bool do_ffa_features(struct arm_smccc_res *res,
 	return true;
 }
 
+static void do_ffa_part_get(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, uuid0, ctxt, 1);
+	DECLARE_REG(u32, uuid1, ctxt, 2);
+	DECLARE_REG(u32, uuid2, ctxt, 3);
+	DECLARE_REG(u32, uuid3, ctxt, 4);
+	DECLARE_REG(u32, flags, ctxt, 5);
+	u32 count, sz;
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
+	/* FFA_VERSION_1_0 lacks the size in the response */
+	if (ffa_version > FFA_VERSION_1_0)
+		sz = res->a3;
+	else
+		sz = 8;
+
+	WARN_ON(count * sz > PAGE_SIZE);
+	memcpy(host_buffers.rx, hyp_buffers.rx, count * sz);
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 {
 	struct arm_smccc_res res;
@@ -686,6 +726,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
 	case FFA_MEM_FRAG_TX:
 		do_ffa_mem_frag_tx(&res, host_ctxt);
 		goto out_handled;
+	case FFA_PARTITION_INFO_GET:
+		do_ffa_part_get(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (ffa_call_supported(func_id))
@@ -726,6 +769,8 @@ int hyp_ffa_init(void *pages)
 	if (FFA_MAJOR_VERSION(res.a0) != 1)
 		return -EOPNOTSUPP;
 
+	ffa_version = res.a0;
+
 	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 != FFA_SUCCESS)
 		return -EOPNOTSUPP;
-- 
2.44.0.478.gd926399ef9-goog


