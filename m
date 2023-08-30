Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422978E36D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjH3Xnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbjH3Xnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:43:32 -0400
X-Greylist: delayed 7053 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 16:43:26 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE5CF;
        Wed, 30 Aug 2023 16:43:26 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4RbZdC575gz1sCHT;
        Wed, 30 Aug 2023 21:49:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4RbZd83ty8z1qqlb;
        Wed, 30 Aug 2023 21:49:48 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id PaI3XmDZtnS9; Wed, 30 Aug 2023 21:49:47 +0200 (CEST)
X-Auth-Info: Pbpxk8dOWlbPEEBN/noqaoWZixAIgLuZJUPRLWT+r811XAsiT63LvvaA3kzBJABK
Received: from igel.home (aftr-62-216-205-244.dynamic.mnet-online.de [62.216.205.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 30 Aug 2023 21:49:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3018C2C0D30; Wed, 30 Aug 2023 21:49:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
In-Reply-To: <20230819004356.1454718-2-Liam.Howlett@oracle.com> (Liam
        R. Howlett's message of "Fri, 18 Aug 2023 20:43:55 -0400")
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
        <20230819004356.1454718-2-Liam.Howlett@oracle.com>
X-Yow:  Hmmm..  a CRIPPLED ACCOUNTANT with a FALAFEL sandwich is HIT
 by a TROLLEY-CAR..
Date:   Wed, 30 Aug 2023 21:49:47 +0200
Message-ID: <87bkeotin8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This breaks booting on ppc32:

Kernel attemptd to writ user page (1ff0) - exploit attempt? (uid: 0)
BUG: Unable to handle kernel data access on write at 0x00001ff0
Faulting instruction address: 0xc0009554
Vector: 300 (Data Access) at [c0b09d10]
    pc: c0009554: do_softirq_own_stack+0x18/0x30
    lr: c004f480: __irq_exit_rcu+0x70/0xc0
    sp: c0b09dd0
   msr: 1032
   dar: 1ff0
 dsisr: 42000000
  current = 0xc0a08360
    pid   = 0, comm = swapper
Linux version 6.5.0 ...
enter ? for help
[c0b09de0] c00ff480 __irq_exit_rcu+0x70/0xc0
[c0b09df0] c0005a98 Decrementer_virt+0x108/0x10c
--- Exception: 900 (Decrementer) at c06cfa0c __schedule+0x4fc/0x510
[c0b09ec0] c06cf75c __schedule+0x1cc/0x510 (unreliable)
[c0b09ef0] c06cfc90 __cond_resched+0x2c/0x54
[c0b09f00] c06d07f8 mutex_lock_killable+0x18/0x5c
[c0b09f10] c013c404 pcpu_alloc+0x110/0x4dc
[c0b09f70] c000cc34 alloc_descr.isra.18+0x48/0x144
[c0b09f90] c0988aa0 early_irq_init+0x64/0x8c
[c0b09fa0] c097a5a4 start_kernel+0x5b4/0x7b0
[c0b09ff0] 00003dc0
mon>

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
