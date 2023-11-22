Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8C7F4528
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbjKVLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbjKVLxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F45D1BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:53:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93917C433C8;
        Wed, 22 Nov 2023 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700654000;
        bh=K+VyxU9+3wW62WbOigu1weinCYoVJfJ+ufPp61LPh54=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GKwiYsrwf7fq6SO3hzB9JoIaSsbl8hFlTz09O5fenYcbfYKlaUK16grVcMwU8ayWy
         WmiJLrm4qXMs3IvjDbVpugwh5hJhp4MtiYDLWUVAI6dokP7GI206vyCfsGz8S33PAz
         XpM0SJ1czh1x5aWSDdpvP128oRe/Sgu+AH3hKZuiteGMEuvG2HASWtcJALp0qa6bxU
         C4+986Y+G9ormMvnMvphmtuNKSWx0N8ZaYFTkHZoTUJ0xOPH0ria0E/xebVAlzjOYE
         ailbbVS7E2Cj2zaauHWUUsdNLUjnURKFIAVHAo1OxpSMY5mbKUtOwgvvzhn5cOXvA0
         FeBpQ6yRs+S8w==
From:   Leon Romanovsky <leon@kernel.org>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        gustavoars@kernel.org, Shifeng Li <lishifeng1992@126.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn
In-Reply-To: <20231121101236.581694-1-lishifeng1992@126.com>
References: <20231121101236.581694-1-lishifeng1992@126.com>
Subject: Re: [PATCH v3] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
Message-Id: <170065399591.29157.1831837396009274154.b4-ty@kernel.org>
Date:   Wed, 22 Nov 2023 13:53:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Nov 2023 02:12:36 -0800, Shifeng Li wrote:
> When removing the irdma driver or unplugging its aux device, the ccq
> queue is released before destorying the cqp_cmpl_wq queue.
> But in the window, there may still be completion events for wqes. That
> will cause a UAF in irdma_sc_ccq_get_cqe_info().
> 
> [34693.333191] BUG: KASAN: use-after-free in irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333194] Read of size 8 at addr ffff889097f80818 by task kworker/u67:1/26327
> [34693.333194]
> [34693.333199] CPU: 9 PID: 26327 Comm: kworker/u67:1 Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
> [34693.333200] Hardware name: SANGFOR Inspur/NULL, BIOS 4.1.13 08/01/2016
> [34693.333211] Workqueue: cqp_cmpl_wq cqp_compl_worker [irdma]
> [34693.333213] Call Trace:
> [34693.333220]  dump_stack+0x71/0xab
> [34693.333226]  print_address_description+0x6b/0x290
> [34693.333238]  ? irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333240]  kasan_report+0x14a/0x2b0
> [34693.333251]  irdma_sc_ccq_get_cqe_info+0x82f/0x8c0 [irdma]
> [34693.333264]  ? irdma_free_cqp_request+0x151/0x1e0 [irdma]
> [34693.333274]  irdma_cqp_ce_handler+0x1fb/0x3b0 [irdma]
> [34693.333285]  ? irdma_ctrl_init_hw+0x2c20/0x2c20 [irdma]
> [34693.333290]  ? __schedule+0x836/0x1570
> [34693.333293]  ? strscpy+0x83/0x180
> [34693.333296]  process_one_work+0x56a/0x11f0
> [34693.333298]  worker_thread+0x8f/0xf40
> [34693.333301]  ? __kthread_parkme+0x78/0xf0
> [34693.333303]  ? rescuer_thread+0xc50/0xc50
> [34693.333305]  kthread+0x2a0/0x390
> [34693.333308]  ? kthread_destroy_worker+0x90/0x90
> [34693.333310]  ret_from_fork+0x1f/0x40
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
      https://git.kernel.org/rdma/rdma/c/2b78832f50c4d7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
