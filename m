Return-Path: <linux-kernel+bounces-127665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6D894F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04591C225C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22895915A;
	Tue,  2 Apr 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nvhlaD+a"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7B51C52
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051603; cv=none; b=PTHm3aVohUNTRLmDXPVNUSL/0LERXvvX6MX396fUSF5QKRtbqpkCpp+S72Ldjr9e0DXzJpWme+M9eMilRUY39BUhTZ39Wa/o7tQJ5egGM4LCKhGAyfGxZbnxnvGVOcO4TDKOdWR8w8ejoARhH+bZ3x2oI+Yo3c+L15HG4XlyO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051603; c=relaxed/simple;
	bh=H92Z8U2YBFFdaC4L6X13E2f0ZVakp5ra2dp91kdypcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKX3Z4mmx+Ts/S4EhToaod012newFjt/G2ls9QbA1cPpinJ9KynSzIpHF7A29U/Dneo7rW7QWEEOHDG/knhHQwdTx2YfsJMKD+xC5yrDFyGCVty0tSDgrveSyasUCmJG7GrPJjil49YyyyTzdRuUSx2JsnzbAXcfdyI4cb+Hd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nvhlaD+a; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V83923hzMzct9;
	Tue,  2 Apr 2024 11:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712051590;
	bh=H92Z8U2YBFFdaC4L6X13E2f0ZVakp5ra2dp91kdypcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nvhlaD+aptQO/JRmneq8ZnxYjv4HOJIA3KIc1BP3n8jL9jutIVsnzyzcovfquN3iu
	 NN6ZYAImAt84ML8xfof0x+yJaNwuEwn+1LjmiVdczc2Qhv1Dt/3KBKveAKodKPAEk+
	 8zi7/Sid/sQfs4+wPc7sXSTxoDXdUTr9Lds8fcy4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V83913wxVz3Y;
	Tue,  2 Apr 2024 11:53:09 +0200 (CEST)
Date: Tue, 2 Apr 2024 11:53:09 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: TaheraFahimi <fahimitahera@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <20240401.ieC2uqua5sha@digikod.net>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

Thanks for this patch.  Please CC the netdev mailing list too, they may
be interested by this feature. I also added a few folks that previously
showed their interest for this feature.

On Thu, Mar 28, 2024 at 05:12:13PM -0600, TaheraFahimi wrote:
> Abstract unix sockets are used for local interprocess communication without
> relying on filesystem. Since landlock has no restriction for connecting to
> a UNIX socket in the abstract namespace, a sandboxed process can connect to
> a socket outside the sandboxed environment. Access to such sockets should
> be scoped the same way ptrace access is limited.

This is good but it would be better to explain that Landlock doesn't
currently control abstract unix sockets and that it would make sense for
a sandbox.


> 
> For a landlocked process to be allowed to connect to a target process, it
> must have a subset of the target process’s rules (the connecting socket
> must be in a sub-domain of the listening socket). This patch adds a new
> LSM hook for connect function in unix socket with the related access rights.

Because of compatibility reasons, and because Landlock should be
flexible, we need to extend the user space interface.  As explained in
the GitHub issue, we need to add a new "scoped" field to the
landlock_ruleset_attr struct. This field will optionally contain a
LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
ruleset will deny any connection from within the sandbox to its parents
(i.e. any parent sandbox or not-sandboxed processes).

> 
> Link to first draft:
> 	https://lore.kernel.org/outreachy/20240328.ShoR4Iecei8o@digikod.net/

You can move this sentence in the below changelog.

> 

You can add this:

Closes: https://github.com/landlock-lsm/linux/issues/7

> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

Your Git (or email app) configuration doesn't use the same name as here.

Please run ./scripts/checkpatch.pl on this patch and fix the warnings.

> 
> ----
> Changes in v2:
> - Remove wrapper functions, noted by Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/landlock/task.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 849f5123610b..67528f87b7de 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -13,6 +13,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> +#include <net/sock.h>
>  
>  #include "common.h"
>  #include "cred.h"
> @@ -108,9 +109,48 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  
> +static bool unix_sock_is_scoped(struct sock *const sock,

For consistency with task_is_scoped(), you can rename this to
sock_is_scoped().

> +				struct sock *const other)
> +{
> +	bool is_scoped = true;
> +
> +	/* get the ruleset of connecting sock*/

These comments don't help more than the following line, you can remove
them.

> +	const struct landlock_ruleset *const dom_sock =

According to the name it looks like the domain of the socket but it is
just the domain of the current task. Just "dom" would be clearer and
more consistent with security/landlock/fs.c

> +		landlock_get_current_domain();
> +
> +	if (!dom_sock)
> +		return true;
> +
> +	/* get credential of listening sock*/
> +	const struct cred *cred_other = get_cred(other->sk_peer_cred);

We have a get but not a put call, so the credentials will never be
freed.  The put call must be called before any return, so you
probably need to follow the goto/error pattern.

In the context of these LSM hooks, only unix_listen() sets the "other"
socket credential, and unix_listen() is guarded by unix_state_lock()
which locks unix_sk(s)->lock .  When security_unix_stream_connect() or
security_unix_may_send() are called, unix_sk(s)->lock is locked as well,
which protects the credentials against race-conditions (TOCTOU:
time-of-check to time-of-use).  We should then make that explicit with
this assertion (which also documents it):

lockdep_assert_held(&unix_sk(other)->lock);

In theory it is then not required to call get_cred().  However, because
the performance impact should be negligible and to avoid a potential
use-after-free (not possible in theory with the current code), it would
be safer to still call get/put.  It would be worse to have a
use-after-free rather than an access control issue.

Another thing to keep in mind is that for this hook to be
race-condition-free, the credential must not change anyway.  A comment
should highlight that.

> +
> +	if (!cred_other)
> +		return true;
> +
> +	/* retrieve the landlock_rulesets */
> +	const struct landlock_ruleset *dom_parent;

All declarations should be at the top of functions.

> +
> +	rcu_read_lock();

No need for this RCU lock because the lock is managed by
unix_state_lock() in this case.

> +	dom_parent = landlock_cred(cred_other)->domain;
> +	is_scoped = domain_scope_le(dom_parent, dom_sock);
> +	rcu_read_unlock();
> +
> +	return is_scoped;
> +}
> +
> +static int hook_unix_stream_connect(struct sock *const sock,
> +				    struct sock *const other,
> +				    struct sock *const newsk)
> +{
> +	if (unix_sock_is_scoped(sock, other))
> +		return 0;
> +	return -EPERM;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> +	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),

Please add a hook for security_unix_may_send() too, it should be quite
similar, and simplify the patch's subject accordingly.

You now need to add tests (in a dedicated patch) extending
tools/testing/selftests/landlock/ptrace_test.c (I'll rename the file
later).

These tests should also check with unnamed and named unix sockets.  I
guess the current code doesn't differentiate them and control all kind
of unix sockets.  Because they must explicitly be passed, sockets
created with socketpair(2) (i.e. unnamed socket) should never be denied.

>  };
>  
>  __init void landlock_add_task_hooks(void)
> -- 
> 2.34.1
> 
> 

