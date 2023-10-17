Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818627CCC49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjJQTaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjJQTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:30:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A4ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:30:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50435ad51bbso7949752e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697571019; x=1698175819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/BDofzE4Or/7ySerAf5AsywpyZJIdw+bPNUdrWopVA=;
        b=RclkpbU6pGb/dbYGBaf4Qf8cNdZ7WTIKzjQkZu0e/o16Oi/SMxSFL7jE02X7d1XYc+
         E9/H+lSzqxGznZcA6t4VfjxoG2K3RHoDbMUmj3Vlaa70u0Fn4NWTCfcF6hNZA/hav7Ix
         gqumiry0/HW3Puejr4kpG70Kx01MLoRJL+v7bevEonaG6Gie75PCDlZjZMy3sBHuvq/t
         uotvn/mQyPXEqGuGhqkmWdwG9akJ2UNjViODZtPNDx4LwtSsIdYb2yPk1NscZ8HPRKMz
         HLGAhY/SZn270CgCEvQzTiEiW5dMdJE4Wd2jKIk86bCngoYa4qmrFHGJL6s0toCdSum0
         t9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697571019; x=1698175819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/BDofzE4Or/7ySerAf5AsywpyZJIdw+bPNUdrWopVA=;
        b=oaYTtnBeKHJjGG6EG0lrBikYOIySXI+Sd5LrI3STM+kQS5XVL2g1WgPjUpFdB+KeGB
         xdnsMGYdT7dfd9gLPf3UmPwBQ/Qrg2d8URB9karq8uXpIvVuFQ+eKKp8aMQO433c3qBC
         giPjPyDr2xTVA/flK7ecC/kt87mD7eSlRmcYlM0FKqJtsoDDND9Nd7m5eEbimmcUabWK
         fI+CoOa5YZTL3J/7y6GAfZpdTHkN+25XJ4Y1eWXQSav4ispXZKyCe1i6gXe8ktfmKKP0
         xlYVTznGV1hFJSlBxfYEd64gMa9bQPj2tY8IWFNVNSKUpq2Bb6JIcsoonzt/e5hJhb9W
         KyWQ==
X-Gm-Message-State: AOJu0YyrwARQP4u7rYORFyJuajjTnwuvQozelu3VNYJ7OMvGrhXQT4jt
        iGq8MAWvaDbcSumpLkcPuPPXYik0lFI=
X-Google-Smtp-Source: AGHT+IFjYavsMAWVLd6koUJ1EZp8kJLvjzK88YNCDRHrNmxTdehEdew4S4he2wBfWoNngZ+PbRNLxw==
X-Received: by 2002:a19:500d:0:b0:500:9a29:bcb8 with SMTP id e13-20020a19500d000000b005009a29bcb8mr2571559lfb.4.1697571019023;
        Tue, 17 Oct 2023 12:30:19 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cda00aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff3c:da00:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id f17-20020a50a6d1000000b0052ffc2e82f1sm1728909edc.4.2023.10.17.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:30:18 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=shift.localnet)
        by shift.daheim with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.97-RC2)
        (envelope-from <chunkeey@gmail.com>)
        id 1qspli-000000009ct-0VOa;
        Tue, 17 Oct 2023 21:30:18 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, seanjc@google.com, klaus.espenlaub@oracle.com,
        bp@alien8.de, glx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH  v1] x86/cpu/cacheinfo: fix panic on Ryzen Mobile 7x40 series in
 VBox VM
Date:   Tue, 17 Oct 2023 21:30:17 +0200
Message-ID: <4550917.LvFx2qVVIh@shift>
In-Reply-To: <652989ad8a7f110bad16cf1244c4c68a823f0afe.1693606609.git.chunkeey@gmail.com>
References: <652989ad8a7f110bad16cf1244c4c68a823f0afe.1693606609.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heads up!

Oracle addressed this with their virtualbox 7.0.12 release.
If you are affected, try it!

On Saturday, September 2, 2023 12:19:11 AM CEST Christian Lamparter wrote:
> Ryzen Mobile 7x40 chips experience an early kernel fault
> (division by zero) due to nonexistent input validation
> from CPUID data in amd_cpuid4().
> 
> This error was first reported on reddit [0] for a
> "AMD Ryzen 9 7940HS w/ Radeon 780M Graphics", but since then
> the bug has been reproduced on a "AMD Ryzen 7 7840HS" Laptop
> too.
> 
> [...]
> 
> The reason why this is happening is because the Ryzen CPU reports in its
> CPUID 80000006 edx register (which contains the L3 Cache Information)
> the value "00009000". This magic value means according to AMD's
> "AMD64 Architecture Programmer's Manual Volume 3" Table E-4.
> "L2/L3 Cache and TLB Associativity Field Encoding":
> 
> | Value for all fields should be determinded from Fn8000_001D.
> 
> (This means to look in cpuid(0x8000001D,...) instead.)
> 
> So, amd_cpuid4() is missing this special case. A case which has been
> present - according to this AMD Community post [1] - since
> Zen 2/Ryzen 3000 Series.
> 
> But wait, why is this only happening with Linux' when running under
> VirtualBox with these Ryzen Mobile CPUs and not when running natively?
> [...]



