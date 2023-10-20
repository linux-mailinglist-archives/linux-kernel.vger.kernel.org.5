Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36CD7D0FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377370AbjJTMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377271AbjJTMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:45:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E81091;
        Fri, 20 Oct 2023 05:45:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789a4c01easo47633685a.0;
        Fri, 20 Oct 2023 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805931; x=1698410731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY35Cbfn5zj5Ipo1600m6sKYcyjqxN0EYqA8P1Am52U=;
        b=U/2bETJ4o32MVe33VcqxQabVTXHb8E80PMwNZ02Wu9/+oURU6bRDtXttZqZ1u2KLjx
         /EixLX2ZYPc43uV51M7fcuZFG4Tej4ebOMdiZhfpnr/9CzKkSHYt0TgD6iMa02WhEj1L
         icIOgz0bVDBxvz/QxUtGYc0G9+n0KI+xG1RpvwNXWQLZ5fIUZ3RDaDRgR1c4PtWSXL48
         nAn5hSjlXLkbOzG8lafj7ewJOMV/b89byzn+zk2St5kmipU5WVuA7pgIzhMtQvldt5vQ
         1ZAbHg86xwIKCYQcup/PYop+j0386Rdkme+PkFo4wwNinEuGit23LYtBkLlbql7P8CMQ
         qROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805931; x=1698410731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FY35Cbfn5zj5Ipo1600m6sKYcyjqxN0EYqA8P1Am52U=;
        b=KP+eaArX21dvZscpHjj8UFvxHhOgVBqEj8JeltZMOLyjkyaF9NmEESlawfjVks8koc
         xpuGfjY99F5rl6aOZz+Nw99b+za099YNVZ7Pb393ih2+Rszz8q5MyVU4L8dZeqA7F8ja
         Bs13M4R47/9jJuTMqSjBgVwUXajt5bEs/S/s7AAxz9HCNskSaf552aOZUPf5zZDoIJsV
         SV55EvFT+bvNLwu53Us/Xu2Dm/pO1Ft75WttGqVjPXxnC3fVbR/C/Ym5alHSDkcR/8Zu
         3Li/mZkANrIQGcRAl8ZU+yW4XE08Y7koq5tp3R98OMqVFJ3MkbqKZCsqR8txGwYt1QWh
         dqEg==
X-Gm-Message-State: AOJu0YxElvfvOZPg0Y5j75qkMzF5WIEIudrNkBnXm/N3b0fCAwmDRL6K
        lKJS3opFLZr81lwpgTreHRg=
X-Google-Smtp-Source: AGHT+IGEw0YWk9e28NRXWQWBzJ1lPljHRuRkDb+Mshzfx2wmhsg5X+NFekA/Mxidgs2E5vA4dVhMVw==
X-Received: by 2002:a05:620a:29d1:b0:776:5135:d98c with SMTP id s17-20020a05620a29d100b007765135d98cmr1847767qkp.15.1697805930618;
        Fri, 20 Oct 2023 05:45:30 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id m26-20020ae9e71a000000b00767dba7a4d3sm571948qka.109.2023.10.20.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:45:30 -0700 (PDT)
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Ian Kent <raven@themaw.net>,
        Sven Joachim <svenjoac@gmx.de>,
        Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Ricardo Lopes <ricardoapl.dev@gmail.com>,
        Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev,
        Manish Chopra <manishc@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 1/2] staging: qlge: Update TODO
Date:   Fri, 20 Oct 2023 08:44:56 -0400
Message-ID: <20231020124457.312449-2-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020124457.312449-1-benjamin.poirier@gmail.com>
References: <20231020124457.312449-1-benjamin.poirier@gmail.com>
MIME-Version: 1.0
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

Update TODO file to reflect the changes that have been done:
* multiple functions were renamed to have the "qlge_" prefix in commit
  f8c047be5401 ("staging: qlge: use qlge_* prefix to avoid namespace
  clashes with other qlogic drivers")
* a redundant memset() was removed in commit 953b94009377 ("staging: qlge:
  Initialize devlink health dump framework")
* the loop boundary in ql(ge)_alloc_rx_buffers() was updated in commit
  e4c911a73c89 ("staging: qlge: Remove rx_ring.type")
* pci_enable_msi() was replaced in commit 4eab532dca76 ("staging:
  qlge/qlge_main.c: Replace depracated MSI API.")
* pci_dma_* were replaced in commit e955a071b9b3 ("staging: qlge: replace
  deprecated apis pci_dma_*")
* the while loops were rewritten in commit 41e1bf811ace ("Staging: qlge:
  Rewrite two while loops as simple for loops")
* indentation was fixed in commit 0eb79fd1e911 ("staging: qlge: cleanup
  indent in qlge_main.c")

I also slipped in one new TODO item, naughty me!

Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
---
 drivers/staging/qlge/TODO | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/qlge/TODO b/drivers/staging/qlge/TODO
index c76394b9451b..7e277407033e 100644
--- a/drivers/staging/qlge/TODO
+++ b/drivers/staging/qlge/TODO
@@ -1,7 +1,7 @@
 * commit 7c734359d350 ("qlge: Size RX buffers based on MTU.", v2.6.33-rc1)
   introduced dead code in the receive routines, which should be rewritten
   anyways by the admission of the author himself, see the comment above
-  ql_build_rx_skb(). That function is now used exclusively to handle packets
+  qlge_build_rx_skb(). That function is now used exclusively to handle packets
   that underwent header splitting but it still contains code to handle non
   split cases.
 * truesize accounting is incorrect (ex: a 9000B frame has skb->truesize 10280
@@ -17,17 +17,12 @@
 * the flow control implementation in firmware is buggy (sends a flood of pause
   frames, resets the link, device and driver buffer queues become
   desynchronized), disable it by default
-* some structures are initialized redundantly (ex. memset 0 after
-  alloc_etherdev())
 * the driver has a habit of using runtime checks where compile time checks are
-  possible (ex. ql_free_rx_buffers(), ql_alloc_rx_buffers())
+  possible (ex. qlge_free_rx_buffers())
 * reorder struct members to avoid holes if it doesn't impact performance
-* avoid legacy/deprecated apis (ex. replace pci_dma_*, replace pci_enable_msi,
-  use pci_iomap)
-* some "while" loops could be rewritten with simple "for", ex.
-  ql_wait_reg_rdy(), ql_start_rx_ring())
+* use better-suited apis (ex. use pci_iomap() instead of ioremap())
 * remove duplicate and useless comments
-* fix weird line wrapping (all over, ex. the ql_set_routing_reg() calls in
+* fix weird line wrapping (all over, ex. the qlge_set_routing_reg() calls in
   qlge_set_multicast_list()).
-* fix weird indentation (all over, ex. the for loops in qlge_get_stats())
+* remove useless casts (ex. memset((void *)mac_iocb_ptr, ...))
 * fix checkpatch issues
-- 
2.42.0

