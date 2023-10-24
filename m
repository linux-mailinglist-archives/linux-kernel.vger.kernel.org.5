Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74DB7D5D09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjJXVTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjJXVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27310D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4795354b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182347; x=1698787147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN6qLLiV1hMbAd2ABROBC8TqYl495gWbFutxERKWZ5Q=;
        b=mT4s4Ukao4U0XP3DnWwD9hL0lnywK/bw3sgWt6Obl8bftn20XFbV51NPQ+SRr1/l04
         jSRw0NG8tauKCbkmDjytC0I/+WH8qg+78JLFCuvgMOCa06cvD3AYP2dJTvj0wBrbiJyz
         uOuayNPuk3DEGn2h5EBgIlKxpoG3I6F+3NZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182347; x=1698787147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6qLLiV1hMbAd2ABROBC8TqYl495gWbFutxERKWZ5Q=;
        b=N4WlU/4DC7yms3EzKgdswFarXm0L0lL+Gc4IW06rsI5F9/invjOqdvho/xZOJmpg6r
         qtRv4oHp6w9uijTItT9n0KYo8gI4RtwnOjqkC8cY5lwTluaCh+/2bZXZSTAhjVdC/EGP
         QOFtPxSVdw5rSDa2yI9WVIL1UoBkT9+Z0XiZUDUb2He3LADIYFMzL2uA0BZ2yhb7yezo
         1vwqg6IyBg0hWoMlNaXEI+Kn4Rys1TpIED+R0TRMRd5NHkx02ozJeRuJK/vOr5TprXxo
         Jt10ec72gkNPEf602QMUpt57hJyurTkISgHAcpnWT+4CHOmE50uywe/JBgVzmrvq4tfk
         Azmw==
X-Gm-Message-State: AOJu0YyOOT/wby6zAbqVeHgR9WLTI2q7Wn2GvQdx/XUFBQVWeWtNclxh
        /o04Q/H7I9TxhHK/FEdkl/+e/w==
X-Google-Smtp-Source: AGHT+IF34WCz22LleHdBIoXGoj6CerzAjgn+5ajfqq2LqtYNzNXC/G3yfQWrDrbHRch4V57IWmaAtg==
X-Received: by 2002:a05:6a21:7983:b0:170:3e5b:bccd with SMTP id bh3-20020a056a21798300b001703e5bbccdmr3039533pzc.30.1698182347115;
        Tue, 24 Oct 2023 14:19:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h29-20020a056a00001d00b0068fbaea118esm6013685pfk.45.2023.10.24.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm crypt: replace open-coded kmemdup_nul
Date:   Tue, 24 Oct 2023 14:18:50 -0700
Message-Id: <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
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

On Mon, 25 Sep 2023 06:35:54 +0000, Justin Stitt wrote:
> kzalloc() followed by strncpy() on an expected NUL-terminated string is
> just kmemdup_nul(). Let's simplify this code (while also dropping a
> deprecated strncpy() call [1]).
> 
> 

Applied to for-next/hardening, thanks!

[1/1] dm crypt: replace open-coded kmemdup_nul
      https://git.kernel.org/kees/c/17348b0a6a6d

Take care,

-- 
Kees Cook

