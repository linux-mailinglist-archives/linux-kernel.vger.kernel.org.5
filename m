Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECB753155
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjGNFfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjGNFeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:34:36 -0400
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Jul 2023 22:34:06 PDT
Received: from mailgw.gate-on.net (auth.gate-on.net [IPv6:2001:278:1033:4::74:21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608430C6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:34:06 -0700 (PDT)
Received: from vega.pgw.jp (unknown [49.135.109.134])
        by mailgw.gate-on.net (Postfix) with ESMTP id 492DC80189;
        Fri, 14 Jul 2023 14:34:05 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
        by vega.pgw.jp (Postfix) with SMTP
        id CC1D8A53D; Fri, 14 Jul 2023 14:34:04 +0900 (JST)
From:   <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To:     regressions@lists.linux.dev
Cc:     bagasdotme@gmail.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, rostedt@goodmis.org,
        kkabe@vega.pgw.jp
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference, address:00000004
In-Reply-To: Your message of "Fri, 14 Jul 2023 05:44:07 +0200".
        <55a3bbb1-5b3c-f454-b529-8ee9944cc67c@leemhuis.info>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date:   Fri, 14 Jul 2023 14:34:04 +0900
Message-ID: <230714143404.M0123570@vega.pgw.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks you all for getting attention to the report: 

regressions@leemhuis.info sed in <55a3bbb1-5b3c-f454-b529-8ee9944cc67c@leemhuis.info>

>> On 14.07.23 05:12, Steven Rostedt wrote:
>> > On Fri, 14 Jul 2023 09:50:17 +0700
>> > Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> > 
>> >> I notice a regression report on Bugzilla [1]. Quoting from it:
>> >>
>> >>
>> >> See Bugzilla for the full thread and attached patches that fixes
>> >> this regression.
>> >>
>> >> Later, when bisecting, the reporter got better kernel trace:
>> >>
>> >>> [  469.825305] BUG: kernel NULL pointer dereference, address: 00000004
>> >>> [  469.830502] #PF: supervisor read access in kernel mode
>> >>> [  469.830502] #PF: error_code(0x0000) - not-present page
>> >>> [  469.830502] *pde = 00000000
>> >>> [  469.830502] Oops: 0000 [#1] PREEMPT SMP
>> >>> [  469.830502] CPU: 0 PID: 365 Comm: systemd-udevd Not tainted 5.14.0-221.el9.v1.i586 #1
>> > 
>> > This is a 5.14 kernel right?
>> 
>> And a vendor kernel that from the sound of the version number might be
>> heavily patched. But apparently the reporter later bisected this on a
>> newer kernel (Bagas, would have been good if this had been mentioned in
>> your earlier mail):
>> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5
>> ```
>> I succeeded to bisect down the regressing commit found in kernel-5.18.0-rc2:
>> 
>> b39181f7c690 (refs/bisect/bad) ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to
>> avoid adding weak function
>> 
>> This at a glance does not relate to drm/kms code.
>> 
>> The attached patch effectively reverts the commit for 32bit.
>> This fixed the problem on kernel-5.18.0, but not enough for kernel-6.4.3 ```
>> 
>> That being said: That commit is not in 5.18, as Steve noticed:
>> 
>> >> #regzbot introduced: b39181f7c6907d https://bugzilla.kernel.org/show_bug.cgi?id=217669
>> >> #regzbot title: FTRACE_MCOUNT_MAX_OFFSET causes kernel NULL pointer dereference and virtual console (tty1) freeze
>> > That commit was added in 5.19.
>> > 
>> > So I'm confused about why it's mentioned. Was it backported?
>> 
>> Taketo Kabe, could you please help to clean this confusion up? Did you
>> mean 5.19 in https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5 ? And
>> BTW: did you really use a vanilla kernel for your bisection?


Reporter Me:
I bisected using freedesktop.org kernel tree, which git commit ID is
in sync with kernel.org
but version number in ./Makefile could be slighty behind. 

Patch in
https://bugzilla.kernel.org/show_bug.cgi?id=217669#c4
fixed the problem in freedesktop.org kernel 5.18.0-rc2 .
This may explain that in kernel.org tree, the said commit is in kernel-5.19.


>> TWIMC, there is also
>> https://bugzilla.kernel.org/show_bug.cgi?id=217669#c6 :
>> ```
>> Attached patch sort of fixes the problem; it does not panic and
>> KMS console works, but printk is triggered 4 times on radeon.ko load and
>> when VGA connector is plugged in.
>> 
>> I am sort of at loss now; I need advice from people which knows better.
>> 
>>  --- ./drivers/gpu/drm/drm_internal.h.rd	2023-06-25 21:35:27.506967450 +0900
>>  +++ ./drivers/gpu/drm/drm_internal.h.rd	2023-06-25 21:36:34.758055363 +0900
>>  @@ -99,6 +99,10 @@ u64 drm_vblank_count(struct drm_device *
>>   /* drm_vblank_work.c */
>>   static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblank)
>>   {
>>  +	if (!vblank->worker) {
>>  +		printk(KERN_WARNING "%s: vblank->worker NULL? returning\n", __func__);
>>  +		return;
>>  +	}
>>   	kthread_flush_worker(vblank->worker);
>>   }
>> ```
>> 
>> Ciao, Thorsten
>> 
