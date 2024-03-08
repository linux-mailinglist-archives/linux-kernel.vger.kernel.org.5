Return-Path: <linux-kernel+bounces-96779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE6876154
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5413E1C2222F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEA53801;
	Fri,  8 Mar 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytV3gF8E"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021C535D3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891656; cv=none; b=VK96tYv+92+G37qmC4wZeCkGA/03mcbGyzt8PjT3OKnzqdl7N/3Ym1T2B0H6QibWY5WebnzzkcC2I0zEPnSmkRGh+nnAb0XCT6EeTCPiIqLw1uKWeAtf9szv+cvFhek8+khHBoZSbt6YPUGiwc8H8AeQhckLnhsNb1YbTSH+aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891656; c=relaxed/simple;
	bh=PSSmdFEKXbQoDoLCkYh9gWPYZ30jQDOHJ1WglWyUdcI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gz7FyUZJ+Ek+r/kno5tqMwJLWfm5uh52/B7LyqC3qdc7EfxWXoGjL6GZg28t0sbifXN07sm+TZDhTeQSMwpBcuJRYO8JBXunXvyRv15pe4bAQ1YUkVQILtLW0Yv3wuhbRqUp8R3/Qku0MmuBa4k/bi6rd0kSiq3vX6AUQ+jMV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytV3gF8E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dd129acd2aso18372115ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709891654; x=1710496454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kd9b+xnVrsV0VnvP5BBobh+7armz3SPZmewGeAELg2w=;
        b=ytV3gF8EP34hyIMMZ2QJseL3LPVTrc2NDBdolJoM4xGO7CB8WcamB2r4NoVeAzmEYx
         Qz5UfThOrbqpQitYDhQ5VtwVcaDZFcIhShDnTgrBFxvvqzyf+LGvd8XsA3dEut77EOi4
         ZX3iVd0yYLeHSk1kigdvZfQYJ3ImxU1bH6aK1yqaU/17kosDWPtgIQd4filUi4zIzVrr
         ixVjafFgRONl5mrgwtIg47RlX9g3waUeFMZGMQ76NFY2tUuCIImG6JHCYrk5JGrn57qD
         SR8mm9LB7PqRfjWmBbS4trJ9PMNhmcrQOnOA4QtTU8sHQW0JPR+XA+fuuZvHwSC5Wtwj
         EFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891654; x=1710496454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kd9b+xnVrsV0VnvP5BBobh+7armz3SPZmewGeAELg2w=;
        b=GwzOQscCJS2aQNSnee4tT2EcI21D3UfCCnuisuw+ADuKCPvbNwhSWmvVfxFW46fuBg
         bWMELkQyMUlUaBIUgoLT4+Yhw52vGgPcFQSfy4D24kvWFcX6mBjHhgRfOnxyyMIhdSkF
         0FrmqKEpGxdiYnEg8oa0agfRbn7wKvpO8eQXIDDdFsSH6y+ezi6Zs152qhJn3ghgKt2+
         anl1eSwwFR3g40f3FcINTVHDCN6/kk5w+EQlHn1cIYItD2J8A73f4wfgjSBDKNaQZxAJ
         jgul9C+mLFJffHralFmId4Zr2X7Vl9HuWk21L+C3LSoxlwDvNvZGXDc/df72pTmcXGDX
         7iNg==
X-Gm-Message-State: AOJu0YyXtusk1/0a8SeKOF0v67xa8mquIgLpQ1Q87sIp3gfiY3DUAQh8
	ZMHhfmQvoOPOFFp0+Wim5xMTlun+Qq/mfDhY0Qn12L3iovQPK5jo2VR149A6IU9H4A3BgCOu+4F
	bTusPwm4pfooPBw==
X-Google-Smtp-Source: AGHT+IG7o+dh/76ogl6dMQx3yfx+ZlS2Tc2RH7CYeArGIpPrqv+Lt8uzvSvNDTz8wBfiHvp5wM9In7J0dxXtBnY=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a17:903:22ce:b0:1db:f7e5:afd2 with SMTP
 id y14-20020a17090322ce00b001dbf7e5afd2mr717431plg.12.1709891654099; Fri, 08
 Mar 2024 01:54:14 -0800 (PST)
Date: Fri,  8 Mar 2024 09:53:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308095320.1961469-1-howardyen@google.com>
Subject: [PATCH v4 0/2] Add support for multiple coherent memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the system I'm working on, there is an always-on subsystem which
includes a small size memory, and several functions need to run and
occupy the memory from the small memory if they need to run on the
always-on subsystem. These functions must allocate the memory from the
small memory region, so that they can get benefit from the always-on
subsystem. So the small memory is split for multiple functions which are
satisfied with their generic use cases. But in specific use cases, like
USB3 devices which support the stream trasnsfer or multiple devices
connect to the host, they required more memory than their pre-allocated
memory region. I tried to implement it in a generic way and propose this
patch to give it the ability to get the memory from the other larger
memory to solve the issue.


Changelog
--------------------------------------------
Changes in v4:
- Add the driver where uses the multiple coherent memory regions

Changes in v3:
- Re-org the members of struct dma_coherent_mem to avoid additional
  pointer arithmetics and the holes inside the structure.
- Use consistent naming of return value.
- Re-write the dev checking statement to be more clear.

Changes in v2:
- Replace the pointer(dma_mem) to a list_head(dma_mems) in the device
  structure and initialize the list_head in device_initialize().
- Modify the required changes in coherent.c.


Howard Yen (2):
  dma-coherent: add support for multi coherent rmems per dev
  usb: host: xhci-plat: add support for multi memory regions

 drivers/base/core.c          |  3 ++
 drivers/usb/host/xhci-plat.c | 19 +++++++-
 include/linux/device.h       |  5 +-
 kernel/dma/coherent.c        | 92 +++++++++++++++++++++++-------------
 4 files changed, 82 insertions(+), 37 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


