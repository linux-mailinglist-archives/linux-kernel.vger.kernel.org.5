Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DF807559
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442563AbjLFQji convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 11:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379345AbjLFQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:39:36 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF3FA;
        Wed,  6 Dec 2023 08:39:42 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fb2b83986cso4041fac.0;
        Wed, 06 Dec 2023 08:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880782; x=1702485582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOpsMpN5kc6thb3d1q4d3kl9xx5Ha381XUlpiCeA7Vg=;
        b=Skr0ltN7RAh68pvyRQ62RYPCxQkTu3zX5vEV7e88NMba0BheWhtM9OU0p4nbhlQNRp
         MIMIwcRA90C1ojRWsvZr23RVolctb4WJxh7Oj4o2T6Qgg/A0VaG96mk2m3ceQJuNeF3Z
         75fcagUOb/zghK32WzCh7BrrdA1LBxT1WdUR0p2Hn1XEroNWB+/AnJIaikumhAGBUxe/
         n+sbxLQqKLlTRgQwiTpIHzgIiOfzciej85BSHAUwWTN8VwxeFWeGMM5RfOa0Jx5UemB4
         lxn8z61L7FhDdk5dbR8enUfvh5Ww+URb3rkPfb+N/W6GcrVqDHJHldh710GPlLw3LsYG
         9B1Q==
X-Gm-Message-State: AOJu0Yykcspxr++1unk5wx2E8XcYlOjSFPOPWjtLZTsuCVl3V4GNavtg
        vHBeLqx+H4W+i9W8djKOmJUyIcRXbxZcGX7Fi8b3Yv/4qUM=
X-Google-Smtp-Source: AGHT+IE+QBw0uGCe3QdwQFdjnKR42J/h74k4XSadE/DgYk6WWgxdbDG4+G3mwf1tieSM1OUVNXOpgCrQ+v1vLscpEso=
X-Received: by 2002:a05:6870:e2cb:b0:1fb:23ec:3318 with SMTP id
 w11-20020a056870e2cb00b001fb23ec3318mr2127789oad.0.1701880782199; Wed, 06 Dec
 2023 08:39:42 -0800 (PST)
MIME-Version: 1.0
References: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
In-Reply-To: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 17:39:29 +0100
Message-ID: <CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: debugger: check status of acpi_evaluate_object in acpi_db_walk_for_fields
To:     Nikita Kiryushin <kiryushin@ancud.ru>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 2:33 PM Nikita Kiryushin <kiryushin@ancud.ru> wrote:
>
> Errors in acpi_evaluate_object can lead to incorrect state of buffer.
> This can lead to access to data in previously ACPI_FREEd buffer and
> secondary ACPI_FREE to the same buffer later.
>
> Handle errors in acpi_evaluate_object the same way it is done earlier
> with acpi_ns_handle_to_pathname.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields
> of particular subtype")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpica/dbnames.c | 8 ++++++--

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index b91155ea9c34..c9131259f717 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>         buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> -
> +       status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_os_printf("Could Not evaluate object %p\n",
> +                              obj_handle);
> +               return (AE_OK);
> +       }
>         /*
>          * Since this is a field unit, surround the output in braces
>          */
> --
> 2.34.1
>
>
