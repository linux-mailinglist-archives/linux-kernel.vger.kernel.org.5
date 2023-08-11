Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC3778567
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHKC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHKC2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:28:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3141FD;
        Thu, 10 Aug 2023 19:28:12 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMSNb6WSRzrSDr;
        Fri, 11 Aug 2023 10:26:55 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:28:09 +0800
Message-ID: <85802fb2-bf8f-e03e-1690-b05c34de9254@huawei.com>
Date:   Fri, 11 Aug 2023 10:28:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, Leon Romanovsky <leon@kernel.org>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
To:     Kees Cook <keescook@chromium.org>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
 <20230809070302.GR94631@unreal>
 <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
 <20230810102247.699ddc14@kernel.org> <202308101103.D0827667B@keescook>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <202308101103.D0827667B@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/11 2:23, Kees Cook wrote:
>> Let's add Kees in case he has a immediate recommendation on use of
>> strtomem() vs memcpy() for this case..
> tldr: use memcpy() instead of strscpy().
>
>
> Okay, I went to go read up on the history here. For my own notes, here's
> the original code, prior to 1cf3d5567f27 ("net: hns3: fix strncpy()
> not using dest-buf length as length issue"):
>
> static void hns3_dbg_fill_content(char *content, u16 len,
> 				  const struct hns3_dbg_item *items,
> 				  const char **result, u16 size)
> {
> 	char *pos = content;
> 	u16 i;
>
> 	memset(content, ' ', len);
> 	for (i = 0; i < size; i++) {
> 		if (result)
> 			strncpy(pos, result[i], strlen(result[i]));
> 		else
> 			strncpy(pos, items[i].name, strlen(items[i].name));
>
> 		pos += strlen(items[i].name) + items[i].interval;
> 	}
>
> 	*pos++ = '\n';
> 	*pos++ = '\0';
> }
>
> The warning to be fixed was:
>
> hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
>
> There are a few extra checks added in 1cf3d5567f27, but I'm more curious
> about this original code's intent. It seems very confusing to me.
>
> Firstly, why is "pos" updated based on "strlen(items[i].name)" even when
> "result[i]" is used? Secondly, why is "interval" used? (These concerns
> are mostly addressed in 1cf3d5567f27.)
>
> I guess I'd just like to take a step back and ask, "What is this
> function trying to do?" It seems to be building a series of strings in a
> " "-padding buffer, and it intends that the buffer be newline and %NUL
> terminated.
>
> It looks very much like it wants to _avoid_ adding %NUL termination when
> doing copies, which is why it's using strncpy with a length argument of
> the source string length: it's _forcing_ the copy to not be terminated.
> This is just memcpy.
>
> strtomem() is designed for buffer sizes that can be known at compile
> time, so it's not useful here (as was found), since a string is being
> built up and uses a moving pointer.
>
> I think the correct fix is to use memcpy() instead of strscpy(). No
> %NUL-truncation is desired, the sizes are already determined and bounds
> checked. (And the latter is what likely silenced the compiler warning.)
>
> -Kees
Yes, your guess is right, we want to copy the string without termination.
Thanks for your introduction, we understand why strtomem() is not 
userful here.

Regards
Jijie Shao
