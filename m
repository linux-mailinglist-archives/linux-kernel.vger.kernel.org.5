Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2723B77EFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbjHQDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbjHQDou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:44:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FD269F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:44:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6887059f121so1761795b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692243888; x=1692848688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoxuOOOPCYR3t9kZOgenEGYkSAziR5agcDn1+0l1D/g=;
        b=B/J9fB4fcigGxOQotv7KYzsjvjQMoeIpTwIjWuQQw8P+/Pi98sK76cvGOJKHp5e2Og
         V+z1uc1hGBTK+1pcOvLpkka95uzRAaf8vQROOzfk+q7bnbYSrBi6U61Gm+y1eTe0epDW
         8gfx29U3+I++WkX3n6Zs6dGWrvxcS0KFDh3no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692243888; x=1692848688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoxuOOOPCYR3t9kZOgenEGYkSAziR5agcDn1+0l1D/g=;
        b=alt8Knxp/ragIUhHnLD7U9aDnmtfms7nLTQ+gC72KRm0koMC/g91V7FREHNXWUPmCu
         WuuI33pYDb4saKiYEvGiAKKDfcgHiNOgLXHstw9Jd0hX8nnMRywv3dZ9fL+YS+ZzshwA
         zwJhif/Vrhas77CrwcFIB2COQ5tznI4z9yIIxTlHEPNsyz+ZO8pHN8M2tnuNZAKKGpmE
         Ypp+BsdsgxNR6Q5ORAxUFC0T/nmTqjKf3eU1tRZI9emZ28/Pad3Se6gFkKmMVVOU1Siv
         UlipNXkfXBDI+VZgNT0k8gWtzaiEB0u07DmkuKtdu9U5qs7wqs1bc2guSx2fqpsmfbda
         Kwsg==
X-Gm-Message-State: AOJu0Yy230xhrvFjVrkrW0j+OsqqxzjD5kZ+aOqqif6JjGEwifLWQGxj
        YouzThW3Grhwl0cuq7BrFFbV5g==
X-Google-Smtp-Source: AGHT+IEDbX0HaCKbcWjeHvsVDLzdj7CvE3sivY202/QqGMIWkgUJKlySIY0cLQQcGqu8OZ+N0vPa6w==
X-Received: by 2002:a05:6300:808c:b0:133:b3a9:90d with SMTP id ap12-20020a056300808c00b00133b3a9090dmr3767651pzc.36.1692243888390;
        Wed, 16 Aug 2023 20:44:48 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fba0:de48:e2d6:bcf2])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78e17000000b006883561b421sm6191564pfr.162.2023.08.16.20.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:44:47 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:44:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
Message-ID: <20230817034443.GF681074@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817012007.131868-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/17 10:19), Sergey Senozhatsky wrote:
> The listunknownconfig option reads old .config and lists
> all unrecognized symbols. This is especially useful for
> continuous kernel uprevs when some symbols can be either
> removed or renamed between kernel releases (which can go
> unnoticed otherwise).
> 
> A recent real-life example of such a symbol rename
> that quietly disabled some drivers after kernel uprev
> is MFD_RK808 rename.
> 
> Example:
> Suppose old .config has the following two options which
> were removed from the recent kernel:
> 
> $ cat .config
> CONFIG_DISABLE_BUGS=y

Uh, I see what happened there. The correct output is

    $ cat .config
     CONFIG_DISABLE_BUGS=y
     # CONFIG_ENABLE_WINAPI is not set
