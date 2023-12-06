Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21F80757A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjLFQmZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 11:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjLFQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:42:23 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D97FA;
        Wed,  6 Dec 2023 08:42:29 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58dd5193db4so593381eaf.1;
        Wed, 06 Dec 2023 08:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880949; x=1702485749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIMxSzHR3qe9Kpm2WxCB7U+8a2fot2Cq5eXT0G3opo8=;
        b=SymsvCjQpV+N/1iiNY8gtAWu6dysHek206tip0KT4Kuo+KVTiK69Oc9ypgxj2ucRiz
         jHGgKFVkh4mIDEztWqC+eJRsK/frp1m9KKxtOs/rN7+R0CGkwKD0ZMS0gvrV0l++e1OE
         QICWMXFibwSJXK/3g4Sf6hQFHDW3Au/jJq8x/HoNl1w/tqvdiFCP8OsmO6cUOBfqJzIR
         cnQuHBkMOFICC3R3RcKp9AXL8s5C/X2G8GMVVgA5DQRfOSOyBiaHRImAULbyHTyMGVin
         sCppIT+xyu0utkKMsGzD/r1vFpUyqBh6yL/0DsYBybpJE7e2Vhupx/GZFfgzQ3hTBCCV
         LJIQ==
X-Gm-Message-State: AOJu0YzREgrCDe2MXkmltxuOnJbjHMGOHT5XGz22AfWQCGBwm35ixLZ4
        nzM9yp7YK8bpBXCkC/WIpvcLLl2gOK6ucz94SkI=
X-Google-Smtp-Source: AGHT+IF+3Ncf78ciIJeaNwWxRt+lcWpdhggiA3DAS/EzgAxn6GAxK1TNZCKnSlGnWwIZVQUmD20k7Sw8beVn2OvHVvE=
X-Received: by 2002:a05:6870:1481:b0:1fb:1d07:86a6 with SMTP id
 k1-20020a056870148100b001fb1d0786a6mr2047259oab.3.1701880948896; Wed, 06 Dec
 2023 08:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20231120114143.95305-1-ytcoode@gmail.com>
In-Reply-To: <20231120114143.95305-1-ytcoode@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 17:42:15 +0100
Message-ID: <CAJZ5v0ijJeOLJo=ooru9raj0n=iiGybFCud42Z+EEtncgNk47A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Correct and clean up the logic of acpi_parse_entries_array()
To:     Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 20, 2023 at 12:42 PM Yuntao Wang <ytcoode@gmail.com> wrote:
>
> The original intention of acpi_parse_entries_array() is to return the
> number of all matching entries on success. This number may be greater than
> the value of the max_entries parameter. When this happens, the function
> will output a warning message, indicating that `count - max_entries`
> matching entries remain unprocessed and have been ignored.
>
> However, commit 4ceacd02f5a1 ("ACPI / table: Always count matched and
> successfully parsed entries") changed this logic to return the number of
> entries successfully processed by the handler. In this case, when the
> max_entries parameter is not zero, the number of entries successfully
> processed can never be greater than the value of max_entries. In other
> words, the expression `count > max_entries` will always evaluate to false.
> This means that the logic in the final if statement will never be executed.
>
> Commit 99b0efd7c886 ("ACPI / tables: do not report the number of entries
> ignored by acpi_parse_entries()") mentioned this issue, but it tried to fix
> it by removing part of the warning message. This is meaningless because the
> pr_warn statement will never be executed in the first place.
>
> Commit 8726d4f44150 ("ACPI / tables: fix acpi_parse_entries_array() so it
> traverses all subtables") introduced an errs variable, which is intended to
> make acpi_parse_entries_array() always traverse all of the subtables,
> calling as many of the callbacks as possible. However, it seems that the
> commit does not achieve this goal. For example, when a handler returns an
> error, none of the handlers will be called again in the subsequent
> iterations. This result appears to be no different from before the change.
>
> This patch corrects and cleans up the logic of acpi_parse_entries_array(),
> making it return the number of all matching entries, rather than the number
> of entries successfully processed by handlers. Additionally, if an error
> occurs when executing a handler, the function will return -EINVAL immediately.
>
> This patch should not affect existing users of acpi_parse_entries_array().
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>

This needs to be ACKed by Dave Jiang or Dan Williams.

> ---
>  lib/fw_table.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index b51f30a28e47..b655e6f4b647 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -85,11 +85,6 @@ acpi_get_subtable_type(char *id)
>         return ACPI_SUBTABLE_COMMON;
>  }
>
> -static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
> -{
> -       return proc->handler || proc->handler_arg;
> -}
> -
>  static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
>                                           union acpi_subtable_headers *hdr,
>                                           unsigned long end)
> @@ -133,7 +128,6 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>         unsigned long table_end, subtable_len, entry_len;
>         struct acpi_subtable_entry entry;
>         int count = 0;
> -       int errs = 0;
>         int i;
>
>         table_end = (unsigned long)table_header + table_header->length;
> @@ -145,25 +139,19 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>             ((unsigned long)table_header + table_size);
>         subtable_len = acpi_get_subtable_header_length(&entry);
>
> -       while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
> -               if (max_entries && count >= max_entries)
> -                       break;
> -
> +       while (((unsigned long)entry.hdr) + subtable_len < table_end) {
>                 for (i = 0; i < proc_num; i++) {
>                         if (acpi_get_entry_type(&entry) != proc[i].id)
>                                 continue;
> -                       if (!has_handler(&proc[i]) ||
> -                           (!errs &&
> -                            call_handler(&proc[i], entry.hdr, table_end))) {
> -                               errs++;
> -                               continue;
> -                       }
> +
> +                       if (!max_entries || count < max_entries)
> +                               if (call_handler(&proc[i], entry.hdr, table_end))
> +                                       return -EINVAL;
>
>                         proc[i].count++;
> +                       count++;
>                         break;
>                 }
> -               if (i != proc_num)
> -                       count++;
>
>                 /*
>                  * If entry->length is 0, break from this loop to avoid
> @@ -180,9 +168,9 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>         }
>
>         if (max_entries && count > max_entries) {
> -               pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
> -                       id, proc->id, count);
> +               pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
> +                       id, proc->id, count - max_entries, count);
>         }
>
> -       return errs ? -EINVAL : count;
> +       return count;
>  }
> --
