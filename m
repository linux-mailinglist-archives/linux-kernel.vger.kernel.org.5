Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10F7C6350
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJLDa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjJLDaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:30:55 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDADB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:30:53 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:51994)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqmPR-002NxY-OX; Wed, 11 Oct 2023 21:30:49 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35210 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqmPQ-00E9TF-Gp; Wed, 11 Oct 2023 21:30:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
References: <20231011065446.53034-1-cuiyunhui@bytedance.com>
Date:   Wed, 11 Oct 2023 22:30:24 -0500
In-Reply-To: <20231011065446.53034-1-cuiyunhui@bytedance.com> (Yunhui Cui's
        message of "Wed, 11 Oct 2023 14:54:46 +0800")
Message-ID: <87sf6gcyb3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qqmPQ-00E9TF-Gp;;;mid=<87sf6gcyb3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18jR1acemHAkEyGJW1gUCzoj5kRrtYsd2Y=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Yunhui Cui <cuiyunhui@bytedance.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.9%), parse: 0.94
        (0.2%), extract_message_metadata: 13 (2.4%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-2000: 15 (2.8%), tests_pri_-1000: 2.4 (0.5%),
        tests_pri_-950: 1.28 (0.2%), tests_pri_-900: 1.08 (0.2%),
        tests_pri_-200: 0.86 (0.2%), tests_pri_-100: 7 (1.3%), tests_pri_-90:
        57 (10.8%), check_bayes: 56 (10.5%), b_tokenize: 9 (1.7%),
        b_tok_get_all: 10 (1.8%), b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 31
        (5.9%), b_finish: 0.71 (0.1%), tests_pri_0: 364 (68.7%),
        check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 2.7 (0.5%),
        poll_dns_idle: 33 (6.3%), tests_pri_10: 3.6 (0.7%), tests_pri_500: 49
        (9.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] pid_ns: support pidns switching between sibling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunhui Cui <cuiyunhui@bytedance.com> writes:

> In the scenario of container acceleration,

What is container acceleration?

Are you perhaps performing what is essentially checkpoint/restart
from one set of processes to a new set of processes so you can
get a container starting faster?

> when a target pstree is cloned from a temp pstree, we hope that the
> cloned process is inherently in the target's pid namespace.

I am having a hard time figuring out what you are saying here.

> Examples of what we expected:
>
> /* switch to target ns first. */
> setns(target_ns, CLONE_NEWPID);
  ^-------- Is this the line that fails for you?

> if(!fork()) {
> /* Child */
> ...
> }
> /* switch back */
> setns(temp_ns, CLONE_NEWPID);

Assuming that the "switch back" means returning to your
task_active_pid_ns that should always work.

If I had to guess I think what you are missing is that entire pid
namespaces can be inside other pid namespaces.

So there is no reason to believe that any random pid namespace
that happens to pass the CAP_SYS_ADMIN permission check is also in
your processes task_active_pid_ns.


> However, it is limited by the existing implementation, CAP_SYS_ADMIN
> has been checked in pidns_install(), so remove the limitation that only
> by traversing parent can switch pidns.

The check you are deleting is what verifies the pid namespaces you are
attempting to change pid_ns_for_children to is a member of the tasks
current pid namespace (aka task_active_pid_ns).


There is a perfectly good comment describing why what you are attempting
to do is unsupportable.

	/*
	 * Only allow entering the current active pid namespace
	 * or a child of the current active pid namespace.
	 *
	 * This is required for fork to return a usable pid value and
	 * this maintains the property that processes and their
	 * children can not escape their current pid namespace.
	 */


If you pick a pid namespace that does not meet the restrictions you are
removing the pid of the new child can not be mapped into the pid
namespace of the parent that called setns.

AKA the following code can not work.

pid = fork();
if (!pid) {
	/* child */
        do_something();
        _exit(0);
}
waitpid(pid);


So no.  The suggested change to pidns_install makes no sense at all.

The whole not being able to escape your current pid namespace is
also an important invariant when reasoning about pid namespaces.

It would have to be a strong well thought out case for me to agree
it makes sense to abandon the invariant that a process can not escape
it's pid namespace.


> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  kernel/pid_namespace.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 3028b2218aa4..774db1f268f1 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -389,7 +389,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
>  {
>  	struct nsproxy *nsproxy = nsset->nsproxy;
>  	struct pid_namespace *active = task_active_pid_ns(current);
> -	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
> +	struct pid_namespace *new = to_pid_ns(ns);
>  
>  	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
>  	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
> @@ -406,12 +406,6 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
>  	if (new->level < active->level)
>  		return -EINVAL;
>  
> -	ancestor = new;
> -	while (ancestor->level > active->level)
> -		ancestor = ancestor->parent;
> -	if (ancestor != active)
> -		return -EINVAL;
> -
>  	put_pid_ns(nsproxy->pid_ns_for_children);
>  	nsproxy->pid_ns_for_children = get_pid_ns(new);
>  	return 0;


Eric
