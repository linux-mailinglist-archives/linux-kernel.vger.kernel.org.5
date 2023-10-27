Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E56D7D95A8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjJ0Kyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjJ0Ky1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:54:27 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74E51A5;
        Fri, 27 Oct 2023 03:54:24 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qwKTd-00BeXP-1r; Fri, 27 Oct 2023 18:54:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Oct 2023 18:54:11 +0800
Date:   Fri, 27 Oct 2023 18:54:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     wangzhou1@hisilicon.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/qm - prevent soft lockup in receive
 loop
Message-ID: <ZTuW09if6KVsvhVM@gondor.apana.org.au>
References: <20231020093558.16695-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020093558.16695-1-liulongfang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:35:58PM +0800, Longfang Liu wrote:
> In the scenario where the accelerator business is fully loaded.
> When the workqueue receiving messages and performing callback
> processing, there are a large number of messages that need to be
> received, and there are continuously messages that have been
> processed and need to be received.
> This will cause the receive loop here to be locked for a long time.
> This scenario will cause watchdog timeout problems on OS with kernel
> preemption turned off.
> 
> The error logs:
> watchdog: BUG: soft lockup - CPU#23 stuck for 23s! [kworker/u262:1:1407]
> [ 1461.978428][   C23] Call trace:
> [ 1461.981890][   C23]  complete+0x8c/0xf0
> [ 1461.986031][   C23]  kcryptd_async_done+0x154/0x1f4 [dm_crypt]
> [ 1461.992154][   C23]  sec_skcipher_callback+0x7c/0xf4 [hisi_sec2]
> [ 1461.998446][   C23]  sec_req_cb+0x104/0x1f4 [hisi_sec2]
> [ 1462.003950][   C23]  qm_poll_req_cb+0xcc/0x150 [hisi_qm]
> [ 1462.009531][   C23]  qm_work_process+0x60/0xc0 [hisi_qm]
> [ 1462.015101][   C23]  process_one_work+0x1c4/0x470
> [ 1462.020052][   C23]  worker_thread+0x150/0x3c4
> [ 1462.024735][   C23]  kthread+0x108/0x13c
> [ 1462.028889][   C23]  ret_from_fork+0x10/0x18
> 
> Therefore, it is necessary to add an actively scheduled operation in the
> while loop to prevent this problem.
> After adding it, no matter whether the OS turns on or off the kernel
> preemption function. Neither will cause watchdog timeout issues.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
