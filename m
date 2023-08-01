Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9876B47B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHAMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjHAMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:22 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8007719A1;
        Tue,  1 Aug 2023 05:15:19 -0700 (PDT)
Received: from [192.168.178.44] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 9789C1118;
        Tue,  1 Aug 2023 13:15:18 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 9789C1118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1690892118;
        bh=OAnzIZ5FOMw8kuNYG4/Nz/Khly/B4xPeBb+FdLMl5l0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VgGNg7q153abiiNMieCoigqpP37zG16C8v9iZfq3nmukyjdZhyxiss6yE9BDkbhw7
         Mrvg66rCyma2DWFlBbdOhRgmj7ylIlfwwYWbzEsCNj5MDTEzr2zC4zJtT2DyHWvr6B
         /gfGIS9m7mKkR64HVgdh1+VOJufpPqOBMHl6d/Dk=
Message-ID: <24c07700-d335-1921-b64c-c748ca62d144@gigawatt.nl>
Date:   Tue, 1 Aug 2023 13:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rich Felker <dalias@libc.org>, linux-x86_64@vger.kernel.org,
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
 <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
 <87zg3b5j45.fsf@oldenburg.str.redhat.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <87zg3b5j45.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 08:15, Florian Weimer wrote:
> * Harald van Dijk:
> 
>> There is one complication that I think has not been mentioned yet:
>> when _GNU_SOURCE is defined, glibc does provide a definition of struct
>> msghdr in <sys/msg.h> with a field "__syscall_slong_t mtype;". This
>> makes it slightly more likely that there is code out there in the wild
>> that works fine with current kernels and would be broken by the
>> fix. Given how rare x32 is, and how rare message queues are, this may
>> still be acceptable, but I am mentioning it just in case this would
>> cause a different approach to be preferred. And whatever is done, a
>> fix should also be submitted to glibc.
> 
> What should glibc do here?  Just change the definition in the header to
> long and ignore the breakage?

Yes, I believe so, but perhaps for glibc it might make sense to wait a 
little bit to see if it does indeed go into the kernel in that form. If 
the kernel ends up preferring something else, the change needed in glibc 
might also be different.

Cheers,
Harald van Dijk
