Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486737F7023
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjKXJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:40:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E88D54
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:40:41 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-407da05f05aso11543105e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700818840; x=1701423640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liKWi3k1bQmGEMyLltDAEJD618fY1ygP7q9s9GKBNQY=;
        b=iCbh6pTSrlU3axKSDVlAEbvJ8FkJrYAlkp7tLPy6XcDdc2tocoULEnP8JKrWRUWL8s
         8Qmq1stTFpQBnTpqByFwVoZ5cFaug1ugwtX8lRe6QzH+hj6nLD1bCO/YxV+581INpfGx
         L6k4BedylFdg+ry+nqhJtkkfyrs69+IOUeT8j5Yhq9E9WiNCq5nMZOqBi2zCfPE/bZpX
         0WnNvPB9fuIPv6WQjrtNo/AyQPGEnwYkn9nU+GsBzWtci2Ip8S1GIy4meYFVx8L31USE
         btemkWbMp7HfTht8JzINJgLzLNK6qmJCFRnRJDleBMvX59NtXZyL8FAzvdO0LtW3ji2n
         1R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818840; x=1701423640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liKWi3k1bQmGEMyLltDAEJD618fY1ygP7q9s9GKBNQY=;
        b=dpWpOg4UId8UEUEj5s+DySv3+10XUxbRPV3zKzIVya3JE1t32V5tUMERx6TDcA9VWR
         iSRPCPyzRqAmKv5fgBdeD4Z1kYxZjE+NifN4Sm2+YHvIVjFLQcrHyEILQmjEYYcWTYJ8
         oIcnVGcAcJ6GkBdjKYjzUyLRhkdeN8waVpBPdM3Wr1/VswQ/LtBldDO81qYfzSLp/Orz
         JY2c2PjZGG5CzohvMyWfxJTJ1xsksB3Ovv7vaNlx27Cv40SpyEB3lSFTTkMaJjzW/i3j
         If1ht1ChDBY2jGXZ/dtRaxW95c5F9uqKp/hkrqR3hHymYe5VMDRSv3wdR8dIl/cEjh43
         EThg==
X-Gm-Message-State: AOJu0YxDyErr5SLOUaROOPcFdMBKMrFpZyEPnJ8R7jtOBAdDtiJWGEe3
        g3QTVfu/sGBU9KLIaN6YIeqSKQ==
X-Google-Smtp-Source: AGHT+IF9VLUBW6WyHhdlX2rn3vRUYeHRnBcJF0nS6mbPXvTDrFDn41SBn1hGDsyIKy9IjON6i7vOzg==
X-Received: by 2002:a05:600c:a0b:b0:408:3cdf:32c with SMTP id z11-20020a05600c0a0b00b004083cdf032cmr2103866wmp.41.1700818840312;
        Fri, 24 Nov 2023 01:40:40 -0800 (PST)
Received: from localhost (cst-prg-91-180.cust.vodafone.cz. [46.135.91.180])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040b35195e54sm4550012wmo.5.2023.11.24.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:40:39 -0800 (PST)
Date:   Fri, 24 Nov 2023 10:40:34 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Christoph Muellner <christoph.muellner@vrull.eu>
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
Message-ID: <20231124-3934c1b3c4b6dc3f076b0f9a@orel>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:58:16PM +0100, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> When building the RISC-V selftests with a riscv32 compiler I ran into
> a couple of compiler warnings. While riscv32 support for these tests is
> questionable, the fixes are so trivial that it is probably best to simply
> apply them.
> 
> Note that the missing-include patch and some format string warnings
> are also relevant for riscv64.

I also posted [1] a couple days ago for the format warnings, but, as this
series also includes rv32 fixes, then we can drop [1] in favor of this.

[1] https://lore.kernel.org/all/20231122171821.130854-2-ajones@ventanamicro.com/

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
