Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE775AAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjGTJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGTJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:50 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE22727
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:13:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2F9960012;
        Thu, 20 Jul 2023 09:13:36 +0000 (UTC)
Message-ID: <90c8509f-bd0a-4996-adca-86f6116b5129@ghiti.fr>
Date:   Thu, 20 Jul 2023 11:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/10] riscv: Allow userspace to directly access perf
 counters
Content-Language: en-US
To:     Atish Patra <atishp@atishpatra.org>,
        =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        Mathieu Malaterre <malat@debian.org>,
        Jan Newger <jannewger@google.com>
References: <20230703124647.215952-1-alexghiti@rivosinc.com>
 <8756384.Zvl9fuB8X0@basile.remlab.net>
 <CAOnJCU+W9u+HnMfjU_y9W7331Zx07eQs9R1twV0=KsBAeSMSjw@mail.gmail.com>
 <5951331.lOV4Wx5bFT@basile.remlab.net>
 <CAOnJCUKCx0Jh1igZytKAYePhhUBt=x5ANCVx4FRTbLtxGkyowA@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAOnJCUKCx0Jh1igZytKAYePhhUBt=x5ANCVx4FRTbLtxGkyowA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish, Rémi,


On 19/07/2023 19:14, Atish Patra wrote:
> On Wed, Jul 19, 2023 at 7:46 AM Rémi Denis-Courmont <remi@remlab.net> wrote:
>> Le keskiviikkona 19. heinäkuuta 2023, 1.48.49 EEST Atish Patra a écrit :
>>>> Isn't RDTIM susceptible to interference from power management and CPU
>>>> frequency scaling? I suppose that RDCYCLE may behave differently depending
>>>> on PM in *some* designs, but that would still be way better than RDTIME
>>>> for the purpose.
>>> Yes. But that's what it is probably using for other ISAs ?
>> At least on AArch64, it is using either Linux perf cycle counter, or if that
>> is disabled at build time, the raw PMU cycle counter - which obviously leads
>> to SIGILL on Linux, just like this MR would do with RDCYCLE.
>>
> Good to know. Thanks for the clarification.
>
>> Again, I do not *personally* have objections to disabling RDCYCLE for
>> userspace (somebody else does, but that's neither my nor your problem). I do
>> have objections to the wording of some of the commit messages though.
>>
> Completely agreed. We will update the commit text with more clarification in v5.


Thanks for all your comments and sorry for being slow here. I will 
improve the commit logs in the next version, that's an oversight, sorry 
about that.

Thanks again,

Alex


>
>>> My point was it should just do whatever it does for other ISA. RISC-V is no
>>> special in that regard.
>> Sure. My point is that RDTIME may be great for, so to say, system-level
>> benchmarks. For FFmpeg that could something like how long it takes to
>> transcode a video. But it doesn't seem to make much sense for
>> microbenchmarking of single threaded tightly optimised loops, as opposed to
>> RDCYCLE (or a wrapper for RDCYCLE).
>>
>> --
>> Rémi Denis-Courmont
>> http://www.remlab.net/
>>
>>
>>
>
