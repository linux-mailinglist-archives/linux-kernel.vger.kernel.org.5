Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA27FC132
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjK1RSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjK1RSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:18:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361FD6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:18:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251DC433C7;
        Tue, 28 Nov 2023 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701191905;
        bh=V7IKAf0Hbu6oP2LSWp5l10ZwtBSliEPvVOx9m0gWfYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTHgE9PPklBAMdua0Gq+s/PRw++bw+Gj2frl4hyn3VWGoVDnO+zsrE+nNNl9kJCnm
         Aif6OPqLGkuMeO87bQeZNkZxecGgE35op+PwvNVEC2SVi6UE42oxDvc1NCf0whVyze
         u8jJwbYkbzVJX9f4i+TBbmFu3kC7Li++6kX/8uQ9anTcQ4LX74JdAzadEKlFWGdl5W
         h4rVFVKK67H6Cj6TLoi6TfcG2mi/7B1FgCnuhoSHVgdEqmLzIa4r2Lgph6KRcxAgDc
         GLP7RCT6Ldry21zdNGa0876otyOA+nuP48lukN/ibWTlhZV9gY3exB+auhSbDec+Yn
         v/iSmyghEjysQ==
Date:   Tue, 28 Nov 2023 09:18:23 -0800
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
Message-ID: <20231128171823.GA1148@sol.localdomain>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
 <20231127224719.GD1463@sol.localdomain>
 <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cabaa42-c366-4928-8294-ad261dae0043@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:00:17PM +0100, Sergei Shtepa wrote:
> But I haven't tested the code on a device where hardware inline encryption is
> available. I would be glad if anyone could help with this.
> > 
> > Anyway, this patch is better than ignoring the problem.  It's worth noting,
> > though, that this patch does not prevent blksnap from being set up on a block
> > device on which blk-crypto-fallback is already being used (or will be used).
> > When that happens, I/O will suddenly start failing.  For usability reasons,
> > ideally that would be prevented somehow.
> 
> I didn't observe any failures during testing. It's just that the snapshot
> image shows files with encrypted names and data. Backup in this case is
> useless. Unfortunately, there is no way to detect a blk-crypto-fallback on
> the block device filter level.

Huh, I thought that this patch is supposed to exclude blk-crypto-fallback too.
__submit_bio() calls bio->bi_bdev->bd_filter->ops->submit_bio(bio) before
blk_crypto_bio_prep(), so doesn't your check of ->bi_crypt_context exclude
blk-crypto-fallback?

I think you're right that it might actually be fine to use blksnap with
blk-crypto-fallback, provided that the encryption is done first.  I would like
to see a proper explanation of that, though.  And we still have this patch which
claims that it doesn't work, which is confusing.

- Eric
