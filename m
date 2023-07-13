Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582F37515B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 03:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjGMBF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 21:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGMBF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 21:05:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BE9E;
        Wed, 12 Jul 2023 18:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E12619BD;
        Thu, 13 Jul 2023 01:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D6C433C7;
        Thu, 13 Jul 2023 01:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689210325;
        bh=JEUoxjasu4MEtpBfYEyLKlXhktabrDJ3YVSK42TmZNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TmW4P7ENPxcCFiajRH4RFW+is7jtcftlGP1uqxBYokYrsMrUxAU1kEJU37lc+0DPS
         myemZ/8bBdMVucjEO9Cr27LCMdDgycU+gjBlR48nErxt9/xOGQWP2iHA+dLOl2GdgR
         noRGfjfHPF4Aj+VktAZSddw3HYJZTHOWQhqpgYraIuJUQT6LfMZk+4RJWPA+3PbW0U
         YU6rOYBtFOY2uNNQAOt/1kDXGFR7L4xZAu/tEErer9XfZkpDWnEjnGwD+rW+dkeKL3
         ZvSEDKLXa6/N+invb6MZOsQOO6Jl2DUNKNRhhU3KxNSP2yaY3UygCj9rYETy32qZr8
         nBr2HVcpWmU2A==
Message-ID: <2b7bf9b6-c676-c1fb-28c9-b46c7d99459a@kernel.org>
Date:   Wed, 12 Jul 2023 17:58:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] serial: arc_uart: simplify flags handling in
 arc_serial_rx_chars()
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
 <20230712081811.29004-9-jirislaby@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230712081811.29004-9-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 01:18, Jiri Slaby (SUSE) wrote:
> * move the declaration of flg (with the initializer) to the loop, so
>    there is no need to reset it to TTY_NORMAL by an 'else' branch.
> * use TTY_NORMAL as initializer above, not a magic zero constant
> * remove the outer 'if' from this construct:
>    if (S & (A | B)) {
>      if (S & A)
>        X;
>      if (S & B)
>        Y;
>    }
> * drop unlikely() as I doubt it has any benefits here. If it does,
>    provide numbers.
>
> All four make the code easier to read.
>
> Signed-off-by: Jiri Slaby (SUSE)<jirislaby@kernel.org>
> Cc: Vineet Gupta<vgupta@kernel.org>

Thanks for the cleanup.

Acked-by: Vineet Gupta <vgupta@kernel.org>

Th,
-Vineet
