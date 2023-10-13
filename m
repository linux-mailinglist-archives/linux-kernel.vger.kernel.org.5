Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482E97C8BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjJMQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:54:47 -0400
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B265AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:54:45 -0700 (PDT)
Message-ID: <58ed787f-a3b1-58d3-74a5-3a6e8c4c970a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697216082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFYiULr6F/P0Mtox7L6PbFCpW6iv+F01a/eo96NoyTs=;
        b=TUHuLF04Jm3hSEVbAw2g19VbmJgt632qjJxcZSSi5yKBZUiHK07SX1NECkqY+moL56vlyJ
        cIWcNlgp5VmjTwUhVpbPpmwYpykxL1qffWPVUyB5WHxqsNlahLMoF4tn5w+3bz1eoCH18Y
        NJPxOnXWj4ER5rkSg2XIhT1ogYHo8uY=
Date:   Fri, 13 Oct 2023 09:54:35 -0700
MIME-Version: 1.0
Subject: Re: linux-next: build warning after merge of the bpf-next tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231013114007.2fb09691@canb.auug.org.au>
 <20231013163034.73314060@canb.auug.org.au>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231013163034.73314060@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 10:30 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 13 Oct 2023 11:40:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the bpf-next tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> net/ipv4/af_inet.c: In function 'inet_getname':
>> net/ipv4/af_inet.c:791:13: warning: unused variable 'sin_addr_len' [-Wunused-variable]
>>    791 |         int sin_addr_len = sizeof(*sin);
>>        |             ^~~~~~~~~~~~
>>
>> Introduced by commit
>>
>>    fefba7d1ae19 ("bpf: Propagate modified uaddrlen from cgroup sockaddr programs")
> 
> This became a build failure for the i386 defconfig build, so I applied
> the following patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 13 Oct 2023 16:25:08 +1100
> Subject: [PATCH] fix up for "bpf: Propagate modified uaddrlen from cgroup sockaddr programs"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   net/ipv4/af_inet.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 7e27ad37b939..0fcab6b6cb04 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -788,7 +788,9 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>   	struct sock *sk		= sock->sk;
>   	struct inet_sock *inet	= inet_sk(sk);
>   	DECLARE_SOCKADDR(struct sockaddr_in *, sin, uaddr);
> +#ifdef CONFIG_CGROUP_BPF
>   	int sin_addr_len = sizeof(*sin);
> +#endif

Thanks for the report and taking care of it.

Daan, something that was missed in ipv4 getname. It should be done similar to 
inet6_getname() in af_inet6.c such that it "return sin_addr_len;" in this 
function to avoid the compiler warning here in ipv4.

