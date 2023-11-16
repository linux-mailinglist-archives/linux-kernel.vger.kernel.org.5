Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1AB7EDDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbjKPJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344971AbjKPJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D7419B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700128065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uiFBR3JQf5JhHqleJ4f4NPiEeGpPS9MKZ9jUPGR8g8=;
        b=Kk7XBt7tWhN0cPvhoGWROA3ZVPw7lfRDplnyflShe1OsW9GOlSdWOJx2dQx5nVFdfoAOua
        qKGZfnFaT/N4IYcYFzM/b7CKI5b2gv73gCXquNcuEfUNLqC5NXgiIvYxD56//SzEYQ0Ph+
        gR124MPJ3VJX21+zwJ5QV5lZehlLvzw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-fZCpevcmPXSKB-d9Huy8EQ-1; Thu, 16 Nov 2023 04:47:39 -0500
X-MC-Unique: fZCpevcmPXSKB-d9Huy8EQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77891f36133so65723885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700128058; x=1700732858;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uiFBR3JQf5JhHqleJ4f4NPiEeGpPS9MKZ9jUPGR8g8=;
        b=LGTB1K+MUY70sT6c0k0e9ghTYZZ/ADTWgpp4x/+gcEb1ygy5bk73O1raP4sd2NG2fn
         i0S5P5sAIf9HKraBODtT7Q1aNHtjNB2IwxN7N1y16Z+2YERoL0PqbSBUSxFWPaHaMG5g
         XhwoGhiHtP8s1p6E1iOLNDyLeow26Uv5ms+rgPPZrhPYFNYpVTh/ZLDmFA4SPvXcoLmB
         EaYkOhoYijHyt7OY/eQ9zcgg+jpcsKYOWSF32ImyLkWlQy1G4oC4LrlognIpZ54awKta
         z7ZZ7mi002vpmgRsUh96J7v9RkxiJHfQqfkeh+r5XGyAaa90KNQETwaBrIuRp6qUSinH
         mXTg==
X-Gm-Message-State: AOJu0YxuEzu6zOK01M+HH5YQK/H4Y3QsWIq99mflBqav4QYu6WvVSPs4
        mF/nmzd1umEqY9dOlB1tJkacsQkSXRLbcPhTEGvrcWa0FHrQl09ITyQc6e2b/tBjOuz8rYGFyAL
        Gedv8vI5qnoqe7r+X5OGYTJWBENiHy6DB
X-Received: by 2002:a05:620a:450f:b0:77b:a837:f6c3 with SMTP id t15-20020a05620a450f00b0077ba837f6c3mr8981895qkp.15.1700128058667;
        Thu, 16 Nov 2023 01:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE2Yk8BDxgOdgM8zDkfkQslAKDFXqLXANjPOfZ0tsgrPsXXVo1kMfuDnEUn8oqPPyH5MsqWQ==
X-Received: by 2002:a05:620a:450f:b0:77b:a837:f6c3 with SMTP id t15-20020a05620a450f00b0077ba837f6c3mr8981878qkp.15.1700128058316;
        Thu, 16 Nov 2023 01:47:38 -0800 (PST)
Received: from 117.195.187.81.in-addr.arpa (1.0.1.7.7.8.6.b.6.c.4.1.e.c.9.d.0.0.0.0.a.d.f.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:ffda:0:d9ce:14c6:b687:7101])
        by smtp.gmail.com with ESMTPSA id bq41-20020a05620a46a900b007758ffab58asm4153503qkb.8.2023.11.16.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:47:37 -0800 (PST)
Message-ID: <491b0e5d86798242ff0ff2cdea44588c50ae9a77.camel@redhat.com>
Subject: Re: linux-next: contacts for the gfs2 tree
From:   Steven Whitehouse <swhiteho@redhat.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Thu, 16 Nov 2023 09:47:33 +0000
In-Reply-To: <CAHc6FU5qLYLw=EVodktQbEuBVZmV-tT1FpTvvaoPD1ezvRso1A@mail.gmail.com>
References: <20231116073950.02c0610f@canb.auug.org.au>
         <CAHc6FU5qLYLw=EVodktQbEuBVZmV-tT1FpTvvaoPD1ezvRso1A@mail.gmail.com>
Organization: Red Hat UK Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2023-11-15 at 23:18 +0100, Andreas Gruenbacher wrote:
> Hi Stephen,
>=20
> On Wed, Nov 15, 2023 at 9:40=E2=80=AFPM Stephen Rothwell
> <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >=20
> > I noticed commit
> >=20
> > =C2=A0 2e6ef8aaba6b ("Remove myself as maintainer of GFS2")
> >=20
> > Currently I have
> >=20
> > Steven Whitehouse <swhiteho@redhat.com>
> > Bob Peterson <rpeterso@redhat.com>
> >=20
> > listed as the only contacts for the gfs2 tree.
> >=20
> > Should I change that to
> >=20
> > Andreas Gruenbacher <agruenba@redhat.com>
> >=20
> > or keep Steven (even though he is not listed in MAINTAINERS)?=C2=A0 And
> > should
> > I add the mailing list as well?
>=20
> I think it would make sense to put me in instead of Bob. Steve hasn't
> been working on the actual code for a while -- even though he remains
> a valuable source of information for GFS2 -- so I don't think he will
> object to being removed here.
>=20
> For the time being, I will be the only person screwing up the
> upstream
> gfs2 repository, so I'll also be the person to fix things up again.
> In
> that context, would it make sense to add the gfs2 list? Is this what
> you would commonly do?
>=20
> Thanks,
> Andreas
>=20

Yes, I'm not likely to be working on the code again, so it definitely
makes sense to remove me from that list,

Steve.

