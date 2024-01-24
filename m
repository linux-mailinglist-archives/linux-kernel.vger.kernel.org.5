Return-Path: <linux-kernel+bounces-37213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B183ACA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD1A29E2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412CF1E49D;
	Wed, 24 Jan 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cil6swvt"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46057C088;
	Wed, 24 Jan 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108389; cv=none; b=Zl9+fIb4elOuAYJ8NigjYJNj+EAn1iaf6OnDkx+43n+muajD+dQtxvtGq/0cX1tlAu+S/yrN/CsNkhRJrlnccTOye7M6cMdYf3hgTVjrsJevQXZ/ObZ0jyRdYH6tPpWtuVSp7B2ygynmwZy8xJzNMt3A6caUmMBqeHlVa+GS6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108389; c=relaxed/simple;
	bh=RzDbhYSEcmLvl0Tieidy5sjp9uAbbBuDzPRK5lNr8Tk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gPLWkjiuT279M3Etqdd1mpr8Dyln82k5HGxFDFcgFq9OOVG3r4zJtDlAdQOBNFF7TnCEpDf0I12CgAePzjTXZyP68/PMXq4rwWUCttMY6+5qeHApSW4jj3A1P3I4n7SkVMe1HJHoma/9guuSs4ZPgu+xuO2VamUslfEjtZ+uLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cil6swvt; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706108386; x=1737644386;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RzDbhYSEcmLvl0Tieidy5sjp9uAbbBuDzPRK5lNr8Tk=;
  b=Cil6swvtNfZ92Cyy1GGmLzszogBQnu1QF5g+xBVoZ+t6GfUXP/FrFt6/
   vNdiqyE3EnEd2uZShAz2Qg8nZXvbmhe6tv1wWwAM9KBcVQ1N4EBibHKmx
   c8LmWpWMay06ynyunvaib7uTPldTVNxGfNbJjDr4JvvdrBVQjSqB3lJOu
   7RpbYvg12YOsjPJX5NgGzSiU9tDoUd9skZD6TLcOf3IRFlidpxDjBOSfp
   OqUwLOL3vzEiCYjZtXw3860DbJydtEGXQa+JRZS0GeOS1HWoXqrxSsW0L
   bqTh8tOMvNwQjnfHjvJxooQMwDsEEv3uAIoHshTuT/9zKct1eDz8EQUoe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405616927"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405616927"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1932880"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:59:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Jan 2024 16:59:36 +0200 (EET)
To: Frank Li <Frank.Li@nxp.com>
cc: alexandre.belloni@bootlin.com, conor.culhane@silvaco.com, 
    devicetree@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, imx@lists.linux.dev, 
    Jiri Slaby <jirislaby@kernel.org>, joe@perches.com, 
    krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org, 
    linux-i3c@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, miquel.raynal@bootlin.com, 
    robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 4/8] i3c: svc: Add svc-i3c-main.c and svc-i3c.h
In-Reply-To: <20240123231043.3891847-5-Frank.Li@nxp.com>
Message-ID: <bb434214-0607-4054-dd04-a870db9e7f5d@linux.intel.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com> <20240123231043.3891847-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jan 2024, Frank Li wrote:

> SVC i3c is a dual role controller. Move probe() into svc-i3c-main.c. This
> prepares to support target probe depending on dts "mode" settings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master/Makefile         |  3 +-
>  drivers/i3c/master/svc-i3c-main.c   | 52 +++++++++++++++++++++++++++++
>  drivers/i3c/master/svc-i3c-master.c | 34 ++++---------------
>  drivers/i3c/master/svc-i3c.h        | 11 ++++++
>  4 files changed, 71 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/i3c/master/svc-i3c-main.c
>  create mode 100644 drivers/i3c/master/svc-i3c.h
> 
> diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
> index 3e97960160bc8..484cb81f45821 100644
> --- a/drivers/i3c/master/Makefile
> +++ b/drivers/i3c/master/Makefile
> @@ -2,5 +2,6 @@
>  obj-$(CONFIG_CDNS_I3C_MASTER)		+= i3c-master-cdns.o
>  obj-$(CONFIG_DW_I3C_MASTER)		+= dw-i3c-master.o
>  obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
> -obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c-master.o
> +svc-i3c-objs				+= svc-i3c-main.o svc-i3c-master.o
> +obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c.o
>  obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci/
> diff --git a/drivers/i3c/master/svc-i3c-main.c b/drivers/i3c/master/svc-i3c-main.c
> new file mode 100644
> index 0000000000000..053b2bd9d8317
> --- /dev/null
> +++ b/drivers/i3c/master/svc-i3c-main.c

..

> +module_platform_driver(svc_i3c_master);
> \ No newline at end of file

> diff --git a/drivers/i3c/master/svc-i3c.h b/drivers/i3c/master/svc-i3c.h
> new file mode 100644
> index 0000000000000..0bd1f0112a071
> --- /dev/null
> +++ b/drivers/i3c/master/svc-i3c.h

..

> +#endif
> \ No newline at end of file

Add the trailing newline characters.


-- 
 i.


