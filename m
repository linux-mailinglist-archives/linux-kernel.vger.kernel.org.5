Return-Path: <linux-kernel+bounces-103203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93987BC52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC716B225B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F46F06C;
	Thu, 14 Mar 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CV1EkFKI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272C60ED0;
	Thu, 14 Mar 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417351; cv=none; b=BFKkf/I+7oWPlx6acmXUt8okdGrqvngOSuznwRCzLZSS9qqcitug0IYZ7TNMppgA5MSWlXwI7dcIwLrFiKRjOjd9noeBfs9OtTRdeFs5UkcNPkjVMjlpaOI9Q8u++l2uU0hdkM3N9X+h7f2/1IIBDSw4iy673Bsy+p6N2xTpzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417351; c=relaxed/simple;
	bh=oDf0a0JXbai2/BaU9j5kpEvaONUbaKix1QFd5DKkUMs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qTmToyf0LekAq4tFr4hrB8E5hG4/6R3P+l6GPgx3k7+S+TbT8cn+t42lY5F/pJbW4ASsGlqEXyWWok0e6cNA+sw6WPDXJCX3plbb2aisE5q1IHXwdW18+vxJ7SU34JVmmPhwSviQYuAAAHQo+D/pGCH3jHDBTJKph7PhPEL4MBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV1EkFKI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710417350; x=1741953350;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=oDf0a0JXbai2/BaU9j5kpEvaONUbaKix1QFd5DKkUMs=;
  b=CV1EkFKIDEOqzrxFaZPeg5R275Z42caixOyKAgRlQNejsP66qe8hdh5i
   pZ0z8/ew6cA0aktl3rtny7vZ8bZE1Arzuem1qkroy7TDT74HvQC/Juz4b
   vNRBaJ4P9oOA3rifbR7FbxmRqQYRmD6TQFac97MfcJz3cf+G3j2Btx6qJ
   yIUfaWpmu5d/90bUlX9XL/sICJNtT+vXzOfesfrylp05HuNdn2Fk7S1tW
   RIUJw6OPuvC6TVPd49vrpeQYn70bife5mXSOHIECzyWT2oWdqLpNyub3L
   I1IO8AJlAip2AtKuWS39JaoJKHgiUUQq0DS+ffbDh7hjQwjWXficr8fqX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16681102"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="16681102"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="17002742"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.8])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:55:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 14 Mar 2024 13:55:39 +0200 (EET)
To: Ai Chao <aichao@kylinos.cn>
cc: Hans de Goede <hdegoede@redhat.com>, u.kleine-koenig@pengutronix.de, 
    mario.limonciello@amd.com, jes965@nyu.edu, alexbelm48@gmail.com, 
    onenowy@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] platform/x86: hp-wmi: use sysfs_emit() instead of
 sprintf()
In-Reply-To: <20240314063703.315841-1-aichao@kylinos.cn>
Message-ID: <ae3ade7d-ca88-e2a5-aba5-9574e16e59c0@linux.intel.com>
References: <20240314063703.315841-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1489743920-1710417238=:1017"
Content-ID: <54061eef-325c-57e0-9635-5d60be3f0669@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1489743920-1710417238=:1017
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e59bddc6-0a36-8616-72b7-3fb4b7f7870b@linux.intel.com>

On Thu, 14 Mar 2024, Ai Chao wrote:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
>=20
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---

Thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1489743920-1710417238=:1017--

