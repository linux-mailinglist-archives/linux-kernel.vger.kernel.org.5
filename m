Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B807A156F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjIOFbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIOFbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:31:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415B2711
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:31:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so1326855a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755879; x=1695360679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2oy3JQ3Ym6wgzqkudmTJFBYwdewLlXjODtSzjwIDM4=;
        b=JJdUekjU0GgMaIO7VMrqB5psc+GOo9qj4+2YeeQ1E463ZuZKI8zCoLmp2J+1l2X1SZ
         sSnYQOWIWGOLCeo8R1kuFyBnGfz8PcrZC0u7u1mn4QZcIfZF21n94lYztF0K34pnUQ9C
         EjMyDY3TV5K6jSmuJ6WCfNCRc7a5lrjQ9Qqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755879; x=1695360679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2oy3JQ3Ym6wgzqkudmTJFBYwdewLlXjODtSzjwIDM4=;
        b=ZzrtXhNigqkHfYDd4VMG0hN1pAtw5mbJ7ByeHASECq/ohjISI6RFeuJGDyRLBnIMcX
         VjVNxJph8MsWbmngOstWhVAEq49TLLzy9mysQhrcXQF5pmZAgovjfU5oxV0IMHUXCKGP
         Z47BfW14PpSHiBrdIV6e+eJEOUvC9bnNfrM8xTuVwLsRBmNBadg8gACjQ4f93wehb1dW
         4PKWxwt85XlTMC0tSWxURE8SKTYcW1x6ninOfkP9SfmX2NiaskwWki798jelRzSxyAv8
         Wfo5C2WwTZMSsyhi4ClaoWcNKlx290P7UBVkuke96vGRWdCvgg9aiVh/dbxWoJTbZxCC
         Tmow==
X-Gm-Message-State: AOJu0YxmO4CADBUOjoJuh9xIW8QiBL85JB4ApJBjZSbOOteaj5YfzU5a
        6moFPUlHChYTUC8flNYTPXc2eA==
X-Google-Smtp-Source: AGHT+IHMIAlMdBTZtgkSQiGvMYyOxImIq1zcFtS0+vkG+SJ/6YzW7skLyFbJxSwvmiQQW6dl/k/Pfw==
X-Received: by 2002:a05:6a21:4886:b0:14d:abc:73dc with SMTP id av6-20020a056a21488600b0014d0abc73dcmr801625pzc.32.1694755878761;
        Thu, 14 Sep 2023 22:31:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001bfd92ec592sm2511764plv.292.2023.09.14.22.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:31:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kobject: Replace strlcpy with strscpy
Date:   Thu, 14 Sep 2023 22:31:16 -0700
Message-Id: <169475587548.4081176.2268827529789172345.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831140104.207019-1-azeemshaikh38@gmail.com>
References: <20230831140104.207019-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 14:01:04 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kobject: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/68a39dfd6f94

Take care,

-- 
Kees Cook

