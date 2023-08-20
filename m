Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE8781CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHTHfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHTHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:35:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA34208
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:33:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf078d5f33so17987095ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692516817; x=1693121617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT3lS/Jv4Funx3x4lB2IfaEWNFY6X105VqzhdeEsq94=;
        b=VyUcsj1JGYEopaoBHIqTW+KTajNecFXm1mCLu66FxbfJp/r0p5D6QzZO7ZIAeYX4oa
         UunNQ36jLS2a7vGTXUDPhPAXtt7Tszi6R5NAResk8U1xJJbs/iRfxVX4g2A8whEWqPOO
         eC1EwXjuH9a6pEZnZcLNX046Z8q0eW1Kg2vmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692516817; x=1693121617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT3lS/Jv4Funx3x4lB2IfaEWNFY6X105VqzhdeEsq94=;
        b=XZUqXRxgTDIfDlSF9BXo6D9YCQN13lyPrxken2OyhEqXHGyF2utqdEhEvKqW+osvtQ
         tB/Cicy8NSIxzvzdszMXe9ygsOE2EODnlU9uA+EK2BvpOcu0/nge1bnWbJhwfarupDJH
         XMv6cuCbQJ6gIvzUj6jLRHFdb+XxFdAe1zKEldedJWXPR/stco0PmmkEJdfIRI5Kda0A
         1kLxBcWk9m71DUPd6QO03i4wT7Ii6DEa2zXy3G/dV4NfeCxmBuuv88zWnfxrdxMnQz3v
         cCf/lwtDvual77+I9VU2C8y+2yZTJWIke0Fx+h9M2GO7L7rx9+bjyC0HIyhmxR/meqk9
         TZwQ==
X-Gm-Message-State: AOJu0YypCjRfT+tJO7l2I+d4amtjO3hJukxxO+d7q3CoPnp1cDUDPqyr
        2lWFpEGqNm7JB30vlTc+ZXMH+w==
X-Google-Smtp-Source: AGHT+IEje6KjE5NQg/EB2Mr/qhSz7z0A+zpIPsBpEjnxEEcS++pnUt3/LqKj+wpt3NNsuCMvqnKtqA==
X-Received: by 2002:a17:903:1108:b0:1bc:1b01:8961 with SMTP id n8-20020a170903110800b001bc1b018961mr4803262plh.1.1692516817118;
        Sun, 20 Aug 2023 00:33:37 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001bf846dd2ebsm108808plg.303.2023.08.20.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 00:33:36 -0700 (PDT)
Date:   Sun, 20 Aug 2023 16:33:32 +0900
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
Message-ID: <20230820073332.GN907732@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com>
 <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820072119.GM907732@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/20 16:21), Sergey Senozhatsky wrote:
> What the preferred approach would be? Do we want a new KCONFIG_FOO env
> variable that changes behaviour of one of the targets? E.g.
> 
> 	KCONFIG_LIST_MISSING=1 make oldconfig
> 
> and then have conf list symbols and terminate with exit(1) if there are
> some unrecognized symbols?


Will something like this be OK with you?


 KCONFIG_LIST_MISSING=1 make oldconfig

.config:6:warning: unknown symbol: DISABLE_BUGS
.config:7:warning: unknown unset symbol: ENABLE_WINAPI

make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1


---

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index fa2ae6f63352..b2c0bcf0e5c1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -360,7 +360,9 @@ int conf_read_simple(const char *name, int def)
        char *p, *p2;
        struct symbol *sym;
        int i, def_flags;
+       const char *list_missing;
 
+       list_missing = getenv("KCONFIG_LIST_MISSING");
        if (name) {
                in = zconf_fopen(name);
        } else {
@@ -448,6 +450,12 @@ int conf_read_simple(const char *name, int def)
                        if (def == S_DEF_USER) {
                                sym = sym_find(line + 2 + strlen(CONFIG_));
                                if (!sym) {
+                                       if (list_missing) {
+                                               conf_warning("unknown unset symbol: %s",
+                                                            line + 2 + strlen(CONFIG_));
+                                               continue;
+                                       }
+
                                        conf_set_changed(true);
                                        continue;
                                }
@@ -482,6 +490,12 @@ int conf_read_simple(const char *name, int def)
 
                        sym = sym_find(line + strlen(CONFIG_));
                        if (!sym) {
+                               if (list_missing) {
+                                       conf_warning("unknown symbol: %s",
+                                                    line + strlen(CONFIG_));
+                                       continue;
+                               }
+
                                if (def == S_DEF_AUTO)
                                        /*
                                         * Reading from include/config/auto.conf
@@ -530,6 +544,13 @@ int conf_read_simple(const char *name, int def)
        }
        free(line);
        fclose(in);
+
+       if (list_missing) {
+               if (conf_warnings)
+                       exit(1);
+               exit(0);
+       }
+
        return 0;
 }
