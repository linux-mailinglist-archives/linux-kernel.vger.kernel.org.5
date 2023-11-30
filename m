Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011307FFE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377172AbjK3WBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377155AbjK3WA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:00:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E8D1722
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:01:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d011cdf562so13508725ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381664; x=1701986464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LerepnGMUiOXT/0UGMgfJC9H+FWGcQr9/NrsSWwAYiw=;
        b=Q3dhC8qjpdGvSN6yf4sstv1lscPUiM7AdYCkZeyAZwM1+tcrkBL9mPq6BWnF+3XEFz
         WyMCIYCB+/8DFNZ3PmxRP2Z01h/3cQ65NyxGve/qLeviTCOzAsv2NhaAAerloOYcOu1B
         telNaPWDg/xcoYoO/q0N6jGyLGcn6aZpdqj7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381664; x=1701986464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LerepnGMUiOXT/0UGMgfJC9H+FWGcQr9/NrsSWwAYiw=;
        b=qwEioLMzzk9k3ZJ6vlRFuRfDEY4bA7kpyiQ8nyDMuTMMELz8YegHy5BLR4nM3zcbxb
         qoVmDpWJ0sipovB7DxWu2EzA+Gl+vkkcf/pIe86Kd4gp+vXTsrVefzFDkfyrO8AmpiN3
         aTILVaVQ4d0YE8w84LIfWOC607y33qTHQu0fZjew87huOEcb3aGLRQYeasb0twv+Z4qo
         Gf+DPdfcBMN+7us+NBmJ6e5T73NADWtKiLuYop352Et5mSASDqCRRVo09a7M9+tl58dV
         Z3GXrYK+f1hXTZHQqmopK6zfzQiiaY9RT9TNlzTWUnTL8aUEy8qdlH+FkTtszJzY+ORq
         6eEw==
X-Gm-Message-State: AOJu0YxWWfu1EtYveQUar52N9bgBjRXVkifyzhLQ7ZHg74Q6Q4EQMPst
        f9sfkJAFzm4AgD5tgs5wU2+3LbA0mI/SzxVgUmk=
X-Google-Smtp-Source: AGHT+IGXEBsq8mJGgfRrzCqpP9iVTEjhPsI63xlSBWuqXIohnExKvOFH6N2uRWv3F1zWbr5pMAWXTw==
X-Received: by 2002:a17:902:7045:b0:1cf:b4a3:adae with SMTP id h5-20020a170902704500b001cfb4a3adaemr17178400plt.44.1701381664185;
        Thu, 30 Nov 2023 14:01:04 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001c71ec1866fsm1910128plk.258.2023.11.30.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:01:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] nvdimm/btt: replace deprecated strncpy with strscpy
Date:   Thu, 30 Nov 2023 14:01:01 -0800
Message-Id: <170138165969.3649414.1104286704035557609.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
References: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
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

On Thu, 19 Oct 2023 17:54:15 +0000, Justin Stitt wrote:
> Found with grep.
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect super->signature to be NUL-terminated based on its usage with
> memcmp against a NUL-term'd buffer:
> btt_devs.c:
> 253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
> btt.h:
> 13  | #define BTT_SIG "BTT_ARENA_INFO\0"
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] nvdimm/btt: replace deprecated strncpy with strscpy
      https://git.kernel.org/kees/c/26b4ca3c3901

Take care,

-- 
Kees Cook

