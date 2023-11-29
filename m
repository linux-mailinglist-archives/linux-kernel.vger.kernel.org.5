Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1937FD05C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjK2IIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2IIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:08:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2661735;
        Wed, 29 Nov 2023 00:08:53 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B7172191E;
        Wed, 29 Nov 2023 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701245331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ff6pAJpcX3l7MPwnKq6UwMRVAXT7uHWdW8qXvtQnSOM=;
        b=NOfwYpFJNcsLFFNezw3nE+validjAfo58PcPGDSRV0buD137yKHXFJ7G92GDcPWj4szyoz
        dtLZMMYPXoXbO9yVEL4dekjRADnKnq7YvzHQ0I+GI0CEakOC5fxWOFjq0TW7+k6VEeBAe5
        ES/3+v9IiMm+o8KAvr3OVolM8LexlxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701245331;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ff6pAJpcX3l7MPwnKq6UwMRVAXT7uHWdW8qXvtQnSOM=;
        b=Fajihkt29yGkLJ/h1MKUkmz5ITB1D575FcaVndQTfOxzbg06bVbgWVGTeDxiW161xs897u
        PF+jaL1D0JtY53Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E6E561377E;
        Wed, 29 Nov 2023 08:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id b1IhJY7xZmWkNwAAn2gu4w
        (envelope-from <colyli@suse.de>); Wed, 29 Nov 2023 08:08:46 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: block/badblocks.c warning in 6.7-rc2
From:   Coly Li <colyli@suse.de>
In-Reply-To: <562a2442-d098-4972-baa1-5a843e06b180@gmail.com>
Date:   Wed, 29 Nov 2023 16:08:25 +0800
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Block Devices <linux-block@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux bcachefs <linux-bcachefs@vger.kernel.org>,
        Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Janpieter Sollie <janpieter.sollie@edpnet.be>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8305655-3749-411B-A696-E07E95882215@suse.de>
References: <562a2442-d098-4972-baa1-5a843e06b180@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spamd-Result: default: False [-2.15 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-1.35)[90.51%];
         FROM_HAS_DN(0.00)[];
         MV_CASE(0.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-0.20)[-0.989];
         RCPT_COUNT_TWELVE(0.00)[12];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.15
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B411=E6=9C=8829=E6=97=A5 07:47=EF=BC=8CBagas Sanjaya =
<bagasdotme@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> I notice a regression report that is rather well-handled on Bugzilla =
[1].
> Quoting from it:
>=20
>>=20
>> when booting from 6.7-rc2, compiled with clang, I get this warning on =
one of my 3 bcachefs volumes:
>> WARNING: CPU: 3 PID: 712 at block/badblocks.c:1284 badblocks_check =
(block/badblocks.c:1284)=20
>> The reason why isn't clear, but the stack trace points to an error in =
md error handling.
>> This bug didn't happen in 6.6
>> there are 3 commits in 6.7-rc2 which may cause them,
>> in attachment:
>> - decoded stacktrace of dmesg
>> - kernel .config
>=20
> The culprit author then replied:
>=20
>> The warning is from this line of code in _badblocks_check(),
>> 1284         WARN_ON(bb->shift < 0 || sectors =3D=3D 0);
>>=20
>> It means the caller sent an invalid range to check. =46rom the oops =
information,
>> "RDX: 0000000000000000" means parameter 'sectors' is 0.
>>=20
>> So the question is, why does md raid code send a 0-length range for =
badblocks check? Is this behavior on purpose, or improper?
>> ...
>> IMHO, it doesn't make sense for caller to check a zero-length LBA =
range. The warning works as expect to detect improper call to =
badblocks_check().
>=20
> See Bugzilla for the full thread and attached decoded dmesg and kernel =
config.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: 3ea3354cb9f03e =
https://bugzilla.kernel.org/show_bug.cgi?id=3D218184
> #regzbot title: badblocks_check regression (md error handling) on =
bcachefs volume
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218184

It seems the improved bad blocks code caught a zero-size bio request =
from upper layer, this improper behavior was silently neglected before. =
It might be too early or simple to decide this is a regression, =
especially Janpieter closes the report for now.

Thanks.

Coly Li

