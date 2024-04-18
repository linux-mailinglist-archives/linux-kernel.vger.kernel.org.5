Return-Path: <linux-kernel+bounces-150482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C948AA00A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F903281919
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790F16F908;
	Thu, 18 Apr 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exoT6TDL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9F146D6F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457905; cv=none; b=g9H1NZlTC2mphgIlDN7R/EX9PI00JqwU50vak9SBwSBOSq94Ts+dzUCIjAKjG3/zxnArpU93AfzkBoBS8mM2VyFfZaMkjUuAj21QO6BjsR/TA0uLwE8msKrq3FZOu66hgfwcem8NFladPLDvC3cRYpHC3MHHuGcVLjvqvg3v6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457905; c=relaxed/simple;
	bh=LtaM0rVbLu1ag5cMKPQBBXdIfFxBnZiCY+XchhieBXY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WCHgKnwokMK9+fteOEFJvQTUHe8XsCM/EqXb97mRrmhP+GrmfHFL8w5RMp8jDDj7vWpP7JFaxwjNN34F5Ng5Wn9/NAUBYzqOY4h09/x9mor5XNo/XYlNTC0Ti4d5GrOSkaLBNzUZL27ceElEWEBrHlEwT36VRgZuudgZ4j4YJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exoT6TDL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de4691a0918so1565532276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713457902; x=1714062702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ltIrcV6ni9WJvy7sa5ZnYfA/lkvYHfjAr3qlJI9BUs=;
        b=exoT6TDL6T/WLYsxKp/03Ie+cRe8olgHKndwls+SsbcJxIAKgWGMckMn+mx2E+2Rfr
         0nXvYm6nfV9suXZbfLMTYn1zzmevpK4ql4FHtJ7P7F+ZHkthvyPoWHD6eiN2kt5p2SlC
         Q4YR8cDT0CSkVYYNqTxO9oBXz1LqlAJNscMr5VDyqkTkOrJ+HAVLIlx89R2gCP6wNN5B
         92HrgeB+7mng2aNmfY7DOYY43K9xskEm8X2ipjvjBX9o8tG7qpC+pZN5OW/o78wSu9No
         OY294BhU9hw6VynIKGLX4zz7d535AQ5jN/UURchTu4594BMT9viIMOwz4HkSMhtkV1fx
         e2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457902; x=1714062702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ltIrcV6ni9WJvy7sa5ZnYfA/lkvYHfjAr3qlJI9BUs=;
        b=WT/rshbg5LXkdqljNJV9Yrtj8ysdxQ0iW6rm/UwrMB+/iC8KsA4e551ACHRQbfcrGx
         RSvhWjgr4QKeo5cDcGHja1iR5M//3S1mfne07pkGdL5LIyJ4/aQ/pMfIq+B90RpxIIvO
         Z0saOSHgvbKKU91O8MPHNO12n9+9XRMYJH+Tx+0MeuDezDZQeM+XxuaUgaQYKgWEEbHK
         TyfjerzRrbXMlEQ82qXBACE4svX7Sp82nulIveF0E0M4FSLZTLxXaybNNpGDG1oV9+I/
         o8+RCn85jZk3P7aQTOreex843HMZxGbSsUDEcAc5TZkIjIRv3+bqgarpsTNOC6YPTHKx
         03dw==
X-Forwarded-Encrypted: i=1; AJvYcCVb7UYdYmTYtdLP3HO+T2htpOQlsF3w1chy7uhHghJUh+8sS8fBrrtskKpsogDG8QXJFrc//MVfK2OPsoDRyhiHFVQmGAc2/O2blsZw
X-Gm-Message-State: AOJu0Yw1HWFeAZPxvnJrrA0nOTfZgQICDa/AjcfbfIgxcvMTsjcTfokf
	U/UeYGB/RpEakIUD8ZzsvZnxw4vA+mUu9uQ94iRl4u64C4FD3FUKmPd9+Jalds3azysI4hMxKHd
	UAxo+mV/JyzFQFbJHG6i9CRh6dQ==
X-Google-Smtp-Source: AGHT+IFzgb9GhfjEE+RHVDZY8Qg+0blXGT4zq/hqyltCjF/7DK1aNMETobD5mbIf5ydAoE4XN1mqzHOyzsEw/eSY4Vg=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:1001:b0:dda:c4ec:7db5 with
 SMTP id w1-20020a056902100100b00ddac4ec7db5mr801945ybt.4.1713457901819; Thu,
 18 Apr 2024 09:31:41 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:30:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418163025.1193763-2-sebastianene@google.com>
Subject: [PATCH 0/4] KVM: arm64: pKVM host proxy FF-A fixes
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

Hello,


This series contains some small fixes for the host pKVM proxy code. I included
some of the patches that I already sent on the list as part of this series
to make it easier to keep track of them.

I verified the functionality with OPTEE as a TEE-OS.

Changelog:
 
* previously posted FFA_PARTITION_INFO_GET patch here:
https://lore.kernel.org/kvmarm/20240411133249.2134696-1-sebastianene@google.com/
 -> minor changes from the previous version, look for the current
    ffa_version in the host_buffer structure

* previously posted "Fix the identification range for the FF-A smcs" here:
https://lore.kernel.org/kvmarm/20240322124303.309423-1-sebastianene@google.com/

Thank you,
Sebastian

Sebastian Ene (4):
  KVM: arm64: Trap FFA_VERSION host call in pKVM
  KVM: arm64: Add support for FFA_PARTITION_INFO_GET
  KVM: arm64: Fix the identification range for the FF-A smcs
  KVM: arm64: Use FF-A 1.1 with pKVM

 arch/arm64/kvm/hyp/include/nvhe/ffa.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c         | 95 +++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


