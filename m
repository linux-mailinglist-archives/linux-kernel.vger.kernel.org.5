Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAE7FADB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjK0WrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjK0WrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:47:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDB1B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:47:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11659C433C8;
        Mon, 27 Nov 2023 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701125241;
        bh=Y4oxrecu9ql/C7+/pWvE72XQSeQO0hmoCWBxJdrSTgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCXakQs3Lvm/NZ4IohSRSzS5ha4CpLf9iXXNE2gzU12WjlKhA6BByL06gdkR2Yl8N
         qIcbnyv/O/hUAE+YcK+WEBL2opMGlawyFsswlIlOShGrocyxQsiF/ltCEsVRgtzk6f
         ZS1CgRTABTLrtC+wT2c06detaejWQs7FwoXclVZmVSEdLvZfQHU8tnC4lJtGkItyiC
         H/JZmfFNJQNuKYaHn7Y57Z5hYpiqPthrcfgNzEzAdOom/D01+Tp+ialYIspQdPEP4P
         HzC/JlWUWvBbXJFZHsI9Lo164J6yw4L4tpYyy8dFb/sUnoEAFYJl9n4RgmXEv+hAtE
         Ygv1bcTo7hedw==
Date:   Mon, 27 Nov 2023 14:47:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sergei Shtepa <sergei.shtepa@linux.dev>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 11/11] blksnap: prevents using devices with data
 integrity or inline encryption
Message-ID: <20231127224719.GD1463@sol.localdomain>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-12-sergei.shtepa@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:59:33PM +0100, Sergei Shtepa wrote:
> There is an opinion that the use of the blksnap module may violate the
> security of encrypted data. The difference storage file may be located
> on an unreliable disk or even network storage. 

I think this misses the point slightly.  The main problem is that blksnap writes
data in plaintext that is supposed to be encrypted, as indicated by the bio
having an encryption context.  That's just what it does, at least based on the
last patchset; it's not just "an opinion".  See
https://lore.kernel.org/linux-block/20a5802d-424d-588a-c497-1d1236c52880@veeam.com/

> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	if (bio->bi_crypt_context) {
> +		pr_err_once("Hardware inline encryption is not supported\n");
> +		diff_area_set_corrupted(tracker->diff_area, -EPERM);
> +		return false;
> +	}
> +#endif

The error message for ->bi_crypt_context being set should say
"Inline encryption", not "Hardware inline encryption".  The submitter of the bio
may have intended to use blk-crypto-fallback.

Anyway, this patch is better than ignoring the problem.  It's worth noting,
though, that this patch does not prevent blksnap from being set up on a block
device on which blk-crypto-fallback is already being used (or will be used).
When that happens, I/O will suddenly start failing.  For usability reasons,
ideally that would be prevented somehow.

- Eric
