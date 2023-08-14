Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E5F77BEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjHNRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHNRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:07:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C1D1;
        Mon, 14 Aug 2023 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692032838; x=1692637638; i=deller@gmx.de;
 bh=O6FC77jA40UipPH7wHgfAz5EUXSuaIs2l06BL8t8ibM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fEamrH3ObHqm2ysIC2hkj1tOklci8lurWcFJptXXfdhGJzPlQ3dr/EEmXZX3ox1fHmYBjAc
 ow9W3ogix3+t0Q7IJz2XZfQK6PtVIaBwlAV+H/brZyTDrvVWHHxVycNHTrP2PhT92TVfSEgX9
 Zzc+G622+bwTCgfQzmABhYCEf9BdW+c88Y/gzbQnB9u1k4quT5mzwFzJwGHN92keHJl4y1hyB
 oXU2Q9Kt9K0n3n1BNucAqvidn5cXaiB1GvAd4q4l5Oxa/U1/EVTucBmvktA1GBe3omO5pnKg7
 KnoxAa0tDemSjtn0ajUo3cInXUYyhni/REA7n0EUJWGBELnWWJHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.155.72]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1qNJ1k1qZa-00SBDN; Mon, 14
 Aug 2023 19:07:18 +0200
Message-ID: <3f7c0eb0-d894-aa36-ed20-d09d525d719c@gmx.de>
Date:   Mon, 14 Aug 2023 19:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] lockdep: Fix static memory detection even more
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-parisc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Borislav Petkov <bp@suse.de>
References: <ZNep5EcYskP9HtGD@p100>
 <202308141646.d3160c77-oliver.sang@intel.com>
 <20230814141710.GL776869@hirez.programming.kicks-ass.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230814141710.GL776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rfl1ljwOxAusUvzqwFnIHSkLvGNwxVYUl9XL2Znpwzd42sJAnEs
 mjFbKd7W0tJB149+zAhSo0KtCCbWD4SE38sMed+WXEmGAk2YeEZneaLkb6a+P4wqiTzA91o
 RDr+ATFgvUumnWrGEGtl2QVzRKQgj3P3ZktqE6wcUmOxMp1vqnclzmFMFp/zKb2eaWFs8zN
 nE0vND7iyIG/pAwv89Yuw==
UI-OutboundReport: notjunk:1;M01:P0:PVsu9daNUBU=;HbmaDYsgH6cfy5Yq7WgJI98qCWl
 5+xyE7wEMFdCw5PAD7wAhPPCvOlkfNWkJx579A8uZMe+HkYlsfQrmKb3a+dtM6uenGZlNLelx
 bs1VlCVWGSfVPexYVrNnvyEfu/Jqr33spQGHxUHvrTV8nQTHozRUVqs7SXZPEFoet4IHpQY8h
 76QCHFWlpJ+z23XMy56sRPXP98nVarIA1EPTJ8hvkPI6hi9FAvISI/azvZTZHe8zGaq0XuXfA
 /lSH2ytH1sneMuctTRXfB1Bo9lARB6sASTAs55IjWlanwAa7AZhjeQ4m4QMQIwCd6/QUGQUvp
 U5RZjm9OWipkppkVid04Mq8teNURFTGGKmhx0QzysWEXvtVqrUnkjV/kMqUoxba2Jt2RhBw8h
 PLZXbK2K26cSOwDBwjHJNjpOfcJBDD4IPNvuVxaHf/dJgu8soqFV9AfUrFk1YmytQSyUrFOR9
 DjQAWOZl4cCI6aCUPuRZ4cP84H64QGuPnI0RHxqFGDHdy/nWZ5+JV5K9+BFqVwbp/p2uRYGIf
 SjzQ14f1ZWgBFEUNTOmEbm65BwJTBKXWDAjGPImYq4LeNEY32W+tSevdyPWRkmcv0KnG9tVx4
 RZ5yZ4I7Zdq2ndU10VV5ajBKUf88+RghtXGpqs8dVWtWt0sngDKXCxJBN3HNnGx+w5OvgX05n
 N+ObPZPjJAYOKEwHw1y5Kae8snwuaTVXmwmopHcfoK7CFNobgLlxSopi/VjNP3kcLrjolBj9j
 3mugZy3I+ZFJcidYXTelk3vprt4KTCZke6JYPwXBimJ5Z39JLaHetQWq78XY8O89DcfPwXh65
 BVHobcv5WtEI/3NOqArARmw3xVK36ihpJYBSeEprFHeHPTAQ7i1KdgNNN5FiM8kdjahsmr1XX
 k+CU/h7GuDY1PPRLlKhQhUSHvD2WNjCM1TCPhGd6XZ0vSxU2Dn7J23p5XdPomx8t78mMjax8b
 mRtg1T7nlYo96BHrJc1Ye/h6uw0=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 16:17, Peter Zijlstra wrote:
> On Mon, Aug 14, 2023 at 09:40:42PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "BUG:key#has_not_been_registered" on:
>>
>> commit: 94d4413e506da48ea18f1cc982202874d35c76b1 ("[PATCH] lockdep: Fix=
 static memory detection even more")
>> url: https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/lockde=
p-Fix-static-memory-detection-even-more/20230812-235022
>> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-every=
thing
>> patch link: https://lore.kernel.org/all/ZNep5EcYskP9HtGD@p100/
>> patch subject: [PATCH] lockdep: Fix static memory detection even more
>>
>> in testcase: boot
>>
>> compiler: gcc-12
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202308141646.d3160c77-oliver.s=
ang@intel.com
>>
>>
>>
>> [    0.575811][    T1] BUG: key b35c282c has not been registered!
>> [    0.576580][    T1] ------------[ cut here ]------------
>> [    0.577216][    T1] DEBUG_LOCKS_WARN_ON(1)
>> [    0.577236][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep=
.c:4888 lockdep_init_map_type+0x155/0x250
>> [    0.578389][    T1] Modules linked in:
>> [    0.578856][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-=
rc4-00587-g94d4413e506d #2
>
>> [    0.595653][    T1]  __kernfs_create_file+0x6a/0xe0
>> [    0.596244][    T1]  sysfs_add_bin_file_mode_ns+0x4e/0xc0
>> [    0.596891][    T1]  sysfs_create_bin_file+0x5c/0x90
>> [    0.597496][    T1]  ? nsproxy_cache_init+0x30/0x30
>> [    0.598090][    T1]  ksysfs_init+0x5c/0x90
>
> Problem seems to be __ro_after_init. Your patch only considers
> is_kernel_core_data(), which seems to not include these other fancy data
> sections we have.

Thanks for that hint!
So, adding "if (is_kernel_rodata(addr))..."
I'll test and send a new patch.

Helge

