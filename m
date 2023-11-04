Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6667E1037
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjKDQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKDQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 12:07:33 -0400
Received: from rs227.mailgun.us (rs227.mailgun.us [209.61.151.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9819D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 09:07:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1699114045; x=1699121245; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=mIrZkNLfFQmJrTMlm06l8GQfR/oHbKA4CpRXcFL+3h8=;
 b=XaYWc/ge1C4usMfgvX+x+elx3Jk7bi4oHSVs/yd//nhLGsxr2YNo8qB6edec13W6dHiK8ziI5Ba1kIfOtOf5AZn3ZZQ0MmeuHIjT55ViLVbz6i+8QIBxxg1inIavAUz9PrueEhM0gPaBXKnYTCFv563GHEKnz02TdjoaiGV8UX6oUjyomc+GL+Kq9Itnl7gncHP6Rz8kLxrSdwc2c/VOBt4HG1uiov5ZQsdPz3aFJsEespRj/2GFHHi2PPivzSezxVt/UJuYYeFftrWcaA3SAnay6zSpsX3PMB/PBmwR0qDfBWc6rSN3zpt6IY8XmpH476Ff+z84Faj/E9U9k2DTQw==
X-Mailgun-Sending-Ip: 209.61.151.227
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by fd04f8955ffa with SMTP id
 65466c3d647274ac901a5fe3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Nov 2023 16:07:25 GMT
Sender: james@equiv.tech
Date:   Sat, 4 Nov 2023 09:07:24 -0700
From:   James Seo <james@equiv.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Lukasz Stelmach <l.stelmach@samsung.com>,
        Armin Wolf <W_Armin@gmx.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk
 800 G6
Message-ID: <ZUZsPO9aN+E3qAng@equiv.tech>
References: <20231103181931.677796-1-james@equiv.tech>
 <dec086cc-7403-4a06-b860-aae6daf8f0e7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dec086cc-7403-4a06-b860-aae6daf8f0e7@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 12:36:49PM -0700, Guenter Roeck wrote:
> On 11/3/23 11:19, James Seo wrote:
>> +static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
>> +{
>> +	const char *board_name;
>> +
>> +	if (property_map != hp_wmi_platform_events_property_map ||
>> +	    prop != HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME)
>> +		return false;
>> +
>> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
>> +	if (!board_name)
>> +		return false;
>> +
>> +	return !strcmp(board_name, HP_WMI_BOARD_NAME_ELITEDESK_800_G6);
> 
> Would it be possible to use a dmi table and dmi_check_system() ?
> That would make it easier to add more platforms later on if needed.
> 
> Thanks,
> Guenter
>

Hi Guenter,

Sure, I can do something like this:


#define HP_WMI_WSTR_INFO(name, wids) {					\
	.matches = {							\
		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),	\
		DMI_EXACT_MATCH(DMI_BOARD_NAME, (name)),		\
	},								\
	.driver_data = (void *)(wids),					\
}

struct hp_wmi_wstr_id {
	const acpi_object_type *property_map;
	int prop;
};

static const struct hp_wmi_wstr_id elitedesk_800_g6_wstr_ids[] = {
	{
		.property_map = hp_wmi_platform_events_property_map,
		.prop = HP_WMI_PLATFORM_EVENTS_PROPERTY_NAME,
	},
	{ },
};

static const struct dmi_system_id hp_wmi_dmi_wstr_table[] = {
	HP_WMI_WSTR_INFO("870C", elitedesk_800_g6_wstr_ids),
	{ },
};

static bool is_raw_wmi_string(const acpi_object_type property_map[], int prop)
{
	const struct hp_wmi_wstr_id *wstr_id;
	const struct dmi_system_id *id;

	id = dmi_first_match(hp_wmi_dmi_wstr_table);
	if (!id)
		return false;

	wstr_id = id->driver_data;
	for (; wstr_id->property_map; wstr_id++)
		if (property_map == wstr_id->property_map &&
		    prop == wstr_id->prop)
			return true;

	return false;
}


Out of curiosity, how would you feel about just adding full raw WMI string
support now? It wouldn't take much more work and for various small reasons
it's starting to look like a better idea to me.

James
