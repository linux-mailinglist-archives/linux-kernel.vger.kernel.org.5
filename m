Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2997B0E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjI0Vbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjI0Vbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:31:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B511D;
        Wed, 27 Sep 2023 14:31:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35CE166072C1;
        Wed, 27 Sep 2023 22:31:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695850302;
        bh=abGO4qVbXavCbwSjN2zmFsd9RtUxOGTas692u8/WW7I=;
        h=From:To:Cc:Subject:Date:From;
        b=BczI9cp09MAmd3AeGVfnAnlvTX9pbPWgg5xUb8fqszZkajamLLc288xSJJahwrifo
         +mGY/28WQG3oeugxfeXHTWD2pYI1WQplNlj8R84piFVuuVmTlLHbp8nUZGrWHGpuwx
         etShr56hPD6j5IokMSWdYGoRDK0OwSDMCu1KNbjRNLnjuzUeK23OY8gjiPXqsstWVy
         OJ3lUq96c4OoVxH89dpUjpSPIB45Ca30zwtY7NJJ3J/pSgvjvaRp3ylKj2d5JoXOJJ
         kKCtcSBNKu4mJShZmQnYABu3MEf+fTmdSAUifdWBKCaT6LNHEV/3V7HDVFOVjkT1W1
         zLTE/15M/EpNw==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com, tvrtko.ursulin@linux.intel.com,
        boris.brezillon@collabora.com
Subject: [PATCH v7 0/5] Add fdinfo support to Panfrost
Date:   Wed, 27 Sep 2023 22:29:54 +0100
Message-ID: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds fdinfo support to the Panfrost DRM driver. It will
display a series of key:value pairs under /proc/pid/fdinfo/fd for render
processes that open the Panfrost DRM file.

The pairs contain basic drm gpu engine and memory region information that
can either be cat by a privileged user or accessed with IGT's gputop
utility.

Changelog:

v1: https://lore.kernel.org/lkml/bb52b872-e41b-3894-285e-b52cfc849782@arm.com/T/

v2: https://lore.kernel.org/lkml/20230901084457.5bc1ad69@collabora.com/T/
 - Changed the way gpu cycles and engine time are calculated, using GPU
   registers and taking into account potential resets.
 - Split render engine values into fragment and vertex/tiler ones.
 - Added more fine-grained calculation of RSS size for BO's.
 - Implemente selection of drm-memory region size units.
 - Removed locking of shrinker's mutex in GEM obj status function.

v3: https://lore.kernel.org/lkml/20230905184533.959171-1-adrian.larumbe@collabora.com/
 - Changed fdinfo engine names to something more descriptive.;
 - Mentioned GPU cycle counts aren't an exact measure.
 - Handled the case when job->priv might be NULL.
 - Handled 32 bit overflow of cycle register.
 - Kept fdinfo drm memory stats size unit display within 10k times the
   previous multiplier for more accurate BO size numbers.
 - Removed special handling of Prime imported BO RSS.
 - Use rss_size only for heap objects.
 - Use bo->base.madv instead of specific purgeable flag.
 - Fixed kernel test robot warnings.

v4: https://lore.kernel.org/lkml/20230912084044.955864-1-adrian.larumbe@collabora.com/
 - Move cycle counter get and put to panfrost_job_hw_submit and
   panfrost_job_handle_{err,done} for more accuracy.
 - Make sure cycle counter refs are released in reset path
 - Drop the model param for toggling cycle counting and do
   leave it down to the debugfs file.
 - Don't disable cycle counter when togglint debugfs file,
   let refcounting logic handle it instead.
 - Remove fdinfo data nested structure definion and 'names' field
 - When incrementing BO RSS size in GPU MMU page fault IRQ handler, assume
   granuality of 2MiB for every successful mapping.
 - drm-file picks an fdinfo memory object size unit that doesn't lose precision.

v5: https://lore.kernel.org/lkml/20230914223928.2374933-1-adrian.larumbe@collabora.com/
 - Removed explicit initialisation of atomic variable for profiling mode,
   as it's allocated with kzalloc.
 - Pass engine utilisation structure to jobs rather than the file context, to avoid
   future misusage of the latter.
 - Remove double reading of cycle counter register and ktime in job deqeueue function,
   as the scheduler will make sure these values are read over in case of requeuing.
 - Moved putting of cycle counting refcnt into panfrost job dequeue.
   function to avoid repetition.

v6: https://lore.kernel.org/lkml/c73ad42b-a8db-23c2-86c7-1a2939dba044@linux.intel.com/T/
 - Fix wrong swapped-round engine time and cycle values in fdinfo
   drm print statements.

v7:
 - Make sure an object's actual RSS size is added to the overall fdinfo's purgeable
   and active size tally when it's both resident and purgeable or active.
 - Create a drm/panfrost.rst documentation file with meaning of fdinfo strings.
 - BUILD_BUG_ON checking the engine name array size for fdinfo.
 - Added copyright notices for Amazon in Panfrost's new debugfs files.
 - Discarded fdinfo memory stats unit size selection patch.

Adrián Larumbe (5):
  drm/panfrost: Add cycle count GPU register definitions
  drm/panfrost: Add fdinfo support GPU load metrics
  drm/panfrost: Add fdinfo support for memory stats
  drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
  drm/panfrost: Implement generic DRM object RSS reporting function

 Documentation/gpu/drm-usage-stats.rst       |  1 +
 Documentation/gpu/panfrost.rst              | 38 +++++++++++++
 drivers/gpu/drm/drm_file.c                  |  8 +--
 drivers/gpu/drm/panfrost/Makefile           |  2 +
 drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ++++++++
 drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 +++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  8 +++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 ++
 drivers/gpu/drm/panfrost/panfrost_device.c  |  2 +
 drivers/gpu/drm/panfrost/panfrost_device.h  | 13 +++++
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 60 ++++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 29 ++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h     |  5 ++
 drivers/gpu/drm/panfrost/panfrost_gpu.c     | 41 ++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h     |  4 ++
 drivers/gpu/drm/panfrost/panfrost_job.c     | 24 +++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h     |  5 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c     |  1 +
 drivers/gpu/drm/panfrost/panfrost_regs.h    |  5 ++
 include/drm/drm_gem.h                       |  9 ++++
 20 files changed, 289 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/gpu/panfrost.rst
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h


base-commit: f45acf7acf75921c0409d452f0165f51a19a74fd
-- 
2.42.0

