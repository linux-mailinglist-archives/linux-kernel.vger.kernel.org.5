Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834E3800DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379247AbjLAOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379208AbjLAOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:47:30 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70661170E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:47:36 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B1EkvpZ005615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 09:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701442020; bh=kArsuLagsSnYy/Wige3LZnikmXXjnr7ZjdM85XfWUMQ=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=fOxxb2mKE0KV987CyElNlxzOFvPu7JIxFgB6eAJd2sxQKtC6QZTFGVRHEcC65W/aq
         4wURw7svKD0bD3Kq0Y7hDinQBAm2JoCPhlhoD8IplEo1eM1jJuRYdiHjvTY8JYNW9p
         d7wxBe83et/K1i7I7lovT1D88M/Sdr4KXBx3/QrcsFkmbjXc+4CxOTLrOi3ozfjTpS
         B6iGc2ha+/NVtlyQxt+6h0oSN2YtdJsV60iqERx56Ygyw8CZ6Jh5JBQoOJ/MMVj06X
         Qhuarot+BqNf6APmPyMpI1XtEhlIe3f41psUBIqpN4UYN0zvbS3FSLKy4P9BE7prfU
         IGUWFDtXlgW3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5E5F515C0290; Fri,  1 Dec 2023 09:46:57 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        djwong@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com, stable@kernel.org
Subject: Re: [PATCH] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
Date:   Fri,  1 Dec 2023 09:46:55 -0500
Message-Id: <170144199127.633830.13561950566118838688.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231127063313.3734294-1-libaokun1@huawei.com>
References: <20231127063313.3734294-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2023 14:33:13 +0800, Baokun Li wrote:
> For files with logical blocks close to EXT_MAX_BLOCKS, the file size
> predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
> This can cause some blocks to be preallocated that will not be used.
> And after [Fixes], the following issue may be triggered:
> 
> =========================================================
>  kernel BUG at fs/ext4/mballoc.c:4653!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
>  Hardware name: linux,dummy-virt (DT)
>  pc : ext4_mb_use_inode_pa+0x148/0x208
>  lr : ext4_mb_use_inode_pa+0x98/0x208
>  Call trace:
>   ext4_mb_use_inode_pa+0x148/0x208
>   ext4_mb_new_inode_pa+0x240/0x4a8
>   ext4_mb_use_best_found+0x1d4/0x208
>   ext4_mb_try_best_found+0xc8/0x110
>   ext4_mb_regular_allocator+0x11c/0xf48
>   ext4_mb_new_blocks+0x790/0xaa8
>   ext4_ext_map_blocks+0x7cc/0xd20
>   ext4_map_blocks+0x170/0x600
>   ext4_iomap_begin+0x1c0/0x348
> =========================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
      commit: 2dcf5fde6dffb312a4bfb8ef940cea2d1f402e32

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
