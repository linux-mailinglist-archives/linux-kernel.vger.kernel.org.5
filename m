Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE47A06B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjINN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjINN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:59:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9461BE;
        Thu, 14 Sep 2023 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694699975; x=1726235975;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=M9/pjtPgrCPB3pKfZPcjSZj8sNqVAWupOs4Vq63aUF0=;
  b=dK3Ka0Bt8SpiQICGk+guBf++P+yNwT0g8WiZ1Qnn5KKj8XQvNzztz5xq
   lojyMZnGLPt8RRVcNb2weSdIkea6mQzMsEDSkZVd/boK9oCpfEcFF7Qy+
   BQ77PH/rnfNPZVGHTXqdp3dUGXM5zG60VHbZxHiuegd/BUBwhT0iq/yJU
   AqsmGqwXxlSj4e+wQNQLVIO6p8DH2XGKgfoTVamhICquJmnn5qZ1nkrbV
   EDS4qhhNv8G0MgbxQqZBCyQY+d6SGmm8LnZN0clAez5g/vo/bYa46Orbl
   3eLRYiaeBMIQJnXJ8o109fXZY0xX3nbaaGbq0aTHZRPyEjB3/pgW31Gh6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364002912"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364002912"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 06:43:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991391112"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="991391112"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 06:42:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
In-Reply-To: <20230913113801.1901152-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230913113801.1901152-1-arnd@kernel.org>
Date:   Thu, 14 Sep 2023 16:42:55 +0300
Message-ID: <874jjwx44g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This problem frequently comes up in randconfig testing, with
> drivers failing to link because of a dependency on an optional
> feature.
>
> The Kconfig language for this is very confusing, so try to
> document it in "Kconfig hints" section.

Thanks for doing this.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
> index 858ed5d80defe..89dea587a469a 100644
> --- a/Documentation/kbuild/kconfig-language.rst
> +++ b/Documentation/kbuild/kconfig-language.rst
> @@ -573,6 +573,32 @@ above, leading to:
>  	bool "Support for foo hardware"
>  	depends on ARCH_FOO_VENDOR || COMPILE_TEST
>  
> +Optional dependencies
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Some drivers are able to optionally use a feature from another module
> +or build cleanly with that module disabled, but cause a link failure
> +when trying to use that loadable module from a built-in driver.
> +
> +The most common way to express this optional dependency in Kconfig logic
> +uses the slighly counterintuitive
> +
> +  config FOO
> +	bool "Support for foo hardware"
> +	depends on BAR || !BAR

	depends on BAR || BAR=n

seems to be an alternative that's about as common:

$ git grep "depends on \([A-Z0-9_]\+\) || \!\1" | wc -l
109
$ git grep "depends on \([A-Z0-9_]\+\) || \1=n" | wc -l
107

Maybe worth mentioning both?


BR,
Jani.


> +
> +This means that there is either a dependency on BAR that disallows
> +the combination of FOO=y with BAR=m, or BAR is completely disabled.
> +For a more formalized approach if there are multiple drivers that have
> +the same dependency, a helper symbol can be used, like
> +
> +  config FOO
> +	bool "Support for foo hardware"
> +	depends on BAR_OPTIONAL
> +
> +  config BAR_OPTIONAL
> +	def_tristate BAR || !BAR
> +
>  Kconfig recursive dependency limitations
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
Jani Nikula, Intel
