Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C17FDE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjK2ROf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 12:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2ROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:14:33 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D573B2;
        Wed, 29 Nov 2023 09:14:40 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b85d97a529so940777b6e.0;
        Wed, 29 Nov 2023 09:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278079; x=1701882879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BTxP1AwTzLXl5jDe0Z7kCtR7I/vrVTah70CPbLH4S0=;
        b=FAfXAdaC80+Q/W/LPYt8abxZi3DZ7wHCIrgb8ekJsIyBipBlFS+0F94bWGg2zEmybm
         LVUGyKJ/B6XfYL+2ZIvrinnaEHM2ivItn2bYGt179Yhu+Obg0myMlz1WzabNYERqKuqo
         xpR9aLdsjpOdNlrXOUDb9K8RauNFJttlDHGA22bGhaNetglJKMlxU0EuKFBW1aYGe7QG
         6hQ+B5e1aCx1YtriwbdKFztdKSdFin5YiZPX3a9SJQp7ACSwPOHmFlaxp1dHmPIUEmnw
         BD847Ozc3VMJnCftz15K6sc6wazscd4mSyi1FsEVv4u0XesEulYkjX8dhaV05iJP8FwG
         xVhQ==
X-Gm-Message-State: AOJu0YxKumvjeaZL/H3TEY3s+ghfB47PAkrtqpw0O6opCs9dPELVBylz
        5mKbrJTyHI1WNgPMF4UnVLNYWNFvKoApdHZxUwum78e1
X-Google-Smtp-Source: AGHT+IG152vCdgIxEMGykqygUQVsz6Hdg5TzKW/KF5ZSpdliYWHwOwYY75niGuSgTIWLtW7dp2Z3NQpnzZuITgaJjIw=
X-Received: by 2002:a05:6808:d1:b0:3ae:5e6a:5693 with SMTP id
 t17-20020a05680800d100b003ae5e6a5693mr19467747oic.0.1701278079477; Wed, 29
 Nov 2023 09:14:39 -0800 (PST)
MIME-Version: 1.0
References: <12350772.O9o76ZdvQC@kreacher> <4869676.GXAFRqVoOG@kreacher> <ce9297d4-db9f-44c7-a590-2b9d4600be42@linaro.org>
In-Reply-To: <ce9297d4-db9f-44c7-a590-2b9d4600be42@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 18:14:28 +0100
Message-ID: <CAJZ5v0j34VB6mkKjscU0BpQ8wvgeutr_2U50OznsmxSdTVySDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
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

Hi Daniel,

On Wed, Nov 29, 2023 at 5:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 29/11/2023 14:38, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quite a bit
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above functions to address the above.
>
> Please hold on before merging this change. I've some comment about it
> but I have to double check a couple of things before

That's fine, but why don't you make the comment before the double checks?
