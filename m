Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9F78ECEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbjHaMR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbjHaMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C4E49
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693484219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
        b=QM8qKAGK9IbMC12Q/AkAwOOUxhcHEkaJE44UypwcxBVT3DZHx0zXKuJ8AqFpG+w2l1TOI7
        iBg4q95YWZKhKSkF2Wbr3fZ0ka5huN5LZP2C6jfRQUVLBCPRPK9lNTXmlV3aQl68PCnK0L
        Nzv6NTkmOEWsl0c0ltb8bjVSKkcoOJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-g01vupYTM3SnAGfM531CbA-1; Thu, 31 Aug 2023 08:16:57 -0400
X-MC-Unique: g01vupYTM3SnAGfM531CbA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401b91039b4so1308635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484216; x=1694089016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TIPZiS5WiygpRoovt73Dy9nOHlU7oscs2x344MogyU=;
        b=dYi+bP5FtJtPVXYYLe89kGZlpteo582/Ff+SpmULaAXLrW8PFXyvw6i5KTcOQ5p3Pt
         newFVWQECniO5hrKvVOSDgrNwXgfWr77IfHGI8olWJZhyFAgAcPB7PvyGDAvGDtLkcC2
         k5SyUDxfWlQRJ+Pkxybqo9TtTdz1WaYraU0GFfhwhZXwVNg1APMlyRRAl/dpSM3gBpax
         DUJQczv2TBzp5Zs73arUO+jipYTtpsUbke42bm7wchYoQngiK9dZNBQjwOGcamhh0R3C
         AxIAsJXjlHOth6lBCCnPCbzpOEQme1G6Ue2cJMJHhP5NmKO/jXA/1WpDBrm+Y5pX+W9j
         o0eA==
X-Gm-Message-State: AOJu0YzrTSVJ5mmjHhixzw9U5qFGe85ZhAdde/YhQPMluy9MmqoZ5m+K
        aw/NX1rB5xwQuH6yD9dFiC/gZADI4jcN6JUU8CJ2GKXlNxulP37GjgllO3gJ8+mbypm8XgjLSmC
        GxFGNJfc4G0vw+kq/79BvrS/8
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029833wms.2.1693484216704;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGojultcfb0NIiOQPSvztdAjpKlNPabZq65nI0NSxG/DjDY/J8YCs5kvptoKVkC+FPxrHVegg==
X-Received: by 2002:a05:600c:5113:b0:401:c392:d28d with SMTP id o19-20020a05600c511300b00401c392d28dmr4029795wms.2.1693484216302;
        Thu, 31 Aug 2023 05:16:56 -0700 (PDT)
Received: from [10.32.64.120] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003fbdbd0a7desm4922787wmk.27.2023.08.31.05.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:16:55 -0700 (PDT)
Message-ID: <98bf616420e4ef3c7c18a1f52fda7cd410137f7d.camel@redhat.com>
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
Date:   Thu, 31 Aug 2023 14:16:54 +0200
In-Reply-To: <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
         <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
         <CAHp75VdS=kSWnz8FzHcdrZPaeZKsQNbzjE9mNN7BDvZA_nQpaA@mail.gmail.com>
         <a4ba0493965ad32fcf95cd6e2439096668a9ed46.camel@redhat.com>
         <CAHp75VdqFPJAnCm9A-S+TCChr9v9_s=Wfnb5wO2=vuwp1v+JvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-31 at 11:59 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 10:15=E2=80=AFPM <pstanner@redhat.com> wrote:
> > On Wed, 2023-08-30 at 17:29 +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 30, 2023 at 5:19=E2=80=AFPM <pstanner@redhat.com> wrote:
> > > > On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > > > > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner
> > > > > <pstanner@redhat.com>
> > > Alphabetical.
> > >=20
> > > compiler.h
> > > err.h
> > > overflow.h
> > > ...the rest that is a bit unordered...
> > >=20
> > > > > > =C2=A0#include <linux/stdarg.h>
> > > > > > =C2=A0#include <uapi/linux/string.h>
> >=20
> > I mean I could include my own in a sorted manner =E2=80=93 but the exis=
ting
> > ones are not sorted:
>=20
> I know, that's why I put "(to some extent)" in my initial comment.
>=20
> > We could sort them all, but I'd prefer to do that in a separate
> > patch
> > so that this commit does not make the impression of doing anything
> > else
> > than including the two new headers
>=20
> But you can do your stuff first with better ordering than you
> proposed
> initially, so there will be less churn for any additional change
> (either that simply unifies the thing or something else).
>=20
>=20

I'll take care of those points in a v2 once I gathered some more
feedback from the other parties.

P.

