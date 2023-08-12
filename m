Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3454377A0EB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHLPyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:54:09 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E62FE4D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:54:09 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A11532015D.A4933
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id A11532015D;
        Sat, 12 Aug 2023 17:54:07 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691855647;
        bh=P6FEmoLxV8JB8AYhhMj1qcPRhLPi1LeHTiWlZA36uKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H8+Xs9u/UF/giR1mL6aggaisc2HJOlmXfiOSQp273eyHqvQqDaN9VMSSVdOD6L4/O
         22UvqTAvCRjN/N4wi8M4uWwTMlrrnj7VzLgECRaqYtNX8p+goufLsZF428+FsLwCnw
         QAuseusqaGtUbhuP8Iq8R45JvpIGOqi1wOjVSWCM=
Received: from [10.11.22.164] (rrcs-24-123-120-98.central.biz.rr.com [24.123.120.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 827B6D4EBFAB3;
        Sat, 12 Aug 2023 17:54:05 +0200 (CEST)
Message-ID: <3f9db8a8-0be0-fa21-7919-0d89e057f50e@cs.kuleuven.be>
Date:   Sat, 12 Aug 2023 08:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
 <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
 <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
 <3a4bf401-0781-492f-a952-3c96c1507551@intel.com>
 <b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <b9bbb279-fa8f-0784-900f-114ce186cbb3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.23 17:08, Dave Hansen wrote:
> On 8/11/23 16:58, Sohil Mehta wrote:
>> I agree this doesn't have to be this complex. PTI_FORCE_AUTO is unnecessary.

> It's worth *ZERO* hassle.  The docs say:
> That's 100% unambiguous.
> 
> If you do "mitigations=off pti=auto", you might as well have done
> "pti=auto nopti" which is nonsense.
> 
> The kernel shouldn't fall over and die, but the user gets to hold the
> (undefined) pieces at this point.
> 
> Please let's not make this more complicated than it has to be.

Thank you both for the suggestions. I agree the code got overly complex 
and unnecessary when users are clearly passing conflicting options. So I 
prepared another patch iteration to largely revert back to the original 
proposed patch, i.e., *without* backwards compatible behavior when pti= 
nopti and mitigations=off are erroneously combined.

I'll post the new patch shortly.

Best,
Jo
