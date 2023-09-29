Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8C7B3772
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjI2QDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2QDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:03:52 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2836195
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:03:47 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RxwBT28DwzMpntj;
        Fri, 29 Sep 2023 16:03:45 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RxwBS1ZLbzMppDK;
        Fri, 29 Sep 2023 18:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696003425;
        bh=9RrEUFMCn3XCiafqX02HANvSi6JI9RSYZUTuuo4vMGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmUDX9Yl22c3K6Uy7nyCVqGYQwEqgZeEyNfYJnWxrvzwh+DA4ecdNXsqCbRU7kZTg
         3a9bkB0Jx5c8RUeWWKss/4/P7rU0+vE7doSEsE3j1i9qydVx+80D8fWMuRc5vY7Mt9
         rY5hrhzoHGVCsRQTthsUUAGdMLSqO2MQGAniNVUY=
Date:   Fri, 29 Sep 2023 18:03:37 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/7] Landlock audit support
Message-ID: <20230928.ooP7aeghohqu@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
 <ZRMFwNzBJyyr85hV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRMFwNzBJyyr85hV@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:24:32PM +0200, Günther Noack wrote:
> Hi Mickaël!
> 
> On Thu, Sep 21, 2023 at 08:16:34AM +0200, Mickaël Salaün wrote:
> > This patch series adds basic audit support to Landlock for most actions.
> > Logging denied requests is useful for different use cases:
> > * app developers: to ease and speed up sandboxing support
> > * power users: to understand denials
> > * sysadmins: to look for users' issues
> > * tailored distro maintainers: to get usage metrics from their fleet
> > * security experts: to detect attack attempts
> > 
> > To make logs useful, they need to contain the most relevant Landlock
> > domain that denied an action, and the reason. This translates to the
> > latest nested domain and the related missing access rights.
> 
> Is "domain" always the latest nested domain, or is that the domain which caused
> the check to fail because it denied the requested access right?  (If it is just
> the counter of how many domains are stacked, this could maybe also be queried
> through proc instead?)

The logged domain is the latest nested domain that denied at least one
access request (others might be denied by older domains).

What do you mean to query it through proc?

> 
> 
> > Two "Landlock permissions" are used to describe mandatory restrictions
> > enforced on all domains:
> > * fs_layout: change the view of filesystem with mount operations.
> > * ptrace: tamper with a process.
> 
> I find the term "access" already a bit overloaded, and the term "permission"
> also already appears in other contexts.  Maybe we can avoid the additional
> terminology by grouping these two together in the log format, and calling them
> the "cause" or "reason" for the deny decision?  In a sense, the access rights
> and the other permissions can already be told apart by their names, so they
> might also both appear under the same key without causing additional confusion?

I choose to have two fields (missing-fs-accesses and missing-permission)
because one is specific to the FS access rights and the other is
generic. The reason of a deny is specifically the "missing FS accesses
or the missing permissions". I though about a generic "missing-accesses"
but in this case we'll need to prefix all rights with "fs_" or
"generic_", which seems too verbose. I think that tying to the access
right types would be less confusing when parsing these logs.

I'm not a fan of the "permission" name neither, but I didn't find a
better name. This comes from EACCES vs. EPERM.

BTW, I should use fs_topology instead of fs_layout.

