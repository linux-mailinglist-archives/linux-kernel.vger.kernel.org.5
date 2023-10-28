Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A17DA782
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjJ1OMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1OMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 10:12:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D3E1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 07:12:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698502331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWAt/PDpViqk3UG1Vk3j+0hCIjdKt4J31sr7CYkEEWA=;
        b=GNY6kXNByQkJQe/0Dk5K7kRNpz+qZa+bZR68lQGT6vUrL6kSjnnLbImYBXOqP0+ueebAV5
        gsOQnMx6lkcBlUOk5IT2YamImtiO1APlalzZHJb7nCgHJbGRroY5GgrTDgJEgicUztWpYp
        sx/61YRKSiSjjnTSsDQXfheFy+KmeSW5n3Xn9puHFQrJxRgR4rMTXUBSH9i39JW5b5wNeU
        QfgBJBA59dmshNBvyqWdkucR5TF11vFr+1+9PGyQF+8R0Dn+2ul24BKCsRGwvgVf0OH5Yn
        gkJUEjymQKTw+WeNpfZpK0AC6UntzEXXvF1oOc+rX6bU1ajxc2t8qK0QAB5Okg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698502331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWAt/PDpViqk3UG1Vk3j+0hCIjdKt4J31sr7CYkEEWA=;
        b=NEQPzWuSx4qqzS4AYxdB3fJkAE2b0tT66TOWNyVlzvm+ClVFz5ErrXG/mXZmfIFd/FbOHY
        sNPgaHg8ASI15CBw==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
In-Reply-To: <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
Date:   Sat, 28 Oct 2023 16:12:10 +0200
Message-ID: <87a5s225vp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:

Subject: cpu/hotplug: ...

> ACPI MADT doesn't allow to offline CPU after it got woke up.

ACPI MADT is a table ...

This is about the MADT mailbox wakeup method, right?

> Currently offlining hotplug prevented based on the confidential

is prevented

> computing attribute which is set for Intel TDX. But TDX is not
> the only possible user of the wake up method.
>
> Introduce cpu_hotplug_not_supported() that can be called to indicate
> that CPU offlining should be disabled.

Otherwise the changes look good!
