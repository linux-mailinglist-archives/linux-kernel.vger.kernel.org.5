Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158DD773302
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjHGWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHGWh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:37:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38430F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=RChfjjdAzNr1F57W+nsw6J9j7yaKmQaVWXDZCVm7gbY=; b=DJqHbMgCF7eNGGGE1v/QmHiKdp
        qOWxjEkSiNTi1z3gTlt98cX/u60Ryed7Ku1CI6iCD2dtF0hiwQBw+Yf/+73SikJD5UHIQeChaHy7m
        4zFabUAqLhdanssd/g/ra3qwAi3nF1jZqiQfSweP6Sto7BeHtyNEbEP4/3DYtaLV5rWy3jv64VJPL
        +ayCAorurBAp5it4jRSneOp67tmCkIghOBpJDrLC3R/cLxagol73MUUjTbBrmPR9nf88qbEki7N9R
        iZsqyCJOn5EKFvlBArqPdupd2MCprWxnIzL1h42pfEkS2A3AYaCQJP7Sdc8NU3FNHJgr+l9C63+SA
        6/2MUDMA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qT8ql-00103c-2S;
        Mon, 07 Aug 2023 22:37:19 +0000
Message-ID: <41713c95-51a8-8e2a-9c70-dab10dacf26d@infradead.org>
Date:   Mon, 7 Aug 2023 15:37:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] hexdump: minimize the output width of the offset
Content-Language: en-US
To:     thunder.leizhen@huaweicloud.com, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-2-thunder.leizhen@huaweicloud.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230805072116.1260-2-thunder.leizhen@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/5/23 00:21, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The offset of case DUMP_PREFIX_OFFSET always starts from 0. Currently,
> the output width is fixed to 8. But we usually dump only tens or hundreds
> of bytes, occasionally thousands of bytes. Therefore, the output offset
> value always has a number of leading zeros, which increases the number of
> bytes printed and reduces readability. Let's minimize the output width of
> the offset based on the number of significant bits of its maximum value.
> 
> Before:
> dump_size=36:
> 00000000: c0 ba 8c 80 00 80 ff ff 6c 93 ee 2f ee bf ff ff
> 00000010: 00 50 1e 98 ff 27 ff ff 01 00 00 00 00 00 00 00
> 00000020: 80 ca 2f 98
> 
> After:
> dump_size=8:
> 0: c0 ba 89 80 00 80 ff ff
> 
> dump_size=36:
> 00: c0 3a 91 80 00 80 ff ff 6c 93 ae 76 30 ce ff ff
> 10: 00 60 cd 60 7d 4e ff ff 01 00 00 00 00 00 00 00
> 20: 40 9e 29 40
> 
> dump_size=300:
> 000: c0 ba 8d 80 00 80 ff ff 6c 93 ce d4 78 a7 ff ff
> 010: 00 00 16 18 0c 40 ff ff 01 00 00 00 00 00 00 00
> 020: 01 00 00 00 00 00 00 00 e8 bc 8d 80 00 80 ff ff
> ... ...
> 110: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 120: 00 08 12 01 0c 40 ff ff 00 00 01 00
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  lib/hexdump.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 06833d404398d74..86cb4cc3eec485a 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -263,12 +263,21 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  		    const void *buf, size_t len, bool ascii)
>  {
>  	const u8 *ptr = buf;
> -	int i, linelen, remaining = len;
> +	int i, linelen, width = 0, remaining = len;
>  	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
>  
>  	if (rowsize != 16 && rowsize != 32)
>  		rowsize = 16;
>  
> +	if (prefix_type == DUMP_PREFIX_OFFSET) {
> +		unsigned long tmp = len - 1;	/* offset start from 0, so minus 1 */
> +
> +		do {
> +			width++;
> +			tmp >>= 4;
> +		} while (tmp);
> +	}
> +

You could put all of that ^^^ in the case DUMP_PREFIX_OFFSET below.
Otherwise LGTM.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

>  	for (i = 0; i < len; i += rowsize) {
>  		linelen = min(remaining, rowsize);
>  		remaining -= rowsize;
> @@ -282,7 +291,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>  			       level, prefix_str, ptr + i, linebuf);
>  			break;
>  		case DUMP_PREFIX_OFFSET:
> -			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
> +			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
>  			break;
>  		default:
>  			printk("%s%s%s\n", level, prefix_str, linebuf);

-- 
~Randy
