Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9177BC9B0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjJGUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:10:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D57BA;
        Sat,  7 Oct 2023 13:10:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B99C433C7;
        Sat,  7 Oct 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696709427;
        bh=EI+Jf8MyoFRrRMDhTXvbJDTwh+ESwYKlXTuaakRtzs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dbv8D4brUV7WGJZolzIPMHeTV5YeDeayiREoz1J72BdJbAs8Osmyg6iRzym6AR8BM
         MX6vFlyHHpidaODVwIl0EF82M5nA0sj69YH8TClpwIJh7aWfRBa3rLm8rQlugexkm9
         teawuemJYPXm0hS9+OWrEkw1L+PCvjNpxCBUv6PEd7BCbXPTafyWSw+YoGP0ql3Mjq
         TsvRiFU8BeWmog7Opy9wDzrYNY6PfMB8915xJU83Pg0wQ+hSIbyZRlpdpItKak91La
         /mPN5mXFSuVIxBdldqxTCtWTiHxf0u3MhpYWPEFlFpheXGLUvgvL4SGvDqZi1lhN+k
         VvgOU9jLJbQkQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date:   Sat,  7 Oct 2023 20:10:24 +0000
Message-Id: <20231007201024.3576-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007200432.3110-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 7 Oct 2023 20:04:32 +0000 SeongJae Park <sj@kernel.org> wrote:

> DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
> is already out of the main loop and before_terminate callback
> (damon_sysfs_before_terminate() in this case) is not yet called.  And
> damon_sysfs_handle_cmd() can further be finished before the callback is
> invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
> which is not locked by anyone.  This happens because the callback
> function assumes damon_sysfs_cmd_request_callback() should be called
> before it.  Check if the assumption was true before doing the unlock, to
> avoid this problem.
> 
> Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
> Cc: <stable@vger.kernel.org> # 6.2.x

And this will not cleanly applied to 6.5.y, since this is based on latest
mm-unstable tree.  I will send a backport once this is merged into the
mainline.


Thanks,
SJ

[...]
