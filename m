Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF107E5C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjKHR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKHR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:26:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C31FDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:26:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da31ec03186so868260276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699464410; x=1700069210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcNGmp0bMVeoUVK/kj6RJuJ80bfwKP2JtkyvpFXoMsU=;
        b=28g+1mtFmc1p3pzUrX3+MUEcElyvcMxoKaEtniN85c0fGU1wRsa5JzbjTsz2Lwmf8i
         TJ0WyWMnvgywjRdnIIVOHe8qj9oQ0wsGdJ5eAYl+5MI7adJBPj3LgOSofyvhn7RgJJ+J
         vPqEYrlQI9e0lWU1n7Ke+okhX/I8LzR6+bW1oQC7fIlci8vLXZCCK86kCbP8WUZBCjHP
         Z8preWys1obzEwoh57IkUlMe/a8TKg5roClTHuXbYj311jgPQopQXMYO2XasUMAGyHJw
         nP7GLQerLdnWjGg0OnX5oJHhtYozGw3MwgY4tejM580tG51inlky1sOqPfFTcgAmnzGy
         g8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464410; x=1700069210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcNGmp0bMVeoUVK/kj6RJuJ80bfwKP2JtkyvpFXoMsU=;
        b=uKt5pn3CA8A8LMBueliBV0r3zCAjX50jsBhTGy1HzF/QxlFjHdcCnY94Ul+Fyt+ef9
         UwoyfIoSyjWBFEO/++Vrio6QV7OMYraQeBPCpxWX2/+osbdtMPx3Uos4VQ3U1b1WrIG+
         PhhTPb5q2RD9sxvx1XC2651hO8+rm3axv25TPWHF1YeCnLLpGZymq7gYtor0OtWuY5AD
         z8Y+fN25ePGh1L+BygdN3pISMf0EMnnaolWSnP83z86Gl+czt9bL7kusYIS1ZYSY7/xg
         zlI3fq7XRLbmLmwAKJQH63YGeRSvaLCOGlOtAyQL/46Z1tCsJgth7y1eb+392DW2uvEs
         30wQ==
X-Gm-Message-State: AOJu0YzPoyAxrIZKzLNCMc60/pzsKpRfOxMbkWDWMkaaqCC/eOTNHpMQ
        ewMFyVv+edaF0uREFn3f9E75+bZXpYY=
X-Google-Smtp-Source: AGHT+IFxHXaCZqys2v1fdXMGyt4nA5veqhn2zv5LksaAjCX4Ofs8pcVrVl/9acHOhLlQN5myH5bfxC98TFQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2307:0:b0:da0:37e1:558e with SMTP id
 j7-20020a252307000000b00da037e1558emr56047ybj.6.1699464410654; Wed, 08 Nov
 2023 09:26:50 -0800 (PST)
Date:   Wed, 8 Nov 2023 09:26:49 -0800
In-Reply-To: <20231108111806.92604-15-nsaenz@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-15-nsaenz@amazon.com>
Message-ID: <ZUvE2clQI-wOzRBd@google.com>
Subject: Re: [RFC 14/33] KVM: x86: Add VTL to the MMU role
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, graf@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> With the upcoming introduction of per-VTL memory protections, make MMU
> roles VTL aware. This will avoid sharing PTEs between vCPUs that belong
> to different VTLs, and that have distinct memory access restrictions.
> 
> Four bits are allocated to store the VTL number in the MMU role, since
> the TLFS states there is a maximum of 16 levels.

How many does KVM actually allow/support?  Multiplying the number of possible
roots by 16x is a *major* change.
