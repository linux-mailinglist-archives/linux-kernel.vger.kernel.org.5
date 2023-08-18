Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BED7802F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356846AbjHRBQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356866AbjHRBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:16:06 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E94219
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:15:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5657659a8a1so81288a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321310; x=1692926110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0OZI4NJnVebNM6+xyzwnKsD1iMAOA59kDaPSqooa2s=;
        b=o63LFo902MW3jOMihEhTthkAapz32a8B14io7B4LRVjqDuG13Ue5OxpXnJBUZGVnyG
         03RA88lMAR6UKQX8vGB8lj0F+tLePgx5ynoUORrZAD4gY//TsVr38UUC9Z3rpPKj8JQ4
         Lt2gngGzRIE7p0mXq4yTNP2tRoTWKjfs0Ncp8lPvTnaz0WT/ZRucUlCIWeutorLT8uQS
         YqzndBepB4nOWt85vsREbBi/5VuL0m95ikk1N4tNtynrlrEixZ9SCMAXKFQmAx4trnWQ
         BH8LNsc/8cHblRZ8LRtHSkm+6meWhuMs/a63NmbNMPyKyf2OWcfJV3u9ElV1sOOWVXqt
         urfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321310; x=1692926110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0OZI4NJnVebNM6+xyzwnKsD1iMAOA59kDaPSqooa2s=;
        b=KRUCs0zaVIUXMhPr971Xvdvaloh+xP+T2Yy9rJxkGRE75qTtZAYBQTlFdhhyAxdPHl
         RiqJU9iLZNNzkhi2OpiKqlnxBgEhFCIICd7ynX8CRvpNEgZl7dnxhGZTvRTsYssigGTc
         UhXn96Hcih+sWT7zTACNnjle7AQq93t83RMIA1ALePk8L6vgKaDFIEEw6auKpkdZL4P3
         tWka8hPVwF23QGkwugR6Mbl9aDs65+2tQBYno4WaUuI3QjWTIyWkJSssJxVKesDxsruJ
         QRoiCpf4QZfmPqO4lpgtzT9JaEMglNQRvEIWIz5OEoI0AhDGvdTNCWXhEbMEKOqb0t5O
         /jGA==
X-Gm-Message-State: AOJu0YwhQOficW/fpaXV9UHBu5rSyrl8A6TK8PmemjQElcwnEL+q/Hek
        yBwO2E38B+QZ9QDMqGeqFSW4xg==
X-Google-Smtp-Source: AGHT+IGQubHAAfLcM9gFxNKvlfXNaq4wEeNmXlj6d+JqwuLxwHoSVzghFX4bWwVbT5cYfcDW4zVlnQ==
X-Received: by 2002:a05:6a00:1d85:b0:681:9fe0:b543 with SMTP id z5-20020a056a001d8500b006819fe0b543mr1234120pfw.2.1692321310699;
        Thu, 17 Aug 2023 18:15:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7800c000000b0068842ebfd10sm358490pfi.160.2023.08.17.18.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:15:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230817212146.never.853-kees@kernel.org>
References: <20230817212146.never.853-kees@kernel.org>
Subject: Re: [PATCH] io_uring/rsrc: Annotate struct io_mapped_ubuf with
 __counted_by
Message-Id: <169232130924.700993.10043093294166679219.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:15:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 14:21:47 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct io_mapped_ubuf.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: Annotate struct io_mapped_ubuf with __counted_by
      commit: 04d9244c9420db33149608a566399176d57690f8

Best regards,
-- 
Jens Axboe



