Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D577E9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbjHPTxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbjHPTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A6E56;
        Wed, 16 Aug 2023 12:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B27B564146;
        Wed, 16 Aug 2023 19:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C71C433C8;
        Wed, 16 Aug 2023 19:52:42 +0000 (UTC)
Date:   Wed, 16 Aug 2023 15:52:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sishuai Gong <sishuai.system@gmail.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracefs: avoid setting i_mode to a temp value
Message-ID: <20230816155245.6ead4384@gandalf.local.home>
In-Reply-To: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
References: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 20:59:26 -0400
Sishuai Gong <sishuai.system@gmail.com> wrote:

> Right now inode->i_mode is updated twice to reach the desired value
> in tracefs_apply_options(). Because there is no lock protecting the two
> writes, other threads might read the intermediate value of inode->i_mode.
> 
> Thread-1			Thread-2
> // tracefs_apply_options()	//e.g., acl_permission_check
> inode->i_mode &= ~S_IALLUGO;
> 				unsigned int mode = inode->i_mode;
> inode->i_mode |= opts->mode;
> 
> I think there is no need to introduce a lock but it is better to
> only update inode->i_mode ONCE, so the readers will either see the old
> or latest value, rather than an intermediate/temporary value.
> 
> Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
> ---
>  fs/tracefs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 57ac8aa4a724..dca84ebb62fa 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -297,8 +297,7 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
>  	 */
>  
>  	if (!remount || opts->opts & BIT(Opt_mode)) {
> -		inode->i_mode &= ~S_IALLUGO;
> -		inode->i_mode |= opts->mode;
> +		inode->i_mode = (inode->i_mode & ~S_IALLUGO) | opts->mode;

You do realize that the compiler could decide to keep the original logic
even with this change? If it was crucial that the compiler did not, you
would need to have:

	if (!remount || opts->opts & BIT(Opt_mode)) {
		umode_t tmp = READ_ONCE(inode->i_mode);

		tmp &= ~S_IALLUGO
		tmp |= opts->mode;
		WRITE_ONCE(inode->i_mode, tmp);
	}		

And if you notice the !remount flag, this is only preformed when the file
system is actually mounted. Are the files visible before then?

Can you produce this race?

-- Steve



>  	}
>  
>  	if (!remount || opts->opts & BIT(Opt_uid))

