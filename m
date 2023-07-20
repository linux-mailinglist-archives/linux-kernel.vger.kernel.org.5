Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB275B6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGTS2z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjGTS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:28:53 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09C135;
        Thu, 20 Jul 2023 11:28:52 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-991f9148334so31401666b.1;
        Thu, 20 Jul 2023 11:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877730; x=1690482530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSLBVGx3HoP3RFoIMod2KbCcM9a83USRqNgkAkEojzk=;
        b=izNatHukOSk4Xo2qrDOE4Ysza0tF0iXH3qM1zhMLW04CliKcYhYGROQkJXecHlEHX6
         0MBg9Tn7lpFl+t/BVy1mrDCntNCgYnHxvPsOtYAmUhrp2c+nazE+5KWxbHbLnLhXwHoJ
         ULaDJVV0s4xW54PgWqPekUyB6pbZr4HcL+s4kcQkHumKI1m4WoAR9kT/3op6WruW7ArP
         StJoaHnM9qY7XOMyodmpaRZDWKhX95JlObvkKy3irsNwNDIgz/0iqxEZXNSWOLpt7z3T
         8Aw6H18BOzw63A+V3LS/zdawtTqOITixUrLUK+kVYtLM3KMup0vPN4/qa8wWLMcF0rZ5
         HmRA==
X-Gm-Message-State: ABy/qLaEDpp5AlZ7OV07AO02L8o0iCPASJ7cOF2HsYzlTDwKkhgdnRZY
        b/ixOhMLev/48RuhJsgA4K2T/TKi/Z5f0OAahzE=
X-Google-Smtp-Source: APBJJlH9YJSt+9fYYn1n9Ms3gvFEZcDvZeFJa5ynO6MdwniV+ivjxvg6c4PvBVf8LC1QgHsh2vmCdtN8dyhn1+dlb6c=
X-Received: by 2002:a17:906:5192:b0:994:1808:176b with SMTP id
 y18-20020a170906519200b009941808176bmr2803227ejk.6.1689877730287; Thu, 20 Jul
 2023 11:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230718101726.1864761-1-cristian.marussi@arm.com> <20230718132028.wtycky4amu35xxcy@bogus>
In-Reply-To: <20230718132028.wtycky4amu35xxcy@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 20:28:39 +0200
Message-ID: <CAJZ5v0hTBVVqv-vJrg6CUZLt-VXkmmHHctJ83tACnQ0zs-Lt4Q@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: arm_scmi: Remove recursion while parsing zones
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, "Rafael J . Wysocki" <rafael@kernel.org>
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

On Tue, Jul 18, 2023 at 3:20 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jul 18, 2023 at 11:17:26AM +0100, Cristian Marussi wrote:
> > Powercap zones can be defined as arranged in a hierarchy of trees and when
> > registering a zone with powercap_register_zone(), the kernel powercap
> > subsystem expects this to happen starting from the root zones down to the
> > leaves; on the other side, de-registration by powercap_deregister_zone()
> > must begin from the leaf zones.
> >
> > Available SCMI powercap zones are retrieved dynamically from the platform
> > at probe time and, while any defined hierarchy between the zones is
> > described properly in the zones descriptor, the platform returns the
> > availables zones with no particular well-defined order: as a consequence,
> > the trees possibly composing the hierarchy of zones have to be somehow
> > walked properly to register the retrieved zones from the root.
> >
> > Currently the ARM SCMI Powercap driver walks the zones using a recursive
> > algorithm; this approach, even though correct and tested can lead to kernel
> > stack overflow when processing a returned hierarchy of zones composed by
> > particularly high trees.
> >
> > Avoid possible kernel stack overflow by substituting the recursive approach
> > with an iterative one supported by a dynamically allocated stack-like data
> > structure.
> >
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Fixes: b55eef5226b7 ("powercap: arm_scmi: Add SCMI Powercap based driver")
>
> Makes sense,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 6.6 material, thanks!
