Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0E810738
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378107AbjLMBC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjLMBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:02:48 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC181AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:46 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0897e99e0so38196375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702429366; x=1703034166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSXCpaBxHdiNua9KDi/vnKPqQf7jzYWRNQ9I/nlItPk=;
        b=FASaJ/tEZh5YVfVAOcRVXyFcU9y4LzP6E2am6wMNxuS3y7P46+dmxJGuGjDonnvOHQ
         FCGrrGSu3Z4Ayve+TxRYIrDoS24k14Idc/IbtEQ5rG8ijfwAWXldrekYBHbM8Ic4MkH6
         y4Gd3kz10fGbOtLa3JAa6arLt8BZLy/uC/eWv59QQgL7xP6QOSrNd1UvAre332CG3nex
         eMgUom7bVU1fyKn+fjHOVsPgImg/Fuie24RdXGeElWBo5JySYL8VgebYVVFkiaJN/xS5
         aACIuYz/iwDB0pa+FsA+deh/2Tq9D+0O4geiuv0YVbbd1vncDCcXp5vLTwVA6/wE6Wqx
         nHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429366; x=1703034166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSXCpaBxHdiNua9KDi/vnKPqQf7jzYWRNQ9I/nlItPk=;
        b=NuC4m5i3xZ3ory7JbkRjs2IizgAz2EO7qNkc+RRwhQ0r/vq59eK1N+ycFvJxumpCe+
         +OoTZOCE2rXDDXJB+x5H2bkP8SUxUUZEWp4IBbTGVWIeFtgI7X0iO0RXgmpuF4wBKvYk
         6dHG6yYNBA/4t5oh/bi0nqk3QuLK4GlTyQPP/lVeACLMs6E2Ff+lZ7psQ+OD7NO3OnJR
         zPu6LsEBdO2rCQKkTzc8gZ6OSt4NymhCoIWA4WuPF9Lk5FmWPrZhc1VGxViea311yqq3
         3854ogdcPUOC2BgzzpEDbypCCzL9qxHAjACU5zhDy81mprLNa88T/iZrgFpHTPaNbcoF
         IK3Q==
X-Gm-Message-State: AOJu0YxKNNUxMKySn7PycYgxf1tvlqfqdB9/aCbErdiQysTtCzaoDXXW
        QeOTtDX4SU2WKF3i8PAGlnoLYw==
X-Google-Smtp-Source: AGHT+IFum8Ift//4Nra1iOHPfHAzmMHgsPr8kZVXLDYsGQ+bYi9tzjcgY6pGrGjQsCDcWHskZtKrZg==
X-Received: by 2002:a17:90a:ec07:b0:286:6cc1:279 with SMTP id l7-20020a17090aec0700b002866cc10279mr3175285pjy.68.1702429365928;
        Tue, 12 Dec 2023 17:02:45 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a5300b002802a080d1dsm10638490pjl.16.2023.12.12.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:02:45 -0800 (PST)
Date:   Tue, 12 Dec 2023 17:02:43 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, ajones@ventanamicro.com,
        guoren@kernel.org, mchitale@ventanamicro.com, waylingii@gmail.com,
        greentime.hu@sifive.com, samitolvanen@google.com,
        Bjorn Topel <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        jeeheng.sia@starfivetech.com, Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>, jszhang@kernel.org,
        cleger@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
Message-ID: <ZXkCs9ypok5X/Wx2@debug.ba.rivosinc.com>
References: <20231212235003.2036221-1-debug@rivosinc.com>
 <mhng-ae72b5fd-358d-48e2-87cf-f571b67afe9e@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <mhng-ae72b5fd-358d-48e2-87cf-f571b67afe9e@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 04:53:48PM -0800, Palmer Dabbelt wrote:
>On Tue, 12 Dec 2023 15:49:25 PST (-0800), debug@rivosinc.com wrote:
>>envcfg CSR defines enabling bits for cache management instructions and soon
>>will control enabling for control flow integrity and pointer masking features.
>>
>>Control flow integrity and pointer masking features need to be enabled on per
>>thread basis. Additionally, I believe cache management instructions need to be
>>enabled on per thread basis. As an example a seccomped task on riscv may be
>>restricted to not use cache management instructions
>
>Do we have anything in the kernel that actually does that?  Generally 
>we need some use, I couldn't find any user-mode writable envcfg bits 
>in any extesions I looked at (admittidly just CFI and pointer 
>masking), and unless I'm missing something there's no per-thread state 
>in the kernel.
>

Cache management operations?
As of now kernel blindly enables that for all the user mode. It will be good if
that is enabled on per-thread basis. Sure, all threads can have it enabled by
default. But if strict seccomp is enabled, I would argue that cache management
operations for that thread to be disabled as is done on other arches. As an
example x86 disable rdtsc on strict seccomp. 
RISCV allows this CMO extension and I expect CMO to leverage this (currently it
doesn't).

I was being opportunistic here so that I can reduce number of patches on CFI
enabling patchset.

Will it be okay if I revise this patch to include with a usecase to restrict CMO
(say for case of strict seccomp on risc-v)?
