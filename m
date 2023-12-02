Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E73801A4A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjLBDw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjLBDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:52:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770C10D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:52:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788CFC433C7;
        Sat,  2 Dec 2023 03:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701489151;
        bh=5DQc1mOWcsTDXpyiHSerNZx+ehkcdBrL+QVWurjwA8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdtDKs2SVnXzus+bjT+foTkDMO2BdnkqVjvd9mr6SUuW0Z72upvKEiRzZnJgme3ip
         WfDaGNJIkRsdmet17u1wzDSWFu9UxVg8rFGxXuftKNXXUFPfufN7HR9LbVIoVRfMnL
         F0U9z5bFRWDn8+3E9IFhzm9PF54xT2kXfBcPiKQJuWzGe43/VpDwykcYYiLhMHs6g8
         vT/Em5Ux38sXz24j88Z+E+EA2Vb2+1Sqooh1iWffYs3i6Z0b+AmnxAb9pHtc5CT98w
         Eoq1xJmdvLXcf6UYNvILWJqsRMMXmFr6qEbsOWky2ONE4SVxgAYHkZYV0VrMQ59Nzp
         VQN/mQoHzTpoA==
Date:   Fri, 1 Dec 2023 19:52:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Restrict max filesize for 16K f2fs
Message-ID: <20231202035229.GA41173@sol.localdomain>
References: <20231202030347.2330936-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202030347.2330936-1-drosen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 07:03:47PM -0800, Daniel Rosenberg via Linux-f2fs-devel wrote:
> +	/* For compatibility with 4K crypto unit size, we must restrict
> +	 * the max filesize to what can fit within U32_MAX 4K units.
> +	 * Since the blocksize must currently be equal to the page size,
> +	 * we can grab that from there. inode is NULL when setting up
> +	 * the superblock.
> +	 */
> +
> +	result = min(result, ((loff_t) U32_MAX * 4096) >> PAGE_SHIFT);

This should be formatted like:

	/*
	 * For compatibility with ...
	 */
	result = ...

Also, the comment should mention that this is for the IV_INO_LBLK_64 and
IV_INO_LBLK_32 encryption settings.  There is no issue with the default
encryption setting.

Also, use F2FS_BLKSIZE_BITS instead of PAGE_SHIFT?

Also, the commit message could use:

	Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")

- Eric
