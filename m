Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B2754648
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGOCjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 22:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGOCjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 22:39:19 -0400
Received: from mailgw.gate-on.net (auth.gate-on.net [IPv6:2001:278:1033:4::74:21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51805359F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 19:39:17 -0700 (PDT)
Received: from vega.pgw.jp (unknown [49.135.109.134])
        by mailgw.gate-on.net (Postfix) with ESMTP id 813E68018A;
        Sat, 15 Jul 2023 11:39:14 +0900 (JST)
Received: from localhost (vega.pgw.jp [10.5.0.30])
        by vega.pgw.jp (Postfix) with SMTP
        id 3562DA53D; Sat, 15 Jul 2023 11:39:11 +0900 (JST)
From:   <kkabe@vega.pgw.jp>
Content-Type: text/plain; charset=ISO-2022-JP
To:     rostedt@goodmis.org
Cc:     kkabe@vega.pgw.jp, regressions@lists.linux.dev,
        bagasdotme@gmail.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer dereference,address:00000004
In-Reply-To: Your message of "Fri, 14 Jul 2023 10:00:19 -0400".
        <20230714100019.6bf9b1ab@gandalf.local.home>
X-Mailer: mnews [version 1.22PL5] 2002-11-27(Wed)
Date:   Sat, 15 Jul 2023 11:39:11 +0900
Message-ID: <230715113911.M0124687@vega.pgw.jp>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rostedt@goodmis.org sed in <20230714100019.6bf9b1ab@gandalf.local.home>

>> On Fri, 14 Jul 2023 14:34:04 +0900
>> <kkabe@vega.pgw.jp> wrote:
>> 
>> > >> > So I'm confused about why it's mentioned. Was it backported?  
>> > >> 
>> > >> Taketo Kabe, could you please help to clean this confusion up? Did you
>> > >> mean 5.19 in https://bugzilla.kernel.org/show_bug.cgi?id=217669#c5 ? And
>> > >> BTW: did you really use a vanilla kernel for your bisection?  
>> > 
>> > 
>> > Reporter Me:
>> > I bisected using freedesktop.org kernel tree, which git commit ID is
>> > in sync with kernel.org
>> > but version number in ./Makefile could be slighty behind. 
>> > 
>> > Patch in
>> > https://bugzilla.kernel.org/show_bug.cgi?id=217669#c4
>> > fixed the problem in freedesktop.org kernel 5.18.0-rc2 .
>> > This may explain that in kernel.org tree, the said commit is in kernel-5.19.
>> 
>> Even if the bisect did land on this commit, it doesn't make sense. I would
>> think that one of the results of the bisect was incorrect (a pass that
>> should have failed?), as that would lead the bisect down to the wrong
>> conclusion.
>> 
>> Now if you you remove this commit and everything works fine, and add it
>> back again and it fails reliably, then I can't argue it is not the commit.

I agree with that it does not make sense.
But reverting that commit made the freedesktop.org kernel-5.18-0-rc2 not panic,
and adding it back made kernel panic
(actually, check for vblank->worker==NULL fires)

>> 
>> But the commit in question kicks off a worker thread at boot up to search
>> for weak functions that were tagged to be traced by the function tracer and
>> sets them to "disabled" to never be traced.
>> 
>> Is the function tracer used at all here? I really do not see how this
>> commit affects the code that is crashing. Unless there's something wrong
>> with the way the kworker was set up and it corrupted other kworkers :-/
>> -- Steve

Yes, this is puzzling. That's why I need other people's opinion on this.
Does it matter the DUT is a slow machine (Pentium 120MHz)?

-- 
kabe

