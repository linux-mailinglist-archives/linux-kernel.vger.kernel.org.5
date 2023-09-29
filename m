Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B67B3A48
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjI2S46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjI2S45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:56:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D271B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:56:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5859b06509cso1012421a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013815; x=1696618615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38pbwnD/6eDKhHLG19a5SyUZuoCH2GCeORBXHSAlt1U=;
        b=Isl9SkMcfMurRagz8HyCgmPmq2YMHkBwmZWNnPuaeYC8fZ6jr0J+DGH9kxIQaUZ+xH
         cDb/5rtLXHAQSXgRLNk7N9yi2pDK4W4WkLbRwx8HVjU32UbRZYUMsNDzeuuEqmnjTyTD
         t5C+bLjKn1/2UGoUyNCXP0507FgbgkBfdg310=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013815; x=1696618615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38pbwnD/6eDKhHLG19a5SyUZuoCH2GCeORBXHSAlt1U=;
        b=ZFWd57e/4U7Sbccyx6bu5XQD0WNl431Xa5pWKdyoVx73R1bxMT3QfR6SdVTVQc08+i
         jcgoXSa/gUmCxHwzdbCiisV+ml/pAMH5AtoRi70z1TD7qGY2iVOmG0dBq3Y+mA68oI8n
         aeErRv7uwTPNc0m3dlsDvzmBBCjFbCB5qR1peTEpjNpYlOk9CzNK69vAPY1fKr4bHuNl
         hEv/TPJC1BRk8AW5XmCogPaVHjBdJClCsoVuuZWtr2yoMH97bLrD0T9j82z9CXojKKs1
         G511etd+9aLMOm6e/cgZ3WRCj0mGnKcgugdQuqlTlVoWWN8l5xY5lxMZLt4b+UZ96u0B
         4lrg==
X-Gm-Message-State: AOJu0YxnPxqbU3tAYoJmdckMbcB/QDPV/Dyvw54bt5QAxw+cESQDEXCP
        Phl4LAxOtwO2nrohbAJ39pdUtg==
X-Google-Smtp-Source: AGHT+IF5nt/LdTUwDsS/akLaNEuPbpl4qhURQmh05OKPQrNtEcQY/ppQfYdlDqxFeMC5y6YUPwJZjQ==
X-Received: by 2002:a05:6a21:32a3:b0:15e:10e:2cc3 with SMTP id yt35-20020a056a2132a300b0015e010e2cc3mr5542828pzb.60.1696013815496;
        Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902ee0600b001c7283d3089sm5497300plb.273.2023.09.29.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:56:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus_wmi_sensors) refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:56:46 -0700
Message-Id: <169601380449.3011049.1674985914851229968.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-v1-1-e1703cf91693@google.com>
References: <20230914-strncpy-drivers-hwmon-asus_wmi_sensors-c-v1-1-e1703cf91693@google.com>
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

On Thu, 14 Sep 2023 23:10:34 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding. If, for any reason, NUL-padding is needed
> let's opt for `strscpy_pad`.
> 
> [...]

Applied to for-next/hardening, thanks! (Subject updated...)

Take care,

-- 
Kees Cook

