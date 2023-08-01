Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE64776A5BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjHAAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHAAtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:49:05 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 17:49:02 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8B4D11D;
        Mon, 31 Jul 2023 17:49:02 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:18c3:f7f6:8527:d23e] (unknown [IPv6:2a02:8010:68a1:0:18c3:f7f6:8527:d23e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id A5E34734;
        Tue,  1 Aug 2023 01:43:41 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A5E34734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1690850621;
        bh=z2xpW/s+dG8OC7kM4UbQnTxycaJkRZfSUILTGNhbKQs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RF4J3Q8GFNyjJUe8+l2sx/aJvvUwljzTlrJMbHSUU30Kjx/iErR0XjoS+iy7ziP2R
         /1RBmLgVM1AYq799fcvp6ocq8mDy0k3ebescAE9lI96VRUDmi+jnah7tOtgZgkL+AS
         a9Ab7tBTWCfocDn4WhzJyk/aiFaQ9u9xusBiqGbM=
Message-ID: <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
Date:   Tue, 1 Aug 2023 01:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Rich Felker <dalias@libc.org>, linux-x86_64@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com>
 <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx>
 <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx>
 <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
 <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx>
 <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
 <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2020 22:55, Andy Lutomirski wrote:
> On Sat, Dec 5, 2020 at 4:01 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>
> 
>> Ping?
> 
> Can you submit patches implementing my proposal?  One is your existing
> patch plus fixing struct msghdr, with Cc: stable@vger.kernel.org at
> the bottom.  The second is a removal of struct msghdr from uapi,
> moving it into include/inux (no uapi) if needed.  The second should
> not cc stable.

Hi,

This looks like it was forgotten, but it is still needed. Jessica, are 
you interested in submitting the requested change? If not, would it be 
okay if I do so? I have been running this locally for a long time now.

There is one complication that I think has not been mentioned yet: when 
_GNU_SOURCE is defined, glibc does provide a definition of struct msghdr 
in <sys/msg.h> with a field "__syscall_slong_t mtype;". This makes it 
slightly more likely that there is code out there in the wild that works 
fine with current kernels and would be broken by the fix. Given how rare 
x32 is, and how rare message queues are, this may still be acceptable, 
but I am mentioning it just in case this would cause a different 
approach to be preferred. And whatever is done, a fix should also be 
submitted to glibc.

(musl define struct msghdr as well, but defines mtype unconditionally as 
having type long, so if this approach is still preferred, needs no changes.)

Cheers,
Harald van Dijk
