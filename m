Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E97B586A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbjJBQvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjJBQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:51:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E64FBD;
        Mon,  2 Oct 2023 09:51:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C3C2C000D;
        Mon,  2 Oct 2023 16:51:03 +0000 (UTC)
Message-ID: <689fe81f-e2b4-9f99-4005-8ae330afb869@ovn.org>
Date:   Mon, 2 Oct 2023 18:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     dev@openvswitch.org, netdev@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, i.maximets@ovn.org
Subject: Re: [ovs-dev] [PATCH net-next 2/2] net: openvswitch: Annotate struct
 mask_array with __counted_byUse struct_size()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        keescook@chromium.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
References: <8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr>
 <f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr>
From:   Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <f66ddcf1ef9328f10292ea75a17b584359b6cde3.1696156198.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 13:07, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, in tbl_mask_array_alloc(), several things are allocated with
> a single allocation. Then, some pointer arithmetic computes the address of
> the memory after the flex-array.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>  net/openvswitch/flow_table.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
> index 9e659db78c05..8d9e83b4d62c 100644
> --- a/net/openvswitch/flow_table.h
> +++ b/net/openvswitch/flow_table.h
> @@ -48,7 +48,7 @@ struct mask_array {
>  	int count, max;
>  	struct mask_array_stats __percpu *masks_usage_stats;
>  	u64 *masks_usage_zero_cntr;
> -	struct sw_flow_mask __rcu *masks[];
> +	struct sw_flow_mask __rcu *masks[] __counted_by(size);

Did you mean 'max'?  There is no 'size' in the structure.

Also, the patch subject is messed up a bit.

Best regards, Ilya Maximets.
