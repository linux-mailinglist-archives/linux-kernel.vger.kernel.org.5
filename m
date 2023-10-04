Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6677B75C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjJDAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbjJDAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:23:34 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2C9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 17:23:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd26c41fc8so255480fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696379010; x=1696983810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez26gy9c2AmSrsb9lxv7cbyOXUyAR+EWcPzvcDK4+/Q=;
        b=k6Hk7RYRluehQ/L1AGA5Owg/2NyTDLgpuKvzty9uPFr1C9nBE6zs7QoQsgXHVjCrp6
         Phi9BbG/IVeGs6hPWqJePPk0fEKhhIVpPj+Fq3N2r9nHk28/7vRpTCeoncRVevp3YB80
         nutPpuDZIt2g/oWmpWnbqDE3P6fsUQ4n0T9WC77v6pAI7e8SUW7BhAjjYV1aBlgsvAjU
         yKOhWA6gJBL0bLS09jpOAyqVEnr0j+sMhZsOiVHhTT+ixmfzfbgw+pKiILJ/ZQvy+RpJ
         8l1ZtwmiV7goNTVQ/wiFsBWdaUHKP8W0C+fUwV0PS8v/TogX5TPWlAR1gwfuFHdgR+YS
         6hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696379010; x=1696983810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ez26gy9c2AmSrsb9lxv7cbyOXUyAR+EWcPzvcDK4+/Q=;
        b=RaeTV//zW9alTRRKl3JG7QA6wqN4V6MK5IKTd4Zalvu+oK0XYWLQaGz5Mfa4UOdemM
         5lYLZGavcXonMjwLkgKil/bpFaefZO+t3qLd0URGcA/+dHsWUpawLJ6LxVFPK3cFg4Gh
         IMzSAZx7vHzLV+oNAyc6kWlsY0mqj7O7JIZehdLL5XU2miMu8kUa1DDEPn00oaF0XyLE
         ecmgx/7X7wCUvspkir8n22lt705gxwtkS0Od/RoHVf65POfEWCIJAi+8W63HPS1Jf6u8
         XHvJLeWTLrJeDoagG01b4F7uEH95q0rj88s4KKkxhFY+2/h0PIlD4ZkiSrhHUM6+8VuJ
         rdfg==
X-Gm-Message-State: AOJu0Yyw7dBqlc70HPW4gr6EPqWAZamZ6/TgQFqWwKZevJqpoNTyvZXU
        lITBdHys2x0yX10r5SutSp5QXA==
X-Google-Smtp-Source: AGHT+IEDW1m23bvF/k1OZ9I6cWgVW5H46waJxGasAHFfhJcL1Wwh8860VLpbRJWvqimsjoNJe/QKjw==
X-Received: by 2002:a05:6358:830d:b0:15e:5391:f1e7 with SMTP id i13-20020a056358830d00b0015e5391f1e7mr522434rwk.3.1696379010016;
        Tue, 03 Oct 2023 17:23:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00578afd8e012sm1721966pgp.92.2023.10.03.17.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 17:23:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
References: <20230919-strncpy-drivers-block-null_blk-main-c-v3-1-10cf0a87a2c3@google.com>
Subject: Re: [PATCH v3] null_blk: replace strncpy with strscpy
Message-Id: <169637900876.2061762.14731877442734988774.b4-ty@kernel.dk>
Date:   Tue, 03 Oct 2023 18:23:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 05:30:35 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should favor a more robust and less ambiguous interface.
> 
> We expect that both `nullb->disk_name` and `disk->disk_name` be
> NUL-terminated:
> |     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
> |              "%s", config_item_name(&dev->group.cg_item));
> ...
> |       pr_info("disk %s created\n", nullb->disk_name);
> 
> [...]

Applied, thanks!

[1/1] null_blk: replace strncpy with strscpy
      commit: e1f2760ba3478fa3f8c48db8e91fbe3df8bea2f8

Best regards,
-- 
Jens Axboe



