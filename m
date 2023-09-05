Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95E0792AF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjIEQpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350519AbjIEFEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:04:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3CCC5;
        Mon,  4 Sep 2023 22:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15C2ACE1020;
        Tue,  5 Sep 2023 05:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3746C433C7;
        Tue,  5 Sep 2023 05:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890242;
        bh=rNZ6gSz952FnYbdOwNayc8WW+NGygaXz472YSAOluYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b0GC0EYlTsTH7sHYMimcCh/EOaOHV4uGQ7vqQf/HuRw9Qulq+4xw75y80YOFRnkv9
         b4LwteX6i6uFW4Fi/ztQKY0pa4fXglePRsstW5agm7HVr4h21wC+8G73P3d1omz09n
         GGU1bpU3WQG8xLoTtxpVnQnHg6fx0QC3kZW9vs1ru7oUifErFtuAMkxJEKXZ7d4ht6
         sryxO7lp4qym/OQ1QPl3o9iWxAJOcuRmQROuIxNSbTxRonsykbGilksIMBUfibE0jK
         Q7wJoHWgM41x5ogHEVlUfkVJZSQroVIQvuP5b5/gvHNG2/fsm7hFKRlU03NC6GpKOD
         +ekqiIr73cSXQ==
Message-ID: <b5dcc85d-f709-a3a3-e7ad-9c71f278842a@kernel.org>
Date:   Tue, 5 Sep 2023 14:04:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: sata_mv: Fix incorrect string length computation in
 mv_dump_mem()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1a35e114a3dcc33053ca7cca41cb06b8426d8c40.1693857262.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 04:54, Christophe JAILLET wrote:
> snprintf() returns the "number of characters which *would* be generated for
> the given input", not the size *really* generated.
> 
> In order to avoid too large values for 'o' (and potential negative values
> for "sizeof(linebuf) o") use scnprintf() instead of snprintf().
> 
> Note that given the "w < 4" in the for loop, the buffer can NOT
> overflow, but using the *right* function is always better.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Doesn't this need Fixes and CC stable tags ?

> ---
>  drivers/ata/sata_mv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d105db5c7d81..45e48d653c60 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
>  
>  	for (b = 0; b < bytes; ) {
>  		for (w = 0, o = 0; b < bytes && w < 4; w++) {
> -			o += snprintf(linebuf + o, sizeof(linebuf) - o,
> -				      "%08x ", readl(start + b));
> +			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
> +				       "%08x ", readl(start + b));
>  			b += sizeof(u32);
>  		}
>  		dev_dbg(dev, "%s: %p: %s\n",

-- 
Damien Le Moal
Western Digital Research

