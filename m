Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054807FC3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjK1S55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbjK1S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E41701
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:57:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821E4C433C7;
        Tue, 28 Nov 2023 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701197862;
        bh=KIRVGvgTEo6MU+1ULyVc42k3ON+LvmquMKcr6ZnGB3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8HREUCGIlGLBK181OWcIiiwNM7az5F2/keOGgEmCp1N5CBiZzZbIyXGkTl6cDRpZ
         h8Mi1fpXus+5yAlhYTVVXAYfH7HJLlst3bzpeA3U7tcnwQIWVrBMSr/Usib3aA94xe
         43YUMNYUrAwk4y4uxr79scpnrC7f104NNqHAMUDt/XVR2L/xJtvhva7P0D98UW/nDH
         XT4K889yFY1VzQ73VM0o4ScUzCecJhELMaZk/1t/YMFcn+jE+hNAbqtpGWR00D9pxS
         iRXFetT1MZuufpT4Lb20BBecXM40n0krFVJFr/EoSATB0SBnyhdV7Qg8SY/BcvhZIn
         D93uAYnLbXatQ==
From:   SeongJae Park <sj@kernel.org>
To:     cuiyangpei <cuiyangpei@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cuiyangpei <cuiyangpei@xiaomi.com>
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Date:   Tue, 28 Nov 2023 18:57:39 +0000
Message-Id: <20231128185739.47916-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cuiyanpei,


Thank you for this nice patchset.

On Tue, 28 Nov 2023 15:34:39 +0800 cuiyangpei <cuiyangpei@gmail.com> wrote:

> The user space users can control DAMON and get the monitoring results
> via implements 'recording' feature in 'damon-sysfs'.  The feature
> can be used via 'record' and 'state' file in the '<sysfs>/kernel/mm/
> damon/admin/kdamonds/N/' directory.
> 
> The file allows users to record monitored access patterns in a text
> file. Firstly, users set the size of the buffer and the path of the
> result file by writing to the ``record`` file. Then the recorded
> results are first written in an in-memory buffer and flushed the
> recorded results to a file in batch by writing 'record' to the
> ``state`` file.
> 
> For example, below commands set the buffer to be 4 KiB and the result
> to be saved in ``/damon.txt``. ::
> 
>     # cd <sysfs>/kernel/mm/damon/admin/kdamonds/N
>     # echo "4096 /damon.txt" > record
>     # echo "record" > state

This reminds me the record feature of DAMON debugfs interface[1], which still
not merged in the mainline.  I deprioritized the patchset to have a better
answer to Andrew's questions on the discussion (nice definition of the binary
format and quatization of the benefit), and later I realized I don't have real
use case that this makes real benefit, so I'm no more aiming to make this
merged into the mainline.

More specifically, I'm now thinking the feature is not really needed since
trace event based recording works, and we found no problem so far.  The DAMON
user-space tool (damo)[2] also dropped support of the in-kernel record feature,
but we received no problem report.

Also, I believe DAMOS tried regions like feature could provide some level of
information, since it provides snapshot of the monitoring result, which
contains a time data, namely 'age'.

Could you please further elaborate your aimed use case of this feature and the
advantage compared to other alternatives (tracepoint-based recording or DAMOS
tried regions based snapshot collecting) I mentioned above?

[1] https://lore.kernel.org/linux-mm/20211011093057.30790-1-sj@kernel.org/
[2] https://github.com/awslabs/damo


Thanks,
SJ

> 
> Signed-off-by: cuiyangpei <cuiyangpei@xiaomi.com>
