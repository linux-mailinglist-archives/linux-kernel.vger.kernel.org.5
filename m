Return-Path: <linux-kernel+bounces-44287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764B841FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE501F2B23F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1B60861;
	Tue, 30 Jan 2024 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TG8PSorp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B0560DC0;
	Tue, 30 Jan 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607828; cv=none; b=pzaIe7yMyEDcyAcPUKNhmMOfsznh90lL4l489HmJQ51HrRdaLxohAzhgV8iPf5yGhyjqAT8sR6xb2cmLESwWqDCV19IwmzXlXwhVBqTCnZst/EvnU/IdMkDkC7ZMf0jcjVQpNgE6TtggcTGrxZgpYnj/7LfXNUEPn2OTy1pIwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607828; c=relaxed/simple;
	bh=o5dpfM83ZQetXPFoQaiUi8sNPsZ0JGG1M8+mmBuXIgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktfancoDvxiXejitZnz0EasmP8ZHt3f+MrcBNqJCWQqphT11tzeL4Zg2aMA7QW/3MBOTBfYTBsv78vkZbrgh0xs8Snecao729Ks2LhuxbD8NPYRhhPgGYE/mA7ND6NYSB8PRqPFQTRcj63bVd+y7MG1rTxf80QzxWB1RjN1bE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TG8PSorp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706607826; x=1738143826;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o5dpfM83ZQetXPFoQaiUi8sNPsZ0JGG1M8+mmBuXIgA=;
  b=TG8PSorpIph8XL/MIe3SmnIZI/OWQe66mgnfYwLrxNpdqDbECLFmibzH
   z3UKY6dnLgiinXliUZCC/LG812zqVI3cKMkxSyVA/6zk11t5FbFiYT+pt
   p+QQobqj1bPhmrGQVp5+iRVicWkY78CvAnrmyvRpLFo/5qedyVldYIYa+
   0YVIDDBa5OLtkQ2QwiTpZ/M9lULJdgTDAUVrEf2lalsysyjZw3vYNRDrR
   SP4YwgQwSlWqTnlpyh/hZ7G9mK1Jsoy7xa745TKHGqihSPgofp46Y2YTF
   jD1ri6ULuT2vmPI4mKekudCg2Qoyi0bK0P7f+hBJiP3IMgM+v0NAn9H9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9864943"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9864943"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3682192"
Received: from dcarleto-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.176])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:43:42 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Breno Leitao <leitao@debian.org>, corbet@lwn.net, kuba@kernel.org, David
 S. Miller <davem@davemloft.net>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
In-Reply-To: <20231121114831.3033560-1-leitao@debian.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231121114831.3033560-1-leitao@debian.org>
Date: Tue, 30 Jan 2024 11:43:39 +0200
Message-ID: <874jevjgvo.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.

First of all, my boilerplate complaint: All extra processing for Sphinx
should really be done using Sphinx extensions instead of adding Makefile
hacks. I don't think it's sustainable to keep adding this stuff. We
chose Sphinx because it is extensible, and to avoid the Rube Goldberg
machine that the previous documentation build system was.

At the very least I would've expected to see Jon's ack on changes like
this.

The specific problem with this patch, now merged as commit f061c9f7d058
("Documentation: Document each netlink family"), is that it explicitly
writes intermediate files in the $(srctree). Even for O= builds. That's
one of the pitfalls of hacking it in Makefiles.

See below.

> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs input file and generate the correspondent RST file.
>
> Create a new Documentation/networking/netlink_spec index page, and
> reference each Netlink RST file that was processed above in this main
> index.rst file.
>
> In case of any exception during the parsing, dump the error and skip
> the file.
>
> Do not regenerate the RST files if the input files (YAML) were not
> changed in-between invocations.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

[snip]

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2f35793acd2a..5c156fbb6cdf 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -97,7 +97,21 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
>  	fi
>  
> -htmldocs:
> +YNL_INDEX:=$(srctree)/Documentation/networking/netlink_spec/index.rst
> +YNL_RST_DIR:=$(srctree)/Documentation/networking/netlink_spec
> +YNL_YAML_DIR:=$(srctree)/Documentation/netlink/specs
> +YNL_TOOL:=$(srctree)/tools/net/ynl/ynl-gen-rst.py
> +
> +YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
> +YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
> +
> +$(YNL_INDEX): $(YNL_RST_FILES)
> +	@$(YNL_TOOL) -o $@ -x
> +
> +$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
> +	@$(YNL_TOOL) -i $< -o $@
> +

Right here.

> +htmldocs: $(YNL_INDEX)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 683eb42309cc..cb435c141794 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -55,6 +55,7 @@ Contents:
>     filter
>     generic-hdlc
>     generic_netlink
> +   netlink_spec/index
>     gen_stats
>     gtp
>     ila
> diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
> new file mode 100644
> index 000000000000..30d85567b592
> --- /dev/null
> +++ b/Documentation/networking/netlink_spec/.gitignore
> @@ -0,0 +1 @@
> +*.rst

And then goes on to git ignore the mess it made.


BR,
Jani.


-- 
Jani Nikula, Intel

