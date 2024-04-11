Return-Path: <linux-kernel+bounces-140575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA08A1658
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083ABB21236
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B314D708;
	Thu, 11 Apr 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EeQeVIsI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9528FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843829; cv=none; b=eDOl889P9ipwP84ofEDN7BvDu4N/7U8u0B20FC2xJifQqAoh5glJJKLiiKI+qLVXamfvNKYKPRuJBwmPLl+hmsGtOMAkrltZ4lBIg6VlwxdZ6+LSJRbTbSjV80+muMMa4WNyt8xyOJqgtKnBs9QgBQa48t0BwgmFqCN8FYzq3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843829; c=relaxed/simple;
	bh=rj7jL0inBOSEZHgrBXiWcOt4NTfoLLf41Owd8e/QN1E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pQ2l4n9qa83G0aBzwZt2wVwkK4TU2RGvQBlWioTmhErrz7IaNNj4oAZHSsPD2LBmuW3tj8xJD1s6cFvpEdYXzHSpKJWraJQIgCu/ybDMg23Yi/wXTph25TyjjyBwyhb/os1YJ9Dd7QBFX+DCorAJX4AS13V/8PGkqrwJNZ1JI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EeQeVIsI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so12402414276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712843826; x=1713448626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+EIh4GaKjBC89iq3H7JjSUXThXK2r+ggs0qQY84omw=;
        b=EeQeVIsIfcs7TDjcit2gCobKzYVdbwOaxbRNbJE9JQRcsYK0fHeJ0t8qWTbP4wI9QX
         vEZ+ez2Hr0NCsohQqntSFniTVwg8QtFYCiEsXfBvvqhxleFRm+Wa0reSQSx3WB8oKNZw
         xW5DRTddgJA1pDcZ4vjiEaNHp202TAF4mz3M4t8Ipcc6GAadcqGKVZZdGLm7YAQDOL9I
         ZzISdN4YZlz+dzOq7uWLaMy4FZ/NoC6II/w/+8Z2b6R0QxHPZDKMQ8xZNMLA5u55y1WN
         /YqxsSSU8ivRv2r/fEeIRUG1yzdOB3yolYYJsW/bb4xH67Pvw90qbOlYVSjAqBvyACK3
         kDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843826; x=1713448626;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+EIh4GaKjBC89iq3H7JjSUXThXK2r+ggs0qQY84omw=;
        b=Jy9+P+k0agOef22KKwHhGaXLny4sjHErfDm+SkexzhHDMzzlG6OCkGUiZZG7b5CoBG
         RH1YaNJSILt0eMTBYYuV++A6HaFAm5RbYzbSOcBUn6E2bnDEDAoAvT1XXOE1ACHAdz+5
         /AGELGg+Lf/grgA4ZvKOhYOr6Cga2Q2bB4L6dXmcPDTCEcO0idShQVSXES1AmJFynSzA
         e8aTAOOlJ49Zq5bu/1Kb3kHSy4uxIalzHAL+G2bNz4wkbEVLiHKai2WP8ju2QQF/J+UQ
         vPnX+Vz5Kw3MaxSNaYWR27VHizJBXmOvvey0Rywmggsbx4tweHUBd3aspJJi4535ukTd
         AIaA==
X-Forwarded-Encrypted: i=1; AJvYcCUbhIZ1Kn/U43+tO5OodKy9812jhRjSDZHu86vRokwrYpN22mXFF4pGkIRSeuFLszYOS2oHt06KHf1OlKz5UKjSBs/Wp5Gsx+nlTazQ
X-Gm-Message-State: AOJu0YyS6Lhfcee1LVrRlv8a3FLWhzFYmWFmsutl4GZagoisg9cJKLA9
	1Au1dSNlLQ1KYT/TuldHipfAeT5+uuJZ6cgmYGClypXCYgdPFQc068HDGDEVMJlghtF+FrCI+Pr
	6F8+expZjwUirXPQlvGK8+xaqvA==
X-Google-Smtp-Source: AGHT+IEwnm375fG2EIsGyufwb0TdVTVsW3fmGnrbbBqhe480E3BRr8U08k6owLTh9FqdJqCEg0fO34CuUpQr+Fmo7L0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b83:b0:dd9:1db5:8348 with
 SMTP id fj3-20020a0569022b8300b00dd91db58348mr1560194ybb.8.1712843825763;
 Thu, 11 Apr 2024 06:57:05 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:56:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240411135700.2140550-1-sebastianene@google.com>
Subject: [PATCH] KVM: arm64: Remove FFA_MSG_SEND_DIRECT_REQ from the denylist
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, qperret@google.com, qwandor@google.com, 
	suzuki.poulose@arm.com, tabba@google.com, will@kernel.org, 
	yuzenghui@huawei.com, vdonnefort@google.com, lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The denylist is blocking the 32 bit version of the call but is allowing
the 64 bit version of it. There is no reason for blocking only one of
them and the hypervisor should support these calls.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 31ad740137fd..0df217bb2194 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -601,7 +601,6 @@ static bool ffa_call_supported(u64 func_id)
 	case FFA_MSG_POLL:
 	case FFA_MSG_WAIT:
 	/* 32-bit variants of 64-bit calls */
-	case FFA_MSG_SEND_DIRECT_REQ:
 	case FFA_MSG_SEND_DIRECT_RESP:
 	case FFA_RXTX_MAP:
 	case FFA_MEM_DONATE:
-- 
2.44.0.478.gd926399ef9-goog


