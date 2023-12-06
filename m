Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5632D80794D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442894AbjLFUWj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379461AbjLFUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:22:38 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C0D1;
        Wed,  6 Dec 2023 12:22:44 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso33882fac.1;
        Wed, 06 Dec 2023 12:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894164; x=1702498964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j41kzx3s+Lo9n7iUVy0Ar6AWX6l9HBvX9XWuY/yvyU=;
        b=EOcENLNTyfbIW8tSVOelHRwzhNl6IXl9pS80DwFYjozzh4qqHAUbnr3+6t8m9yY5Pl
         +IIz8i+drj/BKzQb3PEz5EcTqjSz+UpG2tRIlu2Pb4uTl6Ie8AFh3z5gEL9/QwyS3AxC
         Gk2t+H6OYOtc3t5ZUwrmZ/A8xu5FwjU/mxMBBoix3UcbiEiC1l/YZZP5XswNFj+6aJF+
         cG/IYaSkjOJ8eMS5GAfNIaLc57FE/B9uaIRYTMSIDbf35jaYIqL/VC/jnzi0gNwYLWKK
         ARf0B1aIFbd/FgAdnKnQya2kouPPAfbeUsU6Qc7AGHGtIcR1YQlxmIhEP+GJoidiXMDA
         Gwsg==
X-Gm-Message-State: AOJu0YzoQ2u5l6dav2YnziO6sdzu5In9desLJYW+Q6DnAPaD/hcZUJTQ
        CoS3q1FnRV+QNnWCMN0PIlZVc++Bk0Pfv55Xyvw=
X-Google-Smtp-Source: AGHT+IEhO2mU6P/7052PchUGl0mD/WRb+JlHzOLetzdJxqFUjJkan2T6grG1crR2CLmqbqHs5uwGwAIAsJnq65+10lk=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2893274oab.0.1701894164249; Wed, 06
 Dec 2023 12:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20231204180037.383583-1-prarit@redhat.com>
In-Reply-To: <20231204180037.383583-1-prarit@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:22:33 +0100
Message-ID: <CAJZ5v0g2mgGyL3ti9Q1rS2unQbXj9mNLr_4Repp==Hh_iiUyzQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: extlog fix null dereference check
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Mon, Dec 4, 2023 at 7:00 PM Prarit Bhargava <prarit@redhat.com> wrote:
>
> The gcc plugin -fanalyzer [1] tries to detect various
> patterns of incorrect behaviour.  The tool reports
>
> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
>     |
>     |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>     |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     |      |                                                  |
>     |      |                                                  (1) pointer ‘extlog_l1_addr’ is dereferenced here
>     |  307 |         if (extlog_l1_addr)
>     |      |            ~
>     |      |            |
>     |      |            (2) pointer ‘extlog_l1_addr’ is checked for NULL here but it was already dereferenced at (1)
>     |
>
> Fix the null dereference check in extlog_exit().
>
> [1] https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options.html
>
> CC: "Rafael J. Wysocki" <rafael@kernel.org>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/acpi/acpi_extlog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e120a96e1eae..193147769146 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -303,9 +303,10 @@ static int __init extlog_init(void)
>  static void __exit extlog_exit(void)
>  {
>         mce_unregister_decode_chain(&extlog_mce_dec);
> -       ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -       if (extlog_l1_addr)
> +       if (extlog_l1_addr) {
> +               ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>                 acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +       }
>         if (elog_addr)
>                 acpi_os_unmap_iomem(elog_addr, elog_size);
>         release_mem_region(elog_base, elog_size);
> --

Applied as 6.8 material with minor edits in the subject and changelog, thanks!
