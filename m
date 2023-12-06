Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F6380745D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379482AbjLFQB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 11:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379484AbjLFQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:01:53 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41A10E6;
        Wed,  6 Dec 2023 08:01:51 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-58e255472daso590164eaf.0;
        Wed, 06 Dec 2023 08:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878511; x=1702483311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEEyO8kikl4P6RL0mPnSeAdcpM6MtvSyVyxaRRF7VNY=;
        b=VQzPEcqwMuA+CeKWUe9yDY8z4PFOaCvBrkDWl4AfhvHQbkcQ59EE2BrjS3Y95Kj0wx
         SIDZax4xCbgvv3Zw59QVsk6eTcWuckzQ5sKph4SxqZoGvonnwMt39a8yyqkG7tBk/nG/
         vRXKzpcYXVOVFVa3hlzNU4e66d+aNXX/vIgiRSF2lBdekNXrCN4g24xkM7YHRCZdNn14
         6Jan8FgyV1LVseUL4Gj8bbGSNq7bber+/RyYSQcT2WdqVhq/zxTJhuOmK290XqE3BeUd
         IJPgG3M/OhH8uc9J+46FesI87B5ojy73dsOZbCXOWYhMFrY+CY51INBl6wBoYIpDEgi4
         ktRQ==
X-Gm-Message-State: AOJu0YyLPY9Py3rplwqzxXiygZyb94JV81CFWtf5VVS/PRXBF2Dr61F+
        Inp3qeeBehjXt0J7E0N3zM13dS6IMKWFZVENDe8=
X-Google-Smtp-Source: AGHT+IEAHE7OJjtEAogCgEEZ9GRILiRF6QyLYVUjsRiDSNkN92dMVyczpBLHXe88+1cVDz+mrZiVedUNOXUj19XN6P0=
X-Received: by 2002:a05:6870:40c9:b0:1e9:8ab9:11ca with SMTP id
 l9-20020a05687040c900b001e98ab911camr2028604oal.3.1701878510776; Wed, 06 Dec
 2023 08:01:50 -0800 (PST)
MIME-Version: 1.0
References: <5737811.DvuYhMxLoT@kreacher> <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
In-Reply-To: <cf055d45-8970-4657-ab86-d28636645c81@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 17:01:37 +0100
Message-ID: <CAJZ5v0ic_=2wvge1T7YmGe5icR5dPxrvKy2N4gXP+KMievobmA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Send trip change notifications on all
 trip updates
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
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

Hi Daniel,

On Wed, Dec 6, 2023 at 3:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 05/12/2023 20:18, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The _store callbacks of the trip point temperature and hysteresis sysfs
> > attributes invoke thermal_notify_tz_trip_change() to send a notification
> > regarding the trip point change, but when trip points are updated by the
> > platform firmware, trip point change notifications are not sent.
> >
> > To make the behavior after a trip point change more consistent,
> > modify all of the 3 places where trip point temperature is updated
> > to use a new function called thermal_zone_set_trip_temp() for this
> > purpose and make that function call thermal_notify_tz_trip_change().
> >
> > Note that trip point hysteresis can only be updated via sysfs and
> > trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
> > so this code path need not be changed.
>
> Why the ACPI driver is not calling thermal_zone_device_update() after
> changing the trip point like the other drivers?

It calls that function, but because it may update multiple trips in
one go, it does that after all of the updates are done, via
acpi_thermal_check_fn().

> It would make sense to have the thermal framework to be notified about
> this change and check if there is a trip violation, no ?

It is notified as noted above, but not synchronously.
