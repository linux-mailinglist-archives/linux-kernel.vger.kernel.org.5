Return-Path: <linux-kernel+bounces-90626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49A87026D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00445B236D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7053D564;
	Mon,  4 Mar 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVaMEgSa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13663C6A3;
	Mon,  4 Mar 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558213; cv=none; b=bJ5+rDdmrQAiAfVPC/hubvbzEE0JUgpYUP2K7dAqV3MNPSBAvkRfDKqJv11xVUbv1UdQ9QGmLR4/bNHzb4BBS1RQBEwo71x23WKtUJSKxAIGWOFJDna6vBMMRW11jB+VRsj3MpjNQfVtJ0AV3Y73+dN1XFwYUf1M1Q9yfzsKtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558213; c=relaxed/simple;
	bh=HFP5ZkdyG98y4hXFBgqadIXBVsKMkC4DBS2Q6pbdmho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TNsQf74FtcRxr6xFAvI75mHNXq+Dujcl6VpAfUIpZYi533WgVPZPU6qeUT1mrnXnGlz/qj0UjGuc6r/RhcyitGEEqX23cYFiCfFEo91Foc7yuCjD3xuq6HulCk9t4MgoFWxMAIvKPJPiPS6aIQ46rGf45yC7GqSBR7vq75oo2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVaMEgSa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558211; x=1741094211;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=HFP5ZkdyG98y4hXFBgqadIXBVsKMkC4DBS2Q6pbdmho=;
  b=nVaMEgSaFHtQIO9ImHJPRsuNDPHGScTamuYlnqnUipQMYJ5AYTzUMn9V
   AyWP5hNw1XXrEnmopD9csUjHFKbHV8pjqvDsBlJN+mVqgjoGjcrvTcpaX
   qXf7+K9Njw+bjloXsqU74AwTgI6bMkegPYTZHNtk2KdHsqzP6aREnhb8t
   3/DFfeA0Mcj6uBSi12OoYTm4X27AmUBEDywxLCqtfMxuWo1ouj0bDpylr
   sebU8nlyH7uLYIyo9YQS3wxUuY0/+O46PN0hMp1oNh74S4zibTTUcjpMO
   RizRtMA3dA0+bZ2AejMMU7iWTS5DiUb2RWbaftF1UNIJdhOxS8fMaU9Ue
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4625103"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4625103"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8905038"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:16:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Lee, Chun-Yi" <jlee@suse.com>, Hans de Goede <hdegoede@redhat.com>, 
 SungHwan Jung <onenowy@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240220055231.6451-1-onenowy@gmail.com>
References: <20240220055231.6451-1-onenowy@gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: Add support for Acer PH16-71
Message-Id: <170955820277.5357.13472512914572802380.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:16:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 20 Feb 2024 14:52:31 +0900, SungHwan Jung wrote:

> Add Acer Predator PH16-71 to Acer_quirks with predator_v4
> to support mode button and fan speed sensor.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: acer-wmi: Add support for Acer PH16-71
      commit: 21f168a1c5e19dc1af511fc5031678a9c0f823ee

--
 i.


