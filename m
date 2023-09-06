Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A011C793DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjIFNdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjIFNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:33:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5710CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:33:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so692753b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694007199; x=1694611999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d1AVNOFHn3CVQlqf+iRc3+VoRUq4zvMLJvgQBKxvDg=;
        b=Jt7mcQ7IhF/DJgXtjWDb+uyNBOWMANCt47hePVfclaKDOu/Oi+1uxlYifbjY5D/96B
         VDNghZ+i/sRiHDBMDFaWHceHRmrbBEnYyQ8xJkrcSH8ed7fDVsl4y/+QIrbCbZciNAWh
         EdZiEMPWqo8Y+iTAd6BV13C86yybTv7LQFc2qVnJdi5qyq2/TJibUoyHTsUEnsayECTr
         IGG1Val3hypMCGEHW3ouKqfe15sN9WCsAASE0Ac5EeDXW1FUx3W6lvsV5mn3hZ3jFTry
         h0il9AcnELKa26e55cvxogAdQs8OTrrXBZavx3lGuubEV7bkxbtwCEy/NswJqftIrayA
         QiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007199; x=1694611999;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d1AVNOFHn3CVQlqf+iRc3+VoRUq4zvMLJvgQBKxvDg=;
        b=i4EJU7hePyD3mei9MZhwobSRG9Jd0oGoctG2ANIPs0UiImlc81631MtyiMiLo+/rO1
         Df88luCmUu5jqWGKWSytcjW7JLMbwpbF6yAqNVL2yFujRcL6DeSpRTE7VRaNxhOCkYUo
         +KIfWhwXSUFC7gNqVvQEiRXt8dePoci+eOu5F7q9xhIaeW5oQufZLPvAriDfZEC0xiTo
         ow3cjqpoJb1+raBQcPFIrsdOte6MIF9dTN+ifa6BDOu6T4OzJ157UOVgyTcq5PM+3EAw
         tBoLaQaCeJ9xwgPH88owQYRhlebwzd2RcGifdOe76+ain0QVb8cPhwL0LS0LRn2WvohW
         pjlA==
X-Gm-Message-State: AOJu0YxyZDLH9LJp7WekiTdzPhLjRVuHUeokrMjJSEOTzvCg5AmuhQc1
        2qq+ZClPj8ifQbKn6CCUh+/coARYP3BTw4fd3fXJ3A==
X-Google-Smtp-Source: AGHT+IGi5OBROtUZu1lj7ctF+BKO/WjvIApR6wS2hhjSxwyTHuQMfAXh945M7deKizfytAdi93Ewcw==
X-Received: by 2002:a05:6a20:8f15:b0:13d:7aa3:aa6c with SMTP id b21-20020a056a208f1500b0013d7aa3aa6cmr21240577pzk.0.1694007199312;
        Wed, 06 Sep 2023 06:33:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b22-20020aa78116000000b0068c10187dc3sm10726107pfi.168.2023.09.06.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:33:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        Serguei Ivantsov <manowar@gsc-game.com>,
        David Howells <dhowells@redhat.com>, stable@vger.kernel.org
In-Reply-To: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
References: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: swap bvec_set_page len and offset
Message-Id: <169400719806.700937.1715411703006180940.b4-ty@kernel.dk>
Date:   Wed, 06 Sep 2023 07:33:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Sep 2023 15:30:34 +0200, Christoph Böhmwalder wrote:
> bvec_set_page has the following signature:
> 
> static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
> 		unsigned int len, unsigned int offset)
> 
> However, the usage in DRBD swaps the len and offset parameters. This
> leads to a bvec with length=0 instead of the intended length=4096, which
> causes sock_sendmsg to return -EIO.
> 
> [...]

Applied, thanks!

[1/1] drbd: swap bvec_set_page len and offset
      commit: 4b9c2edaf7282d60e069551b4b28abc2932cd3e3

Best regards,
-- 
Jens Axboe



