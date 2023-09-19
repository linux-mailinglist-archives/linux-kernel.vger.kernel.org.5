Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A958E7A5A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjISHDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:03:09 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1F100;
        Tue, 19 Sep 2023 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1695106970; bh=UaVoSUP+GmU9uEDaDrAjnF2PtCRtnQJ7nj017va/XkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kKwISfgwXmbn1gUQGj4NP6Zq45Iw/o0RMKYXWtvlYaQHmFyj9QaO+waiUEo3TFNR+
         pjQnf+bgwsX985INWTlKmv8jDoIrm0+SCK0RQgZ0xml3AoVX6pXKb4mfuFZPaR994Y
         RJHk+lD4koPprUjkygu8sNaUYYxSxXPOYBPz5O0A=
Date:   Tue, 19 Sep 2023 09:02:49 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: refactor deprecated strncpy
Message-ID: <987d843b-d451-4f85-85b2-00ec18c75cca@t-8ch.de>
References: <20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-strncpy-drivers-hwmon-acpi_power_meter-c-v2-1-8348432d6442@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-19 05:07:55+0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A trailing zero is already handled by the kcalloc
> |	*str = kcalloc(element->string.length + 1, sizeof(u8), GFP_KERNEL);
> ... which makes memcpy() a suitable replacement to strncpy.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use memcpy over strscpy (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hwmon-acpi_power_meter-c-v1-1-905297479fe8@google.com
> ---
>  drivers/hwmon/acpi_power_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index fa28d447f0df..82e99aec4a33 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -803,7 +803,7 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
>  			goto error;
>  		}
>  
> -		strncpy(*str, element->string.pointer, element->string.length);
> +		memcpy(*str, element->string.pointer, element->string.length);

Isn't this now essentially the same as kmemdup_nul()?

>  		str++;
>  	}
>  
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-hwmon-acpi_power_meter-c-c9f2d8053bef
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
