Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD3751C56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjGMI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjGMI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:56:34 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B0E4F;
        Thu, 13 Jul 2023 01:56:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D43C4000C;
        Thu, 13 Jul 2023 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689238591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lpf4/5uUcVQ6IGM3xCIyZwUJyb/sKEglBkryPLS6H+I=;
        b=N945Q4+Or/JU1urddwT+kKk3xVDTcL6n1+pF/XwsGzORj5f8Zkl+kK3iuKOg1adKiRKUVe
        r7A6OxXjfSNimoN7u4dEbP1CaWWaKhnyIS9fg0e8n5/aIuQJlapXIBtk4WPLQ7zLd4Dynb
        BKmZ9O49i7QIsvN6yfbgXMOBukXG3ilqzNA4sQedKmOv93mCeEpYMUAQ0l1z6M93n6H4DZ
        5B0q9OpO1nHTh3iyqmWx9ThJ5LEKucgxlmWNC2FMeyeoGnEDqDT9VrIi3ORb1V0bYc4atQ
        nWVF9ZY2X08eLKkKJdJhcO/wyC6LfUiU6lVKOdT9N70Ow/jbdpbVcLgdLD2gvQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] firmware: turris-mox-rwtm: Fix an error handling
 path in mox_get_board_info()
In-Reply-To: <20230712131629.3161d6c9@thinkpad>
References: <fb3a73fd378582bf02e6c5eeabb61d3a3662cbdc.1676453328.git.christophe.jaillet@wanadoo.fr>
 <20230217122108.4a93667f@dellmb>
 <95bd5686-1ed9-63ef-e91f-30aa54c09cd6@wanadoo.fr>
 <20230712131629.3161d6c9@thinkpad>
Date:   Thu, 13 Jul 2023 10:56:31 +0200
Message-ID: <87jzv42nr4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Beh=C3=BAn <kabel@kernel.org> writes:

> Gregory, could you take this patch via mvebu?


Yes sure, actually I was not in CC of this series and I don't follow
linux-kernel or kernel-janitors mailing lists. So thanks to having
pointing me the thread.

Applied on mvebu/drivers

Thanks,

Gregory


>
> On Tue, 11 Jul 2023 18:44:36 +0200
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>
>> Le 17/02/2023 =C3=A0 12:21, Marek Beh=C3=BAn a =C3=A9crit=C2=A0:
>> > On Wed, 15 Feb 2023 10:30:02 +0100
>> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
>> >=20=20=20
>> >> wait_for_completion_timeout() returns 0 if timed out, and positive (at
>> >> least 1, or number of jiffies left till timeout) if completed.
>> >>
>> >> In case of timeout, return -ETIMEDOUT.
>> >>
>> >> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
>> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> >> ---
>> >> Compile tested only.
>> >>
>> >> v2:
>> >>     - Fix some other wait_for_completion_timeout() calls
>> >>
>> >> ---
>> >>   drivers/firmware/turris-mox-rwtm.c | 12 ++++++------
>> >>   1 file changed, 6 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/tu=
rris-mox-rwtm.c
>> >> index 6ea5789a89e2..d6fc37ba897d 100644
>> >> --- a/drivers/firmware/turris-mox-rwtm.c
>> >> +++ b/drivers/firmware/turris-mox-rwtm.c
>> >> @@ -200,8 +200,8 @@ static int mox_get_board_info(struct mox_rwtm *rw=
tm)
>> >>   		return ret;
>> >>=20=20=20
>> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
>> >> -	if (ret < 0)
>> >> -		return ret;
>> >> +	if (ret =3D=3D 0)
>> >> +		return -ETIMEDOUT;
>> >>=20=20=20
>> >>   	ret =3D mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
>> >>   	if (ret =3D=3D -ENODATA) {
>> >> @@ -236,8 +236,8 @@ static int mox_get_board_info(struct mox_rwtm *rw=
tm)
>> >>   		return ret;
>> >>=20=20=20
>> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
>> >> -	if (ret < 0)
>> >> -		return ret;
>> >> +	if (ret =3D=3D 0)
>> >> +		return -ETIMEDOUT;
>> >>=20=20=20
>> >>   	ret =3D mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
>> >>   	if (ret =3D=3D -ENODATA) {
>> >> @@ -275,8 +275,8 @@ static int check_get_random_support(struct mox_rw=
tm *rwtm)
>> >>   		return ret;
>> >>=20=20=20
>> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
>> >> -	if (ret < 0)
>> >> -		return ret;
>> >> +	if (ret =3D=3D 0)
>> >> +		return -ETIMEDOUT;
>> >>=20=20=20
>> >>   	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
>> >>   }=20=20
>> >=20
>> > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
>> >=20=20=20
>>=20
>> Hi,
>> polite reminder.
>>=20
>> CJ
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
