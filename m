Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5178DE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjH3TE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbjH3OYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839912F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693405394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
        b=Akvmh1yAb35F5xpAl/Lm+uXDZo+cFqsKdiy2StQEZmcccAC70cJXdAnVjUuk5LeaplByHJ
        wa4DSAAzvLYUHpkYfInM0lyNXTbGFPeecYT72loaFmLKFg7VJtXv6dr8F2FUfqVoaMhUkn
        Rzs/QTBGrzfX6EKAxmZe4w8CMYjOx+4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-ujiE5vg-Pgi9z0qw-cllsw-1; Wed, 30 Aug 2023 10:23:13 -0400
X-MC-Unique: ujiE5vg-Pgi9z0qw-cllsw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e535b143fso366086a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405392; x=1694010192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
        b=Jv1QzySCythTpW57ypL7fpaXDQnwd5sZqSHbzZn4j+xtG4jISiBubvDT8JfuHArfjh
         ReO+6poka6iV9SWfL8Ieutl9GBHsJbrnD9XpNPfcFsmDdSgXOi9WI0MZdilbYtz1PezA
         IGccLC2Vy5LWCE4Thbr1zHt6TMgnuBtjWF226fhtmKdeZP/XzUdS7IQjdjvJvO5cOuFe
         M5Ekwa6Zv9ZoOBIsaJmG1ua2SigcmtTinhLmy97db/SWsEg+8Y0zIJatbRYyVBDCnflm
         8oAFTn+KEjJK26UVL96wBh0vWdh4bbeOsk/ZdWgBPTfgZ8n5gcdVXLQH7b0v+y5EnWvF
         W3vA==
X-Gm-Message-State: AOJu0YyF042LdKOl/d8wvxYrheNaDwkGCrOc2lzQKquRrDP5g6lENqbC
        SXHi2WT7TotigyAHE3a/WN84j+LRIUkuIE/WA+CjxVOiG/z41DHDWkU1XbIrd+F0c6eXBeTxfle
        jkPZtRwDzBQceuqkG2SfItN0P
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019180eda.2.1693405392376;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETjNW9wp/fQvTrgjMQpXcwVHdHwUrjVBdjXk8jizCaYvhqq5Q/jtzkYzdJEKBqJ9axaU5/A==
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019152eda.2.1693405392119;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0052574ef0da1sm6830091edt.28.2023.08.30.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:23:11 -0700 (PDT)
Message-ID: <a79b3c34a12abc51bc5e840ae3a87ab9a47f7742.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   pstanner@redhat.com
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
Date:   Wed, 30 Aug 2023 16:23:10 +0200
In-Reply-To: <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
         <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
         <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 17:15 +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redhat.=
com>
> wrote:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(check_mul_overflow(n=
, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EINVAL);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(check_mul_overflow(n=
, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ERR_PTR(-EINVAL);
>=20
> Btw, why not -EOVERFLOW ?
>=20

Good question, actually.
To be honest I wasn't quite sure which code to pick (-E2BIG was also
once I candidate).

-EINVAL was picked because the idea was that a request overflowing a
size_t could surely be expected to contain an invalid parameter,
because no one would ever request an array _that_ large

?

