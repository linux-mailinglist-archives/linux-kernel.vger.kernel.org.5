Return-Path: <linux-kernel+bounces-36227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D640839DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322BF1F2860E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28B137B;
	Wed, 24 Jan 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hViAUrDt"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F046A5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056748; cv=none; b=jjB7kRj9xDkMDrOXqCCp+Bzou5arze9l5u427rR6z6bG7nltBjYGbZ2BuQC29I98kLdyvaaTrAP2lvQ9d2P8vCWFTUbRjHn11HLGZrBcKvFuxrXnSfQPA0hUfuslvGaLUzmPdBxNwGkMcHD4vqlcd2x57azFfmtnkk/WzeD/H3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056748; c=relaxed/simple;
	bh=Pmes/76ATJ5iMBDiMOhOpvseICI7sfNxJbqpgCgJMKQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jAFpmoZe7QunORshadDd4UtcmSyeqro0dRL1x9GmXYdACTXDE47UF8f79IivPTsceilJQ6/Grm0Iu6zaX5jNHrvc/PUYhd+DV5Cmw/87knvcVWHWF9tP1zzYEpWhYwh4ylUhtKefW1MN+A5IjoHCNaDpSxXQTlnWM2n6aZihGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hViAUrDt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2904fe6c360so2822183a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706056747; x=1706661547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNqsPVxxueMRtem4HrgMeKqxFA/BzEkuov3VkZszacw=;
        b=hViAUrDtIwz9mNeYp5Uu8ND48T8wehWvUrIl2MHJXgcOTM5UvyQUKCk+FHpMIsfqKt
         Mo8r5cPdPTvFRjuHb1hr735HS8GxaRSqAGvtb+iRFWFG+uk2kV3rIf58Hcy0fYY9OjaM
         thkE+pwZWDVoIN6XDcOdtMfGuKDjSKytTh9fRcyuN5JqBnFEzMubH7Ooter8GqM9kPHA
         rPdtDSyZSTb8+wNbtYVLoDkxQv8vWHpf/tsS0ED0YV/Utejr1f5rzZgHRz4liXSRPo23
         ZtgSmr7yLn4a2Blnmt8QdQJIcan/3o8WAKBSbVZ+HXtSL1vnNHaETY9rE4cGkrNJ0QaL
         nDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706056747; x=1706661547;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNqsPVxxueMRtem4HrgMeKqxFA/BzEkuov3VkZszacw=;
        b=RSC8vPcZhDV5/Ey+jEYdh3PdffoGRJQF6M1CcKyBpfv/Sz5mRtchv69MBC2VMMRL3D
         eVfgwUzQgMRBnf/CqIN3HtUJjg3eQ/vfFxcLUd067IgOe/69dwHkp8MSYVYlUMB7cWtP
         aVfGemGQ4MsQPIpidzr9pnpPnbxsS2/qSP6Czshz5KjFGbLKySmY2f/KOdse18slBrPL
         0z80Mdqq0LXgtj1zp2u7FJ4L6xpCiVWc9kzgmWxuRg9BjNe2dxIuKBELZHzb+ABxApSu
         nkWzCfeUZWmwJRaK0xpCJBuoYA74KdXS/zdPPgUeeiEGmrYdkTFPAbVStlxIFhc1wr2P
         dmRA==
X-Gm-Message-State: AOJu0YxGUGVv2Di0fkgsaEHgu5cLLVtS+QyF/DFnAJP7r8XmFvJBsgqK
	zHxlghK7XalCxfB0y22oeQfLGpkTD0W42deEHLPU8AbC4JBjUaguJmRlAiIOH42nMZqDjL18ZDo
	zMedwrQ==
X-Google-Smtp-Source: AGHT+IEAovmuRYmPDtifaSMhBZecrlj5H2b7aFa6mvUPhCGRR9IzXqE4+RS3FksRX/0nVdwP3pLJ3MfOAsMc
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a17:90a:d255:b0:28d:b9aa:eec4 with SMTP id
 o21-20020a17090ad25500b0028db9aaeec4mr36954pjw.0.1706056746934; Tue, 23 Jan
 2024 16:39:06 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Wed, 24 Jan 2024 00:38:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124003858.3954822-1-mizhang@google.com>
Subject: [PATCH 0/2] minor fix on perf_capabilities in KVM/x86
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aaron Lewis <aaronlewis@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

This simple series fixes the value setup for vcpu->arch.perf_capabilities
to fix an issue in live migration and remove an inline helper in Intel pmu
specific PMU code to make the code simple.

Mingwei Zhang (2):
  KVM: x86/pmu: Reset perf_capabilities in vcpu to 0 if PDCM is disabled
  KVM: x86/pmu: Remove vcpu_get_perf_capabilities()

 arch/x86/kvm/cpuid.c         |  3 +++
 arch/x86/kvm/vmx/pmu_intel.c | 16 ++++------------
 2 files changed, 7 insertions(+), 12 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0.429.g432eaa2c6b-goog


