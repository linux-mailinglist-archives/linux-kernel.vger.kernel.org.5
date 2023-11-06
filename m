Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AF97E2EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjKFV1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjKFV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:27:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E7D77
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:26:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f70391608so2541384f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699306016; x=1699910816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHe8D736RO4AAE+BmknvCqjTIPolggejI3ZO5PCW5Gg=;
        b=WbquFnkksKPPuTNKsS7UUvamWCuvOGHwB5RNZ4k5dlHLMcIgM8nXNcgR76UPTUyKB/
         3DoCg552QVZKZ0UIYyUzjj9oolPEyjhStwKuFs6ICc37XNaEK+NQlqhFmEKMRVHjl+Z7
         x0F0Y7fhLbUsr+WTc6gJEZIp4LeJvQT+RXIMHBs1WyrrXqi4a9l3L9WEmodhu6a+USWl
         u+YwE1Zmw//V4N5BOxw0pLTNt3tOOTG/RTTsKmqTzbuo2ffycaKEiAA1JL6c5+LBNFvu
         mrqhh07NTeMB1P/HjZdoYMZnxGkqAn9Eb5t5FAme9Guzhku8vr+1agAub2x809i+7WRc
         7nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699306016; x=1699910816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHe8D736RO4AAE+BmknvCqjTIPolggejI3ZO5PCW5Gg=;
        b=lnexCAJjdya+HG4UgA2raHZmuZxn/eNJxLDgzdbk46ZNIIIYtBgJkxyWTLOsvhq5Go
         7nWlA2E2U3zyXQXYgR1+V96lXajYumH5ksXlyptX3gumNdgCMmfHLWMWVyquAo5QNzeb
         VUx/mEOncP0lJ7Tv1S6iA/zYu9qM772MjB2HPIpcfHPChTqshJkDe/q0tDHX8gHP8OT4
         53wee/hqauzjBSltwIi43/ARMRDjeEFoE5BCocoB+F8lXhZP27F5oYMbkpXh8ylX778i
         WmO6w3aPAyfHAqsC9buoYAZ62t1lVfiqw66a77c4uHoV0suEbMcAWcvtb8/tDqkcF6Iy
         gQaA==
X-Gm-Message-State: AOJu0YyJuE44qI13scdr3hLFlhZMbM1FgTrbEXzE8YPHniBdAQuXaFS0
        IQf6rtGomdUWei25d+UFl8QxBw==
X-Google-Smtp-Source: AGHT+IHmQ+42Zq81k+WB7jgYWUFzJoI8vvHA2Nnhf+xl+7sVywooW0AAnWHAqTZ9U5Cl/2fsZBCFIA==
X-Received: by 2002:a05:6000:84:b0:32d:b55c:41fa with SMTP id m4-20020a056000008400b0032db55c41famr18624182wrx.28.1699306016270;
        Mon, 06 Nov 2023 13:26:56 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4bc2000000b0032da319a27asm583547wrt.9.2023.11.06.13.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:26:55 -0800 (PST)
Message-ID: <a8cc305d-0ab8-4ff7-b11a-94f51f33ec92@arista.com>
Date:   Mon, 6 Nov 2023 21:26:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, trix@redhat.com, noureddine@arista.com,
        hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 21:14, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
> 
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
> 
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
> 
>   net/ipv4/tcp_output.c:663:2: error: expected statement
>           }
>           ^
>   1 error generated.
> 
> While adding a semicolon after the label would resolve this, it is more
> in line with the kernel as a whole to refactor this block into a
> standalone function, which means the goto a label construct can just be
> replaced with a return statement. Do so to resolve the warning.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Seems like exactly the fix that my git testing tree had, with an
exception to naming the helper tcp_ao_options_write().
But then I found* your patch-v1 and decided not to send an alternative
patch.

Thanks for fixing this,
Reviewed-by: Dmitry Safonov <dima@arista.com>

