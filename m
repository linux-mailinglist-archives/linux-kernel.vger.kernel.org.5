Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB47BC9A6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjJGTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 15:41:22 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7BBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hsRMnVxEdXNQbDv8iJbkta6BVDoT/UbI/OfTI7OLzNA=;
  b=W9Aiik7bGTqpsEh2M3jhWuB0L8H+QhWpejGYv782et3LDt2en/zlR2PK
   bEaYsetnvgX+h9qouglrS1BjvbTAkxnIWUnDqJOq4FbRmFbas7FVpIjzc
   5Okky/cTMhpqRYn4NW5VuRHTTMyU0SvAxUbcf/sc+i+WAA3HdH/t0paA0
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,206,1694728800"; 
   d="scan'208";a="130024966"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 21:41:15 +0200
Date:   Sat, 7 Oct 2023 21:41:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Anton Eliasson <anton.eliasson@axis.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
In-Reply-To: <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
Message-ID: <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com> <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2023, Anton Eliasson wrote:

> This helps automating coccicheck runs by discarding stderr and only
> looking at the output of stdout. In report mode the only remaining
> output on stdout is the initial "Please check for false positives"
> message followed by each spatch warning found.

What is getting dropped is the spatch command lines indicating the
semantic patch.  Is this desirable?

julia

>
> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
> ---
>  scripts/coccicheck | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 95a312730e98..7e7c44125f47 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>                  echo $@>>$DEBUG_FILE
>                  $@ 2>>$DEBUG_FILE
>          else
> -                echo $@
> -                $@ 2>&1
> +                echo $@ >&2
> +                $@
>  	fi
>
>  	err=$?
>
> --
> 2.30.2
>
>
