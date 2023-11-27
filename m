Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8AD7FAD45
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjK0WSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjK0WS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:18:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF73C61B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:13:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E5C433C8;
        Mon, 27 Nov 2023 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701123239;
        bh=WF3ITnRdxZ1JdO0IF1blZnQ+4lx1xVrjjRVhYkXkzak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MnUQn1J+TRZK4ykCnr4fHhXG5iAgndex0EG4yIj8lE6zDDyZEgE7wwMxwWR6Pv0Sd
         pIpCPSaVIvX4neY/0+Vdbz+nkvy4cVLDONkETExt31vS1NgQfa5lkLsNiHyV9mQCgh
         5zkYWwGJb/SEIq4Vt8rPFK+2RjYrvy/2HGNlc2mtqwBd60O+ZsT1RE1I4SaJ/kYoWX
         kSN/ZruvrSeb2ZrM2LeQXv+30gX3OMAYYmoBWnUR/CxbOhgdLCFwfR5raxLnPxoKcm
         kHtqEGN8L7h8YIUdbGg5dPgF/TlKKL49RR5+B8kohfahyDgPDNE7mOC0zsv7hqnUlM
         qZ2KAm2j3bj6w==
Date:   Tue, 28 Nov 2023 07:13:55 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded
 config
Message-Id: <20231128071355.1fd8b2857f4622bd111d8647@kernel.org>
In-Reply-To: <ZWSvfgFFu+ILKN4H@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-3-oss@malat.biz>
        <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
        <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
        <20231127074630.993db80be06f03067d8a1aef@kernel.org>
        <ZWSvfgFFu+ILKN4H@ntb.petris.klfree.czf>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 16:02:22 +0100
Petr Malat <oss@malat.biz> wrote:

> Hi Masami,
> On Mon, Nov 27, 2023 at 07:46:30AM +0900, Masami Hiramatsu wrote:
> 
> Shortened the mail as this seems to be the last open point
> 
> > > > And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
> > > > should be removed.
> > > 
> > > I have added BOOT_CONFIG_EMBED_APPEND_INITRD, because it's not backward
> > > compatible change and I didn't want to risk breaking current use cases.
> > > My change tries to get early options working without affecting how
> > > other options are handled, but I think appending the config is more
> > > reasonable behavior and if you do not see it as a problem to not be
> > > backward compatible here, I will delete the "replace" behavior.
> > 
> > That's a good point. OK if disabling CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD,
> > it must skip setting early_params to avoid "hidden setting" from the
> > embedded bootconfig.
>  
> That's not a good idea because then disabling BOOT_CONFIG_EMBED_APPEND_INITRD
> would disable early options handling even if the user doesn't use initrd at
> all, which we do not want.

Yes, so the config name and comment needs to be updated. The problematic point
is that we can not know where there is an initrd (and bootconfig on initrd)
until parsing/applying the early params. And we have to avoid setting "hidden"
parameter.

> 
> I suggest logging a KERN_NOTICE message if any early option was applied and
> at the same time embedded bootconfig was replaced.

No, that's no good because kernel log can be cleared.
Usually user will check /proc/cmdline to check what parameters are set, so at
least it needs to be updated, but also, we need to keep the original cmdline
for make sure the user can reuse it for kexec. To solve this issue without
contradiction, we need to ask user to set BOOT_CONFIG_EMBED_APPEND_INITRD=y
to support early params in bootconfig. (Thus it will be something like
"BOOT_CONFIG_EMBED_EARLY_PARAM")

Thank you,

>   Petr


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
