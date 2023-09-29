Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F67B3A27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjI2Smm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2Sml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:42:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0EA19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:42:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-279294d94acso763576a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012958; x=1696617758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9uvG72rN99E2O8Y/qdqLqMjg2c8kFRNHVwd2wswc8k=;
        b=ai8S07hGdEesJ+tYar8luKkbXpHUG758UVb26RdnyRp+Wa+XGuEkEXFWiD8w4KnFs/
         cbg5bh0lNo4lc0eih3XoGPHbivHmkjPcC5swHb3cRBNqex8owFm/fAvT91LoWxtBbNQb
         jq+om0zlZczrNzoiuM1T5LCmDxuyohfrbDSkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012958; x=1696617758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9uvG72rN99E2O8Y/qdqLqMjg2c8kFRNHVwd2wswc8k=;
        b=A/p8jJh9duPfoJdHgHHzMpieVJY9y3lkYmJGIpR4andsqtSMGC1YepqHMttGpwqOTH
         ETEl41dV8cu70vtiHF8K+iQdSiTGX8W4mgI/LQuKTfw8Cqsetpio4pHzfoaJ8Td1ZZP7
         3I6HYzSf6feF/U3g+ee6/eOSb4GdKcB9cYGX7Z38uoEXAiloXBTv93rKUA4Ntm+ukH7q
         quPJsfeT9tsajdQh1lqdk0g6A5z7CEHBJnuP4jECd0tWXhFPwhLyfkVGIik1aEyk6E8+
         l8Mgmc4gvkM6RyTrWIAkcJBHJ09/lB6wVylNRg52TtNsJWZtT3iJIJy+51l+7VdgspjB
         TQSQ==
X-Gm-Message-State: AOJu0Yz7Dk81QYL0WLApOc1dYHwwu7E6NBdNdSdxCzlEmZ+qte+1wUMO
        Xz9INzNFRRB1jIGxBlERvoSx2g==
X-Google-Smtp-Source: AGHT+IFawLQKnjWvqnv/R1ichCDj6BPDnUafRPjmIJgk11i3pS1JnzbcQn+xqetwefwI/Zpyai3aeQ==
X-Received: by 2002:a17:90b:1982:b0:279:dae:2d3f with SMTP id mv2-20020a17090b198200b002790dae2d3fmr7807149pjb.22.1696012958637;
        Fri, 29 Sep 2023 11:42:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a01ce00b00271c5811019sm1932915pjd.38.2023.09.29.11.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:42:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: panel: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:42:27 -0700
Message-Id: <169601293865.3008733.731908758021441164.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
References: <20230911-strncpy-drivers-auxdisplay-panel-c-v1-1-b60bd0ae8552@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 20:51:04 +0000, Justin Stitt wrote:
> `strncpy` is deprecated and as such we should prefer more robust and
> less ambiguous interfaces.
> 
> In this case, all of `press_str`, `repeat_str` and `release_str` are
> explicitly marked as nonstring:
> |   struct {	/* valid when type == INPUT_TYPE_KBD */
> |           char press_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
> |           char release_str[sizeof(void *) + sizeof(int)] __nonstring;
> |   } kbd;
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] auxdisplay: panel: refactor deprecated strncpy
      https://git.kernel.org/kees/c/0456f788873d

Take care,

-- 
Kees Cook

