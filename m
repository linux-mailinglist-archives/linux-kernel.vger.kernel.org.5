Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EED753E99
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjGNPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbjGNPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:16:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D552D43;
        Fri, 14 Jul 2023 08:16:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-314172bac25so2134298f8f.3;
        Fri, 14 Jul 2023 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689347800; x=1691939800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02O0pKuXfrVTJZa3UAhgaDlxYfuP+KHC2VebuqxgPlk=;
        b=AKf8ll+oHQglE5FvBsDTP5P2sfOnQrZU4KTSe02P+DsU4oLOeB8mR4sLlH+/Hh5lDY
         TWoqx0/KE9cVCMHGiINt4KV5WgkWyruO0CQ4p2rvcjkl9mx8HtkFOOcBXaK5Jv2igjqH
         VsS55c4/0KdSbRbq/zVqKjlUMY+chN8HlvJKRcLVdkW8O+9Od131ib3d4a+H66d22hl6
         tNkXRH2Z5FJwryeALcv1rtX5nZ36jYHXIjXu8akuwHOIQ8k1BviU4K/8CZS0JHfzCR/7
         HWgmFhy7MuN+xAerjqfKNAG5OuYD89uKCb23Y3MAPmcnqT2U/rgi6OiRc++3xycrnlve
         ZpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689347800; x=1691939800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02O0pKuXfrVTJZa3UAhgaDlxYfuP+KHC2VebuqxgPlk=;
        b=R9alCmA06S/vA16UU6IcK24s/LoywQi+ZdCKCRDaX45pwyIkgVdxg/JEa8+UPlRNPc
         F4AhKzwVi3tmCo+1mQYqP3b3JyZRnGGirFbglXaIDSWUvMnlMNinhrfU+KXH7ZMSku7k
         nUW706EfAhkUCSDpNgdObZ9I3k6lmTgS56FAEkWTcnCUcSLFh328efWdhzJkb4Ds+Q3r
         foBlJewNW+hEHWHC7QfNpNIwSbcw7eES+dRKkQb1wbQ0ijkVw+s4LwFGP4kK3j5k0J//
         YLLCxmDTx76FqGe7hIz4Q7L0oJeg07rzhzJ7VRClLnjKfBGNLHgIlC9NarHz1ISXKiyd
         eomQ==
X-Gm-Message-State: ABy/qLaIs7FF+51r+Ixx09KihsRO6Lzatrrx4WGBZDdYrdn7Zm37J7Ew
        EUy12c8avHH7ooIW8EefK22osvdmvCY=
X-Google-Smtp-Source: APBJJlEIjmdgCDyZsZ9yyMxpzDJFKfMwl7Xlg0BiCo4BzrG/uHwZFMPyV+RSM3ljlf9LghJuwoAxfQ==
X-Received: by 2002:a05:6000:1084:b0:313:e971:53af with SMTP id y4-20020a056000108400b00313e97153afmr4527897wrw.32.1689347799535;
        Fri, 14 Jul 2023 08:16:39 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00313e4d02be8sm11118922wrp.55.2023.07.14.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:16:38 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 6.5-rc2
Date:   Fri, 14 Jul 2023 17:16:21 +0200
Message-ID: <20230714151629.69199-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc2

for you to fetch changes up to a282a2f10539dce2aa619e71e1817570d557fc97:

  libceph: harden msgr2.1 frame segment length checks (2023-07-13 13:18:57 +0200)

----------------------------------------------------------------
A fix to prevent a potential buffer overrun in the messenger, marked
for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: harden msgr2.1 frame segment length checks

 net/ceph/messenger_v2.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)