> 
> 
> > Here is an example of logs, result of the sandboxer activity:
> > tid=267 comm="sandboxer" op=create-ruleset ruleset=1 handled_access_fs=execute,write_file,read_file,read_dir,remove_dir,remove_file,make_char,make_dir,make_reg,make_sock,make_fifo,make_block,make_sym,refer,truncate
> > tid=267 comm="sandboxer" op=restrict-self domain=2 ruleset=1 parent=0
> > op=release-ruleset ruleset=1
> > tid=267 comm="bash" domain=2 op=open errno=13 missing-fs-accesses=write_file,read_file missing-permission= path="/dev/tty" dev="devtmpfs" ino=9
> > tid=268 comm="ls" domain=2 op=open errno=13 missing-fs-accesses=read_dir missing-permission= path="/" dev="vda2" ino=256
> > tid=269 comm="touch" domain=2 op=mknod errno=13 missing-fs-accesses=make_reg missing-permission= path="/" dev="vda2" ino=256
> > tid=270 comm="umount" domain=2 op=umount errno=1 missing-fs-accesses= missing-permission=fs_layout name="/" dev="tmpfs" ino=1
> > tid=271 comm="strace" domain=2 op=ptrace errno=1 missing-fs-accesses= missing-permission=ptrace opid=1 ocomm="systemd"
> 
> In more complicated cases like "refer" and "open", it is possible that more than
> one access right is missing, and presumably they'll both be listed in
> missing-fs-accesses=.  In this case, it is not clear to me whether the domain=
> number is referring to the first or the second of these missing rights.
> (Assuming that the domain= is about the domain which caused the denial.)

In the case of "open", only the missing access rigths from the youngest
domain (that denied at least one request) are printed. This enables to
focus on this one, which should be the most common use case and the more
useful when debugging a sandbox. This also means that the logs are not
complete, only the more relevant informations are logged.

It is more complex in the case of "refer" because two paths/objects are
involved. I'm not sure how to log such request yet, but I think an
useful log entry should contain both the source and the destination
paths, which would be new compared to other LSMs. This would require to
extend furthermore audit_log_lsm_data(), probably by adding a prefix to
the "path=" string. I'd like to log only one entry per denial, and then
only one set of missing rights per domain. This should be OK by
extracting the youngest missing access rights from the destination
and/or the source (according to the same domain).

> 
> 
> > As highlighted in comments, support for audit is not complete yet with
> > this series: some actions are not logged (e.g. file reparenting), and
> > rule additions are not logged neither.
> 
> When ftruncate(2) gets denied, it is also not possible to tell which of the
> nested domains is responsible, without additional changes to what we carry
> around in the file's security blob.  (Right now, we calculate the overall
> truncation right in advance at open(2) time, and just store that bit with the
> newly opened file.)

Right, one solution would be to add a pointer to the domain that set the
restrictions, but I'd like to avoid that. Instead, we should be able to
identify the struct file at open time (another case for logging a
granted access), and then delegate the complexity of domain tracking and
file lifetime to the (user space) log parser.

> 
> 
> > I'm also not sure if we need to have seccomp-like features such as
> > SECCOMP_FILTER_FLAG_LOG, SECCOMP_RET_LOG, and
> > /proc/sys/kernel/seccomp/actions_logged
> > 
> > I'd like to get some early feedback on this proposal.
> 
> If you want to have the full feature set as proposed above for other operations
> as well, like file reparenting and truncation, it'll complicate the Landlock
> logic and increase the amount of data that needs to be kept around just for
> logging.  I'm not convinced that this is worth it.  After all, the simpler the
> Landlock implementation is, the easier it'll be to reason about its logic and
> its security guarantees.

I'd also like to keep the *enforcement implementation* as simple as
possible, and move most of the logging complexity to the audit.c file
and user space parsers. This patch series doesn't add complexity to the
enforcement logic, only to the audit logic.

The amount of data should only be a 64-bit ID per domain and ruleset,
and maybe the same for landlock_file_security (but I guess there are
other ways to identify a struct file).

Being able to debug Landlock policies is a critical feature for its
adoption.

> 
> A possible simplification would be to omit the domain number which is
> responsible for a "deny" decision.  I feel that for debugging, knowing the fact
> that Landlock denied an operation might already be a big step forward, and the
> exact domain responsible for it might not be that important?

Debugging a set of nested policies would be very challenging without the
ability to identify the exact domain causing denials. Storing an ID
doesn't look like a significant burden isn't it?

> 
> —Günther
> 
> -- 
> Sent using Mutt 🐕 Woof Woof
