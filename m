Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688D760535
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGYCd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGYCdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:33:54 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EB173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:33:53 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-666ed230c81so4745214b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 19:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690252433; x=1690857233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SM9MI7YqcumJFAsvdHugETP5mtZWx3U5IfVV0xoWahs=;
        b=awuiI061ny1qf1yamFlxqwNgo+EmwYqt/+z2wsi+fNXQbNg835z5g/ekcc0Sow9/wO
         tJ6ial72Pre4/IQeuhJ0W9J/1BZYGqjMlAg/PCF8Z6u0vrJyzij9h6+6sOY0c6rHzEdz
         obVCqWWyri5OBfmi04cJo2o/SFuvM8YzF6SxNgxtwzIcIkI+/4yO+8zfZTrxReZ+k4I5
         5XWAqxsp/rEL4Uh+RZiYtk00aAUBV3ZcFIC4E+ZG2RZBelCDzjIl3J3IZla3RflyPWYu
         TU6zM/SAbQPlrsQSX7f/sFo6gWtEXLOE6jUHkPn9HECRgIgCkZ08RxaVZ3gdOj1zUjGp
         7J7g==
X-Gm-Message-State: ABy/qLZ6wI5h8Klg0acCDbinqZlL4NMZKf3OYzQ7Wl1q5fccc47uVYuW
        aHX6NiK7zuHwSFfetzH33/s=
X-Google-Smtp-Source: APBJJlFVe0K7GMtaxllYKxPFOGwt19poxqCSbLkh8PZkCc+BmgSRNhWmJG3byudSuItSdTzPyYG1PA==
X-Received: by 2002:a05:6a00:3914:b0:682:616a:f910 with SMTP id fh20-20020a056a00391400b00682616af910mr12230293pfb.20.1690252432864;
        Mon, 24 Jul 2023 19:33:52 -0700 (PDT)
Received: from snowbird ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a62e406000000b00684b64da08bsm8382076pfh.132.2023.07.24.19.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 19:33:52 -0700 (PDT)
Date:   Mon, 24 Jul 2023 19:33:49 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     bibo mao <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH 0/3] LoongArch: mm: Code cleanup with populate pte
Message-ID: <ZL80jRwJ1ROz07a8@snowbird>
References: <20230712031622.1888321-1-maobibo@loongson.cn>
 <8d22477f-d7e4-b151-f72b-cea3f1ef3ef3@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d22477f-d7e4-b151-f72b-cea3f1ef3ef3@loongson.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 25, 2023 at 08:36:22AM +0800, bibo mao wrote:
> slightly ping.
> 

Sorry, I'm not sure how I missed this. I'll take a look at this
tomorrow.

Thanks,
Dennis

> 在 2023/7/12 11:16, Bibo Mao 写道:
> > There are some confusion between pdg and p4d when populate pte for
> > kernel address space. This patch modifies this issue and adds unified
> > function for pcpu and fixmap populate pte.
> > 
> > Bibo Mao (3):
> >   mm/percpu: Remove some local variables in pcpu_populate_pte
> >   LoongArch: Code cleanup in function pcpu_populate_pte
> >   LoongArch: mm: Add unified function populate_kernel_pte
> > 
> >  arch/loongarch/include/asm/pgalloc.h |  1 +
> >  arch/loongarch/kernel/numa.c         | 35 ++-----------------
> >  arch/loongarch/mm/init.c             | 52 ++++++++++++++++------------
> >  mm/percpu.c                          | 24 +++++--------
> >  4 files changed, 42 insertions(+), 70 deletions(-)
> > 
> 
