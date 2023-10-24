Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF17D5AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbjJXSwM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJXSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:52:10 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063BA6;
        Tue, 24 Oct 2023 11:52:08 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ea1742c1a5so1380458fac.0;
        Tue, 24 Oct 2023 11:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173528; x=1698778328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b47eW1W1ZA3iY9fGQWptMYQkO14e99bJy5u+/oy5i2Y=;
        b=aZEwBny9h18y3Sexpm1gP6WTOHnyV+grEkCz6WuZVsCCwZ2JVuDM/GR3oH2n2MVgMD
         LMBQCQfVWdV92nSSvAl2DZXuMIyxyToOV8EuiEVpohVVvZZQs0wIDl6ntkLK/jEWlva3
         6IaMeyzOO0loI1COrMmRKa6SzTehfiZeOoRb9o6Blu6BNbO8iPIjX1rX81lZ2h/R6yQK
         /YtksuEUYxoJM3KCIaW9z55oPKD1O5F1Hy8XmzvOgSxXYD/hBxQjZLeZiUqdr5cRlDV6
         sBWjeBgQgbHpak/qLLWZ+7+6fbhI+pbyo9zyEbPFDDSXtrif6mpxwrR9gEt0qt4GYXSt
         iVVA==
X-Gm-Message-State: AOJu0Yw04wr7yV0HId29biuCd9JJWS9GVl7/RWdLVvMRccapd6clWVIQ
        gL4fvXGmmZnXr4XK5ctYVGhDuJt0pUTfNjcawZg=
X-Google-Smtp-Source: AGHT+IGEyL46Vaabh0PQgToQaEorF+rTwJ2e/VuAsoUSTFafddKjwzGKWYy/ed+ekhC8GDeNVIsCZEpkTFfXDb/+gKo=
X-Received: by 2002:a05:6870:9a98:b0:1e9:9e04:1d24 with SMTP id
 hp24-20020a0568709a9800b001e99e041d24mr16645138oab.5.1698173528060; Tue, 24
 Oct 2023 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230712223448.145079-1-jeshuas@nvidia.com> <ZTfhpRRA4bga0qSI@agluck-desk3>
In-Reply-To: <ZTfhpRRA4bga0qSI@agluck-desk3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 20:51:57 +0200
Message-ID: <CAJZ5v0j2mbKOqDaL_31fL9ftTZRhUiURx3nubLmLUo3-R_w3gw@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
To:     Tony Luck <tony.luck@intel.com>, Jeshua Smith <jeshuas@nvidia.com>
Cc:     keescook@chromium.org, gpiccoli@igalia.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 5:27 PM Tony Luck <tony.luck@intel.com> wrote:
>
> On Wed, Jul 12, 2023 at 10:34:48PM +0000, Jeshua Smith wrote:
> > Slow devices such as flash may not meet the default 1ms timeout value,
> > so use the ERST max execution time value that they provide as the
> > timeout if it is larger.
> >
> > Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
>
> > +/* ERST Exec max timings */
> > +#define ERST_EXEC_TIMING_MAX_MASK      0xFFFFFFFF00000000
> > +#define ERST_EXEC_TIMING_MAX_SHIFT     32
>
> I've recently become a fan of <linux/bitfield.h> I think this would
> be easier on the eyes as:
>
> #define ERST_EXEC_TIMING_MAX    GENMASK_ULL(63, 32)
>
> > +static inline u64 erst_get_timeout(void)
> > +{
> > +     u64 timeout = FIRMWARE_TIMEOUT;
> > +
> > +     if (erst_erange.attr & ERST_RANGE_SLOW) {
> > +             timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
> > +                     ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
>
> then this becomes:
>
>                 timeout = FIELD_GET(ERST_EXEC_TIMING_MAX, erst_erange.timings) *
>                           NSEC_PER_MSEC;
>
> > +             if (timeout < FIRMWARE_TIMEOUT)
> > +                     timeout = FIRMWARE_TIMEOUT;
>
> But that's just a matter of style.  Otherwise the patch looks fine.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.7 material, thanks!
