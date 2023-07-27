Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49F76580B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjG0PxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F650271E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686efb9ee0cso1127282b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7byZLLYnwmmWu9vINkUL47woFRKOyjYp5fOTgP+wEo=;
        b=igS0GQcrQIveAPQFzyQwhP4qE9bKKyyOHUNPTtX8kf0mYPpW5hcxXhyoW6aFVLRAGK
         PnIJFSi7wAS7PKPxFW52a9A+h3cJAwD9Y3T+/L4Y4HCiSpT38oVotAX+twD/kWsslIts
         U4ldXwQ68/ypzcQdIQzU0lWkdo+eBC28AXxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473180; x=1691077980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7byZLLYnwmmWu9vINkUL47woFRKOyjYp5fOTgP+wEo=;
        b=C9H+dRvUVzHrjIREGJK2ZHsCPc+UWY2njRsGcMd5lhZNDjTrIh3ZautKkJaorImGmt
         gi1xO/rxhmE8jGlqYxfROan1g/5jiqGYEQE/9ShXEWL4L9iMRrXuhOf9DQVGqas2TVdM
         yuzZWlulV6kCgTkQi46d/K45QYFyUvBV9cWyXlG0mfezr2WWb9UCgN9vlS00QmAM3GUf
         RI4292xX+oJ35b+5+spMEUeY9XMO3XG0JayvJA/MIqRmefq2HaqgQn2jd1MXkcFq2HLf
         hN7LG4XGnND7Ha67EYzHO53swPGYJvmTdvFXUUJz6OiL1+1gwXLk+tabakpTbEH3rITZ
         pJ7Q==
X-Gm-Message-State: ABy/qLYXF71SBQFzV5/pRSUAp369bM/m2djX5aDvc/N0skQpZs8sepby
        l5ln3xdC4nBWqevFWppmvLblmA==
X-Google-Smtp-Source: APBJJlFUaN7BXHfPCVb/0lPtSKuhDsKAgK0qZmTjLK5grvf3IvKfatUQ9D7onj/9Lo5gYiBXKBRSgQ==
X-Received: by 2002:a17:902:d2c4:b0:1bb:14e7:4fdf with SMTP id n4-20020a170902d2c400b001bb14e74fdfmr6994875plc.22.1690473179794;
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001bb54b6c4e4sm1803002plh.147.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] EISA: Replace all non-returning strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:52 -0700
Message-Id: <169047317160.2400214.17169594909094600573.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
References: <20230706175804.2249018-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Jul 2023 17:58:04 +0000, Azeem Shaikh wrote:
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

[1/1] EISA: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/f2ccf8d13625

Best regards,
-- 
Kees Cook

