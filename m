Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230B7AEA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjIZKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIZKfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:35:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CB8BF;
        Tue, 26 Sep 2023 03:35:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6907e44665bso7434152b3a.1;
        Tue, 26 Sep 2023 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695724549; x=1696329349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JI22u4oFcSIyGcZiwVeeO4sm05tqY+QDbtPIh5RQo1w=;
        b=Ta95eXlBEe8uw1ZXLKbttCxboZ7Z64pposu2U2lP7kZAUWePPV9rF+HLpezhVEVAwH
         sddxCpWLi5XO8Jua08takSmakpQhqXTuXZBXi/yTyRFrgsMaIedi2uc38C1DY+i2Qeuz
         0QxU+L5YHIPDLZ0WGfAxBjQDSDUU96toM6hUKjUk73p/SHUod+5CN3q0ckzKS3W9kzKz
         4dwTeiPLtMX+Lpyr/uZ54CXeUcRtxy+wEswVFKPq/JaZqP5LieD4SGaxeBdH28M6L1En
         ntDYeBNu75IdsloukPn84TZJzvMfrfaBaTV34gfVwWHl99L1gvxGwh1E7BpczT5XyzaG
         NPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724549; x=1696329349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI22u4oFcSIyGcZiwVeeO4sm05tqY+QDbtPIh5RQo1w=;
        b=wXDjvDn74zOx7EfOULiZH1RqV/VDtSdp5UMTQBS5f8rPEY//TpS5CfgZ5z+J3aqWKI
         6LMJcw/yzStSd9ufjUs3DsPhjvZcwjhirtG7HLNGn3BUyqYJNPLBRXPQDAdq0AXlLWWW
         e7WHCNuyu4reksBuI6Rr6hYODDCSSzrSQ/IPwB4MVTLcPAKArnGOVbY1j+NyOkKPPTJM
         bvNnUe500EMjjgLqwXal3L+NhdmcxRfoByLoMuLn5xQewgv4OBZnUXvDK+qO5wDDZ5K8
         IZZetE3TX8lFJH+kReczo4GcF0h30RuCtVexNphb03KmYMWXLGGylHRsi/GEqmE5y6Ef
         zAvQ==
X-Gm-Message-State: AOJu0Yx54JI7AtVIeW/w41girBqT9QmEz1Sh6g/Un7/QNULfS8sk3qyu
        LrTcnD59eDiSgjBcv4lOJKw=
X-Google-Smtp-Source: AGHT+IHPgxQLC3Tuaq5fkXY5EnNUthvz5JnG4AAGGsD5gZCBIyiEtOP5iIEm+MeIHUqJYXsXLl7SMg==
X-Received: by 2002:a05:6a00:a22:b0:691:21:d9b7 with SMTP id p34-20020a056a000a2200b006910021d9b7mr10322863pfh.27.1695724548760;
        Tue, 26 Sep 2023 03:35:48 -0700 (PDT)
Received: from sol (14-201-140-18.tpgi.com.au. [14.201.140.18])
        by smtp.gmail.com with ESMTPSA id q18-20020a638c52000000b0058264a3c942sm3792389pgn.69.2023.09.26.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:35:48 -0700 (PDT)
Date:   Tue, 26 Sep 2023 18:35:40 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 1/5] lib/test_bitmap: Excape space symbols when
 printing input string
Message-ID: <ZRKz/G8y397MmVoc@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926052007.3917389-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:20:03AM +0300, Andy Shevchenko wrote:
> test_bitmap_printlist() prints the input string which contains
> a new line character. Instead of stripping it, escape that kind
> of characters, so developer will see the actual input string

Grammar nit:

"that kind of characters" -> "those kinds of characters" or "that kind
of character" or "such characters" or ...

> that has been used. Without this change the new line splits
> the string to two, and the first one is not guaranteed to be
> followed by the first part immediatelly.

immediately

And the second "first" should be "second"??

"the second part is not guaranteed to immediately follow the first" is
clearer (and hopefully what you mean), IMHO.

Cheers,
Kent.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index f2ea9f30c7c5..1f2dc7fef17f 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -523,7 +523,7 @@ static void __init test_bitmap_printlist(void)
>  		goto out;
>  	}
>  
> -	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
> +	pr_err("bitmap_print_to_pagebuf: input is '%*pEs', Time: %llu\n", ret, buf, time);
>  out:
>  	kfree(buf);
>  	kfree(bmap);
> -- 
> 2.40.0.1.gaa8946217a0b
> 
