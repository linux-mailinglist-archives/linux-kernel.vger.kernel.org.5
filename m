Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A38062C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjLEXPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:15:48 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629BAC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:15:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d075392ff6so2285725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701818154; x=1702422954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VVNNaeri+5Y0qxSYlV0XhmR9zZubt+O1raKhY5eD/Jc=;
        b=RqpLYzUS0yEQjJq4+OAsDugFMxzWzbqvD/xES9dTuh1WgjhlFKVbXMp5vwFqb80i3v
         z3lrK6Z8MqTE5xybrLadQdUk/ZfE0tSRAP5/GcrTifJI3474kdDCtq6GkJFG0DRi3lfB
         VY2Sm5faMaiz0YsMqudBC3ev0Q/6GmXToWLRK2pdVzPzBg3XFftrALl5HhgO1s7bZRKY
         43XR0aqkAFaGksq1ugTVhjPqNQb/nDZoKIpe2k2O6tx60ZsGJyeQEwUlYAOUzgGHnpKj
         6bMDye+TjzYuu5/AGP2T5xiIhS5M/U12/C58+zQtdpbBkhojzhi2mNG7ZlpL/BqPYSA6
         nJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818154; x=1702422954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVNNaeri+5Y0qxSYlV0XhmR9zZubt+O1raKhY5eD/Jc=;
        b=Ku8tkRFXKCxYGLvcu3sLWrn7HVZjCH1IMypQlTgw6hgG7xuFQ1Po5BdX/2xuHXDu2G
         Vgh2CjNS0LxK4Zco/uOidj2YUqDPMhLyX39kp8lLBtvXOzRVXRVuD8zjIcpR9f/ZkUXC
         89lES18kzxIRhF4cMCDFtpVTcthSm3RSVJxGpfwwXk6pBb9rOQR3ntK0Ht5qqoXzq6TJ
         quV7UE5hiuhSKPzaXyzPlSPRxmFdZhLrQAXxeANykG9oFmhzQShhtLBxop94DZkeZ3jG
         TIIUkX5j8wVXRngG5cFksPDo0KhMks+hty9wAc14XrCF+pGtun6TzHl4LVk5imJDRcKU
         xlBw==
X-Gm-Message-State: AOJu0YzPwFDs3HvY3e8yW6bDTwAGUmilIYSphyng/ACClvm04eiUly8M
        DvlEBMuP178REqicG6NrnxOxUw==
X-Google-Smtp-Source: AGHT+IHLnhkBKhKacZxALW++uKQjQ31jkdCiI55mR9VPh9Os2SOaOyUzFyiX6wvjFphFQxb9MHBs6Q==
X-Received: by 2002:a17:902:e904:b0:1d0:9979:7be5 with SMTP id k4-20020a170902e90400b001d099797be5mr2364868pld.31.1701818153919;
        Tue, 05 Dec 2023 15:15:53 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001d0b32ec81esm3625974pll.79.2023.12.05.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 15:15:52 -0800 (PST)
Date:   Tue, 5 Dec 2023 23:15:48 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] android: binder: fix a kernel-doc enum warning
Message-ID: <ZW-vJGvhQY6oftiJ@google.com>
References: <20231205225324.32362-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205225324.32362-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 02:53:18PM -0800, Randy Dunlap wrote:
> Add kernel-doc notation for @LOOP_END to prevent a kernel-doc
> warning.
> 
> binder_alloc_selftest.c:76: warning: Enum value 'LOOP_END' not described in enum 'buf_end_align_type'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hjønnevåg <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  drivers/android/binder_alloc_selftest.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff -- a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
> --- a/drivers/android/binder_alloc_selftest.c
> +++ b/drivers/android/binder_alloc_selftest.c
> @@ -72,6 +72,10 @@ enum buf_end_align_type {
>  	 * buf1 ]|[ buf2 | buf2 | buf2 ][ ...
>  	 */
>  	NEXT_NEXT_UNALIGNED,
> +	/**
> +	 * @LOOP_END: The number of enum values in &buf_end_align_type.
> +	 * It is used for controlling loop termination.
> +	 */
>  	LOOP_END,
>  };
>  

'LOOP_END' seems self explanatory to me but if this helps to clear the
warning then why not. Thanks Randy!

Acked-by: Carlos Llamas <cmllamas@google.com>
