Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1D577C7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHOGha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjHOGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:37:14 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90C127
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:37:12 -0700 (PDT)
Date:   Tue, 15 Aug 2023 06:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1692081429; x=1692340629;
        bh=gTNMOOleVV5P6GLOdZ27ULHCi1wjyvV2oSd/xlGSrjc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CgCWI6WPRHiVurtpSEQdM84Xnq/SjLu0xmFQigFVmHLwt8a7JV6ZBzLGWh4HZkjtQ
         Z8lp69qig/97TFfXqvkt/cgAj/vjgS0Yo8qLu9uiIjTk4hyk2dit++0Pd1IGVlky/N
         tX121XZw5W7dPo90KaQDc+CDC9PCRUP5wIVss5JjHg7WIY3U3rNlIGsNeFPWjZU0SM
         7K2H5qoJWdDjaEs+UsqphW391g2Mct1gQGyDhsWjMXO38TZCFQ5+j1N9nLkdweD87E
         y+RgW0nFzGxLcVxs7pe+4JG7cfGf7sEb9xa7Q8E5qsp6X6KEH2P+iObCnMYcQOdKrr
         iAjN9XYCNy7iQ==
To:     Riwen Lu <luriwen@hotmail.com>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v1] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Message-ID: <87fs4kn77j.fsf@protonmail.com>
In-Reply-To: <TYCP286MB260715E63D023C52591264C5B114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM> <nycvar.YFH.7.76.2308141126330.14207@cbobk.fhfr.pm> <TYCP286MB260715E63D023C52591264C5B114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug, 2023 14:02:40 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
> =E5=9C=A8 2023/8/14 17:26, Jiri Kosina =E5=86=99=E9=81=93:
>> On Mon, 3 Jul 2023, Riwen Lu wrote:
>>
>>> From: Riwen Lu <luriwen@kylinos.cn>
>>>
>>> The format '%*ph' print up to 64 bytes long as a hex string with ' '
>>> sepatator. Usually the size of report descriptor is larger than 64
>>> bytes, so consider using print_hex_dump_debug to print out all of it fo=
r
>>> better debugging.
>>>
>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>> ---
>>>   drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i=
2c-hid-core.c
>>> index efbba0465eef..8e97fc01c852 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>>>   =09=09}
>>>   =09}
>>>
>>> -=09i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
>>> +=09i2c_hid_dbg(ihid, "Report Descriptor\n");
>>> +=09print_hex_dump_debug("  ", DUMP_PREFIX_OFFSET, 16, 1,
>>> +=09=09=09rdesc, rsize, false);

Maybe it makes sense to use a prefix for the hex dump that is easy to
trace rather than padding whitespace? This looks good when you do not
see any other kernel message log lines get interlaced when written.
However, if you have a lot of concurrent kernel message output, I think
it can be tough to piece together the lines of the dump with this
prefix. Just my opinion.

>>
>> But that would dump it unconditionally, while i2c_hid_dbg() is
>> conditional.
>>
> Function print_hex_dump_debug() dump messages is as conditional as
> i2c_hid_dbg().
>
> The function i2c_hid_dbg() defines as follows:
> #define i2c_hid_dbg(ihid, ...) dev_dbg(&(ihid)->client->dev, __VA_ARGS__)
>
> dev_dbg() depends on the same macro as print_hex_dump_debug().

I agree with this point. Both dev_dbg and print_hex_dump_debug are noops
if neither CONFIG_DYNAMIC_DEBUG is set or DEBUG is defined.

--
Thanks,

Rahul Rameshbabu

