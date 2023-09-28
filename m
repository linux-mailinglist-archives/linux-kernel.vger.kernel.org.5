Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB837B1E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjI1Nbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI1Nbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:31:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9ED1A3;
        Thu, 28 Sep 2023 06:31:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8757C433C7;
        Thu, 28 Sep 2023 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907889;
        bh=r0hQXmQnOijwmkf9TTTA4LIpwyQ/WrWVSuk4R6AtERI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuHbRTy20f7lg3HEHfC5CwQr73ZEW76NEwiuyFuC4fHFDUzq7PW/X3p6/1J0fOEjH
         LW7t1SFeuHfQ4TpVtJJ640Htkc5qUwzsHqDT2V7Qq/N+uo31KVka9RtC6X00e3Muls
         RXvp0qmYJ1iwoCPs67oOQHc6on38orfTcQQ59sBEZPmLfwnXpVYKVzJqsZeJcGi207
         sHo06mxLrYRbfhQBbZGpn02oypBUXPyJdCCt+NCuzNW54rUjRptNUMXUDSp//yPB12
         JACxToRH3G3ckvYtcuN6+K+ee48+p8iuMF7mh32CkQ3T8Vmyo4pozahVIdJA8PKZb0
         i7pnjucvXVpQw==
Date:   Thu, 28 Sep 2023 21:31:22 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     chao@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@coolpad.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: update documentation
Message-ID: <ZRWAKh02rWgWo5c+@debian>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, huyue2@coolpad.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230928131600.84701-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928131600.84701-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:16:00PM +0800, Jingbo Xu wrote:
>  - update new features like bloom filter and DEFLATE.
> 
>  - add documentation for the long xattr name prefixes, which was
>    landed upstream since v6.4.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 4654ee57c1d5..522183737be6 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -58,12 +58,14 @@ Here are the main features of EROFS:
>  
>   - Support extended attributes as an option;
>  
> + - Support a bloom filter that speeds up negative extended attribute lookups;
> +
>   - Support POSIX.1e ACLs by using extended attributes;
>  
>   - Support transparent data compression as an option:
> -   LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
> -   inplace decompression is also supported to avoid bounce compressed buffers
> -   and page cache thrashing.
> +   LZ4, MicroLZMA and DEFLATE algorithms can be used on a per-file basis; In
> +   addition, inplace decompression is also supported to avoid bounce compressed
> +   buffers and unnecessary page cache thrashing.
>  
>   - Support chunk-based data deduplication and rolling-hash compressed data
>     deduplication;
> @@ -268,6 +270,38 @@ details.)
>  
>  By the way, chunk-based files are all uncompressed for now.
>  
> +Long extended attribute name prefixes
> +-------------------------------------
> +There are use cases that extended attributes with different values can have

                        ^ where

> +only a few common prefixes (such as overlayfs xattrs).  The predefined prefixes
> +works inefficiently in both image size and runtime performance in such cases.

  ^ work

> +
> +The long xattr name prefixes feature is introduced to address this issue.  The
> +overall idea is that, apart from the existing predefined prefixes, the xattr
> +entry could also refer to user specified long xattr name prefixes, e.g.

                             ^ user-specified

> +"trusted.overlay.".
> +
> +When referring to a long xattr name prefix, the highest bit (bit 7) of
> +erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
> +represents the index of the referred long name prefix among all long name
> +prefixes.  Therefore, only the trailing part of the name apart from the long
> +xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
> +the full xattr name matches exactly as its long xattr name prefix.
> +
> +All long xattr prefixes are stored one by one in the packed inode as long as
> +the packed inode is valid, or meta inode otherwise.  The xattr_prefix_count (of

                                ^ the meta inode

> +on-disk superblock) indicates the total number of the long xattr name prefixes,

^ the on-disk superblock

> +while (xattr_prefix_start * 4) indicates the start offset of long name prefixes
> +in the packed/meta inode.  Note that, long extended attribute name prefixes is

                                                                            ^ are

> +disabled if xattr_prefix_count is 0.
> +
> +Each long name prefix is stored in the format: ALIGN({__le16 len, data}, 4),
> +where len represents the total size of the data part.  The data part is actually
> +represented by 'struct erofs_xattr_long_prefix', where base_index represents the
> +index of the predefined xattr name prefix, e.g. EROFS_XATTR_INDEX_TRUSTED for
> +"trusted.overlay." long name prefix, while the infix string kepts the string

                                                               ^ keeps
Thanks,
Gao Xiang
