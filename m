Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A108774D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjHHVqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHHVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:46:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC6110D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:46:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bba9539a23so12604355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691531211; x=1692136011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVvoOD3a42GY8Ebmz0RgOSN9u//C9LOSXpl4Qlkoi1A=;
        b=vwzjw4SdDejKeetWZRaBDTicu9grb6ugVg7T8YnuZUbdMLc9dfk1EMR28ENeqt+GpF
         5Rftbu+6VKu4oW+ZTSpphTvNyOs4WfBzS8pdunUrA1UR90wPfLYwrUUpwfE+3LXAJPZi
         //6RRyqPEptBY+xWLXIGTNZlhPmvBI0xPp6Ep7MQ+0r9HOZxa9TrayL3wT56TrFxqpC7
         HIhArHuxT/LqzgRoWWDriK7Xhw47A+R8jvgfLMe44CV+MAQ05uet7T/RxO58soSzeFPY
         gI/ZdmtovekPQBX/fxueb59ytj+PV2hGQJMaanSIemuwCUQAiS8sBVPeKddRIzQVpBFr
         zzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531211; x=1692136011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVvoOD3a42GY8Ebmz0RgOSN9u//C9LOSXpl4Qlkoi1A=;
        b=VaUZ5gy/x+/8lq6gj0yFxzfdV2he+U2qTGGXbTxBa0c5hD5apg0fAGRXuFdp3ElYJk
         cCubswpFnm5om3YEqnLjzObGkGyu1xdG7LLi27ii8POI5te2L6/DFM0PfZUQscKybxwF
         V5mnkFbyB7oKOYdWcnxxjkMHJzmgbsj1aZD6qRJzLFItIgq/QFdDIr3b9SNWZjr009Bd
         zgNhWcitjuXF6visOndRi1XXC6o+ASmnHXtyUh8wSrKzfvJVraBc53Pf77CZSkuSXwOI
         hLg5nDGdrRZeT5GdJvDBo/oeyY5SauHkfr4VdEa984ZHwja1fMqnqYaQf49F560vxuKz
         ercg==
X-Gm-Message-State: AOJu0YzGydatLyCwXFzRbdbJJJ6ggA+RSCJ7taw/wHLY4KVn0++Lr2Lp
        oEoJ7JR97Qf4E5xYniM6572l/D0THikFrnwWU2s=
X-Google-Smtp-Source: AGHT+IEBaw5bcF1S5gfk8OAPjNSNb32ZmPfHsUgxSa1VUvAiECqC/ErJwgsi0eVABsUaVuyoaxnLWw==
X-Received: by 2002:a17:902:d2c2:b0:1bb:83ec:832 with SMTP id n2-20020a170902d2c200b001bb83ec0832mr1035725plc.2.1691531211359;
        Tue, 08 Aug 2023 14:46:51 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b001b9da8b4eb7sm9476577plk.35.2023.08.08.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:46:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org, Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        niuzhiguo84@gmail.com, hongyu.jin@unisoc.com,
        yunlong.xing@unisoc.com
In-Reply-To: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
Subject: Re: [PATCH] block/mq-deadline: use correct way to throttling write
 requests
Message-Id: <169153121035.141127.745815954316396191.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:46:50 -0600
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


On Thu, 03 Aug 2023 19:12:42 +0800, Zhiguo Niu wrote:
> The original formula was inaccurate:
> dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> 
> For write requests, when we assign a tags from sched_tags,
> data->shallow_depth will be passed to sbitmap_find_bit,
> see the following code:
> 
> [...]

Applied, thanks!

[1/1] block/mq-deadline: use correct way to throttling write requests
      commit: d47f9717e5cfd0dd8c0ba2ecfa47c38d140f1bb6

Best regards,
-- 
Jens Axboe



