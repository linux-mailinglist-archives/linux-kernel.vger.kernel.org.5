Return-Path: <linux-kernel+bounces-35021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06244838AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B36D1F21C06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25459B7A;
	Tue, 23 Jan 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCaNr30v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638B5F550
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003091; cv=none; b=JabLNXXoOlwzOxEMa8FW9fRDQfeqSkYfyUi3w+ZcdhHcVhRIKhPUV5KbyFSjndTMPXcCWhmaOFmxLqKWm8zpGZzKCR0kOJoFVI739Hcqdn3PYuyJOH531ENFBkr95xnlSKW3MJqwHVIHPOuugTXv10mCTHBqZ/v6UzizcTL/agI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003091; c=relaxed/simple;
	bh=JFTLW1kaMuZUYxU3cw/LJma88IOra9rBHQOxZf6SLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cCAp5cEI52WGSXq1fujJbD0YJHCpF/E9JVB/wxjWExMXZ3ZPCFl7uYYdtvuo/RqPjR0GRIS+YL+Ipcu3RUZVro83CTpe4cSk8S8Ezb3U8uUdSbT9p4jJdM7yAC4BgvdRduIN9J+5B6w1Sc6Q+PY66lwwQO9tgCYTtqp39cmDqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCaNr30v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cphQXX8XuT1Nm7Usg0W5GdqAqwTrHKAeifLIKj3Ewws=;
	b=GCaNr30vjmUnMWNgzlMKrtWesaJ7BevomQBS7ixHbPPS1b1YuURZmx4UFF+Cuso+zbPfLi
	y0IFvTrYRl/ZGixtZixSTr9PYpaBC+/4CrwZIsGTme7eqKeUdDhAqZyPo/RAtwoJ3XNit8
	FchvNS0DL2xZS2TylX8w5u7Bb26Rwto=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-d4CToPYjNjeMWc3NyOC2DQ-1; Tue, 23 Jan 2024 04:44:45 -0500
X-MC-Unique: d4CToPYjNjeMWc3NyOC2DQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78313358d3bso124590485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003085; x=1706607885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cphQXX8XuT1Nm7Usg0W5GdqAqwTrHKAeifLIKj3Ewws=;
        b=FpJGAZPlEJ/smiJfxOBj/dEZ7Y0yNPdoqAeW6vn6rgzFTUlXLUPTOBoFK68H7jqHyo
         AOqWmsEDZghTKDK+Tj4PbF4GXWlq5SW/eunFyOXsdQ+Mf00dWYlItxh//rBYLdYxD+a1
         E4k4OKl+ylL9LHJ0E0tZmqz/lmURwyyOrbx3bH0YYnoe+5YM4p8iVELhSlnWCgeu1hMK
         sPfMCbKhi0YppX32uw/J+0vXq1EuWIu5emptOLAWi1Cqf0KWyjmwWShEtv8XsVvwy5mi
         IjoRMEyc73lfOHoPWwB6LmKL7FaoK4APWg7YrqlYJDxASWsxwHND8/WTY+IqBGsmpvqs
         WeMg==
X-Gm-Message-State: AOJu0YxciiNCy1ZX7Zia0kedaULrj19OQvpc+xaMU8H8zBwt26gbA6L4
	aGpzlOwbuoSlRc7h3SUyl2AuKUYG97e3aKwodGBHpHu/0Ic8bNlqI/anzizLSMvUC55rTJwtK3T
	HfQ/YeRAxw3rxEcrZYA+pBhWeU8riKMFD45Y8JHJDHJcuVJFHziZJKeBWJzyO0Q==
X-Received: by 2002:ad4:5aad:0:b0:686:9f9e:2963 with SMTP id u13-20020ad45aad000000b006869f9e2963mr1450869qvg.5.1706003084848;
        Tue, 23 Jan 2024 01:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDCQ2aTilrii2HWL3KnMWgohNXX1WVQoFY5wh45yF59z1xc/IopVs+Mm8bKJtO7SF5i4FZfw==
X-Received: by 2002:ad4:5aad:0:b0:686:9f9e:2963 with SMTP id u13-20020ad45aad000000b006869f9e2963mr1450849qvg.5.1706003084364;
        Tue, 23 Jan 2024 01:44:44 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:44:44 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 00/10] Make PCI's devres API more consistent
Date: Tue, 23 Jan 2024 10:42:57 +0100
Message-ID: <20240123094317.15958-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
  PCI: add new set of devres functions
  PCI: deprecate iomap-table functions
  PCI: warn users about complicated devres nature
  PCI: make devres region requests consistent
  PCI: move dev-enabled status bit to struct pci_dev
  PCI: move pinned status bit to struct pci_dev
  PCI: give pcim_set_mwi() its own devres callback
  PCI: give pci(m)_intx its own devres callback
  PCI: remove legacy pcim_release()
  drm/vboxvideo: fix mapping leaks

 Documentation/driver-api/pci/pci.rst  |    3 +
 drivers/gpu/drm/vboxvideo/vbox_main.c |   24 +-
 drivers/pci/devres.c                  | 1015 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   25 +-
 include/linux/pci.h                   |   18 +-
 7 files changed, 1011 insertions(+), 215 deletions(-)

-- 
2.43.0


