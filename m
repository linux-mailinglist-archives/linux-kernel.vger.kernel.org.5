Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E407D1C62
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjJUKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:14:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5CB1BF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:14:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c78d258fso2314716e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883286; x=1698488086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbhtOmOMlrSXq3cWZFLEsrn0khhJxxkh0d58gwvHYGQ=;
        b=IKj2Y9ReeXhxw13GaQrnALy3YOg0Yfz0Wbpu10GCxv5+m/h56ItxzQyW3EWYnAL5dy
         FMCehLyXc95YXWEv5owuTRiIiqcBG1uYQdH0fKIu7ZdwvjPrDRWsdvKh42v8TGFOLXxb
         MW5AVAFnN/tpFG50QlJQi2ZpDakqI2qZuuQ3mlYSPd25y/rKGgakKAzXZ67AL4XgEwSL
         uozW0+xh6Kgfl0qAlGHe+/NZ4N4OLdK0NX+PB7zZSrE35l2Wf24zXVniANerWns0YCQ9
         PN4in+D6lCKdSByz3fWHKL3bqDUchWWax4FTGkCVDEGFy1Lfvjxg+25lSTASARVcCewm
         iqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883286; x=1698488086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbhtOmOMlrSXq3cWZFLEsrn0khhJxxkh0d58gwvHYGQ=;
        b=UCzgxsr9kOb4sKqffxDMoJrd3/lua+wln6KIyuhrYJi9CUNPGmV7lkyu+09o4UFvXY
         DhkSG0wgO8O58ZsbD2zgV7+sdDFQHr4yKLHmebilVEzaDqoF8x7ZvDA638yBG80goniQ
         UjDSg619p4mqFbp1aPPg8mY95t7+ptD51xuv0NfL8UZivuRkn/WNuWKizEa2Lx++dXWI
         ZkUcVtOqm2e2JMqEac6UP1jYWSrtlAaOsN8dLQ+Cq/6qSDYFjyO+Dou08NxIXOQDHR+w
         SjdLgRsdPeg2utIbtk557kusQeQ0Q/h31RanmMFbPlqxAJ2SBnNMJVfOnXyT0G8i9yZQ
         sI/g==
X-Gm-Message-State: AOJu0YxJ39o1hiouXn8rTaOCD1JXAz+GxGlQJBVHnaC//DWr+8PvQ0FS
        KfIweK/GrTDbDiTRDfpD712jqyp9g60=
X-Google-Smtp-Source: AGHT+IHghhP35vQyNpTtkbKNnZXkQheAufQxt+fcQr2cKWcyv2UbeppweocwijFkfDJQUqZdRM0qzQ==
X-Received: by 2002:a19:644d:0:b0:507:9618:dc1f with SMTP id b13-20020a19644d000000b005079618dc1fmr2763831lfj.69.1697883285675;
        Sat, 21 Oct 2023 03:14:45 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:14:44 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 0/7] staging: octeon: Fix warnings due to introduction of new typedefs
Date:   Sat, 21 Oct 2023 12:12:31 +0200
Message-Id: <20231021101238.81466-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This patch series fixes (removes) the introduction of several new typedefs
for enums and structs in the octeon driver. First the declarations are
fixed and then implementations are updated to remove references to the 
old typedefs.

Changelog:
 * v1 -> v2: Fix breaking change spread across multiple patches
 * v2 -> v3: Break changes up into individual patches for each removed
   typedef

Jonathan Bergh (7):
  staging: octeon: Fix introduction of new enum typedef cvmx_spi_mode_t
    in octeon
  staging: octeon: Fix up introduction of new typedef
    cvmx_helper_interface_mode_t  in octeon
  staging: octeon: Fix introduction of following new typedef
    cvmx_pow_wait_t in octeon
  staging: octeon: Fix up introduction of new typedef cvmx_pko_lock_t in
    octeon
  staging: octeon: Fix introduction of new typedef cvmx_pko_status_t in
    octeon
  staging: octeon: Fix introduction of new typedef
    cvmx_pip_port_status_t in octeon
  staging: octeon: Fix introduction of new typedef
    cvmx_pko_port_status_t in octeon driver

 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------
 2 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.40.1

