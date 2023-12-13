Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D98811607
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442493AbjLMPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442498AbjLMPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:20:11 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF14A111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b05e65e784so59787639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480817; x=1703085617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=BeyLrSX1t2fusOTEW4Z/Jp9D0CCDHU/5SDqnfDRxmdZkzJQ0mn/o1i/wX+HUmqdywG
         VoxYHcN2CatjZG3wIt7ZWexen18me0u46jcoqYURbUX9FKR3FUeSxjbpoO8NP8NzPZlk
         +AMNbEEJcaFg225avSS5SzoJqGeb8ABcZYlZEEeXaQ1Y1sTAPlz+aaq68Qoofvpnloax
         4VfPkN6kUNR0wbH7FaBXrUVQR8kBKzZEEKIEnlrZCBQvhRpRsgWQbvMVmwqaBBaQChBI
         ZPN+m1bTosb1VXON0VGblAcjeXki4uMyTT7xpJN0YtJ96a5YM4N90o236tE8KuU/cRcG
         AM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480817; x=1703085617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=Hvo2reQ3H4RAE1ozLD+dFPdaKlS6sQKLYd+KNK1zUxpMWK4hkukDKVBppqlSvcRgt+
         J9RG8W5p2mja0HPzZvaf2fqMCurcA7Dy4YWGTZcRNokaXiBwq0LowZ85rO2Vfy+swObe
         h+22ZyzboPevyXxKgSY5/RJBTNAGbMx3Brmn+rJLQaZYBAiXF3+GUwgnkpHElG8DTUoC
         ENv96CGsQ0bJzLMaGVrg46DJqwG5ROQbodmu0ZyFonvoBJKlTXNOmDuPec8kwd//HhLi
         oXZ9eVhxdfzJ+igNguP2Bu8QCjrLxxodJNUfC5q2JhrWsCfFDbPNbLegNPN1TgHWSIa+
         UElQ==
X-Gm-Message-State: AOJu0YxA6HjCqoqdkN1gDTSncqMDFEYfixajnFVYOWjbxunSPUZtbEPq
        DBTRb/pra32HfzUennk5BB/Alg==
X-Google-Smtp-Source: AGHT+IGY0kHOkIzt6H+QWTL10izoHuOyMzxLzV+feo8HGgLLYqLqoUMAAYk3po1dYDle3iKyK7WuqQ==
X-Received: by 2002:a05:6602:b90:b0:7b6:fe97:5242 with SMTP id fm16-20020a0566020b9000b007b6fe975242mr14827360iob.0.1702480815144;
        Wed, 13 Dec 2023 07:20:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gj1-20020a0566386a0100b00466601630f4sm2990491jab.174.2023.12.13.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:20:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     willy@infradead.org, hch@lst.de, dlemoal@kernel.org,
        gregkh@linuxfoundation.org, Min Li <min15.li@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20230629142517.121241-1-min15.li@samsung.com>
References: <CGME20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1@epcas5p2.samsung.com>
 <20230629142517.121241-1-min15.li@samsung.com>
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Message-Id: <170248081388.44340.415544465517225810.b4-ty@kernel.dk>
Date:   Wed, 13 Dec 2023 08:20:13 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 14:25:17 +0000, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> [...]

Applied, thanks!

[1/1] block: add check that partition length needs to be aligned with block size
      commit: 6f64f866aa1ae6975c95d805ed51d7e9433a0016

Best regards,
-- 
Jens Axboe



