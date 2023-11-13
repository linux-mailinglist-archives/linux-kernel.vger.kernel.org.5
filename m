Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE27EA277
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjKMR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjKMR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:57:31 -0500
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09CADB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:organization:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1699898243; x=1700762244;
 bh=G2z0me/yRSAtTPp8UJNn7Msm1z8dQes5+Guip9AJK88=; b=n3iyX7er2gZj
 lXYm6VnebHtV6UhYp5re8Pf4Wl3YqGYaZxgt0rhrU6MqLLUAHzstE25VLhXqcZeS
 Z75UYekNDVueA8iybypkttOQhiTV33brFhurYq4X+h/Oo4XF29874/+MM2WFjrP1
 19PszePLajEpbSNYb0iMMUjRz6mjEx4=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, akaher@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [v6.6][PATCH] eventfs: Check for NULL ef in eventfs_set_attr()
Date:   Mon, 13 Nov 2023 18:57:22 +0100
Message-ID: <1978591.lLQaUkDWoz@milian-workstation>
Organization: KDAB
In-Reply-To: <20231112121817.2713c150@rorschach.local.home>
References: <20231112121817.2713c150@rorschach.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 12. November 2023 18:18:17 CET Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The top level events directory dentry does not have a d_fsdata set to a
> eventfs_file pointer. This dentry is still passed to eventfs_set_attr().
> It can not assume that the d_fsdata is set. Check for that.
> 
> Link:
> https://lore.kernel.org/all/20231112104158.6638-1-milian.wolff@kdab.com/

Thanks you Steven,

this works like a charm.

Tested-by: Milian Wolff <milian.wolff@kdab.com>

> Fixes: 9aaee3eebc91 ("eventfs: Save ownership and mode")
> Reported-by: Milian Wolff <milian.wolff@kdab.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Note: This only affects 6.6 as the code in 6.7 here was rewritten.
>    I tested 6.7 and it does not have this bug.
> 
>  fs/tracefs/event_inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5fcfb634fec2..efbdc47c74dc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -113,14 +113,14 @@ static int eventfs_set_attr(struct mnt_idmap *idmap,
> struct dentry *dentry,
> 
>  	mutex_lock(&eventfs_mutex);
>  	ef = dentry->d_fsdata;
> -	if (ef->is_freed) {
> +	if (ef && ef->is_freed) {
>  		/* Do not allow changes if the event is about to be 
removed. */
>  		mutex_unlock(&eventfs_mutex);
>  		return -ENODEV;
>  	}
> 
>  	ret = simple_setattr(idmap, dentry, iattr);
> -	if (!ret)
> +	if (!ret && ef)
>  		update_attr(ef, iattr);
>  	mutex_unlock(&eventfs_mutex);
>  	return ret;


-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

