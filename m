Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140787A4610
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbjIRJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjIRJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:34:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0018E;
        Mon, 18 Sep 2023 02:34:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso3220453a12.3;
        Mon, 18 Sep 2023 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695029655; x=1695634455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kelQ4HIlrinqzdx3z4JlvIjia4dK9faB2QYDc72HlFI=;
        b=YderAkyTVy8c5r8rkVUNqPsW6iN++gNPy1D8P6DwNfUdGRkVHLgl7cKlaftw++mjQf
         AwfOViGWOWlLHMXCenNnWk9tsPrbyWYBWs7PBE9IMbzdH4ES2tk7VNISQ+sKuvENV89T
         okvnwpmK1/W+CGXsCJlG0V4m2xgsoVbme6xxzVF4blNLFirolVYCctFFKtwt/Fo5AkDJ
         +W4SG/gYTtl5ul/pmWULZauflh3N8duBrKDiIRFxGjWFyYVOJGpnoit2Rg/obG+ts9yI
         MD4jqctHDrWEcqAXe+09XbDO9Z8dG7Guoh3RfBwKkB6V9fq+Y2oiqVryKDKggeKHbFMl
         uR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029655; x=1695634455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kelQ4HIlrinqzdx3z4JlvIjia4dK9faB2QYDc72HlFI=;
        b=JjseKNdoKQgbE56uBnNhTYpj6dQ8AwWGGcEIu8q13YjQlrNY9Tmi1+9F/dvHcsXNTa
         4/lUJtXLV7debAm/fyWGHVRFgKU8JDEF6IDciHrRtXoZzgn3sxvW3sPdAOYfVWyHtefU
         CcRpufEGXAM+dJdQTDGwd/STpVjwZcdDD9vWJp3VLFRRSFGXo4Tu+8xyMJ9NimDLC46h
         A+3DMF3Fr/TH+S6hOo6PjonIb4ApjTv6bk12itlm7/w8ze3vj/8kueCcUg4rE27zCsJ9
         3bRF1igWRnD3FkISnPycUCnDDvme1pPsqasiLbBM4PyDc90Q9NgQtbvDY9ZUX29KAiaz
         T0Sg==
X-Gm-Message-State: AOJu0Yyf+NOFCdp6GyWPw5DVjpKpVLiM4vc5Uu4SgkLdi+bUDD5NhMfq
        ttdxRFIDJrht1oMgccejy6jDBNk6tMc=
X-Google-Smtp-Source: AGHT+IGw8JuSJf8LT173j0/ycpeAgcDtvcHLTnsG/WDalOOOsutDk/clRv3O1xK1IRZz/5wZUi/zAg==
X-Received: by 2002:a17:90a:d806:b0:273:e689:8dfc with SMTP id a6-20020a17090ad80600b00273e6898dfcmr6028541pjv.32.1695029655191;
        Mon, 18 Sep 2023 02:34:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a19de00b002694fee879csm9353848pjj.36.2023.09.18.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:34:14 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] Documentation fixes for dpll subsystem
Date:   Mon, 18 Sep 2023 16:32:37 +0700
Message-Id: <20230918093240.29824-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=bagasdotme@gmail.com; h=from:subject; bh=gLSfw3/7qcOxXKVRjl/l5XRJARBrbZqflmQEsBi/WUM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkckmpTHBPi3rc0nlX7v7QtOGyW2I7+m1IbH0uJyhuEu X1cefdFRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACay+isjw4mpAlI3bS8+4xbh nv6r+mfM3EdTO3cfrX0zW3i/N+u/vXMZ/ntarrp6x9BsxdSLeYJ2rixLrDfU9Vtwqess47dtiLG 3YgcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, sorry for not reviewing dpll series [1] before it gets merged. I
was prompted to post this doc fixup mini series because I was emailed by kernel
test robot (see [1/2] for the warnings).

This fixup is all code block related.

[1]: https://lore.kernel.org/netdev/20230913204943.1051233-1-vadim.fedorenko@linux.dev/

Bagas Sanjaya (2):
  Documentation: dpll: Fix code blocks
  Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block

 Documentation/driver-api/dpll.rst | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)


base-commit: 8d6198a14e2bfb09f190055b387c90b4ac9b49a4
-- 
An old man doll... just what I always wanted! - Clara

