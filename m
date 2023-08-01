Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18076B904
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjHAPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjHAPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:49:14 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23C1736;
        Tue,  1 Aug 2023 08:49:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407ff54164dso25956691cf.2;
        Tue, 01 Aug 2023 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690904950; x=1691509750;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqD7HSQGZ6HL3v1M7zQJmJ/TyPFEl9SKUOQ+urkNaPs=;
        b=AK5PSwvtavTCIYKNBw8La7to4nWRZ4YdZoLXDBISFLLn/zgvWaaw7OcLzHAsk400XB
         YVPfijHd0pzVOwlLnO9B9Cc9ErzVngn21mINfxcxmgO63cP5ky3NUDBOAevpSvUroIF1
         05WBu3NlZY5CkKEa6rbhXLQdEUkw7l5jaGOdkZJT7Y99Gb+mVRIlESAAwij/dnQ+ik2T
         lfnGyrH92Pc79u7whLT10WY9b6fs1sVAvIO+wO/Fmoa49VNe0ZrsKNXGiubW5NYyAq6v
         w3OBPt4J5x6MD24V6URzu8ck5weEEnAlbQGvgTvswh/kzT8kw8lJgw8JvJglbws405LN
         p+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690904950; x=1691509750;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqD7HSQGZ6HL3v1M7zQJmJ/TyPFEl9SKUOQ+urkNaPs=;
        b=NXwK3sre4+KL5CnSYyVTRlGnnJZku8wKp0E/fgXBUDkaz/G3Q/Rnh8yVUw+AF7Xw1R
         MZjDBA1udiUhtujg+x9/26V2sO2ZBtY2wNS0CEC6/2t4uS6fWmA1jcL8W/5gBfQYDUUK
         SrZT8i+MXJvku1ZN81J1uZQGRvFPRvK3eeH4GXYjjzpO3xtqW+nIzOlV3UFc3yTrmQ8c
         3S3R9d9Rk2drDVAwStWLB7ijFfOnSaKhx3tjnlVyOTtIVC31o+hRnqElikCQuJge0Q+z
         3Lk+BPnxw3Efzd3mMyj3aALR0UoRH1Veu/nrxsyty7pDO4OIPA/4brJxRcnBaURfY9zm
         J4sQ==
X-Gm-Message-State: ABy/qLZwCZaH+v7UTGyqik/28pJ+pZwlqPZ4NAqTsgvbb3GvgCWYyG5c
        bsnpcrU9sojpHgTvlbT2x8WAUyNku/VoxoZrPaxFp3Ba/C+pHY0/
X-Google-Smtp-Source: APBJJlENIdTazzkFQcHocLj635aLmmp7NWkvt2LFlRnd3wZRGjUJthh2Vmro0Jwod+6A7Tvx5HcOaAsHjy2+H8hPkuM=
X-Received: by 2002:a05:622a:114:b0:3ff:c677:a033 with SMTP id
 u20-20020a05622a011400b003ffc677a033mr17002098qtw.29.1690904950139; Tue, 01
 Aug 2023 08:49:10 -0700 (PDT)
MIME-Version: 1.0
From:   Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date:   Tue, 1 Aug 2023 23:48:59 +0800
Message-ID: <CALf2hKvsXPbRoqEYL8LEBZOFFoZd-puf6VEiLd60+oYy2TaxLg@mail.gmail.com>
Subject: A Discussion Request about a maybe-false-positive of UBSAN: OOB Write
 in do_journal_end in Kernel 6.5-rc3(with POC)
To:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi UpStream Community,

I found a UBSAN: OOB Write in do_journal_end reported on Linux Kernel
6.5-rc3 by my  modified version of syzkaller on 25 July. I tried to
send an email, but it was rejected by the mail system due to HTML
formatting included in the email. Here is the plain email text:

The .config, report*, repro.prog, repro.cprog can be found in:
https://drive.google.com/file/d/1GPN68s6mA0Ee3CyK7OSbdBNABuFEzhtv/view?usp=sharing
And the POC can be stably reproduced in the latest kernel (in/after
6.5-rc3) and the kernel panics. Reproduced screenshot:
https://drive.google.com/file/d/10_4PQHSSwEBCHIMDxjb9EzB6UylRjocP/view?usp=sharing

After analyzing the root cause, I found it may be a false-positive of
UBSAN. Firstly, the oob behavior happened at
fs/reiserfs/journal.c:4166. When i == 1, it overwrites the
desc->j_realblock[i], which is declared with a size of 1. However,
with a further sight, the desc is wrapped with a b_size=0x1000 when
allocating and i won't be larger than trans_half (smaller than
blocksize), which would prevent the overwriting at line 4166. It seems
a trick of memory access of j_realblock.

But in fs/reiserfs/journal.c:4169, is it possible to manually
construct an extremely long journal link and let i-trans_half >
0x1000? In this way, commit->j_realblock[i - trans_half] =
cpu_to_le32(cn->bh->b_blocknr); may destroy the memory outside the
block "barrier". And maybe conduct a heap spray?

I'm not sure if it's actually an fp, so I haven't patched it yet. I
hope to have some discussion based on my analysis.

Thanks for your time reading this discussion request. Although I'm a
newbie in kernel security, I am very glad to help to improve the
kernel.

Best regards!
Zhiyu Zhang
