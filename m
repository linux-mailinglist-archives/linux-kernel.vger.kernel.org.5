Return-Path: <linux-kernel+bounces-151936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620028AB605
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FA21F21B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0D764F;
	Fri, 19 Apr 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJr8GvuA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D11170D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558803; cv=none; b=f0TKJ0y3AvFbsS2W/r8pT9B82Ey9i10L7Npo6dMrD5+2qQhXYPnbd4VpKtmXL0gP9nK1bCLJ6Uakw32DRW35YRc8dV1K/C6Ln+zPlddObbVbODeMJA54BpO3UxLrQFa430tzP1Hb1BEJVd0kvlXs+qFgIRNPoaFihxX7+QOeGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558803; c=relaxed/simple;
	bh=+7yAnQjLOwY8eotLH3n+GRmYa/kTB7nFodBZZ3/Ch0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8bTtxU6Quob4U6jeGyBqX39jKV0h6rTzNm0sbdEZhCWOAYWGTcdEmbV7Bo4z+4JLCJ7VM9OrYFmjfQb88nyAX/GUKvOtk2o2kgzYpbNgdw8wSB5WPC4wKuHaJ8iK10dQ71OC6fFcqjV+TXc3TT4r9M64R+cNDApIAu85Xe70uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJr8GvuA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713558801; x=1745094801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+7yAnQjLOwY8eotLH3n+GRmYa/kTB7nFodBZZ3/Ch0k=;
  b=SJr8GvuAUm7pgXNkQSX9ZEqgSQ6IpgkzNLoxeIsx3VLbhCwKR0Rc3c+8
   cYS9FlM66n90+k5LcIJdnh7XMxy+8QWFrbe8wjlGRz0RXayj2tpTbgIBN
   zc4tOLuXcOsd6qOOWpXfzlGBrejUEp7ALranSiX142M+cavJsMyy6kLxM
   bup+54kviQPXD8ySyBhklX/ZwGrakbKavP5sfDrGO9sj3UvFCuwemSdKM
   FeVuSE/qZRWkPtM9526l8/cKUZlEPzrIkpP27pyBvz2vQyd+2LA5bSmgQ
   1uRf1yiJc9OZtTMBoVfenZnzAJtj1klXV4BjZpZBOv6+EhL9w9Wm60z+o
   g==;
X-CSE-ConnectionGUID: 31Y0WEgfT3eI18lGn5S6Gg==
X-CSE-MsgGUID: 2PrTJCCwTLaRpm5dtrVG5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26694651"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26694651"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:33:21 -0700
X-CSE-ConnectionGUID: JDSwDXOsQ7W00BXO1srI2A==
X-CSE-MsgGUID: C87isBRxRteH+yj/0ZGzHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23462599"
Received: from mmihaitx-mobl.ger.corp.intel.com (HELO [10.125.66.30]) ([10.125.66.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 13:33:20 -0700
Message-ID: <b6ae9f58-c883-4d82-aeff-7f85337d9ef7@linux.intel.com>
Date: Fri, 19 Apr 2024 13:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker feature
 is present
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dan.j.williams@intel.com,
 bernie.keany@intel.com, charishma1.gairuboyina@intel.com,
 chang.seok.bae@intel.com, Josh Poimboeuf <jpoimboe@kernel.org>,
 antonio.gomez.iglesias@linux.intel.com
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
 <24713e0d-779f-4084-ba5c-7375d4b05955@linux.intel.com>
 <20240419201918.czmg6rq3whovhafw@desk>
Content-Language: en-US
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
In-Reply-To: <20240419201918.czmg6rq3whovhafw@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 13:19, Pawan Gupta wrote:
> ... mcu_ctrl is read here, it will overwrite any previous value.Ah, yep. Bummer.

