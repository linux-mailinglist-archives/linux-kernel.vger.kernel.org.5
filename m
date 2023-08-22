Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BB7839BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHVGHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjHVGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:07:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30E185
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:07:03 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E37861EC0103;
        Tue, 22 Aug 2023 08:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692684422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+f3OoNYZr5R+2gmWTYysQEDi/jCkwT5jgj4nIZaUJQs=;
        b=ZHI6yeyl2dX2MQ0qOWmYE28slmNhFT9ABDedYEk2b1kni1ebZ+1jaarzGfuB+92dZb5j+9
        2rD+39MHPiy2Uoz3WIlVrRe9TcOFaLyDV2uqhB5b7z+czaTmai9TZmkx2buVVPjQnCf+rA
        qznLSk5i3C5P4+rqxXPbz52qBroGS34=
Date:   Tue, 22 Aug 2023 08:07:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/22] x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
Message-ID: <20230822060706.GEZORQiq136ZR5Tnc0@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <23a121e309d5e880eb35c441d9bdfa642d6d59f4.1692580085.git.jpoimboe@kernel.org>
 <20230821141619.GCZONxs5OdbbXFYSq2@fat_crate.local>
 <20230821163649.dyhxdeewlf6eerda@treble>
 <20230822055452.GDZORNrNdYc3OmGygU@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822055452.GDZORNrNdYc3OmGygU@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 07:54:52AM +0200, Borislav Petkov wrote:
> If you goto pred_cmd, you will overwrite it with PRED_CMD_SBPB here.

Looking at this more:

"If SRSO mitigation is not required or is disabled, software may use
SBPB on context/virtual machine switch to help protect against
vulnerabilities like Spectre v2."

I think we actually want this overwrite to happen.

But then if retbleed=ibpb, entry_ibpb() will do bit 0 unconditionally...

Hmm, lemme talk to people.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
