Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931887B213C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjI1P2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjI1P2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:28:05 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB3AC;
        Thu, 28 Sep 2023 08:28:02 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RxHRg6mXXzMr3yF;
        Thu, 28 Sep 2023 15:27:59 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RxHRf70HvzMppDN;
        Thu, 28 Sep 2023 17:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695914879;
        bh=5TbzNnbHjMBaw/hqLYXv0/YPa4xbm8wFAcwV61jhk4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spWoM0mbRhMT5nzVdAn/x+LHYB1Jj7njxIUT6IcE5acIQ30gQlXV+o2IIEzE64pGX
         6pxI++jHHiSfFtzHTzr8XS7txfAxpFMfUoEvnSGItvez3EgaTB8kteU8Vg2UE93QRW
         dTTe90yMw7QhhE8jXssngHGNRjxj7mzulpthbxrc=
Date:   Thu, 28 Sep 2023 17:27:46 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     Ben Scarlato <akhna@google.com>,
        =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/7] Landlock audit support
Message-ID: <20230928.wae8Caitha7n@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I talked about this patch series at the Kernel Recipes conference, and
you might want to take a look at the future work:
https://landlock.io/talks/2023-09-25_landlock-audit-kr.pdf

In a nutshell, new syscall flags:
* For landlock_create_ruleset() to opt-in for logging ruleset-related
  and domain-related use
* For landlock_add_rule() to opt-in for logging this rule if it granted
  the requested access
* For landlock_restrict_self() to opt-in for:
  * not log anything
  * handle a permissive mode to log actions that would have been denied
    (very useful to build a sandbox)


On Thu, Sep 21, 2023 at 08:16:34AM +0200, Mickaël Salaün wrote:
> Hi,
> 
> This patch series adds basic audit support to Landlock for most actions.
> Logging denied requests is useful for different use cases:
> * app developers: to ease and speed up sandboxing support
> * power users: to understand denials
> * sysadmins: to look for users' issues
> * tailored distro maintainers: to get usage metrics from their fleet
> * security experts: to detect attack attempts
> 
> To make logs useful, they need to contain the most relevant Landlock
> domain that denied an action, and the reason. This translates to the
> latest nested domain and the related missing access rights.
> 
> Two "Landlock permissions" are used to describe mandatory restrictions
> enforced on all domains:
> * fs_layout: change the view of filesystem with mount operations.
> * ptrace: tamper with a process.
> 
> Here is an example of logs, result of the sandboxer activity:
> tid=267 comm="sandboxer" op=create-ruleset ruleset=1 handled_access_fs=execute,write_file,read_file,read_dir,remove_dir,remove_file,make_char,make_dir,make_reg,make_sock,make_fifo,make_block,make_sym,refer,truncate
> tid=267 comm="sandboxer" op=restrict-self domain=2 ruleset=1 parent=0
> op=release-ruleset ruleset=1
> tid=267 comm="bash" domain=2 op=open errno=13 missing-fs-accesses=write_file,read_file missing-permission= path="/dev/tty" dev="devtmpfs" ino=9
> tid=268 comm="ls" domain=2 op=open errno=13 missing-fs-accesses=read_dir missing-permission= path="/" dev="vda2" ino=256
> tid=269 comm="touch" domain=2 op=mknod errno=13 missing-fs-accesses=make_reg missing-permission= path="/" dev="vda2" ino=256
> tid=270 comm="umount" domain=2 op=umount errno=1 missing-fs-accesses= missing-permission=fs_layout name="/" dev="tmpfs" ino=1
> tid=271 comm="strace" domain=2 op=ptrace errno=1 missing-fs-accesses= missing-permission=ptrace opid=1 ocomm="systemd"
> 
> As highlighted in comments, support for audit is not complete yet with
> this series: some actions are not logged (e.g. file reparenting), and
> rule additions are not logged neither.
> 
> I'm also not sure if we need to have seccomp-like features such as
> SECCOMP_FILTER_FLAG_LOG, SECCOMP_RET_LOG, and
> /proc/sys/kernel/seccomp/actions_logged
> 
> I'd like to get some early feedback on this proposal.
> 
> This series is based on v6.6-rc2
> 
> Regards,
> 
> Mickaël Salaün (7):
>   lsm: Add audit_log_lsm_data() helper
>   landlock: Factor out check_access_path()
>   landlock: Log ruleset creation and release
>   landlock: Log domain creation and enforcement
>   landlock: Log file-related requests
>   landlock: Log mount-related requests
>   landlock: Log ptrace requests
> 
>  include/linux/lsm_audit.h    |   2 +
>  include/uapi/linux/audit.h   |   1 +
>  security/landlock/Makefile   |   2 +
>  security/landlock/audit.c    | 283 +++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h    |  88 +++++++++++
>  security/landlock/fs.c       | 169 ++++++++++++++++-----
>  security/landlock/ptrace.c   |  47 +++++-
>  security/landlock/ruleset.c  |   6 +
>  security/landlock/ruleset.h  |  10 ++
>  security/landlock/syscalls.c |  12 ++
>  security/lsm_audit.c         |  26 ++--
>  11 files changed, 595 insertions(+), 51 deletions(-)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
> 
> 
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> -- 
> 2.42.0
> 
