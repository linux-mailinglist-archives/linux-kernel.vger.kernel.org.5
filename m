Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F677A5BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjHMJGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHMJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70109170E;
        Sun, 13 Aug 2023 02:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0014E6192D;
        Sun, 13 Aug 2023 09:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C4BC433C7;
        Sun, 13 Aug 2023 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691917562;
        bh=MOUoxzvR1CPW0JXDdK0xEyu1X8cNtNkMtsilpDEvcbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYdULDb/4Nhijf7L7WBumsbA9hrhVs7VwNP54EzDtzOKVulbm3HSfmW16szIRxjuX
         w5yEWRADqdXqZbp9y7o9mtSQ5ZBgG7oaVFMZiAJP1N1DWtXgI+9yEfe2MuYvdR4z9Z
         J9BI4EyddYptG4pypRMNzdkZd2D6hLuSucyjJI+CXoKTG6ewylWhuvyY6DfKD5FJYq
         6psC+N7aQehytw2cDkBEpM8zhL56FaS7Q17Th8P2W5Bvi1aO8EdyrVv2zj5hWIrwPf
         Hl3fxbkVl3Ay2fhprG+6EB1OJbrDUv7sETiJl6EJFj0bF7VHOE8v853fVk5ScN20qc
         WtLeD4bHQIiDg==
Date:   Sun, 13 Aug 2023 12:05:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
Message-ID: <20230813090557.GH7707@unreal>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
 <20230809070302.GR94631@unreal>
 <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
 <20230810102247.699ddc14@kernel.org>
 <202308101103.D0827667B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202308101103.D0827667B@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:23:46AM -0700, Kees Cook wrote:
> On Thu, Aug 10, 2023 at 10:22:47AM -0700, Jakub Kicinski wrote:
> > On Thu, 10 Aug 2023 15:45:50 +0800 Jijie Shao wrote:
> > > on 2023/8/9 15:03, Leon Romanovsky wrote:
> > > > On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote:  
> > > >> From: Hao Chen <chenhao418@huawei.com>
> > > >>
> > > >> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
> > > >> items to a string for content, and we add '\n' and '\0' in the last
> > > >> two bytes of content.
> > > >>
> > > >> strscpy() will add '\0' in the last byte of destination buffer(one of
> > > >> items), it result in finishing content print ahead of schedule and some
> > > >> dump content truncation.
> > > >>
> > > >> One Error log shows as below:
> > > >> cat mac_list/uc
> > > >> UC MAC_LIST:
> > > >>
> > > >> Expected:
> > > >> UC MAC_LIST:
> > > >> FUNC_ID  MAC_ADDR            STATE
> > > >> pf       00:2b:19:05:03:00   ACTIVE
> > > >>
> > > >> The destination buffer is length-bounded and not required to be
> > > >> NUL-terminated, so just change strscpy() to memcpy() to fix it.  
> > > > I think that you should change to strtomem() and not use plain memcpy().
> > > >
> > > > Thanks  
> > > 
> > > Hi:
> > > 
> > > We tried to replace memcpy with strtomem, but errors was reported during 
> > > compilation:
> > > /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In 
> > > function ‘hclge_dbg_fill_content.part.0’:
> > > /kernel/include/linux/compiler_types.h:397:38: error: call to 
> > > ‘__compiletime_assert_519’ declared with attribute error: BUILD_BUG_ON 
> > > failed: !__builtin_constant_p(_dest_len) || _dest_len == (size_t)-1
> > >    397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
> > > __COUNTER__)
> > >        |                                      ^
> > > /kernel/include/linux/compiler_types.h:378:4: note: in definition of 
> > > macro ‘__compiletime_assert’
> > >    378 |    prefix ## suffix();    \
> > >        |    ^~~~~~
> > > /kernel/include/linux/compiler_types.h:397:2: note: in expansion of 
> > > macro ‘_compiletime_assert’
> > >    397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
> > > __COUNTER__)
> > >        |  ^~~~~~~~~~~~~~~~~~~
> > > /kernel/include/linux/build_bug.h:39:37: note: in expansion of macro 
> > > ‘compiletime_assert’
> > >     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), 
> > > msg)
> > >        |                                     ^~~~~~~~~~~~~~~~~~
> > > /kernel/include/linux/build_bug.h:50:2: note: in expansion of macro 
> > > ‘BUILD_BUG_ON_MSG’
> > >     50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> > >        |  ^~~~~~~~~~~~~~~~
> > > /kernel/include/linux/string.h:302:2: note: in expansion of macro 
> > > ‘BUILD_BUG_ON’
> > >    302 |  BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||  \
> > >        |  ^~~~~~~~~~~~
> > > /kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:115:4: 
> > > note: in expansion of macro ‘strtomem’
> > >    115 |    strtomem(pos, result[i]);
> > >        |    ^~~~~~~~
> > > 
> > > In the strtomem macro, __builtin_object_size is used to calculate the 
> > > _dest_len.
> > > We tried to print the _dest_len directly, and the result was -1.
> > > How can we solve this?
> > 
> > Let's add Kees in case he has a immediate recommendation on use of
> > strtomem() vs memcpy() for this case..
> 
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

Thanks for an explanation.

> 
> -Kees
> 
> -- 
> Kees Cook
