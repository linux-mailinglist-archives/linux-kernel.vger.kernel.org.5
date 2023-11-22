Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6512B7F3D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjKVF26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjKVF2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:28:55 -0500
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B3D6E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:28:47 -0800 (PST)
Message-ID: <4f832b6f-97b1-45b1-a210-b497ee6e55d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700630925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hD50C65SyRlfrZivQBcgQbDNXXMp17iahMqbitu/UDs=;
        b=t1pw6u3HRRqNnLREfeSsRTYPDZzQ0FK4D1UpJYO48npsJYtMWOxVYqwNHDl8A0Mt6wOayM
        qPUIMOhMBqYRN61DKxUeCsLmVNccHvZYXn3a/52mT7Hl6CtgpmCi2tsRYCCT61J1N65pKC
        4UKp+utudAI/k0rhIwQda6mq0jqUZ6M=
Date:   Tue, 21 Nov 2023 21:28:29 -0800
MIME-Version: 1.0
Subject: Re: [PATCH net] bpf: test_run: fix WARNING in format_decode
Content-Language: en-GB
To:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        martin.lau@kernel.org, martin.lau@linux.dev, mhiramat@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rostedt@goodmis.org,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        yhs@fb.com
References: <0000000000004b6de5060ab1545b@google.com>
 <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/23 7:50 PM, Edward Adam Davis wrote:
> Confirm that skb->len is not 0 to ensure that skb length is valid.
>
> Fixes: 114039b34201 ("bpf: Move skb->len == 0 checks into __bpf_redirect")
> Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Stan, Could you take a look at this patch?


> ---
>   net/bpf/test_run.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index c9fdcc5cdce1..78258a822a5c 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -845,6 +845,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>   {
>   	struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
>   
> +	if (!skb->len)
> +		return -EINVAL;
> +
>   	if (!__skb)
>   		return 0;
>   
