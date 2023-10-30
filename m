Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E867DB52C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjJ3Icv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3Ics (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:32:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D00B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:32:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2553FC433C8;
        Mon, 30 Oct 2023 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698654766;
        bh=YJ9ZZit0sb1xELvhkWLuVnRRKf6RLGvT2DxscVJLozk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlpbA/4TO5VHBgETbcAPiGKDPbNXs1JbWvLVf0sCApqjpLQrfwQLy15BZEuUvLsyd
         xpECLgMazOZnIUv5uxfQ2aGy76CyelEg+9R6zhxlIgRJKMFQVDvBcZ7b2XZE+Moi8O
         0JVRNX9t11/eI6UoXzsnYHYUjsl6ga4zHTKyy/XZNLMvGV5WFYwTMMNAg3Kwc+EGSg
         l97WYD6nNCEthkwBxqEKPCvJR72QHAFm/FnZrnuwcEQNOw6zYyKiGXYOG2mAsi/zVD
         /etK+sanWgtWhhCIZBotD2cJQ5P0kxyH5CS9rVWvfpI4SP1ocnxQVR87V1UGi1fZY0
         n2FzHGfdyGMiA==
Date:   Mon, 30 Oct 2023 09:32:37 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     gaoyusong <a869920004@163.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] fs: Fix typo in access_override_creds()
Message-ID: <20231030-debatten-nachrangig-f58abcdac530@brauner>
References: <20231030015235.840410-1-a869920004@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030015235.840410-1-a869920004@163.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 01:52:35AM +0000, gaoyusong wrote:
> From: Yusong Gao <a869920004@163.com>
> 
> Fix typo in access_override_creds(), modify non-RCY to non-RCU.
> 
> Signed-off-by: gaoyusong <a869920004@163.com>
> ---
>  fs/open.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 98f6601fbac6..72eb20a8256a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
>  	 * 'get_current_cred()' function), that will clear the
>  	 * non_rcu field, because now that other user may be
>  	 * expecting RCU freeing. But normal thread-synchronous
> -	 * cred accesses will keep things non-RCY.
> +	 * cred accesses will keep things non-RCU.

I think this might have been intended as a joke aka "non-RCY" as in
"non-racy" here. I think best would be to change it to something like
"cred accesses will keep things non-racy and allows to avoid rcu freeing"
if you care enough.
