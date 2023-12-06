Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52558075B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379379AbjLFQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378443AbjLFQs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:48:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C63D4B;
        Wed,  6 Dec 2023 08:49:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701881344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OW6fkIGPO4x87Du5pJ1IsDRO+WfPCm+RulSO3wBmJjI=;
        b=ttBvv3qTtmWX7QH0yvPnoZ2t8W6iQhQt0oIGmlQNB9lXAE+LRzhL4F3/uqF3MaWitYgtrH
        O5Z51b6Kh2n92+pivCzR6ZvOVwGLz+52hsYK7TZCwcC4+ezW0/QQUiNv2GqSZE2tJbhfVb
        9UWOFCx20RlnIzPDdb0StSLg8KmiNINvj6Lqtgvb1ZBWSTMGbwjdA2GadGHgZCVtIm9ilT
        mn/RXy4b7zenoxkDCUVHDsbhmNsWiuVb/CAF20R0l7PRiu680h2rvDpHswsh0BFXm0F0Ws
        sRz2zC7KbjmKlEvq5lHze7dTzQ+GA/XGq9RY9+0k53g6ItW1WDXrUPyYsjbvTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701881344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OW6fkIGPO4x87Du5pJ1IsDRO+WfPCm+RulSO3wBmJjI=;
        b=CFNzObTnCB9e4938vW9R7RJkgiaZJW+XFIkytbquEq82rCgRKbEMl4zau7bI7aKSb7cp9E
        LVkx+RN8Q5UgLsBg==
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC 04/13] iommu/vt-d: Add helper and flag to
 check/disable posted MSI
In-Reply-To: <20231112041643.2868316-5-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-5-jacob.jun.pan@linux.intel.com>
Date:   Wed, 06 Dec 2023 17:49:04 +0100
Message-ID: <87o7f3uvi7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
> Allow command line opt-out posted MSI under CONFIG_X86_POSTED_MSI=y.
> And add a helper function for testing if posted MSI is supported on the
> CPU side.

That's backwards. You want command line opt-in first and not enforce
this posted muck on everyone including RT which will regress and suffer
from that.

