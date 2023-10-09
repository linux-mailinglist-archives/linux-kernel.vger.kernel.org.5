Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ECB7BD568
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbjJIIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjJIIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:41:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578CB6;
        Mon,  9 Oct 2023 01:41:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3970AC433C7;
        Mon,  9 Oct 2023 08:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696840912;
        bh=4kcb3KJxlv8xCWB0hf9FgeYmQ74is/VJSpLom3fBsoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTU2kcR8q/tIZnExeb3VK5ciNJvkkphanMOurKs3FwH6W0csFeiAJIIP1FvK3AlJx
         cK3nL9xTZf31ZI+s6rz25iHEYD1kwBObTWCi+M/hma15XVAWtGBbF1mZzMYlGuXLLc
         dcQgBOAdDaA0WykfzWlgS7FyyJwLQzyH1+rQaNCLLbstpF0QporGOPW8xgny+ORqsx
         wbcMdXOQhL1dRrhaKZMK6LaefQ5DYEHigIkdPNWlUxJxfQoQilqMUTytR9QCKGAoWy
         j7APXNbcE4LyhT41zUaupAFBMMqdGIm660ETyw2zxuIXqcumqhtJL90PVqRUbudVmP
         oReRJ5PvA9dww==
Date:   Mon, 9 Oct 2023 11:40:58 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] userfaultfd.2: comment on feature detection in the
 example program
Message-ID: <20231009084058.GH3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:01:59PM -0700, Axel Rasmussen wrote:
> The example program doesn't depend on any extra features, so it does not
> make use of the two-step feature handshake process. This is fine, but it
> might set a bad example for programs which *do* depend on specific
> features (e.g. they may conclude they don't need to do anything to
> enable / detect them).
> 
> No need to make the example program more complicated: let's just add a
> comment indicating why we do it the way we do it in the example, and
> describing briefly what a more complicated program would need to do
> instead.
> 
> The comment is kept rather brief; a full description of this feature
> will be included in ioctl_userfaultfd.2 instead.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/userfaultfd.2 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 00d94e514..b2b79f61d 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -881,6 +881,13 @@ main(int argc, char *argv[])
>      if (uffd == \-1)
>          err(EXIT_FAILURE, "userfaultfd");
>  \&
> +    /* NOTE: Two-step feature handshake is not needed here, since this
> +       example doesn't require any specific features.
> +
> +       Programs that *do* should call UFFDIO_API twice: once with
> +       `features = 0` to detect features supported by this kernel, and
> +       again with the subset of features the program actually wants to
> +       enable. */
>      uffdio_api.api = UFFD_API;
>      uffdio_api.features = 0;
>      if (ioctl(uffd, UFFDIO_API, &uffdio_api) == \-1)
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
