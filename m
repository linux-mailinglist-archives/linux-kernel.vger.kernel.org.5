Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246BA800277
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377291AbjLAEL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:11:56 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F056170D;
        Thu, 30 Nov 2023 20:12:02 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b88f2a37deso82244b6e.0;
        Thu, 30 Nov 2023 20:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403922; x=1702008722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnESfCU4C29IBkRwYQL0U9rC92Mng7P+RMsbFW8/Xbg=;
        b=AqsuVOl9noJG/hSSXQYsqu+h6vbdEOL5YiD8XN44CV5swWuO1mbJvrtQcRNB3PAzhq
         +vM754H1M0rXKUUUqlvKYnV449sUJ51Z6bEjMm0vvwVM7iJuM6tdHrRFfc1KjqZVHuXE
         Tv6qS9LOmEGWEdzJRLHssOD0VRnTsxYLQLKpKLy2U/EV3FAGBlBxmWnOrjB94KTOVrqu
         gnKs55KWZcL9E7eN1LpgPEe0FeaXCzngZnlRwDUdGky7Ke5ZO4dsCz6dnUE63ScsCl1h
         pezcYoJlk2+C3jQyZpNt3uVRKbd2idPnWTGmsLNcaN1LbRXiQ9XagcEaZvY8nBj4Q80B
         2kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403922; x=1702008722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnESfCU4C29IBkRwYQL0U9rC92Mng7P+RMsbFW8/Xbg=;
        b=VH4etFABcTHBwRVsNqnOiGCnyOgc/FdxtT4eo2pomjAs2apdEPiwVjy6UoegRRJbUo
         vNvnVieuO8atM2bAgJFztDUlz4V7o54QezU9MSSNK87yLh5zrJnn/cb9oFDFfvpUkfRO
         OsiacNiU7+/nTr5V7JdgRbd67O/vQSsB4VmusD+rhpbFFLv6Xf68oryxEAI+/G1MrMAL
         xHtSK+FXtGlZ9Yiry1YUxgMwY7yhRtqpqLH1jxzkDUi7bprlbBD+9vskg7uOGxXCiCXw
         5kAJYMlehDnqEMCYDeeAi5kbFcOoPVYZv+6hYGjbe6amJSKcrTjZOht49ZVax88JVtTb
         SztA==
X-Gm-Message-State: AOJu0YxHGL0QxxTS3vkTZNIhMk/KpxpJ/PHO6X/WxhemyktccQFyWxiW
        F3b6k0YNQ9TbBYj0OeHxO6TTfhKbaPE=
X-Google-Smtp-Source: AGHT+IEQOi98xu9aQC90ZKltpGsHJmAnWDflBVISmd6T4OJzPcX9j3VFLiGP592NkNO5SQ2X+aBWlg==
X-Received: by 2002:a05:6808:3083:b0:3a7:4e0c:faa9 with SMTP id bl3-20020a056808308300b003a74e0cfaa9mr1841048oib.29.1701403921770;
        Thu, 30 Nov 2023 20:12:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15-20020a54468f000000b003a3860b375esm414631oic.34.2023.11.30.20.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:12:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 20:12:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3] hwmon: (hp-wmi-sensors) Fix failure to load on
 EliteDesk 800 G6
Message-ID: <20536823-9dcf-462a-8037-8697392da3b0@roeck-us.net>
References: <20231123054918.157098-1-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123054918.157098-1-james@equiv.tech>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:49:19PM -0800, James Seo wrote:
> The EliteDesk 800 G6 stores a raw WMI string within the ACPI object in its
> BIOS corresponding to one instance of HPBIOS_PlatformEvents.Name. This is
> evidently a valid way of representing a WMI data item as far as the
> Microsoft ACPI-WMI mapper is concerned, but is preventing the driver from
> loading.
> 
> This seems quite rare, but add support for such strings. Treating this as a
> quirk pretty much means adding that support anyway.
> 
> Also clean up an oversight in update_numeric_sensor_from_wobj() in which
> the result of hp_wmi_strdup() was being used without error checking.
> 
> Reported-by: Lukasz Stelmach <l.stelmach@samsung.com>
> Closes: https://lore.kernel.org/linux-hwmon/7850a0bd-60e7-88f8-1d6c-0bb0e3234fdc@roeck-us.net/
> Tested-by: Lukasz Stelmach <l.stelmach@samsung.com>
> Signed-off-by: James Seo <james@equiv.tech>

Applied.

Thanks,
Guenter

