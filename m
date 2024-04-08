Return-Path: <linux-kernel+bounces-135060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3789BA8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B0B22187
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45C3A1B6;
	Mon,  8 Apr 2024 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K53y7SIT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE039FC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565874; cv=none; b=HLHEh0afn2+648W0AFAxZdbD1bNwhQCgXqeaqdfRFiCduKWfB7CfravZgwV72QPKK8EiPaaxvzdgexVRn6adpzkszhmVmi6bc0ZFOS1NumOVLThQX934Wvqce314yYY8Y33d7AR+vdRGEoZ14GTsWUIPvPx3Qr+MOHhDBFYU8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565874; c=relaxed/simple;
	bh=IAogvOcATWo2UHrFcxB2KYks+D0MIT3UGiLbW1wMbag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kP73AEBtfmPAsG3tZ38C7wUrwulWuacnZfg/WW87HRTdAfQyRBrScrL5IYwl2IHeOGEO0f7Ax1B4jkT2051DKifnqO+dzYlsJe6A06ZSlSVeXHWuNQADuLUxSPMynBEzgytxBsJjA2EKv3XZ9Tt6ZmIl9y4ajaXixdqvTkIIXXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K53y7SIT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d001lAD3qdFhL1jiZqzes39oJoG6dz7X9cNnKIOVG3A=;
	b=K53y7SIT2+s57dIbJ4jhAH2cF862sknqYqjIILZqgpf0ihKzSsg4SGciVtxNHgeDfwtFUQ
	rVBbLNI9FlRzAWS9jn3Ph5BIkR4ZLjc7K5K28Q+aDJH/rL/A7sv9Nc5zcnRTcihP37b6cI
	5hQ2OOh3z1a8s2DHMv0d2Ote8WZcXk4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_Ut3NGSEMBS5DSzrczhwHQ-1; Mon, 08 Apr 2024 04:44:29 -0400
X-MC-Unique: _Ut3NGSEMBS5DSzrczhwHQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78d346eeb02so182029585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565868; x=1713170668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d001lAD3qdFhL1jiZqzes39oJoG6dz7X9cNnKIOVG3A=;
        b=Z4AqUwmQba0KzbvBhB7VkalGfbkixy1bnmyq1lvdpIXthWGQK+dOJKK07JCWn6Eitm
         81DrilcKUHnrllwfaLIbhFJHiI8LoakHecDovB6GGDzomkz58MM9B2merZVSiPOIlTlq
         YVbdYzD8J72YFo8haux4fj+P/3+p5Bd6tVTYpd2qz5XYhZ5fHazPPUmqCb2MgPhZWTf2
         coRbmOO5rfC3h0g0CArckjp+K+4ENmEF/h1G2kc+xN/kQLZBIip6XotNz0IJWxTpWQYU
         UfB9qnkd0U5ixP+dVTeQNek/SkQNU7u5Cq5GalVEEHKRiBiIfk0qYnuqcrB3bzcbmuMl
         AolQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh/vZOXp9pWgJ5xc99OthvpSlii9pN3VDwPLvCOMSSHOxkHLoC2lOSdyKYNPZc1Oxcv+pyPBRKGB0jOU+J7D9WrB8h0NnZYCnNXX/e
X-Gm-Message-State: AOJu0YwBPjMVuAJ0r3MavMi04j6FVbaIEs5IFLbgxCWd0MyIXqCrUKgj
	NStMGaVcSAFknxlYrqJNgLLFLgg6mgpmrfnt9S6T5oNhCdHKJ4TejWODwX1MQ66bLRorPpLZzQy
	/jtuqghzD0NJJvs2MaJywCg56f8Av5m9TzsfBdnE0qVgP84Jiab2lz8Q2jp9D0w==
X-Received: by 2002:a05:620a:4154:b0:78d:6978:35aa with SMTP id k20-20020a05620a415400b0078d697835aamr448085qko.0.1712565868647;
        Mon, 08 Apr 2024 01:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ6H4YaYzmGoDEmgcQrm4a1neORRX6/FgF2RK851AHjC5ozf510YYDnM0NrHdnKQbWb8gHNw==
X-Received: by 2002:a05:620a:4154:b0:78d:6978:35aa with SMTP id k20-20020a05620a415400b0078d697835aamr448070qko.0.1712565868271;
        Mon, 08 Apr 2024 01:44:28 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v6 00/10] Make PCI's devres API more consistent
