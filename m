Return-Path: <linux-kernel+bounces-111435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA24D886C53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EBE288219
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966345BEC;
	Fri, 22 Mar 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNNndBhc"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A35446B6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111447; cv=none; b=fsURCcxCmrEKz3B8oHPfOWSxY4tB9aMvG3QObpKIlIC7N4xLfY9Y7tdYIo/0Ea6rD9jwjNKQ1F1gAAkPsQ+VXPRuOA45BdxPKeBOqQQgNe3bjKaY0ee/rWNi1N6c+zOnakPlOj5O90k4wPk9yfGP6ClhQY+s6xdbCBR8VTchOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111447; c=relaxed/simple;
	bh=KFDyqz+2NM43tMXZpH+HM+iW4o2u46W6ALODy+oGMbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hz+LjGcHhpGxCbqKDnJHBC3lxd09VwpCr9z6SSyxTNMbogrisXJFy9fUTMa75Z4jHrQWgZVpgM14Lswae6ZBhLOwkuLkTukSyVx+lQFr/4CT4xOTkwDnhw+SyO8ZNwK/1+Oec0E2M0vK8a/UNcRPGOXuvuBXliNUoZwIaijeslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNNndBhc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-33ec0700091so964320f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711111444; x=1711716244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8cb/JElUFHNMOSO0hj2Q7csN4h6JfrSorkGcltJjfs=;
        b=BNNndBhcidk2hEw3ybg0A6OQ2sPHFwluLWV6I6w03Sm4BV9IH2QqviTUHzhtKFB/XH
         4VQKkVdsQaPZVEDkLFE4T4JYtHygNKQir6RDdlLd9VH1RXaMlBuxyJczC9hkwQRo7Vhn
         atIdeJnR0TibR+g301H0DxUJ40spoa0FXwbILfWseWfVmNThp8q4aN9/BwAkeIDqtwzd
         F3arB+x9WLPri6P4w3gvsR7hUjGxSbo0e4Ai/hxBxpd5xcGxoixSepesm3uOEIfYvLUY
         Hf4VpcIPRpF/lfXbwlXDRXW2JqQGz+e1A90RV2cjlaW0kI3BMGg7tYpWzrguo5Pwnr/K
         IEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111444; x=1711716244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8cb/JElUFHNMOSO0hj2Q7csN4h6JfrSorkGcltJjfs=;
        b=ftYWuwla1+jbgRLK6w2r6ctM8j9YsiaHIvAo4VH9VpFbDtApzNg2oyfglXPr+IcpSJ
         UbtMGIfYPQyy25dyeILkLs9dpufpqNwAbHBOAWU2Ye/hy1ObQfLJrwzQ+vu/ipYBA1Q5
         ARDxtL/d8VSd/iVjSWseiJr10sGjsAK4lt4Jk05iVOC7/8Nr7IymhBx8xSmtaXMj1UDg
         qX73PkU2aa4JowYLA9Px9TFi04OoK0zmoNSuozp5bBjuwKSkzh4x86B01qf30QFbisY2
         qHwP6O1q3IgeCCvYcfbeIXCswlRkdgYb2ulEcD7XTdMskYzE45xxd/xcTi1s/fJ69dTL
         TAqA==
X-Forwarded-Encrypted: i=1; AJvYcCVABCQHMb87z9VL/Ob/53L+An74rQxr/sihfzvLVE7GsorY0R4cAt3SgbbYhZW2Y4oUEQpim7xv6NWxhsve2GP+m8vcyQBgKQ9engJK
X-Gm-Message-State: AOJu0Yx29i8b+PuC3hQzL4vdJiCwO9DzJi6C17jeSBc2ccOrdMASpUqS
	hWIKi92enLbGFxRdJyDK/mgYBbS1auxNAnfvrkctLWBoTEWupWRPKEQr16DhYMtmie0oCXtqasC
	HzGYHsUHgfl1q7s/zi/XZsfKs3g==
X-Google-Smtp-Source: AGHT+IHvj0UU8M976GVx3IfLiLrCo0XzB/01QI1sAsqph0orYlVs+PZ3CRX/Ahi7ItrF5KZEgwszuCw6akj/+SxlRsw=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:adf:f50b:0:b0:341:ba6a:6996 with SMTP
 id q11-20020adff50b000000b00341ba6a6996mr1855wro.7.1711111444641; Fri, 22 Mar
 2024 05:44:04 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:43:03 +0000
In-Reply-To: <20240322124303.309423-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322124303.309423-1-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322124303.309423-2-sebastianene@google.com>
Subject: [PATCH 2/2] KVM: arm64: Allow only the specified FF-A calls to be
 forwarded to TZ
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sebastianene@google.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The previous logic used a deny list to filter the FF-A calls. Because of
this, some of the calls escaped the check and they were forwarded by
default to Trustzone. (eg. FFA_MSG_SEND_DIRECT_REQ was denied but the 64
bit version of the call was not).
Modify the logic to use an allowlist and allow only the calls specified in
the filter function to be proxied to TZ from the hypervisor.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 320f2eaa14a9..fc4f04209618 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -580,35 +580,35 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 		ffa_to_smccc_res(res, ret);
 }
 
-/*
- * Is a given FFA function supported, either by forwarding on directly
- * or by handling at EL2?
- */
 static bool ffa_call_supported(u64 func_id)
 {
 	switch (func_id) {
-	/* Unsupported memory management calls */
-	case FFA_FN64_MEM_RETRIEVE_REQ:
-	case FFA_MEM_RETRIEVE_RESP:
-	case FFA_MEM_RELINQUISH:
-	case FFA_MEM_OP_PAUSE:
-	case FFA_MEM_OP_RESUME:
-	case FFA_MEM_FRAG_RX:
-	case FFA_FN64_MEM_DONATE:
-	/* Indirect message passing via RX/TX buffers */
-	case FFA_MSG_SEND:
-	case FFA_MSG_POLL:
-	case FFA_MSG_WAIT:
-	/* 32-bit variants of 64-bit calls */
+	/* Discovery functions */
+	case FFA_FEATURES:
+	case FFA_ID_GET:
+	case FFA_VERSION:
+	case FFA_PARTITION_INFO_GET:
+
+	/* Memory management calls */
+	case FFA_FN64_RXTX_MAP:
+	case FFA_RXTX_UNMAP:
+	case FFA_MEM_SHARE:
+	case FFA_FN64_MEM_SHARE:
+	case FFA_MEM_RECLAIM:
+	case FFA_MEM_LEND:
+	case FFA_FN64_MEM_LEND:
+	case FFA_MEM_FRAG_TX:
+
+	/* State management */
+	case FFA_RUN:
+
+	/* Message passing */
 	case FFA_MSG_SEND_DIRECT_REQ:
-	case FFA_MSG_SEND_DIRECT_RESP:
-	case FFA_RXTX_MAP:
-	case FFA_MEM_DONATE:
-	case FFA_MEM_RETRIEVE_REQ:
-		return false;
+	case FFA_FN64_MSG_SEND_DIRECT_REQ:
+		return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool do_ffa_features(struct arm_smccc_res *res,
-- 
2.44.0.396.g6e790dbe36-goog