> ---
> 
> Changes v2->v3:
> * Fix checkpatch warnings
>   - Line break commit message differently (no non-whitespace changes)
>   - Use "unsigned int" instead of "unsigned"
> * Add Tested-by: from Lukasz Stelmach
> 
> Changes v1->v2:
> * Remove DMI-based workaround logic
> * Add full support for raw WMI strings
>   - Improve UTF-16 validation and conversion for the general case
>   - Support such strings if they occur in HPBIOS_BIOSEvent objects
> * Only use the result of hp_wmi_strdup() in update_numeric_sensor_from_wobj()
>   if the call succeeded
> 
> History:
> v2: https://lore.kernel.org/linux-hwmon/20231105192054.24833-1-james@equiv.tech/
> v1: https://lore.kernel.org/linux-hwmon/20231103181931.677796-1-james@equiv.tech/
> 
> ---
> drivers/hwmon/hp-wmi-sensors.c | 127 ++++++++++++++++++++++++++++-----
>  1 file changed, 111 insertions(+), 16 deletions(-)
> 
> 
> base-commit: c03cd01890c5e41138cc5709e37859bc917aab5d
> 
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
> index 17ae62f88bbf..b5325d0e72b9 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -17,6 +17,8 @@
>   *     Available: https://github.com/linuxhw/ACPI
>   * [4] P. Rohár, "bmfdec - Decompile binary MOF file (BMF) from WMI buffer",
>   *     2017. [Online]. Available: https://github.com/pali/bmfdec
> + * [5] Microsoft Corporation, "Driver-Defined WMI Data Items", 2017. [Online].
> + *     Available: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/driver-defined-wmi-data-items
>   */
>  
>  #include <linux/acpi.h>
> @@ -24,6 +26,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
> +#include <linux/nls.h>
>  #include <linux/units.h>
>  #include <linux/wmi.h>
>  
> @@ -395,6 +398,50 @@ struct hp_wmi_sensors {
>  	struct mutex lock;	/* Lock polling WMI and driver state changes. */
>  };
>  
> +static bool is_raw_wmi_string(const u8 *pointer, u32 length)
> +{
> +	const u16 *ptr;
> +	u16 len;
> +
> +	/* WMI strings are length-prefixed UTF-16 [5]. */
> +	if (length <= sizeof(*ptr))
> +		return false;
> +
> +	length -= sizeof(*ptr);
> +	ptr = (const u16 *)pointer;
> +	len = *ptr;
> +
> +	return len <= length && !(len & 1);
> +}
> +
> +static char *convert_raw_wmi_string(const u8 *buf)
> +{
> +	const wchar_t *src;
> +	unsigned int cps;
> +	unsigned int len;
> +	char *dst;
> +	int i;
> +
> +	src = (const wchar_t *)buf;
> +
> +	/* Count UTF-16 code points. Exclude trailing null padding. */
> +	cps = *src / sizeof(*src);
> +	while (cps && !src[cps])
> +		cps--;
> +
> +	/* Each code point becomes up to 3 UTF-8 characters. */
> +	len = min(cps * 3, HP_WMI_MAX_STR_SIZE - 1);
> +
> +	dst = kmalloc((len + 1) * sizeof(*dst), GFP_KERNEL);
> +	if (!dst)
> +		return NULL;
> +
> +	i = utf16s_to_utf8s(++src, cps, UTF16_LITTLE_ENDIAN, dst, len);
> +	dst[i] = '\0';
> +
> +	return dst;
> +}
> +
>  /* hp_wmi_strdup - devm_kstrdup, but length-limited */
>  static char *hp_wmi_strdup(struct device *dev, const char *src)
>  {
> @@ -412,6 +459,23 @@ static char *hp_wmi_strdup(struct device *dev, const char *src)
>  	return dst;
>  }
>  
> +/* hp_wmi_wstrdup - hp_wmi_strdup, but for a raw WMI string */
> +static char *hp_wmi_wstrdup(struct device *dev, const u8 *buf)
> +{
> +	char *src;
> +	char *dst;
> +
> +	src = convert_raw_wmi_string(buf);
> +	if (!src)
> +		return NULL;
> +
> +	dst = hp_wmi_strdup(dev, strim(src));	/* Note: Copy is trimmed. */
> +
> +	kfree(src);
> +
> +	return dst;
> +}
> +
>  /*
>   * hp_wmi_get_wobj - poll WMI for a WMI object instance
>   * @guid: WMI object GUID
> @@ -462,8 +526,14 @@ static int check_wobj(const union acpi_object *wobj,
>  	for (prop = 0; prop <= last_prop; prop++) {
>  		type = elements[prop].type;
>  		valid_type = property_map[prop];
> -		if (type != valid_type)
> +		if (type != valid_type) {
> +			if (type == ACPI_TYPE_BUFFER &&
> +			    valid_type == ACPI_TYPE_STRING &&
> +			    is_raw_wmi_string(elements[prop].buffer.pointer,
> +					      elements[prop].buffer.length))
> +				continue;
>  			return -EINVAL;
> +		}
>  	}
>  
>  	return 0;
> @@ -480,7 +550,9 @@ static int extract_acpi_value(struct device *dev,
>  		break;
>  
>  	case ACPI_TYPE_STRING:
> -		*out_string = hp_wmi_strdup(dev, strim(element->string.pointer));
> +		*out_string = element->type == ACPI_TYPE_BUFFER ?
> +			hp_wmi_wstrdup(dev, element->buffer.pointer) :
> +			hp_wmi_strdup(dev, strim(element->string.pointer));
>  		if (!*out_string)
>  			return -ENOMEM;
>  		break;
> @@ -861,7 +933,9 @@ update_numeric_sensor_from_wobj(struct device *dev,
>  {
>  	const union acpi_object *elements;
>  	const union acpi_object *element;
> -	const char *string;
> +	const char *new_string;
> +	char *trimmed;
> +	char *string;
>  	bool is_new;
>  	int offset;
>  	u8 size;
> @@ -885,11 +959,21 @@ update_numeric_sensor_from_wobj(struct device *dev,
>  	offset = is_new ? size - 1 : -2;
>  
>  	element = &elements[HP_WMI_PROPERTY_CURRENT_STATE + offset];
> -	string = strim(element->string.pointer);
> -
> -	if (strcmp(string, nsensor->current_state)) {
> -		devm_kfree(dev, nsensor->current_state);
> -		nsensor->current_state = hp_wmi_strdup(dev, string);
> +	string = element->type == ACPI_TYPE_BUFFER ?
> +		convert_raw_wmi_string(element->buffer.pointer) :
> +		element->string.pointer;
> +
> +	if (string) {
> +		trimmed = strim(string);
> +		if (strcmp(trimmed, nsensor->current_state)) {
> +			new_string = hp_wmi_strdup(dev, trimmed);
> +			if (new_string) {
> +				devm_kfree(dev, nsensor->current_state);
> +				nsensor->current_state = new_string;
> +			}
> +		}
> +		if (element->type == ACPI_TYPE_BUFFER)
> +			kfree(string);
>  	}
>  
>  	/* Old variant: -2 (not -1) because it lacks the Size property. */
> @@ -996,11 +1080,15 @@ static int check_event_wobj(const union acpi_object *wobj)
>  			  HP_WMI_EVENT_PROPERTY_STATUS);
>  }
>  
> -static int populate_event_from_wobj(struct hp_wmi_event *event,
> +static int populate_event_from_wobj(struct device *dev,
> +				    struct hp_wmi_event *event,
>  				    union acpi_object *wobj)
>  {
>  	int prop = HP_WMI_EVENT_PROPERTY_NAME;
>  	union acpi_object *element;
> +	acpi_object_type type;
> +	char *string;
> +	u32 value;
>  	int err;
>  
>  	err = check_event_wobj(wobj);
> @@ -1009,20 +1097,24 @@ static int populate_event_from_wobj(struct hp_wmi_event *event,
>  
>  	element = wobj->package.elements;
>  
> -	/* Extracted strings are NOT device-managed copies. */
> -
>  	for (; prop <= HP_WMI_EVENT_PROPERTY_CATEGORY; prop++, element++) {
> +		type = hp_wmi_event_property_map[prop];
> +
> +		err = extract_acpi_value(dev, element, type, &value, &string);
> +		if (err)
> +			return err;
> +
>  		switch (prop) {
>  		case HP_WMI_EVENT_PROPERTY_NAME:
> -			event->name = strim(element->string.pointer);
> +			event->name = string;
>  			break;
>  
>  		case HP_WMI_EVENT_PROPERTY_DESCRIPTION:
> -			event->description = strim(element->string.pointer);
> +			event->description = string;
>  			break;
>  
>  		case HP_WMI_EVENT_PROPERTY_CATEGORY:
> -			event->category = element->integer.value;
> +			event->category = value;
>  			break;
>  
>  		default:
> @@ -1511,8 +1603,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct hp_wmi_sensors *state = context;
>  	struct device *dev = &state->wdev->dev;
> +	struct hp_wmi_event event = {};
>  	struct hp_wmi_info *fan_info;
> -	struct hp_wmi_event event;
>  	union acpi_object *wobj;
>  	acpi_status err;
>  	int event_type;
> @@ -1546,7 +1638,7 @@ static void hp_wmi_notify(u32 value, void *context)
>  
>  	wobj = out.pointer;
>  
> -	err = populate_event_from_wobj(&event, wobj);
> +	err = populate_event_from_wobj(dev, &event, wobj);
>  	if (err) {
>  		dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
>  		goto out_free_wobj;
> @@ -1577,6 +1669,9 @@ static void hp_wmi_notify(u32 value, void *context)
>  out_free_wobj:
>  	kfree(wobj);
>  
> +	devm_kfree(dev, event.name);
> +	devm_kfree(dev, event.description);
> +
>  out_unlock:
>  	mutex_unlock(&state->lock);
>  }
