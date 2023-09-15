Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150C77A274F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjIOTnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbjIOTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:42:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC619BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf57366ccdso26214635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694806958; x=1695411758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=WaD0aTyDH/uutpVV8adNXlYXUhfqEf+U/H86LF52FutN6nw4UgSWcRY+/j7ENhjbgB
         VZKLGelUiNKYNJF8jZ9sfR2Apk6zSj4CWlFuxMeqBbV8lWkuyrkE1LAK8gEaaraW8g5a
         YitWmqcEfS43fv1RxMxGnBWFAoFAIYXmX+Do8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806958; x=1695411758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIj8OzGJrhv2lGM2biZWis6A17RAWnGoSZFCbIwFvuM=;
        b=IEMpUX47Nfh1Xju+fH6RC9mAg1ze/38QloilanUnfUxR82D5eyi64KLTh7grQ2BXRW
         E8e8gVv1E8nQ4oDi3ucd8ZeZb1ODz5NhO3Xm64XRBMkrBO8V5ACxqm+5qQQSHBgzkrGB
         HP8bLmZkzUcBgLV1qUBZBx6YwL/e4ReW23jhrlS7ZpP8U7TrYobCtQefeCeOeAd6XnZn
         QVPdLVe95asWhmYP9bRcqudpDfAOE4SS6Gro4hGlKTk//To4PFGRynkAr7UaKHd0T90U
         XXZCk81k+HUNnCgWmW4Cb/d8Po0m8t0X+DXJfw7DNZILTMC0lQAh5CXyO8q9qX8yW33S
         f/yw==
X-Gm-Message-State: AOJu0YzLT+RExO3RQ4U3bpfkpQSWbTVfLwje/dWQgOHlIBA80UszSO6n
        WiRyJLrzZF52h6rPBw94Z9uJJg==
X-Google-Smtp-Source: AGHT+IERfok0jFzZlZtdhSIeue7UAgumLdb8qFaPg7HdEwWvabfB1YwxclxmfbPVjycC8GbPAfm1aw==
X-Received: by 2002:a17:903:110e:b0:1b8:8682:62fb with SMTP id n14-20020a170903110e00b001b8868262fbmr7918269plh.4.1694806958504;
        Fri, 15 Sep 2023 12:42:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm3831900pls.146.2023.09.15.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:42:37 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:42:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tls: Use size_add() in call to struct_size()
Message-ID: <202309151242.BC470261F@keescook>
References: <ZQSspmE8Ww8/UNkH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSspmE8Ww8/UNkH@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:12:38PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
