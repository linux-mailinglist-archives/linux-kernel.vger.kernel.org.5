Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C237FFBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376563AbjK3TvU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 14:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjK3TvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:51:17 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EE10D9;
        Thu, 30 Nov 2023 11:51:20 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5a0dc313058so136471a12.0;
        Thu, 30 Nov 2023 11:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373880; x=1701978680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJU5RuE0x+xF9mko7R10DFPHzyAQ5KB1GOFj2cnT57k=;
        b=rwtPNW3zhV8z9RabPkiekD+P4kifiy4FHJUC4v+8gGp8bev10lRyFr/HOcDWeYund/
         8TJQMNPgC4UOL9fQpj4PFfv8rU6SMQ7ym3v6vHv1JGjtF2y8ACPuF7qC2Qn5TQnq11Zh
         0qr0XqyfSz4+GjpALilSDEEGNNvHQ/JpDOj9Wpp/uyPTp3z41Cd1ZLvt+wRHnX54+3FO
         QKAJtlpBZDRVs1CAKqyvd8loDE0x/Sy9sPMYYMHb0iXRd86b2MOf2H+I/OECkfxUOeBq
         2xz+XUPNeyhXgwN9NSDVK4LA+BCH4IuRPDWHzIuiQfavCuaOMhuYNP3FfEH5QlhrrJFe
         B1Yw==
X-Gm-Message-State: AOJu0Yzk6TTRODk83id9uUwjMy6OswjLdKHtYZpn9bcQUlCPYHB6HSmM
        SpXL1kBiMS0zuGNTi6uQzr9I6VGB1raPFKZdcuI=
X-Google-Smtp-Source: AGHT+IEFEK0LHZXePrtLzsfQf6R9c7+Ca+68z5ZzBNw0EzmjpUDqlWBqijb28fQCsMkPW9EnYkvf/ceIGlmP9n4sFkU=
X-Received: by 2002:a05:6a20:da91:b0:187:df59:5c43 with SMTP id
 iy17-20020a056a20da9100b00187df595c43mr29063050pzb.2.1701373880126; Thu, 30
 Nov 2023 11:51:20 -0800 (PST)
MIME-Version: 1.0
References: <5754079.DvuYhMxLoT@kreacher> <12355894.O9o76ZdvQC@kreacher>
In-Reply-To: <12355894.O9o76ZdvQC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Nov 2023 20:51:08 +0100
Message-ID: <CAJZ5v0jKOarHuhVgS_Q8Rtamt6uP8LKdbVC=moYNO=WT+Kueog@mail.gmail.com>
Subject: Re: [PATCH v1.1 2/2] thermal: sysfs: Simplifications of trip point
 attribute callbacks
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong subject, sorry for the noise.  Will resend.

On Thu, Nov 30, 2023 at 8:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The _show() callback functions of the trip point sysfs attributes,
> temperature, hysteresis and type, need not use thermal zone locking,
> because the layout of the data structures they access does not change
> after the thermal zone registration.
>
> Namely, they all need to access a specific entry in the thermal
> zone's trips[] table that is always present for non-tripless thermal
> zones and its size cannot change after the thermal zone has been
> registered.  Thus it is always safe to access the trips[] table of a
> registered thermal zone from each of the sysfs attributes in question.
>
> Moreover, the type of a trip point does not change after registering its
> thermal zone, and while its temperature and hysteresis can change, for
> example due to a firmware-induced thermal zone update, holding the zone
> lock around reading them is pointless, because it does not prevent stale
> values from being returned to user space.  For example, a trip point
> temperature can always change ater trip_point_temp_show() has read it
> and before the function's return statement is executed, regardless of
> whether or not zone locking is used.
>
> For this reason, drop the zone locking from trip_point_type_show(),
> trip_point_temp_show(), and trip_point_hyst_show().
