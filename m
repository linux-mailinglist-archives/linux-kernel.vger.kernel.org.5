Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05E7FA255
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjK0OSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjK0ORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:17:31 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF711FE5;
        Mon, 27 Nov 2023 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=yMC1fr9zFr/aFbPIXFs2B98BYpQenlWqGbcREQeOEDM=; b=JAg3NTCQBfivlXVjbi5yc6w5nN
        OH9xE0Xb0p4xAYGVUKhJE+55+hIn3EVOPzrV992PsVxVFj25vj5Vdq5xJIT9R1ME1eTAp0Pp3B5mq
        lPjV9EtqsCnAs8Y2MmAR9gX+gA4wdAU8Yz+0navJ9BmK2oOHC00NdBrOGUjWi53MvQC8sG81Lldbd
        qwD0TXLNj+SmvUibAPXGVXdvDlAOd9X3PdfN08KYy6ZYrHIMTIedINIn3rfV1JOYvCuHWo0J8RUEG
        txzJg7gAr7Bs1FQl/xxc2q2U5DTGz7Y89PAVu/6DjQ03ruIyHy2NklKrQjZcFyzgcmCQ0c4x3CUo8
        M4AD6glw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1r7cK7-000ABW-7v; Mon, 27 Nov 2023 15:10:55 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1r7cK5-0001fA-I6; Mon, 27 Nov 2023 15:10:53 +0100
Subject: Re: [PATCH net] bpf: test_run: fix WARNING in format_decode
To:     Yonghong Song <yonghong.song@linux.dev>,
        Edward Adam Davis <eadavis@qq.com>,
        syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org,
        martin.lau@linux.dev, mhiramat@kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, rostedt@goodmis.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
References: <0000000000004b6de5060ab1545b@google.com>
 <tencent_884D1773977426D9D3600371696883B6A405@qq.com>
 <4f832b6f-97b1-45b1-a210-b497ee6e55d5@linux.dev>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8821dd97-3aed-1d3d-6c12-f5bc4fb88d5a@iogearbox.net>
Date:   Mon, 27 Nov 2023 15:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4f832b6f-97b1-45b1-a210-b497ee6e55d5@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27106/Mon Nov 27 09:39:12 2023)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 6:28 AM, Yonghong Song wrote:
> On 11/21/23 7:50 PM, Edward Adam Davis wrote:
>> Confirm that skb->len is not 0 to ensure that skb length is valid.
>>
>> Fixes: 114039b34201 ("bpf: Move skb->len == 0 checks into __bpf_redirect")
>> Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> Stan, Could you take a look at this patch?

I think this only papers over the bug.. also BPF selftests seem to break
with this change.

Looking again at the syzkaller trace :

   [...]
   Please remove unsupported %\0 in format string
   WARNING: CPU: 0 PID: 5068 at lib/vsprintf.c:2675 format_decode+0xa03/0xba0 lib/vsprintf.c:2675
   [...]

We need to fix bpf_bprintf_prepare() instead to reject invalid fmts such
as %0 and similar.

>>   net/bpf/test_run.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index c9fdcc5cdce1..78258a822a5c 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -845,6 +845,9 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>>   {
>>       struct qdisc_skb_cb *cb = (struct qdisc_skb_cb *)skb->cb;
>> +    if (!skb->len)
>> +        return -EINVAL;
>> +
>>       if (!__skb)
>>           return 0;

