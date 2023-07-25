Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F47622B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGYTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGYTyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6419BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690314799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ehsQdgWSIS7eeNPhg1juxuHJiisqBuDA4AQKiM8tp4=;
        b=QY9NxMNp3iTsTIV05fwM9kHD9BftD8GRCqkUga4k2qLDEEoGlETcFgDARLNB8DDfGvC7l4
        7Jn5a4dtqZXOEGif6Zu2sfYii9C6GwA7xNa7L2GvRS1KClY2UhjkEo/tS4xtffgIS5ATkp
        bOjimQ+lDHUxfrX+GvXsFwL6O8oXqT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-RDYM-f_vOySu7mj-g7SADQ-1; Tue, 25 Jul 2023 15:53:18 -0400
X-MC-Unique: RDYM-f_vOySu7mj-g7SADQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3158f4d72e9so2840006f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314797; x=1690919597;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ehsQdgWSIS7eeNPhg1juxuHJiisqBuDA4AQKiM8tp4=;
        b=kO8FWJIGmxfQ97nSH95qtwb/X/ltu1ef1uJVXUcfpdTl+DFYW8RUy2ebDtHVzI7yS1
         10rXI7ADZ5UWUP9pNo7eEEG7zYrnFNfUBpvGJJw+9xY2QDl3aS8Yx4yIbTZ134GEXpeE
         2QHicwTRWKrkdI7d8AjvXeYfBkusJg4omHFVqlOoE5teI41F41mG2767q+4m6CtxCKlF
         SPgxNuC0OGF65Sw9kYUrvrRfHpLOMWGWm5PQzPxRSQadAtva1sujU98UdK49Z5f6Mv8C
         Pe9QZj/pG0KyxP76VVozmjYCxqzptURCez76q/z83bviCKiqZ1YJ0RHJvcsy6n6SroGi
         vNHg==
X-Gm-Message-State: ABy/qLbsYOz0p//eNaIPCtgzJm8aFvgoNLEcoNXh9p5zUeZj0B/7kc5N
        d5Xn4ATzoQQSX/piDko0b5Zw3vYqdusBCWYya936kjO+Nn/kPZLGQyLFmZ2kk+6lePbQ7rNyIlS
        8ZCd0b+AEUYCOM9TlQby8J+fe
X-Received: by 2002:a5d:4ccd:0:b0:313:e9dc:44d5 with SMTP id c13-20020a5d4ccd000000b00313e9dc44d5mr8756124wrt.61.1690314797299;
        Tue, 25 Jul 2023 12:53:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfpWWBSGVv7qsi/9x0G1/ru7iK4Zf2hflHhR0TYMahLeFmVnfj9mjTHzpX0KH0ux4gaM1qHQ==
X-Received: by 2002:a5d:4ccd:0:b0:313:e9dc:44d5 with SMTP id c13-20020a5d4ccd000000b00313e9dc44d5mr8756108wrt.61.1690314796971;
        Tue, 25 Jul 2023 12:53:16 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003fc0505be19sm13825286wmc.37.2023.07.25.12.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 12:53:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <c10d925b-8d37-caa0-8f66-a0206f948c69@suse.de>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
 <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
 <c10d925b-8d37-caa0-8f66-a0206f948c69@suse.de>
Date:   Tue, 25 Jul 2023 21:53:16 +0200
Message-ID: <874jlrkbtf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>

[...]

>> 
>> Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
>> source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
>> on FB_CORE.
>
> No, please rather leave it where it is. There's no code dependencies to 
> the fbdev core; it merely depends on the Kconfig token.
>

Sure, fine by me. But I disagree that there's merely a Kconfig dependency.
The include/linux/linux_logo.h header declares both fb_find_logo() and
fb_append_extra_logo().

The fb_find_logo() function is defined in drivers/video/logo.c while the
fb_append_extra_logo() is in drivers/video/fbdev/core/fbmem.c, even though
only arch/powerpc/platforms/cell/spu_base.c uses fb_append_extra_logo().

So there's a relationship already between logo and fbdev/core, that's why
I wondered if would make sense to also move drivers/video/logo.c to have
both functions in there.

Yes, as noted drivers/video/console/newport_con.c also uses fb_find_logo()
but the only other user of that in drivers/video/fbdev/core/fbmem.c.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

