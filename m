Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD57580F6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377111AbjLLThz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:37:53 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FBA1;
        Tue, 12 Dec 2023 11:38:00 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5908b15f43eso480655eaf.1;
        Tue, 12 Dec 2023 11:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409880; x=1703014680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6TjCFcD7qqsRK8I7srUQGOuOzdomezjScNXBNfHm3c=;
        b=CriFQhx5hk5W2tseS+MUQG7YSyBpLDiMlDX/E1QASIDxaKmuTLtWhw1u8LxnBkX35i
         eGM0ijNr2paMNz8bORQ84gHzmJ1Pkcr/pUJnHAkroMuol4NslaEn2qOkKXN2vacNi+o4
         arNL4VqeBFuSFKWjpAtG9dFfpLjcm6TpBATpqWNaA5qUujQbQ4g7ifRpfGXhf6NYofTC
         +ilPXIEaMLj9aV1fBrdDR+La+ZzClbqHP7Pba5dH6mjPKGk4Y8W8+UO7EuTFLZp/0CDQ
         80vDdzwdFLTgDHDjj/2OmnLKt3Gl781UNR0usdhy3gBdIz0uxA437bP5VwpTYYFxdWRF
         4FIw==
X-Gm-Message-State: AOJu0YzfBpMZ2GMCi5qdiOZRDTrQD5trpU6+5tvpt+K4xRKEEkKcKB72
        odWo4WEh7qUyYOhWXRx6lSVl2atM8bxjyi6Kqv7A5e0u
X-Google-Smtp-Source: AGHT+IHUeZ5IA6EI9od+HcRjK7eilawttVi9sYNw6E2NHqGjYEiKVBQT4v0dg1zTZkhRiOEKPeNkOLpWPWsZu0OWTCE=
X-Received: by 2002:a05:6820:220d:b0:58d:5302:5b18 with SMTP id
 cj13-20020a056820220d00b0058d53025b18mr13895661oob.1.1702409879802; Tue, 12
 Dec 2023 11:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20231206104318.182759-1-ytcoode@gmail.com>
In-Reply-To: <20231206104318.182759-1-ytcoode@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 20:37:48 +0100
Message-ID: <CAJZ5v0gUO-mz2=nN_Xz7ngw0hms1CziDMAKBv=xndqZtHd44UQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI/NUMA: A few fixes and cleanups in drivers/acpi/numa/srat.c
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Wed, Dec 6, 2023 at 11:44 AM Yuntao Wang <ytcoode@gmail.com> wrote:
>
> This series fixes an issue and does some cleanups in drivers/acpi/numa/srat.c.
>
> Yuntao Wang (3):
>   ACPI/NUMA: Remove unnecessary check in acpi_parse_gi_affinity()
>   ACPI/NUMA: Optimize the check for the availability of node values
>   ACPI/NUMA: Fix the logic of getting the fake_pxm value

All patches applied as 6.8 material with some edits in the changelogs.

Thanks!
