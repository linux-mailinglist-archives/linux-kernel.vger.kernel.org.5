Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46FF7E607B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHWm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:42:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF17D2581
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:42:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6be0277c05bso195715b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699483342; x=1700088142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVpZQ2TqkbtD0eXsIko8JRS/WhVgEwgGc5rAVxKOH5g=;
        b=DNa+5WnAOkXZPe9jRWlzk+DnkFD/hloKHcdGm7q5RfOejq7TD7PmzJMxWpok4zjO89
         W1VRCyMqxAZyeGzXfUn99iLoLzs7YHDnsG1Te4xgSqRy3Tj2fIF1Mi91GYSuRIWww3gD
         O5YiURAs8rN8r/v7wfO6/2OGg9tA92xxuQc+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699483342; x=1700088142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVpZQ2TqkbtD0eXsIko8JRS/WhVgEwgGc5rAVxKOH5g=;
        b=BgghHbubWO4/EOJZR5c8GHUkuOKH539gdJSnJDPcW6CEyH7lT0rNOVcZ+jL+XcWWfC
         ktHtI2ufYY1V3kisZOMB1S6i424q1kD53nkizfa7sGX5Hqo8mNg2/l5CmB3H5hU55Q6k
         vici6q0JijrZ259aK058ZbivYPi+T4Zuq99VQanOLdqWrhrusc3KSOYbNNA02/HaodgI
         8hVGWmc49zEOGLgMvylbdMjX2T1fKIHHquvfDmkYPcfXx8VqjxQPnKstRIHN0clGwvy7
         LZ4e6SIYK1hMAjSnLgMNJFVs0iIowJFUWE6GseUljADNBgSot4Dez+Nt/dqdB7qXIWeo
         Wgcw==
X-Gm-Message-State: AOJu0Yyy1yvxrRKuykXoKnUZ98ryHHog3TOqMaBD1JQaDacp7XsaA3pQ
        Fi/j0jVO6jxpx1+E3WROu0j14zR90MdnkQOiPfxZvw==
X-Google-Smtp-Source: AGHT+IHE3wZkhuN2JLwODxxPG+/BjIN7tGWOJiAL/xyI3bDpvId5aRrsU/BuJouONu0EFLmW5BHiiA==
X-Received: by 2002:a05:6a00:3a1d:b0:6be:308:e61b with SMTP id fj29-20020a056a003a1d00b006be0308e61bmr2985096pfb.10.1699483342275;
        Wed, 08 Nov 2023 14:42:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ey18-20020a056a0038d200b00690d255b5a1sm9338107pfb.217.2023.11.08.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:42:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     yt.shen@mediatek.com, darren.chen@mediatek.com,
        tony.luck@intel.com, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Weichen Chen <weichen.chen@mediatek.com>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 1/1] pstore/ram: Fix crash when setting number of cpus to an odd number
Date:   Wed,  8 Nov 2023 14:42:17 -0800
Message-Id: <169948333592.634220.3558707769669516163.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224023632.6840-1-weichen.chen@mediatek.com>
References: <20230224023632.6840-1-weichen.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 10:36:32 +0800, Weichen Chen wrote:
> When the number of cpu cores is adjusted to 7 or other odd numbers,
> the zone size will become an odd number.
> The address of the zone will become:
>     addr of zone0 = BASE
>     addr of zone1 = BASE + zone_size
>     addr of zone2 = BASE + zone_size*2
>     ...
> The address of zone1/3/5/7 will be mapped to non-alignment va.
> Eventually crashes will occur when accessing these va.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Fix crash when setting number of cpus to an odd number
      https://git.kernel.org/kees/c/1d49dee6b691

Take care,

-- 
Kees Cook

