Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31597FFE51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbjK3WFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377157AbjK3WFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:05:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D310DF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:05:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc35090b0so13662205ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381948; x=1701986748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+z84/9szAuZC+Uij5uL4JYHHRg/gwkkJLqAhisbf48=;
        b=Yrc6Mvh0BBgy8D53nOvgWWwLFYZgf2/P+bDfmofx0bS++LPM0Ab3JrPGAOu97YQJAI
         hEtnfu+Y1jTdVUBYAGLpNYVAp211n9FfdhmypK9iWFKw5vKtRN4E3T0C7Amh2Xcq/uh7
         GC7Nh+md2HmbOfZxOWA+Tm1BGd8WRNTf5m4LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381948; x=1701986748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+z84/9szAuZC+Uij5uL4JYHHRg/gwkkJLqAhisbf48=;
        b=ZAVpD+YkpejnRjJL2HuTCD0OsA3Mly6c6ESQqOSrt5C28nwBrJDm+NA+lNOzIxoBx8
         g14qNDQR7YNIaqbCeIotKTldQnLVEXf+WKmE78PhVQucrhR0YN/foIwfILKZJL1P2ocl
         Tb88/8LzN8PyZeQxBKk+T2000UB0Zv26281i0jJd7yd4BF0/psVI7eemIaY7/Hw8lUAM
         KHocLV0B43rZfTB1AZBLFMQ9g6+n7D8LrHjzqDORDmVsDADIw3FH2xFTix3lzu7hZ5Vj
         KZAh274GMTwp2BnaNUAFYC32Yv/E/Xyzd39PztXARB2Nzvm9SiP0gJQ7R9kJIaBvaiSM
         I2ng==
X-Gm-Message-State: AOJu0Yx102tqtoFz/M8C4yvhUML9Mtks/0rusIBJuxVuyCwGAJ4rpMFU
        W4sNsy5aF5wkipQrcaRHe8c8UA==
X-Google-Smtp-Source: AGHT+IEjHZgHLIabxybJ+AkRENmwF9P4IgVmEVrP/H1KdcfCDs57RRkP3D5fO0kqDd00TZ7Ep+gIgw==
X-Received: by 2002:a17:903:2345:b0:1cf:d8c5:2288 with SMTP id c5-20020a170903234500b001cfd8c52288mr15051983plh.41.1701381948433;
        Thu, 30 Nov 2023 14:05:48 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cf65d03cedsm1890895plc.32.2023.11.30.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:05:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] lkdtm: Add kfence read after free crash type
Date:   Thu, 30 Nov 2023 14:05:45 -0800
Message-Id: <170138194305.3650163.16392122923355361827.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129214413.3156334-1-swboyd@chromium.org>
References: <20231129214413.3156334-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 13:44:04 -0800, Stephen Boyd wrote:
> Add the ability to allocate memory from kfence and trigger a read after
> free on that memory to validate that kfence is working properly. This is
> used by ChromeOS integration tests to validate that kfence errors can be
> collected on user devices and parsed properly.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] lkdtm: Add kfence read after free crash type
      https://git.kernel.org/kees/c/0e689e666214

Take care,

-- 
Kees Cook

