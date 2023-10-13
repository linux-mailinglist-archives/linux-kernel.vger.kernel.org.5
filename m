Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263BA7C88C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjJMPgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:36:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDCB7;
        Fri, 13 Oct 2023 08:35:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b9faf05f51so348936366b.2;
        Fri, 13 Oct 2023 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211358; x=1697816158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dFgKvPZrQ13yellxv0kI7jEIq7Um9XHjQvDBq2k1N0M=;
        b=ES03oT/0zeaP3THVozOxgbriZPBigWhpe2hQvkC8FNUbIAN0ENQ6C92pkvVv24A411
         rkrTJlE2P8yT3IfG9K5qGE8NCIeTo0f9ihdA9A7P0hXYlIuPEwgQmzajwOLzcDSQ730m
         /W8JShy3yc5NuBrJHvAMYp/9c4XVmltvJBA98+d2yXiH36jKChu/n783XVlMStuc6LS1
         9rEYnEgVzCVgKlDaJ7bDuhBbSqIf9ZCQCgy9LKDOvoUD+/D0fz1X9btrtXD5E0KG/WsC
         CC+JDHkj3YfMFZ4b523IvSHGNLd+v6/VvExANzSOrBgr2lmVWQnR1ceWGhGsOxNY0trq
         GQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211358; x=1697816158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFgKvPZrQ13yellxv0kI7jEIq7Um9XHjQvDBq2k1N0M=;
        b=ekJ1II38pDhnfD+1vyPSy8/uHQfTMEGTEN3sMG2ZAb3HtPgVOVThmaqs2tHa4Exr+k
         1AzhF5NlvfzgdK7xlnjdeEEzJ/IrBgAg+5mFEpgleGtCyHk5+2wVXcXuTtb9jeQSV9sH
         Pl7LxA7LlkJXXz/Br9+ZXThtk0GEMQMVCWHd8tfmL5XpKGOHfFcKOJnJ76nCmNFCJSSr
         D7hNHQ4QG4s+feJc8nqE3+1XJ8uNeXMLPzicmX48HhftbrHi0m9POpFSvzYYCxufbiUu
         XVoIW9zT1wK6UVlOnwoMPisokIyT8gLkSkeWrAmW1F3jOL6fCw5DVQ9WUcEe0A5gp9di
         10Jg==
X-Gm-Message-State: AOJu0YxbKF9J8ltjzVw55z1gbWJog4orQ2W6WcGBwn7pAvcU0doYONV3
        Wn96ZdeW9Y2sMhBtwWkGTS1oDK/zK7E=
X-Google-Smtp-Source: AGHT+IGhlBAaGskan1xu5Vp4AsJ6uwcwJKF+5ZFht37Y3ONI4tyy0DI/Z1rQoZDRAU6ODEtUMblNwA==
X-Received: by 2002:a17:906:ef07:b0:9bd:e99b:82d2 with SMTP id f7-20020a170906ef0700b009bde99b82d2mr945677ejs.9.1697211357693;
        Fri, 13 Oct 2023 08:35:57 -0700 (PDT)
Received: from zambezi.redhat.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906481300b009b9720a85e5sm12519516ejq.38.2023.10.13.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:35:56 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.6-rc6
Date:   Fri, 13 Oct 2023 17:35:42 +0200
Message-ID: <20231013153544.463041-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc6

for you to fetch changes up to 07bb00ef00ace88dd6f695fadbba76565756e55c:

  ceph: fix type promotion bug on 32bit systems (2023-10-09 13:35:24 +0200)

----------------------------------------------------------------
Fixes for an overreaching WARN_ON, two error paths and a switch to
kernel_connect() which recently grown protection against someone using
BPF to rewrite the address.  All but one marked for stable.

----------------------------------------------------------------
Dan Carpenter (1):
      ceph: fix type promotion bug on 32bit systems

Jordan Rife (1):
      libceph: use kernel_connect()

Luis Henriques (1):
      ceph: remove unnecessary IS_ERR() check in ceph_fname_to_usr()

Xiubo Li (1):
      ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

 fs/ceph/crypto.c     | 2 +-
 fs/ceph/file.c       | 2 +-
 fs/ceph/inode.c      | 4 +---
 net/ceph/messenger.c | 4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)