*had to fix my Gmail lkml filter to label not only emails with cc/to my
name, but also the raw email address (usually, I got them to/cc "Dmitry
Safonov", but this one didn't have the name and got lost in the lkml pile).

> ---
> Changes in v3:
> - Don't use a pointer to a pointer for ptr parameter to avoid the extra
>   indirection in process_tcp_ao_options(), just return the modified ptr
>   value back to the caller (Eric)
> - Link to v2: https://lore.kernel.org/r/20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org
> 
> Changes in v2:
> - Break out problematic block into its own function so that goto can be
>   replaced with a simple return, instead of the simple semicolon
>   approach of v1 (Christoph)
> - Link to v1: https://lore.kernel.org/r/20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org
> ---
>  net/ipv4/tcp_output.c | 70 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 31 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0d8dd5b7e2e5..eb13a55d660c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -601,6 +601,44 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>  }
>  #endif
>  
> +static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
> +				      const struct tcp_request_sock *tcprsk,
> +				      struct tcp_out_options *opts,
> +				      struct tcp_key *key, __be32 *ptr)
> +{
> +#ifdef CONFIG_TCP_AO
> +	u8 maclen = tcp_ao_maclen(key->ao_key);
> +
> +	if (tcprsk) {
> +		u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
> +
> +		*ptr++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
> +			       (tcprsk->ao_keyid << 8) |
> +			       (tcprsk->ao_rcv_next));
> +	} else {
> +		struct tcp_ao_key *rnext_key;
> +		struct tcp_ao_info *ao_info;
> +
> +		ao_info = rcu_dereference_check(tp->ao_info,
> +			lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
> +		rnext_key = READ_ONCE(ao_info->rnext_key);
> +		if (WARN_ON_ONCE(!rnext_key))
> +			return ptr;
> +		*ptr++ = htonl((TCPOPT_AO << 24) |
> +			       (tcp_ao_len(key->ao_key) << 16) |
> +			       (key->ao_key->sndid << 8) |
> +			       (rnext_key->rcvid));
> +	}
> +	opts->hash_location = (__u8 *)ptr;
> +	ptr += maclen / sizeof(*ptr);
> +	if (unlikely(maclen % sizeof(*ptr))) {
> +		memset(ptr, TCPOPT_NOP, sizeof(*ptr));
> +		ptr++;
> +	}
> +#endif
> +	return ptr;
> +}
> +
>  /* Write previously computed TCP options to the packet.
>   *
>   * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -629,37 +667,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		opts->hash_location = (__u8 *)ptr;
>  		ptr += 4;
>  	} else if (tcp_key_is_ao(key)) {
> -#ifdef CONFIG_TCP_AO
> -		u8 maclen = tcp_ao_maclen(key->ao_key);
> -
> -		if (tcprsk) {
> -			u8 aolen = maclen + sizeof(struct tcp_ao_hdr);
> -
> -			*ptr++ = htonl((TCPOPT_AO << 24) | (aolen << 16) |
> -				       (tcprsk->ao_keyid << 8) |
> -				       (tcprsk->ao_rcv_next));
> -		} else {
> -			struct tcp_ao_key *rnext_key;
> -			struct tcp_ao_info *ao_info;
> -
> -			ao_info = rcu_dereference_check(tp->ao_info,
> -				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
> -			rnext_key = READ_ONCE(ao_info->rnext_key);
> -			if (WARN_ON_ONCE(!rnext_key))
> -				goto out_ao;
> -			*ptr++ = htonl((TCPOPT_AO << 24) |
> -				       (tcp_ao_len(key->ao_key) << 16) |
> -				       (key->ao_key->sndid << 8) |
> -				       (rnext_key->rcvid));
> -		}
> -		opts->hash_location = (__u8 *)ptr;
> -		ptr += maclen / sizeof(*ptr);
> -		if (unlikely(maclen % sizeof(*ptr))) {
> -			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
> -			ptr++;
> -		}
> -out_ao:
> -#endif
> +		ptr = process_tcp_ao_options(tp, tcprsk, opts, key, ptr);
>  	}
>  	if (unlikely(opts->mss)) {
>  		*ptr++ = htonl((TCPOPT_MSS << 24) |
> 
> ---
> base-commit: c1ed833e0b3b7b9edc82b97b73b2a8a10ceab241
> change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498

Thanks,
             Dmitry

