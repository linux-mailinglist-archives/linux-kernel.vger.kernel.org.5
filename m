Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0157D6A28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjJYLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJYLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:30:10 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC88130;
        Wed, 25 Oct 2023 04:30:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qvc5N-00084y-OX; Wed, 25 Oct 2023 13:30:05 +0200
Message-ID: <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
Date:   Wed, 25 Oct 2023 13:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Content-Language: en-US, de-DE
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <20230904133321.104584-1-git@andred.net>
 <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
 <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698233407;c10736fc;
X-HE-SMSGID: 1qvc5N-00084y-OX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Miklos, I'm wondering what the status here is. The description in the
reverts André sent[1] are maybe a bit vague[2], but it sounds a lot like
he ran into a big regression that should be addressed somehow -- maybe
with a revert. But it seems we haven't got any closer to that in all
those ~7 weeks since the first revert was posted. But I might be missing
something, hence a quick evaluation from your side would help me a lot
here to understand the situation.

[1]
https://lore.kernel.org/lkml/20230904133321.104584-1-git@andred.net/
https://lore.kernel.org/lkml/20231018111508.3913860-1-git@andred.net/

[2] Does this happen on all Android versions or just some? And what is
actually breaking (this was answered somewhere in the thread iirc)?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

On 18.10.23 17:51, Bernd Schubert wrote:
> On 10/18/23 16:40, Bernd Schubert wrote:
>> On 10/18/23 16:26, André Draszik wrote:
>>> On Wed, 2023-10-18 at 11:52 +0000, Bernd Schubert wrote:
>>>> On 10/18/23 13:46, André Draszik wrote:
>>>>> On Wed, 2023-10-18 at 11:39 +0000, Bernd Schubert wrote:
>>>>>> On 10/18/23 13:15, André Draszik wrote:
>>>>>>> From: André Draszik <andre.draszik@linaro.org>
>>>>>>>
>>>>>>> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
>>>>>>>
>>>>>>> This patch breaks all existing userspace by requiring updates
>>>>>>> as
>>>>>>> mentioned in the commit message, which is not allowed.
>>>>>>>
>>>>>>> Revert to restore compatibility with existing userspace
>>>>>>> implementations.
>>>>>>
>>>>>> Which fuse file system does it exactly break? In fact there
>>>>>> haven't
>>>>>> been
>>>>>> added too many flags after - what exactly is broken?
>>>>>
>>>>> The original patch broke the existing kernel <-> user ABI by now
>>>>> requiring user space applications to pass in an extra flag.
>>>>> There are various side-effects of this, like unbootable systems,
>>>>> just
>>>>> because the kernel was updated.
>>>>> Breaking the ABI is the one thing that is not allowed. This is not
>>>>> specific to any particular fuse file system.
>>>>
>>>> How exactly did it break it?
>>>
>>> At least in Android, creating new files, or reading existing files
>>> returns -EFAULT
>>
>> Hmm, could you please point me to the corresponding android userspace 
>> library? I guess it is not using libfuse? At least I would like to 
>> understand the issue...
>>
>>>
>>>>   These are feature flags - is there really a
>>>> file system that relies on these flag to the extend that it does not
>>>> work anymore?
>>>
>>> I don't know enough about the implementation details, but even outside
>>> Android user space had to be updated as a prerequisite for this kernel
>>> patch:
>>> https://lore.kernel.org/all/YmUKZQKNAGimupv7@redhat.com/
>>> https://github.com/libfuse/libfuse/pull/662
>>>
>>> Which means any non-Android user space predating those changes isn't
>>> working anymore either.
>>
>> The patch in libfuse is from me, there was nothing broken.
>> And I don't think that any of the additional flags added are a 
>> _requirement_ for libfuse file systems to work. I'm not sure if DAX and 
>> the other flags before the patch was merged are a _requirement_ for 
>> virtiofsd or just a nice feature to have...
> 
> 
> Looking at the android kernel source:
> 
> /*
>   * For FUSE < 7.36 FUSE_PASSTHROUGH has value (1 << 31).
>   * This condition check is not really required, but would prevent having a
>   * broken commit in the tree.
>   */
> #if FUSE_KERNEL_VERSION > 7 ||                                                 \
>          (FUSE_KERNEL_VERSION == 7 && FUSE_KERNEL_MINOR_VERSION >= 36)
> #define FUSE_PASSTHROUGH (1ULL << 63)
> #else
> #define FUSE_PASSTHROUGH (1 << 31)
> #endif
> 
> 
> So passthrough gets broken with this check and android heavily uses that.
> Would be interesting to know if this could result in EFAULT.
> 
> 
> Thanks,
> Bernd
