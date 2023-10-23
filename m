Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159D7D2BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjJWHr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJWHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBDBD78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698047194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lNB6/ff+rLs+rmxProTi0SrXX83HkuqfjEdd5Y/zzwM=;
        b=axkMRVU2hGVRxDNnmFiRnl7BTswV444eMtSXdXupyXwVhxWJMojr/CwZN2clKib8iqaevS
        9lUMJ1rOtV5kLS7HNWwkIszxbof8Xde0kxewK/+YE+sWJtKo2rv+uAjlCnOxwtcVyGqrgq
        i3LoXhsONZL7Aad5Mn+Br3CuiF1tjK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-NDkQTlfHMPSrvp9XuJ_SMg-1; Mon, 23 Oct 2023 03:46:21 -0400
X-MC-Unique: NDkQTlfHMPSrvp9XuJ_SMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09E4F88B767;
        Mon, 23 Oct 2023 07:46:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A318CEF;
        Mon, 23 Oct 2023 07:46:14 +0000 (UTC)
From:   Albert Esteve <aesteve@redhat.com>
To:     qemu-devel@nongnu.org
Cc:     zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@gmail.com>, banackm@vmware.com,
        Rob Clark <robdclark@gmail.com>, javierm@redhat.com,
        krastevm@vmware.com, spice-devel@lists.freedesktop.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mombasawalam@vmware.com,
        Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
Date:   Mon, 23 Oct 2023 09:46:04 +0200
Message-ID: <20231023074613.41327-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: Shift DRIVER_CURSOR_HOTSPOT flag bit to BIT(9), since BIT(8)
was already taken by DRIVER_GEM_GPUVA.

v5: Add a change with documentation from Michael, based on his discussion
with Pekka and bump the kernel version DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
might be introduced with to 6.6.

v4: Make drm_plane_create_hotspot_properties static, rename
DRM_CLIENT_CAP_VIRTUALIZED_CURSOR_PLANE to DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
and some minor stylistic fixes for things found by Javier and Pekka
in v3.

v3: Renames, fixes and cleanups suggested by Daniel, Simon and Pekka
after v2. There's no major changes in functionality. Please let me know
if I missed anything, it's been a while since v2.

Virtualized drivers have had a lot of issues with cursor support on top
of atomic modesetting. This set both fixes the long standing problems
with atomic kms and virtualized drivers and adds code to let userspace
use atomic kms on virtualized drivers while preserving functioning
seamless cursors between the host and guest.

The first change in the set is one that should be backported as far as
possible, likely 5.4 stable, because earlier stable kernels do not have
virtualbox driver. The change makes virtualized drivers stop exposing
a cursor plane for atomic clients, this fixes mouse cursor on all well
formed compositors which will automatically fallback to software cursor.

The rest of the changes until the last one ports the legacy hotspot code
to atomic plane properties.

Finally the last change introduces userspace API to let userspace
clients advertise the fact that they are aware of additional restrictions
placed upon the cursor plane by virtualized drivers and lets them use
atomic kms with virtualized drivers (the clients are expected to set
hotspots correctly when advertising support for virtual cursor plane).

Link to the IGT test covering this patch (already merged):
https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html

Mutter patch:
https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html

Michael Banack (1):
  drm: Introduce documentation for hotspot properties

Zack Rusin (8):
  drm: Disable the cursor plane on atomic contexts with virtualized
    drivers
  drm/atomic: Add support for mouse hotspots
  drm/vmwgfx: Use the hotspot properties from cursor planes
  drm/qxl: Use the hotspot properties from cursor planes
  drm/vboxvideo: Use the hotspot properties from cursor planes
  drm/virtio: Use the hotspot properties from cursor planes
  drm: Remove legacy cursor hotspot code
  drm: Introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT

 Documentation/gpu/drm-kms.rst             |   6 ++
 drivers/gpu/drm/drm_atomic_state_helper.c |  14 +++
 drivers/gpu/drm/drm_atomic_uapi.c         |  20 ++++
 drivers/gpu/drm/drm_ioctl.c               |   9 ++
 drivers/gpu/drm/drm_plane.c               | 120 +++++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_display.c         |  14 ++-
 drivers/gpu/drm/qxl/qxl_drv.c             |   2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c      |   2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c     |   4 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c      |   2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c    |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c       |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c       |   9 +-
 include/drm/drm_drv.h                     |   9 ++
 include/drm/drm_file.h                    |  12 +++
 include/drm/drm_framebuffer.h             |  12 ---
 include/drm/drm_plane.h                   |  14 +++
 include/uapi/drm/drm.h                    |  25 +++++
 18 files changed, 245 insertions(+), 39 deletions(-)

-- 
2.41.0

