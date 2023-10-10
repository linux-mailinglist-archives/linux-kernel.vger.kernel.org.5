Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E4A7C040E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343675AbjJJTGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjJJTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:05:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D794;
        Tue, 10 Oct 2023 12:05:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95796C433C7;
        Tue, 10 Oct 2023 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964755;
        bh=slgHXzrc2IofJCZavg5wuuNQrcCzs3dZIe68cvgkTCg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YKfqXHjFVbF5Ecm0X9rz/cuJ7TwxuPCHbWy3ros5O+ugINGNfCgvW2M06BUH2ApRC
         7U8vC5TX8pxOt5NZO0T6qftqrTAOPRRShYdzNeW47y7DlKA3m3398NRbJS8je4D5YB
         lq2YvYacfrRMNrNgArDVDGGnICM6NrXxML+sH/0g2zwlfXjl8SMOYIRtPxpKe1fsLN
         1ZGztSIlAS98Hxc0n7OpR40AdEa3SDwELLOrEC959Te+Lv56HyjfYqX7RUDjXVh7Oc
         aoBMncCSMIwkQUMRubkpbpA2iLY5+YoZdZLo7RWBlLRzx6K/Oj/2b2MQ2GjkJTqQnH
         ZYBanr5ovygfQ==
Message-ID: <8a8c14694d5ff62e385163bf0852fd3adb675087.camel@kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>
Cc:     peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 10 Oct 2023 22:05:50 +0300
In-Reply-To: <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
References: <20231006051801.423973-1-sumit.garg@linaro.org>
         <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 11:28 -0700, Linus Torvalds wrote:
> On Thu, 5 Oct 2023 at 22:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> >=20
> > Static calls invocations aren't well supported from module __init and
> > __exit functions. Especially the static call from cleanup_trusted() led
> > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=3Dy.
> >=20
> > However, the usage of static call invocations for trusted_key_init()
> > and trusted_key_exit() don't add any value from either a performance or
> > security perspective. Hence switch to use indirect function calls inste=
ad.
>=20
> I applied this patch to my tree, since it is a fix for the issue, and
> doesn't change any logic otherwise.
>=20
> However, I do note that the code logic is completely broken. It was
> broken before too, and apparently causes no problems, but it's still
> wrong.
>=20
> That's a separate issue, and would want a separate patch, but since I
> noticed it when applying this one, I'm replying here:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].ops->exit;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->migratable=
;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D static_call(trusted_key_init)();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->init();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
>=20
> Note how this sets "trusted_key_exit" even when the ->init() function fai=
ls.

Sumit, can you remind me why this continues *on any failure*?

E.g. something like this would make more sense to me:

		ret =3D trusted_key_sources[i].ops->init();
		if (!ret) {
			static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
			static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unsea=
l);
			static_call_update(trusted_key_get_random, get_random);
			static_call_update(trusted_key_exit, trusted_key_sources[i].ops->exit);
			migratable =3D trusted_key_sources[i].ops->migratable;
			break;
		}

		if (ret !=3D -ENODEV)
			break;
`
BR, Jarkko
