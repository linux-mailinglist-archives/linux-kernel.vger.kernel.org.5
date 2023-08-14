Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607FF77C28F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjHNVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjHNVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:42:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4112E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:42:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68844c0af5dso110936b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692049362; x=1692654162;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrArp5hxpkdgjNK8gMpBHma1X/irJT/bwo2nrrap7jw=;
        b=1/eIPU/Beo3pGB8oRf7iueZnFOu64es4saACfGEmGsl8pg9E1w29PMb9sFRMwL58X/
         jmRPocTlbnFeY9iWpJvbRxnEhBVyrXRKM5g+TqSgZabP5oOx/ao09eZ+9pN0NGBaK2B4
         bBm78X20IRdYe34mR25Q321/hGEJoxmJSdECaWAcz6y8b+lO5KSvpfiCQL+Rez8EflJW
         gkYp2D+fF8in0X0KmBif9aKIQo7Q9nCFMYbKIZI9iwI6yYSuVHleE5qBcedgsvM4thRv
         q11HFRYOA3NqGuTW8GZM3m7m1YvsvNN4jiIdbdkpMaGRUoAqLjNxcGqxSTxIzTUx1itm
         yfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692049362; x=1692654162;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrArp5hxpkdgjNK8gMpBHma1X/irJT/bwo2nrrap7jw=;
        b=JoLKQEnWMsQzMKUdOyW/IXdXTAojVNzATusHihHb52vYBwIxKJ4gniIigvk1MGjbdS
         FsRsFaeaCN62x+IG0EuBqlw+gFgayW82wrZomoqTTX/eWsLRq19Mm2y9nlVYFk017pLV
         /84MYB7IqnCYq4cxcKNm25E55DWuIkdwqFo2kRbbfex8poH549t6pgIiHSchJeW/E0FQ
         OOGlDYZ3Ejv3qHkK5GC5M1fQ4u90Q9Qt8YCrxkPCdVA7IRkkieUXYepE6phGrAZA1d7P
         mWWOk6TOCKLF9jCvQAuBrvX/W/mHJ/V1rPgtOmzdfgbqUuw2B+Su6zlQ7xka6CVpkXap
         ECwQ==
X-Gm-Message-State: AOJu0YxeJjJfjKVGzOar/qaklpNhbFLOBf9T5HCHQkqiSHYeHY+VDZWv
        TitYUO3E/Jn2YJW6FyJkf1pDzQ==
X-Google-Smtp-Source: AGHT+IGWuKZrXvXNXMNbLK8XyKtfWy2Dj8d1s/Exg/N4xSpJ2YzMptutmIEe4694RskKGx76/2Mf9A==
X-Received: by 2002:a05:6a20:729b:b0:134:d4d3:f0a5 with SMTP id o27-20020a056a20729b00b00134d4d3f0a5mr15183457pzk.2.1692049361961;
        Mon, 14 Aug 2023 14:42:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b0064aea45b040sm8322132pfi.168.2023.08.14.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:42:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, chuck.lever@oracle.com, chengming.zhou@linux.dev
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
In-Reply-To: <20230813152325.3017343-1-chengming.zhou@linux.dev>
References: <20230813152325.3017343-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Message-Id: <169204936048.419413.8584205428292895580.b4-ty@kernel.dk>
Date:   Mon, 14 Aug 2023 15:42:40 -0600
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


On Sun, 13 Aug 2023 23:23:25 +0800, chengming.zhou@linux.dev wrote:
> Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests").
> 
> We analysed the IO hang problem, found there are two postflush requests
> are waiting for each other.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: release scheduler resource when request complete
      (no commit info)

Best regards,
-- 
Jens Axboe



