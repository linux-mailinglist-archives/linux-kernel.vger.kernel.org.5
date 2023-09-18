Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA17A45B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbjIRJPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjIRJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D1910F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695028434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
        b=cd42VR+RzlMdxl2zq5h68JxAWA8yz9ZBAJOKiUVT3dhi3Lh3XLe7PsYjrzdRkGYwBOj9Zg
        RQ5B9x9uDHJvs+J7Ose05SKJ2WJjpmWVxfvQlBQ2QwXTknFhm9r27dysILszFa1kVglnSs
        Lg2Q1OKi5RFTi1boQdgEFkBDB2qbXMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-Uz9Fh3RlO56roIsFype9dg-1; Mon, 18 Sep 2023 05:13:51 -0400
X-MC-Unique: Uz9Fh3RlO56roIsFype9dg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-404daa4f5a7so7379615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028430; x=1695633230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
        b=pKSs/Zf4oVmz8AT+cNp1woTte3ZKjgk2l0EbJ0SRrpNO4grxQqYRFo6y7yIBShFfB+
         bHKOtCe7Gjf5c58PFwbYWNxsvk+bSsNI884levpPld+KTI+5C5lS813WkaAosZrBh1dX
         EwFPqHEyEuSk+mqyte6HL5zOEpIFNFivuGqzF3RAwsL3eEVfiitfgh245MI8Y2ql6Yxv
         Duwb8sqDI8ug7lUVrPLGU6eLuAgFnvzZibR65ADR3ow0BhJV+8f/tDaFJ3kHg4f5x1/m
         4Tl5OBussHlC/n00zgyIGBsYt3vi/HOz1BDnYMMfWG4E48bJmoEHnfws2wjeAG25n1lF
         dCoQ==
X-Gm-Message-State: AOJu0YxpZsFYTtQuD+/MjlS+/X4jWPtibgh/iCUc3q7266Fs+XOXxUBV
        y5zXvsEsqbtGA1m8lG0S4hd7G4u+d9YNSVwtpVEr/TiWcQkkGVsvJyR5828XLuPBcvI7tfFOfBe
        zEsiQ+ZyuYVj6EDUm8NFJh0CIk6MUnJGURlM=
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416393wrt.1.1695028430605;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB8VnbhuBBqYU4diZ/ky5juLhWgDDI8ddqsgXauCCvjjTxBkK6OXa7bUUeWyDSF9cThUqM3g==
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416363wrt.1.1695028430263;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
Received: from [10.32.64.2] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600010d000b0031aef72a021sm11830334wrx.86.2023.09.18.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:13:49 -0700 (PDT)
Message-ID: <72a444cd42629f5bdd56647e7aa24588d6964bec.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
From:   Philipp Stanner <pstanner@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
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
Date:   Mon, 18 Sep 2023 11:13:48 +0200
In-Reply-To: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
         <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
         <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-16 at 17:32 +0300, Dan Carpenter wrote:
> On Fri, Sep 08, 2023 at 09:59:40PM +0200, Philipp Stanner wrote:
> > +static inline void *memdup_array_user(const void __user *src,
> > size_t n, size_t size)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t nbytes;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(check_mul_overf=
low(n, size, &nbytes)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EOVERFLOW);
>=20
> No need for an unlikely() because check_mul_overflow() already has
> one
> inside.

ACK. I overlooked that as it was hidden in the callstack.


> =C2=A0 I feel like -ENOMEM is more traditional but I doubt
> anyone/userspace
> cares.

I agree with Andy here. We're not allocating, so -ENOMEM makes no sense
IMO.


P.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return memdup_user(src, nbyt=
es);
> > +}
>=20
> regards,
> dan carpenter
>=20

