Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302A7CF6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjJSLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbjJSLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:31:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D6191
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:31:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so1091562b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697715080; x=1698319880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJEDujWnPhanwrnYk+UI82QdYkyiqzOJ40ODb2Z7lao=;
        b=Bnu1ulTFo67GEcErM/P/jVFHma/ial2Y3bm2bhqoCGzaQUlFDdc7uO05HVBZlWlIri
         JJXHzQN4oPz2oTHG0dMWnXjdltMHFQ5zOVI396HSIXUsWUAz2TV3GttiOFkyOx9FOHrX
         JUchIMfa39N2iPsBOLRCel6KrHLGF5MDVRoXX4rBQWvbsoC7Z9KYfYMJjbt53XQtjd9R
         AVOcj+aZ9MfNUC+9V/2/2T2FF8ZU/SmNxerf/3Jlokl27v1v7bj69o+rNQt/nmQUoSQX
         40+6BgqqwTAi1ll7oL9KC8gXLzqW1+y2JkmUjHXVIG6hCaI7m995Mun/T2ClWHUoOUKS
         MTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697715080; x=1698319880;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJEDujWnPhanwrnYk+UI82QdYkyiqzOJ40ODb2Z7lao=;
        b=JUzl1itpPKTe4fQcmfCdsSpCQQNKawqWQxnc44gs+jpinfkluk8nqFfzQgxOrZm+Rb
         h8fVlTw9RZaWVZYRZx/5Qv3rzE1R1SleLyEl3S8iBHDkJ2bTd59+mjiQwQ9sOyYnuL5p
         WQ+r+Gwqn/K8Ie/oybPe1vDlHdBiD3uHUDpCJOmy/RwGJWYumtBUuMxhGvowJYJvrDyN
         wRTg8snVTveD/NRsM745GJL4CN1CmgRo1vwy/cI6m0lWqlnwNnxGkkx4iiGpyGXQj4k/
         OZzRWzCE5F0b4Qh3fINTjMGABQkT00h51PYZftliLzTFZux9cw4REZddnYZkt8wg6yG6
         JWFQ==
X-Gm-Message-State: AOJu0YyPRRQfedVJOpmF7KFP0UpBk+k7KbeHayHr0kHeRsxk7K8GAo12
        r7qZsPWxO/gWReQMrNXVVPyeLQ==
X-Google-Smtp-Source: AGHT+IFXp+26yCOoLOpCkwrAISkzg74LEy3nMtbDkNz0ybskISntSdYhBYketZUQIwWSWMVvA3nNnA==
X-Received: by 2002:a05:6a20:4292:b0:15a:2c0b:6c81 with SMTP id o18-20020a056a20429200b0015a2c0b6c81mr1938815pzj.3.1697715080193;
        Thu, 19 Oct 2023 04:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709029a8200b001ca23f2470bsm1706154plp.196.2023.10.19.04.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 04:31:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
References: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] block: ublk_drv: Remove unused function
Message-Id: <169771507904.2601781.4738608164721336393.b4-ty@kernel.dk>
Date:   Thu, 19 Oct 2023 05:31:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Oct 2023 11:04:44 +0800, Jiapeng Chong wrote:
> The function are defined in the ublk_drv.c file, but not called
> elsewhere, so delete the unused function.
> 
> drivers/block/ublk_drv.c:1211:20: warning: unused function 'ublk_abort_io_cmds'.
> 
> 

Applied, thanks!

[1/1] block: ublk_drv: Remove unused function
      commit: 411957553bca681f6c6a64f419c352bb7d87c2a5

Best regards,
-- 
Jens Axboe



