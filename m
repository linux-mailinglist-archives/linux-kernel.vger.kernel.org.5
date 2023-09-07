Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13F797A84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbjIGRm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbjIGRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:42:53 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABFA1BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:42:30 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RhNf72X8ZzMq2vS;
        Thu,  7 Sep 2023 15:37:19 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RhNf54vqczMpnPd;
        Thu,  7 Sep 2023 17:37:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694101039;
        bh=HTiZwHVg8F7uVKSD4j4wLDwhc/PFGcVuJRCd0AKedao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOLj3EIcmbKasCKmy+JVIdqDOT3jHOrUOcq01dx4d1aFtqAYO+4vbajrOpjnr9QCA
         yFtoR4vnyfyl+VU0F76dLcoLu0RJxKQoGjmX4xdPHd8KklPlNXsBzWc4cJHNtJyVee
         Fd9rI1wvoT70eJVGAptNwkveUz9+NCiYU3YVErFE=
Date:   Thu, 7 Sep 2023 17:37:09 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
Message-ID: <20230907.eFie4boo3sei@digikod.net>
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com>
 <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
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

On Wed, Sep 06, 2023 at 04:48:04PM -0700, Casey Schaufler wrote:
> On 9/6/2023 4:22 PM, Paul Moore wrote:
> > On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process.
> >> Create a system call lsm_set_self_attr() to set a security
> >> module maintained attribute of the current process.
> >> Historically these attributes have been exposed to user space via
> >> entries in procfs under /proc/self/attr.
> >>
> >> The attribute value is provided in a lsm_ctx structure. The structure
> >> identifies the size of the attribute, and the attribute value. The format
> >> of the attribute value is defined by the security module. A flags field
> >> is included for LSM specific information. It is currently unused and must
> >> be 0. The total size of the data, including the lsm_ctx structure and any
> >> padding, is maintained as well.
> >>
> >> struct lsm_ctx {
> >>         __u64 id;
> >>         __u64 flags;
> >>         __u64 len;
> >>         __u64 ctx_len;
> >>         __u8 ctx[];
> >> };
> >>
> >> Two new LSM hooks are used to interface with the LSMs.
> >> security_getselfattr() collects the lsm_ctx values from the
> >> LSMs that support the hook, accounting for space requirements.
> >> security_setselfattr() identifies which LSM the attribute is
> >> intended for and passes it along.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >> ---

> >> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> >> +			 size_t __user *size, u32 flags)
> >> +{
> >> +	struct security_hook_list *hp;
> >> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> >> +	u8 __user *base = (u8 __user *)uctx;
> >> +	size_t total = 0;
> >> +	size_t entrysize;
> >> +	size_t left;
> >> +	bool toobig = false;
> >> +	bool single = false;
> >> +	int count = 0;
> >> +	int rc;
> >> +
> >> +	if (attr == LSM_ATTR_UNDEF)
> >> +		return -EINVAL;
> >> +	if (size == NULL)
> >> +		return -EINVAL;
> >> +	if (get_user(left, size))
> >> +		return -EFAULT;
> >> +
> >> +	if (flags) {
> >> +		/*
> >> +		 * Only flag supported is LSM_FLAG_SINGLE
> >> +		 */
> >> +		if (flags & LSM_FLAG_SINGLE)
> >> +			return -EINVAL;
> > Should this be something like the following?
> >
> >   if (flags & ~LSM_FLAG_SINGLE)
> >     return -EINVAL;
> 
> Yes. I have a fix ready. There are a couple other touch-ups, too.

This is already part of patch 11. It should be squashed here.
