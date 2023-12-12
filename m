Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83680F8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbjLLVEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377304AbjLLVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:04:38 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:04:44 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so4412702b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1702415083; x=1703019883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXCOnbYbo1oDbYsUXOqGGj5UISArUKYnIPWgHEPvDjQ=;
        b=P9H6W68KDxlcz4p4ZxU4IQVos/49qUzB4LIsstplfLuWcb+AyoExaxveaIwlACrBVs
         CVaYFFxp7uVN6+e9EPnuZ+VT5qA99vClM3hjOQIuRkC9ofuanrMAyTcMfBJvN4StrmI4
         EeAR/oDL/buz5xTTpiPXXY+ppckC77G5clP6QaUrWvJ6e9XUSiAkAUorU3jd6J0XXJ0p
         vGsx7+HnLJXi6ZcRIG8fbegu9fiJAgBH4vWzskE0uEVbiExMQOCS7iciKn0yR2B2n5mc
         9JaXDPv0yMBNWo+p5qKT0d4M59l82od3uiKYd9bIn73yTikweuTcoc5Gd/jGu1pz06bl
         zviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415083; x=1703019883;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXCOnbYbo1oDbYsUXOqGGj5UISArUKYnIPWgHEPvDjQ=;
        b=FNS8x/7/cJ/mOd8cXOjoVmx0r9JD0SbpskfsStQK6LMcHyDmvN3SBuhvHJMlX5SZa2
         iNNxDrmLuz9yMoUDBzHA6+Xy/KgG/vhP+kalrSKRljvxcgswr8zJfFJq4B1qwP4C8YjP
         l6OiIBQRkj7Y938YWuCbPemosRQgsU2nNncPmYwFWbA3ME07Q8h7agF//uFVoMn39wTd
         +wfGhH/nUUbBVjr3xn6BYI/ZjXn8mmHOFagWOGeY0OEkxkKAf0sNT+FwDHENfK7bk7f/
         VheKxdJfGnvyIBjagh3/uhEQKkgEN/PHkEv+bRmfrh0ZV1K8LDleNOMwXg1zWC+bpQQk
         EcVw==
X-Gm-Message-State: AOJu0Yxf6SNJWASRVfXe36UuXLGROn/Gi4BnXVporY2Zb6Ht6zOfqpUv
        TbuT9nrh6a7fae6WRH3/CF0E1w==
X-Google-Smtp-Source: AGHT+IE61QRANzgSPbOgmtPUskN2VwVdPNkZ7fInEOmKuM7txtCu/lMVHSlCuGpBOJ/y7lhzZvTlPA==
X-Received: by 2002:a05:6a20:3946:b0:190:e59:f154 with SMTP id r6-20020a056a20394600b001900e59f154mr9530635pzg.18.1702415083565;
        Tue, 12 Dec 2023 13:04:43 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id o28-20020a634e5c000000b005c6bd30ea57sm8531769pgl.47.2023.12.12.13.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:04:42 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:04:42 -0800 (PST)
X-Google-Original-Date: Tue, 12 Dec 2023 13:04:38 PST (-0800)
Subject:     Re: [PATCH] drivers: perf: constify the ctl_table argument of the riscv user access handler
In-Reply-To: <20231206-flanking-frill-fffeca740221@spud>
CC:     m.szyprowski@samsung.com, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, keescook@chromium.org, linux@weissschuh.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>, mcgrof@kernel.org
Message-ID: <mhng-8f7ddf72-8e2f-4dac-a67e-624eb5511a14@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 02:55:48 PST (-0800), Conor Dooley wrote:
> On Wed, Dec 06, 2023 at 09:46:42AM +0100, Marek Szyprowski wrote:
>> 
>> Fix riscv build break after commit c8be9e66ca1e ("sysctl: treewide:
>> constify the ctl_table argument of handlers").
>> 
>> Fixes: c8be9e66ca1e ("sysctl: treewide: constify the ctl_table argument of handlers")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> This breaks the build when applied to the RISC-V tree. I'm going to mark
> it "handled elsewhere" in patchwork since it needs to go into whatever
> tree has the broken commit.

Ya, thanks.  There's a second copy of the fix over at 
https://lore.kernel.org/all/20231212-garage-pellet-c6a2bd34854c@spud/ .

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

for this one too.  Just trying to merge that fixed hash into 6.7-rc1 is 
giving me a conflict, so I don't really want to pull it in myself.  So I 
think the best bet here is to have whomever took the patch take the fix, 
but LMK if there's some shared tag thing I should grab to take this into 
the RISC-V tree.

>
> Thanks,
> Conor.
