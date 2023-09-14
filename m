Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B47A09E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbjINP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjINP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:56:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CB1BDD;
        Thu, 14 Sep 2023 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694707012; x=1726243012;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sjnm9j0exQ8kWr8SJac5qRGJ+LAGIH1ZXOdQmtHpGXE=;
  b=SiHmhm6foJEnFyG/rGFMMcAXA7ho6GK/GFPu+blg0EXP6KkTYVSZggLp
   fa9psn67MexnLZ1kDmLVcGLiZ23/DF4m9T3hRlrQrj6dNLV4KNBaCGDL8
   8Gim7MgQOQxXXeKWUKS1ZzHY1/mzIDeHBNtAraP5HhGz4B4Bzl2Xxo1B2
   Gy5O/6Ee3wOgLWMV96Fa010ZHD4PU+n/8A99O0fFHGSo7wMLVwoYYztIa
   weqNQhdVFTESMjK9bmavk/bw0FmVDEK8RgoUHlLd6gMqZ7K90rBaKGh/r
   LJVcSdSYMUCMdlSbmHq40ZB0LqXZdwJV+2KPEFIVqdhDvKtFBn28ENox7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378913726"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="378913726"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075437508"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="1075437508"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:56:45 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
In-Reply-To: <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
Date:   Thu, 14 Sep 2023 18:56:42 +0300
Message-ID: <87v8ccvjd1.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023, "Arnd Bergmann" <arnd@arndb.de> wrote:
> On Thu, Sep 14, 2023, at 15:42, Jani Nikula wrote:
>> On Wed, 13 Sep 2023, Arnd Bergmann <arnd@kernel.org> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>  
>>> +Optional dependencies
>>> +~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +Some drivers are able to optionally use a feature from another module
>>> +or build cleanly with that module disabled, but cause a link failure
>>> +when trying to use that loadable module from a built-in driver.
>>> +
>>> +The most common way to express this optional dependency in Kconfig logic
>>> +uses the slighly counterintuitive
>>> +
>>> +  config FOO
>>> +	bool "Support for foo hardware"
>>> +	depends on BAR || !BAR
>>
>> 	depends on BAR || BAR=n
>>
>> seems to be an alternative that's about as common:
>>
>> $ git grep "depends on \([A-Z0-9_]\+\) || \!\1" | wc -l
>> 109
>> $ git grep "depends on \([A-Z0-9_]\+\) || \1=n" | wc -l
>> 107
>>
>> Maybe worth mentioning both?
>
> I fear that would add more confusion than it avoids:
> "!BAR" is actually different from "BAR=n", but

*head explodes*

> "BAR || !BAR" is the same as "BAR || BAR=n" here, and
> trying to explain this in the documentation would either
> make it incorrect or unhelpfully complicated.

Fair enough.


BR,
Jani.


-- 
Jani Nikula, Intel
