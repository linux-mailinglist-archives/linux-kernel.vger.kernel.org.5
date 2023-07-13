Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC9751856
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjGMFu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGMFu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:50:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAAC1BD5;
        Wed, 12 Jul 2023 22:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GFMF1ikSol53pF8uOEYCDZ1uK/JIIE1rXx1j7+aTy1Y=; b=x5xLgY8KePVopF6k6iKAFKM/QG
        P+4A2RB3luT+Ws8svb8REwmQaHeRbkoCjA9Af2WrJZb8mRuM/yjfryuJsmtFM69Y3IssVptJJTksC
        RG7x556xM0UQIkcBxlIIN4Zef6sOPTp7Q7twuECA1YqrVG/8ndJnKCf6zs2HF9dS78IC1uh+Xx4Oj
        t4AIjyGIugFrOD3fIoJWGFZZsKCWJuYJyxdguKPnI5u/yIuAme0Fo3ySGMVufMUWtgEHpKsatIIxP
        +L1qSalel55POdhvo+0+AVTAhscTS70DCmxARuO5QPwJaRhSPxGTKTjsvNOuWm2FuZ7Luup69oQ2A
        lQDDfFrg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJpDS-0022Nf-05;
        Thu, 13 Jul 2023 05:50:14 +0000
Message-ID: <27105f25-f3f9-0856-86e5-86236ce83dee@infradead.org>
Date:   Wed, 12 Jul 2023 22:50:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v1] bna:Fix error checking for debugfs_create_dir()
Content-Language: en-US
To:     Wang Ming <machel@vivo.com>, Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krishna Gudipati <kgudipat@brocade.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230713053823.14898-1-machel@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713053823.14898-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/12/23 22:38, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in bnad_debugfs_init() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> 
> Fixes: 7afc5dbde091 ("bna: Add debugfs interface.")

Comment from fs/debugfs/inode.c:

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

so no, drivers should not usually care about debugfs function call results.
Is there some special case here?

> ---
>  drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> index 04ad0f2b9677..678a3668a041 100644
> --- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> +++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
> @@ -512,7 +512,7 @@ bnad_debugfs_init(struct bnad *bnad)
>  	if (!bnad->port_debugfs_root) {
>  		bnad->port_debugfs_root =
>  			debugfs_create_dir(name, bna_debugfs_root);
> -		if (!bnad->port_debugfs_root) {
> +		if (IS_ERR(bnad->port_debugfs_root)) {
>  			netdev_warn(bnad->netdev,
>  				    "debugfs root dir creation failed\n");
>  			return;

-- 
~Randy
