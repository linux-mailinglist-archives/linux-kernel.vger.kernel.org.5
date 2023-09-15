Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC57A163F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjIOGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjIOGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:39:18 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CF2710
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:39:09 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bba7717d3bso1032056fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694759948; x=1695364748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9krPXP60RvOc/Jly4MzMbTGFZqB63oEeqar0n+mZto=;
        b=QT/d3nz7Sh9jd+cGn9PMO+4DvHv00XPDk4LeIdzv10MGU4lMBGxTmvbTIvwsQCLHHW
         HP/YbcQKBNAW+HgGGd1ivovHUUzc5vhDRUZ4BwVZfEhthqQYThlze8O1vS4rPl7Lua95
         L59/KeLLLWsyWWu61tmxP5B8yVVGGoHG2dNTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759948; x=1695364748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9krPXP60RvOc/Jly4MzMbTGFZqB63oEeqar0n+mZto=;
        b=AmqqFJzWwmo5H5aE5CFETctv4LjTcBQcWFxuFlt8ZRsXuYEMUfzxA2I0GmrDxVyR/n
         zpH02fxP+yEX3svYyl8vYgl1qXvhUZ+Ae4QwMfk26smcds0eg3EV4kjsQ353PS5Gb584
         3krMWqREWE1O/dnQS9yjfQD2cOydzCKXF2xcYm7tfytH0I5IpPVrflMFcuggRPjCRQQF
         OE4x6NPQHmvg4430Aj1Wn436GO0Hvq0T4V8UM6YeA97dr3kFDAEzsy6dABQAlMiPRJNF
         gi5ry/wbiI09m/rlwH/TE7LCUwKwyOJ1M4nzMruHAbbSXoJjfi6lELxZB6GFuf74evAv
         cv+g==
X-Gm-Message-State: AOJu0YwsXEYtSW9wrrrk6FJP370ibwoGOHUoomhSfxnfignbX4QToT7j
        /mD5QDjJIQU9V1/+PpVUYkM9HzdGiAmILqs5dY8=
X-Google-Smtp-Source: AGHT+IFDmhw7ZRBNGNOL6ig8k8GdAMIkgXC0ino4cM4yA0zOj4mNkUi7jC3Ss/34A3XxvP1tmTpnBg==
X-Received: by 2002:a05:6870:64a2:b0:1d6:3f77:c214 with SMTP id cz34-20020a05687064a200b001d63f77c214mr725392oab.55.1694759948598;
        Thu, 14 Sep 2023 23:39:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n19-20020a637213000000b0056c52d25771sm2114306pgc.69.2023.09.14.23.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:39:07 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:39:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jean Delvare <jdelvare@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ibmpowernv) refactor deprecated strncpy
Message-ID: <202309142334.0F81E0EA2D@keescook>
References: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
 <202309142223.D16446A30D@keescook>
 <4b490305-0ab7-403f-7bec-a08fb8f20b56@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b490305-0ab7-403f-7bec-a08fb8f20b56@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:40:37PM -0700, Guenter Roeck wrote:
> It is really sad that the submitters of such "cleanup" patches can't be bothered
> to check what they are doing. They can't even be bothered to write a coccinelle
> script that would avoid pitfalls like this one, and they expect others to do their
> homework for them.

Well I'm not sure that's entirely fair to Justin's efforts (I know he's
been studying these changes and everyone makes mistakes), but that's why
I'm helping review his findings -- some code behaviors are more obvious
than others. :)

-- 
Kees Cook
