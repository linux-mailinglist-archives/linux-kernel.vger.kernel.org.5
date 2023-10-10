Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122BD7BF77B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjJJJiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:38:09 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE9893;
        Tue, 10 Oct 2023 02:38:06 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso973760666b.1;
        Tue, 10 Oct 2023 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930685; x=1697535485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8CLQTcJrYOwRTqvT9o06ssVLzSd0KqWTzYK7stGT78=;
        b=ex2yHlG5a2b5VSBTEqWopu7/4R2fO22Xkb1XRvsfBLxqd8YZXuck+wTik5nyCP2sDV
         kKWNaIVN4CuVuRCJVQa/H/qT3zMMsEbclfABdyz3ro9YWoqSIfnWpELODTXWRz0tnPWI
         CiXhSJ1EyPO4QKSaTUxe9vircyAkT8sQspInn/Dv+PtOM38/R/e77CR+1b9C76UDzWrE
         i2pGFCTjSHTBjT1hlK5B04/NQ1HCOefTfUjDK4uRV7nnL2liNPxpW5s/MQ72ZkvD4GT0
         y+V2sSKREaj+h79ZWbD5/K/rNVfYWcIhmqKcUee8Lsr2XMhrRPzNca+IQAeoHiFccv6w
         SzMw==
X-Gm-Message-State: AOJu0Yz9nKq8d+JRX1u/jHbVAU8TrjkXSHAPyh2wpqVHmrXlGF0KwS50
        amtYbrcS7Nzn4YmUQ3TEnrNocFphKAc=
X-Google-Smtp-Source: AGHT+IFEAO3D+NTuvMGbGR2gtxY3ZFQrouBf+JYoVlaesCCaipRr2RMMsBCetfITs9O7Z23lKtTsZA==
X-Received: by 2002:a17:906:310b:b0:9b5:f25d:9261 with SMTP id 11-20020a170906310b00b009b5f25d9261mr15657614ejx.22.1696930684587;
        Tue, 10 Oct 2023 02:38:04 -0700 (PDT)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906a40700b009ae587ce133sm8196942ejz.188.2023.10.10.02.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:38:02 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v3 0/4] net: netconsole: configfs entries for boot target
Date:   Tue, 10 Oct 2023 02:37:47 -0700
Message-Id: <20231010093751.3878229-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation in netconsole, where it is impossible to
disable or modify the target created from the command line parameter.
(netconsole=...).

"netconsole" cmdline parameter sets the remote IP, and if the remote IP
changes, the machine needs to be rebooted (with the new remote IP set in
the command line parameter).

This allows the user to modify a target without the need to restart the
machine.

This functionality sits on top of the dynamic target reconfiguration that is
already implemented in netconsole.

The way to modify a boot time target is creating special named configfs
directories, that will be associated with the targets coming from
`netconsole=...`.

Example:

Let's suppose you have two netconsole targets defined at boot time::

 netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc;4444@10.0.0.1/eth1,9353@10.0.0.3/12:34:56:78:9a:bc

You can modify these targets in runtime by creating the following targets::

 $ mkdir cmdline1
 $ cat cmdline1/remote_ip
 10.0.0.3
 $ echo 0 > cmdline1/enabled
 $ echo 10.0.0.4 > cmdline1/remote_ip
 $ echo 1 > cmdline1/enabled

---
Changelog:
 * Version 3:
	* Move alloc_param_target() to the bottom of the file to avoid
	  forward declaration.

 * Version 2:
	* Replaced the name of the NETCONSOLE_PARAM_TARGET_NAME macro
	* Improved the code documentation
	* Improved the user documentation

---
Breno Leitao (4):
  netconsole: move init/cleanup functions lower
  netconsole: Initialize configfs_item for default targets
  netconsole: Attach cmdline target to dynamic target
  Documentation: netconsole: add support for cmdline targets

 Documentation/networking/netconsole.rst |  22 +++-
 drivers/net/netconsole.c                | 155 ++++++++++++++++--------
 2 files changed, 121 insertions(+), 56 deletions(-)

-- 
2.34.1

