Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE78ECF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbjHaMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjHaMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE49E50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693484533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSOEGxFz87m0ye0g3IzP1/eXKvdkuFQz3xBGryZ7gJY=;
        b=Qv3aBiP9AeFvyw3FxZjb3U9mEGI+WoE4GbXaMabz3Z6ymYAjkTqB4xzwjyBVztiwHyGPq1
        1FunRJBc6yc3HiYg1cs5Yu/BOLX2dt8JucWOPmmPrxK6ll0HVg02mj0zr2ny0zA3x851nS
        Mz034Y1cLEZoV4Ild4dnP/WShOjFm3w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-_mc-j535NXutxLx2GD3vtg-1; Thu, 31 Aug 2023 08:22:12 -0400
X-MC-Unique: _mc-j535NXutxLx2GD3vtg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4ffa3a94607so372199e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484530; x=1694089330;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSOEGxFz87m0ye0g3IzP1/eXKvdkuFQz3xBGryZ7gJY=;
        b=USt5ubv351ZMEefB56NXA8bodYM1ik//4RMtCLzDyhezbiaqSkG1mJUaa0lMkEs1HK
         Bn09Y773j5qnCO+hhiOZD+ZtbB1XkfcphWuehuTsJstV3z8LgVuKvqvSgGETeWJZZvcO
         Wz2gd9YHjAAtCsAfgdGvZ91TcFySYzGQeJssY9fcxPkscfl3bOR48ZWKj6NJfxbwD5pE
         2lNxBVw/B8WDaoRTiPZjZQ6mn3aVirrTUY071OWAPAEG634Srlby0DFENfNMAM+396qO
         qYKgwgIKY1Kiqvnkphf4nMQBizm0EVLNPHiGe5Cu6SkQP20lmWrALc/NuH8Njl0AG093
         ll9g==
X-Gm-Message-State: AOJu0YzqrSE32OeUvumZiBplob+Q0zmZ+TuuydlA55pO38d3oZPA2Gx5
        3R4rRRw3r21POF9AWznukaEZKntOFWT9aRT21zLcKdMKbncq/roqhyLRWF9CL1KjnxndWEkiRkv
        1kYlK3SMa/qR/K1D3+IsBpWhi
X-Received: by 2002:ac2:4432:0:b0:4fd:cbd8:17c0 with SMTP id w18-20020ac24432000000b004fdcbd817c0mr3729080lfl.3.1693484530579;
        Thu, 31 Aug 2023 05:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CjCYPDLiBCWT5zVq/nHUhJcr4QW0nSq7bjVUdz8KXgZTbSh2XNB92Vzw3Ab4jqk6Nh2Jcg==
X-Received: by 2002:ac2:4432:0:b0:4fd:cbd8:17c0 with SMTP id w18-20020ac24432000000b004fdcbd817c0mr3729057lfl.3.1693484530194;
        Thu, 31 Aug 2023 05:22:10 -0700 (PDT)
Received: from [10.32.64.120] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id f3-20020a7bc8c3000000b00401c595fcc7sm5011941wml.11.2023.08.31.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:22:09 -0700 (PDT)
Message-ID: <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Date:   Thu, 31 Aug 2023 14:22:08 +0200
In-Reply-To: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
> >=20
> > Currently, user array duplications are sometimes done without an
> > overflow check. Sometimes the checks are done manually; sometimes
> > the
> > array size is calculated with array_size() and sometimes by
> > calculating
> > n * size directly in code.
> >=20
> > Introduce wrappers for arrays for memdup_user() and vmemdup_user()
> > to
> > provide a standardized and safe way for duplicating user arrays.
> >=20
> > This is both for new code as well as replacing usage of
> > (v)memdup_user()
> > in existing code that uses, e.g., n * size to calculate array
> > sizes.
>=20
> ...
>=20
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
>=20
> I'm wondering if this has no side-effects as string.h/string.c IIRC
> is
> used also for early stages where some of the APIs are not available.
>=20

I forgot to address this point in my previous reply.

Who's going to decide whether this is a problem or not?


My personal guess is that this is unlikely to be a problem because

   A. either (v)memdup_user() is available, in which case
      (v)memdup_array_user() will always work =E2=80=93=C2=A0
   B. or (v)memdup_user() is not available, which would cause the code
      that currently uses (v)memdup_user() for copying arrays to fail
      anyways.


P.

