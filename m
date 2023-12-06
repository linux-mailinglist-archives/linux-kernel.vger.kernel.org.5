Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB30807347
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442232AbjLFPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378966AbjLFPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:05:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD379A;
        Wed,  6 Dec 2023 07:05:12 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d03fb57b69so35457805ad.1;
        Wed, 06 Dec 2023 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875112; x=1702479912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jI9BXQ6U/V2yKZyvwgWABlpSIS9z4T/U+cMlmbF/xPw=;
        b=QZEk6QusF/Z6Y3zUnMvSlQnTKeGLOBLHrk+cG/2UThR1DXmJS9lUACV1swELq5vW0l
         keTEaG2Yr554q+L0cfJBZlurwpxYcZkjGku9zbuueK/qeHMa7oKz9qGhYbnBDH44/cgw
         9XQdkxyETE3fn+mL1yBhGPuNWuZ3ZVYxEic5XbAbMIcAKZ9waDzbyGvVpD2cCIk88o8H
         pzGgqfCsWrG9loGc5tY0C9qQjDzP6Irx0hfXhQQgG8wCnsobKj6pmOZGSleDLJSkApdB
         wRQLNGAEtX8H1OeDlkdS7JKZwZTJDpxCjzPCKC7mhxLEsF43h2kdb1MVpOXmr6NIRO2L
         U3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875112; x=1702479912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jI9BXQ6U/V2yKZyvwgWABlpSIS9z4T/U+cMlmbF/xPw=;
        b=PM30QV46gfDypPhCG2WPp/sllSJe3iVtg7BGa2CIdHtIrMP3I4v/ZVLcnVwDXDCP1b
         fdj4nDwp6Ixo4tHS7NH5gjcBi05E/MkXq6XasBtMWL0cj2bqCEg5LsWg7pzBbBoAtBhK
         MhNHp8fd8+WkSV4SXGxsnUsQLPHCVdc5fyffjfh9Q3xfDCP0UBFOxXUIgSxNJ0KtR6jc
         xcGVyPPY8BdojRULHA5DrI4ApWA6BRXPljS9a57e67Wk7Gey1I1M/UdFnediMGF6fvlB
         OS4y/DCPERN6XSRm9nT54bx5VLRyYExUSwxdb6TA6642SzmchXIyJErCnDneRs5bcQS8
         c6vA==
X-Gm-Message-State: AOJu0Yx2J9xbZgMyfH/xU7cjuNgmN2k5zPksnSWvU9XQC7mO2oNmVHdN
        l/vEwxvPeBvDuhkW6N/nWsCVlHHkGzSYUCkI
X-Google-Smtp-Source: AGHT+IHMIrp6vihpwyJjk/bwe3y89ZutbMbWmzySJQKcGLrlc8f7z7dP/gTw5TpWkY8ph2J3cEdwmA==
X-Received: by 2002:a17:902:f68b:b0:1d0:c6a6:10e8 with SMTP id l11-20020a170902f68b00b001d0c6a610e8mr759970plg.56.1701875111692;
        Wed, 06 Dec 2023 07:05:11 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001cfad034756sm7458267plb.138.2023.12.06.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:05:11 -0800 (PST)
Date:   Wed, 6 Dec 2023 23:05:06 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXCNouKlBlAKgll9@Laptop-X1>
References: <20231206123719.1963153-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206123719.1963153-1-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:37:18PM +0100, Florent Revest wrote:
> In __team_options_register, team_options are allocated and appended to
> the team's option_list.
> If one option instance allocation fails, the "inst_rollback" cleanup
> path frees the previously allocated options but doesn't remove them from
> the team's option_list.
> This leaves dangling pointers that can be dereferenced later by other
> parts of the team driver that iterate over options.
> 
> This patch fixes the cleanup path to remove the dangling pointers from
> the list.
> 
> As far as I can tell, this uaf doesn't have much security implications
> since it would be fairly hard to exploit (an attacker would need to make
> the allocation of that specific small object fail) but it's still nice
> to fix.
> 
> Fixes: 80f7c6683fe0 ("team: add support for per-port options")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  drivers/net/team/team.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 508d9a392ab18..f575f225d4178 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -281,8 +281,10 @@ static int __team_options_register(struct team *team,
>  	return 0;
>  
>  inst_rollback:
> -	for (i--; i >= 0; i--)
> +	for (i--; i >= 0; i--) {
>  		__team_option_inst_del_option(team, dst_opts[i]);
> +		list_del(&dst_opts[i]->list);
> +	}
>  
>  	i = option_count;
>  alloc_rollback:
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
