Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083B774FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHIAAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHIAAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:00:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25561A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:00:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686bc261111so4491969b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=S7jrgnEEVtUldEZ4fNsxO5xEuNoE09AvfT2epMDZGQwiwLRniNAO2qXPn/6oani3Iy
         y4s2i5y5E7eP3BXt/GkDQ4kjTfxQGB4SkA14rz4hamND0QYauUTmcIS/uSJRQYbug7do
         jM9Zck/hWLwlAHtfJLiKY7st0kDikdcU5ZVQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539213; x=1692144013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fm5B+owbZtJ+LAFpreHAl1yfs2i6hETlV0UI2KgsE5I=;
        b=NFhrPqkaB97aajuxgI60hMGiizCS534kkBHOXyYtMku69N9tV7jKu8JdVLAKKQa8RH
         ogJ+khXORZLOEcrScM/qA6+MNom9gdtB80xgCqwhpyCO26EUWJ8GAmkn+I3QMLp6fgAE
         teKaFcU+qrnfRRrYe/Rgw6SZkObHAt7yCtHpmX7TpQWcEIZO6YTXbR9j4S1dYnVvYLs/
         gDUqirqPCoOgko3MCGln1XJ5USFcpTMmVORc9+139Jr+YXpzhfTunZYFRJl4/AfHmcuP
         ky75pvuv6eIX/drjwcTzlsK7uXw74tUtEXvtWI/DCMneRQLhO8UOOHFTxtOC6LYcT+6Q
         K+vw==
X-Gm-Message-State: AOJu0YwkIro5tDKyEK67J1XPArUXe/67V+LR6fkaWY5oKc0hISxCqEgr
        oTK8LJbcPz7ukUXmuvXBIh93eg==
X-Google-Smtp-Source: AGHT+IGsb7fkWGDseQQ2Ri6YAXrzLtLS9DjCLOnwlVVwzX1UZy1oeQM7mZIdp9cIPi7Q5ULncQgshQ==
X-Received: by 2002:a05:6300:808d:b0:13d:ee19:7723 with SMTP id ap13-20020a056300808d00b0013dee197723mr980401pzc.35.1691539213546;
        Tue, 08 Aug 2023 17:00:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b00686bb3acfc2sm8609957pfn.181.2023.08.08.17.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:00:12 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:00:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Justin Stitt <justinstitt@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <202308081659.BD539443@keescook>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-1-efbbe4ec60af@google.com>
 <20230808233855.GI9741@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808233855.GI9741@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 01:38:55AM +0200, Florian Westphal wrote:
> Justin Stitt <justinstitt@google.com> wrote:
> > Fixes several buffer overread bugs present in `ip_set_core.c` by using
> > `strscpy` over `strncpy`.
> > 
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> > ---
> > There exists several potential buffer overread bugs here. These bugs
> > exist due to the fact that the destination and source strings may have
> > the same length which is equal to the max length `IPSET_MAXNAMELEN`.
> 
> There is no truncation.  Inputs are checked via nla_policy:
> 
> [IPSET_ATTR_SETNAME2]   = { .type = NLA_NUL_STRING, .len = IPSET_MAXNAMELEN - 1 },

Ah, perfect. Yeah, so if it needs to zero-padding, but it is always
NUL-terminated, strscpy_pad() is the right replacement. Thanks!

-- 
Kees Cook
