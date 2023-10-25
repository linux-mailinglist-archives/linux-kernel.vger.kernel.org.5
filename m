Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0227D76D9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJYVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjJYVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:30:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C314133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:30:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF330C433C7;
        Wed, 25 Oct 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698269453;
        bh=866yJ6QEGke94UXkLijvdFJbDhsr/QcS04165KyCsiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V03LB5AGmTa2S0gwTGLR0QsbNNE4fsKEyw5CvM/d1G0lUP33AwaYenDUmklzr06hf
         uxgOr9Z7MlDyakRq/IX8/UMl5/P8kWUaBgHiUmcJeuPAzJx9mHISNIknW2a+jR255X
         QrJwkF34lLPGmMXyOkEufZY5iara7NWfC+9WzEQltCvtphdMYyy6Zot5SLmpEiVz8V
         If+lG5KnGVXoIqs9iKltg1WfD3+3QPpjri58IwFSlQRG5Xb5/T+hSbiU4C1bpFQSiD
         48icvZKTp2nVv4n15RGZ4/QNc39JFK5uO4FcGn9rVtRGOhpDZiUL14sivxNlrJXISW
         8g4Ly4+WKKprw==
Date:   Wed, 25 Oct 2023 14:30:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <20231025143051.6cfe4fc5@kernel.org>
In-Reply-To: <ZTmGl1BFr0NQtJRn@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
        <ZTZ9H4aDB45RzrFD@hog>
        <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
        <ZTjteQgXWKXDqnos@hog>
        <20231025071408.3b33f733@kernel.org>
        <ZTmGl1BFr0NQtJRn@hog>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 23:20:23 +0200 Sabrina Dubroca wrote:
> There's already a comment above tls_decrypt_sg that (pretty much) says
> out_iov is only used in zero-copy mode.
> 
>  *          [...]            The input parameter 'darg->zc' indicates if
>  * zero-copy mode needs to be tried or not. With zero-copy mode, either
>  * out_iov or out_sg must be non-NULL.
> 
> Do we need another just above the call to tls_decrypt_sg?

Sounds good. Right next to a line of code that people will try to
modify when whatever static checker they have tells them this is
buggy :S  Call site of tls_decrypt_sg() seems like a good bet.
