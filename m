Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D47C91F0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJNA7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJNA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:59:39 -0400
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5355BE;
        Fri, 13 Oct 2023 17:59:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=HBXsmAGmocJo6yoWBhkrgxNZCb9WtBCbFZetm3/XVE8=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230917; t=1697245166; v=1; x=1697677166;
 b=YbEaADeEU+Zf33KJ3Lum1ryo7UJhiVENwcitc417ymfUrcTDld2xvLxEQ2nRbQhVGNLSTRmg
 VGP/4ZxYHid4nX6Lt57LsZ4TZSS/HhWo4g9WC4BfWpNGFm58AoEbfoKhqkEHPevLAGC84OYXVH6
 II2wEh3/g5dxY/sMYwwaZOrJE1sPmHWmKdiACNPSoKppU7ewTsYaf1kRLmkgx8QbAV0UkTz5Pka
 jbpgiT3c5kV26/sF1jXLHC3zguK0nOarCH7l8YuPj4p49BksXbkmiqvbuRwm2+fMX0TvwimPAZB
 ZMWczcFsAgWIqfOWl96YOJGh2gCu7iDJtVzTIze68O4rerUb8Di9bGGaqtKZPWas0F3IkAj58hG
 0o+zFV1+xBcmMks7Z+azSyKVfxQZxShg5LcS1VXg6KyeP88OngzHCr4WHttyv8GrtbAf1ehAz+/
 4adbYFVH7DV6pHJqHCVJUEGHifRDoaKyjTHA4Z7IBs5vM8hH2n2Tp09XxmE1YEJjYYpnF6IPLrh
 q6DHymHy/K/TVMReDF4uWf4RcXKjtPNNIYDmTb9B/ZJIQ5Bx5RSGQfjGCLOhv63HWohjDs+UuJg
 3arSMb6N0x+sjQrhZhAiLqFUBAbMXoOEykMZWiEy/r+P7GGOv9m5WrlG+oBmn+49PAJg3+xXudI
 ttE1RPOv2yk=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id c713fbfd; Fri, 13 Oct
 2023 20:59:26 -0400
MIME-Version: 1.0
Date:   Fri, 13 Oct 2023 20:59:26 -0400
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Steve French <smfrench@gmail.com>
Cc:     Paulo Alcantara <pc@manguebit.com>,
        "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>,
        Tom Talpey <tom@talpey.com>, Paul Aurich <paul@darkrain42.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Regressions <regressions@lists.linux.dev>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Brian Pardy <brian.pardy@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
In-Reply-To: <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me>
 <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
 <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
 <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
 <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
 <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
 <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
 <ZRN9MtBqYnT6oX60@vaarsuvius>
 <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
 <83d00d50bc628a85db71adb440d8afb5@matoro.tk>
 <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
 <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com>
 <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
Message-ID: <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-13 20:13, Steve French wrote:
> Let me know if those fixes help as two of them have not been sent to 
> Linus
> yet, but I could send tomorrow
> 
> On Fri, Oct 13, 2023, 19:01 Paulo Alcantara <pc@manguebit.com> wrote:
> 
>> You probably want these two as well
>> 
>> 
>> https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=2da338ff752a2789470d733111a5241f30026675
>> 
>> 
>> https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=3b8bb3171571f92eda863e5f78b063604c61f72a
>> 
>> as directory leases isn't supported in SMB1, so no waste of system
>> resources by having those kthreads running.
>> 
>> On 13 October 2023 20:52:11 GMT-03:00, Paulo Alcantara 
>> <pc@manguebit.com>
>> wrote:
>> >Could you please try two commits[1][2] from for-next?
>> >
>> >[1]
>> https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=e95f3f74465072c2545d8e65a3c3a96e37129cf8
>> >[2]
>> https://git.samba.org/?p=sfrench/cifs-2.6.git;a=commit;h=81ba10959970d15c388bf29866b01b62f387e6a3
>> >
>> >On 13 October 2023 20:19:37 GMT-03:00, matoro <
>> matoro_mailinglist_kernel@matoro.tk> wrote:
>> >>On 2023-10-05 05:55, Dr. Bernd Feige wrote:
>> >>> Am Dienstag, dem 26.09.2023 um 17:54 -0700 schrieb Paul Aurich:
>> >>>> Perhaps the laundromat thread should be using msleep_interruptible()?
>> >>>>
>> >>>> Using an interruptible sleep appears to prevent the thread from
>> >>>> contributing
>> >>>> to the load average, and has the happy side-effect of removing the
>> >>>> up-to-1s delay
>> >>>> when tearing down the tcon (since a7c01fa93ae, kthread_stop() will
>> >>>> return
>> >>>> early triggered by kthread_stop).
>> >>>
>> >>> Sorry for chiming in so late - I'm also on gentoo (kernel 6.5.5-
>> >>> gentoo), but as a client of Windows AD.
>> >>>
>> >>> Just want to emphasize that using uninterruptible sleep has not just
>> >>> unhappy but devastating side-effects.
>> >>>
>> >>> I have 8 processors and 16 cifsd-cfid-laundromat processes, so
>> >>> /proc/loadavg reports a load average of 16 on a totally idle system.
>> >>>
>> >>> This means that load-balancing software will never start additional
>> >>> tasks on this system - "make -l" but also any other load-dependent
>> >>> system. Just reducing the number of cifsd-cfid-laundromat processes
>> >>> does not fix this - even a single one makes loadavg report a wrong
>> >>> result for load balancing.
>> >>>
>> >>> So, if cifsd-cfid-laundromat must really be uninterruptible, the only
>> >>> solution would be to change the way loadavg is computed by the kernel
>> >>> to exclude uninterruptible but sleeping processes. But must it be
>> >>> uninterruptible?
>> >>>
>> >>> Thanks and best regards,
>> >>> Bernd
>> >>
>> >>This is a huge problem here as well, as a client to Samba using SMB1
>> (for Unix extensions).
>> >>
>> >>For others encountering this problem, I was able to work around it with
>> the following snippet:
>> >>
>> >>diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
>> >>index 2d5e9a9d5b8b..fc2caccb597a 100644
>> >>--- a/fs/smb/client/cached_dir.c
>> >>+++ b/fs/smb/client/cached_dir.c
>> >>@@ -576,7 +576,7 @@ cifs_cfids_laundromat_thread(void *p)
>> >>        struct list_head entry;
>> >>
>> >>        while (!kthread_should_stop()) {
>> >>-               ssleep(1);
>> >>+               msleep_interruptible(1000);
>> >>                INIT_LIST_HEAD(&entry);
>> >>                if (kthread_should_stop())
>> >>                        return 0;
>> 

Do you have backports of these to 6.5?  I tried to do it manually but 
there's already so many changes between 6.5 and these commits.
