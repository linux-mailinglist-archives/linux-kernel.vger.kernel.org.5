Return-Path: <linux-kernel+bounces-111434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80955886C52
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210FB1F22645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CB94437D;
	Fri, 22 Mar 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugTkqFfb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A83FE28
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111444; cv=none; b=G2+yvsy/udrxP3PEzo8sS3cxgXDo9D04Sri0ewSK3czsPGJtUlNgp2enBifE0/N0DZKj0avZD88Un2RuX1Oc9YotHiPVQCAPcnyDO3r7MzZzfFhmo/oBp0Yj2ZMQT7q0/+X+IXtB5Y1Xy/9l9wXaT5tA0Mpt4XnNuUBu4rDXb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111444; c=relaxed/simple;
	bh=TFLtWqVtnfY3Ny77IqrCP4FTbQMx8MGubLMvGhIpAOw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MexFZ6NJWiMAc1ZWdU77CcqRmRBvs1IvuxiilyDSaLMT68pb0+RJPsVEBw//vaUOlNW3jeeKjJQ4UfUxslOkqDFkDSHUNx0pRO0XzsgeHThYU1NsworOfOFxMZGB/YG19o47LWrkfz/7ADXTCOhOHM1aU6SVE55aYA0lBVASdPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugTkqFfb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b18e52dso24351037b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711111442; x=1711716242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBPzH8uDG5g28i+V0dmYxrEXrjob8o+00KlgZjV6q1c=;
        b=ugTkqFfbmhPpE7gp9RJUedmEIeDqvcV2Q7/tu/YpqiB7O1OG6WBBkxvqjkHn3/NXYd
         vGx1zOn0Xal3gyFCY0/Dpi9RroyGM86GzZQyig+4vuSF2p1hf78g8u+hs6mVeFyxFn+u
         ciIFWdF8LpWHlV+WcBivsiZOPzEIob+0/TLh21xmFcwr4vQ+WVy7ZfWmZJru0pkv8JaG
         UNur140eY8FhTJejgJNy1QntAJQG2ToDOeC2N7w35vsEnYtbKdFhS1Uh9UhkRII70cCD
         UXibrCRNBr/pczwFGdaprozWqbGxHMCMOODDLPD3UHvXvrFXH/SiKQZEPRDazryVeEGv
         z5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111442; x=1711716242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBPzH8uDG5g28i+V0dmYxrEXrjob8o+00KlgZjV6q1c=;
        b=GcnpuKhQzMOVKo/MgBrrQ3MHnQ0+88PHxS88IuiZtgB0qojs/qz9E4i02NCN2LJyxH
         P4b9vxvS81fdyT5fNc6nd6lkMUc0ShCOcMfbMywfDdzRuk+15a+9TCW3ZbGtCvCuY9l6
         TR3642ApvsNdhXWpMpRE1LlQ37xCYWmKnYmJUOWJQrJYC9T0ujAiLttwiXK6xVRTC3br
         0YpFKIrW0HHSSaXf4qPTwO/j/s5ADxz7Jk1PTCsvLcnRT1dA0PqSQ3OfJgO1u7iAj8NL
         /QVuiechrBdOmnqSlerxvpvLHQnyeBX7PXmght+DeSbCK6OBhX+PkQt60ffjUw22Khmb
         8xWg==
X-Forwarded-Encrypted: i=1; AJvYcCXGZjLSeVPvsfJ7y8oWhYGq1zkRQ1HgknEG75XrCrNaVSQIN5ENc1NalUBAgjZtVGwf0eJl6G2LZ24zfB6oJ0WYihHC5FipS/IwemLZ
X-Gm-Message-State: AOJu0YwOFWDQe3qwpE7945+Gd9s3Q6KBXtagwQjniH/kJwd2Mq3N6oHc
	vd4Kmc385wD68qOw5uDXOU00XJJLT5mz1ubmm4gvYuHEiAXZFiankvDqvxYVGNL7EEibpogt9/H
	rT28H936lBhw/3EzmHEObU3P9Fg==
X-Google-Smtp-Source: AGHT+IFzf18KZ0iBCrjW/8R/6z+H2nXgPj8YuTFxRr7MGr6I4rYMt6hvaFHDr1At0VKoydLVvbh6cjlq/HBZLuTcqXQ=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a81:4fc5:0:b0:610:dc1b:8e57 with SMTP
 id d188-20020a814fc5000000b00610dc1b8e57mr560266ywb.3.1711111442517; Fri, 22
 Mar 2024 05:44:02 -0700 (PDT)
Date: Fri, 22 Mar 2024 12:43:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322124303.309423-1-sebastianene@google.com>
Subject: [PATCH 1/2] KVM: arm64: Fix the identification range for the FF-A smcs
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sebastianene@google.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The FF-A spec 1.2 reserves the following ranges for identifying FF-A
calls:
0x84000060-0x840000FF: FF-A 32-bit calls
0xC4000060-0xC40000FF: FF-A 64-bit calls.

Use the range identification according to the spec and allow calls that
are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
identified correctly.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index d9fd5e6c7d3c..146e0aebfa1c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -9,7 +9,7 @@
 #include <asm/kvm_host.h>
 
 #define FFA_MIN_FUNC_NUM 0x60
-#define FFA_MAX_FUNC_NUM 0x7F
+#define FFA_MAX_FUNC_NUM 0xFF
 
 int hyp_ffa_init(void *pages);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
-- 
2.44.0.396.g6e790dbe36-goog


