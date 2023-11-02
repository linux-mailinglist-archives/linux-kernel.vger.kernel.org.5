Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC547DFC2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjKBWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKBWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AB8192
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698962876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkWJVPJFaRtARApP/xOT73zf0/RfYFWCBPOHT7K33GA=;
        b=XD+U+zkhV4h3DGLK1fL77d5s6gnL6PmXhEWqix4a0FegLE/AnCZyiVif1/k6eM5OddMA1I
        XUB8ke6jOrDnBBfXfmEX0VXB08eMKTCphIyQna0t1HVSy27pkG48gs6vcxt9d7iKyERCrM
        Yw67XPzZPy6dt4seKUcerUJsMf5Q/Hw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-9OOaCS8BM1O3GmQE0wWWag-1; Thu, 02 Nov 2023 18:07:54 -0400
X-MC-Unique: 9OOaCS8BM1O3GmQE0wWWag-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-534838150afso228393a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698962873; x=1699567673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkWJVPJFaRtARApP/xOT73zf0/RfYFWCBPOHT7K33GA=;
        b=wjjgPIuDVxzg5jELi4gVZulazPo4dJV2QdLQkn7LXosht4OgQUNauG5p5pggKrnybx
         t1RF07z3pArKAFaXqkbdWbpANyhM09tc2YXJJX+YWSGkFm9mR+95AUBgUKf9FgkSgVf1
         BMAt39Rv1/V9eONG6wBfVFpz7s69OVjKNRMPJAGYY7QTAD3hXwh0T+PCc/HMZOy7OkUE
         BmqnkogSQwZPhICde8ajW2Fpg6SzwrAeczwrxpFvatKQKhqsIUsAP03RYd08uI8osguJ
         wgciDTZ8nZ6m2zKvoIopCWfb0mlRYGfu/RXs5damm/MleF654uYXJVmdWmzuDo4AXQZD
         7ogg==
X-Gm-Message-State: AOJu0YwfI6KjvWDmAtSzntOC0TfwsmxLVbIimlgipNk+8QWe+OlpfSul
        oiLHv/Em6MWcPKQ5vWMeTwse8gm+uRLcsm+WMOVOKoJ9AIHKWhy2JyipQ8m4ft58gENsFKZbJeM
        G9xARdeChicUJiKgibiCVaz3f
X-Received: by 2002:a50:c05b:0:b0:543:83a3:f39 with SMTP id u27-20020a50c05b000000b0054383a30f39mr6383129edd.4.1698962873044;
        Thu, 02 Nov 2023 15:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYB5pMCj8ov2H3l8xfTg6DCVUBcRNCnuF1xlx8YzxWJryLAx/pozKFMTC55qPQqelAfT1XKw==
X-Received: by 2002:a50:c05b:0:b0:543:83a3:f39 with SMTP id u27-20020a50c05b000000b0054383a30f39mr6383110edd.4.1698962872750;
        Thu, 02 Nov 2023 15:07:52 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id u14-20020a50c04e000000b005412c0ba2f9sm212636edd.13.2023.11.02.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:07:52 -0700 (PDT)
Message-ID: <37ab45c67d630b4832912cb8403ce8235f52d9c0.camel@redhat.com>
Subject: Re: [PATCH] drivers/tty/vt: copy userspace arrays safely
From:   Philipp Stanner <pstanner@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Airlie <airlied@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Date:   Thu, 02 Nov 2023 23:07:51 +0100
In-Reply-To: <20231102204903.GM1957730@ZenIV>
References: <20231102192134.53301-2-pstanner@redhat.com>
         <20231102201424.GL1957730@ZenIV>
         <CAMwc25rgdNt3oO3Yf=v05AWOSgN5W4j=ST=Y9qikeBrNTqqW2w@mail.gmail.com>
         <20231102204903.GM1957730@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-02 at 20:49 +0000, Al Viro wrote:
> On Fri, Nov 03, 2023 at 06:24:09AM +1000, David Airlie wrote:
> > On Fri, Nov 3, 2023 at 6:14=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk=
>
> > wrote:
> > >=20
> > > On Thu, Nov 02, 2023 at 08:21:35PM +0100, Philipp Stanner wrote:
> > > > The functions (v)memdup_user() are utilized to copy userspace
> > > > arrays.
> > > > This is done without overflow checks.
> > > >=20
> > > > Use the new wrappers memdup_array_user() and
> > > > vmemdup_array_user() to
> > > > copy the arrays more safely.
> > >=20
> > > > @@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc,
> > > > ushort ct, struct unipair __user *list)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ct)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 unilist =3D vmemdup_user(list, array_size=
(sizeof(*unilist),
> > > > ct));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 unilist =3D vmemdup_array_user(list, ct, =
sizeof(*unilist));
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(unilist))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return PTR_ERR(unilist);
> > >=20
> > > a 16bit value times sizeof(something).
> >=20
> > So since it's already using array_size here, moving it to a new
> > helper
> > for consistency just makes things clearer, and so you are fine with
> > the patch?
>=20
> Sigh...=C2=A0 OK, if you want it spelled out, there we go.=C2=A0 I have n=
o
> objections
> to the contents of patches; e.g. in case of ppp ioctl it saves the
> reader
> a grep in search of structure definitions, which is a good thing.=C2=A0
> The one
> and only suggestion I have for those patches is that such patches
> might be
> better off with explicit "in this case the overflow is avoided due to
> <reasons>, but use of this helper makes it obviously safe" - or, in
> case
> of real bugs, "the overflow is, indeed, possible here", in which case
> Fixes: ... and Cc: stable might be in order.
>=20

So if you agree the content is improving things a little bit then it
seems the only critical thing is the commit message :)

So let's get that fixed, shifting the focus from security to
readability and general usefulness.

Do you have a proposal for a good wording?

Personally, I would have gone with something minimalistic like here in
my other commit, where the irrelevance of the overflow-aspect was more
obvious for me to see [1]
I can also add a sentence clarifying that it's about improving
readability or sth if you think that's better

Kind regards,
P.

[1] https://lore.kernel.org/all/20231102192402.53721-2-pstanner@redhat.com/

