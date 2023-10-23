Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8077D3F76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjJWSqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:46:08 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A78B7;
        Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b4bdb89177so91704b6e.1;
        Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086766; x=1698691566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7qmlsW1aphbWWQFznUoBodF+sYdz65fd6/X5tOb8Ns=;
        b=sK1Y0CIT8/r57x4Q7FkVESE7hdL2NTnL3oWy0oGLQhJqeaSZ+t63Ox7J+9lhs5h0bm
         jx+TV29c04t1BM9JwhEL4E+zTaKz3454bVs+iKxjOs0e76H4H3lblgNd9rxtF7eEWs0w
         NfQWooreBH+KoDHTs/ExV0jWTQ2arNKBW2wC1V0VPicZvnB8Is2RmtfQkoxJGOdYd+iu
         /xkyf0Bh8+d8E2MVDzb5cUBEqGp+uMIYAFOhqzc3OmaSHyvDe6rK3jJYz1XaG9Oj4KZe
         MH3NR3pCN0EJm6TVtTmMv0qq0WLybCxcUb4I6qbXzqWAQvchxb46CYAsFsv5+p2U4WAV
         sIcw==
X-Gm-Message-State: AOJu0YwZdrpZ5n0U24sCUdStSskedU9GU1Ic8+NmyVswAW5LYX6CgZVG
        wY9V23j5mybPHiRxl1hrVAxGv0bb+NEjCto5dOY=
X-Google-Smtp-Source: AGHT+IGS15eSBmMGDbQ6578FNooPNXOmZfULT4eWtObUSpW1lpWIoWGk2LshlD7fu9oFRekvnZM9rUH0iB4abMPca9g=
X-Received: by 2002:a4a:e7d1:0:b0:583:ec88:e0 with SMTP id y17-20020a4ae7d1000000b00583ec8800e0mr10035549oov.0.1698086766162;
 Mon, 23 Oct 2023 11:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231023053530.5525-1-raag.jadav@intel.com> <20231023053530.5525-3-raag.jadav@intel.com>
 <ZTZacR86hSmV04M9@smile.fi.intel.com> <ZTaGaDweYpBlxBez@black.fi.intel.com>
In-Reply-To: <ZTaGaDweYpBlxBez@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Oct 2023 20:45:55 +0200
Message-ID: <CAJZ5v0g1nTXRD9D5KxQ2DoSRkaavLGjXVAOWbe3wfDLeoTtV8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] pinctrl: intel: use acpi_dev_uid_match() for
 matching _UID
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 4:43 PM Raag Jadav <raag.jadav@intel.com> wrote:
>
> On Mon, Oct 23, 2023 at 02:35:13PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> > > Convert manual _UID references to use the standard ACPI helper.
> >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > It has a hidden logic that is not aligned with acpi_dev_hid_uid_match().
> > Or revert to your v1 I assume.
>
> I don't see how this has to be aligned with acpi_dev_hid_uid_match() or
> if acpi_dev_hid_uid_match() implementation concerns this specific change,
> since that's not what we intend to do here.
>
> Also, I think acpi_dev_uid_match() implementation in v2 is actually more
> aligned with the previous logic that we're replacing here, since it gives
> us a guaranteed match result as originally intended with strcmp in this
> case. And the "hidden logic" in v1 implementation (match with @uid2 == NULL)
> is what ends up breaking it in my opinion.
>
> Regardless, for any version (v1 or v2) the usage still remains the same
> in this case.

Right, so it is a bit unclear what all of the fuss is about.

> > As I asked you, please drop this one.
>
> But okay, as you wish :(
>
> Rafael, should I send a v3 with dropped tags?

No need to resend in general, I can drop tags from the patches just fine.

For this one, though, I'd like to get a maintainer's ACK, so it may be
necessary to resend it without the tag.
