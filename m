Return-Path: <linux-kernel+bounces-81483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D50867682
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CF51F29F25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9E129A63;
	Mon, 26 Feb 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgEXo7Wd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408412881C;
	Mon, 26 Feb 2024 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954065; cv=none; b=hKgNwayugl3vNLKAAtoQdS5v24nfvX/0CV0EJ3QZHHB0Gc88NWehw+MdyP4z4S5GmGHbZYLWvB/JMp4dvcGC24tdSf/dakEouegW6DdRgf2ztqSaAsl9ZoSnqS9RDa/3Mn9rxR4k5BN8PiDbb8bKjJIOkq/h2vVHd/2wt7GQcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954065; c=relaxed/simple;
	bh=Ix55SDDxs43BwGtiKWK/8AwfY6ZDBx66aPuAUJxoKB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZHL2tOGev3CCSng7WG+SzmAT+uyiNH/BWNjjZK06K0tl9vE77n0Nn8VWEW/i49COoOMjkef5mY/77aaXOvu4bDUjc/Lmyddvd87XZ6BkOSOq7qCKnEaIbzqCdb0OVe46GXhq6eiGSEuHRkm3EmhOrsK7lc0dFbSpujCdNCHkYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgEXo7Wd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708954064; x=1740490064;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Ix55SDDxs43BwGtiKWK/8AwfY6ZDBx66aPuAUJxoKB8=;
  b=GgEXo7WdVidrHGjxU71MjA5U2CeZKW6HgQfULsFuRV4dszrrkjnm+4IW
   NdG65gRgXqfoMR3wSby7sDR27L/NIMTeNDQahK01EEKlCqHye8/NZ2WU3
   7xpsvBFK6H7c8EFdBYfbe/fJf6YmvYP3Kci/ct+vzffa6NTOdSQAmj/BV
   faGp2v20hFVIAPtfNZCBBnQZVTtZtnojMWRZJMlaCCn3CSzXFoWEUnWNH
   jP7ate59s5d5o2pH9nXBn5eg6GjfYxLC27hmDWNbwaXMT7RjIpQpKlbMQ
   0o2WdSER4W1QZr5LSiH+AX2Vh+FB7p6vn8Ag8G7w2uQgncFoicxas6CPs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14652571"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14652571"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6702834"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 05:27:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Philipp Jungkamp <p.jungkamp@gmx.net>, Gergo Koteles <soyer@irl.hu>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org
In-Reply-To: <cover.1708399689.git.soyer@irl.hu>
References: <cover.1708399689.git.soyer@irl.hu>
Subject: Re: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
Message-Id: <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com>
Date: Mon, 26 Feb 2024 15:27:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 20 Feb 2024 04:39:34 +0100, Gergo Koteles wrote:

> This patch series adds a new KEY_FN_R input event code and map the
> Fn + R key to it in the ideapad-laptop driver.
> 
> It affects two WMI keycodes and I couldn't try the 0x0a, but I couldn't
> find any indication that the refresh rate toggle should not be Fn + R.
> 
> Regards,
> Gergo
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] Input: allocate keycode for Fn + R
      commit: 4e45fa464aeef4e803412b5dcce73aad48c94b0e
[2/2] platform/x86: ideapad-laptop: map Fn + R key to KEY_FN_R
      commit: cd4525993e49f1449e9380bd28fa1179b05c911d

--
 i.


