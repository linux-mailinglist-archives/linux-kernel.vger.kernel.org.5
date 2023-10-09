Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666807BD56D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjJIIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjJIInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:43:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2397;
        Mon,  9 Oct 2023 01:43:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930E7C433C7;
        Mon,  9 Oct 2023 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696841021;
        bh=otc7OfNhraJmkEuE8nhHuV118f/GVw4nI6P2etVcZfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KE5jyaI1vXYs5g40TIRVUzC931PNUBTA7Fd/tsfO4yKfdpIWV/3g2bhtQ9OA/dC+3
         6nYhS4PcDvnSJnIxxc6OQZVTP1KtsOsBFDTrEL5E56HyzHB2puTyFUB1MNwCAYwM9u
         Oaf1EZO7dLr1Xl1rPzFrWaTCIFdCSPRjgvvuL1pao+N66Mf1nox1uxmQYqSTrAenOb
         cPFf1BW0jqctmUZL1KGkRTKUTi04awyxW2HZfAcfqy89skDkXl3N7xAiO6CK4VUmut
         SuccwWgOfzOLFnsQFvPOuHTIyACKTCOVWUcPi068bjYFRD37o6LdCuYDybW8CQ9GQs
         gH45+RfmowMQQ==
Date:   Mon, 9 Oct 2023 11:42:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature
 handshake
Message-ID: <20231009084247.GI3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-6-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:02:01PM -0700, Axel Rasmussen wrote:
> Fully describe how UFFDIO_API can be used to perform a two-step feature
> handshake, and also note the case where this isn't necessary (programs
> which don't depend on any extra features).
> 
> This lets us clean up an old FIXME asking for this to be described.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 339adf8fe..e91a1dfc8 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -83,7 +83,6 @@ struct uffdio_api {
>  The
>  .I api
>  field denotes the API version requested by the application.
> -.PP
>  The kernel verifies that it can support the requested API version,
>  and sets the
>  .I features
> @@ -93,6 +92,25 @@ fields to bit masks representing all the available features and the generic
>  .BR ioctl (2)
>  operations available.
>  .PP
> +After Linux 4.11,
> +applications should use the
> +.I features
> +field to perform a two-step handshake.
> +First,
> +.BR UFFDIO_API
> +is called with the
> +.I features
> +field set to zero.
> +The kernel responsds by setting all supported feature bits.
> +.PP
> +Applications which do not require any specific features
> +can begin using the userfaultfd immediately.
> +Applications which do need specific features
> +should call
> +.BR UFFDIO_API
> +again with a subset of the reported feature bits set
> +to enable those features.
> +.PP
>  Before Linux 4.11, the
>  .I features
>  field must be initialized to zero before the call to
> @@ -102,24 +120,11 @@ and zero (i.e., no feature bits) is placed in the
>  field by the kernel upon return from
>  .BR ioctl (2).
>  .PP
> -Starting from Linux 4.11, the
> -.I features
> -field can be used to ask whether particular features are supported
> -and explicitly enable userfaultfd features that are disabled by default.
> -The kernel always reports all the available features in the
> -.I features
> -field.
> -.PP
> -To enable userfaultfd features the application should set
> -a bit corresponding to each feature it wants to enable in the
> -.I features
> -field.
> -If the kernel supports all the requested features it will enable them.
> -Otherwise it will zero out the returned
> +If the application sets unsupported feature bits,
> +the kernel will zero out the returned
>  .I uffdio_api
>  structure and return
>  .BR EINVAL .
> -.\" FIXME add more details about feature negotiation and enablement
>  .PP
>  The following feature bits may be set:
>  .TP
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
