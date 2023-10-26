Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBFA7D7E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbjJZILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZILu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70F9B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698307858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mu9CqNzHmR1cghiTt072AyNStUb++59v1yqmM3sI/hY=;
        b=IoiGJw1IXDgfj1HAUoArJ+9Gmssi8QZUXVP66/ONARADxt1Kim2MLAeTQyAUJ2P8aTJCKG
        2oR1be4Q62OuL9CJomQqRRoXjaGBNnmegu8F/5J+gr44BW/4n2yPlkXogc9weQ6Q1SxwtM
        vs1MU9RTqfkbreXcP5fWlTp7nxcv00s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-ybismBlQPXq5vZDZX11hxg-1; Thu, 26 Oct 2023 04:10:56 -0400
X-MC-Unique: ybismBlQPXq5vZDZX11hxg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53e305a5a1bso419754a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307855; x=1698912655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mu9CqNzHmR1cghiTt072AyNStUb++59v1yqmM3sI/hY=;
        b=a32h5TRphNbwigvbteqjy3j/tnlQFtw/J5Yr/FFhJ/mTx71xhWSNOVxVyL84MSr4L1
         WzrQ4Ow9utd3f20XY5EgSIsi4IwV/LMyPyXWNm+mI3hfE5rYMUqshWPUbe08OVKkKG/o
         52sWyWlTlaof+af2LY5kAGTB6bl/RdDyZ5EBY35bpA5pFoGicG2c1jlBmltAtT1F6e5G
         n85Y8Fa7tE49tyAgHQ9uUOe8OWF4V9zydcOuxnfcZ3EBbYWAZh17c/raC33BNOJwBkhw
         CoEW/EWHdI3LFZVXQAjY26tg/R5aJSmzQUoDYgI7PVb53fsG621Sfw7i5dwK4ZzIhPEd
         Tr7g==
X-Gm-Message-State: AOJu0Yxnf7moRHicbakJOnk+TEyaSUrttW7hP22RcVfH75zLTgsabE8k
        2EldWr+80PdRAjwUeytoIcs0zpILGkplcXNmPVDR3RPzuptJXeiJgkhVb52PuvhYTZ4obmbywwc
        wpeOCkpY7fGv/mJAvKfvpiLQp
X-Received: by 2002:a50:d653:0:b0:540:f0d8:d748 with SMTP id c19-20020a50d653000000b00540f0d8d748mr2861213edj.23.1698307855071;
        Thu, 26 Oct 2023 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2N1z2qWdGjfEA1yxlY2cOxTVTjatXRORFKvfK/3RMkyeH6al2P/rteW2Hyqs7Ekqu5vdAOA==
X-Received: by 2002:a50:d653:0:b0:540:f0d8:d748 with SMTP id c19-20020a50d653000000b00540f0d8d748mr2861194edj.23.1698307854786;
        Thu, 26 Oct 2023 01:10:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b0053e6e40cc1asm10749112edu.86.2023.10.26.01.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 01:10:54 -0700 (PDT)
Message-ID: <e2370602-256a-4c30-b73f-1552d7d8bf22@redhat.com>
Date:   Thu, 26 Oct 2023 10:10:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: Add s2idle quirk for more Lenovo laptops
To:     David Lazar <dlazar@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
References: <ZTlsyOaFucF2pWrL@localhost>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZTlsyOaFucF2pWrL@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/25/23 21:30, David Lazar wrote:
> When suspending to idle and resuming on some Lenovo laptops using the
> Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
> dmesg as repeated errors:
> 
> nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
> address=0xb6674000 flags=0x0000]
> 
> The system is unstable afterwards.
> 
> Applying the s2idle quirk introduced by commit 455cd867b85b5
> ("platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of
> laptops") allows these systems to work with the IOMMU enabled and s2idle
> resume to work.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: David Lazar <dlazar@gmail.com>

Thank you and Mario and Mark thank you for the reviews.

I'll prep + send a fixes pull-req to Linus
with just this single patch tomorrow.

Regards,

Hans



> ---
>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 73 +++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index ad702463a65d..6bbffb081053 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
>  		}
>  	},
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
> +		}
> +	},
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 14AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 14AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 15AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
> +		}
> +	},
>  	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>  	{
>  		.ident = "HP Laptop 15s-eq2xxx",

