Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA0811604
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442486AbjLMPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442459AbjLMPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:20:08 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C02AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:20:14 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b7117ca63eso49237739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480814; x=1703085614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v15uYxGg6gkytkWqBGX5C6eEYyMifKma8MdBhOHf7x8=;
        b=LVDqwpXU7wvdPvbyla3Ud/xuqvkGtl4867QSTBmnmBhTJw+3xdj5iXTBF7fLgmR9jw
         DAl0a5LyfDQGO/d73ysh15X2VQ4y/z64PvBKwc0N1wu8QVrANSobuyWz/EuS04DXQvJ8
         KURbFs6jwRmLYxc6D5v07qXOzMeujRXQJ06JQPv8QzAsJQwNps1i8hoxdjKZiWDTKTXX
         3BNaLUdiAX2CzPEuyb5yiuq5iWXqNGIOxaAHcNmLThGJB4p7m4ynhSjrl84oCrnaQxSt
         WYhq+1OpT6eI/rHe+f+JcbXu382wmabhxT38TRzx1OuBiIHWVLXsRz8yjR0WakuDnmGh
         AtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480814; x=1703085614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v15uYxGg6gkytkWqBGX5C6eEYyMifKma8MdBhOHf7x8=;
        b=quWr8KbYUHNrPBMulC3woKV7sqCnGwedQstPE+Rf3iq4gwP+RuTqI6NhHCk9RYEbGP
         VOYLljduH9PhKkVWaZO86LL2FWo+7wVZj40phiry6xixe2ZlSPHxBXxD8bPFVoKo9bKP
         TLs2vg4YKEh+AOdnvgaTpWChX2a0c4bjtZ61g7YPLt7EqkW8CKX/X2KTw4QASmL1v6+J
         U2NfSom5dKI6BMgp4LbpGEFY43JsxDI2JggHCGkFGTmqQp52XdCu1uEKnHXLJGulnFCd
         XKXV3ImQKCYxLP40vsDKQMSCDQuVjFI2RUEucFqJ9vyxrA7w1Ab2POXbOlnTy8INHpFV
         U7yQ==
X-Gm-Message-State: AOJu0YxiTP+GAuQGayZYL65tYdh4W3+fdBfTa2gixlE1JnR54atCEau/
        w5DG3wJaMzj4HZRg3zEdoSgLVA==
X-Google-Smtp-Source: AGHT+IF5WQK1UZjrunvvmScqN+py0D//HqewJThVrYQlPIQSuuwNxdHCvFlLtvuWmTnS8JdMpmXDfw==
X-Received: by 2002:a6b:ea0a:0:b0:7b4:520c:de0b with SMTP id m10-20020a6bea0a000000b007b4520cde0bmr13370272ioc.1.1702480813790;
        Wed, 13 Dec 2023 07:20:13 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gj1-20020a0566386a0100b00466601630f4sm2990491jab.174.2023.12.13.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:20:13 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     akpm@linux-foundation.org, ming.lei@canonical.com,
        linan666@huaweicloud.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20231211075356.1839282-1-linan666@huaweicloud.com>
References: <20231211075356.1839282-1-linan666@huaweicloud.com>
Subject: Re: [PATCH] block: Set memalloc_noio to false on device_add_disk()
 error path
Message-Id: <170248081296.44340.16976032771590083104.b4-ty@kernel.dk>
Date:   Wed, 13 Dec 2023 08:20:12 -0700
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


On Mon, 11 Dec 2023 15:53:56 +0800, linan666@huaweicloud.com wrote:
> On the error path of device_add_disk(), device's memalloc_noio flag was
> set but not cleared. As the comment of pm_runtime_set_memalloc_noio(),
> "The function should be called between device_add() and device_del()".
> Clear this flag before device_del() now.
> 
> 

Applied, thanks!

[1/1] block: Set memalloc_noio to false on device_add_disk() error path
      commit: 5fa3d1a00c2d4ba14f1300371ad39d5456e890d7

Best regards,
-- 
Jens Axboe



