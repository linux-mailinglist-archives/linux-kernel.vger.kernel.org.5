Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8497C4D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJKIuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjJKIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6163EBA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697014182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7p+gT1BFGsm9JpR0WAEA6fS7XL44+MjD9PCU+IXIk8=;
        b=OPQWE13cYAc4q01+FGjkBTJIncxSGeYU8UybIpgALbU+zrbVmsC3SVld5YAvHaPjwlJpPW
        QbO6tJ/5OfJdZy7Ui8jY43iziMMm4trlt1Fcof0/zBi8Ko2XWvOVx5LJaev7VWNlmv4+Jl
        c9gp9PCgqUqhenB0nfxEGOimkEpdWDQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-VLGPxEb9NX6WEIz6p75dXA-1; Wed, 11 Oct 2023 04:49:41 -0400
X-MC-Unique: VLGPxEb9NX6WEIz6p75dXA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4065478afd3so43299885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014180; x=1697618980;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7p+gT1BFGsm9JpR0WAEA6fS7XL44+MjD9PCU+IXIk8=;
        b=cXD2/b7ncXyxFC2O6J3KEY8CtNfE4wbluo+Ff3iI1KMPsrbcQmfKEdmyoSJ1hOpnZo
         oQl98rxbbP1Lk5Z3MnblffH8J1haAmTwHlsszFh7t0PwM7Hq6KhDUicFflXMlj+mc1tW
         sYvq3T/AUeCvWoQI/ulCQgS/nEGnBAg2nrpgWCWdjcMY8un4hzw+hmZRRaKI2yHWAViF
         xkJ6Ka9TRn5ZxsVkspHQ5rQHD5JCBgI4H3ytwAQVA6sxCavkdgdjrnw5ZFGLG9KaxCoX
         spoGU0Lc987JkDOmXqL8oqwLiboYbdOrQcBDKXNEKoIsvQ2ryAyfaWDEOI4kyIsyBSGg
         E1CQ==
X-Gm-Message-State: AOJu0YyZee6TFqP/Je8pK0sQj4GJKkUkc8QYX7jcW+kTqYH3nJ5DmkCj
        tM/yqsw2f8csdAN+Dye1uMEp1l45ZuyGeM9J42VmO+fBwA71ygFAOYQ3tEjW4PoVoT8NtIsxsFO
        Va3WXgHWxzipBNphKQ+/np76q
X-Received: by 2002:a05:600c:3b89:b0:406:478e:9e2d with SMTP id n9-20020a05600c3b8900b00406478e9e2dmr17266869wms.26.1697014180237;
        Wed, 11 Oct 2023 01:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMk/WfgoVRBsAcpGEPEZXx8KzMpE03uuKB/MMWvjPxgBJOuXw+ZzUoM4SqRqGjbIVG7/sI1g==
X-Received: by 2002:a05:600c:3b89:b0:406:478e:9e2d with SMTP id n9-20020a05600c3b8900b00406478e9e2dmr17266861wms.26.1697014179892;
        Wed, 11 Oct 2023 01:49:39 -0700 (PDT)
Received: from localhost ([185.124.31.160])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b00406725f27e1sm16090936wmc.42.2023.10.11.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:49:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 7/8] drm/ssd13xx: Add support for the SSD132x OLED
 controller family
In-Reply-To: <CAMuHMdVnJPBfcaPSpeONuz0dPsWUD69_GnWXwbs9VPgN+fhmtw@mail.gmail.com>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-8-javierm@redhat.com>
 <CAMuHMdVnJPBfcaPSpeONuz0dPsWUD69_GnWXwbs9VPgN+fhmtw@mail.gmail.com>
Date:   Wed, 11 Oct 2023 10:49:38 +0200
Message-ID: <87h6mxsfvh.fsf@minerva.mail-host-address-is-not-set>
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

> Hi Javier,
>
> On Mon, Oct 9, 2023 at 8:36=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The Solomon SSD132x controllers (such as the SSD1322, SSD1325 and SSD132=
7)
>> are used by 16 grayscale dot matrix OLED panels, extend the driver to al=
so
>> support this chip family.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for your patch!
>
>> --- a/drivers/gpu/drm/solomon/ssd13xx.c
>> +++ b/drivers/gpu/drm/solomon/ssd13xx.c
>
>> @@ -631,9 +821,12 @@ static int ssd13xx_fb_blit_rect(struct drm_framebuf=
fer *fb,
>>         unsigned int dst_pitch;
>>         int ret =3D 0;
>>
>> -       /* Align y to display page boundaries */
>> -       rect->y1 =3D round_down(rect->y1, SSD130X_PAGE_HEIGHT);
>> -       rect->y2 =3D min_t(unsigned int, round_up(rect->y2, SSD130X_PAGE=
_HEIGHT), ssd13xx->height);
>> +       if (ssd13xx->device_info->family_id =3D=3D SSD130X_FAMILY) {
>> +               /* Align y to display page boundaries */
>> +               rect->y1 =3D round_down(rect->y1, SSD130X_PAGE_HEIGHT);
>> +               rect->y2 =3D min_t(unsigned int, round_up(rect->y2, SSD1=
30X_PAGE_HEIGHT),
>> +                                ssd13xx->height);
>> +       }
>
> Don't you need to align to page boundaries (2 pixels per page)
> on SSD132X?
>

I guess so, yes. I'll add that to v2 as well.

> This should be handled through ssd13xx_funcs instead of a family check.
>

Agreed.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

