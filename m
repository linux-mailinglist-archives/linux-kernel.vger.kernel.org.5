Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91757774D47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjHHVqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHHVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:46:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F52E72
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:46:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f74a8992so873617b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691531167; x=1692135967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufWuCKJ0Egs+nu6uKEsjf2MM+Il03RPk8D6z9LZXuM0=;
        b=qLwewUrX+FYlxFdmr9x2SVRkFYsJPZWlsvn0aR5S8y10rD+eTmJwvEtnYcx9VMSGHA
         kWrqoIail9KKc10CDeC5lPUYZHlQMdlMnjwjcQV4ETMTYPMLGan1lY3mE14BvOAYCoRe
         238uysRjvclQGaTEAgiFNbgxHyQKAM/1xyABWOeXoBPeyZ4m8x76CUHxT2bMJZct8bk+
         AkaB9D4JoA66bsVLAgaDp7JoNAkh7MFO7/vELWTtDdfSW9iuy4IqKbOKb8jgi4HgMKlP
         /pBnJNMXnJO0w4+y6d3deb0B/XM72MLFDa62F8sBbUivPUlJXjAs7g/g/GR51XaCslVb
         /AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531167; x=1692135967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufWuCKJ0Egs+nu6uKEsjf2MM+Il03RPk8D6z9LZXuM0=;
        b=WddOjRRmTgmfCaEnU8hVBOU+jjJ79YKF89ZAQ1vHHATl/sX/2DoZsFz3CkD+/QFEQV
         lAc7XIh4yyPiG7SaU7vNgpOlsMayoNrBBCrS21zfPqg5HjbpNELtzh0KI+1fakf5vPh1
         dwCBw012FQTMjJBMKu2ySAgux9oZp57BSJruffx2iHeqEhSEbA+DgMWm1H//bWOxvypc
         +OzF0qvUJOzd18are5cADGgoX3uk3HmujTaWHtj32/yWpzp9EeIfA2m9q8tqIIfUKD0y
         +dHdAKzYXJMzrOjYj8xwods9RC/+mCAgmUpYM1KRjawyQn9bDiuVwMVkpagzBskk/UVV
         YrJA==
X-Gm-Message-State: AOJu0YyqwpiFgASsJjAEdxPYhwDr+mdLF/TigRvXe2nE9lAsiDDGWU50
        D6tJ5F32syjk5GjKXgL6FlvVCCC3B42F5UEzzqk=
X-Google-Smtp-Source: AGHT+IHkGwK2VLiIPMa36nJ8CbMNcef2T8B9k+5PkKB+SYwXOHjwO7V2CUI4EK5q5UWOO+ObeACVbw==
X-Received: by 2002:a05:6a00:1993:b0:687:8f50:47c8 with SMTP id d19-20020a056a00199300b006878f5047c8mr837042pfl.1.1691531166970;
        Tue, 08 Aug 2023 14:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b00687dde8ae5dsm459819pfi.154.2023.08.08.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:46:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, chengming.zhou@linux.dev
Cc:     linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
In-Reply-To: <20230804065039.8885-1-chengming.zhou@linux.dev>
References: <20230804065039.8885-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH 1/3] iocost_monitor: fix kernel queue kobj changes
Message-Id: <169153116618.140710.11864952365847342577.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:46:06 -0600
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


On Fri, 04 Aug 2023 14:50:37 +0800, chengming.zhou@linux.dev wrote:
> When I use iocost_monitor on nvme0n1, this error shows up:
> "Could not find ioc for nvme0n1"
> 
> There is no kobj in struct queue in recent kernel, it seems that the commit
> 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
> move the queue kobj to struct gendisk.
> 
> [...]

Applied, thanks!

[1/3] iocost_monitor: fix kernel queue kobj changes
      commit: 2eae9c4912b6cfdfadcd4fa8ac26879e18a504a1
[2/3] iocost_monitor: print vrate inuse along with base_vrate
      commit: 8e93c1acd15e6a754c19ef12f6e69641f37e267a
[3/3] iocost_monitor: improve it by adding iocg wait_ms
      commit: 68392b002023cb6dadd3d5044268470a7201b313

Best regards,
-- 
Jens Axboe



