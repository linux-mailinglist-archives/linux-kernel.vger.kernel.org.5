Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47417C6C01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378092AbjJLLOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjJLLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:14:27 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1468C4;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ae75ece209so135708466b.3;
        Thu, 12 Oct 2023 04:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109262; x=1697714062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtB8IDZz5dk1cNl4dqJ3VZqh/YbjyD7s+JDKd6G9pwQ=;
        b=PwOpaSCmvvv/VNHf9uqHZeUNQd662kRTywsuiengjCmpAZebV/aJVu4UhQ0QUS1+Tl
         GruToI0QOpExD/FubFt28KGVWxMBCwyOTXE2T6chE1TaWDBndsn9ttVElG3ipg3BrYjS
         n3Q88t+ZCS5TT7GL/XybASUL8mzOFuiNeFRp1AybY/hZzw05ql7Hef2tacyNwHk81+q1
         1UgWp1kgxqyP+Wz1HotSA5pV3GxmbFr7RPyGfaegNg1SFIjLUNfifve3PDo/b2mewbof
         rutvTJBO+SLtEK720vRTYG61Xww8iOcRKvtza5a4Te0h00HOabVGcnWmAzzME8WGzj4V
         ENOA==
X-Gm-Message-State: AOJu0Yz+x8UNoB12O4CGtWWtl6W1PM/x4L/VIABHeprzgBdJIR1bjwkO
        dI+4OdtbTJ+Y7U3Bw3xWg48=
X-Google-Smtp-Source: AGHT+IErldYLlXudceU/+JDgQI7626yVVyudGsGX0Rne04CdkkqfMIRXx49NP8sygZHNlD2+n5+tXg==
X-Received: by 2002:a17:906:73d4:b0:9b8:df8e:cbdd with SMTP id n20-20020a17090673d400b009b8df8ecbddmr19417346ejl.38.1697109261432;
        Thu, 12 Oct 2023 04:14:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00536e03f62bcsm10053640edu.59.2023.10.12.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:14:20 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v4 0/4] net: netconsole: configfs entries for boot target
Date:   Thu, 12 Oct 2023 04:13:57 -0700
Message-Id: <20231012111401.333798-1-leitao@debian.org>
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

==

Changelog:
 * Version 4:
	* Rename NETCONSOLE_PARAM_TARGET_NAME to NETCONSOLE_PARAM_TARGET_PREFIX

 * Version 3:
	* Move some functions around to avoid forward declaration

 * Version 2:
	* Replaced the name of the NETCONSOLE_PARAM_TARGET_NAME macro
	* Improved the code documentation
	* Improved the user documentation

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

