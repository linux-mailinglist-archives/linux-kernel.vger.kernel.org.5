Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58B7A8075
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjITMh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjITMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B33D9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dpwuQg4DW9CQa6W2DXgKa+/2xEjZS0PSQLwcoRBZU2A=;
        b=E+4VoAE6dRZ2BPhR+qhBQtJkREFUe50OgJ30CN/bI+PUf4NUFv9o8OP9hupc3eYry14aRX
        Oz8z/dzeyIUJApyoDkXuCp+osPQ7aYDj1MZezeKcnSJIPV6/SDz6x5t67iYZP7u6UwHtHX
        epK+YbBX/bQaigWamf+4OBOJI/IOduM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-lPAta_BGM2O21ernFsNXeQ-1; Wed, 20 Sep 2023 08:36:29 -0400
X-MC-Unique: lPAta_BGM2O21ernFsNXeQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae4b211f43so17284266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213388; x=1695818188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpwuQg4DW9CQa6W2DXgKa+/2xEjZS0PSQLwcoRBZU2A=;
        b=LqZqCuHlM5Tvu1inKoSfeHBdYwPYaWzuFexOG7smhyk+/NJ7HLMloI/CdmmMpCgNdm
         JqZa0QrRi9BRRoBOxpTQKhJ62b/3loCFf839LPpQDlftcKPjGSfuFJwnU3kGAci9kTUr
         bCunxLdO5mAAEdL/Wuermdafo85GBjjJOXC+iXQeJ+0f+PVEfd6YgLVK9y+9YQIl/mMk
         q5vjWq1KKWFlPagHxpFIBXujXzrOMV8e711tHln3bbgurd+zEuXD6qsf0QLt3oMleY+4
         +QvIYIb5MXo2ijjH2OJo6Rn1AVgiO8cTp5o71PcWfmpD2dc7yfBufzWbaIJIg5cCHtfW
         ITPw==
X-Gm-Message-State: AOJu0YyHswNtTFTR4pF1RwCxxA7byx3iZw6KBs31NMhi/WPv7xZbvxgo
        zijWW3Dtb23Bd/xoKz8hJYo+laVcsb52/BCuCYst2L7TsO4juVSFGolU7nGzmxsgxDrAMxiocf3
        ocJqudFfX4IhK6ELe0IjgNy+/
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr1853797eji.4.1695213388726;
        Wed, 20 Sep 2023 05:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWfVGOFs1cXim3gTD9PAzh0cZ1ptQJMSfTtIDViZU2bgVjNf9KAP/OZ/dlJHXc8IFPusAbnQ==
X-Received: by 2002:a17:906:d3:b0:9a1:d915:6372 with SMTP id 19-20020a17090600d300b009a1d9156372mr1853784eji.4.1695213388364;
        Wed, 20 Sep 2023 05:36:28 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id ld3-20020a1709079c0300b009adc81bb544sm8137735ejc.106.2023.09.20.05.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:24 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v3 0/5] Introduce new wrappers to copy user-arrays
Date:   Wed, 20 Sep 2023 14:36:08 +0200
Message-ID: <20230920123612.16914-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

David Airlie suggested that we could implement new wrappers around
(v)memdup_user() for duplicating user arrays.

This small patch series first implements the two new wrapper functions
memdup_array_user() and vmemdup_array_user(). They calculate the
array-sizes safely, i.e., they return an error in case of an overflow.

It then implements the new wrappers in two components in kernel/ and two
in the drm-subsystem.

In total, there are 18 files in the kernel that use (v)memdup_user() to
duplicate arrays. My plan is to provide patches for the other 14
successively once this series has been merged.


Changes since v2:
- Remove the unlikely() from the overflow-check, since the latter
  already implements one (Dan Carpenter)
- Add the Reviewd-bys for the changes already reviewed in v2

Changes since v1:
- Insert new headers alphabetically ordered
- Remove empty lines in functions' docstrings
- Return -EOVERFLOW instead of -EINVAL from wrapper functions

P.

Philipp Stanner (5):
  string.h: add array-wrappers for (v)memdup_user()
  kernel: kexec: copy user-array safely
  kernel: watch_queue: copy user-array safely
  drm_lease.c: copy user-array safely
  drm: vmgfx_surface.c: copy user-array safely

 drivers/gpu/drm/drm_lease.c             |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  4 +--
 include/linux/string.h                  | 40 +++++++++++++++++++++++++
 kernel/kexec.c                          |  2 +-
 kernel/watch_queue.c                    |  2 +-
 5 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.41.0

