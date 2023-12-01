Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD8801296
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379274AbjLASZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379218AbjLASZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:25:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93775129
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:25:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfae5ca719so7485035ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455157; x=1702059957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orj9kF5e+hUcR28yOOxjlUg2Ej6Q6UVVNyYtII2f8D8=;
        b=EIW98yMkqWGv6NAbMULA46eyhHZ6XfRcZOPmJDtyo6oHeUqpiaZWieLOrRQ9GRjWuV
         1eC029v54Ia4Ka6R0A5OJkLS/MMt4sbEUTrs1kAd7fIU7Dswu0Qj96MOH3r0VTWIPGs7
         VVIrd+p7KJe2KwSY/prKQKEzn+Svwh3bywAzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455157; x=1702059957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orj9kF5e+hUcR28yOOxjlUg2Ej6Q6UVVNyYtII2f8D8=;
        b=nX0QxLw8hSWcdQ4zi1n3yPRBONfYe1sDgyiMC0qiwr860R6w3A7mvQhTiSBertAbhp
         CKcJy7CxWmSbZjwfWqWC0jF4w6bb8AlrMLWDmbN2/BCorBVfPGNOWhyWGPw9aemS5Sfa
         nFaVbkQh5/9iSA1GQcHsfuaGdAJZLkpMBe7q/rHgahWKqN3kjPubvIINZyT31J3KJY9G
         OYqSOPTgFgvW7UQEchgBmgDkYgn7S0rq9WS+9EPZgqUTn+xKETaIEjn0kvcVHS1TbHM4
         4vMHNX5QBugpNWMBZV9EwGbL/hOx/FauFj2LAKIWge/icEyr21bE49D10LUq3+i9UQIJ
         9I5A==
X-Gm-Message-State: AOJu0YyGdKTVk+UM9bYdTsGhZTfEKmDMIRCJhTSHa8lvcShxbl+1wL93
        HCe8rhLmPAMDd3M256RrJ26YYw==
X-Google-Smtp-Source: AGHT+IEbUvlE58eT2LaLFiL7khlyUcE1aUZwyJ3/wHK55llArs7nB+pjInhr6ocqQcgHJVujAr2xgA==
X-Received: by 2002:a17:903:2302:b0:1cf:c649:61a3 with SMTP id d2-20020a170903230200b001cfc64961a3mr21194686plh.52.1701455157079;
        Fri, 01 Dec 2023 10:25:57 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001cfc50e5ae9sm3667469plr.78.2023.12.01.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:25:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Date:   Fri,  1 Dec 2023 10:25:49 -0800
Message-Id: <170145514843.55310.746207226357478640.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205607.work.463-kees@kernel.org>
References: <20231130205607.work.463-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 12:56:08 -0800, Kees Cook wrote:
> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tracing/uprobe: Replace strlcpy() with strscpy()
      https://git.kernel.org/kees/c/8a3750ecf810

Take care,

-- 
Kees Cook

