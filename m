Return-Path: <linux-kernel+bounces-137423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD7C89E1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC581F231B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D673156861;
	Tue,  9 Apr 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RgGbTiS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4C15667A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685072; cv=none; b=OfF18I+V85ou+SqOlpKgZSJL2BLSoJ/FBsQUeNli9Go4X4LAI39z1svQnYrVWM/CfrQDDh72p0Q3X+KQfL5HRAEoJtCg75Prwpv1RP2CIk4+sZm+nVEtgeDxQ+lhYOUTE+i5E2QmvNzrsu5jKWAFNcrqdKO15q7CC8gP+7lUgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685072; c=relaxed/simple;
	bh=7CKVGLEJOhMrsVcoFnVtIefSpMJClF53TVcgy2tA/2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r8aXDR5oUylrZPj8qbdgNCHlEV9O7F/omrpgeJAbEYiFOWoSvXUVcK9bZKwKU5Bh56o1cSTGDiqpOGntUhGm4c8ZjPYUpYJ+YtueN9g4yi8VHCFWILf98zaAI7Rbo8r6SVXq1Xwxw0N0dIWrrmpJfGJnT6oCpHOyu2prQ4pSDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RgGbTiS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f06so69179817b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712685070; x=1713289870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5eLSr5afbvnu0+fDPQYrl4RtiR5hKH4QirhAQ7AdlA=;
        b=1RgGbTiSWbgC+I/98yIMFAg4KlC9aORwJnHZsSQ8fhyEqaL8k5Y3qv6ZCNpNUQlwft
         HHmUOPEPPihtj656PE8R5s3DOruq+GaHnYTURrO4tL6DquGQkIUrcxsJk34KSrvCEBvT
         zghFcmS2fF3dVYy+mBjU6jbl4Zc9yZ4ttiCbwowLqAZsLMLCPs8BhQ/hUBx5vJdp5MsE
         jcn6H/htWh19xzGvGe1kg79huDQUT1lI6u2bBQ99XWqvVWcvxbdNkTnnNn79oy7D7A8s
         SGk729gtxaseFV/AynVoaus736Myjma8g/1fFoZxRkBHn2FLPqMsra63ZIVqj0O6QftF
         NeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712685070; x=1713289870;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5eLSr5afbvnu0+fDPQYrl4RtiR5hKH4QirhAQ7AdlA=;
        b=ugryF8PjDZEU9HTRjK2qFdoclOOGKzAUFo4D8YmOmFOMxSB6uI6UPjHoBw1kprcvZo
         CABaSoBJsS6/DkbOM9aP20i2koFncppE/nfzaI0SXHhuVeT6D+xPh9B3fkqiJoTK05zN
         DsmynPh2XnBgU1uFFZ84jFMdr/Ym0QoUHb57KwNnES/r0L4Qs4HE3bGedAXFrFsB6m7Y
         kLc613PbyeDVY4r2k5YAQd+YuHKvGDnTr70flr6+QH8jj/aXVMAUhmyNJ0L8tOdyHwhf
         Ybn0cdxzUeVyWJwxIN3gYYAzJCDw55GCiNT7y8lwPDxTob4FM+USE/1Bm5wU8Bhx3sYy
         HFJA==
X-Forwarded-Encrypted: i=1; AJvYcCV1wz9wVu0Sn6KUa75jNGQCWRhFsmi4XN1Taatgw5VMHGA6haYqKjnyK5ZVgbg9DEtkAUuYmAjcgZV0b0fnS5r58BCB2MfwGMJO8gi9
X-Gm-Message-State: AOJu0Yx6YfCYHjdctbOyEw+23nznGwtcHIsOyzlLtSk72kUV28awLWFv
	qzCq5lOzIkjHlgeW5xdaa0pWqlDKX+Y04nG9CstrvBA5HlcsxDXYxqsGbpawy9VIiDPOl9EygFP
	S0Q==
X-Google-Smtp-Source: AGHT+IGuj/QQ0/BEcuSpdkZRZJhoXvNvl8rW+Lfime7OMZS8+VMZrjL6Ff0W5H6V+gnKuvGIuG9t7tilq1w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:e6c1:0:b0:615:ca8:6058 with SMTP id
 p184-20020a0de6c1000000b006150ca86058mr52080ywe.5.1712685070361; Tue, 09 Apr
 2024 10:51:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Apr 2024 10:51:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409175108.1512861-1-seanjc@google.com>
Subject: [PATCH 0/3] x86/cpu: Fix SPECULATIVE_MITIGATION=n kernels
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix the handling of SPECULATION_MITIGATIONS=n so that it actually does
what it says it does: disable any and all mitigations.

And because I don't see a way to provide sane behavior for overriding
SPECULATION_MITIGATIONS=n at runtime, explicitly disallow doing so via
the "mitigations" kernel parameter, e.g. so that the user at least knows
that their system is still likely vulnerable to a variety of issues.

Sean Christopherson (3):
  x86/cpu: Actually turn off mitigations by default for
    SPECULATION_MITIGATIONS=n
  x86/cpu: Disable BHI mitigation by default when
    SPECULATION_MITIGATIONS=n
  x86/cpu: Ignore "mitigations" kernel parameter if
    SPECULATION_MITIGATIONS=n

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                | 10 +++++++---
 arch/x86/kernel/cpu/bugs.c                      |  6 +++---
 kernel/cpu.c                                    |  5 ++++-
 4 files changed, 17 insertions(+), 7 deletions(-)


base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.44.0.478.gd926399ef9-goog


