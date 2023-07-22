Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF775D872
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 02:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGVAvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGVAv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 20:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4226BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689987033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJYv5x+k3Q4NH1eRkFB8Sxq+BIWu4PhXjDBrAF/r5Hk=;
        b=Viazr+bfyusLGlDw7giqc6lXvMeysIJ1n0GIWf4v7ng7ZlqAMTpIUAd/qPnUrM1AZ+sRG+
        9yu4F5pioY8hOMq0uxR5MVY8HEBW2Wa9ClVGtg6RbUIsiv8DgzW5n7ceoIap7KYonimLLb
        xEXFWnVQZMrU3XdNdCEnsJ2Xbknfm4A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-9gIurOMONYmLyfCK3EwAnw-1; Fri, 21 Jul 2023 20:50:31 -0400
X-MC-Unique: 9gIurOMONYmLyfCK3EwAnw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b70bfc97e4so24827861fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689987029; x=1690591829;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJYv5x+k3Q4NH1eRkFB8Sxq+BIWu4PhXjDBrAF/r5Hk=;
        b=Yo+qlCRNpGBCfitoirS3LwTRUQS28jQ8W5Em/5Ro0lIhwPEOm1MrltzD00tLbxctDE
         G9hg0NV19kZeEffwtk1AWW/p9F6xluo1Vuk8WLMP82AnR5bgz6w9i3QrFn5EUXPbMu0x
         AzqYlDb8bd/DLNcGzFfdE8t33vZcLWUwRrGsFfzDZVzqa3SDzbG8EKg7q4SlZCteMRm6
         TW//wxM1CB4GQlraaWyIFCZYkxx4qnG/eAS/ZiOfGaCjoD6CZLVfuXA9fow4mdpEiHoy
         cdUPA+alcl02VcXtMvbGtJ+AXH5J5ijSGDOeY+bmregag5UYyOcfKUiosprw13aeYfhh
         CStQ==
X-Gm-Message-State: ABy/qLbmzALkTy0XFLp5i3/x4/aQuaAaFyi/TKhRVYBWfrl/RzomP8Rj
        oq6AB07S17yQ6IM0tEiEm2TOGKb44+a3SpuErU9q+jEzCbFg2zGrCzXSi+mkjW0BHDMdhJG7JLW
        p9spfIuTdyid3XTIoEz+64qkU
X-Received: by 2002:a2e:9b06:0:b0:2b9:601d:2c3 with SMTP id u6-20020a2e9b06000000b002b9601d02c3mr2616250lji.37.1689987029680;
        Fri, 21 Jul 2023 17:50:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFD2Ck7YGPgxYDau0n94eHp8Rfq71xrJ0iC1YYZPposhWAbzYQSuWbwHpQN486Xy3RRLOn9ew==
X-Received: by 2002:a2e:9b06:0:b0:2b9:601d:2c3 with SMTP id u6-20020a2e9b06000000b002b9601d02c3mr2616243lji.37.1689987029310;
        Fri, 21 Jul 2023 17:50:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b003fbe561f6a3sm7028287wmq.37.2023.07.21.17.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:50:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <CANiq72=RBUdFdt8=k-AACxXWrbnqfiaiViNUNxvwzGNCDkjwQA@mail.gmail.com>
References: <20230719081544.741051-1-javierm@redhat.com>
 <20230719081544.741051-2-javierm@redhat.com>
 <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
 <CANiq72=A3PLGGPGnwL=gjX7LFsQL9N8W__ojxmVpj2uCAKvhQA@mail.gmail.com>
 <87mszou7kz.fsf@minerva.mail-host-address-is-not-set>
 <CANiq72=RBUdFdt8=k-AACxXWrbnqfiaiViNUNxvwzGNCDkjwQA@mail.gmail.com>
Date:   Sat, 22 Jul 2023 02:50:28 +0200
Message-ID: <87jzusu5uz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Sat, Jul 22, 2023 at 2:13=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>>
>> Oh, interesting. I wonder why that couldn't had been a fbdev driver then
>> using FB_VISUAL_MONO01? I'll reword then the commit message before apply
>> to the following instead:
>
> It is :)
>
>     .type =3D FB_TYPE_PACKED_PIXELS,
>     .visual =3D FB_VISUAL_MONO10,
>

Ah! Should had read the driver before commenting then :)

> The original distinction was more about having a place where to put
> small, simple displays that were not your usual "screen", where you
> would typically draw a custom UI, probably controlled with a few
> custom buttons, etc.
>

Got it. Then that's yet another argument for adding the auxdisplay
drivers under the same "Graphics support" menu.

>> Perfect, thanks!
>
> My pleasure!
>
> Cheers,
> Miguel
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

