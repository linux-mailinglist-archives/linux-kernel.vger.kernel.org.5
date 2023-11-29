Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727C87FDAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjK2PSA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjK2PR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:17:59 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D23130;
        Wed, 29 Nov 2023 07:18:05 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58dcc1c1662so24369eaf.0;
        Wed, 29 Nov 2023 07:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271084; x=1701875884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRL70tfnciqpnZQShe5VMW79vFweuj5MNYehzRNT6wg=;
        b=oJGwCBZNBuE6jtsFb9+Fb2jALMi6wVx6MlY56mQCRBa8Zcbv9SKQUMYdox6K5wohE8
         v5kVtaONrD2G5xcJSJiQcIPr+e/qBt+1+8Wt3CfikiTLcKHSTFsVMydgL1t6gEEUmh/8
         ohN+WcrqhT3Zx9Makj+fANbgcEImyyTt9z2tO8j1vSpmHPCYAuW4MocoQKXEz9E8p2DU
         Tyv+1YR6u3Q6yWpn0FHR3P3JcUmSVZS6+2xclVzY5Ln78Lu6I5VYG/4f2DEOEh3T/+Tu
         4dBQuKnkzCICQ6NtE4wUAHXQwal/PaHxtNmd9o6mkyxwojbK4He5UrHKwBAOLIdaw3W5
         vWTA==
X-Gm-Message-State: AOJu0YxTFOepW0Qb0BiCIStFJ9+XEZk4hjdkPzBVP3WXDOORZhtDAW9j
        jfmZ4H7hf/5henEWEplz6iR78PP1+/i8rdMR4As=
X-Google-Smtp-Source: AGHT+IECpXnLFy60MfUtXkrbb44qwWzOO8r2kcoPpen+NBQ+O+6/qWjnPyw7K6s3hrp7fedrmgYTV92FNisIQ6SX4aY=
X-Received: by 2002:a4a:e79a:0:b0:58d:be0d:6f7b with SMTP id
 x26-20020a4ae79a000000b0058dbe0d6f7bmr4401432oov.1.1701271084466; Wed, 29 Nov
 2023 07:18:04 -0800 (PST)
MIME-Version: 1.0
References: <3281896.aeNJFYEL58@kreacher> <7617703.EvYhyI6sBW@kreacher> <ZWdF_XdUD6gxtYIW@smile.fi.intel.com>
In-Reply-To: <ZWdF_XdUD6gxtYIW@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 16:17:53 +0100
Message-ID: <CAJZ5v0heXGK0yjG-XL=YYKLhEroJpjvmy_yVFEPAF05h-O1LQQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ACPI: OSL: Allow Notify () handlers to run on all CPUs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
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

On Wed, Nov 29, 2023 at 3:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 29, 2023 at 02:50:54PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Notify () handlers, like GPE handlers, are only allowed to run on CPU0
> > now out of the concern that they might trigger an SMM trap and that (in
> > some cases) the SMM code running as a result of that might corrupt
> > memory if not run on CPU0.
>
> Pardon my French, but I'm a bit lost in the semantics of all those "that".

Well, fair enough.

> Maybe the above can be simplified?

It can be rephrased.
