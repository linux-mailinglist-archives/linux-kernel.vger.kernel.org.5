Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE395787BF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbjHXXWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbjHXXV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:21:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590391FC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:21:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7423ef3eso3417705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692919313; x=1693524113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w5mv6lG3O3l4xUxVWDEcklkLQovn+KSfkFXrkAtd8o=;
        b=HUNbIF3SZFESQtWsYGw4ufoOPQfn0DMhz6J6tkXQyiqY0N4QCZMi+uH9lXx7i5V4JS
         WShu9Elj1MhAzOogVa/Zk7n3ucdznSw165k9gkqJc5lkHungrIP+gxo55QxUrPQoUgLX
         K4NXLnL4+wIUv0fIgiY8+1FVzP9yZ1K5RkeQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692919313; x=1693524113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w5mv6lG3O3l4xUxVWDEcklkLQovn+KSfkFXrkAtd8o=;
        b=JFyMWrTqhfGY9ltCzZRCy8QfFLt/USTsyUM+93F0dEgGAtYCXHsWduv4mnQAVjC8i6
         6SfQoYcvBoF2GLep1gMRBrDvXq7a9bbdNSdv9E7yFngSut4lJ69fxPfxQaNP4AN5k9Zy
         tj0TIoewrrTwwNmMYOxa9ucf5YvATaWvNeQOQi4JxnmPU+pSOB7h2Laff1IY4JTt+7e6
         kgqC15mXROmV4sd500He/BSw7Kc+pL3uw55FQrJBIh3Bpi1ZusxmIuDrmqhiFAQhZI7f
         EzAXil5frzqUDbPrg9DsEgDkT820ml7kEwEvn1S7bxf39/N86+A+byvJJi8MCZGm90Py
         qMqA==
X-Gm-Message-State: AOJu0YzugaDQXMlIsH0QeLxM6Q73xh+0gGUYuzO5XRtfLR1UfAeHjvkv
        FmcoPv2dOLSieVrutqMHIVWLKQ==
X-Google-Smtp-Source: AGHT+IGJh2BpYlnLI9AIMkXlJ+xO74J7Z1ns9je/GIWPjgLHY3P/y30UST+GseFimmXO+HAnYy+e4A==
X-Received: by 2002:a17:902:b782:b0:1bf:22b7:86d with SMTP id e2-20020a170902b78200b001bf22b7086dmr13934006pls.3.1692919312831;
        Thu, 24 Aug 2023 16:21:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju14-20020a170903428e00b001b672af624esm214114plb.164.2023.08.24.16.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:21:51 -0700 (PDT)
Date:   Thu, 24 Aug 2023 16:21:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH RFC] ACPICA: remove acpi_ut_safe_strncpy in favor of
 strscpy
Message-ID: <202308241612.DFE4119@keescook>
References: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:02:02PM +0000, Justin Stitt wrote:
> I wanted to gather some thoughts on removing `acpi_ut_safe_strncpy` (and
> potentially other `acpi...safe...()` interfaces) in favor of
> pre-existing interfaces in the kernel (like strscpy).
> 
> Running a git blame shows these functions were implemented 10 years ago
> and their implementations generally mirror the _newer_ and more robust
> stuff in lib/string.h -- Let's just use these, right?
> 
> I appreciate any comments and whether or not I should stop at just
> `strncpy`.

ACPICA is actually a separate upstream project, so changes are best made
there[1]. However, this code base is shared with many OSes and
compilers, so there won't be a common "strscpy" available. Perhaps the
right thing to do here is to implement acpi_ut_safe_strncpy() in terms
of strnlen(), memcpy(), and memset(). That would make the upstream
project safe against "too long reads", etc, and would require no
collateral changes:

void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
{
	/* Do not over-read the source string. */
	acpi_size len = 0;

	if (dest_size > 0)
		len = strnlen(source, dest_size - 1);
	if (len)
		memcpy(dest, source, len)
	/* Always terminate destination string and pad to dest_size. */
	memset(dest + len, '\0', dest_size - len);
}

-Kees

[1] https://github.com/acpica/acpica
    e.g. https://github.com/acpica/acpica/pull/856

-- 
Kees Cook
