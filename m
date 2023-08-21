Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D249782D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjHUPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHUPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:20:29 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 08:20:26 PDT
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6838EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:20:26 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 36551 invoked from network); 21 Aug 2023 17:13:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1692630822; bh=UJVVkk77jJQZRtW+kosJTe40F9fUyfu1I0p/gVNGHdY=;
          h=From:To:Cc:Subject;
          b=QIHVnDF9DeJf3cj8pjs392jmorQteOzgor6KiiNXBwIInDZ6Wy7oVlxXKINZx35bW
           7Wm86V/rvhVbSt0BGNuYEB6P7HEtxmHivDm24r6T5ggXBULbqZVzvF46ZCWUAWzaeK
           d73ng3cPwH8aaKIea5fuLpxgjkT5sK/ZRKURewrs=
Received: from public-gprs210194.centertel.pl (HELO mocarz) (deweloper@wp.pl@[46.134.160.83])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@arndb.de>; 21 Aug 2023 17:13:42 +0200
Date:   Mon, 21 Aug 2023 17:13:36 +0200
From:   Aleksander Mazur <deweloper@wp.pl>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH] /proc/modules: honor kptr_restrict even without
 CONFIG_KALLSYMS
Message-ID: <20230821171336.11677436@mocarz>
In-Reply-To: <b1435818-2cba-4270-9933-282029f5449c@app.fastmail.com>
References: <20220605224347.481e2fb4@mocarz>
        <20230527005539.5b06df24@mocarz>
        <b1435818-2cba-4270-9933-282029f5449c@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-WP-MailID: 70365e5cc3a5709a6f09bd4cab58040d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0XPE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 2023-05-27, o godz. 11:44:35
"Arnd Bergmann" <arnd@arndb.de> napisa=C5=82(a):

> > Dnia 2022-06-05, o godz. 22:43:47
> > Aleksander Mazur <deweloper@wp.pl> napisa=C5=82(a):
> > =20
> >> Commit e4a8ca3baa55 fixed building without CONFIG_KALLSYMS by providing
> >> dummy kallsyms_show_value(). Unfortunately -- due to hard-coded "false"
> >> being returned -- access to addresses in /proc/modules became permanen=
tly
> >> disabled.
> >>=20
> >> My proposal is to change this unconditional "false" to !kptr_restrict.
> >> This re-enables addresses in /proc/modules even without CONFIG_KALLSYS=
MS
> >> unless restricted by means of sysctl (kernel.kptr_restrict). =20
>=20
> I just looked at the original 516fb7f2e73dc ("/proc/module: use the
> same logic as /proc/kallsyms for address exposure") commit again,
> the intention here was to use the same logic for /proc/modules
> and /proc/kallsyms.
>=20
> I agree that this means my patch went too far, but I'm not sure
> about yours either. Maybe we can just move kallsyms_show_value()
> into a different location that is always built and rename it
> accordingly. Then it can be used by both kallsyms and /proc/modules
> regardless of which combination of these two is enabled in the
> kernel.
>=20

I don't see any reason why should I enable both KALLSYMS and PERF_EVENTS ju=
st to see addressess inside /proc/modules.
But this is currently required by the kernel, what in my opinion violates t=
he description of kptr_restrict in Documentation/admin-guide/sysctl/kernel.=
rst.

My patch restores exposing kernel addresses via /proc/modules in the case o=
f kptr_restrict=3D=3D0 and it doesn't change current behaviour in other cas=
es, especially for kptr_restrict=3D=3D1; this means that even with my patch=
 applied, the code is still more restrictive than the description of kptr_r=
estrict (because it doesn't make an exception for processes with CAP_SYSLOG=
). Therefore I cannot agree that my patch goes "too far"; it rather goes ju=
st one step in the direction towards compliance with kernel documentation.

Moving kallsyms_show_value() somewhere else and re-using it won't help in m=
y case because that function honors kptr_restrict=3D=3D0 only if profiling =
is compiled in and perf_event_paranoid<=3D1.
BTW. I think this is wrong since according to the docs, perf_event_paranoid=
 "controls use of the performance events system by unprivileged users", whi=
le placing restrictions on exposing kernel addresses via /proc should be co=
ntrolled by kptr_restrict.
Or maybe I'm wrong and /proc/modules silently became a part of "the perform=
ance events system"?...

--=20
Aleksander Mazur
