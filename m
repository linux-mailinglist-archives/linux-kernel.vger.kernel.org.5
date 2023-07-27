Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34FC765B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjG0SDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG0SDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:03:07 -0400
Received: from out-74.mta1.migadu.com (out-74.mta1.migadu.com [IPv6:2001:41d0:203:375::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BF2D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:03:05 -0700 (PDT)
Message-ID: <78844509-f01f-20cd-4719-49d7480d7aee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690480983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UN2gCovcnQF/n0WdaSNMF0rqbN7wNxdtIMcf2HnumI=;
        b=TyFpCkm7W6ezQm0abgCgNHNyuCaRr+aNeqQPeCuPCYKfDTNODTmIr3ZgPp1FWWux6RWWxC
        gdCwtJ9lSiaBCv39rCFCyUAMunEAT5jTNf0ZjEPNSvy/hWQAc64jwJZ4epGvnxjuu5chPF
        b8uyZ7mv6P4NJjjrCHjHI4vaPZuYbn4=
Date:   Thu, 27 Jul 2023 11:02:57 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] samples/bpf: Update sockex2: get the expected output
 results
Content-Language: en-US
To:     George Guo <guodongtai@kylinos.cn>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, masahiroy@kernel.org, ndesaulniers@google.com,
        nathan@kernel.org, nicolas@fjasle.eu
References: <20230726070955.178288-1-guodongtai@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230726070955.178288-1-guodongtai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 12:09 AM, George Guo wrote:
> Running "ping -4 -c5 localhost" only shows 4 times prints not 5:
> 
> $ sudo ./samples/bpf/sockex2
> ip 127.0.0.1 bytes 392 packets 4
> ip 127.0.0.1 bytes 784 packets 8
> ip 127.0.0.1 bytes 1176 packets 12
> ip 127.0.0.1 bytes 1568 packets 16
> 
> debug it with num prints:
> $ sudo ./samples/bpf/sockex2
> num = 1: ip 127.0.0.1 bytes 392 packets 4
> num = 2: ip 127.0.0.1 bytes 784 packets 8
> num = 3: ip 127.0.0.1 bytes 1176 packets 12
> num = 4: ip 127.0.0.1 bytes 1568 packets 16
> 
> The reason is that we check it faster, just put sleep(1) before check
> while(bpf_map_get_next_key(map_fd, &key, &next_key) == 0).
> Now we get the expected results:
> 
> $ sudo ./samples/bpf/sockex2
> num = 0: ip 127.0.0.1 bytes 392 packets 4
> num = 1: ip 127.0.0.1 bytes 784 packets 8
> num = 2: ip 127.0.0.1 bytes 1176 packets 12
> num = 3: ip 127.0.0.1 bytes 1568 packets 16
> num = 4: ip 127.0.0.1 bytes 1960 packets 20
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   samples/bpf/sockex2_user.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> index 2c18471336f0..84bf1ab77649 100644
> --- a/samples/bpf/sockex2_user.c
> +++ b/samples/bpf/sockex2_user.c
> @@ -18,8 +18,8 @@ int main(int ac, char **argv)
>   	struct bpf_program *prog;
>   	struct bpf_object *obj;
>   	int map_fd, prog_fd;
> -	char filename[256];
> -	int i, sock, err;
> +	char filename[256], command[64];
> +	int i, sock, err, num = 5;
>   	FILE *f;
>   
>   	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
> @@ -42,21 +42,22 @@ int main(int ac, char **argv)
>   	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
>   			  sizeof(prog_fd)) == 0);
>   
> -	f = popen("ping -4 -c5 localhost", "r");
> +	snprintf(command, sizeof(command), "ping -4 -c%d localhost", num);
> +	f = popen(command, "r");
>   	(void) f;
>   
> -	for (i = 0; i < 5; i++) {
> +	for (i = 0; i < num; i++) {
>   		int key = 0, next_key;
>   		struct pair value;
>   
> +		sleep(1);
>   		while (bpf_map_get_next_key(map_fd, &key, &next_key) == 0) {
>   			bpf_map_lookup_elem(map_fd, &next_key, &value);
> -			printf("ip %s bytes %lld packets %lld\n",
> +			printf("num = %d: ip %s bytes %lld packets %lld\n", i,
>   			       inet_ntoa((struct in_addr){htonl(next_key)}),
>   			       value.bytes, value.packets);
>   			key = next_key;
>   		}
> -		sleep(1);

Moving sleep around is paper wrapping it. e.g. what if the first ping did start 
later than 1s? Please address it properly.

tbf, as an example instead of regression test, displaying fewer line output is fine.

>   	}
>   	return 0;
>   }

