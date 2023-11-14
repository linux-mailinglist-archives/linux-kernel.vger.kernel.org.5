Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554D7EB48B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjKNQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjKNQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:11:55 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8FDF0;
        Tue, 14 Nov 2023 08:11:51 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:33842)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r2w0z-00Cbqy-Ug; Tue, 14 Nov 2023 09:11:50 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:46168 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r2w0x-00FFJ1-QV; Tue, 14 Nov 2023 09:11:49 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>, sonicadvance1@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        oleg@redhat.com, yzaikin@google.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, dave@stgolabs.net,
        joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
        <e673d8d6-bfa8-be30-d1c1-fe09b5f811e3@redhat.com>
        <202310091034.4F58841@keescook>
        <8dc5069f-5642-cc5b-60e0-0ed3789c780b@igalia.com>
        <871qctwlpx.fsf@email.froward.int.ebiederm.org>
        <9f83d97e-b7a1-4142-8316-088b3854c30d@redhat.com>
Date:   Tue, 14 Nov 2023 10:11:15 -0600
In-Reply-To: <9f83d97e-b7a1-4142-8316-088b3854c30d@redhat.com> (David
        Hildenbrand's message of "Mon, 13 Nov 2023 20:16:49 +0100")
Message-ID: <87ttpouxgc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r2w0x-00FFJ1-QV;;;mid=<87ttpouxgc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18A0u86nlnYSNcejSdGhCmXdqM80fiLBAM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Hildenbrand <david@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1546 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 0.69
        (0.0%), extract_message_metadata: 9 (0.6%), get_uri_detail_list: 1.47
        (0.1%), tests_pri_-2000: 4.0 (0.3%), tests_pri_-1000: 2.1 (0.1%),
        tests_pri_-950: 0.99 (0.1%), tests_pri_-900: 0.81 (0.1%),
        tests_pri_-90: 81 (5.2%), check_bayes: 80 (5.2%), b_tokenize: 7 (0.4%),
         b_tok_get_all: 9 (0.6%), b_comp_prob: 2.1 (0.1%), b_tok_touch_all: 59
        (3.8%), b_finish: 0.65 (0.0%), tests_pri_0: 312 (20.2%),
        check_dkim_signature: 0.40 (0.0%), check_dkim_adsp: 2.3 (0.1%),
        poll_dns_idle: 1116 (72.2%), tests_pri_10: 1.67 (0.1%), tests_pri_500:
        1128 (72.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 13.11.23 19:29, Eric W. Biederman wrote:
>> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
>> 
>>> On 09/10/2023 14:37, Kees Cook wrote:
>>>> On Fri, Oct 06, 2023 at 02:07:16PM +0200, David Hildenbrand wrote:
>>>>> On 07.09.23 22:24, Guilherme G. Piccoli wrote:
>>>>>> Currently the kernel provides a symlink to the executable binary, in the
>>>>>> form of procfs file exe_file (/proc/self/exe_file for example). But what
>>>>>> happens in interpreted scenarios (like binfmt_misc) is that such link
>>>>>> always points to the *interpreter*. For cases of Linux binary emulators,
>>>>>> like FEX [0] for example, it's then necessary to somehow mask that and
>>>>>> emulate the true binary path.
>>>>>
>>>>> I'm absolutely no expert on that, but I'm wondering if, instead of modifying
>>>>> exe_file and adding an interpreter file, you'd want to leave exe_file alone
>>>>> and instead provide an easier way to obtain the interpreted file.
>>>>>
>>>>> Can you maybe describe why modifying exe_file is desired (about which
>>>>> consumers are we worrying? ) and what exactly FEX does to handle that (how
>>>>> does it mask that?).
>>>>>
>>>>> So a bit more background on the challenges without this change would be
>>>>> appreciated.
>>>>
>>>> Yeah, it sounds like you're dealing with a process that examines
>>>> /proc/self/exe_file for itself only to find the binfmt_misc interpreter
>>>> when it was run via binfmt_misc?
>>>>
>>>> What actually breaks? Or rather, why does the process to examine
>>>> exe_file? I'm just trying to see if there are other solutions here that
>>>> would avoid creating an ambiguous interface...
>>>>
>>>
>>> Thanks Kees and David! Did Ryan's thorough comment addressed your
>>> questions? Do you have any take on the TODOs?
>>>
>>> I can maybe rebase against 6.7-rc1 and resubmit , if that makes sense!
>>> But would be better having the TODOs addressed, I guess.
>> Currently there is a mechanism in the kernel for changing
>> /proc/self/exe.  Would that be reasonable to use in this case?
>> It came from the checkpoint/restart work, but given that it is
>> already
>> implemented it seems like the path of least resistance to get your
>> binfmt_misc that wants to look like binfmt_elf to use that mechanism.
>
> I had that in mind as well, but
> prctl_set_mm_exe_file()->replace_mm_exe_file() fails if the executable
> is still mmaped (due to denywrite handling); that should be the case
> for the emulator I strongly assume.

Bah yes.  The sanity check that that the old executable is no longer
mapped does make it so that we can't trivially change the /proc/self/exe
using prctl(PR_SET_MM_EXE_FILE).

Eric

