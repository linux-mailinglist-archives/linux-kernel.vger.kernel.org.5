Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4780178C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjLAXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0F103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701472934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2It67EXDhApMVqtGRDR3LyeWNVXSB0HYmIpaVAhnqBE=;
        b=ZQXOPosfpxgcFseCVqxnLi9TuHfnrEqzCTZoEN733i5NXzm9ADWQibtChzmogZIAfLwpUB
        5JWpAV1JnjYwZWX02BxebKvRXS4tkCNAP9y7nkCsA4KD+40eLCR44Je46ZETMXUtvvd08m
        LmpCi7n7Jt/Jfg4COPtz+FUGtP10KXM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-esdEWZ82MIG3sDYRffqlsg-1; Fri, 01 Dec 2023 18:22:13 -0500
X-MC-Unique: esdEWZ82MIG3sDYRffqlsg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b3f80e659aso256017439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701472932; x=1702077732;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2It67EXDhApMVqtGRDR3LyeWNVXSB0HYmIpaVAhnqBE=;
        b=YnKfF1YD5Mgk/TcHlah7xjlOEzZ1yAcPBZZR3Q8EmsErhpNdo8XR9y3f6ZVZ7xEl63
         DMu5+qJrArWgiLO020dGXRJ+ICrq14ctPlaPIG/otwGivyR7Lp4PYfsLhtMG66Tu1xPC
         l8m2b7Fp7qazvsa6ndRuB9GNght9Zant9Pr2sXU7AYMhxE9yT870Sjxat1KJ4hCmupBf
         gEviihYcaPOUfbm/NwT5WY5Aqesd4dEq6wE0O9F+HnkxEQuRr69p2GO9vRTTHg2ZHP+Z
         6odU58o+Ipy22CcBCzqH6rQxu08VlDmKWz/y6bRaNU2A9Ep7VrK51dkpVXJojnrrnwAu
         RyQw==
X-Gm-Message-State: AOJu0Yw9WBaiY07Inn6QFPs4MN0Xj07TmvmZawRKnMaRnxJ6hA7zxuyo
        UuWdgNBkVmy1T9JCFPRk0ykRO3sDSOZgg4gs66KHi0y74ZDuD58813VgLXQ0g0odXcoJHed97vk
        0vt9CaKIVmujwDSBmYlp1MDKbhdCtDtNC
X-Received: by 2002:a6b:e815:0:b0:7b4:28f8:2bf8 with SMTP id f21-20020a6be815000000b007b428f82bf8mr378568ioh.33.1701472931940;
        Fri, 01 Dec 2023 15:22:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFazra/I71ZeyXPm/bApiqsfwZgJ1ogQvL8QHOBXoLZrytqb6Z7nk+emp8aFIg/bHDAdwCMNw==
X-Received: by 2002:a6b:e815:0:b0:7b4:28f8:2bf8 with SMTP id f21-20020a6be815000000b007b428f82bf8mr378562ioh.33.1701472931716;
        Fri, 01 Dec 2023 15:22:11 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id cw2-20020a05663849c200b004640db25da8sm1099439jab.131.2023.12.01.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:22:10 -0800 (PST)
Date:   Fri, 1 Dec 2023 16:22:09 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO fix for v6.7-rc4
Message-ID: <20231201162209.1298a086.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v6.7-rc4

for you to fetch changes up to 4ea95c04fa6b9043a1a301240996aeebe3cb28ec:

  vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart (2023-11-30 11:27:17 -0700)

----------------------------------------------------------------
VFIO fixes for v6.7-rc4

 - Fix the lifecycle of a mutex in the pds variant driver such that
   a reset prior to opening the device won't find it uninitialized.
   Implement the release path to symmetrically destroy the mutex.
   Also switch a different lock from spinlock to mutex as the code
   path has the potential to sleep and doesn't need the spinlock
   context otherwise. (Brett Creeley)

 - Fix an issue detected via randconfig where KVM tries to symbol_get
   an undeclared function.  The symbol is temporarily declared
   unconditionally here, which resolves the problem and avoids churn
   relative to a series pending for the next merge window which
   resolves some of this symbol ugliness, but also fixes Kconfig
   dependencies. (Sean Christopherson)

----------------------------------------------------------------
Brett Creeley (2):
      vfio/pds: Fix mutex lock->magic != lock warning
      vfio/pds: Fix possible sleep while in atomic context

Sean Christopherson (1):
      vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart

 drivers/vfio/pci/pds/pci_drv.c  |  4 ++--
 drivers/vfio/pci/pds/vfio_dev.c | 30 +++++++++++++++++++++---------
 drivers/vfio/pci/pds/vfio_dev.h |  2 +-
 include/linux/vfio.h            |  8 ++------
 4 files changed, 26 insertions(+), 18 deletions(-)

