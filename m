Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0381153A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441922AbjLMOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378944AbjLMOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:51:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B993;
        Wed, 13 Dec 2023 06:51:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702479060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHe6ZT6IqHXuvZfN2Kkv8LYZ39KD28BsElvHGdR2yLk=;
        b=xMCS46RkFqf5k2sd7I0D5MPvvAB63Omcbg8KLgVk2SQU7Ghd1CZw/ElA3/FOQt9X1UGnJn
        6U+4YO70gazL6yuOO8oelZ79FjJU6HDxDAqifYzSuEtPn3skyg0kJqCOEGOmX5bZqoQebL
        0VvVtQ/34lXz5afr0fWZWMYVBt4P1veJqfSC0Bodins7HhOHyETaQ9eXNzl1tUrCGxsbuR
        wl4HpmKpDljPQ6ZLzQmmxnPZOxb+n4i1Ia1Wl3GQZzuN8S39tpZv3TKuV4kCjv/mZPr8b8
        RBp7hXsGw+M3j83dEIXn4bmn9S6zM4KEQ7EOhOLSigCXc11Wx1096MrpFysiyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702479060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHe6ZT6IqHXuvZfN2Kkv8LYZ39KD28BsElvHGdR2yLk=;
        b=XZ+HChB4RPHfbor4Q/YW7pwBZoCQviihzZCHu8++ftZ3wCiy3NX7Or9ivo25GQwo8/o5hP
        sapuqCrsi4G2GLCw==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "jsperbeck@google.com" <jsperbeck@google.com>,
        "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>
Cc:     "andres@anarazel.de" <andres@anarazel.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
In-Reply-To: <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
References: <87ttonpbnr.ffs@tglx>
 <c1d7e60329a62a9f6d70ffa664632db8db668efe.camel@intel.com>
Date:   Wed, 13 Dec 2023 15:51:00 +0100
Message-ID: <878r5yp357.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13 2023 at 07:39, Zhang, Rui wrote:
> Yeah, I agree.
>
> I have posted a patch to do more strict check
> https://lore.kernel.org/all/20231210143925.38722-1-rui.zhang@intel.com/
> in case there are some weird cases that LAPIC fails to probe any
> enabled CPU and we also lose the X2APIC cpus.

The return value of acpi_register_lapic() is not really useful.

It returns an error if

  1) the number of registered CPUs reached the limit.
  2) the APIC entry is not enabled

#1: any further X2APIC CPU will be ignored

#2: the return value is bogus as the CPU is accounted for as disabled
    and will eventually lead to #1

    In fact even 'disabled' entries are valid as they can be brought
    in later (that's what "physical" hotplug uses)

The topology evaluation rework gets rid of this return value completely,
so I really don't want to add an dependency on it.

Thanks,

        tglx



