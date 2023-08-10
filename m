Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DE7781BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjHJToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHJToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:44:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2635F12B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so984322b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691696657; x=1692301457;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwLcr+qLqxp9uILJzHR0AOl3psh7swIvtQXIg5ZMp1w=;
        b=CvduWUlZzx84mIAB1T9e2rAahPkDRFSk+A17ilCInoLdvhF0h5YmvXr0wxkj4G6JNK
         D2jdPfkidRPUf64LYrN6aMZqmngbymQJayobTVMBKadsh8c6Lxo6S6teZGcn0i/jk5PS
         Bi+mOY/cVwuE0ZmygLL+H81ecFAE/6ZkA8tRRaFDKnXUMAGpQCj8KbEaqmEuLvddBp6E
         4zO6z5BaQBCNtAticZK5mPSr06LQ0VIkrFG5X28+KKeYm4JI9YNKIqoh/0zgtijGoLz6
         vFd9IwDkCL9Ak3WXXaMh27b42q7OvpiQgOtGylm5HpVxnoNB0c4KhODIiYc5rcsa9Tv0
         pK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696657; x=1692301457;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwLcr+qLqxp9uILJzHR0AOl3psh7swIvtQXIg5ZMp1w=;
        b=Fm/ImjbXAlczfhXvxCwYZcP16MdH3cZSKRXXmCH/H4MoY5dTejls98QhYRvLx4YlUO
         5kwCJJJLq5+O53+SMdRiU5SbMlEss53MZJc3wgXkcY7D/IjpxffRNKmaUOgSVTV4mG7P
         1YVafM/OBlBrmD373yqipE036rk7fzOXUYKHWfNgX1HTw8ehnwt5Vk22QaCmBOrb2fK5
         rvq4XuuFEBQfIhEnEB0A8bPGFTZDHKAJ9zcBxeRSjtg6MSiuvqTEQ+1uexZUJYaZKMts
         z09He0+vh+J+/yeD8SpX7UfS1jn1rjWrg1NA6t5dKvC312y3ohdxxkQExvBBupXzYa/+
         XaXQ==
X-Gm-Message-State: AOJu0Yz5he9T02R3P8eV8X4XvPAQXpxhp1QyjdMJinSsAdLmR+vkoGlo
        nO8aysJs9D5syLOP/lTLaa1tHIoBKrormgHXH8o=
X-Google-Smtp-Source: AGHT+IFiVdYsssSNSg+RLnpvaujHNrG3IHRYouNiTyLod2XG58mtE1PEiNGLAjtoTQapbZ0NEqrCNA==
X-Received: by 2002:a05:6a00:17a8:b0:66f:578c:59fb with SMTP id s40-20020a056a0017a800b0066f578c59fbmr3901964pfg.10.1691696657149;
        Thu, 10 Aug 2023 12:44:17 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id bz4-20020a056a02060400b0055c2bd881c6sm1758899pgb.84.2023.08.10.12.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:44:16 -0700 (PDT)
In-Reply-To: <20230803012608.3540081-1-samuel.holland@sifive.com>
References: <20230803012608.3540081-1-samuel.holland@sifive.com>
Subject: Re: [PATCH] riscv: Fix CPU feature detection with SMP disabled
Message-Id: <169169664355.3729.14458848108996711975.b4-ty@rivosinc.com>
Date:   Thu, 10 Aug 2023 12:44:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel.holland@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Aug 2023 18:26:06 -0700, Samuel Holland wrote:
> commit 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA
> string parser") changed riscv_fill_hwcap() from iterating over CPU DT
> nodes to iterating over logical CPU IDs. Since this function runs long
> before cpu_dev_init() creates CPU devices, it hits the fallback path in
> of_cpu_device_node_get(), which itself iterates over the DT nodes,
> searching for a node with the requested CPU ID. (Incidentally, this
> makes riscv_fill_hwcap() now take quadratic time.)
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix CPU feature detection with SMP disabled
      https://git.kernel.org/palmer/c/6514f81e1bd5

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

