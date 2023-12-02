Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAD801F43
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjLBWyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBWyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E672116
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701557684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rDiaC8gmwkqMrLrLuxIdRXvkTePXT11VS7Tvo55eZtg=;
        b=ZUbPGrKJicX/ym0OXhcIql1I6GIzCRF4+bLB/84zXVWOdBEr5oTLNG3nCV2HwevoAd5QFc
        1MoxHztllig5LPSEmgjpZ8gKX/XwEi+Jv+fYaeG6VqjpO4JJbmtc7O4izLr+8FIDGWyJpV
        xFz8+kCEjYuxiEfoOG1rlGJs1Lcbi/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-HsQyYg2BMQ6CoQopPRW_bw-1; Sat, 02 Dec 2023 17:54:41 -0500
X-MC-Unique: HsQyYg2BMQ6CoQopPRW_bw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e11a22a0so2822681f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 14:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701557680; x=1702162480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDiaC8gmwkqMrLrLuxIdRXvkTePXT11VS7Tvo55eZtg=;
        b=pJ5NAF0c9Ww5ip0Ef39oGG47SL+GRdS2axoHTYHer3klAedryu4GDQWvoJZkVs+p/v
         3kO2t7zPA/fnCJcylnlAf6G8JRnxa7eJ7x6uPZA0vCaZXOpsaEjoGwfXBP+LdgAW3kmj
         vR1iVhGz16l3tSXOc4HgIQj5lt+vQHBkeU37AAII9MzHksdODjLHHIbmYddFBzHLQB7K
         kdfWvLoQ6FkeIt2vv6PLOttZM8Aa6hO06Ud57tVS+EEPn+JuwQm37DTKUwEbBalnmP/f
         03jbBVLMPzNgd5nC+7dfN6sqd1Rwn+GQ3NjqBs3Z2LsnWcqDDDZWmYkt3sszw4NpIm2Q
         miaQ==
X-Gm-Message-State: AOJu0YyJdy1VgHXEb/uQH6aZF+X626Er+AhtCQ/ZxBadVScmzHe+dQr/
        MKK2EcYt3VN2js08wiXXsQlQvT/aRyRs4nuvS+tOIoQUCGKw3vDY8J/qE4kqy9iO1qz36+6SUo2
        am5gs2qTzBQC310SwrgGEtaeN
X-Received: by 2002:a05:600c:198d:b0:40b:5e21:bdc6 with SMTP id t13-20020a05600c198d00b0040b5e21bdc6mr1211078wmq.85.1701557680056;
        Sat, 02 Dec 2023 14:54:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY8pqdK1WJw1JXBRTVAxbTjAVl1rJubin/wp1neDj4YG+JD2TCeIIIjK/TgzpIx/QlBPfVSQ==
X-Received: by 2002:a05:600c:198d:b0:40b:5e21:bdc6 with SMTP id t13-20020a05600c198d00b0040b5e21bdc6mr1211071wmq.85.1701557679157;
        Sat, 02 Dec 2023 14:54:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064a9800b00a0cd9d89a00sm3510588eju.151.2023.12.02.14.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 14:54:38 -0800 (PST)
Message-ID: <53fd830a-0f92-4d02-b407-bd93497e751b@redhat.com>
Date:   Sat, 2 Dec 2023 23:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/extcon/extcon-intel-cht-wc.c:153:3: warning: this
 statement may fall through
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <202311220741.oIvJcjV4-lkp@intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202311220741.oIvJcjV4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/22/23 00:27, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c2d5304e6c648ebcf653bace7e51e0e6742e46c8
> commit: de85d79f4aab67fe0537dd6e2c5d545b88239cc4 mfd: Add Cherry Trail Whiskey Cove PMIC driver
> date:   6 years ago
> config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220741.oIvJcjV4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311220741.oIvJcjV4-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/extcon/extcon-intel-cht-wc.c: In function 'cht_wc_extcon_get_charger':
>>> drivers/extcon/extcon-intel-cht-wc.c:153:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>       dev_warn(ext->dev,
>       ^~~~~~~~~~~~~~~~~~
>        "Unhandled charger type %d, defaulting to SDP\n",
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         ret);
>         ~~~~
>    drivers/extcon/extcon-intel-cht-wc.c:157:2: note: here
>      case CHT_WC_USBSRC_TYPE_SDP:
>      ^~~~

I have no idea why lkp is reporting this warning now, this has long been fixed, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/extcon/extcon-intel-cht-wc.c?id=962341b54b99965ebec5f70c8d39f1c382eea833

Regards,

Hans



