Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD627B7593
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjJCXzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjJCXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:55:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17727E3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:55:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690bd59322dso1154012b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696377303; x=1696982103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zDSZaEXmJ2Rq3hJpJCUNWtVnDT1OU4Zatqdb0xDsNA=;
        b=oCPyIjonwDbbQcQ/j8mCdWLmijTjql6Qk0JNCezOsz6FZLz2/fS+AojQJ8z0hdQd2R
         NiymEJ82Cx9XVK0SpqTxE5ABU5AcRLcIHg36D7WVYHNClfUUUx6CjQcfSVOQgMXBuXVk
         73Dlhm27P8lDk4zCnOVR5qw87hHO0k/89i6b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377303; x=1696982103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zDSZaEXmJ2Rq3hJpJCUNWtVnDT1OU4Zatqdb0xDsNA=;
        b=RvakGjruiJC97215yMq9CFbeXXyv78pb3X28WoYlWCbuON+pf38g5vLsFSy1XNO5o/
         gyU6ULm3Ft347F+OJJWEmwX1xLkqQE21HbaNsTYpL4y0tNYlikF7Cxb41eA3DMzFPQhK
         rqLq1QbXJpuf1hP2+VtDmTfObkLV0alofdsYv4OQ2EzcxNmb/gHRe+XeH8huPoJo3PJI
         wtwnh6htAmT8KM9TkJ0EH2of3PqvwsNO+HWALDeVpaTq7xPzEw9I/5ascsyNwOP6F0R5
         fUb56VihwOMADx7+UsuYH9yNCSrxW1U+Rv5y2XaFLBTNhuHuNjpHj9DICATbnmcKDbWk
         dALw==
X-Gm-Message-State: AOJu0YzEwQ/NPRTH+eLYa/N836BohK3gLUn4Hu8fL09CcT3OtiHj6X+v
        RXFmnP6eS1ylY3AZwG9oIrgPwA==
X-Google-Smtp-Source: AGHT+IHMLXtu+UBUaiToYMlRU313LQJjnHRm1u9g1daNHqKGmuGOzbiugg/42ZAIhTmGFvHR4Fn7NQ==
X-Received: by 2002:a05:6a00:1511:b0:68e:2cf2:1613 with SMTP id q17-20020a056a00151100b0068e2cf21613mr1144614pfu.3.1696377302885;
        Tue, 03 Oct 2023 16:55:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx13-20020a056a001e0d00b006934390d0c5sm2012467pfb.175.2023.10.03.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:55:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] accessibility: speakup: refactor deprecated strncpy
Date:   Tue,  3 Oct 2023 16:53:47 -0700
Message-Id: <169637722416.168837.4167782621423487593.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918-strncpy-drivers-accessibility-speakup-kobjects-c-v2-1-d5b1976c5dbf@google.com>
References: <20230918-strncpy-drivers-accessibility-speakup-kobjects-c-v2-1-d5b1976c5dbf@google.com>
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

On Mon, 18 Sep 2023 05:30:15 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this function to just use synth_write().
> 
> 

Thanks for the testing! It's been 2 week without any more comments,
so I'll snag this.

Applied to for-next/hardening, thanks!

[1/1] accessibility: speakup: refactor deprecated strncpy
      https://git.kernel.org/kees/c/692c013e8f37

Take care,

-- 
Kees Cook

