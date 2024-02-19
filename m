Return-Path: <linux-kernel+bounces-71277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8785A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE821C21620
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978CE2D604;
	Mon, 19 Feb 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CF94/7WZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E72C1AE;
	Mon, 19 Feb 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344418; cv=none; b=YwYYNR4VZ/Fxh4IaR9NvKtpa3dSDQ5WZlODTuvpt0roSGBmUpd/UJGSAJiFqFhhE6vPWMpM2BhneHQidqLBFUX3TCpuwWWlwF3Z73rZqDHKbxt9eHTh4Ts8rxd8WtKReYj7lSa6vtlGeLg/c8puQgDNWqeOBvJ2oteRYj61K8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344418; c=relaxed/simple;
	bh=pDZK7NPfB1MTel/LL2NIFxKTCuRuSZodULRbT2pMx4E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kX7+HYgARSR+Fi6EciDdN+5/Y+9z7vMAanhxza+BrmycndiKKfC3kGKqXLsbiaq/1Y0UeZV/Fs08O8ecbBsAxssOVDweSGZskjCy0TJKot7KFi3CuIf1b9HmC2YLjH7ZwMjkZtivKD70ed96rYUrKT8emKMZJCIU2Tu7e5Cgwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CF94/7WZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344417; x=1739880417;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=pDZK7NPfB1MTel/LL2NIFxKTCuRuSZodULRbT2pMx4E=;
  b=CF94/7WZQ1adw61QsZdmsExf326Tfiv/8Ln41Wg4BpU23dmUN9orw24u
   cc5Gf/Ud6vAAsvP2Fpw8Pvy1+C0ssRIDeMqPVlI1F3ZK5FecpNYA3BkAJ
   KWuvTwLc7dIXSozbRE0H/XAaPUriKb8KM2d09G3blSVX5ZMMF1ilcwXAs
   wLdDAe78j/VRGEM6bmt8htko4sckGbrFw+hvD2qVdhu38BskKZDdQ7XV0
   i41kFp20Du73V6Q55onLRjKiBZVHx56XTgo5PWV+n2/b/BroeDI9z+nDB
   7/PsxKiJQ2sWFLDz7Z6TvJKsn5trDCTtyhATEqnTS6vId7Be4QYphUMdF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13127979"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13127979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4474117"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:06:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 jwoithe@just42.net, hdegoede@redhat.com, W_Armin@gmx.de, 
 Szilard Fabian <szfabian@bluemarch.art>
In-Reply-To: <20240215203012.228758-2-szfabian@bluemarch.art>
References: <20240129163502.161409-2-szfabian@bluemarch.art>
 <20240129175714.164326-2-szfabian@bluemarch.art>
 <20240207023031.56805-2-szfabian@bluemarch.art>
 <20240215203012.228758-2-szfabian@bluemarch.art>
Subject: Re: [PATCH v4] platform/x86/fujitsu-laptop: Add battery charge
 control support
Message-Id: <170834440647.4050.13047961348645894978.b4-ty@linux.intel.com>
Date: Mon, 19 Feb 2024 14:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 15 Feb 2024 20:31:43 +0000, Szilard Fabian wrote:

> This patch adds battery charge control support on Fujitsu notebooks
> via the S006 method of the FUJ02E3 ACPI device. With this method it's
> possible to set charge_control_end_threshold between 50 and 100%.
> 
> Tested on Lifebook E5411 and Lifebook U728. Sadly I can't test this
> patch on a dual battery one, but I didn't find any clue about
> independent battery charge control on dual battery Fujitsu notebooks
> either. And by that I mean checking the DSDT table of various Lifebook
> notebooks and reverse engineering FUJ02E3.dll.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/fujitsu-laptop: Add battery charge control support
      commit: 9b716ef48c90446b8d6d86726c6c3f0141e53091

--
 i.


