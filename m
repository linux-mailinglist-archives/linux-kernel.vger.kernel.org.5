Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025FE7C4D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjJKIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjJKIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551893
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697013240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBSUHVYwZj4KmNlo/HekBOnWzf8kuUwRk15W2B1doHE=;
        b=IscIF/4CNG0hakuLujgcNSrBIBAy1RCZs8wvJw8wspTtV9xcRmyffQksZ7pN8VbNyVuzwD
        +mFBspK7Kw2Mm1N1/9hvEvQuR9PiPzUoiGxt+zUt/dQybZoVUgHz/vqVy81zk9FA6yfLWI
        bOlZpml0ZCItnYmTg218fiUhudheyQ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-kkvOX0rTNOq-KO0OA-P0cg-1; Wed, 11 Oct 2023 04:33:57 -0400
X-MC-Unique: kkvOX0rTNOq-KO0OA-P0cg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4063dd6729bso42616995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013236; x=1697618036;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBSUHVYwZj4KmNlo/HekBOnWzf8kuUwRk15W2B1doHE=;
        b=akMwJe30jtaGbUaBxSvwJepPDrbG46Cst1o6TT2wRApzz2n2qd+ajyEnDXN8x55On2
         NtHADSyARNqqN63bnm2zFueI78ph6zXS33ARWARMdTOjMFQnod9GfTtTqNLmJJHB2TO/
         NxwcWZrWo64VIogw8+W0SKaexIyL6/4l3ANxYZPzy3bamQT71DiKK4qcp51H5jbXGBJ9
         z2QDhgu2B8U0GThMDCJtoQn2TqF7wrKa3CoZRD7dm0N+L53zW1/45nVAlmaHvsm0WPb4
         S45qKVtpcSoDlGFKjtlg6dMBLse37njLEY+Qk9LI3DYNof3TZOfhxmnGB4KVtgQ4b8yP
         N3Ig==
X-Gm-Message-State: AOJu0YzMieA6+guWOnuI+z3J793FnnEEPVCvNzYKMUvstoa9y5o0vPiZ
        HDhM0+j7/wID6lUvPiPwAPMLFEaZTG+O5LusL6XS/rQe6xxiOIP7WeB5g0LN/Yg/knKCVxVoWfo
        FqBKcYbLXnNCquh68lkhzfcIR
X-Received: by 2002:a1c:f710:0:b0:401:be77:9a50 with SMTP id v16-20020a1cf710000000b00401be779a50mr17626453wmh.8.1697013236582;
        Wed, 11 Oct 2023 01:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyRNmcOuM6kEhCJe8HBmwlRQzNEqoTa9cWmacSt1cPCBvFmG9AI8JkFBAF3LS/TIPSphIClA==
X-Received: by 2002:a1c:f710:0:b0:401:be77:9a50 with SMTP id v16-20020a1cf710000000b00401be779a50mr17626440wmh.8.1697013236300;
        Wed, 11 Oct 2023 01:33:56 -0700 (PDT)
Received: from localhost ([185.124.31.160])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c224400b003fe2b081661sm18516317wmm.30.2023.10.11.01.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:33:56 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/8] drm/ssd13xx: Replace .page_height field in device
 info with a constant
In-Reply-To: <CAMuHMdWSOcgV-qseaidUKcJswiJzr2+JQqB=k6tasaUXiEyiHw@mail.gmail.com>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-4-javierm@redhat.com>
 <CAMuHMdWSOcgV-qseaidUKcJswiJzr2+JQqB=k6tasaUXiEyiHw@mail.gmail.com>
Date:   Wed, 11 Oct 2023 10:33:54 +0200
Message-ID: <87pm1lsglp.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

Thanks a lot for your feedback.

> On Mon, Oct 9, 2023 at 8:36=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[...]

>>         u32 array_idx =3D 0;

[...]

>>
>>                         for (k =3D 0; k < m; k++) {
>> -                               u8 byte =3D buf[(8 * i + k) * line_lengt=
h + j / 8];
>> +                               u32 idx =3D (page_height * i + k) * line=
_length + j / 8;
>
> Nit: I would use unsigned int for idx, as that matches all other
> variables involved.
> But given array_idx is u32, too, u32 may makes sense.
>

Yes, this function logic is mostly based on ssd1307fb_update_rect() from
drivers/video/fbdev/ssd1307fb.c and that is from where the u32 array_idx
comes from.

As you said, I used u32 for idx to be consistent with that variable type.

>> +                               u8 byte =3D buf[idx];
>>                                 u8 bit =3D (byte >> (j % 8)) & 1;
>>
>>                                 data |=3D bit << k;
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Thanks!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

