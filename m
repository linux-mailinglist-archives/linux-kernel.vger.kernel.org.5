Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268507712D3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 00:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHEWNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 18:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjHEWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 18:13:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FB10C9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:13:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7dfb95761so5452825ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691273616; x=1691878416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfoCc+RvjV+g+GLE3LFiITYI1ax4E6KyrUn9GtTQWKU=;
        b=Y2h94PojIusanzrjPBql/8LV2CORjY1s6biXpvYlWwZA1L/KDwvg8dvBt37DG0mzpN
         B7dt7VojBlYTaPOWjlaP5esyiMkVGFyQucBOPNHcvfI5nN80tbVha52gvGMx6PAuPB0v
         I3ysUBajJcS2F0UybgEkEiBJjjMbxn/id96mFIOfl5hJoI7YRXvhcLxucQMIm0/wWZ4U
         62tdfCNAIwzXEP8CaXC1q6uZg7CyC9VldzoAzQ5L2RoFlI9z8xHcM33mXz2xZvpT/pLI
         bMh/CR95r3UXAc39JwJxAjYlje52Q/t6RStTV8BsBBOms0Pux+zE5OS5TEZW6fN55YhK
         +zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691273616; x=1691878416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfoCc+RvjV+g+GLE3LFiITYI1ax4E6KyrUn9GtTQWKU=;
        b=KtL91fWKsYl0n3b5zrR0W/GBNhBz1cUP2Cxx4BXS+oryAi3KRnLVdxxBHADOM6GgFv
         +sc6tNofpQnkmBmAUV3Av+/Ru/MozMIRPQoQJ0dsPX7ZObKla44OTNK7Cvmu0bNVENeX
         oV/wM8ldAWk7E950ArWZyg7xfA251okCQg9UqkM3Uxfh4yTFsm0OsMoUE63Fi1LA/cXT
         in/8MupeDs9Rg1oFWf9301Z2ZBSM2b1o9hwTAdJnoEYSkW4OLbvcJR5u5kcdnQTxB2XF
         GrDwUSwsZikF1B29km8r+5FELIdA1tgsWbV8J6s1gRsGM4H9paBLJ0T0ykfYUApna5Tk
         i90w==
X-Gm-Message-State: ABy/qLZ3jJ7cS8E9YB3XRhG8/Vf+2+/VZIhBxv6/PInwQyxvRh5ENgdY
        Rz1sKlG4Gq1+McxfI2Kqbm5RaA==
X-Google-Smtp-Source: APBJJlEv8pHOH7HWV+MOVitX5Kxcf06soD19PKjn8qyNH4ESUwUgXVaV/O/MtzWWKBI09ZRESJ80Tg==
X-Received: by 2002:a17:902:d2d1:b0:1b8:ac61:ffcd with SMTP id n17-20020a170902d2d100b001b8ac61ffcdmr28867244plc.3.1691273616618;
        Sat, 05 Aug 2023 15:13:36 -0700 (PDT)
Received: from [127.0.0.1] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001bba1188c8esm3929244plj.271.2023.08.05.15.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 15:13:35 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     minchan@kernel.org, senozhatsky@chromium.org,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20230805055537.147835-1-hch@lst.de>
References: <20230805055537.147835-1-hch@lst.de>
Subject: Re: [PATCH] zram: take device and not only bvec offset into
 account
Message-Id: <169127361527.13732.4190461845439151626.b4-ty@kernel.dk>
Date:   Sat, 05 Aug 2023 16:13:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 07:55:37 +0200, Christoph Hellwig wrote:
> Commit af8b04c63708 ("zram: simplify bvec iteration in
> __zram_make_request") changed the bio iteration in zram to rely on the
> implicit capping to page boundaries in bio_for_each_segment.  But it
> failed to care for the fact zram not only care about the page alignment
> of the bio payload, but also the page alignment into the device.  For
> buffered I/O and swap those are the same, but for direct I/O or kernel
> internal I/O like XFS log buffer writes they can differ.
> 
> [...]

Applied, thanks!

[1/1] zram: take device and not only bvec offset into account
      commit: 95848dcb9d676738411a8ff70a9704039f1b3982

Best regards,
-- 
Jens Axboe



