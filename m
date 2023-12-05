Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6051D8056A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbjLEOAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLEOAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:00:08 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0490
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:00:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce539a8a59so273541b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701784814; x=1702389614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3+bW/v6MDITHt8Ne3kr1yjPs8dFYgDQOcc3i2P9p5s=;
        b=IK66RCqo48j2jMqLh8HwPYD+Vh4aVyf2tZpKo/Y4PkkWdEROQnAMNDpYVmSkgPgZWj
         EUkgf5wgaVShjZQhrCg6Iv1aAiVtT5Re+j7zBO4wQJvQAcyNzHZVaDp6y4O7bVBBCmII
         diX+imgLIdm/wpzU8KO6ol4Cm1WjkrA9HAdOfzWnSKA2GGElTHsWRm5P5B5weL6/WTnO
         ai0h1AzMNtlSG70fsYoHPqOGTOAdelE8f8ADqPNJKwdDrIXhrqnRC/Jx78p3dPahnVlT
         i67V0m9euxvCc/9Dk4/f4SnJH6UYtdltBUvs4pADL69FVFJiWMY7RK8XFHaOgKdOFhrW
         /R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784814; x=1702389614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3+bW/v6MDITHt8Ne3kr1yjPs8dFYgDQOcc3i2P9p5s=;
        b=tvdsWixVSTtJ2dt/CR/8R9YPBlnp8BGHUbQ+ztqUsXgvYIsztdwfHUFmSz/VbRZy87
         W4vpBwmGS54cDwv5/xF2j61QrCKJin0o2NT/xiSJxA4Osk3zbSkyCQFdKIP497QvF+SB
         oxitNqcOPUhUYVaN4qqaMqMbzT3+Z8piE+wlXEtlK1am1zHJDfWLyU3VEIRCP4Eu66Y3
         S9IW9t+1VZX4tGIn0Vz1YO2XTXS7hpZaPJrvw4P+94b7vSSHNW6Arna+gBV67IjMjQYe
         kS8G9rJECa46Qz/2CFwsC+xw+4Cg9O6rlGMCZM+G1webMZyGktCCWv6KhPTQx2ZaaoPr
         SeFw==
X-Gm-Message-State: AOJu0YwlkB+2scqlDxAVeZORF4r02HrH0jY70rmwsoK26tCMmBCne3rJ
        dTRUjOokMlLreBC1LXbBnEmPUg==
X-Google-Smtp-Source: AGHT+IFQjdRBV5sf/JQ4j05zWmrXabqvEORSDJHB6L0Y3ji8r06KlwdZd19ypeLkZuJUH0I1FjzQug==
X-Received: by 2002:a05:6a00:3a04:b0:6bc:67ca:671d with SMTP id fj4-20020a056a003a0400b006bc67ca671dmr42693253pfb.1.1701784814321;
        Tue, 05 Dec 2023 06:00:14 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a62e308000000b006ce6bf5491dsm1406377pfh.198.2023.12.05.06.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:00:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <5ed268d3-a997-4f64-bd71-47faa92101ab@moroto.mountain>
References: <5ed268d3-a997-4f64-bd71-47faa92101ab@moroto.mountain>
Subject: Re: [PATCH] io_uring/kbuf: Fix an NULL vs IS_ERR() bug in
 io_alloc_pbuf_ring()
Message-Id: <170178481260.1425677.4337915769048640252.b4-ty@kernel.dk>
Date:   Tue, 05 Dec 2023 07:00:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Dec 2023 15:37:17 +0300, Dan Carpenter wrote:
> The io_mem_alloc() function returns error pointers, not NULL.  Update
> the check accordingly.
> 
> 

Applied, thanks!

[1/1] io_uring/kbuf: Fix an NULL vs IS_ERR() bug in io_alloc_pbuf_ring()
      commit: e53f7b54b1fdecae897f25002ff0cff04faab228

Best regards,
-- 
Jens Axboe



