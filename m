Return-Path: <linux-kernel+bounces-88344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEB86E049
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D7B1C20F33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F366CBFF;
	Fri,  1 Mar 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAM/HKXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE426BFA4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292616; cv=none; b=uzuqzlmhyQs1D6YXgLq0T4WSuhvCHB6RW8eU+I8OLDjmkRyDbSVOXlVHBmX5v+IEzS7jO0gPKgHIS7SNKakLP+6d4uCzzYHS9xtoOi3qUrHdd3FKOthhzY49+e2GuWkPdKT76lPViObshk8Pkz8oovHhxrdhrRr/6kHL01GehWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292616; c=relaxed/simple;
	bh=+oRThxcj3ps9wr+dkXNQtIKwQg+6L7ubdaoT5TWxYww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwLgn3Cx2Zy8V3IHrq5r4t6B+/9FLDkqlIE7UfFkSfukaQRNgsCTQjvggjnKMAOo6AK8+4WTzr2fpTSDc8owje562dPl5mzzib7eeJFyl1nJ6dfUsx9CpjiSvvSioOMf/PxXWupWP8Ny9B7clxharLlhnbFYWEjtKz2SzTdqdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAM/HKXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6/G3ufR6Nb0rp8kKGopKHt3c5V3Y56ocTb8Uds47XJ8=;
	b=FAM/HKXKATBHG4zwIDyIBx+l/aB+q/hd/acqq8I0IIo7axxsR4G43OD1N0pYw0Kd1ISrqm
	Cep/ZfZviTOkpp1jDR7Zuv9ZjaEghCUGhDaHEaU7g1jpEje82CBciIn4Z/B6g7FC2mOl38
	Z+BJcxlJ+c8CDWvzwxEs0BjTKSr/t/o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-k8qL7V8wP--Q9v3SdtTUSw-1; Fri, 01 Mar 2024 06:30:10 -0500
X-MC-Unique: k8qL7V8wP--Q9v3SdtTUSw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6818b8cb840so8651036d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292610; x=1709897410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/G3ufR6Nb0rp8kKGopKHt3c5V3Y56ocTb8Uds47XJ8=;
        b=Gb6tNXHH0Hkr3qM9YMuBBGJD7ujxJf46tmr+V35rnmSjNzO0i6BhOqdXvZuhpbfBG5
         U+1HLWhZ0GC36CWK9SnjIlflph+VzOPwBYfuV7QhaWwhL8sWShDE+khPtqA2olcrXwb9
         /SEFuzgxApSt6lINzw/WZ7/KapAfDUyZEi2Duvv8xO4T+gmzRUfsvg7AlD1NECA7Yl20
         4W6H1Ki8+FoXGDz4QfdnPUchMRMeLwm9ldiPawJIu7P0zmjEdQsoetc4FvD0rBudrXAC
         C4b/A/pPvZifB69oAP56O0EFIKpYpZcmwDQk7Eti0eZuldQyBDQgMZ9802eUQnuGu/fk
         Pwmw==
X-Forwarded-Encrypted: i=1; AJvYcCVg5X+JmqQGCMD0JR1VxflM+id7sHB40XAmKKuGWethcy8AKs4y4B5ZbaJAnbZnbkoXGWm6ftjYwDS2+WdS2+jOJMtUIvhc6qMxOKo3
X-Gm-Message-State: AOJu0YzlzKxoxMw0E3unnK3ojh0UDqp+Y02uN3LcBn1pJemRBvfo+V6k
	ksVacSOzKEiWxZwmAaD3oYtwG2vi818ClwKJ77FjlKbSV2E0Jaw6sFlWXr0HLXP37CaUcoyx7PN
	kc95cBKMGVUME6AvCy1sNUwNPYSWIgFRPeyBgdCAGBszdMwr43lBrRs3ndAAksg==
X-Received: by 2002:a05:622a:1aa2:b0:42e:8a55:f02a with SMTP id s34-20020a05622a1aa200b0042e8a55f02amr1436208qtc.1.1709292609774;
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHKUF+PUO5SDcV5IYLHAdLlF4fORhKtCX+2PkvUwBFPFfa9Zs2pE7fVUdk3eExP+LxG7kPCQ==
X-Received: by 2002:a05:622a:1aa2:b0:42e:8a55:f02a with SMTP id s34-20020a05622a1aa200b0042e8a55f02amr1436196qtc.1.1709292609472;
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:09 -0800 (PST)
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
Subject: [PATCH v4 00/10] Make PCI's devres API more consistent
Date: Fri,  1 Mar 2024 12:29:48 +0100
Message-ID: <20240301112959.21947-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v4 now can (hopefully) be applied to linux-next, but not to
mainline/master.

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
2.43.0


