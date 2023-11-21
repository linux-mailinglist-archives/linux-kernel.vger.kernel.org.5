Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375E57F39A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjKUW50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjKUW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:57:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F8D5D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:57:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD78FC433CA;
        Tue, 21 Nov 2023 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700607424;
        bh=xo0rZfEH6XOgDU8QdntjZwVzF3RfcOmi68IeS+5BMbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0N0ke0u8nUKNqiGzOQVsNoUAQgSoLko6yZo8nn7CfW9Ie6BVukB6bX1ompRMlmE0
         1TkBNpBJeiJ9MIW+71vtUoP9c62rm9Ecr0o4Sq1umvYuiPaR6YE7fKsE7QGWsLfuGB
         t8M7ObSFtgwGknfFtn97LRq1uN1MV7ZKLB3sX5Ks6ilZEcTnWOeBbpOSnXQrzOEEA8
         gDs36YtK8AN/sF8VMTKBenqQlyrLvLmiT2D9Bik4vg25eUUivRUBUOcL5Fzt5Tuhes
         i/MtnhgzGE/bgcb9yOvEcrX0l0PUIX9azTL+9nw9ZeaVxcsrRbER9HQmBIBd8Er2aL
         jO2/rDb8+AHrQ==
Date:   Tue, 21 Nov 2023 14:57:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>
Subject: Re: [PATCH 1/2] dm verity: init fec io before cleaning it
Message-ID: <20231121225702.GA2172@sol.localdomain>
References: <cover.1700555778.git.bo.wu@vivo.com>
 <419e7aa58f67d90020512892f7652623e8c9f059.1700555778.git.bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419e7aa58f67d90020512892f7652623e8c9f059.1700555778.git.bo.wu@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:55:28AM -0700, Wu Bo wrote:
> If BIO error, it may goto verity_finish_io() before
> verity_fec_init_io(). Therefor, the fec_io->rs is not initialized and
> may crash when doing memory freeing in verity_fec_finish_io().
> 
> Crash call stack:
>  die+0x90/0x2b8
>  __do_kernel_fault+0x260/0x298
>  do_bad_area+0x2c/0xdc
>  do_translation_fault+0x3c/0x54
>  do_mem_abort+0x54/0x118
>  el1_abort+0x38/0x5c
>  el1h_64_sync_handler+0x50/0x90
>  el1h_64_sync+0x64/0x6c
>  free_rs+0x18/0xac
>  fec_rs_free+0x10/0x24
>  mempool_free+0x58/0x148
>  verity_fec_finish_io+0x4c/0xb0
>  verity_end_io+0xb8/0x150
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

What commit introduced this bug?  It looks like it was commit 5721d4e5a9cd ("dm
verity: Add optional "try_verify_in_tasklet" feature"), which moved the call to
verity_fec_init_io() from verity_map() to verity_work().  Do you agree?  Should
the call to verity_fec_init_io() perhaps be moved back to verity_map(), instead
of putting it in verity_end_io()?  Or maybe another call to verity_fec_init_io()
should be added only just before the call to verity_finish_io() in
verity_end_io(), given that it's not needed in the tasklet case?

In any case, please also add a Fixes tag with the appropriate commit, as well as
a "Cc stable" tag.

- Eric
