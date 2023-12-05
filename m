Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD8804411
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343889AbjLEB23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:28:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA0102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:28:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5F7C433C7;
        Tue,  5 Dec 2023 01:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701739713;
        bh=L369r6QG+1soJZ/sl7HyL9wmEkarV3L7SQPXkpSpAD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z4+avRTqadCix0I52N1G9GAJ1/JvqMmqAyXFykcz2aOLy7BDAttc2R6jB7ENY9l8l
         lZzHtJZGQFAsG4RclyT+uGsYYCoz+o4EkvjxRfp3eDhpmLvC6/QQEliLW4RRUT1yQ9
         xxpyaqoH/nxQlgxP2xdmwgpZK/b/M/BB0QU9LhIJhOtYPliFXRzVTPRGQAI8ExXT0D
         Orlvgq0u8JWPkJLAOt7P/11SgMED8HRp15G7vsEXAWyK2h8PFSPSHKy/1snNbzoYtp
         0wJTIZqdGgx787/sDySjSpG97+PmgPsqBcy6vNduWBGDcJ3QRkRt8K/9faTb62lFdL
         cOUZLkx0emk6Q==
Date:   Mon, 4 Dec 2023 17:28:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Restrict max filesize for 16K f2fs
Message-ID: <20231205012831.GA1168@sol.localdomain>
References: <20231204234615.3592624-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204234615.3592624-1-drosen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:46:15PM -0800, Daniel Rosenberg via Linux-f2fs-devel wrote:
> Blocks are tracked by u32, so the max permitted filesize is
> U32_MAX * BLOCK_SIZE. Additionally, in order to support crypto data unit
> sizes of 4K with a 16K block size with IV_INO_LBLK_{32,63}, we must

{32,63} should be {32,64}

> +	/*
> +	 * For compatibility with FSCRYPT_POLICY_IV_INO_LBLK_{64,32} with a
> +	 * 4K crypto data unit, we must restrict the max filesize to what can
> +	 * fit within U32_MAX data units.

FSCRYPT_POLICY_IV_INO_LBLK_{64,32} should be
FSCRYPT_POLICY_FLAG_IV_INO_LBLK_{64,32}

> +	 *
> +	 * Since the blocksize must currently be equal to the page size,
> +	 * we can use a constant for that. Note if this is not the case
> +	 * in the future that inode is NULL while setting up the superblock.

I'm not sure what the last sentence is trying to say.

> +	 */
> +
> +	result = min(result, ((loff_t) U32_MAX * 4096) >> F2FS_BLKSIZE_BITS);

Is it intentional that this is off by 1?  If indices can be up to U32_MAX, then
the maximum size is U32_MAX + 1.  It's not a bad idea to go with the lower size,
so that max_index + 1 does not overflow.  But that's not what the explanation
says, so this seems to be accidental.

- Eric
