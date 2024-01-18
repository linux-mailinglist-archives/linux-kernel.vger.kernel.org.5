Return-Path: <linux-kernel+bounces-30387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F0831E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC051F23136
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CB2C84D;
	Thu, 18 Jan 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXAHcms6"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DA2C6B8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597125; cv=none; b=WZ4hFNrtySWofoWUoLcTDvq+bNq8wdNq9yU4mRoufswtUH+9vSbMG09FAmFoZImRd7QFzno5FSycCqMy5H6EbwwFqnC0QePpok0ez/8Wcwrkfj0xXZtHSyGelm+9aK+oyF+S4ZCly//Qj1azpjpE4bc6S35QqisuJpPexV+uSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597125; c=relaxed/simple;
	bh=Z5thKj8FdeMPyV5/0e6dgRb4ppMPY94gIbrMAFviSyo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=PMsp0ZrGi2hjg+Y+xfqMYTUgRu054AnXIIBy2Fueak/CGKFku18ny5vPHbZQPx86GGhxgu84RNAHJ2GVJRcyr2oLXFAY7pei/AmaLaW/uldTlp/67kLY4JzjINgo/GVw21b8f7+u/I8G8RPG2I6hGDAyFt5uWTtOudzorfXTK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXAHcms6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cf962e1fcbso1532847a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705597123; x=1706201923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOJj2c9xW4mty6RVL8pJG7rPEgOg5AXdEBigC3Y4jtY=;
        b=AXAHcms6dIN13GnNTUE4FzFUwDA+eem9NXCDkkP1Od/czzNHTQr5OhOGk3QX0KEonr
         NFd962j41sNkyewHIRD2Pm8NuJ7Z9pSIC4YT5VAZHsNCzfr8w3UUtbiNs2ExsTKyMgCY
         VPP22Ti95YqC1gsjrIuJDDCdljmhHYMv/YSgrGox2+0Dd0pcidQqrQmHBKcGdqSRad9z
         W9gFvyUKaU7nAS7+3lDqzzr6LMANTRMi4pJ1hBq4g6SFR2+vQlGsqC4054u9TYqLwB7z
         Kw8ZvoyFNt29tMdbe+C/uhbzCIhoyWBLVxslky0kROZFzx4jGyj7dK8sMxfVr8sEh0xX
         Jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597123; x=1706201923;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOJj2c9xW4mty6RVL8pJG7rPEgOg5AXdEBigC3Y4jtY=;
        b=dcsz3++ALtA7cS/IoLnlWf7yFN7OtNU39jHVUdoviPWlsI702gnFxv2I6088ZrgBVt
         MzBYseF4KIyzV5fVbR4LSvWoHIzQz29r+w4T7xUvD+iCaGMF161KOaikSZLdBI050eyv
         w2j9nZnLkQZlgiwgpP3n/y9MOmoXKjs7PoPAhqPSkBclumbPV0ub6QuBRGPh5BchYWcz
         vA9L9UtGvgPhLBW8sntjDrIVKdHmqnL2l4DaAEnQVJlqYQ5LWsmNpeaqFXos5uWyRSBu
         d5kxxkbQlNVDtTDZaB98hOgX01chvobQNpTijFgHnHAhyU8huyM/SKh6pxr8p9dnP+P+
         eDdw==
X-Gm-Message-State: AOJu0YwD2zIoHsPZCZwB/V6Vj/19W7H4ruBXqvqkXzpyY2qy1IXpfzR7
	OKh+BOGEw2Gph983TAHqIEoT3VteXrTDPGg1rNuyRjSzjChNHHfQZxCMw5Fea/f6frehw5wELD0
	hbQ==
X-Google-Smtp-Source: AGHT+IGe39iSbo3pp4Oh1OoPuJaAYSL8rktRk+jxW6UtZTirBf1ZCu2iYHNI0H7nbbmWrSXesSiYDaEUb0M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2fc1:0:b0:5ca:3e8f:6d6a with SMTP id
 v184-20020a632fc1000000b005ca3e8f6d6amr6924pgv.12.1705597123202; Thu, 18 Jan
 2024 08:58:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jan 2024 08:58:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118165838.1934853-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Notes - 2024.01.17 - TDP MMU for IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Recording and slides:

  https://drive.google.com/corp/drive/folders/1sSr_8FE5KjjGGnpX7_QlHAX3QGoRnck7?resourcekey=0-UB_vbXfpY4Dezo9xI_-6iA

Key Takeways:

 - Having KVM notify (or install PTEs in) the IOMMU page tables for _all_ PTEs
   created by KVM may not be necessary to achieve the desired performance, e.g.
   proactively mapping in the IOMMU may only be necessary when swapping in
   memory for oversubscribed VMs.

 - Synchronously notifying/installing could be a net negative for guest
   performance, e.g. could add significant latency in KVM's page fault path if
   a PTE operation necessitates an IOMMU TLB invalidation.

 - Despite hardware vendors' intentions/claims, CPU and IOMMU page table entries
   aren't 100% interchangeable.  E.g. even on Intel, where the formats are
   compatible, it's still possible to create EPT PTEs (CPU) that are not usable
   in the IOMMU.

 - Given the above, having KVM manage and/or notify IOMMU Page tables would be
   a premature optimization.

 - Recommended next step is to explore using heterogeneous memory management
   (HMM) to manage IOMMU page tables and coordinate with mmu_notifiers, and see
   if HMM can be optimized to meet the performance goals without involving KVM.

