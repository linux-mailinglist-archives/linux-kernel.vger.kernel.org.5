Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F53774D46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHHVqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHHVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:46:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E110D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:46:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6879986a436so1024266b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691531168; x=1692135968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwfgpA0q5iaTBOUpEBxbAN7dqDlF1eIK8XtzDLK2LHw=;
        b=jV0xS+l3GV71dqP3Nhb95LNVVItFq29aaqswYJ8OXn91vamWNXOoaFEeRIpn5GH0X6
         erx3U822JsexvvaRKikwZHjTqUI8WQmHazpV/045wqsM8h82rFEJchaym5pxme9BlKkp
         JNcmpF14MpgaTlldPkWBQbytA5YRzwl5sOxKXpfyODXT0VcJK5TyWeu9NEN8SAt59dsX
         btA9f4odc0LxpAG06YX9mLA5mmBOcY3C8GIUbAV11p4+uE0MN5Q/VCcRGKml86MhiMMU
         hgO76O3/JjM5xcEh7YDVqUyVgtueWBFp2cAH4ATPG/OkB/YtQXnvQTOe1M8VgfQetqxs
         zaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531168; x=1692135968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwfgpA0q5iaTBOUpEBxbAN7dqDlF1eIK8XtzDLK2LHw=;
        b=bQOON0/cchcjWcK5wVokakou3ePHqcZZnPSvX4+HBShkNIHxUwTwpXWJH4ZFyBA09d
         5F5WH6mFn7YeBPkrip3Lk2yNpagPG8iZfc2IjQdcqpYLq80hUqli5DzGfzSxWOhmhW4w
         YAszymtVZPc5wZRu6ghNIoLA2KewnE+K3Lvc+Ea2+2BlNl7j7f+Ngo9/qt2mhPo6yxIm
         xS/AFClpS7f6cunk9OGHWNtO+NLt4U0HVsOEBcAFPF4zOjMunNuobTFPlPtSYca0j7Ml
         OfTVQcjM9slnnSMiree41dYoHA5XhqG6yazF84F0Verdij/vkZskupjycRfQ+c4URjRH
         qL5g==
X-Gm-Message-State: AOJu0YxL/EjNIadmmaFIcsCMzXSv0fbpxYSrV1T2NDsXhZn093n80+3Y
        QSc4i9BN3mDWKQprJI7M6rmPr3Y3xBVCS4C9/CM=
X-Google-Smtp-Source: AGHT+IHq8RWRJ6ZFb9EfZ1bID5BejwTL+tXFvnRXAefi/H1WyVxXA9rBf+ECEZKWgXMMCjsI41MPUA==
X-Received: by 2002:a05:6a00:2906:b0:687:95ad:d8dd with SMTP id cg6-20020a056a00290600b0068795add8ddmr878332pfb.0.1691531168403;
        Tue, 08 Aug 2023 14:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b00687dde8ae5dsm459819pfi.154.2023.08.08.14.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:46:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>,
        "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
Subject: Re: [PATCH v11 0/3] ublk: enable zoned storage support
Message-Id: <169153116716.140710.16807799143266719730.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:46:07 -0600
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


On Fri, 04 Aug 2023 13:46:07 +0200, Andreas Hindborg (Samsung) wrote:
> This patch set adds zoned storage support to `ublk`. The first two patches do
> some house cleaning in preparation for the last patch. The last patch adds
> support for report_zones and the following operations:
> 
>  - REQ_OP_ZONE_OPEN
>  - REQ_OP_ZONE_CLOSE
>  - REQ_OP_ZONE_FINISH
>  - REQ_OP_ZONE_RESET
>  - REQ_OP_ZONE_APPEND
> 
> [...]

Applied, thanks!

[1/3] ublk: add helper to check if device supports user copy
      commit: 9d4ed6d46272bb60036a6539aae74eafcbbb3d2d
[2/3] ublk: move check for empty address field on command submission
      commit: 1a6e88b9593b63ccdfe1d84e3f99dd91e4f8d490
[3/3] ublk: enable zoned storage support
      commit: 29802d7ca33bc0a75c9da2a143eeed4f9e99fca4

Best regards,
-- 
Jens Axboe



