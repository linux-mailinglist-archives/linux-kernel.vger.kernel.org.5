Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2997E4394
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjKGPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbjKGPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:36:19 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395713111C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:15:37 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-671188b2d44so13735466d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699370136; x=1699974936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg4S+iVhN0rUMVVADxU0vILU9b9jVJPj9okuexhI30g=;
        b=ue1+wLQ2GbPHyHRQinwZxkazEkLaj8CFlWrc0G/M19QVkSVDhAYprNB9gv6jktR20Z
         ShAShNLjp6U0JYTa+oOuMCH1ghh70b7Yc1d/wK3r+wyKjSVcpixqwmCCj9R81BDELWr5
         Gl/Y8NTdUfcy42T7Yl/e4gKHKhQNbWTgIYYTHxLlJ+GIB5TMB/8jCq3F38/mz2LU2hYG
         ed5SPhbsqJt3JiTtqCEAKn3kDR6kkBlNoCo68ISDV1Io01x4WuKvdvCXNEE2trGNoIzp
         kUlTKGEtJoqCEYQEbNDQg8QFXbaCBnHRLspUQJtHcRfuhkLEEkUxj0n0P9oImrEMNWUd
         uwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370136; x=1699974936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gg4S+iVhN0rUMVVADxU0vILU9b9jVJPj9okuexhI30g=;
        b=h3tsO40RUXKsZ15vzrIeqgi2gwhrDZMEOIr5zLyWHrAEBGs+rHmuh9vkLSRyA1CLiO
         CsXZfZmDL/lR2o1kHJ5MTRVvH50Dbg4soU2BIU87ektQ7ZZo6IXdl4on7ZM0IRW6aOE3
         HY3UB2K2dNZgj9ZkSDk0hYS0JxZjjDZrC72F8GHBMXWIPwRB2GJkZ3jKTY+5+Fu3RC55
         c1heyLsJFe7x1P2tGGSng8yHeHt0VDOKlKQ1WADVmxzDloso1VHBfDRuLfsyQz3mfSMe
         TnjWxdaw8fu72KafQHikDOrbtH2CpESFZh4I+ZrRGZ0AloINXb8lBwu+Jd9mrei0imuS
         jbqQ==
X-Gm-Message-State: AOJu0YzVqKleJHSewtx6FIOzNAAnUY/lVQbzIP/s1W7O0qYHLkivwLx/
        5wxj6c5qD8+hTFuKNA+EfVB0wQxlvisSGmGGcifo3w==
X-Google-Smtp-Source: AGHT+IHDuUKEORbj6lEnJjXGuGurwm6i9VyeFSTXBHFrMNOF5jjb4rAbhSi5DROMGeR+2/gsXs8Zyw==
X-Received: by 2002:a05:6214:2b98:b0:65d:486:25c6 with SMTP id kr24-20020a0562142b9800b0065d048625c6mr33120510qvb.3.1699370135987;
        Tue, 07 Nov 2023 07:15:35 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c091:400::5:f968])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b007759a81d88esm4215667qkf.50.2023.11.07.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 07:15:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
References: <20231107111247.2157820-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-core: use pr_warn_ratelimited() in bio_check_ro()
Message-Id: <169937013415.545643.10559344267374227650.b4-ty@kernel.dk>
Date:   Tue, 07 Nov 2023 08:15:34 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 19:12:47 +0800, Yu Kuai wrote:
> If one of the underlying disks of raid or dm is set to read-only, then
> each io will generate new log, which will cause message storm. This
> environment is indeed problematic, however we can't make sure our
> naive custormer won't do this, hence use pr_warn_ratelimited() to
> prevent message storm in this case.
> 
> 
> [...]

Applied, thanks!

[1/1] blk-core: use pr_warn_ratelimited() in bio_check_ro()
      commit: 1b0a151c10a6d823f033023b9fdd9af72a89591b

Best regards,
-- 
Jens Axboe



