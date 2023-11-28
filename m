Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99447FB8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbjK1LGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344527AbjK1LGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:06:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798DE1BC8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:06:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332e7630a9dso3071668f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1701169603; x=1701774403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4544Fpr0xpXzSsGII81PnfJdRXQwcz4p3qozKAwiwGk=;
        b=Z8GtElyqE8HzK94hmR5+5Q4EFRC8gEw1XbvJf5a7qMNBjDtuO7jww67W8v0fn86PKn
         n1w9Kg4O/lHnap4tZSgWcd6nOzK7cGA1NLQe3xibBEYanXCorGxqq4T+Q2qyqwJefgQQ
         DmrFD1zRjB2q72JFNH/dA5RXXoj1xPbrjhB3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169603; x=1701774403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4544Fpr0xpXzSsGII81PnfJdRXQwcz4p3qozKAwiwGk=;
        b=pvB67ciGGUUAVMWkygaPw3Saecf+Zp5D4mpXQ/0qDg8cv9vDWjrzprOQrOffwgzyh/
         vN0cuAH3CJDj6bZxsJ47J1KqJIiDv1bxD6RofZf772t1ttaNlRiTiu0H9JAQkUjwdgus
         kvw7OAp5NSV/kQofsuQhyxzNPLX8xZmsMaRpJ+Qz8dcFjHSWn7c6Vqk41qaMgjT8r65l
         z9APR4KH/4AhB27KgLUaC6EHwS34V/za57TVWYWFzAnypS9PeVjSovcNalx+m4yC+oyD
         YargfiDLYnxG6qaMWIuiHKn8SqWh5NJpeiGRJeDdO3r4buQe/WZ1laOc2U6nYa1JT26t
         fw7w==
X-Gm-Message-State: AOJu0YyT6/QwMOQ6MOI64fV4vVmfTs6WocypZEMlgp9OYWN1QNa/qL6w
        gOtd9hKw5sdwIMGt9PxQTuO/bw==
X-Google-Smtp-Source: AGHT+IFtDYyljvWb3A7bJ1Us43VzQj6a6DufjzkHfU8NxQpzEuoUTLtz6a8kXHUUqQujHrcwJK3N7g==
X-Received: by 2002:adf:eacd:0:b0:332:ced7:56e5 with SMTP id o13-20020adfeacd000000b00332ced756e5mr10461289wrn.13.1701169602916;
        Tue, 28 Nov 2023 03:06:42 -0800 (PST)
Received: from localhost ([213.195.113.99])
        by smtp.gmail.com with ESMTPSA id x17-20020adff651000000b003330ecc3907sm1324674wrp.44.2023.11.28.03.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:06:42 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:06:41 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] x86/xen: fix percpu vcpu_info allocation
Message-ID: <ZWXJwf4K4FOWSmK5@macbook>
References: <20231124074852.25161-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124074852.25161-1-jgross@suse.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 08:48:52AM +0100, Juergen Gross wrote:
> Today the percpu struct vcpu_info is allocated via DEFINE_PER_CPU(),
> meaning that it could cross a page boundary. In this case registering
> it with the hypervisor will fail, resulting in a panic().
> 
> This can easily be fixed by using DEFINE_PER_CPU_ALIGNED() instead,
> as struct vcpu_info is guaranteed to have a size of 64 bytes, matching
> the cache line size of x86 64-bit processors (Xen doesn't support
> 32-bit processors).
> 
> Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
> Signed-off-by: Juergen Gross <jgross@suse.com>

FWIW, on FreeBSD we also switched to the same approach quite
recently:

https://cgit.freebsd.org/src/commit/sys/xen/xen_common.c?id=20fc5bf7df1db698f2651eaa04a3bc71290e1636

Should have checked the Linux side, sorry.

Roger.
