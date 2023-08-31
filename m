Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A72678F237
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbjHaRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbjHaRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:53:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229EE5F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:53:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56c3a952aaeso1177952a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693504430; x=1694109230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=muHG4XzETvb0f3E5prPRRg9A9bSn2c1VqCPz6B4oxS0=;
        b=lYVk+3m5DIBHpU9VrVFgXfwaltS7MBIx7fqeqnJOZ9UtOFKhkKLQNsMOlW7nL2sp9o
         JkmshYucO5Ks+wNcvBV41OT/gCLVcQzUx1c26UWamrF+eRnmKP6x8YP8jCo9WrNdPun+
         BoyILL4JG+LEuujC6mKD5DxSh/unL6KIFcPGSaSsT5uT8DR4ME0xFbQ5OIhczCH7i4kc
         0/JWR81E5Ovbzi9mU2uNiVmlUrfsjBgMYxTSRN2R3fMlHHZjiMIltwEL79bcL5IlVynM
         lIWbA1kSEtUccbixQF859GJ1Zwe3LkjOSidpwuk5RG0eqZgwBPOie3RIZqEGepvaf7Zn
         S+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504430; x=1694109230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muHG4XzETvb0f3E5prPRRg9A9bSn2c1VqCPz6B4oxS0=;
        b=YJP0xJ9mV/82MuF4ggA6QSoYjIRljcUMP/nzvvPDmY7f+E0o6xOvhwZzF3Q3tktYEV
         JcqqOu0dcoaGTDemxo4MjcZ3AzPMY/yekl9CrrUwG0UoOkOZOGVqTKnyYhDX45mzoT23
         89mnyxXk3nALS81Sast53TUULCdEMKo2J2tTjFIkJOZMagA3rktlHBvyd05gmKsjUNBw
         +duhOR8rrW87+D+AwjYZxMmd7JdaknALFXih7YoMOGYuRcDnXQw21DX4OXsrTKwxiycv
         +mSu0Ln/Q2F7/QtoE2algofufeqqU4YuXq/Mt5PXwECV1J02Hv0fyxUhdhOwE9H0uLeQ
         Pp6w==
X-Gm-Message-State: AOJu0YxSld4P2kJZW2+FplOxHL2kahz+Cst+j3+CP9d5kyx9Wj/bi6k0
        ZGj4kkqqyTRsnOXjPU9KlEBGJiMNbeg=
X-Google-Smtp-Source: AGHT+IFdZnjuVAnScvtRdbIcQ/4afplVa+BDB04mB39SLriQksFhk32oW32aiiySAv9VOAV33q/FPo7exTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2287:b0:1b9:e9f3:b4ca with SMTP id
 b7-20020a170903228700b001b9e9f3b4camr98685plh.12.1693504430486; Thu, 31 Aug
 2023 10:53:50 -0700 (PDT)
Date:   Thu, 31 Aug 2023 10:53:49 -0700
In-Reply-To: <89fad050-e074-463e-8c27-a72b89de620c@gmail.com>
Mime-Version: 1.0
References: <89fad050-e074-463e-8c27-a72b89de620c@gmail.com>
Message-ID: <ZPDTrfppUdG7uxPX@google.com>
Subject: Re: Missing L3 linesize on AMD Ryzen 7940HS chip causes crash in amd_cpuid4.
From:   Sean Christopherson <seanjc@google.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     vbox-dev@virtualbox.org, open list <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023, Christian Lamparter wrote:
> This is because L3 cache's line_size is "0" (this is coming from the 80000006 edx
> value of 0x00009000).
> 
> This can't be right... or? Well, digging around. I found the following explanation
> in AMD's community forum:
> <https://community.amd.com/t5/processors/ryzen-7-3700x-cpuid-function-id-0x80000006-returns-wrong-number/td-p/376937>
> So there's an issue with "wonky L3 values" that happens even earlier with the
> AMD 3700X. In this forum post, the author talks about the
> "L3 cache associativity (bits 12-15) is 0x9".
> 
> And the same is happening with both AMD 7950X and 7940HS.
> The kicker is: this value of "9" means:
> "Please look at CPUID.8000_001D".

Ugh, that's just nasty.

> Which I think boils down to implementing X86_FEATURE_TOPOEXT
> for virtualbox to get over this issue?
> 
> Now, is there something I'm missing? I don't know if qemu is be affected.

AFAICT, QEMU should be fine, so long as the underlying hardware is sane.  Unless
I'm misreading things, QEMU doesn't generate the redirect to 0x8000001D when
synthesizing cache information, and when passing through host cache information,
both 0x80000006 and 0x8000001D are passed through verbatim.

> Or if there's another way around it.

At a glance, having virtualbox zero out EDX if its trying to redirect should also
work.