Date: Mon,  8 Apr 2024 10:44:12 +0200
Message-ID: <20240408084423.6697-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v6:
  - Restructure the cleanup in pcim_iomap_regions_request_all() so that
    it doesn't trigger a (false positive) test robot warning. No
    behavior change intended. (Dan Carpenter)

Changes in v5:
  - Add Hans's Reviewed-by to vboxvideo patch (Hans de Goede)
  - Remove stable-kernel from CC in vboxvideo patch (Hans de Goede)

Changes in v4:
  - Rebase against linux-next

Changes in v3:
  - Use the term "PCI devres API" at some forgotten places.
  - Fix more grammar errors in patch #3.
  - Remove the comment advising to call (the outdated) pcim_intx() in pci.c
  - Rename __pcim_request_region_range() flags-field "exclusive" to
    "req_flags", since this is what the int actually represents.
  - Remove the call to pcim_region_request() from patch #10. (Hans)

Changes in v2:
  - Make commit head lines congruent with PCI's style (Bjorn)
  - Add missing error checks for devm_add_action(). (Andy)
  - Repair the "Returns: " marks for docu generation (Andy)
  - Initialize the addr_devres struct with memset(). (Andy)
  - Make pcim_intx() a PCI-internal function so that new drivers won't
    be encouraged to use the outdated pci_intx() mechanism.
    (Andy / Philipp)
  - Fix grammar and spelling (Bjorn)
  - Be more precise on why pcim_iomap_table() is problematic (Bjorn)
  - Provide the actual structs' and functions' names in the commit
    messages (Bjorn)
  - Remove redundant variable initializers (Andy)
  - Regroup PM bitfield members in struct pci_dev (Andy)
  - Make pcim_intx() visible only for the PCI subsystem so that new    
    drivers won't use this outdated API (Andy, Myself)
  - Add a NOTE to pcim_iomap() to warn about this function being the    onee
    xception that does just return NULL.
  - Consistently use the term "PCI devres API"; also in Patch #10 (Bjorn)


¡Hola!

PCI's devres API suffers several weaknesses:

1. There are functions prefixed with pcim_. Those are always managed
   counterparts to never-managed functions prefixed with pci_ – or so one
   would like to think. There are some apparently unmanaged functions
   (all region-request / release functions, and pci_intx()) which
   suddenly become managed once the user has initialized the device with
   pcim_enable_device() instead of pci_enable_device(). This "sometimes
   yes, sometimes no" nature of those functions is confusing and
   therefore bug-provoking. In fact, it has already caused a bug in DRM.
   The last patch in this series fixes that bug.
2. iomappings: Instead of giving each mapping its own callback, the
   existing API uses a statically allocated struct tracking one mapping
   per bar. This is not extensible. Especially, you can't create
   _ranged_ managed mappings that way, which many drivers want.
3. Managed request functions only exist as "plural versions" with a
   bit-mask as a parameter. That's quite over-engineered considering
   that each user only ever mapps one, maybe two bars.

This series:
- add a set of new "singular" devres functions that use devres the way
  its intended, with one callback per resource.
- deprecates the existing iomap-table mechanism.
- deprecates the hybrid nature of pci_ functions.
- preserves backwards compatibility so that drivers using the existing
  API won't notice any changes.
- adds documentation, especially some warning users about the
  complicated nature of PCI's devres.


Note that this series is based on my "unify pci_iounmap"-series from a
few weeks ago. [1]

I tested this on a x86 VM with a simple pci test-device with two
regions. Operates and reserves resources as intended on my system.
Kasan and kmemleak didn't find any problems.

I believe this series cleans the API up as much as possible without
having to port all existing drivers to the new API. Especially, I think
that this implementation is easy to extend if the need for new managed
functions arises :)

Greetings,
P.

Philipp Stanner (10):
  PCI: Add new set of devres functions
  PCI: Deprecate iomap-table functions
  PCI: Warn users about complicated devres nature
  PCI: Make devres region requests consistent
  PCI: Move dev-enabled status bit to struct pci_dev
  PCI: Move pinned status bit to struct pci_dev
  PCI: Give pcim_set_mwi() its own devres callback
  PCI: Give pci(m)_intx its own devres callback
  PCI: Remove legacy pcim_release()
  drm/vboxvideo: fix mapping leaks

 drivers/gpu/drm/vboxvideo/vbox_main.c |   20 +-
 drivers/pci/devres.c                  | 1011 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   21 +-
 include/linux/pci.h                   |   18 +-
 6 files changed, 999 insertions(+), 212 deletions(-)

-- 
2.44.0


