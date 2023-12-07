Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D98093FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbjLGV3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbjLGV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:28:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82362126
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:25:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15240C433CC;
        Thu,  7 Dec 2023 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701984315;
        bh=YaZTLucbXUWiTUu4ZO//do5mro1EpRuUKJNhwZYZyPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdAxYA+EeNyu7dUv+IRTk8zJHh9KLM672+XJ7jpuEtThS6zfCTI3ANCa3/dWlAyad
         LUFegPgGXaSaGie9FCRbKhkTRG0O8jkxlJ/INEAwB6RH1wXjf1rYbDbjEvfyI46TvY
         H2mChOR+2VWzt6u8hVb9eEhU8KM0kVhU0m0iv06jCCul2W5q8IZJi8z4osKMyynxoN
         G5I02OijBORh6p1rFOjgnaGjyZWdin5pPaH0ehw2ORdAN4bl2pva8cMV0cA7xS1l89
         b4HfU3IB3Rvodibolr3RCSjicIDtQi+roEsAcCcoOK2QRO1cKESYSK+/pj0nkM6KlB
         +wrdrhd5q1UbQ==
Date:   Thu, 7 Dec 2023 22:25:09 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Tycho Andersen <tycho@tycho.pizza>, Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
 <ZWjM6trZ6uw6yBza@tycho.pizza>
 <ZWoKbHJ0152tiGeD@tycho.pizza>
 <20231207-weither-autopilot-8daee206e6c5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207-weither-autopilot-8daee206e6c5@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If these concerns are correct

So, ok. I misremebered this. The scenario I had been thinking of is
basically the following.

We have a thread-group with thread-group leader 1234 and a thread with
4567 in that thread-group. Assume current thread-group leader is tsk1
and the non-thread-group leader is tsk2. tsk1 uses struct pid *tg_pid
and tsk2 uses struct pid *t_pid. The struct pids look like this after
creation of both thread-group leader tsk1 and thread tsk2:

	TGID 1234				TID 4567 
	tg_pid[PIDTYPE_PID]  = tsk1		t_pid[PIDTYPE_PID]  = tsk2
	tg_pid[PIDTYPE_TGID] = tsk1		t_pid[PIDTYPE_TGID] = NULL

IOW, tsk2's struct pid has never been used as a thread-group leader and
thus PIDTYPE_TGID is NULL. Now assume someone does create pidfds for
tsk1 and for tsk2:
	
	tg_pidfd = pidfd_open(tsk1)		t_pidfd = pidfd_open(tsk2)
	-> tg_pidfd->private_data = tg_pid	-> t_pidfd->private_data = t_pid

So we stash away struct pid *tg_pid for a pidfd_open() on tsk1 and we
stash away struct pid *t_pid for a pidfd_open() on tsk2.

If we wait on that task via P_PIDFD we get:

				/* waiting through pidfd */
	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pidfd)
	tg_pid[PIDTYPE_TGID] == tsk1		t_pid[PIDTYPE_TGID] == NULL
	=> succeeds				=> fails

Because struct pid *tg_pid is used a thread-group leader struct pid we
can wait on that tsk1. But we can't via the non-thread-group leader
pidfd because the struct pid *t_pid has never been used as a
thread-group leader.

Now assume, t_pid exec's and the struct pids are transfered. IIRC, we
get:

	tg_pid[PIDTYPE_PID]   = tsk2		t_pid[PIDTYPE_PID]   = tsk1
	tg_pid[PIDTYPE_TGID]  = tsk2		t_pid[PIDTYPE_TGID]  = NULL

If we wait on that task via P_PIDFD we get:
	
				/* waiting through pidfd */
	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pid)
	tg_pid[PIDTYPE_TGID] == tsk2		t_pid[PIDTYPE_TGID] == NULL
	=> succeeds				=> fails

Which is what we want. So effectively this should all work and I
misremembered the struct pid linkage. So afaict we don't even have a
problem here which is great.
