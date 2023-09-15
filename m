Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1557A156E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjIOFbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIOFbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:31:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5192708
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:31:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf57366ccdso21006115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755871; x=1695360671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gABgaFjBhZw5TskJOpVAxOP6v/0aRMLwh4GccF5gC38=;
        b=hD8NeGFlbPHn9wKu9MmrgTvXb8isbAQMaz5VJJtYAH26aLsc2OXxF0y+IeErw+Dfee
         V3xx3Jh+ZWBS2sNM4Mukyl7iC810GgTaFDf782gW2hdJO6NeaiH4QSxTE6BBH2Pe8ChX
         2xffsbh4Qm+iZ8R/v0A5TBuVTDUd2FkNlloLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755871; x=1695360671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gABgaFjBhZw5TskJOpVAxOP6v/0aRMLwh4GccF5gC38=;
        b=Ey+p+ly+CCX9rbPgjLEyQHpni6Za63LFq5hOU0VbXzdB2TBgsxivBlSAHR54NIRxxU
         9BgF4nKuMtj/IZoHKUofFjPAyZTHhCKk2u/gPyemLY5RLsp7PaCqZL/C5mnD22qgeoT4
         5rRUE1BeK6jCyDIMUduv65YuY+IlavnYcDGeIAW/0KAdWui9RwO8fvP2g4irzGy/KXsl
         kPL7CZy9axacvENqO8nQGtWoD51JGdDkPqZZpY9Bj/M8e74WV2JuEGjhGN+jM6x4RGYW
         4fMrukd1RgmDyAVye6m2MRm3n79Ps1rbLix8mB9CF1HFo8Ewz/7ovGTwgcKb/50y3khO
         7xew==
X-Gm-Message-State: AOJu0Yz8sVkqvGxsy+ormzkuyILwcIdAZ0/IwHEaSYhWZ0nqhYR3jAYk
        +eIvITv9wtUxfWvS5Kq4EoNj+A==
X-Google-Smtp-Source: AGHT+IHpVgWK/GmH1DICoQbxiecZxWXuSxkFKfmb21BW9q/zQk8/UqPup0v4SVD2yLhi2zjN0IDhow==
X-Received: by 2002:a17:902:e5cd:b0:1c4:5a9:a45e with SMTP id u13-20020a170902e5cd00b001c405a9a45emr1032547plf.27.1694755871472;
        Thu, 14 Sep 2023 22:31:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001bde12178b4sm2524463plx.33.2023.09.14.22.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:31:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
Date:   Thu, 14 Sep 2023 22:31:04 -0700
Message-Id: <169475586230.4081099.16940913088355099799.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
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

On Wed, 30 Aug 2023 16:08:06 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] init/version.c: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/ec23bc09c1c0

Take care,

-- 
Kees Cook

