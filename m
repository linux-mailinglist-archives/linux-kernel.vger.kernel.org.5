Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAA757016
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGQW6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQW6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:58:36 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97812D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:32 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55e04a83465so3235082eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689634711; x=1692226711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXBV/2bjPwiYS8/exEYcrIZKRRy4LswAgUjKyTXo1Qg=;
        b=BIb1WxzpDndftoSsHfDcuFsuU1AktYDefj1plXXrfhwQnJxz9CG1e85DYQUGj7Hn9a
         Ns7+VLbARCxMXbMHd/ugfmyWDtilfWM7eZIt3uE2bi7kLlSBdh7DuG532t4i+idiYq+r
         FAatICz1PyJc1Zy08rlNc0zovdt6m62tvxPGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634711; x=1692226711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXBV/2bjPwiYS8/exEYcrIZKRRy4LswAgUjKyTXo1Qg=;
        b=e0kc6+gMlAexcYiNAJU/pUZy+LYApXYIWTZjiVB2dSmow5ZK+ng9EfeC0zXf3k1I9n
         VZgQkyJS7szP38bA2TWXZ4gr1neHPj0CwkBoIMKNt214yetxVDxJePoPTCUXx7fez0Eu
         4RGuMN06/n62nmvs3AmN56gwx4/I8BXJ4Au4rT3SRxtG3x0uzEE05fCtt6aeISlwuQ2d
         Nl/9H89YM5JHXqsitdSQhRpVmEQ0rURaQF75RGeANEdJd4IWLB43cwMCK7EP53KZiZtV
         lZgc/ge/5+uW+dTm4Iu/WqE8gtFc1Fu7OpeQXG3Ix2HHSo0BnQtlNS7REiOssXO9lbcW
         scDg==
X-Gm-Message-State: ABy/qLYJ+flzAQlBwhYV9WIh91XAMhu57zAkI6c8DyK+vijzaj5ftgpg
        m3XE2reOgDnW3cCzQUo9VOvHjQ9x9iZdahlCSgA=
X-Google-Smtp-Source: APBJJlHmb/dNiyQOJeC3Ts7HefUDiZyi1y6NEW7+G54thcMrg7Ty39Pdk2XVz2OTyl9esC4YZ7VTNA==
X-Received: by 2002:a05:6358:7189:b0:135:725f:a8af with SMTP id t9-20020a056358718900b00135725fa8afmr1128909rwt.15.1689634711307;
        Mon, 17 Jul 2023 15:58:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a056a00270f00b0067f2413bf6dsm291057pfv.106.2023.07.17.15.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:58:30 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:58:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Message-ID: <202307171558.09183D81@keescook>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
 <202307170826.397635AD@keescook>
 <ZLVm2FLCRSnlYVUC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVm2FLCRSnlYVUC@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:05:44PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 08:43:55AM -0700, Kees Cook wrote:
> > On Mon, Jul 17, 2023 at 12:33:32PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > I think this doesn't need to use seq_show_option_n() at all.
> 
> Quite likely. Nevertheless, it's one of the dozens (?) warnings like this.
> 
> ...
> 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thank you for the review!
> 
> I think it's you who may take it as seq_file.h seems everybody's playground.

Ah, good point. :P

-- 
Kees Cook
