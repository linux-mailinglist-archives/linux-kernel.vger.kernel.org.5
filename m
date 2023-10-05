Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC67BA03F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjJEOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjJEOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:32:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B426A4D;
        Thu,  5 Oct 2023 05:37:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so1509150a12.1;
        Thu, 05 Oct 2023 05:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509429; x=1697114229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTma9nOdd7miP747uWf012/X4qj2VCvWacA0CPBMb6I=;
        b=C7A5HNVl1lcPrAJtq7Zxczqs9a19aUOiW6LZ8RxM2HjzFb+1kzD1PYlf9hYJev+dm9
         MHFV0dmGuBQBR4az1VdtUUEz4rxGYvYeZdEQOI7ENSeUbMQaG/INGm5YCQLvs9SRV+RI
         a8fQmK5CB9upDoc5ZJR9fc4DvPIY76JCPXLM/noNX1gAhFBkOuJ6gRCokuszrOOBPAR3
         Br5qiDYl7clZQlCzQL270CZJ5cGfdzu5VkI9tmUCDG6ODct8FsFRQ1hGA0J4YyI4k/xJ
         3LinJZWoJBRr+PwN4ECVFOLxvEI6V/TiR8i1GpEoM3Tns0rmhkNBXeZoVdTveJVjQNe7
         UUOA==
X-Gm-Message-State: AOJu0YzdRE0Nz+1h1iiZvfeDMeCi1scH/y/yfBfs5uq2Ogn4RWgQ6tTg
        4mMKo1jRjAxXmz0TPODAX3g=
X-Google-Smtp-Source: AGHT+IEJ/s7rZCoW7OKUvhnchqVoaQysN0lS+xxmJvoJyGbyU3j7j7yNxAmtvnx1uVVx0Sm/0ggF2w==
X-Received: by 2002:a17:906:15d:b0:9ae:546b:786b with SMTP id 29-20020a170906015d00b009ae546b786bmr4033344ejh.33.1696509429203;
        Thu, 05 Oct 2023 05:37:09 -0700 (PDT)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906c40e00b009920a690cd9sm1142813ejz.59.2023.10.05.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:37:08 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH net-next v2 0/3] net: netconsole: configfs entries for boot target
Date:   Thu,  5 Oct 2023 05:36:33 -0700
Message-Id: <20231005123637.2685334-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation in netconsole, where it is impossible to disable
or modify the target created from the command line parameter.
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


Change Log:
===========
 * V1 -> V2:
	* Replaced the name of the NETCONSOLE_PARAM_TARGET_NAME macro
	* Improved the code documentation
	* Improved the user documentation

Breno Leitao (3):
  netconsole: Initialize configfs_item for default targets
  netconsole: Attach cmdline target to dynamic target
  Documentation: netconsole: add support for cmdline targets

 Documentation/networking/netconsole.rst | 22 ++++++++--
 drivers/net/netconsole.c                | 55 ++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.34.1

