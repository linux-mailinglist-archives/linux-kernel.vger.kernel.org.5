Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA86785A50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbjHWOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbjHWOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B6E47;
        Wed, 23 Aug 2023 07:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6C764774;
        Wed, 23 Aug 2023 14:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1295BC433D9;
        Wed, 23 Aug 2023 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692800551;
        bh=T+9iOZs+whCT7Lv6LYGMyZU7VyIImWI4ZzMZhZ8diN8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Fz0SpVR6huigMmRcj06AuXaCepT8L3//V/MgikC4I3CrfYmJ5Ql4bsH8ltXOoXFJ5
         aoDGfZ+Uj4A7cVWu6/WkmFWmIxN1eaAQRv+xSTmjLZfQ8Y5Ldae26HcR5vqL7O4Xe1
         KH9mRFngYmotzHfbaDgcaSAB3owj0W9f+U0E7ljsQqc4vE37cAvKswLPYcPvmc4v+j
         HA2iHk2GV984UQeR2/tWF6Bz/bGDuD/6BZxPn1bG0Xip5jMA+GcnFFGoTiCT3B7Mj7
         ZKHumNM20KjuP7xze0jpKv20BG7RoIe/BjJvQFZlAVKIAk/XFJvKkkq5aoxUP25ab2
         1tGVs76uEqz4A==
Date:   Wed, 23 Aug 2023 07:22:29 -0700
From:   Kees Cook <kees@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
CC:     Justin Stitt <justinstitt@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
User-Agent: K-9 Mail for Android
In-Reply-To: <20230823141304.14378-F-hca@linux.ibm.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com> <20230823134936.14378-E-hca@linux.ibm.com> <20230823141304.14378-F-hca@linux.ibm.com>
Message-ID: <D14D69B0-63E4-4650-A7F0-44F6CF81F9F9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 23, 2023 7:13:04 AM PDT, Heiko Carstens <hca@linux=2Eibm=2Ecom> w=
rote:
>On Wed, Aug 23, 2023 at 03:49:36PM +0200, Heiko Carstens wrote:
>> On Tue, Aug 22, 2023 at 11:59:26PM +0000, Justin Stitt wrote:
>> > `strncpy` is deprecated for use on NUL-terminated destination strings=
 [1]=2E
>> >=20
>> > A suitable replacement is `strscpy` [2] due to the fact that it
>> > guarantees NUL-termination on its destination buffer argument which i=
s
>> > _not_ the case for `strncpy`!
>> >=20
>> > Link: www=2Ekernel=2Eorg/doc/html/latest/process/deprecated=2Ehtml#st=
rncpy-on-nul-terminated-strings[1]
>> > Link: https://manpages=2Edebian=2Eorg/testing/linux-manual-4=2E8/strs=
cpy=2E9=2Een=2Ehtml [2]
>> > Link: https://github=2Ecom/KSPP/linux/issues/90
>> > Cc: linux-hardening@vger=2Ekernel=2Eorg
>> > Signed-off-by: Justin Stitt <justinstitt@google=2Ecom>
>> > ---
>> >  block/partitions/ibm=2Ec | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >=20
>> > diff --git a/block/partitions/ibm=2Ec b/block/partitions/ibm=2Ec
>> > index 403756dbd50d=2E=2Ee5893cf71b57 100644
>> > --- a/block/partitions/ibm=2Ec
>> > +++ b/block/partitions/ibm=2Ec
>> > @@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions =
*state,
>> >  		    !strcmp(temp, "LNX1") ||
>> >  		    !strcmp(temp, "CMS1")) {
>> >  			if (!strcmp(temp, "VOL1")) {
>> > -				strncpy(type, label->vol=2Evollbl, 4);
>> > -				strncpy(name, label->vol=2Evolid, 6);
>> > +				strscpy(type, label->vol=2Evollbl, 4);
>> > +				strscpy(name, label->vol=2Evolid, 6);
>> >  			} else {
>> > -				strncpy(type, label->lnx=2Evollbl, 4);
>> > -				strncpy(name, label->lnx=2Evolid, 6);
>> > +				strscpy(type, label->lnx=2Evollbl, 4);
>> > +				strscpy(name, label->lnx=2Evolid, 6);
>> >  			}
>> >  			EBCASC(type, 4);
>> >  			EBCASC(name, 6);
>>=20
>> I'm quite sure this is not correct, since both type and name are not
>> necessarily NUL-terminated, and this code operates on purpose on such
>> strings=2E
>>=20
>> Since currently Stefan and Jan are both not available, I added Peter
>> Oberparleiter to Cc who hopefully knows better than me=2E
>
>I was just made aware of that this patch is already in linux-next=2E And
>indeed: partition detection does not work anymore for DASDs=2E With this
>patch reverted it works again=2E
>
>Jens, can you remove or revert this patch again, please?


Looks like this should be strtomem_pad() rather than strscpy()=2E=2E=2E


--=20
Kees Cook
