Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77EE7B3A14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjI2Scp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjI2Scm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:32:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63F136
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:32:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578cc95db68so8006226a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696012360; x=1696617160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SF6n2eufv24UNtvoOGLmOHY49lmjyqKXfDP05Zw/ODU=;
        b=laaJX50eAyYEbQc+fvnKCztUz6fDVfl+/0tdP1N/EPbnY/iIFKnCnMsHbs1G8f8I2a
         t0gH3EMd8rhtA7VOdwqa8VXbWVmjJPZpvcjBoRg429HX7avSOgV+OBJ7Su4+IzK2KKUP
         XTOFOLBiEp+vNzOmQ98YLe3LNYd9+aJwDJlGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696012360; x=1696617160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF6n2eufv24UNtvoOGLmOHY49lmjyqKXfDP05Zw/ODU=;
        b=GnqCyIXfLpNce2srNdmAiVUXpguQdxU4Yf0RBb16SB6iVdtj879ifb/ChGdI/WM0Dq
         XpriOZFFXGtTMQ3MvULW2qoa8PCKljRvozjANKioBvuRAD3Fx5T1LUoskDvhJTvz5hFB
         XyhuoAbbqJiQcfzIttP9QHUtgmt8q3McyYl23eMEiVvFSWGZKIHfNHv4WJhRV7z4PWeO
         aGwId8UHbopb/oKZ75TQmzPufpYoiC1JDaqcgPmLPgvpdmsEzJrkfLQ/pahKh7yxo5Ir
         FbUD1awPc4HxGVc+1HuHsKv7uFpkjVu71EpBYuc0L4Ra+6NAGhNtiy7ILgg35loB/Hwv
         IGKQ==
X-Gm-Message-State: AOJu0YzE9E9yg9d1Mz9ybWNvb1PlHx9UVDfKrzE/L/GR/C6OVt6dr7f1
        lvQKROq8C+pKBmNodE+lPdxzBA==
X-Google-Smtp-Source: AGHT+IEvX1oEeUKbJDfcj50CrRy49qfzCBzl6yJV/KOKS/JsgDFnXD5aAAqU/2nWkWm8ccindXE2oA==
X-Received: by 2002:a05:6a20:a11c:b0:14d:7130:7bb3 with SMTP id q28-20020a056a20a11c00b0014d71307bb3mr5797622pzk.13.1696012360531;
        Fri, 29 Sep 2023 11:32:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001b8b2a6c4a4sm17133890plt.172.2023.09.29.11.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:32:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:32:37 -0700
Message-Id: <169601235586.3007879.13354261591100704778.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
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

On Mon, 11 Sep 2023 17:52:44 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `gate_buf` should always be NUL-terminated and does not require
> NUL-padding. It is used as a string arg inside an argv array given to
> `run_helper()`. Due to this, let's use `strscpy` as it guarantees
> NUL-terminated on the destination buffer preventing potential buffer
> overreads [2].
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] um,ethertap: refactor deprecated strncpy
      https://git.kernel.org/kees/c/d4e178fe19c9

Take care,

-- 
Kees Cook

