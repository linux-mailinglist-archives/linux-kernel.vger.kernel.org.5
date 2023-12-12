Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295580F471
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376552AbjLLRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjLLRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:22:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567F8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:22:38 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d34350cbe8so4025665ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702401758; x=1703006558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROCp0xNd0wyqOc7nplsrZkpuLfarMjHYIQNZwVviJ7k=;
        b=HnM4jinWoc7Y5b/wDcbxzJJepOv8cd4sO9RdKKADcqamDAueL8wrV0FHrWCfx3snha
         kb3yVOaEw20XaycdieaS9+JG3aDqvlg3rMLHPzUvrdZKKe+oObuCjpJh2kMuUU5v9xvT
         JbNB8Mfz5t85NmrqChVZgfsHz4/BQWiKq3Mekmx+fjBNSN5zFViZCwlKvVQx0hSmvPYO
         boqVaOAw0oI+3miZYt2kJU5fOatMy3jMXyJhVmgtoCpjfSy4xxzxdGN7eE0PDdnLo1OI
         Yo7RpJkmZDIhye5U5vsp5WjHIvgK1t98NzSPOJJq23OGuGmyh5cH+EGutSl2icqNBXHA
         uB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401758; x=1703006558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROCp0xNd0wyqOc7nplsrZkpuLfarMjHYIQNZwVviJ7k=;
        b=jJtumD7/EjTapqtTLwzNwP2iFljBBSJmENJxYGXC3/xSkeKFQXMPyRm3u1/xK6juk8
         FGDfzT6T82jv3DT8/H2SuUYItxeP3h4rdyzoz23iaBJ1gIragDwq0nhOcMufxaGm6okj
         YsdiUXr1niCc6jodWMliAHogXYBqo2Z1mIKG1CHUhUXzCF8v4Bs/u1FZg8uViF2DL0VM
         2QE/aeI2zvUNG+/jksK9vmZTA8Ondq8FCkydMi76sG/R43LZuPcokeSivHq11wA7LwkN
         GEfj6TED4PIaa7NvYBtFxLm6gpTNOT7PP99Z7BQKUSTT0eq1t583qVYceWQpAf7OtM9I
         1JZg==
X-Gm-Message-State: AOJu0Ywr4MukiuyjYNLhM+xjVKQbLQvbBWoAjnshxoVEtt9f3/F2qYY0
        5UyOqa0F/VJbIjJ1/bHUmCvpn7TRSh4=
X-Google-Smtp-Source: AGHT+IEOEh3C8zTlAW12bJONZI+u1CmuqqelXRvUx1auEKYIObXd3RFyfjdun8PThEpN5T5kS2y4fIeGI98=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a504:b0:1d0:54ff:da25 with SMTP id
 s4-20020a170902a50400b001d054ffda25mr46568plq.0.1702401757577; Tue, 12 Dec
 2023 09:22:37 -0800 (PST)
Date:   Tue, 12 Dec 2023 09:22:36 -0800
In-Reply-To: <20231212022749.625238-14-yury.norov@gmail.com>
Mime-Version: 1.0
References: <20231212022749.625238-1-yury.norov@gmail.com> <20231212022749.625238-14-yury.norov@gmail.com>
Message-ID: <ZXiW3AgIENf7whei@google.com>
Subject: Re: [PATCH v3 13/35] KVM: x86: hyper-v: optimize and cleanup kvm_hv_process_stimers()
From:   Sean Christopherson <seanjc@google.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023, Yury Norov wrote:
> The function traverses stimer_pending_bitmap in a for-loop bit by bit.
> Simplify it by using atomic find_and_set_bit().

for_each_test_and_clear_bit(), not find_and_set_bit().

It might also be nice to call out that there are only 4 bits, i.e. that using
for_each_test_and_clear_bit() will still generate inline code.  Definitely not
mandatory though, just nice to have (I highly doubt this code would be sensitive
to using less optimal code).

> While here, refactor the logic by decreasing indentation level.
> 
> CC: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 40 ++++++++++++++++++++--------------------

This doesn't conflict with any of the in-flight Hyper-V changes, so with a fixed
changelog, feel free to take this through the bitmap tree.

Acked-by: Sean Christopherson <seanjc@google.com>
