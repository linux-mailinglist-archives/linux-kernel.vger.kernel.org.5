Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A56F7F1996
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjKTRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjKTRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:17:02 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359FF4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:16:58 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b05e65e784so30930539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700500618; x=1701105418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB7WfUEEaC1OvWTSK9npq8Mo0A16SnQAjvLM/HQZZuI=;
        b=yN5USrdaPRXPjFWxp8LhHRkSO+u4XLdXKwx8rSdK0XlHlCLn1f54W5Non/Az60nNVX
         wBMN0jhJC0IeSlJXHOcZ5sTrg2zlBvhqiq76hmT3g001iGIQd4Ep0lKPlTfWvdZZ/ZK0
         wc6eM+yzmWeiIDDMem2RUIogDh+KeU5xkyZCotXAKWkbNQD6F5tdSCr74PzL3AFslVat
         Hl6CD3KO0yfcHwAFSEJEjwSF6o1tVNC8SzFMx1bvwToM5xpS+4kUzaeE2Arpv/OPJcVS
         IgabTeJGLDmk7KgFlMRVTqGLR+ac6dMBHtq0DWp0B9/9FwTkWbZoNTO02XigWlQmgGxk
         41ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500618; x=1701105418;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eB7WfUEEaC1OvWTSK9npq8Mo0A16SnQAjvLM/HQZZuI=;
        b=drw3AskiyT3fBtPBEY17TAh0mXm0xlT7iajpngGyzsqj2HRXK0NLiFYcvZLRhQcrzY
         E3gRjFISUmO0vqSQFuoXws96c+visZMhUGAqK3vGEm56tfxEzYW2ysOW+rbxb/dQgHQU
         nOWKpwXPsmMZJbr0X4v37NKlsf+rVNUm4blSaVFVr++Z3dZbRAWE9i7xsbbMyHx0bOnJ
         lukctDl0qPDzyA2L9QrJDRaycIPoKSjJ9UTjYJ0D/2he27sQc3Eer4r90K4TWcLLOnkz
         5xEGO45Qs8ZFAZwSHCuHBkkbTd1c3SRllGwkO/GvEoMV8fMsVHzq1Id+21pr8lTbtv0/
         kcDA==
X-Gm-Message-State: AOJu0YzgNsmhJiMn1phJ/ys917jUZe/VnZjLFDhz5Up/JFvsoVPYiliL
        8m+ohcS9sauEtIXk4hB/vYyYpA==
X-Google-Smtp-Source: AGHT+IEIoY7JzwmmB4jXQdtkfpQOU8uINar07von849M9jzHSJ+h0OJXJMILhL1W2qbS/ovZ+3bm5g==
X-Received: by 2002:a6b:fc0b:0:b0:7b0:7a86:2952 with SMTP id r11-20020a6bfc0b000000b007b07a862952mr7278834ioh.1.1700500618197;
        Mon, 20 Nov 2023 09:16:58 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ds21-20020a056638285500b004645a5d3b13sm2110468jab.19.2023.11.20.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:16:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, linan666@huaweicloud.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
In-Reply-To: <20231116162316.1740402-1-linan666@huaweicloud.com>
References: <20231116162316.1740402-1-linan666@huaweicloud.com>
Subject: Re: [PATCH 0/3] fix null-ptr-deref in nbd_open()
Message-Id: <170050061729.96172.17600082878837866184.b4-ty@kernel.dk>
Date:   Mon, 20 Nov 2023 10:16:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2023 00:23:13 +0800, linan666@huaweicloud.com wrote:
> Li Nan (3):
>   nbd: fold nbd config initialization into nbd_alloc_config()
>   nbd: factor out a helper to get nbd_config without holding
>     'config_lock'
>   nbd: fix null-ptr-dereference while accessing 'nbd->config'
> 
> drivers/block/nbd.c | 82 +++++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 29 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] nbd: fold nbd config initialization into nbd_alloc_config()
      commit: 1b59860540a4018e8071dc18d4893ec389506b7d
[2/3] nbd: factor out a helper to get nbd_config without holding 'config_lock'
      commit: 3123ac77923341774ca3ad1196ad20bb0732bf70
[3/3] nbd: fix null-ptr-dereference while accessing 'nbd->config'
      commit: c2da049f419417808466c529999170f5c3ef7d3d

Best regards,
-- 
Jens Axboe



