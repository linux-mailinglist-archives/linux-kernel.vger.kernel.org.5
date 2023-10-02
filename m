Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6EA7B5789
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjJBPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjJBPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:43 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB337D3;
        Mon,  2 Oct 2023 08:55:39 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9adca291f99so2297230966b.2;
        Mon, 02 Oct 2023 08:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262138; x=1696866938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CupPcUlQycCtq5LF2h/9frfQ4ms2uZQt+PNe4MPVspc=;
        b=UAmke+VRDE5iNbSult56dfmU9+sKKaKmnF/2rDik88+0kAih1uVUE1+GAV+b1y9Ud+
         ovosolgYbVW5UQbEPLPrdOsHe92AlriU+toklAOwfqGbqhF6oxHnVTnYPt8boZzrZI0V
         UPEsjqFzZSVLm9lZbzytThetjax4xDzpCxUS3Z1MYEPpGT9fA0/thdYMsZl27jKP5yx0
         zpCEC+MMANbEz3dSn9w1rn14SlcJEMykDa0PMOPz/Po9PCaevBUn1AcVvSJtk3pDfyuX
         yRq4WpFXUSuLG93Q6Xw7cpfIAOwR1sIHK5vFmVJ3QkQYmrxKKNj//zQOeWINdidinlRN
         +NkA==
X-Gm-Message-State: AOJu0YwBFuIXW7bApEf2ywMSXC9FNyRH01j3Ko6EwzUy9zTB/D3OuZ+9
        z3yRHqOInyLCnGzGihAafY8=
X-Google-Smtp-Source: AGHT+IFaKm44CsrFBRCsnPxlxsDClxgKUcEmkX2oiD08R5N4PvwGxKZ+tnrim9qfMKaFALtVWo1PNQ==
X-Received: by 2002:a17:906:29e:b0:9b0:552c:b36c with SMTP id 30-20020a170906029e00b009b0552cb36cmr11400180ejf.21.1696262137932;
        Mon, 02 Oct 2023 08:55:37 -0700 (PDT)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id i2-20020a170906444200b0099cb0a7098dsm17380398ejp.19.2023.10.02.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:55:37 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
        pabeni@redhat.com
Cc:     hch@lst.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: [PATCH 0/3] net: netconsole: configfs entries for boot target
Date:   Mon,  2 Oct 2023 08:53:46 -0700
Message-Id: <20231002155349.2032826-1-leitao@debian.org>
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

Breno Leitao (3):
  netconsole: Initialize configfs_item for default targets
  netconsole: Attach cmdline target to dynamic target
  Documentation: netconsole: add support for cmdline targets

 Documentation/networking/netconsole.rst | 21 ++++++++--
 drivers/net/netconsole.c                | 51 ++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.34.1

