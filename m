Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA2809F67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573421AbjLHJbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjLHJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:31:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC6171F;
        Fri,  8 Dec 2023 01:31:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702027880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ypJIbnUsUGwwnCZqSIYAJ+IV09KDSne8At3TT8svy18=;
        b=eK8feyvcv7dCOLbb3xHKW7Acre82SMz5YWHKDZFYbnvXnZOB1I1/Bi0Uj6sp/Gh3o7+ABJ
        m37gEy5bRrzDFqd3kkVnXrhP85y9xB7WkvZigcVJly0zOktwV0RBgiescyBr+RQnsuPXVQ
        Xd3p8bDEIeeoG//vNQWxRno19a1nNuzorDgeaFIN/lFtZK0ZMAyD3caGo6q9aQDIdxLxep
        41/D8OKXO5lNoch+sz7xx9fAcQfnVTFZ3FxC5S60E8WUa8FKOlQz4iLbS66pE6iEr0l2Md
        2vtKjc4WjhNDbw/3sH+9PuR2Yy1eIqX8QZpmT/D+eoVuuhvwmMTFJAfSXDLUdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702027880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ypJIbnUsUGwwnCZqSIYAJ+IV09KDSne8At3TT8svy18=;
        b=ezKUFhDk5y4jvHILEopD7H1/aDqy17wzslA8uxl3siTltIT35KLucBg9bN7BUKNjtSpp/J
        aLNnYfiHrVnGimAg==
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 01/13] x86: Move posted interrupt descriptor out of
 vmx code
In-Reply-To: <20231207205431.75a214c2@jacob-builder>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-2-jacob.jun.pan@linux.intel.com>
 <87wmtruw87.ffs@tglx> <20231207205431.75a214c2@jacob-builder>
Date:   Fri, 08 Dec 2023 10:31:20 +0100
Message-ID: <875y19t507.ffs@tglx>
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

On Thu, Dec 07 2023 at 20:54, Jacob Pan wrote:
> On Wed, 06 Dec 2023 17:33:28 +0100, Thomas Gleixner <tglx@linutronix.de>
> wrote:
>> On Sat, Nov 11 2023 at 20:16, Jacob Pan wrote:
>> 	u32			rsvd[6];
>> } __aligned(64);
>> 
> It seems bit-fields cannot pass type check. I got these compile error.

And why are you telling me that instead if simply fixing it?
