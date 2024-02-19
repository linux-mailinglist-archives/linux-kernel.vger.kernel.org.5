Return-Path: <linux-kernel+bounces-71278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046285A2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040CF1F228A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967732D05A;
	Mon, 19 Feb 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9ZoDp/k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3312D05C;
	Mon, 19 Feb 2024 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344431; cv=none; b=P6+O9XbbzEC3Ifx2DCtuaO3pPYrSEKq4Rd97pi6g8RsspGH6IKnIe5/opqu0AfPMCUwv246FBH12WJ9jIJLiBhVCk4RqpWzwiCmnP2bXcg4zQZyDHFxOXraee6d4nzSv3cUKF6X76aSnJrVe4scI75/WDLWLH7zjLK2QL9JhbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344431; c=relaxed/simple;
	bh=KnF0phDN3/5uXsJqv2PiwDoKfpY1Mw293W4t6oICmxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TRZKLkWE5mjLbgt5HyAzf+fhqwKjjDv5cfGsPqzsuc3FFueCZRsVSGupBJ35GCt0LbX0uDuiLmbU6fJmLfcg31LhgA3HrXHeVJSDMkcYfj8pzEKC5xHVY25IMC9qmvTrzI9R9C7zJ/JkEYj480FIoxxQNhSgiZ2F+I38P9deNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9ZoDp/k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708344429; x=1739880429;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=KnF0phDN3/5uXsJqv2PiwDoKfpY1Mw293W4t6oICmxQ=;
  b=j9ZoDp/kWHoBYVYCTGfylRVO9HgZm/Ydt48makHwOk2NwvMTlqL2IfEZ
   hwQZ4ENN9shOa4Qam6agFCMhnNgCTptVJAq0KG7cCkb1PL5/i3AAvhYHv
   iHt4aw4/R8Sy16v7/WGIHK7vAG2sEokaJQiL1tCwRW++ZTvd9nxxcDEsI
   IwN7eM3flacSbzsnBiJQo1TQ1GO9jw8ATbnKDJeOSbFU3LOKBSt2wOpOh
   tD4pq7vKddfELekYPTxI3MIUeHBt1L4QWPgDVMjAYNORf0B+fAfZ45Nxi
   eTKTLFhENAUEldYbiLcHovinGazeRMNU32vfMQBXWcDuEWde3mYsBtBnK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13128023"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13128023"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4474137"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:07:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: corentin.chary@gmail.com, luke@ljones.dev, Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219115919.16526-1-W_Armin@gmx.de>
References: <20240219115919.16526-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2 0/5] platform/x86: wmi: Fixes for event data
 handling
Message-Id: <170834441476.4050.13616916099862661423.b4-ty@linux.intel.com>
Date: Mon, 19 Feb 2024 14:06:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Mon, 19 Feb 2024 12:59:14 +0100, Armin Wolf wrote:

> This patch series contains fixes for the handling of WMI event data
> when receiving WMI events.
> 
> The first patch aims to prevent WMI event drivers depending on WMI
> event data support from binding to a WMI device which does not
> support the retrieval of additional WMI event data.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/5] platform/x86: wmi: Prevent incompatible event driver from probing
      commit: b448bcb4cf02b27946f9bd6c4ded17e2209bf271
[2/5] platform/x86: wmi: Check if event data is not NULL
      commit: b5003c979eb4128c7ca81ed144491e85232979b6
[3/5] platform/x86: wmi: Always evaluate _WED when receiving an event
      commit: 2b30ea09e77d701f0b0b02243bdcf8aa408e4214
[4/5] platform/x86: wmi: Update documentation regarding _WED
      commit: c865db581c295085fbfc1b6802f87c38ad92e4ca
[5/5] Revert "platform/x86: asus-wmi: Support WMI event queue"
      commit: b27bb403e136b12cafeff4467d495bbc8c9b7441

--
 i.


