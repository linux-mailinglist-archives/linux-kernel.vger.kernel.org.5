Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4E758FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGSIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGSIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A54E47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689753602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=speJPG1ycW/BkN4uS1NK3jR/omXFRRfNvkd75pwFmqw=;
        b=SO9CuQvKFtQ4DcxlS4H4HDihSQ9jLvgmd3xJl3kmvfSMdM7+YkQriEeOsSsMLT/AKyiwzZ
        WGYpxFUVoxepfaZ5Oi6WQeog9jsV+o7vDYF21jRvh7Bel3/h6oe6/n/EKYDjU1FRnLFj38
        iBzAzX1mdTs3EG5TY3APSC6bCaf6bZw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-nLZDOPNnPUKOVAXTqK1YYA-1; Wed, 19 Jul 2023 04:00:01 -0400
X-MC-Unique: nLZDOPNnPUKOVAXTqK1YYA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-316f39e3e89so200006f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753600; x=1690358400;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=speJPG1ycW/BkN4uS1NK3jR/omXFRRfNvkd75pwFmqw=;
        b=bIcI6U6swW9MqaKVR7A9rYPITScPkkGZsb7TS/3/O1WHyz0jidEs/UqfpRA2LP7Q2m
         cW0sTX+7N6aPxOHqQbZQQZ7n145qKut9IUTgpLi6HqGs+LcM2ayBmJ9iTXIhikK8LyY8
         ZDPW1kJogkb6avUUsEUkAzCFHc1n/sQQmsSyw+Abyh9wIkBNv+CmUjYToU4FOAsAibJI
         MVCtJNnHltZ4ggvN2QvbvjQStUA2odrtweY/lzaH0Rg33MdJ0kObxxr7gXhXc46aG4ZT
         UpwjqUd3ydoB7Ps0SBMTad7+72KjZ1PZCXU0LI9Vcbl8GD2fC6YBEFVlDQRr/1IpKXr4
         Z5iA==
X-Gm-Message-State: ABy/qLbo2ZgNeupZdGEaCLX5x1ouLjhQwlcNf1m1QFR1sKKucz/T9coV
        Wc8UcGGgc/gqjJm+0mKJEL1YokQH92TEUTXkcXlIMAJ3fMg2so/eJyrjnkSSWrh6zuR/Svb7dcT
        Re5eQ5pSBeJnzttJa09oEu0k4
X-Received: by 2002:adf:f183:0:b0:315:a235:8aa8 with SMTP id h3-20020adff183000000b00315a2358aa8mr1151881wro.2.1689753600520;
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGbErd5rOGWg9sKl7p9YbHezYUElnKB4HQRHgHvdWvGr5xTLlQhBGuXUlUSr7TY0UzQpwLZSQ==
X-Received: by 2002:adf:f183:0:b0:315:a235:8aa8 with SMTP id h3-20020adff183000000b00315a2358aa8mr1151868wro.2.1689753600230;
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i3-20020adfe483000000b00313f61889ecsm4551037wrm.66.2023.07.19.00.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:00:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 2/4] fbdev: Move core fbdev symbols to a separate
 Kconfig file
In-Reply-To: <f925fa1c-a6db-4032-8adc-d6aba8cd2ef8@app.fastmail.com>
References: <20230714171642.91185-1-javierm@redhat.com>
 <20230714171642.91185-3-javierm@redhat.com>
 <f925fa1c-a6db-4032-8adc-d6aba8cd2ef8@app.fastmail.com>
Date:   Wed, 19 Jul 2023 09:59:59 +0200
Message-ID: <87lefcib5s.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Jul 14, 2023, at 19:16, Javier Martinez Canillas wrote:
>> The drivers/video/fbdev/Kconfig defines both symbols for fbdev drivers and
>> core fbdev symbols, that can be enabled independently of the fbdev drivers.
>>
>> Split the Kconfig in two, one that only has the symbols for fbdev drivers
>> and another one that contains the fbdev core symbols.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>
> While testing this patch series, I noticed a conflict against
> Thomas Zimmermann's series for FB_SYS_HELPERS_DEFERRED, so you'll
> have to adapt the patches in order to apply them on top.
>

Indeed. That was my bad when doing the conflict resolution on rebase.

>> +
>> +config FB_HECUBA
>> +	tristate
>> +	depends on FB
>> +	depends on FB_DEFERRED_IO
>> +
>> +config FB_SVGALIB
>> +	tristate
>> +	depends on FB
>> +	help
>> +	  Common utility functions useful to fbdev drivers of VGA-based
>> +	  cards.
>> +
>> +config FB_MACMODES
>> +	tristate
>> +	depends on FB
>> +
>
> The FB_HECUBA now needs 'FB_SYS_HELPERS_DEFERRED' instead
> of 'FB_DEFERRED_IO', which is the change done in the other
> patch. I think the best way of doing that would be to just
> not move the three symbols above to core/Kconfig but leave them
> in place, as they are all just helper modules for some other
> drivers, rather than core code.
>

Agreed. I'll change that in v6 as well.

>       Arnd
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

