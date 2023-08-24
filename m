Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B4787884
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbjHXTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbjHXTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:31:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0498A1BDF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:31:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692905501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8yDla5pLPlOBoH9R5UIcl3zdGCQ45eLIUaoUZiqZRg=;
        b=ejX/5GLtjhWI5JeO1TOp5d81z6CBY7R1PnpW7jcjwnR38L2IWffvKTfybh4kHhlsIQfSMr
        FTHxlG1pKcqZc4tPisqaN1Gg0yDXlUMCS9Ami3l9iWFSYmSKTNABt6n7uzpUOOOq72WesW
        92OZ+qRM04nVUPu/ocGZdxkK9sJ5gxXl1n07ACwK7pZokxBw2ATffuBdFkDMakyaoziYhC
        s+MjyyQ8lWRacuIuy58aYKpapQUP0owAPi4o91kFLOeSFZM9K5EHgA2vI/0q125Zw5X1GS
        N5OevJcxtgueqJHelTkkG+wRYkNo79P2CVz0bUG0LAyM6mcRztVf33bXofA7xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692905501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8yDla5pLPlOBoH9R5UIcl3zdGCQ45eLIUaoUZiqZRg=;
        b=Uisgrkt/WrXB8xZZz2J41MLgpatWcrSm2tVY5eG8pt8YpjaLyLBnQACE7TBiS0AeUqfoAP
        jfK9dcm1Kxn1b7Bg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
In-Reply-To: <20230808200111.nz74tmschph435ri@box>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box>
Date:   Thu, 24 Aug 2023 21:31:39 +0200
Message-ID: <878ra0ck4k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 23:01, Kirill A. Shutemov wrote:
> On Tue, Aug 08, 2023 at 10:13:05AM -0700, Dave Hansen wrote:
>> On 8/8/23 09:23, Kirill A. Shutemov wrote:
>> ...
>> > On the other hand, other clock sources (such as HPET, ACPI timer,
>> > APIC, etc.) necessitate VM exits to implement, resulting in more 
>> > fluctuating measurements compared to TSC. Thus, those clock sources
>> > are not effective for calibrating TSC.
>> 
>> Do we need to do anything to _those_ to mark them as slightly stinky?
>
> I don't know what the rules here. As far as I can see, all other clock
> sources relevant for TDX guest have lower rating. I guess we are fine?

Ideally they are not enumerated in the first place, which prevents the
kernel from trying.

> There's notable exception to the rating order is kvmclock which is higher
> than tsc.

Which is silly aside of TDX.

> It has to be disabled, but it is not clear to me how. This topic
> is related to how we are going to filter allowed devices/drivers, so I
> would postpone the decision until we settle on wider filtering schema.

TDX aside it might be useful to have a mechanism to select TSC over KVM
clock in general.

Thanks,

        tglx
