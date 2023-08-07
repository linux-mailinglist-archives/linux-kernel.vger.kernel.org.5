Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794617729DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjHGPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:54:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31AE5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:54:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40ffc70e740so12598721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691423671; x=1692028471;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KusBc1MOLFVLMeaFqGP6mul2FFNA4ekLWslSKlfhILQ=;
        b=I6baKaYbf/fDpN5Jh9iHfbtTyr8EGOBEV/wOPCt7OIyqKhj1kbQvTc/7h7u/IA16mX
         bSZ+s4/bF3paUPgha+qWiZNqwuUzEE5qw2fR/I4WQj/nJUS3jcBUgH91AJk22Z12jWwS
         PCxBGQvzjlz0zD60ytCWnXQ/GsHGKq1rWrwFdUWnf/ZbYWatB2iZWRZGtE5eXYomVjp3
         0/+Dw8W0ZQyJ4q5uGBnrAEDGWFe0deicGtq81XI31G6xqCT5ZQB3kuRpqwsIrKebOWVA
         XZLh4n0T1lViYSIOIFptXj9RADbdowtvyO3jV3DEQNekG2ddm98CxJBU2dgDhC0/yWMs
         EHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423671; x=1692028471;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KusBc1MOLFVLMeaFqGP6mul2FFNA4ekLWslSKlfhILQ=;
        b=VbwT2L9+0YiFGcCAZQEXYgpB4HbCtISos5sQIV7HtfBvzju/NVyWWnG+REgFZL3FiD
         TCnkZ3KHkjwAauowYA2gACw+MWcrtbe7YOtcbW5Mf1Wzbl0GBJ4KpTf0RRyvPp1IwFzJ
         /05XgZj2IdUGRArWqvgp7eLSZGwEHf5wU3ZCWQ0ZPCcW9HMB72lM6So5SxP31tGYvihe
         jDbRbqUF+FKBXG+6L6gq2U25PUliPWNESaLG9cx3bf/2qgAKbeA3piceGFEBqOuRSt4q
         TfYVfjYKGq6HmFXSV4TxY81T96DbW/iRftEASIVurgGy1P6Ru+wvBKmxR6EUqX8Wz11V
         AeGw==
X-Gm-Message-State: AOJu0Yw4IKbCGR4QizwXf6rpudww+iB+1d+z5jJD4rRi25vcYyxK9T7c
        pGwq5G94tPoqBUkC1hnty9WmIpPaDqUtCwj3nTXCgpouTTk=
X-Google-Smtp-Source: AGHT+IE/Z2VeaVn/3kIjXnWgBYnH25cvcmh5tPz+0iJ41Zsg6gOj4awz4i5C3cAcFV+6jauNpu0+YZX1CXXhEjrylIA=
X-Received: by 2002:a05:622a:1388:b0:400:938b:eb0e with SMTP id
 o8-20020a05622a138800b00400938beb0emr11140877qtk.43.1691423670624; Mon, 07
 Aug 2023 08:54:30 -0700 (PDT)
MIME-Version: 1.0
From:   Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date:   Mon, 7 Aug 2023 23:54:20 +0800
Message-ID: <CALf2hKtDJGqmsiSykbX8EEfbthwt6a4Bs98m60dUkS7URW-C8g@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in radix_tree_lookup in&after Linux
 Kernel 6.4-rc6
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a KASAN: slab-use-after-free Read in radix_tree_lookup while
fuzzing Linux kernel 6.4-rc6 with my modified syzkaller in 24 July.

The report, log, and config can be downloaded from:
https://drive.google.com/file/d/1KiZCUHEyp-_Mbq8wdXvjPLs6KU-12JwM/view?usp=sharing

Here is the bug-related key info:

BUG: KASAN: slab-use-after-free in radix_tree_descend
lib/radix-tree.c:87 [inline]
BUG: KASAN: slab-use-after-free in __radix_tree_lookup
lib/radix-tree.c:764 [inline]
BUG: KASAN: slab-use-after-free in radix_tree_lookup+0x12d/0x290
lib/radix-tree.c:817
Read of size 8 at addr ffff8880675ab1a8 by task kswapd0/88

I have preliminarily anlyzed the root cause. The suspected UAF Read is
located in the __radix_tree_lookup function, which is part of the
Radix Tree implementation in the Linux kernel. The condition check
radix_tree_is_internal_node(node) in the while loop is used to verify
if the node is an internal node. However, this check does not fully
guarantee that the passed pointer node is always valid. If an invalid
node pointer is passed to this function, it could lead to undefined
behavior, potentially including a Use-After-Free Read.

As this is a data race uaf, the syzkaller* cannot easily generate POC.
I am still trying to construct a POC. By comparing the code of
radix-tree.c, the vulnerability affects versions ranging from 6.4-rc6
to the latest mainline.

I recommend to patch it by adding invalid check of node in
__radix_tree_lookup, if it is validated as a bug.

Best. Have a good day!
Zhiyu Zhang
