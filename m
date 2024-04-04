Return-Path: <linux-kernel+bounces-132268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E789923D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA961F232EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604313C697;
	Thu,  4 Apr 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHR03Hm4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8713C800
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274015; cv=none; b=eWONwe4J6azNiDaZpHTVtK5MDeBOCeGNkQi+vSPczzh4vP5+sr8VWbPWF8N3LDvd+4JuBtUPFYsr49NkfDSVASV9hPx5XhbAmncFx6cDy5JPF6jWzBUm5HDH9SMWHWVyOWKlVE/IQs0kSIZ1SX4DrATCX8MvIZG5bPHYzbBzu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274015; c=relaxed/simple;
	bh=ShNXKTKxsoV1gidL/jCEGh1UXFa8beTlPBREvu3TALk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8Tu44bm6S6ViLtoN0fjTW4/HpbIUK318zOkShU8SsJ9hz5y5YO1Ye2ACcDshiApXJGW1ufb5Zn9eOqvG8fVpTF398CLbwIZhNpyjV1rz4FbmZRNmuNER/ubtI1F/lu4iZcfueqnLLegN8Y7UjqgUrfdOIFs5BZredR6nb4c8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHR03Hm4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a2fec91d48so467184a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712274013; x=1712878813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=++a/hvLgm2LFaPeq7sJT2WCGQZL19kelVmxT81YyZ+I=;
        b=OHR03Hm4Yz6teVrcBEDj7uZYxtI/wK8o3p/VJxPH9QSOOUt441UucrN3CFoJG9ytlh
         8Wp2XnVg0rlKEsBzmbVjJx9XVoNcjdo5ZqA/FFlK8QagQeW9y+GucU1zKp/Z+1opadLG
         oS2vQ8Seofa5U36TUJzSoDqjbKbHld7YeqMGv3XgNF+p/l6eBpq04VfD7pfumuKv/fmp
         Rv89YUjYDuuR0ORxarFdlWX6/2SNNpTjfb1K/J4PkxeZaYNrqr9alRLOkgunNWw3gCRl
         m0u14fFC/k3WmbI3ykFb6CV44CyVeSKXM/usj/1iatqCLZkdNB5QZL56a8D3ezMoRi8E
         p7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274013; x=1712878813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++a/hvLgm2LFaPeq7sJT2WCGQZL19kelVmxT81YyZ+I=;
        b=kN0ZmvU8JDJx3gIRuqqldksRbuaD0bhwxa566kd1pP0hE8ruwEPR97ylFDCTJKQ+2A
         qABGE3gqmlck58rFSJZRixpuw+T3+TpcOpXUjD/USGUQDRykK3bnUDkrcvdZd/TeTjEr
         6iB2dlEl4tPnuWeBTd3WUMniTRvNqWyaTigBwdQVdUdh/Oo0no6UixpL7cZp7YN/1oTz
         FR7uUWm9O1fWBXWubkztLcliinOxg23c0qtAtgEdLfJUaSDSCy6bIggTpNaMKPXetUw4
         8RgKUvEkVb9W3fJMadNjKw2UTY7k/qzjW42K9T2ehyBU7VrVOPgVV8wT7PTVdGBNLsOZ
         r6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVoiylRZodpDPKLTsDo2HA5zrB0+P4stby0h+FbL/xYdpLD+/qJfMpSq5zsi1vqoOzdqOUqkC88p3TKtQje9a1mGusccWWByeFvRzdc
X-Gm-Message-State: AOJu0YyXOhjFky7EKdkx1VCKc5V+ovZIYWB6xDE58aFboYj/L4HuOMmD
	w1v7JpugxmQ3IKrhrAi+BqnAi2manPa5o9KTVUxsSZ5rrP+Nx9yvPn8r4f5zLTtRtF6Mi/Qoj1z
	P8g==
X-Google-Smtp-Source: AGHT+IFXyQGRwEJ/4fWcQaCNTSSexyUuvyDvbAc15+ionqqlW/lDl07k9yVGUcTvt59QeDxRQ5kPXvAaaLQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c9:b0:1e0:bae4:490e with SMTP id
 u9-20020a17090341c900b001e0bae4490emr38806ple.13.1712274013568; Thu, 04 Apr
 2024 16:40:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Apr 2024 16:40:03 -0700
In-Reply-To: <20240404234004.911293-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404234004.911293-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404234004.911293-2-seanjc@google.com>
Subject: [PATCH 5.15 1/2] KVM: x86: Bail to userspace if emulation of atomic
 user access faults
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Michael Krebs <mkrebs@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Upstream commit 5d6c7de6446e9ab3fb41d6f7d82770e50998f3de.

Exit to userspace when emulating an atomic guest access if the CMPXCHG on
the userspace address faults.  Emulating the access as a write and thus
likely treating it as emulated MMIO is wrong, as KVM has already
confirmed there is a valid, writable memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20220202004945.2540433-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aa6f700f8c5f..a9c26397dcfd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7105,7 +7105,7 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	}
 
 	if (r < 0)
-		goto emul_write;
+		return X86EMUL_UNHANDLEABLE;
 	if (r)
 		return X86EMUL_CMPXCHG_FAILED;
 
-- 
2.44.0.478.gd926399ef9-goog


