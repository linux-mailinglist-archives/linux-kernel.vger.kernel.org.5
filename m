Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7307DFC26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbjKBWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKBWDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D0A199
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698962561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJIex0iBPXEPEipoAN2zQv8ZN5dF+ogwUiK0fjM1zeY=;
        b=YBApA3xDF7pk0+EM/Ew6YVqP3pMtCiyhuWZp2JVyiqhs73m9GD1PdwVMDu0C5ocjjXvg0E
        Xc6TzgjiGnV0j6aY7IJzRxi9wz+B6RGSqAEQbAkvaYwE4AyU51HROUb51Pr+rufBJ3FFxl
        uMGJ0XjfLoA3/o2IdUVn+6XzLKgyY0c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397--w_7nGCZMa2F2_oeNaL_GA-1; Thu, 02 Nov 2023 18:02:38 -0400
X-MC-Unique: -w_7nGCZMa2F2_oeNaL_GA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5435b614a0cso194675a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962557; x=1699567357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJIex0iBPXEPEipoAN2zQv8ZN5dF+ogwUiK0fjM1zeY=;
        b=Y6VMQdpZWid2njCsBQVS9YREgVin+MapwdmypMnvP72ULibhGauh45YTkB2sZK12HV
         hgdwUlBJbITGGXaGh9evIhOrUPEEeGwUusa8OeC+6oEdkYR5yEzZ6XPmh5MmYT4zJRgr
         xdf6Rm3Z1lrIZYKOissiMHTcw1e8BQTcwPoEJNPu8fV7GECI+rWWcHr9ksrRQwFr4yOV
         H/n/EZrYdVSWGdrN4+YTiQm148EXlX8SbAMScTdWv705ZxK1VOJlCgtWjeQbtHCuCtf1
         cKdmucn+eegvfyhN/DlqnM1srxuDd0G3Uc/z6nKsybz1CEn3YR92fSEPlU1Vs9NvCOKb
         UkGQ==
X-Gm-Message-State: AOJu0Yz1YUrM7nEYznbXm3K0Op5IN1D+jkSQtp/HDHP8dF570ZLd3ZjB
        wO5l26mJz84+bhpZcoxPi5k2bqFWEJbXgooNmjY+iZPJQ4ZqLPU8P8yk8/vgp7O8Y88rB44P6B9
        7LoVqgPRp1Tgq11MXjuYflWl+
X-Received: by 2002:a50:baef:0:b0:540:a181:f40b with SMTP id x102-20020a50baef000000b00540a181f40bmr14361460ede.4.1698962557140;
        Thu, 02 Nov 2023 15:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEPk0xaaUC0zu2hRz92pKvvlUi2VsYtlPFFB4YRq8WpOL59/CqvmCQ46OIEBuNHmV0iBU8Ug==
X-Received: by 2002:a50:baef:0:b0:540:a181:f40b with SMTP id x102-20020a50baef000000b00540a181f40bmr14361441ede.4.1698962556843;
        Thu, 02 Nov 2023 15:02:36 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d26-20020a50cd5a000000b0053dab756073sm199543edj.84.2023.11.02.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:02:36 -0700 (PDT)
Message-ID: <7a26cd1bafb22b16eab3868255706d44fa4f255d.camel@redhat.com>
Subject: Re: [PATCH] drivers/net/ppp: copy userspace array safely
From:   Philipp Stanner <pstanner@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Date:   Thu, 02 Nov 2023 23:02:35 +0100
In-Reply-To: <20231102200943.GK1957730@ZenIV>
References: <20231102191914.52957-2-pstanner@redhat.com>
         <20231102200943.GK1957730@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Al,

On Thu, 2023-11-02 at 20:09 +0000, Al Viro wrote:
> On Thu, Nov 02, 2023 at 08:19:15PM +0100, Philipp Stanner wrote:
> > In ppp_generic.c memdup_user() is utilized to copy a userspace
> > array.
> > This is done without an overflow check.
> >=20
> > Use the new wrapper memdup_array_user() to copy the array more
> > safely.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.len =3D uprog->le=
n;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.filter =3D memdup_user=
(uprog->filter,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uprog->len * sizeof(=
struct
> > sock_filter));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprog.filter =3D memdup_arra=
y_user(uprog->filter,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 uprog->len, sizeof(struct
> > sock_filter));
>=20
> Far be it from me to discourage security theat^Whardening, but


a bit about the background here:
(tl;dr: No reason to worry, I am not one of those security fanatics. In
fact, I worked for 12 months with those people with some mixed
experiences ^^')

(btw, note that the commit says 'safety', not 'security')

We introduced those wrappers to string.h hoping they will be useful.
Now that they're merged, I quickly wanted to establish them as the
standard for copying user-arrays, ideally in the current merge window.
Because its convenient, easy to read and, at times, safer.

I just want to help out a bit in the kernel, clean up here and there;
it's not yet the primary task assigned to me by my employer. Thus, I
quickly prepared 13 patches today implementing the wrapper. You'll find
the others on LKML. Getting to:

>=20
> struct sock_fprog {=C2=A0=C2=A0=C2=A0=C2=A0 /* Required for SO_ATTACH_FIL=
TER. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned short=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len;=C2=A0=C2=A0=C2=A0 /* Number of=
 filter blocks */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sock_filter __user=
 *filter;
> };
>=20
> struct sock_filter {=C2=A0=C2=A0=C2=A0 /* Filter block */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16=C2=A0=C2=A0 code;=C2=A0=
=C2=A0 /* Actual filter code */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 jt;=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Jump true */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 jf;=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Jump false */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0 k;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Generic multiuse field */
> };
>=20
> so you might want to mention that overflow in question would have to
> be
> in multiplying an untrusted 16bit value by 8...
>=20

I indeed did not even look at that.
When it was obvious to me that fearing an overflow is ridiculous, I
actually adjusted the commit-message, see for example here: [1]

I just didn't see it in ppp. Maybe I should have looked more
intensively for all 13 patches. But we'll get there, that's what v2 and
v3 are for :)

P.


[1] https://lore.kernel.org/all/20231102192402.53721-2-pstanner@redhat.com/


PS: Security !=3D Safety

