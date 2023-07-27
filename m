Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566276580D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjG0PxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjG0PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0702727
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb84194bf3so6976975ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tsln9vKd77VrKuSCt5b74Dm8nHR1wAeieAig4NB5efM=;
        b=nXJUOUbb//dCVbV2sNfuul/Inn6960O/kVZTCj/H6sx1GdOxxNK6slNWvKKjY+iP61
         GAzYNIFfZK77JXKjmzOAxURrTGpZE7SQkmwqETn1oPudri7QL5DTL3n2+JNk5OoH6rQa
         peDFusmEllNIHZfnhbZyCrIZtwkTDrKl0K/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsln9vKd77VrKuSCt5b74Dm8nHR1wAeieAig4NB5efM=;
        b=IfOe88PVOiHNBYur4uPXHbkrtaEBK5UXJ74KZGQV5CSnoD6TU/cgG6UJUsBL4ikrHa
         lY+dNn1cYuUH8TPHMKUcnoMjDro8tHduMHREZftiV1EVcyFL2t6tov8UcXOBgbkgOS2T
         SwktABoO260BjgU8TLsabFKOgwuRcrXC5ypY+r/Mhv8MqeWxhRHMa6D/UrgTh9r7aWne
         +SLMYNL4vuD/gKJ4+vuenJWIlLhmUlVE0r3Gx6vmWRwiLDwrDDsFh73dOlzcTxSYM1gf
         TW0AxDBEqArjz6I8t0OcKsaxq5Ryt/+IdwTPMaoKheDoec8FGyc2S2bgLVfJLzRZ05ar
         QGcA==
X-Gm-Message-State: ABy/qLYzOuzhOCtV86Jh29G2gLVVLchFRYgqSI/7zYTyEfFEttObirqG
        isKwY0YR1wn8WDi1ysfU/Z9pXw==
X-Google-Smtp-Source: APBJJlFOaM/OFa4DX6l2QCKWulPgwcxSJTXbEbkawxaDeRErqsLH0YJUo8GTRiLZLV6zU5t99voBfQ==
X-Received: by 2002:a17:903:24d:b0:1b8:9044:b8ae with SMTP id j13-20020a170903024d00b001b89044b8aemr4985631plh.11.1690473180185;
        Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b001bbab888ba0sm1803506plb.138.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:53 -0700
Message-Id: <169047317156.2400214.7935379824991435172.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
References: <20230703165817.2840457-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 16:58:16 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] perf: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/c9732f1461f9

Best regards,
-- 
Kees Cook

