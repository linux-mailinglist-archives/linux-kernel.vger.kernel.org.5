Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194D784DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHWAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjHWAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:09:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C116E5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:09:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c0a4333e03so952035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692749350; x=1693354150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdAmFpsgAimnC/MBfbBr1LVAlYOvun6vfII/jkXCFI8=;
        b=w7VKM9wOfDqjg3owcHgb2C1pnHTB9457TIJF1v5sJBPucicGSUVcJwZhbBMXy0CApW
         gmc6pzY4ypInuel01Z/6LdlQpZBASjvNe/TpVzvbylk42+d+JWm8fDM1rWD5wmk6DqPm
         602Fh89hxbzIbZq6T/WoFLAk2obOopGYQ/Kr9awheMUn7sMyWDlAJkuFETmprLdVkHMA
         2/raoT+DuUgn/r7Qt2FJwbY7g1aoySD/PICaXxcBM5NCOSBbpwpKjGHzNgqc5VbTJmFr
         st02qp7I32ujhd0pqOjYxqQBerVFJblqrbKn9gE47dsllzXW2nqbgAhuZadpsZl6HF8j
         DprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692749350; x=1693354150;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdAmFpsgAimnC/MBfbBr1LVAlYOvun6vfII/jkXCFI8=;
        b=cL6JHz0umRn99N/sC4852JCNmPckwEHp4jcfNLc1MOjyjjyl+U9OZXmnKJ6JMQRX1C
         FRPcOQta+WgvNtlfV03hrTWw5gmzU0GLjBukY8RKmVX/2kqlw05LC97lAUaFVQpXffST
         f9IEDi1OBdViSxLlsnlnHwx/ZdLbjZDj2xKRjb8nxb5bD9+kreQphtRP4Gus4bPmZiXZ
         TM1KBHLhG+0XmCyOqqR5GWhvrpKrzgTGlaW2kHwvdIaseVb/tcFiGeNKvuotlZPo6ipL
         MK1cjj9Iu1IM8p7Vzi7jY3pr334lP6fIchY5ZQt7xCgQ/Y20AVat3hG9lr/JqCVu5mx3
         Llgg==
X-Gm-Message-State: AOJu0Yzlgyywu2Ivuzy96TdhGPDJ3+nXFyXG04bqZMgo3oB6kCO3Y2P+
        mH+0QbtCZy3qMf1UmHzw7s3hZA==
X-Google-Smtp-Source: AGHT+IEWieYgoZObLvRGZKRu3zCi2GHgsl+XF2ezTYqTa5Gs1LxrTcwz8X3gX21BbOaA5WSk2J65hw==
X-Received: by 2002:a17:902:dacd:b0:1bc:496c:8eda with SMTP id q13-20020a170902dacd00b001bc496c8edamr12479327plx.4.1692749350550;
        Tue, 22 Aug 2023 17:09:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001bc56c1a384sm9528238plk.277.2023.08.22.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:09:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
Message-Id: <169274934932.113461.1025457818715758046.b4-ty@kernel.dk>
Date:   Tue, 22 Aug 2023 18:09:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 23:59:26 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> 
> [...]

Applied, thanks!

[1/1] partitions/ibm: refactor deprecated strncpy
      commit: 674576f8af1b34d7babade11082c392bcb6081b7

Best regards,
-- 
Jens Axboe



