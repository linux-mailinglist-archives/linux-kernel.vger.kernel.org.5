Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86A7780A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjHJSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbjHJSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743C271B;
        Thu, 10 Aug 2023 11:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A896667E;
        Thu, 10 Aug 2023 18:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F88DC433C7;
        Thu, 10 Aug 2023 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691693236;
        bh=MI9uA1gPyDnlzeAssRrd1QMSMWY9aArciSGRIr3kqK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NeQCgZ4lJ5NLzZkzbwQGFThnLvvxX9FDvSS9qK5+xyyWBCRwW1dDDO1VTdCyyDdmm
         QHnDWXey4AB8UI5tDnapUfxtxBDWkFEVOGkvCuNJIW3YVul9lopEeDgutRqken9Kv8
         +ag9EVbe8PWr3fe8a6Lg5B3ztfggob3/tkhHo6Vc7WKFl669KMdGDH81cnBU8Ittv7
         QfinEeffixpXG7XlykynfpXCriPN/snKt3scSyOW/Hac4c5z72krzz6HdjxCq+DKhq
         HSLr5MVrXtvFdFKhLpFZAN4tvOryZ8ZgKDDDwbE8bUQS975cev+u7vjxR0seeXohta
         wUYjU8YEa5YBg==
Date:   Thu, 10 Aug 2023 11:47:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leon@kernel.org>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <20230810114715.32c8d525@kernel.org>
In-Reply-To: <202308101103.D0827667B@keescook>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
        <20230809070302.GR94631@unreal>
        <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
        <20230810102247.699ddc14@kernel.org>
        <202308101103.D0827667B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 11:23:46 -0700 Kees Cook wrote:
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

Got it, thanks!
