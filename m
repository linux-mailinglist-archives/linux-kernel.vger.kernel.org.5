Return-Path: <linux-kernel+bounces-129266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514589680D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1954028D4CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA7134433;
	Wed,  3 Apr 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrTpIfro"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4706D1A0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131648; cv=none; b=Xs208TWx1WjHTOpIzyRFFHDcYdM0UF+KdShje+DarlX9SxUx3a0IzVmbb7XiUE1JoYL0eSijWRa3gDlMDiab+oKUu5m8Di/NkIvPyU+RbkeKhluf8Zt6q7PPjIWe0HUcaNVhDY7Bkm4eEzGCd1ACvjY5hYVt7aDrVkgktZ/INmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131648; c=relaxed/simple;
	bh=Q/H4nzMvQhmuggnPNAiSSe42t/cBVb0/0gTAVoZQgeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JtozZF/xRirL85V82u7Va5bIYpzjSK5oBufrxLATn4HwQ9Bk8U1pHyZxWMKj92PpYOjwE+eDroo+aV9fYP3SY4EYdoawVU77MY/cJ5UUN6xye/lPuoGn5PA6M+15bLKABDIvvBthUnVm9mOZix5sRte7zRjPt9JjILOnea8XmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrTpIfro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46k5EOtNpPpRezM1uLkG14XJOI7Jh+iRtVOqi3t9M8k=;
	b=TrTpIfroKa127fuxrG0n3ocwnnG7GbyXIS4E0tS606jSS2Nv/G+MCGaE/lllPJo6vJKrAh
	iV6KbY3wW731PBPAHxdijSvxqJV2R8AdagiqNrQA6DSg0w4yUxmz35IJpE9xvmDVqyozxy
	EWvWZ0NxPhU4OH2a/+sa93yv/0OS5P8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-68jz8uoZNHW4TQU_O3nV9w-1; Wed, 03 Apr 2024 04:07:22 -0400
X-MC-Unique: 68jz8uoZNHW4TQU_O3nV9w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34370209778so339170f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131642; x=1712736442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46k5EOtNpPpRezM1uLkG14XJOI7Jh+iRtVOqi3t9M8k=;
        b=rVmiFR2pijpvE/QEW14EO7ZQLz13aXV9ytJcDSMv88exONjLhHNNR9pbSOlr6sxv2y
         SzTTBaOoz0BWfYRXXu4jKcF+xOGdS+k2BhoIxA3X889UEhpWQR8XjzM+mqqg3qVPrlWB
         DXigl8onBlvektOYuByNtX2enNALHvHerpz1AJgReyjYJWCdWCDg6Wafk7MoqFpb0T54
         L1lUDbSGM6u6gOzXyVwrrm3NDeBSWnZ1esYhtBDXyFZMl1Av+5ReAOmraF4e168w0gaF
         zyRDzSZIQfCtIVS9MDmX7vumlFRHSEUERNZ2RU2zg7/5aOAZsSAKBjWYYFtH86qqvOFh
         5pqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHbBDI+lIGqPs/xWLdTsaftKVGIaskLq9MrNQF5aHp7+R7p7epzwlb5FDcQKIBVKwFWdmgBUYUjuJVFjL77Pam5hAVbPQfVq1opw0J
X-Gm-Message-State: AOJu0Yw4PDzF0TGcao7lfwrUZ4Ap/v9gVsGP6l5uV6Ktk27mjx/R8aFe
	daKVbvXes1hXSlX0GrIYDgz+RKRQEWXSvZbvoFrtHFq9SATuT7hLNoYlBJbaymEUfYRQCWmxrN6
	PY3vWtyQCF47oXyWoGJH2TBmQmQUPbqKr/t2lsMkjkYCWGruh2HxcyTp7xZ5zgg==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598225wms.4.1712131641731;
        Wed, 03 Apr 2024 01:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPlqw1V0i7idyMsB6HeezWkDKxElDOlk06ycKPdYELPgnLUzHbjveNDfaoy4XyWSI6DjV1SQ==
X-Received: by 2002:a05:600c:5114:b0:414:8084:a2e7 with SMTP id o20-20020a05600c511400b004148084a2e7mr11598194wms.4.1712131641311;
        Wed, 03 Apr 2024 01:07:21 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:20 -0700 (PDT)
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
Subject: [PATCH v5 00/10] Make PCI's devres API more consistent
Date: Wed,  3 Apr 2024 10:07:00 +0200
Message-ID: <20240403080712.13986-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I now regard this to be the final version of my cleanup, hoping that we
can make it to Linux 6.10 – otherwise this would end up blocking my
other work for another release cycle.

@Heiner:
Thx for the feedback on the other list. Since none of that was
fundamental (bugs, errors and so on) I suggest we postpone further
improvements of the PCI devres API to a release cycle following 6.10.
Maybe we could then even try to port drivers using the old API, removing
that one entirely.

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
 drivers/pci/devres.c                  | 1013 +++++++++++++++++++++----
 drivers/pci/iomap.c                   |   18 +
 drivers/pci/pci.c                     |  123 ++-
 drivers/pci/pci.h                     |   21 +-
 include/linux/pci.h                   |   18 +-
 6 files changed, 1001 insertions(+), 212 deletions(-)

-- 
2.44.0


