Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459CB7B3A46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjI2S4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjI2S4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:56:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF919F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:56:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5db4925f9so7789795ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013802; x=1696618602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viFu6r0UYe+M2GIK9v2NmILPjJMba2+ouWRdc3CGGmo=;
        b=jMV9oe6EEaoKvB+JTAdGlNYnF6xqS9J9ZjjSU7N94MPptoxN5tlNNXxAi6SLmrzfpj
         KE6yD8l6kmKZTg31bmYU4IDBGYZMUYUcWS9COrjbkKHmYtyB9cBZwCH0SQUBoc1WtL90
         i10wwRzklmZaMkxdx5Lcv9/yCiM4W4/YslX6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013802; x=1696618602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viFu6r0UYe+M2GIK9v2NmILPjJMba2+ouWRdc3CGGmo=;
        b=NWbj6hPtE49eR3j323l7ee29FB6WK5mZvjUbpcwjlGwJiYyf5tek4K/fExTL31OTns
         iC7uUYIG9KaihIlkv7NeAx++zw7/4DYLGh+9HS7TARFgxn9lfmPrC/RLPeuZWjIUGcoH
         BvcaTRu42LChZfs3f9cfVmVoG/KOlTlfkIK7Iup+lAkXi9YFJ92VL70vpGlexQBOrMt7
         X9sDaTkZJQXmygpYe3mBqvrclPQJiCI/2ARGE9jrNwQL6XpCg4JaNJU3XNbeOBR478mM
         /YSg9Ed4f3VozmSaPmFx7JuERFZZwTHeE50JXo6tp4fzoXHc0xCQxgZdLz1znJhjsVJl
         G+6A==
X-Gm-Message-State: AOJu0YxN3yjkS9TeYSbd5IoUqneIBeVcLFcs9AR9DCd4qMOINENhX2Ej
        rVXH3mVRZFpQFEJlF6Yu5x3AHQ==
X-Google-Smtp-Source: AGHT+IG6ycLvJhoXuGVCEKkMG9iMqITIOTXsWbm9Kz37/RyNws1GzSB+B8H7SuyFFn3vA3gbgMfwlw==
X-Received: by 2002:a17:902:c948:b0:1bf:193a:70b6 with SMTP id i8-20020a170902c94800b001bf193a70b6mr8030559pla.5.1696013802531;
        Fri, 29 Sep 2023 11:56:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix5-20020a170902f80500b001c733c0e456sm3829091plb.22.2023.09.29.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:56:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hwmon@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ibmpowernv) refactor deprecated strncpy
Date:   Fri, 29 Sep 2023 11:55:45 -0700
Message-Id: <169601374243.3010937.14194696181874272859.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
References: <20230919-strncpy-drivers-hwmon-ibmpowernv-c-v2-1-37d3e64172bc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 05:22:51 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `memcpy` as we've already precisely calculated
> the number of bytes to copy while `buf` has been explicitly
> zero-initialized:
> | 	char buf[8] = { 0 };
> 
> [...]

Applied to for-next/hardening, thanks! (I've updated the Subject here
and with the older "refactor" subjects...)

Take care,

-- 
Kees Cook

