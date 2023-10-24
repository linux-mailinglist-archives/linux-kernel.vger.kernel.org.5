Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780727D5D15
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbjJXVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbjJXVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:19:18 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0570B10EB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4787648b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698182351; x=1698787151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RD2uVI53YPOZ0BFcyzyDDbxRYlHoJPCjbTQOo+qzUU=;
        b=aLJOV/z21vV6m75Xb711cUpOEuqg9A1mLVfSpxFxZ2adW4XZGWqgdaI3E478R7lm6U
         t1oQVSIp/P9CpA/wQk75WxNjgLJMBBKTdWOdS9ZeHPK4DR5P77+CLdEMwq+HMg3TNHIV
         TQAQSqa47yQpwf1QTuhFJgUoWmvpyYZNStKfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182351; x=1698787151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RD2uVI53YPOZ0BFcyzyDDbxRYlHoJPCjbTQOo+qzUU=;
        b=QAk2Oq+WaqzjL41hNrFaXNp7E/7fy5boHrPOA9fSBfGohD1bQYfg0xNbUy2CxOyIZW
         ep2XKSSz6+ArFk+l3qY2eMWmsL07jTsuqakwBr8GuhOh2bgEHRP8gpsRAyDT0vvGeqYD
         Ur4uTKwnVzWPWh1eAKKsYwx60glJnwrf8qoCC79GwFIYetUBGFi27Ld7203si8vXXUxp
         3BYMCwpPuO+vlO3mSPNnq7aO0Acy/cy0rn5Aw2vRpfaxg93uA/njJ3gYZg2zBYawoAT4
         iAk7Y3FpawgM88XeluoxE/CD+eGhttNKZ7oK9Zq6ZKTglDJE59wSenCaeTmZMVCsHkuY
         A54w==
X-Gm-Message-State: AOJu0YzpSWyhhr8ovuKmjOcMW8k7D8F5q1OGgmyzIqe4aCc0nUDLRyEu
        TjVuhfCVCay22KhjAHj3utrWSg==
X-Google-Smtp-Source: AGHT+IFcgXtxN9yXCD1cRuZKX+QfDb7rz5xndfW1LoenNoqJDKgyBK7puzWMqXXuIIqdxoUPZgtJLQ==
X-Received: by 2002:a05:6a21:338b:b0:16c:b580:2a03 with SMTP id yy11-20020a056a21338b00b0016cb5802a03mr4592125pzb.24.1698182351538;
        Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ac384b71cbsm6440046pgv.60.2023.10.24.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: (acpi_power_meter) replace open-coded kmemdup_nul
Date:   Tue, 24 Oct 2023 14:18:53 -0700
Message-Id: <169818232967.2100071.14037828991402814804.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
References: <20230926-strncpy-drivers-hwmon-acpi_power_meter-c-v5-1-3fc31a9daf99@google.com>
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

On Tue, 26 Sep 2023 06:59:15 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> Let's refactor this kcalloc() + strncpy() into a kmemdup_nul() which has
> more obvious behavior and is less error prone.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] hwmon: (acpi_power_meter) replace open-coded kmemdup_nul
      https://git.kernel.org/kees/c/9cca73d7b4bf

Take care,

-- 
Kees Cook

