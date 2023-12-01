Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D4800353
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377553AbjLAFva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377566AbjLAFv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:51:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E41730
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:51:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C3C433C7;
        Fri,  1 Dec 2023 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701409893;
        bh=u4fezI674MfIiRcaNlHhXBBvjWBXFe/Vu9dKNlCWKL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j9ftvqxc9QdhdMf9LvQAOFNLl5/DfDGD+5eO1gkcTof4dlFfhaa/DxzCv/MlYci2K
         nVKKlUNYr/rvetf5rUY7HUvCQGKpO3AnsFXhajtth5JZ4z12/acd/VY0f8acKdgHiD
         6FtrGZZneu8RZrC7lz9q/61uZv6kRVQ/SlX9Bs1p11qCa3h5SQ8oM8d9Txch0ST9a/
         Z0NMn0ggsiueRagWdsunV+KemTtgT63qU80cn26YguBY/2HicuBnGAqH/Nn+YeuRI3
         g0kTrHFXrxSRhhzLl7NOlqB54QtPToPdTZ74TkajfvJ5fMY0x4JwHOmyD4GP1e5h5u
         pM05lgAImQnaA==
Date:   Fri, 1 Dec 2023 14:51:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Message-Id: <20231201145129.30fcaf1b762a9b496ac44a2f@kernel.org>
In-Reply-To: <20231130205607.work.463-kees@kernel.org>
References: <20231130205607.work.463-kees@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 12:56:08 -0800
Kees Cook <keescook@chromium.org> wrote:

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> The negative return value is already handled by this code so no new
> handling is needed here.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for reporting! Let me pick this.

Thanks!

> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 99c051de412a..a84b85d8aac1 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -151,7 +151,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  		return -ENOMEM;
>  
>  	if (addr == FETCH_TOKEN_COMM)
> -		ret = strlcpy(dst, current->comm, maxlen);
> +		ret = strscpy(dst, current->comm, maxlen);
>  	else
>  		ret = strncpy_from_user(dst, src, maxlen);
>  	if (ret >= 0) {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
