Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D253782ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjHUNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjHUNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7168BC;
        Mon, 21 Aug 2023 06:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BFE66311E;
        Mon, 21 Aug 2023 13:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5DFC433C7;
        Mon, 21 Aug 2023 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625884;
        bh=raW/eJ/IekLFv76LPt/xjV+ChKw/iEEDviThfP0LNIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K1rO2pp7CuRPqKRyFO0K7tg3mOBJdE+6WL2eCf3huaAoG4ar6+WJxPMk2I/lU4G9B
         3DvwYrqj5rgYoTyQF8ckDhUw5fX4/t/8RSiavijEwXkQG8YHXravbW5IWmsjoJLErS
         WguPbdKVTGvvNyzjeTSaG+yGhvIVL47kRRVfVibdZs+vGP4SxU55jaqnR4oXfNhwa0
         8dfj3B6wh02vC4TyuYEbtwNo6IXGw7zZR1nt6ucIRQkloGoviePhgAlq1IXtcPvDWx
         jQqP8r0gn5WYWxbtrSLgkJ3AHt2eARZHAeG/+dug92afpPZRy9k2lsL6JPQmGpd+u7
         rGmgVYz/3AZCA==
Message-ID: <96e7cc13-1169-12ab-6dad-7624e33346ab@kernel.org>
Date:   Mon, 21 Aug 2023 15:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: struct_size() using sizeof() vs offsetof()
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
 <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
 <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
 <df8fdd4a-490f-6b2a-03b6-0333e3302dce@kernel.org>
 <d3c4c953c9a742ae98ae9b9036561b38@AcuMS.aculab.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <d3c4c953c9a742ae98ae9b9036561b38@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-21 10:38, David Laight wrote:
> From: Alejandro Colomar <alx@kernel.org>
>> Sent: Thursday, August 17, 2023 7:38 PM
>>
>> Hi Gustavo,
>>
>> On 2023-08-17 18:05, Gustavo A. R. Silva wrote:
>>>
>>>> -               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>>>> +               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GF=
P_KERNEL);
>>>
>>> I just sent a fix[1].
>>>
>>> Thanks for reporting this! :)
>=20
> Perhaps struct_size() should include an assertion that:
> 	(offsetof(type, field[8]) > sizeof (type))
> That will ensure that field is an array member

There's already an assertion that the field in struct_size() is an
array:

$ grepc struct_size include/
include/linux/overflow.h:291:
#define struct_size(p, member, count)					\
	__builtin_choose_expr(__is_constexpr(count),			\
		sizeof(*(p)) + flex_array_size(p, member, count),	\
		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
$ grepc flex_array_size include/
include/linux/overflow.h:275:
#define flex_array_size(p, member, count)				\
	__builtin_choose_expr(__is_constexpr(count),			\
		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))


Notice the must_be_array() there.


> and reasonably
> near the end of the structure.

I did add a must_be_zero_sizeof() assertion to my implementation of
sizeof_fam0(), so I think that's a reasonable assertion that it's
really a FAM.  You can still add a zero-length array in the middle
of a struct and pass those two assertions, but it's unlikely.

>=20
> A more complex calculation (using _Alignof(type) and the offset/size
> of field) could be used.
> But I don't think you can actually detect it is field[] (or even the
> last member).

I'm thinking now that you can plug an assertion that offsetof_fam()
is >=3D sizeof(struct) - alignof(struct).  That should make it even
harder to pass all the assertions without really having the field at
the end.  A [0] at the end of a structure would still pass all those
assertions, but linters probably catch those.  So I think it's a
pretty robust assertion.

Cheers,
Alex

>=20
> 	David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> Registration No: 1397386 (Wales)

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

