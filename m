Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA857A1793
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjIOHfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjIOHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:35:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05323A1;
        Fri, 15 Sep 2023 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694763315; x=1726299315;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=qHIrlzrycle/SJ7JMaIX9e41cVUBla4ANbL4ssaQyrs=;
  b=WTEITUCC17gD2q5M4bdv6PHJur+JlCjRHf/nv6wiv6X4F0pmrV03yzlh
   J60n4EhNz5Dc8Nwpatv2/AkOk1ZcsZi0Hb3d8oVrcldXKQ8qeeJsbNGiU
   dC5TH6kMhIPpItmYjCOEGo61jhis2MZpYPC8QwxxMsq1vhF3uimUL/GGf
   VxbIy8YQG16yTNCDfku6Hb/9GXlMXsrAeP/8E0U57Y7mmVPPG3+NNk4UJ
   Mu9vqVqHZdjiGgvr4Kyakjq/qM4BrwPru5xlPJU1C0a0EOXHlnwKts6Ly
   hE0e7kmVPPnrp2oTvEbxs0lLwQthwNvjODHDQ+A0w6QJyY0ExIGm3AWfc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465550485"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="465550485"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 00:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888139889"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="888139889"
Received: from azafrani-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.177])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 00:33:43 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
In-Reply-To: <763b1599-06b7-490e-9cbf-eb07f1deedb3@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
 <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
 <763b1599-06b7-490e-9cbf-eb07f1deedb3@app.fastmail.com>
Date:   Fri, 15 Sep 2023 10:34:12 +0300
Message-ID: <87sf7fvqiz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Thu, Sep 14, 2023, at 19:23, Masahiro Yamada wrote:
>> On Thu, Sep 14, 2023 at 11:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>> On Thu, Sep 14, 2023, at 15:42, Jani Nikula wrote:
>>
>> It is unclear why WIREGUARD must be entirely disabled
>> just because of the optional feature being modular.
>
> I don't think anyone is asking for that, and the current
> "depends on IPV6 || !IPV6" seems fine here, and is consistent
> with dozens of other symbols.
>
>> My preference is to use IS_REACHABLE(CONFIG_IPV6)
>> instead of IS_ENABLED(CONFIG_IPV6)
>> under drivers/net/wireguard, then
>> get rid of "depends on IPV6 || !IPV6)
>
> My feeling is that this would be significantly worse from a
> usability point of view even if it made it a little easier
> for maintainers:
>
> When a user selects both IPV6 and WIREGUARD, they expect
> to be able to use them together, and a normal user setting
> WIREGUARD=3Dy would have a hard time figuring out why that
> leads it becoming IPv4-only.

I think IS_REACHABLE() is in most cases just plain wrong, and should
only be used as the last resort.

I think the kconfig should express what the dependencies are, and you
should get kconfig or build errors if you get it wrong, and not paper
over them with IS_REACHABLE().

Configuring the kernel is hard enough, and IS_REACHABLE() silences the
issues with no messages to the user at any point. If the user gets it
wrong, it just doesn't work like they expect, they have no clues why,
and they have to peruse the kernel source to figure it out. (Or, more
likely, file a bug and waste the kernel developer/maintainer time to get
the configuration right.)

IS_REACHABLE() considered harmful.


BR,
Jani.


>
>> If you want to make it clearer on the Kconfig level,
>> perhaps the following is also possible.
>>
>>
>> config WIREGUARD
>>        tristate "WireGuard"
>>
>> config WIREGUARD_IPV6
>>        def_bool y
>>        depends on WIREGUARD
>>        depends on IPV6 >=3D WIREGUARD
>>
>> config IPV6
>>        tristate "IPV6"
>
> That has the same downside, with the added problem
> of also confusing kernel developers with the '>=3D'
> Kconfig syntax, which IMHO makes no sense unless one
> knows way too much about Kconfig internals.
>
>       Arnd

--=20
Jani Nikula, Intel
