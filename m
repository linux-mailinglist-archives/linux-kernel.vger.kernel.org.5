Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17F97D05C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbjJTASq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbjJTASo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:18:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C1E113
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:18:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9a1762b43so2145065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697761122; x=1698365922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sZZ1hSxhCzr3d9ET3rkLHcUQIIjWMOt3bcRQEdfBrZs=;
        b=gS4QN/9mmZGpztfaj8drl2UvHpAtJRGq4njvQLiIariSZ+Mvf3iMT97RRLoUGsnUuU
         bt0NpAdOxFTSILMjiAqvawu2KNYsyDlleIVYUxHZspFBN+p6cwGdvtyiel539Ul3CdbZ
         qf1eIl6N0ErCRmgUxHJqxm3Z0NBxVbWG02JT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761122; x=1698365922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZZ1hSxhCzr3d9ET3rkLHcUQIIjWMOt3bcRQEdfBrZs=;
        b=f9j+QcSJ6bgIn4zUI6Pv5CRM+T84mdmYiDZ9QDviuwif++tJrQaDO6HgOlXKq6l856
         JyREz3akbtpg6fruhEk4A/PjzFNuW+sfcfencNczJ3fbJE4uh8oyiF0pqmYbyoVWCkkM
         aoP5ATvnAwXLl/mTk1ndCNkmrfHQeb08lCX/fHP2SBXKrX/OEYYtgbqR3LWbQigg7Ga+
         kJ0rcTtfxiUXQqdJb9SO/Kxesdts1t6t9Mb2lugPy1rXRSRAv1yGMpHMdhEAhIlpZJMV
         JFcpKDx1wMqGWKRbGJCZ2OEHXC6sEL4GRak4H8+IjUtOd3qhwofTgsU2X25yNSBRPO6G
         sqsA==
X-Gm-Message-State: AOJu0YzfEM6DWTby7aacXKiVnnPFYl19m8Yc6Fl9que0fEVMK2FKTWPL
        Gt/QpcFczJEQW5BY/kGoW3p7TQ==
X-Google-Smtp-Source: AGHT+IEan1bQNWQMUIjClc+3tR651FQP0/DjA+XDLcE8v6xLwIt1fxOEA+DG6SlVjlc8mlA6cnRaJQ==
X-Received: by 2002:a17:903:610:b0:1c9:ec98:217 with SMTP id kg16-20020a170903061000b001c9ec980217mr403036plb.41.1697761122385;
        Thu, 19 Oct 2023 17:18:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bba7aab822sm299141pla.5.2023.10.19.17.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:18:41 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:18:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] nvdimm/btt: replace deprecated strncpy with strscpy
Message-ID: <202310191718.4F728D9@keescook>
References: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:54:15PM +0000, Justin Stitt wrote:
> Found with grep.
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect super->signature to be NUL-terminated based on its usage with
> memcmp against a NUL-term'd buffer:
> btt_devs.c:
> 253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
> btt.h:
> 13  | #define BTT_SIG "BTT_ARENA_INFO\0"
> 
> NUL-padding is not required as `super` is already zero-allocated:
> btt.c:
> 985 | super = kzalloc(sizeof(struct btt_sb), GFP_NOIO);
> ... rendering any additional NUL-padding superfluous.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also use the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) instead of (dest, src, XYZ_LEN) for buffers that the
> compiler can determine the size of. This more tightly correlates the
> destination buffer to the amount of bytes copied.
> 
> Side note, this pattern of memcmp() on two NUL-terminated strings should
> really be changed to just a strncmp(), if i'm not mistaken? I see
> multiple instances of this pattern in this system:
> 
> |       if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
> |               return false;
> 
> where BIT_SIG is defined (weirdly) as a double NUL-terminated string:
> 
> |       #define BTT_SIG "BTT_ARENA_INFO\0"
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
