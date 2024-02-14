Return-Path: <linux-kernel+bounces-65401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D50854C67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD1B24FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3E5C5F4;
	Wed, 14 Feb 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBfHTqq2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898754729;
	Wed, 14 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923841; cv=none; b=QnXBOI4OkgODPrMBkznMXi1fKFe7g7n4DYbb16CJ91GnD4vyQNFwHRJN8D2B7nd8suaKtSIQWfJ333G36U1EYbIrhcHkn0M4m8Q3ShkDUC1cNGF4SLSPw0NIIM/mj8ZcRCeM54h1a6T65XZaaSLwceDho3+3doOAOfKj0obs77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923841; c=relaxed/simple;
	bh=ACTxwyP+4YUfgXsf/6lQTT/mpr2H2M+XUhOo0wFm+nM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NLL9YWyxe6QTDqQNexLUlHiwNekEBrty9Hg6Av/03l5xdcqHGpJ3CnkH83wg3EHXYVDDGvS2WFfXEssXHnH+M378bHT23uxqWhbozxqcgyZSlhORkFHTB22SCakmHFAx4UOLQe5vGW6l3k+zFCqjIMCSXDj2UCFYkxsY6B1e83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBfHTqq2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707923840; x=1739459840;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ACTxwyP+4YUfgXsf/6lQTT/mpr2H2M+XUhOo0wFm+nM=;
  b=fBfHTqq2e4SIm/gqJ/d8zjA9zzzYp55DZae8Qk+RPtvcUwAlrmgg/crL
   SBwqH06U/9IyXGodapbBDVWK1BuBIrtUa+WkSnLsrrqJ8gFsIbsYlyLIA
   9W/gt6czi4t/dn1SyU2XBOuOzQ8naLmGmHnH8nTlY4Q6aQHQ7KDWC/JC2
   qPdF+j51yI3BUJ4zUbDbqY9za+GFY5ugRfP8oN0xmE9+KPJ+OobC4gxU5
   jXq6p9od7NyQPzIqSM5Uh0grBlmEuqVeAy+YScCpi+cqJGVrapsy/9Db7
   8jch6xufS1SJfGq7LTIudHL0GRgA8LQtHoqs50lcO8Ry/oX0JdWIkrXYY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2116100"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2116100"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3374125"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.229])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 07:17:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 14 Feb 2024 17:16:16 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/1] tty: Don't include tty_buffer.h tty.h
In-Reply-To: <20240214145439.62624-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <33f66aa5-1577-44cb-dfa6-958a18c19cf6@linux.intel.com>
References: <20240214145439.62624-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1708694187-1707923818=:7959"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1708694187-1707923818=:7959
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 Feb 2024, Ilpo J=C3=A4rvinen wrote:

Gah, I seem to have botched the shortlog while I killed linux/ prefixes=20
from it. I'll send an update tomorrow.

--=20
 i.

> There's no need to include linux/tty_buffer.h in linux/tty.h.
> Move the include into tty_buffer.c that is actually using it.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/tty_buffer.c | 1 +
>  include/linux/tty.h      | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index f8883afbeeba..79f0ff94ce00 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -7,6 +7,7 @@
>  #include <linux/errno.h>
>  #include <linux/minmax.h>
>  #include <linux/tty.h>
> +#include <linux/tty_buffer.h>
>  #include <linux/tty_driver.h>
>  #include <linux/tty_flip.h>
>  #include <linux/timer.h>
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 8c76fd97d4ad..2b2e6f0a54d6 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -6,7 +6,6 @@
>  #include <linux/major.h>
>  #include <linux/termios.h>
>  #include <linux/workqueue.h>
> -#include <linux/tty_buffer.h>
>  #include <linux/tty_driver.h>
>  #include <linux/tty_ldisc.h>
>  #include <linux/tty_port.h>
>=20

--8323328-1708694187-1707923818=:7959--

