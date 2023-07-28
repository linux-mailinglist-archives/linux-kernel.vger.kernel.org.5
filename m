Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0207C767090
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbjG1PbW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjG1PbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:31:21 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824335A8;
        Fri, 28 Jul 2023 08:31:20 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-565e64ed9f7so264656eaf.1;
        Fri, 28 Jul 2023 08:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558279; x=1691163079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hVzfuNh9MUjr8i57XR6qph+tGTTd2zJJ4as7llKbWk=;
        b=G9x1/sbAZWydm0xql2fwrZLwlPPnm7/njtnQSP9E+R0URaixOtfvH6akrRfNDU2VRm
         7dqTcb6lHNqj99IuLYHMxi7trI9/fyFmX2vKIcPShmzKpMCmpcvL7r1RnT4IcbIaFuQ3
         VeKFxYrwjzjcvQaagXBwofcMe5qEBOeOAOuiUY4VPofB8CNlkjDFDUBfye0DpnCtOPEg
         dnBkYF0ko0jPRylEiAWqSVyyNDhWMiG9QVb+BJnE7NwucfZvd5OUWLXgoUKwCz4bx2HA
         el/yDkPwsHcZkVnaMa5S1F8UCKGdqjTa4r1rkY3CvmlrBKdz/HP4Us86S16JhcYXZVgx
         uuEg==
X-Gm-Message-State: ABy/qLYTScKE0uZiVxD7ff+djjL+R4RWA987UJPpGBnrXSwoU92uWtfg
        M6hEtrPaZzKgl3+FBS1h9EQ5lI2fhXR1XN5PIrZo8f3p
X-Google-Smtp-Source: APBJJlE74kpzfh4LxDdn446uwEZun6DOOyt8oYsPPadxJeNcZQXVmQ9WTlDD6R9Dw93N1faGjY8q7HYCKy1rsJoGAII=
X-Received: by 2002:a4a:ba07:0:b0:56c:5e21:c730 with SMTP id
 b7-20020a4aba07000000b0056c5e21c730mr2383772oop.1.1690558279483; Fri, 28 Jul
 2023 08:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230728111345.7224-1-rf@opensource.cirrus.com>
In-Reply-To: <20230728111345.7224-1-rf@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 17:31:08 +0200
Message-ID: <CAJZ5v0ii8AR9fXQJo_DXd60yFrui4Wiw=9C6xPqrKPie8rBSVQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Create platform device for CS35L56
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:13 PM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> From: Simon Trimmer <simont@opensource.cirrus.com>
>
> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
> is used in multiples, and can be connected either to I2C or SPI.
>
> There will be multiple instances under the same Device() node. Add it
> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
> driver.
>
> There can be a 5th I2cSerialBusV2, but this is an alias address and doesn't
> represent a real device. Ignore this by having a dummy 5th entry in the
> serial-multi-instantiate instance list with the name of a non-existent
> driver, on the same pattern as done for bsg2150.
>
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Still ACKed.

> ---
>  drivers/acpi/scan.c                             |  1 +
>  drivers/platform/x86/serial-multi-instantiate.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5b145f1aaa1b..87e385542576 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1714,6 +1714,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>                 {"BSG1160", },
>                 {"BSG2150", },
>                 {"CSC3551", },
> +               {"CSC3556", },
>                 {"INT33FE", },
>                 {"INT3515", },
>                 /* Non-conforming _HID for Cirrus Logic already released */
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 2c2abf69f049..8158e3cf5d6d 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda = {
>         .bus_type = SMI_AUTO_DETECT,
>  };
>
> +static const struct smi_node cs35l56_hda = {
> +       .instances = {
> +               { "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +               { "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +               { "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +               { "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +               /* a 5th entry is an alias address, not a real device */
> +               { "cs35l56-hda_dummy_dev" },
> +               {}
> +       },
> +       .bus_type = SMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to ignore_serial_bus_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -337,6 +350,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
>         { "BSG1160", (unsigned long)&bsg1160_data },
>         { "BSG2150", (unsigned long)&bsg2150_data },
>         { "CSC3551", (unsigned long)&cs35l41_hda },
> +       { "CSC3556", (unsigned long)&cs35l56_hda },
>         { "INT3515", (unsigned long)&int3515_data },
>         /* Non-conforming _HID for Cirrus Logic already released */
>         { "CLSA0100", (unsigned long)&cs35l41_hda },
> --
> 2.30.2
>
