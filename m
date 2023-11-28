Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066E47FAF09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjK1A3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK1A3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:29:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC01A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfb4d28c43so20468155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131367; x=1701736167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=PyEgxNWLeJ3KP8hUS7Ok5YSMoLLYB/ml3itP1fDeV5zzMq6GeWq7Yk+5qYJFlWMz3N
         M2hG48me0XDZH/2YaYA5EuA2ZUobganXhFT3/he5pdHZkDEvHVXNsvUG/6vZqdcAiPmu
         s5ehbXKbSfdq40VxQneA98J3UKPHGyCYYXQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131367; x=1701736167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBhH3SH8gSBwN/mjOaVSdplaO4ytPruThkgoguaYPkk=;
        b=EuFVttVybywenb4HOCJ8NZTItCU242w4rvQ2iGTI1FnlkmiTKwNSGoROhQtQYz0XMG
         X4i9djR1J2M5QRS49lwcXv10u2j1H1uhNvsAjz253M15pdzaQuKezdPBDC/uwt08QUUA
         zHPbASEUK3w4KymMnJlGmfTEUdxD8aAt/IKwpe+8o9g9C41UIe3xmJzAtJ/75nvOu/hx
         Hlwmzd6BKzGNN+kU2ujrLxOG1a5YqV2IFDwwISyySFYUP2gSjL5wfwcDf6pu5PUzD0Cl
         sAKrVtF3bv4LkCEanDiMv/LFK3UHoH9GCdAMIK5RA34kaCd7smaqbuukQWrVidd0wcfE
         dIBg==
X-Gm-Message-State: AOJu0Yze+NkT77df3NsUV5oB4FNva2+ncYitQXobtia1ol6LMrkzuCKk
        G0pI4/zmvd8YIp9ViLtslxwlQw==
X-Google-Smtp-Source: AGHT+IHfOT26JhpsCCRBM96VOFEk0SgWcQnWOKyzAiCxrKsjcBUu975ao2LlZFeKW0Hd0NQIfUCkxA==
X-Received: by 2002:a17:903:22d2:b0:1cc:c273:603 with SMTP id y18-20020a17090322d200b001ccc2730603mr14361492plg.42.1701131366965;
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm8824250pls.256.2023.11.27.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:29:26 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:29:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Bill Wendling <morbo@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] neighbour: Fix __randomize_layout crash in struct
 neighbour
Message-ID: <202311271628.E5EED48@keescook>
References: <ZWJoRsJGnCPdJ3+2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWJoRsJGnCPdJ3+2@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 03:33:58PM -0600, Gustavo A. R. Silva wrote:
> Previously, one-element and zero-length arrays were treated as true
> flexible arrays, even though they are actually "fake" flex arrays.
> The __randomize_layout would leave them untouched at the end of the
> struct, similarly to proper C99 flex-array members.
> 
> However, this approach changed with commit 1ee60356c2dc ("gcc-plugins:
> randstruct: Only warn about true flexible arrays"). Now, only C99
> flexible-array members will remain untouched at the end of the struct,
> while one-element and zero-length arrays will be subject to randomization.
> 
> Fix a `__randomize_layout` crash in `struct neighbour` by transforming
> zero-length array `primary_key` into a proper C99 flexible-array member.
> 
> Fixes: 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
> Closes: https://lore.kernel.org/linux-hardening/20231124102458.GB1503258@e124191.cambridge.arm.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Yes, please. Do we have any other 0-sized arrays hiding out in the
kernel? We need to get these all cleared...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
