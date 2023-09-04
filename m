Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59ED791BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348530AbjIDRQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIDRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:16:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE60BCDB;
        Mon,  4 Sep 2023 10:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 42EC8CE0D97;
        Mon,  4 Sep 2023 17:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17A7C433C7;
        Mon,  4 Sep 2023 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693847790;
        bh=z4DqNpdUXkSKlQCerbH71YbBffTnlz8ppckUvbWEgAQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=md5B188Jx02TkRvw+Bm3W0gIyIOB9yoLiHlUfYrh2D49+oWLDh0LuF+zWS2FE3PCi
         MtnHlqvA2nWmJuAEMD9O+PUPe1BcqOp62MEmDm0Z6F3q6WRSt6vcJOXqcupdFvz2IH
         qo6riPdThjGHj38cBjFRaJDu4gRAnYHq/v5rg0OhBc7PLMDw/fGB+FB81WW+GJq8OP
         Gj1h9vqa0gVZ0+BFGYtAsp8TlljaLh+y/Uy1xKDhyuGbJ5csPlZg2+xvxMK9gbzVYl
         HuWjua9bBdeqoAs0xFhmoAESHvYmT26al8kvEWI8Y00Ql6+CiB+QOtGVQlDOD3jMsF
         4s+6BFW0zCc0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: mwifiex: Fix tlv_buf_left calculation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
References: <06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384778670.3420994.16227760665746324390.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:16:28 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> In a TLV encoding scheme, the Length part represents the length after
> the header containing the values for type and length. In this case,
> `tlv_len` should be:
> 
> tlv_len == (sizeof(*tlv_rxba) - 1) - sizeof(tlv_rxba->header) + tlv_bitmap_len
> 
> Notice that the `- 1` accounts for the one-element array `bitmap`, which
> 1-byte size is already included in `sizeof(*tlv_rxba)`.
> 
> So, if the above is correct, there is a double-counting of some members
> in `struct mwifiex_ie_types_rxba_sync`, when `tlv_buf_left` and `tmp`
> are calculated:
> 
> 968                 tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
> 969                 tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
> 
> in specific, members:
> 
> drivers/net/wireless/marvell/mwifiex/fw.h:777
>  777         u8 mac[ETH_ALEN];
>  778         u8 tid;
>  779         u8 reserved;
>  780         __le16 seq_num;
>  781         __le16 bitmap_len;
> 
> This is clearly wrong, and affects the subsequent decoding of data in
> `event_buf` through `tlv_rxba`:
> 
> 970                 tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
> 
> Fix this by using `sizeof(tlv_rxba->header)` instead of `sizeof(*tlv_rxba)`
> in the calculation of `tlv_buf_left` and `tmp`.
> 
> This results in the following binary differences before/after changes:
> 
> | drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
> | @@ -4698,11 +4698,11 @@
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:968
> |                 tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
> | -    1da7:      lea    -0x11(%rbx),%edx
> | +    1da7:      lea    -0x4(%rbx),%edx
> |      1daa:      movzwl %bp,%eax
> |  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:969
> |                 tmp = (u8 *)tlv_rxba  + sizeof(tlv_rxba->header) + tlv_len;
> | -    1dad:      lea    0x11(%r15,%rbp,1),%r15
> | +    1dad:      lea    0x4(%r15,%rbp,1),%r15
> 
> The above reflects the desired change: avoid counting 13 too many bytes;
> which is the total size of the double-counted members in
> `struct mwifiex_ie_types_rxba_sync`:
> 
> $ pahole -C mwifiex_ie_types_rxba_sync drivers/net/wireless/marvell/mwifiex/11n_rxreorder.o
> struct mwifiex_ie_types_rxba_sync {
> 	struct mwifiex_ie_types_header header;           /*     0     4 */
> 
>      |-----------------------------------------------------------------------
>      |  u8                         mac[6];               /*     4     6 */  |
>      |	u8                         tid;                  /*    10     1 */  |
>      |  u8                         reserved;             /*    11     1 */  |
>      | 	__le16                     seq_num;              /*    12     2 */  |
>      | 	__le16                     bitmap_len;           /*    14     2 */  |
>      |  u8                         bitmap[1];            /*    16     1 */  |
>      |----------------------------------------------------------------------|
> 								  | 13 bytes|
> 								  -----------
> 
> 	/* size: 17, cachelines: 1, members: 7 */
> 	/* last cacheline: 17 bytes */
> } __attribute__((__packed__));
> 
> Fixes: 99ffe72cdae4 ("mwifiex: process rxba_sync event")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

3 patches applied to wireless.git, thanks.

eec679e4ac5f wifi: mwifiex: Fix tlv_buf_left calculation
c7847241de28 wifi: mwifiex: Replace one-element array with flexible-array member in struct mwifiex_ie_types_rxba_sync
d5a93b7d2877 wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/06668edd68e7a26bbfeebd1201ae077a2a7a8bce.1692931954.git.gustavoars@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

