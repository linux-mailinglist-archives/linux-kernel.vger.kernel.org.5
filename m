Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E976394A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjGZOfv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjGZOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:35:49 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2F10A;
        Wed, 26 Jul 2023 07:35:48 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-563393b63dbso729676eaf.1;
        Wed, 26 Jul 2023 07:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382147; x=1690986947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKHJCtI3GVQZ0a3o8Avbpjli9anhsZiCWTWJxzGkOmk=;
        b=ArbcksFi0RAwut7jhBoiSQWQ0Lkp4gOEnbFuBRJTUbdy3HDzmYCit/hXM6kejBC1nM
         wa83CJ/j305ilCr58cciUikaG2ny7YCV3bPpL6EoeDBW+nJuayd3reiFBHrNKyJ6EToE
         5tqL7gPW5ss0TWtmGI0pqA1Ufr+DLi9T06j2EkJqTAKPglSs97lZc3JGMTD3zKYQKA8V
         q31UKs3RiBiYfKJpTklpQcFZwsf4HqC9MAbW4Fve0xFHED65wj43JQbVn3SBBf70WOmV
         ahCcTWRreV1K3F3N15fx5yzUVZFJhjek3ZA80DqwtS3F+JBYYlf2fa93SxdkoQNPNfcO
         U6KQ==
X-Gm-Message-State: ABy/qLYT57s5rebeGta82AnK0IOx+SRkjsJ6f6F2NF3CA++EBoTMAnFS
        AfMni7Qm8i5MmDPRUiRbOIiLJ+iZJn7XuxwAGp8=
X-Google-Smtp-Source: APBJJlHYx0kwDJKxKCewX+CzY5nG5XWqTlWNb5y8DTNu9Kt7oq9XJ0X7Ba2KALOn15JUiLX9JUiEzMonlBMRDW5YR1E=
X-Received: by 2002:a4a:d806:0:b0:569:a35b:1bd3 with SMTP id
 f6-20020a4ad806000000b00569a35b1bd3mr1708830oov.1.1690382147068; Wed, 26 Jul
 2023 07:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <9445401f-7cfb-bbb5-e25c-28f578efa212@valinux.co.jp>
In-Reply-To: <9445401f-7cfb-bbb5-e25c-28f578efa212@valinux.co.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 16:35:35 +0200
Message-ID: <CAJZ5v0jSyE5chyVFFCaqOtE-huf8YH0mD6_udj2w4oA8KoN9qw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: Fix NULL dereference by acpi_os_map_memory()
To:     Kiwamu Okabe <okabe@valinux.co.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 6:53 AM Kiwamu Okabe <okabe@valinux.co.jp> wrote:
>
> The Infer static analyzer https://fbinfer.com/ reports following
> NULL poinster dereference by the acpi_os_map_memory() function.
> I believe this patch does fix the issue without any panic.

Please demonstrate to me that the NULL pointer dereference can
actually happen in this code.

Thanks!

> Signed-off-by: Kiwamu Okabe <okabe@valinux.co.jp>
> ---
>  drivers/acpi/tables.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 8ab0a82b4da4..ae7b7343bacf 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -717,6 +717,9 @@ acpi_table_initrd_override(struct acpi_table_header *existing_table,
>         while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
>                 table = acpi_os_map_memory(acpi_tables_addr + table_offset,
>                                            ACPI_HEADER_SIZE);
> +               if (WARN_ON(!table)) {
> +                       return AE_OK;
> +               }
>                 if (table_offset + table->length > all_tables_size) {
>                         acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
>                         WARN_ON(1);
> @@ -772,6 +775,9 @@ static void __init acpi_table_initrd_scan(void)
>         while (table_offset + ACPI_HEADER_SIZE <= all_tables_size) {
>                 table = acpi_os_map_memory(acpi_tables_addr + table_offset,
>                                            ACPI_HEADER_SIZE);
> +               if (WARN_ON(!table)) {
> +                       return;
> +               }
>                 if (table_offset + table->length > all_tables_size) {
>                         acpi_os_unmap_memory(table, ACPI_HEADER_SIZE);
>                         WARN_ON(1);
> --
> 2.39.2
>
