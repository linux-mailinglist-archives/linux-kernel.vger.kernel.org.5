Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53837FA5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjK0QM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjK0QMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:12:24 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915A99
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:12:31 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b37846373eso28121639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701101550; x=1701706350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvB7rbddcLGLArA7MqLyKH3GIdpZuBsbhH9RHUl0sM8=;
        b=fS/4jveW7ONuSpqHQD2CZCgNBuOihUISIi92yOFVBkfQWg4XyLhqEUGEOmtLVDiDkg
         PhRkXqOMAsJHkGqOz9F7S0J7Y9naw24pww2KOSEY3XoMGcmd6CKfoYrP7OmglHxTfLUP
         kgeE9W4um/AorvcBTB34RZLpEqLSSSiiYJzVcEjymxZHW2zTn1V/cgm1QhaFxjoxXyeG
         1+h8zUrcgx/3PlFBER3ONH+tu6kBdE8SZDZnV1C8TLQogXmV7rNI2YyePXKOrFHor7HV
         fcfPVcZpQB0nf8U36QjnyHlZP0ecaDggyGnbSZE6hyCYpBnem7TpK9UrIGPmCyauhtn+
         ckxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101550; x=1701706350;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvB7rbddcLGLArA7MqLyKH3GIdpZuBsbhH9RHUl0sM8=;
        b=txKX0Prd+OiDD1E8QkVOPkvprUDdaveR/jQZ7hD5V3jWz7OPRPpnt027kghetWi3Gf
         D5NyamemN3LSBnSKFYNX5bvcUUtZZrQQpoJh62FNP+w8Ny2f9Q1F14bX45AliO+0cfZv
         ptKIIP2I+uGjQqNCDVAB3/MKnMMMdqekPvY0w/XNi17dNH09G0TzfYHXvLE5Ko9zkrTn
         8Wko2LMq0n6th9Nf78MKvYEmz47XOWqLsySF04P3Q2pjGTRvwn3+gz7mwx5XUyN6Qmrb
         dS4rnZMTm//NuxLBGHBeRe+so/oDp8bGT0iqbjvAAdF9cpu7qkCxsB0wvxY6yRxrk7AY
         hk+A==
X-Gm-Message-State: AOJu0YwcXyO6sNLbl8hP+jyEekpF7i/jGyjazrgwZKCz9LdjOJcRuVdy
        LMgZVJE1tpbB9iX4gi5nWfkwHg==
X-Google-Smtp-Source: AGHT+IG04eTzzicBywjmAxWaoEJU61uSxMw471TKINu23Lw+T9NqHOZNLbrFo4J4Xa2OGDDQItWp0g==
X-Received: by 2002:a92:503:0:b0:35c:acbd:3d3e with SMTP id q3-20020a920503000000b0035cacbd3d3emr5168491ile.3.1701101550317;
        Mon, 27 Nov 2023 08:12:30 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r15-20020a92c5af000000b0035ca20fc741sm1338589ilt.70.2023.11.27.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:12:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bcache Linux <linux-bcache@vger.kernel.org>,
        Markus Weippert <markus@gekmihesg.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Zheng Wang <zyytlz.wz@163.com>, linux-kernel@vger.kernel.org,
        =?utf-8?q?Stefan_F=C3=B6rster?= <cite@incertum.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Coly Li <colyli@suse.de>
In-Reply-To: <c47d3540ece151a2fb30e1c7b5881cb8922db915.camel@gekmihesg.de>
References: <ZV9ZSyDLNDlzutgQ@pharmakeia.incertum.net>
 <be371028-efeb-44af-90ea-5c307f27d4c6@leemhuis.info>
 <71576a9ff7398bfa4b8c0a1a1a2523383b056168.camel@gekmihesg.de>
 <989C39B9-A05D-4E4F-A842-A4943A29FFD6@suse.de>
 <1c2a1f362d667d36d83a5ba43218bad199855b11.camel@gekmihesg.de>
 <3DF4A87A-2AC1-4893-AE5F-E921478419A9@suse.de>
 <c47d3540ece151a2fb30e1c7b5881cb8922db915.camel@gekmihesg.de>
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
Message-Id: <170110154924.44993.12405607589120929041.b4-ty@kernel.dk>
Date:   Mon, 27 Nov 2023 09:12:29 -0700
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


On Fri, 24 Nov 2023 16:14:37 +0100, Markus Weippert wrote:
> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
> node allocations") replaced IS_ERR_OR_NULL by IS_ERR. This leads to a
> NULL pointer dereference.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> Call Trace:
>  ? __die_body.cold+0x1a/0x1f
>  ? page_fault_oops+0xd2/0x2b0
>  ? exc_page_fault+0x70/0x170
>  ? asm_exc_page_fault+0x22/0x30
>  ? btree_node_free+0xf/0x160 [bcache]
>  ? up_write+0x32/0x60
>  btree_gc_coalesce+0x2aa/0x890 [bcache]
>  ? bch_extent_bad+0x70/0x170 [bcache]
>  btree_gc_recurse+0x130/0x390 [bcache]
>  ? btree_gc_mark_node+0x72/0x230 [bcache]
>  bch_btree_gc+0x5da/0x600 [bcache]
>  ? cpuusage_read+0x10/0x10
>  ? bch_btree_gc+0x600/0x600 [bcache]
>  bch_gc_thread+0x135/0x180 [bcache]
> 
> [...]

Applied, thanks!

[1/1] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
      (no commit info)

Best regards,
-- 
Jens Axboe



