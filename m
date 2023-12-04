Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC18040AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjLDVEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:04:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2EBB6;
        Mon,  4 Dec 2023 13:04:46 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC4231FE75;
        Mon,  4 Dec 2023 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701723884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA+9B0D+52MjUh7aSnDqh3TDNcoFbEwOhL7jbOmZ0qQ=;
        b=Y6DQ1jDwHRUqtIW8jgbyUbVnCwxUH/vb6EMi3N3r8rI2bRqkFAyNEIqjAdwBsI6NPcFbrq
        q3yCBvuMfKVSsm6hjvfRTHPiU4tcmoYw+NMf2nxbyfAJh945rLAgp2zlRTjKXOUNSD/HtD
        FWA1zsbA9aU552eRvgRwm8VbZtPCRzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701723884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA+9B0D+52MjUh7aSnDqh3TDNcoFbEwOhL7jbOmZ0qQ=;
        b=/c/ZpK8Vzwx9mXvAX/fBreIkslJ/fJ+7VzdJZhI2a/PVZxj8kR6nZx3jd+wRycW02fT7X7
        DKuD0CchDgMDyfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF44F1398A;
        Mon,  4 Dec 2023 21:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id jdCKJ+c+bmWMUgAAD6G6ig
        (envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 21:04:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Oleg Nesterov" <oleg@redhat.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
In-reply-to: <ZW04iGENbNm3A/Ki@casper.infradead.org>
References: <20231204014042.6754-1-neilb@suse.de>,
 <20231204014042.6754-2-neilb@suse.de>,
 <ZW04iGENbNm3A/Ki@casper.infradead.org>
Date:   Tue, 05 Dec 2023 08:04:36 +1100
Message-id: <170172387681.7109.15402426750268670177@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.18
X-Spamd-Result: default: False [-1.18 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[14];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.08)[63.75%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023, Matthew Wilcox wrote:
> On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > +++ b/fs/namespace.c
> > @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
> > =20
> >  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
> >  		struct task_struct *task =3D current;
> > -		if (likely(!(task->flags & PF_KTHREAD))) {
> > +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
>=20
> You could lose one set of parens here ...
>=20
> 		if (likely(task->flags & PF_RUNS_TASK_WORK)) {

Done.

>=20
> >  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> > -#define PF__HOLE__00800000	0x00800000
> > +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() period=
ically */
>=20
> And you could lose "Will" here:
>=20
> #define PF_RUNS_TASK_WORK    0x00800000      /* Calls task_work_run() perio=
dically */

Better - thanks.


>=20
> > diff --git a/kernel/task_work.c b/kernel/task_work.c
> > index 95a7e1b7f1da..aec19876e121 100644
> > --- a/kernel/task_work.c
> > +++ b/kernel/task_work.c
> > @@ -183,3 +183,4 @@ void task_work_run(void)
> >  		} while (work);
> >  	}
> >  }
> > +EXPORT_SYMBOL(task_work_run);
>=20
> _GPL?

Justification?

Thanks,
NeilBrown

