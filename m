Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965E76859B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjG3Nbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjG3Nb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:31:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CD10FA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690723883; bh=yo4I6s5/JIPLqK8K6k5zbNM/vTwpF+NR0NjfEi911yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYCE3PKH6dTdwp7caJgSksAupi4XvmTaFkgMI9PFU+ZnueloH0T1AZRScEJBD3QSj
         pTvpAmLgjoc+abV5T8ZhqUqV9QNN6k2r9qv3uCRsuwePmWnS5hYkpe3kmpeJOdMX4c
         Ab7lPQtG3eUy169iPFFTZWhOWQKFCqk4fRrBtbww=
Date:   Sun, 30 Jul 2023 15:31:22 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] erofs: deprecate superblock checksum feature
Message-ID: <f796b2ed-8564-45c3-bb04-44dfabb575c7@t-8ch.de>
References: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717112703.60130-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-17 19:27:03+0800, Jingbo Xu wrote:
> Later we're going to try the self-contained image verification.
> The current superblock checksum feature has quite limited
> functionality, instead, merkle trees can provide better protection
> for image integrity.

The crc32c checksum is also used by libblkid to gain more confidence
in its filesystem detection.
I guess a merkle tree would be much harder to implement.

This is for example used by the mount(8) cli program to allow mounting
of devices without explicitly needing to specify a filesystem.

Note: libblkid tests for EROFS_FEATURE_SB_CSUM so at least it won't
break when the checksum is removed.

> xxhash is also used in the following xattr name filter feature.  It is
> redundant for one filesystem to rely on two hashing algorithms at the
> same time.
> 
> Since the superblock checksum is a compatible feature, just deprecate
> it now.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> changes since v1:
> - improve commit message (Gao Xiang)
> 
> v1: https://lore.kernel.org/all/20230714033832.111740-1-jefflexu@linux.alibaba.com/
> ---
>  fs/erofs/Kconfig |  1 -
>  fs/erofs/super.c | 44 +++++---------------------------------------
>  2 files changed, 5 insertions(+), 40 deletions(-)

> [..]
