Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D837BF9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJJLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:36:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32FA4;
        Tue, 10 Oct 2023 04:36:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F79C433C8;
        Tue, 10 Oct 2023 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696937817;
        bh=kphcprxqB/I3b9pJ6JxA57GWF1FA2S/khI6Dosf5Juo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrtQM7gPxLsbazqeFCEYj5U/iKZxPu0aoABRwuxOTuYHPP3FMwEEgn/RBRPw8zMO+
         +K6X6VnQueWZtZpld6PeEsIdcBaJ9C1ThIEYgLc7Bkf2uodj+R3TgAQnZXfQdofQro
         ZV++fy2u90Plf1Wps+1fJjUnzd06h9GsL1fRPMzo=
Date:   Tue, 10 Oct 2023 13:36:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux@roeck-us.net, joe@perches.com,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/process/coding-style.rst: space around
 const/volatile
Message-ID: <2023101025-bungee-carve-2b4b@gregkh>
References: <20231010101240.992984-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010101240.992984-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:12:40PM +0200, Max Kellermann wrote:
> There are currently no rules on the placement of "const" and
> "volatile", but a recent code submission revealed that there is
> clearly a preference for spaces around them.
> 
> checkpatch.pl has no check at all for this; though it does sometimes
> complain, but only because it erroneously thinks that the "*" (on
> local variables) is an unary dereference operator, not a pointer type.
> 
> Current coding style for const pointers-to-pointers:
> 
>  "*const*": 2 occurrences
>  "* const*": 3
>  "*const *": 182
>  "* const *": 681
> 
> Just const pointers:
> 
>  "*const": 2833 occurrences
>  "* const": 16615
> 
> Link: https://lore.kernel.org/r/264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net/
> Link: https://lore.kernel.org/r/f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  Documentation/process/coding-style.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..b40830517938 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -271,6 +271,18 @@ adjacent to the type name.  Examples:
>  	unsigned long long memparse(char *ptr, char **retptr);
>  	char *match_strdup(substring_t *s);
>  
> +Use space around the keywords ``const`` and ``volatile`` (except when
> +adjacent to parentheses).  Example:
> +
> +.. code-block:: c
> +
> +	const void *a;
> +	void * const b;
> +	void ** const c;
> +	void * const * const d;
> +	void * volatile e;
> +	int strcmp(const char *a, const char *b);

Don't encourage the use of volatile please, it shouldn't be needed in
kernel code (hint, almost all uses of it in the tree is wrong except for
asm statements and some .h files that know they need it for some
hardware operations.)

thanks,

greg k-h
