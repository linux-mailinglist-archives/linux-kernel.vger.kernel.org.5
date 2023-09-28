Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7D7B25B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjI1TMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjI1TMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:12:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4C1B2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:12:30 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59bf1dde73fso170704557b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695928350; x=1696533150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPa0ErQF3fDxXQHa7m7tWTHEw6Kx2LmY0ex/FSA/iQs=;
        b=E6sdIGReA0N/tSvIeLtLw5A76OAsGnJ5wgdJLkKmPgq9D4sma5A0dmDG275I3SNmCd
         pfEP61X8QpfV5QSj0EFZ1UX2tl3gvISyWuI4cFoe/oTtOlRBjRTat/SLTF5F4kdog07o
         fTRkcvDefdVzpPKwnGMpsUtD0ddfMD4R6Qv/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928350; x=1696533150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPa0ErQF3fDxXQHa7m7tWTHEw6Kx2LmY0ex/FSA/iQs=;
        b=gXY0+Z7N9bHxjFsODDlqLqbJOfcUkXr2ShBHStOV9yQw83aiBz5sv6JEGEKF2NlV9h
         0uPrr1o2uFx6F7TmUFalXr12fbO778tM6ihFFBa4fYqTeED6kvsvlqzXuR8JbgbsLM9K
         MiryAgClzF3JNpGdx2H8MSAJFEkslcADmJVX7KuSw0fJAxByOVCQprgtMv1bEEMdSSwi
         1DvHdN/17DrATDa59+Su9Yzr2MU6ZKmI/r+c2QqyuczHYYWNRMsnEtiRK8adW2wVvLHn
         YQWnoe/5hcZQ2mQqC1bwqVpNaCUEtggXdgA/mhpUyLlOh+fnLkK6feM8U1h5qYDOOe1F
         JpwQ==
X-Gm-Message-State: AOJu0YyOMaTZV37O9mGy0pWoQ0XU71vTDeiad7ApZAX+PCPD412jIK47
        5Kr/xqiNwajZVxtThKr9GSFUfw==
X-Google-Smtp-Source: AGHT+IGPwgEvuDu4xj7ASqQ85LZ8y5lOYw28uselEYoiklqGHmZmYw1o958hUhSVlQbLtGGSIMTwbg==
X-Received: by 2002:a25:4255:0:b0:d85:e0d3:b491 with SMTP id p82-20020a254255000000b00d85e0d3b491mr1995811yba.32.1695928349874;
        Thu, 28 Sep 2023 12:12:29 -0700 (PDT)
Received: from meerkat.local ([209.226.106.110])
        by smtp.gmail.com with ESMTPSA id p9-20020a0cf549000000b0065b11053445sm3589952qvm.54.2023.09.28.12.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:12:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 15:12:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2 1/2] get_maintainer: add patch-only keyword-matching
Message-ID: <20230928-revisable-custard-bd7d72@meerkat>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
 <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com>
 <bf9200e2fc9c55187f2b7661a3b5043f56b0deff.camel@perches.com>
 <CAFhGd8o8ihYeML6WpiE1-=eeXC+k1yzSEdA-WJXjwB-f9VcHoA@mail.gmail.com>
 <a3959ab9a9d44444c06ffd0f390cf95dc6bc7f6e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3959ab9a9d44444c06ffd0f390cf95dc6bc7f6e.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:08:33PM -0700, Joe Perches wrote:
> > This could all be a moot point, though, as I believe Konstantin
> > is trying to separate out the whole idea of a patch-sender needing
> > to specify the recipients of a patch.
> 
> As I understand it, by using get_maintainer.

Correct, we will ultimately still defer to get_maintainer to figure out who
needs to be added.

-K
